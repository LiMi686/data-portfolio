
## 1. Project Overview
- **Toy RNN**  
  A simple recurrent network that learns to output \(x_{t-3} - y_{t}\) for each time step \(t\) given input pairs \((x_{t}, y_{t})\).

- **MNIST CNN**  
  A convolutional network for classifying 28×28 grayscale images of handwritten digits (0–9).

- **YouTube Comment RNN**  
  A recurrent network that classifies YouTube comments as spam (1) or ham (0).

- **YouTube Comment CNN**  
  A one-dimensional convolutional network for the same spam/ham classification task.

## 2. Test Results
- **Toy RNN RMSE:** 1.3 (target < 2)  
- **MNIST CNN Accuracy:** 88.0%  
- **YouTube Comment RNN Accuracy:** 90.0%  
- **YouTube Comment CNN Accuracy:** 85.7%  

## 3. Dependencies
- Python 3.7+  
- TensorFlow / Keras  
- pytest  

Install with:
```bash
pip install tensorflow keras pytest