import pytest
import torch
import numpy as np
import pandas as pd
import pickle as pkl
from accelerate import Accelerator
from datasets import Dataset, load_from_disk
from transformers import (RobertaForSequenceClassification, RobertaPreTrainedModel, RobertaTokenizerFast,
                          Trainer, enable_full_determinism)
from transformers.training_args import TrainingArguments
from numpy.testing import assert_array_equal
from dataclasses import dataclass

from nbimport import find_notebook, NotebookLoader


nb_path_a = find_notebook('pretrainedlmA')
loader_a = NotebookLoader(nb_path_a)
nb_module_a = loader_a.load_module('pretrainedlmA')

load_model_a = nb_module_a.load_model
load_data_a = nb_module_a.load_data
preprocess_data_a = nb_module_a.preprocess_data
create_training_arguments_a = nb_module_a.create_training_arguments
create_trainer_a = nb_module_a.create_trainer
make_predictions_a = nb_module_a.make_predictions
                           
nb_path_b = find_notebook('pretrainedlmB')
loader_b = NotebookLoader(nb_path_a)
nb_module_b = loader_a.load_module('pretrainedlmB')

load_model_b = nb_module_b.load_model
load_data_b = nb_module_b.load_data
preprocess_data_b = nb_module_b.preprocess_data
create_training_arguments_b = nb_module_b.create_training_arguments
create_trainer_b = nb_module_b.create_trainer
make_predictions_b = nb_module_b.make_predictions

enable_full_determinism(seed=42)


@dataclass
class Shared:
    model_name: str
    target_model: RobertaPreTrainedModel
    target_tokenizer: RobertaTokenizerFast
    target_data: pd.DataFrame
    target_dataset: Dataset
    target_trainer_args: TrainingArguments
    target_trainer: Trainer
    target_predictions: np.array
    

@pytest.fixture(scope="session")
def shared_a():
    model_name = "test_utils/tiny-random-roberta/"
    target_model = torch.load("test_utils/taskA/tiny-random-roberta-model.pt", weights_only=False)
    with open("test_utils/taskA/tiny-random-roberta-tokenizer.pkl", "rb") as pkl_file:
        target_tokenizer = pkl.load(pkl_file)
    target_data = pd.read_csv("test_utils/taskA/data.csv")
    target_dataset = load_from_disk("test_utils/taskA/dataset")
    with open("test_utils/taskA/trainer_args.pkl", "rb") as pkl_file:
        target_trainer_args = pkl.load(pkl_file)
    with open("test_utils/taskA/trainer.pkl", "rb") as pkl_file:
        target_trainer = pkl.load(pkl_file)
    with open("test_utils/taskA/predictions.pkl", "rb") as pkl_file:
        target_predictions = pkl.load(pkl_file)
        
    return Shared(model_name,
                  target_model, target_tokenizer,
                  target_data, target_dataset,
                  target_trainer_args, target_trainer,
                  target_predictions)


@pytest.fixture(scope="session")
def shared_b():
    model_name = "test_utils/tiny-random-roberta/"
    target_model = torch.load("test_utils/taskB/tiny-random-roberta-model.pt", weights_only=False)
    with open("test_utils/taskB/tiny-random-roberta-tokenizer.pkl", "rb") as pkl_file:
        target_tokenizer = pkl.load(pkl_file)
    target_data = pd.read_csv("test_utils/taskB/data.csv")
    target_dataset = load_from_disk("test_utils/taskB/dataset")
    with open("test_utils/taskB/trainer_args.pkl", "rb") as pkl_file:
        target_trainer_args = pkl.load(pkl_file)
    with open("test_utils/taskB/trainer.pkl", "rb") as pkl_file:
        target_trainer = pkl.load(pkl_file)
    with open("test_utils/taskB/predictions.pkl", "rb") as pkl_file:
        target_predictions = pkl.load(pkl_file)
        
    return Shared(model_name,
                  target_model, target_tokenizer,
                  target_data, target_dataset,
                  target_trainer_args, target_trainer,
                  target_predictions)


def assert_equal_datasets(dataset_1, dataset_2):
    assert dataset_1['input_ids'] == dataset_2['input_ids']
    assert dataset_1['attention_mask'] == dataset_2['attention_mask']
    assert dataset_1['label'] == dataset_2['label']


