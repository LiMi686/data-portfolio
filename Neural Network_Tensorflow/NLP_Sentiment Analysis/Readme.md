# Multi-Label Sentiment Text Classification Project

## Bag-of-Words Neural Baseline

Tokenizer: distilroberta-base tokenizer for wordpiece tokenization

Features: Convert token lists into binary Bag-of-Words vectors

Here, I used a 3-layer fully connected neural network with a high-parameter setup:

    Dense(256) + BatchNormalization + ReLU + Dropout(0.5) + L2(1e-4)

    Dense(128) + BatchNormalization + ReLU + Dropout(0.5) + L2(1e-4)

    Dense(64)  + BatchNormalization + ReLU                + L2(1e-4)

    
### Result 
An accuracy of 0.82 was obtained on the test set, and the same was obtained on the new dataset that tested the model's generalization ability
