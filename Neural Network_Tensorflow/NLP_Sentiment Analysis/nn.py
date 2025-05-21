import argparse
import datasets 
import pandas
import transformers
import keras
from keras import callbacks, regularizers
import numpy

# use the tokenizer from DistilRoBERTa
tokenizer = transformers.AutoTokenizer.from_pretrained("distilroberta-base")


def tokenize(examples):
    """Converts the text of each example to "input_ids", a sequence of integers
    representing 1-hot vectors for each token in the text"""
    return tokenizer(examples["text"], truncation=True, max_length=64,
                     padding="max_length")


def to_bow(example):
    """Converts the sequence of 1-hot vectors into a single many-hot vector"""
    vector = numpy.zeros(shape=(tokenizer.vocab_size,))
    vector[example["input_ids"]] = 1
    return {"input_bow": vector}


def train(model_path="model.keras", train_path="train.csv", dev_path="dev.csv"):

    # load the CSVs into Huggingface datasets to allow use of the tokenizer
    hf_dataset = datasets.load_dataset("csv", data_files={
        "train": r"C:\Users\LIMI\Desktop\graduate-project-LiMi686\train.csv", 
        "validation": r"C:\Users\LIMI\Desktop\graduate-project-LiMi686\dev.csv"})

    # the labels are the names of all columns except the first
    labels = hf_dataset["train"].column_names[1:]

    def gather_labels(example):
        """Converts the label columns into a list of 0s and 1s"""
        # the float here is because F1Score requires floats
        return {"labels": [float(example[l]) for l in labels]}

    # convert text and labels to format expected by model
    hf_dataset = hf_dataset.map(gather_labels)
    hf_dataset = hf_dataset.map(tokenize, batched=True)
    hf_dataset = hf_dataset.map(to_bow)

    # convert Huggingface datasets to Tensorflow datasets
    train_dataset = hf_dataset["train"].to_tf_dataset(
        columns="input_bow",
        label_cols="labels",
        batch_size=16,
        shuffle=True)
    dev_dataset = hf_dataset["validation"].to_tf_dataset(
        columns="input_bow",
        label_cols="labels",
        batch_size=16)

####################################### MODEL #############################################
    # define a model with a single fully connected layer
    model = keras.Sequential([
        #1
        keras.layers.Dense(
            units=256,
            input_dim=tokenizer.vocab_size,
            kernel_regularizer=regularizers.l2(5e-4)),
            keras.layers.BatchNormalization(),
            keras.layers.Activation("relu"), 
        keras.layers.Dropout(0.5),

        #2
        keras.layers.Dense(
            units=128,
            kernel_regularizer=regularizers.l2(5e-5)),
            keras.layers.BatchNormalization(),
            keras.layers.Activation("relu"), 
        keras.layers.Dropout(0.5),

        #3 
        keras.layers.Dense(
            units=64,
            kernel_regularizer=regularizers.l2(0.00001)),
        keras.layers.BatchNormalization(),
        keras.layers.Activation("relu"),

        # output layer
        keras.layers.Dense(units=len(labels), activation="sigmoid")])  

################################ MODEL COMPILE ##########################################
    # specify compilation hyperparameters
    model.compile(
        optimizer=keras.optimizers.Adam(learning_rate=3e-4),
        loss=keras.losses.binary_crossentropy,
        metrics=["accuracy",
                keras.metrics.Precision(name="precision"),
                keras.metrics.Recall(name="recall"),
                keras.metrics.F1Score(average="micro", threshold=0.5)])
    
    # Callbacks: Save best + learning rate scheduling + early stops
    checkpoint_cb = keras.callbacks.ModelCheckpoint(
        filepath=model_path,
        monitor="val_f1_score",
        mode="max",
        save_best_only=True
    )

    reduce_lr_cb = keras.callbacks.ReduceLROnPlateau(
        monitor="val_f1_score",  
        mode="max",               
        factor=0.5,               
        patience=2,               
        min_lr=1e-6               
    )

    earlystop_cb = keras.callbacks.EarlyStopping(
        monitor="val_f1_score",     
        mode="max",                  
        patience=3,                 
        restore_best_weights=True    
    )

###################################M MODEL FIT ##########################################
    # fit the model to the training data, monitoring F1 on the dev data
    model.fit(
        train_dataset,
        epochs=15,
        validation_data=dev_dataset,
        callbacks=[checkpoint_cb, reduce_lr_cb, earlystop_cb])


################################## PREDICT ##########################################
def predict(model_path="model.keras", input_path="test-in.csv"):

    # load the saved model
    model = keras.models.load_model(model_path)

    # load the data for prediction
    # use Pandas here to make assigning labels easier later
    df = pandas.read_csv(input_path)

    # create input_dev features in the same way as in train()
    hf_dataset = datasets.Dataset.from_pandas(df)
    hf_dataset = hf_dataset.map(tokenize, batched=True)
    hf_dataset = hf_dataset.map(to_bow)
    tf_dataset = hf_dataset.to_tf_dataset(
        columns="input_bow",
        batch_size=16)

    # generate predictions from model
    predictions = numpy.where(model.predict(tf_dataset) > 0.5, 1, 0)

    # assign predictions to label columns in Pandas data frame
    df.iloc[:, 1:] = predictions

    # write the Pandas dataframe to a zipped CSV file
    df.to_csv("submission.zip", index=False, compression=dict(
        method='zip', archive_name=f'submission.csv'))
 
if __name__ == "__main__":
    # parse the command line arguments
    parser = argparse.ArgumentParser()
    parser.add_argument("command", choices={"train", "predict"})
    args = parser.parse_args()

    # call either train() or predict()
    globals()[args.command]()
