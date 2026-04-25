import pytest
import json
import torch
import numpy as np
import pandas as pd
import pickle as pkl
from accelerate import Accelerator
from datasets import Dataset, load_from_disk
from transformers import (RobertaPreTrainedModel, RobertaTokenizerFast,
                          Trainer, enable_full_determinism)
from transformers.training_args import TrainingArguments
from numpy.testing import assert_array_equal
from pandas.testing import assert_frame_equal
from dataclasses import dataclass

from nbimport import find_notebook, NotebookLoader


nb_path = find_notebook('pretrainedlmC')
loader = NotebookLoader(nb_path)
nb_module = loader.load_module('pretrainedlmC')

load_model = nb_module.load_model
load_data = nb_module.load_data
preprocess_data = nb_module.preprocess_data
create_training_arguments = nb_module.create_training_arguments
create_trainer = nb_module.create_trainer
make_predictions = nb_module.make_predictions
evaluate_prediction = nb_module.evaluate_prediction

enable_full_determinism(seed=42)


@dataclass
class Shared:
    model_name: str
    target_model: RobertaPreTrainedModel
    target_tokenizer: RobertaTokenizerFast
    target_train_data: pd.DataFrame
    target_train_dataset: Dataset
    target_test_data: pd.DataFrame
    target_test_dataset: Dataset
    target_test_data_with_predictions: pd.DataFrame
    target_trainer_args: TrainingArguments
    target_trainer: Trainer
    target_predictions: np.array
    target_bleu_score:dict
    target_rouge_score:dict
    

@pytest.fixture(scope="session")
def shared():
    model_name = "test_utils/tiny-random-bart/"
    target_model = torch.load("test_utils/taskC/tiny-random-bart-model.pt", weights_only=False)
    with open("test_utils/taskC/tiny-random-bart-tokenizer.pkl", "rb") as pkl_file:
        target_tokenizer = pkl.load(pkl_file)
    target_train_data = pd.read_csv("test_utils/taskC/train_data.csv")
    target_test_data = pd.read_csv("test_utils/taskC/test_data.csv")
    target_test_data_with_predictions = pd.read_csv("test_utils/taskC/test_data_with_predictions.csv", keep_default_na=False)
    target_train_dataset = load_from_disk("test_utils/taskC/train_dataset")
    target_test_dataset = load_from_disk("test_utils/taskC/test_dataset")
    with open("test_utils/taskC/trainer_args.pkl", "rb") as pkl_file:
        target_trainer_args = pkl.load(pkl_file)
    with open("test_utils/taskC/trainer.pkl", "rb") as pkl_file:
        target_trainer = pkl.load(pkl_file)
    with open("test_utils/taskC/predictions.pkl", "rb") as pkl_file:
        target_predictions = pkl.load(pkl_file)
    with open("test_utils/taskC/bleu_score.json") as jfile:
        target_bleu_score = json.load(jfile)
    with open("test_utils/taskC/rouge_score.json") as jfile:
        target_rouge_score = json.load(jfile)
        
    return Shared(model_name,
                  target_model, target_tokenizer,
                  target_train_data, target_train_dataset,
                  target_test_data, target_test_dataset,
                  target_test_data_with_predictions,
                  target_trainer_args, target_trainer,
                  target_predictions,
                  target_bleu_score, target_rouge_score)


def assert_equal_datasets(dataset_1, dataset_2, is_test=False):
    assert dataset_1['input_ids'] == dataset_2['input_ids']
    assert dataset_1['attention_mask'] == dataset_2['attention_mask']
    if is_test:
        assert 'labels' not in dataset_1
    else:
        assert dataset_1['labels'] == dataset_2['labels']


def assert_equal_data_collators(data_collator_1, data_collator_2):
    assert type(data_collator_1) == type(data_collator_2)
    assert type(data_collator_1.tokenizer) == type(data_collator_2.tokenizer)
    
    
def test_load_model_c(shared):
    test_model, test_tokenizer = load_model(shared.model_name)
    assert type(test_model) == type(shared.target_model)
    assert type(test_tokenizer) == type(shared.target_tokenizer)


def test_load_data_c(shared):
    data_csv = "test_utils/taskC/data_all.csv"
    answers_csv = "test_utils/taskC/answers_all.csv"
    test_train_data = load_data(data_csv, answers_csv)
    test_test_data = load_data(data_csv, answers_csv, True)    
    assert_frame_equal(test_train_data.sort_values(by=["id", "reason"]).reset_index(drop=True),
                       shared.target_train_data.sort_values(by=["id", "reason"]).reset_index(drop=True))
    assert_frame_equal(test_test_data.sort_values(by=["id"]).reset_index(drop=True),
                       shared.target_test_data.sort_values(by=["id"]).reset_index(drop=True))
    
    
def test_preprocess_data_c(shared):
    test_train_dataset = Dataset.from_pandas(shared.target_train_data)
    test_train_dataset = test_train_dataset.map(lambda x: preprocess_data(x, shared.target_tokenizer, 30), batched=True)
    test_test_dataset = Dataset.from_pandas(shared.target_test_data)
    test_test_dataset = test_test_dataset.map(lambda x: preprocess_data(x, shared.target_tokenizer, 30, True), batched=True)
    assert_equal_datasets(test_train_dataset, shared.target_train_dataset)
    assert_equal_datasets(test_test_dataset, shared.target_test_dataset, True)


def test_create_training_arguments_c(shared):
    test_trainer_args = create_training_arguments(5, 5, 1e-2, "test_utils/taskC/model/")
    test_trainer_args.logging_dir = ""
    test_trainer_args.logging_strategy = "no"
    assert test_trainer_args == shared.target_trainer_args

    
def test_create_trainer_c(shared):
    test_trainer = create_trainer(shared.target_model, shared.target_trainer_args,
                                  shared.target_train_dataset.select(range(150)),
                                  shared.target_train_dataset.select(range(150, len(shared.target_train_dataset))),
                                  shared.target_tokenizer)
    test_trainer.args.logging_dir = ""
    test_trainer.args.logging_strategy = "no"
    assert type(test_trainer.model) == type(shared.target_trainer.model)
    assert test_trainer.args == shared.target_trainer.args
    assert_equal_datasets(test_trainer.train_dataset, shared.target_trainer.train_dataset)
    assert_equal_datasets(test_trainer.eval_dataset, shared.target_trainer.eval_dataset)
    assert_equal_data_collators(test_trainer.data_collator, shared.target_trainer.data_collator)

    
def test_make_predictions_c(shared):
    accelerator = Accelerator()
    test_predictions = make_predictions(shared.target_trainer,
                                        shared.target_test_dataset,
                                        shared.target_tokenizer)
    assert_array_equal(test_predictions, shared.target_predictions)


def test_evaluate_c(shared):
    test_bleu_score = evaluate_prediction(shared.target_test_data_with_predictions, "test_utils/bleu")
    assert test_bleu_score == shared.target_bleu_score
    test_rouge_score = evaluate_prediction(shared.target_test_data_with_predictions, "test_utils/rouge")
    assert test_rouge_score == shared.target_rouge_score
