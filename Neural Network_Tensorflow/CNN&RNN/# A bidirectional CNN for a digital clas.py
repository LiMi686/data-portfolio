# A bidirectional CNN for a digital classification problem
from typing import Tuple, List, Dict
import keras
def create_youtube_comment_rnn(vocabulary: List[str], n_outputs: int) \
        -> Tuple[keras.models.Model, Dict]:
    """
    This network will take as input a YouTube comment, and produce as output
    either 1, for spam, or 0, for ham (non-spam). The network will be trained
    and tested on data from:
    https://archive.ics.uci.edu/ml/datasets/YouTube+Spam+Collection
    """
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