import pytest
import json
import pandas as pd
import pickle as pkl
import numpy as np
from pandas import DataFrame
from pandas.testing import assert_frame_equal
from tensorflow.keras.models import load_model, Sequential
from tensorflow.random import set_seed
from tensorflow.keras.utils import set_random_seed
from numpy.testing import assert_array_equal, assert_allclose
from dataclasses import dataclass

from nbimport import find_notebook, NotebookLoader


nb_path = find_notebook('relationextraction')
loader = NotebookLoader(nb_path)
nb_module = loader.load_module('relationextraction')

get_vocabulary = nb_module.get_vocabulary
integrate_sentences = nb_module.integrate_sentences
format_examples = nb_module.format_examples
create_model = nb_module.create_model
train_model = nb_module.train_model
make_predictions = nb_module.make_predictions

set_seed(42)
set_random_seed(42)


@dataclass
class Shared:
    data: DataFrame
    target_vocab: list
    target_word2idx: dict
    target_word2idx_incomplete: dict
    target_examples: DataFrame
    target_x: np.array
    target_y: np.array
    target_predictions: np.array
    target_model: Sequential
    target_model_trained: Sequential
    maxlen: int
    epochs: int
    batch_size: int
    embedding_dim: int
    filters: int
    kernel_size: int
    hidden_dim: int
    vocab_size: int


@pytest.fixture(scope="session")
def shared():
    data = pd.read_csv("test_utils/data_rels.tsv", sep="\t", encoding="utf8")
    with open("test_utils/vocab_rels.json", encoding="utf8") as jfile:
        target_vocab = json.load(jfile)
    with open("test_utils/word2idx_rels.json", encoding="utf8") as jfile:
        target_word2idx = json.load(jfile)
    with open("test_utils/word2idx_incomplete_rels.json", encoding="utf8") as jfile:
        target_word2idx_incomplete = json.load(jfile)
    with open("test_utils/label2idx.json", encoding="utf8") as jfile:
        target_label2idx = json.load(jfile)

    with open("test_utils/examples_rels.pkl", "rb") as pklfile:
        target_examples = pkl.load(pklfile)
        
    with open("test_utils/x_rels.pkl", "rb") as pklfile:
        target_x = pkl.load(pklfile)
    with open("test_utils/y_rels.pkl", "rb") as pklfile:
        target_y = pkl.load(pklfile)
    with open("test_utils/predictions_rels.pkl", "rb") as pklfile:
        target_predictions = pkl.load(pklfile)

    target_model = load_model("test_utils/model_rels.keras")
    target_model_trained = load_model("test_utils/model_trained_rels.keras")

    maxlen = 130
    epochs = 10
    batch_size = 64
    embedding_dim = 300
    filters = 100
    kernel_size = 5
    hidden_dim = 10
    
    vocab_size = len(target_vocab)
    
    return Shared(data,
                  target_vocab, target_word2idx, target_word2idx_incomplete,
                  target_examples, target_x, target_y, target_predictions,
                  target_model, target_model_trained,
                  maxlen, epochs, batch_size, embedding_dim,
                  filters, kernel_size, hidden_dim, vocab_size)


def input_shape_to_list(layer_config):
    if type(layer_config) is dict and 'build_config' in layer_config:
        if type(layer_config['build_config']['input_shape']) is tuple:
            layer_config['build_config']['input_shape'] = list(layer_config['build_config']['input_shape'])
    return layer_config


def assert_equal_layers(layer_1, layer_2):
    assert layer_1['class_name'] == layer_2['class_name']
    assert set(layer_1['config']) == set(layer_2['config'])
    for config in layer_2['config']:
        if config == "name":
            continue
        elif config in ["layer", "backward_layer"]:
            assert config in layer_1['config']
            layer_1_layer = layer_1['config'][config]
            layer_2_layer = layer_2['config'][config]
            assert_equal_layers(layer_1_layer, layer_2_layer)
        elif config == "embeddings_initializer":
            assert "embeddings_initializer" in layer_1['config']
            assert layer_1['config']["embeddings_initializer"]["class_name"] == layer_2['config'][config]["class_name"]
        else:
            layer_1_config = layer_1['config'].get(config, None)
            layer_1_config = input_shape_to_list(layer_1_config)
            layer_2_config = layer_2['config'][config]
            layer_2_config = input_shape_to_list(layer_2_config)
            assert layer_1_config == layer_2_config

    
def assert_equal_models(model_1, model_2):
    assert type(model_1) == type(model_2)
    assert model_1.get_compile_config() == model_2.get_compile_config()
    for layer_1, layer_2 in zip(model_1.get_config()['layers'], model_2.get_config()['layers']):
        assert_equal_layers(layer_1, layer_2)


def test_get_vocabulary_rels(shared):
    test_vocab, test_word2idx = get_vocabulary(shared.data)
    assert test_vocab[:2] == shared.target_vocab[:2]
    assert set(test_vocab) == set(shared.target_vocab)
    target_word2idx = {(v, i) for i, v in enumerate(test_vocab)}
    assert test_word2idx.items() == target_word2idx


def test_integrate_sentences_rels(shared):
    test_examples = integrate_sentences(shared.data)
    assert_frame_equal(test_examples.reset_index(drop=True), shared.target_examples.reset_index(drop=True))
    
def test_format_examples_rels(shared):
    test_x, test_y = format_examples(shared.target_examples, shared.target_word2idx_incomplete, shared.maxlen)
    assert_array_equal(test_x, shared.target_x)
    assert_array_equal(test_y, shared.target_y)

   
def test_create_model_rels(shared):
    test_model = create_model(shared.vocab_size, shared.maxlen, shared.embedding_dim,
                              shared.filters, shared.kernel_size, shared.hidden_dim)
    assert_equal_models(test_model, shared.target_model)


def test_train_model_rels(shared):
    test_model_trained = load_model("test_utils/model_rels.keras")
    train_model(test_model_trained, shared.target_x, shared.target_y,
                shared.target_x, shared.target_y,
                shared.batch_size, shared.epochs)
    print(test_model_trained.weights[-1].numpy(), shared.target_model_trained.weights[-1].numpy())
    assert_allclose(test_model_trained.weights[-1].numpy(), shared.target_model_trained.weights[-1].numpy(), rtol=1e-4)
   

def test_make_predictions_rels(shared):
    test_predictions = make_predictions(shared.target_model_trained, shared.target_x, shared.batch_size)
    assert_array_equal(test_predictions, shared.target_predictions)
   
