import pytest
import pathlib
import platform
import pickle as pkl
import pandas as pd
from numpy.testing import assert_allclose
from spacy.lang.en import English
from pandas import DataFrame
from gensim.models import KeyedVectors
from dataclasses import dataclass

from nbimport import find_notebook, NotebookLoader


nb_path = find_notebook('textsimilarity')
loader = NotebookLoader(nb_path)
nb_module = loader.load_module('textsimilarity')

process_sentences = nb_module.process_sentences
load_model = nb_module.load_model
cosine_similarity = nb_module.cosine_similarity
scale_similarities = nb_module.scale_similarities
word_movers_similarity = nb_module.word_movers_similarity


@dataclass
class Shared:
    nlp: English
    data: DataFrame
    target_model: KeyedVectors
    target_sent1_processed: list
    target_sent2_processed: list
    target_cosine_prediction: list
    target_scaled_similarities: list
    target_wmd_prediction: list
   
@pytest.fixture(scope="session")
def shared():
    ext = ""
    if platform.system() == "Windows":
        temp = pathlib.PosixPath
        pathlib.PosixPath = pathlib.WindowsPath
        ext = "_win"
    with open(f"test_utils/nlp{ext}.pkl", "rb") as pklfile:
       nlp = pkl.load(pklfile)
    data = pd.read_csv("test_utils/test_data.csv")
    target_model = KeyedVectors.load("test_utils/__testing_word2vec-matrix-synopsis", mmap='r')
    with open(f"test_utils/sent_processed.pkl", "rb") as pklfile:
        target_sent1_processed = pkl.load(pklfile)
        target_sent2_processed = pkl.load(pklfile)
    with open(f"test_utils/cosine_prediction.pkl", "rb") as pklfile:
        target_cosine_prediction = pkl.load(pklfile)
    with open(f"test_utils/scaled_similarities.pkl", "rb") as pklfile:
        target_scaled_similarities = pkl.load(pklfile)
    with open(f"test_utils/wmd_prediction.pkl", "rb") as pklfile:
        target_wmd_prediction = pkl.load(pklfile)
    return Shared(nlp, data, target_model,
                  target_sent1_processed, target_sent2_processed,
                  target_cosine_prediction, target_scaled_similarities,
                  target_wmd_prediction)


def test_process_sentences(shared):
    test_sent1_processed = process_sentences(shared.data["sent1"].values, shared.nlp)
    assert test_sent1_processed == shared.target_sent1_processed
    
    
def test_load_model(shared):
    test_model = load_model("__testing_word2vec-matrix-synopsis").wv
    assert type(test_model) == type(shared.target_model)
    assert type(test_model.vectors.shape) == type(shared.target_model.vectors.shape)
    
    
def test_cosine_similarity(shared):
    test_cosine_prediction = cosine_similarity(shared.target_sent1_processed, shared.target_sent2_processed, shared.target_model)
    assert_allclose(test_cosine_prediction, shared.target_cosine_prediction)

    
def test_scale_similarities(shared):
    test_scaled_similarities = scale_similarities(shared.target_cosine_prediction)
    assert_allclose(test_scaled_similarities, shared.target_scaled_similarities)

    
def test_word_movers_similarity(shared):
    test_wmd_prediction = word_movers_similarity(shared.target_sent1_processed, shared.target_sent2_processed, shared.target_model)
    assert_allclose(test_wmd_prediction, shared.target_wmd_prediction)
