# A CNN for dividing YouTube comment spam 
from typing import Tuple, List, Dict
import keras
def create_youtube_comment_cnn(vocabulary: List[str], n_outputs: int) \
        -> Tuple[keras.models.Model, Dict]:
    """
    This network will take as input a YouTube comment, and produce as output
    either 1, for spam, or 0, for ham (non-spam). The network will be trained
    and tested on data from:
    https://archive.ics.uci.edu/ml/datasets/YouTube+Spam+Collection
    """
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