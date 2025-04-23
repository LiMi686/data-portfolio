# A RNN for a toy problem
from typing import Tuple, List, Dict
import keras
def create_toy_rnn(input_shape: tuple, n_outputs: int) \
        -> Tuple[keras.models.Model, Dict]:
    """
    The network will take as input a sequence of number pairs, (x_{t}, y_{t}),
    where t is the time step. It will learn to produce x_{t-3} - y{t} as the
    output of time step t.
    """
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