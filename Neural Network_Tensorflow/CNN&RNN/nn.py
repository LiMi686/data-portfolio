"""
The main code for the recurrent and convolutional networks assignment.
See README.md for details.
"""
from typing import Tuple, List, Dict

import keras


def create_toy_rnn(input_shape: tuple, n_outputs: int) \
        -> Tuple[keras.models.Model, Dict]:
    """Creates a recurrent neural network for a toy problem.

    The network will take as input a sequence of number pairs, (x_{t}, y_{t}),
    where t is the time step. It must learn to produce x_{t-3} - y{t} as the
    output of time step t.

    This method does not call Model.fit, but the dictionary it returns alongside
    the model will be passed as extra arguments whenever Model.fit is called.
    This can be used to, for example, set the batch size or use early stopping.

    :param input_shape: The shape of the inputs to the model.
    :param n_outputs: The number of outputs from the model.
    :return: A tuple of (neural network, Model.fit keyword arguments)
    """
    #### YOUR CODE HERE ####
    # We are expected to let RMSE be less than 2,
    # so here, used two RNN layers because one layer is not enough.
    # with 128 and 64 units respectively, and a Dense layer for the output.
    # Firstly, use Sequential structure to build the neural network
    model = keras.Sequential([
    keras.layers.SimpleRNN(units=128, activation='tanh',
                           return_sequences=True,
                           input_shape=input_shape),
    keras.layers.SimpleRNN(units = 64, activation='tanh', return_sequences=True),
    keras.layers.Dense(n_outputs, activation='linear')])
    # Compile the model with optimizer and loss function
    model.compile(
        optimizer="adam",
        loss=keras.losses.MeanSquaredError())
    # Load the parameters into a dictionary
    fit_keywords_arguments = {
        "batch_size": 64,
        "epochs": 20,
        "callbacks": [
            keras.callbacks.EarlyStopping(monitor="loss", patience=10,
                                          restore_best_weights=True)]
        }
    return model, fit_keywords_arguments


def create_mnist_cnn(input_shape: tuple, n_outputs: int) \
        -> Tuple[keras.models.Model, Dict]:
    """Creates a convolutional neural network for digit classification.

    The network will take as input a 28x28 grayscale image, and produce as
    output one of the digits 0 through 9. The network will be trained and tested
    on a fraction of the MNIST data: http://yann.lecun.com/exdb/mnist/

    This method does not call Model.fit, but the dictionary it returns alongside
    the model will be passed as extra arguments whenever Model.fit is called.
    This can be used to, for example, set the batch size or use early stopping.

    :param input_shape: The shape of the inputs to the model.
    :param n_outputs: The number of outputs from the model.
    :return: A tuple of (neural network, Model.fit keyword arguments)
    """
    #### YOUR CODE HERE ####
    # CNN for image classification, Gonna use 2D
    model = keras.Sequential([
        keras.layers.Conv2D(32, kernel_size=(3, 3), activation='relu', input_shape=input_shape),
        keras.layers.MaxPooling2D(pool_size=(2, 2)),
        keras.layers.Conv2D(64, kernel_size=(3, 3), activation='relu'),
        keras.layers.MaxPooling2D(pool_size=(2, 2)),
        keras.layers.Flatten(),
        keras.layers.Dense(128, activation='relu'),
        keras.layers.Dense(n_outputs, activation='softmax')  # classification problem
    ])

    # Sequential.compile()
    model.compile( optimizer='adam', loss='categorical_crossentropy') # multiclass classification

    # fit keywords arguments
    fit_keywords_arguments = {
        'batch_size': 32,
        'epochs': 20,
        'callbacks': [
            keras.callbacks.EarlyStopping(monitor='val_loss', patience=3,
                                          restore_best_weights=True)]
    }

    return model, fit_keywords_arguments

def create_youtube_comment_rnn(vocabulary: List[str], n_outputs: int) \
        -> Tuple[keras.models.Model, Dict]:
    """Creates a recurrent neural network for spam classification.

    This network will take as input a YouTube comment, and produce as output
    either 1, for spam, or 0, for ham (non-spam). The network will be trained
    and tested on data from:
    https://archive.ics.uci.edu/ml/datasets/YouTube+Spam+Collection

    Each comment is represented as a series of tokens, with each token
    represented by a number, which is its index in the vocabulary. Note that
    comments may be of variable length, so in the input matrix, comments with
    fewer tokens than the matrix width will be right-padded with zeros.

    This method does not call Model.fit, but the dictionary it returns alongside
    the model will be passed as extra arguments whenever Model.fit is called.
    This can be used to, for example, set the batch size or use early stopping.

    :param vocabulary: The vocabulary defining token indexes.
    :param n_outputs: The number of outputs from the model.
    :return: A tuple of (neural network, Model.fit keyword arguments)
    """
    #### YOUR CODE HERE ####
    # Classfication problem for natural language, we can use bidrectional LSTM
    vocab_size = len(vocabulary) + 1  # Leave an index for the padding token

    # Use embedding layer, it will convert the token indexes to dense vectors.
    model = keras.Sequential([
        keras.layers.Embedding(vocab_size, 128, mask_zero=True),
        keras.layers.Bidirectional(keras.layers.LSTM(units=32, dropout=0.2)),
        keras.layers.Dense(n_outputs, activation='sigmoid')
    ])

    model.compile(optimizer='adam', loss='binary_crossentropy') # Since 0,1 classification

    fit_keywords_arguments = {
        "batch_size": 32,
        "epochs": 20,
        "callbacks": [
            keras.callbacks.EarlyStopping(monitor="val_loss",
                                          patience=3,
                                          restore_best_weights=True)]
    }

    return model, fit_keywords_arguments

def create_youtube_comment_cnn(vocabulary: List[str], n_outputs: int) \
        -> Tuple[keras.models.Model, Dict]:
    """Creates a convolutional neural network for spam classification.

    This network will take as input a YouTube comment, and produce as output
    either 1, for spam, or 0, for ham (non-spam). The network will be trained
    and tested on data from:
    https://archive.ics.uci.edu/ml/datasets/YouTube+Spam+Collection

    Each comment is represented as a series of tokens, with each token
    represented by a number, which is its index in the vocabulary. Note that
    comments may be of variable length, so in the input matrix, comments with
    fewer tokens than the matrix width will be right-padded with zeros.

    This method does not call Model.fit, but the dictionary it returns alongside
    the model will be passed as extra arguments whenever Model.fit is called.
    This can be used to, for example, set the batch size or use early stopping.

    :param vocabulary: The vocabulary defining token indexes.
    :param n_outputs: The number of outputs from the model.
    :return: A tuple of (neural network, Model.fit keyword arguments)
    """
    #### YOUR CODE HERE ####
    # CNN for words classification, 1D is good for this.
    vocab_size = len(vocabulary) + 1
    model = keras.Sequential([
        keras.layers.Embedding(vocab_size, 64, mask_zero=True),
        keras.layers.Conv1D(filters=64, kernel_size=5, activation='relu'),
        keras.layers.GlobalMaxPooling1D(),
        keras.layers.Dense(32, activation='relu'),
        keras.layers.Dense(n_outputs, activation='sigmoid')
    ])

    model.compile(optimizer='adam', loss='binary_crossentropy') # same as previous one

    fit_keywords_arguments = {
        "batch_size": 32,
        "epochs": 20,
        "callbacks": [
            keras.callbacks.EarlyStopping(monitor="val_loss", patience=3,
                                          restore_best_weights=True)]
    }

    return model, fit_keywords_arguments