def assert_equal_data_collators(data_collator_1, data_collator_2):
    assert type(data_collator_1) == type(data_collator_2)
    assert type(data_collator_1.tokenizer) == type(data_collator_2.tokenizer)

#
# Task A tests
#

def test_load_model_a(shared_a):
    test_model, test_tokenizer = load_model_a(shared_a.model_name)
    assert type(test_model) == type(shared_a.target_model)
    assert type(test_tokenizer) == type(shared_a.target_tokenizer)
    
    
def test_preprocess_data_a(shared_a):
    test_dataset = Dataset.from_pandas(shared_a.target_data)
    test_dataset = test_dataset.map(lambda x: preprocess_data_a(x, shared_a.target_tokenizer, 60), batched=True)
    assert_equal_datasets(test_dataset, shared_a.target_dataset)


def test_create_training_arguments_a(shared_a):
    test_trainer_args = create_training_arguments_a(5, 5, 1e-2, "test_utils/taskA/model/")
    test_trainer_args.logging_dir = ""
    test_trainer_args.logging_strategy = "no"
    assert test_trainer_args == shared_a.target_trainer_args

    
def test_create_trainer_a(shared_a):
    test_trainer = create_trainer_a(shared_a.target_model, shared_a.target_trainer_args,
                                    shared_a.target_dataset.select(range(100)),
                                    shared_a.target_dataset.select(range(100, 150)))
    test_trainer.args.logging_dir = ""
    test_trainer.args.logging_strategy = "no"
    assert type(test_trainer.model) == type(shared_a.target_trainer.model)
    assert test_trainer.args == shared_a.target_trainer.args
    assert_equal_datasets(test_trainer.train_dataset, shared_a.target_trainer.train_dataset)
    assert_equal_datasets(test_trainer.eval_dataset, shared_a.target_trainer.eval_dataset)

    
def test_make_predictions_a(shared_a):
    accelerator = Accelerator()
    test_predictions = make_predictions_a(shared_a.target_trainer,
                                          shared_a.target_dataset.select(range(150, len(shared_a.target_dataset))))
    assert_array_equal(test_predictions, shared_a.target_predictions)

#
# Task B tests
#

def test_load_model_b(shared_b):
    test_model, test_tokenizer = load_model_b(shared_b.model_name)
    assert type(test_model) == type(shared_b.target_model)
    assert type(test_tokenizer) == type(shared_b.target_tokenizer)
    
    
def test_preprocess_data_b(shared_b):
    test_dataset = Dataset.from_pandas(shared_b.target_data)
    test_dataset = test_dataset.map(lambda x: preprocess_data_b(x, shared_b.target_tokenizer, 60), batched=True)
    assert_equal_datasets(test_dataset, shared_b.target_dataset)

    
def test_create_training_arguments_b(shared_b):
    test_trainer_args = create_training_arguments_b(5, 5, 1e-2, "test_utils/taskB/model/")
    test_trainer_args.logging_dir = ""
    test_trainer_args.logging_strategy = "no"
    assert test_trainer_args == shared_b.target_trainer_args

    
def test_create_trainer_b(shared_b):
    test_trainer = create_trainer_b(shared_b.target_model, shared_b.target_trainer_args,
                                    shared_b.target_dataset.select(range(100)),
                                    shared_b.target_dataset.select(range(100, 150)),
                                    shared_b.target_tokenizer)
    test_trainer.args.logging_dir = ""
    test_trainer.args.logging_strategy = "no"
    assert type(test_trainer.model) == type(shared_b.target_trainer.model)
    assert test_trainer.args == shared_b.target_trainer.args
    assert_equal_datasets(test_trainer.train_dataset, shared_b.target_trainer.train_dataset)
    assert_equal_datasets(test_trainer.eval_dataset, shared_b.target_trainer.eval_dataset)
    assert_equal_data_collators(test_trainer.data_collator, shared_b.target_trainer.data_collator)

    
def test_make_predictions_b(shared_b):
    accelerator = Accelerator()
    test_predictions = make_predictions_b(shared_b.target_trainer,
                                          shared_b.target_dataset.select(range(150, len(shared_b.target_dataset))))
    assert_array_equal(test_predictions, shared_b.target_predictions)
