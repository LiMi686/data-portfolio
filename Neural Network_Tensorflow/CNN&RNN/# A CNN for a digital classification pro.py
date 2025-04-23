# A CNN for a digital classification problem
from typing import Tuple, List, Dict
import keras
def create_mnist_cnn(input_shape: tuple, n_outputs: int) \
        -> Tuple[keras.models.Model, Dict]:
    """
    The network will take as input a 28x28 grayscale image, and produce as
    output one of the digits 0 through 9. The network will be trained and tested
    on a fraction of the MNIST data: http://yann.lecun.com/exdb/mnist/
    """
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