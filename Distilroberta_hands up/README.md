# Multi-Label Text Classification with DistilRoBERTa

This project implements a multi-label text classification pipeline using the DistilRoBERTa transformer model. It provides scripts for training and prediction on datasets in CSV format, leveraging the Hugging Face transformers and datasets libraries.

Tokenization & Encoding: distilroberta-base for sequence encoding.

Model: Pretrained DistilRoBERTa + custom classification (num_labels).

Fine-Tuning: Train end-to-end with Adam (lr=3e-5), binary cross-entropy loss, precision/recall/F1 metrics.

Checkpointing: Save the best model by validation F1.

## Result
0.85 accuracy on the test set, 0.85 accuracy on the new dataset, reflecting generalization capabilities


### Training
python nn.py train

### Prediction
python nn.py predict

