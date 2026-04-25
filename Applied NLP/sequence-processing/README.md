# Objectives

The learning objectives of this assignment are to:

1. obtain the numeric representation of neural network input and output
2. create, train and run a recurrent neural network for sequence labeling
3. initialize an embedding layer with pre-trained word embeddings
4. create, train and run a convolutional neural network for relation extraction

# Setup your environment and prepare data

First, carefully follow the *General Instructions for Programming Assignments*.

To install the libraries required for this assignment run:

    pip install -r requirements.txt

Download and unzip GloVe embeddings:

    wget http://nlp.stanford.edu/data/glove.6B.zip
    unzip -d glove glove.6B.zip

# Grading

This repository includes a set of tests for the exercises in `sequencelabeling.ipynb` that all students must complete. They can be run with:

    pytest test.py

The grading distribution for this assignment is listed below:
- test_get_vocabulary = 16%
- test_format_examples = 16%
- test_create_model = 16%
- test_train_model = 16%
- test_make_predictions = 16%
- test_create_embedding_matrix = 10%
- test_create_model_with_embeddings = 10%

Graduate students must also complete the additional set of exercises in `relationextraction.ipynb`. To run the tests for the graduate studen assignment, use the command:

    pytest test_grads.py

The grading distribution for this graduate student assignment is listed below:
- test_get_vocabulary_rels = 15%
- test_integrate_sentences_rels = 20%
- test_format_examples_rels = 15%
- test_create_model_rels = 20%
- test_train_model_rels = 15%
- test_make_predictions_rels = 15%
