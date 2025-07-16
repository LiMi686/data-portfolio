import tensorflow as tf
from transformers.modeling_tf_utils import TFPreTrainedModel
TFPreTrainedModel.compile = tf.keras.Model.compile
from tensorflow.keras.callbacks import EarlyStopping, ModelCheckpoint
import argparse
import datasets
import pandas as pd
import transformers
import numpy as np

from transformers import (
    AutoTokenizer,
    TFAutoModelForSequenceClassification,
    DataCollatorWithPadding,
)

class F1Metric(tf.keras.metrics.Metric):
    def __init__(self, name="f1_score", threshold=0.5, **kwargs):
        super().__init__(name=name, **kwargs)
        self.threshold = threshold
        self.tp = self.add_weight(name = "tp", shape=(), initializer="zeros")
        self.fp = self.add_weight(name = "fp", shape=(), initializer="zeros")
        self.fn = self.add_weight(name = "fn", shape=(), initializer="zeros")

    def update_state(self, y_true, y_pred, sample_weight=None):
        y_pred = tf.cast(tf.sigmoid(y_pred) > self.threshold, tf.float32)
        y_true = tf.cast(y_true, tf.float32)
        self.tp.assign_add(tf.reduce_sum(y_pred * y_true))
        self.fp.assign_add(tf.reduce_sum(y_pred * (1 - y_true)))
        self.fn.assign_add(tf.reduce_sum((1 - y_pred) * y_true))

    def result(self):
        precision = self.tp / (self.tp + self.fp + tf.keras.backend.epsilon())
        recall    = self.tp / (self.tp + self.fn + tf.keras.backend.epsilon())
        return 2 * (precision * recall) / (precision + recall + tf.keras.backend.epsilon())

    def reset_state(self):
        for v in self.variables:
            v.assign(0)


# 1. use the tokenizer from DistilRoBERTa
tokenizer = AutoTokenizer.from_pretrained("distilroberta-base")

def tokenize(examples): 
    # truncation（截断，如果有超出部分） + padding（填充）到同一长度
    return tokenizer(examples["text"], truncation= True, max_length = 128) 

def train(model_path = "model_tf", 
          train_path = "/Users/liml/Desktop/Transformer_demo/train-dev/train.csv", 
          dev_path = "/Users/liml/Desktop/Transformer_demo/train-dev/dev.csv"):
    # 2. upload the csv
    hf = datasets.load_dataset("csv", data_files = {"train": train_path, 
                                                    "validation": dev_path})
    # 标签列
    labels = hf["train"].column_names[1:]

    # 把多列label合成(一个list
    def gather_labels(batch):
        n = len(batch[labels[0]])
        batch["labels"] = [
            [float(batch[l][i]) for l in labels]
            for i in range(n)
        ]
        return batch
    hf = hf.map(
        gather_labels,
        batched=True,
        batch_size=256,
    )


    # 分词
    hf = hf.map(
        tokenize,
        batched=True,
    )

    # 3. DataCollator自动pad， 返回tf张量
    data_collator = DataCollatorWithPadding(tokenizer, return_tensors="tf")

    # 4.再生成tf.data.Dataset
    train_ds = hf["train"].to_tf_dataset(
        columns=["input_ids","attention_mask"],
        label_cols=["labels"],
        shuffle=True,
        batch_size=32,
        collate_fn=data_collator,
    )
    val_ds = hf["validation"].to_tf_dataset(
        columns=["input_ids", "attention_mask"],
        label_cols=["labels"],
        shuffle=False,
        batch_size=32,
        collate_fn=data_collator,
    )

    # 5. 加载预训练Transformer 并指定多标签分类
    model = TFAutoModelForSequenceClassification.from_pretrained(
        "distilroberta-base",
        num_labels=len(labels),
        problem_type="multi_label_classification"
    )

    # 6. 编译
    model.compile(
        optimizer=tf.keras.optimizers.Adam(learning_rate = 3e-5), 
        loss = tf.keras.losses.BinaryCrossentropy(from_logits=True),
        metrics=[tf.keras.metrics.Precision(name="precision"), 
                 tf.keras.metrics.Recall(name="recall"),
                 F1Metric(name="f1_score", threshold=0.5)
            ]
    )

    # 7. 训练，同时保存效果最好的checkpoint
    model.fit(
        train_ds,
        validation_data=val_ds,
        epochs = 3,
        verbose=1, 
        callbacks=[
            tf.keras.callbacks.ModelCheckpoint(
                filepath=model_path,
                save_weights_only=False,
                monitor="val_f1_score",
                mode="max",
                save_best_only=True,
            )
        ]
    )

def predict(model_path="model_tf", input_path="train.csv"):
        # 1. 载入模型
    model = TFAutoModelForSequenceClassification.from_pretrained(model_path)
        # 2. 读入数据
    df = pd.read_csv(input_path)
    hf = datasets.Dataset.from_pandas(df)
        # 3. 分词
    hf = hf.map(tokenize, batched=True)
    data_collator = DataCollatorWithPadding(tokenizer, return_tensors="tf")
    tfds = hf.to_tf_dataset(
        columns=["input_ids", "attention_mask"],
        shuffle=False,
        batch_size = 16,
        collate_fn = data_collator
    )
        # 4. 预测（返回logits）
    logits = model.predict(tfds).logits
    probs = tf.sigmoid(logits).numpy()
    preds = (probs > 0.5).astype(int)

        # 5. 写回DataFrame
    df.iloc[:, 1:] = preds
    df.to_csv("submission.zip", index=False,
            compression=dict(method="zip", archive_name="submission.csv"))

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("command", choices=["train", "predict"])
    args = parser.parse_args()
    globals()[args.command]()
    