# Neural Network Architecture Comparison Project

## Project Overview
This project aims to develop and compare multiple neural network architectures, including deep vs. wide networks, ReLU vs. tanh activation functions, dropout vs. non-dropout networks, and early stopping vs. non-early stopping strategies. Experiments are conducted on multiple datasets (such as **Adult**, **UCI HAR**, and **del.icio.us**) to explore how different architectures and training strategies impact model performance.

### Deep vs. Wide Networks
- **Design Approach**  
  - **Deep Network**: Utilizes multiple hidden layers to capture complex nonlinear relationships.  
  - **Wide Network**: Employs a single hidden layer, with its number of hidden units calculated to approximately match the deep network's parameter count, allowing for a fair comparison.
- **Parameter Matching**  
  - Both networks are designed to have a similar capacity by carefully matching parameter counts, ensuring that differences in performance are primarily due to depth rather than size.

### Activation Function Comparison
- Built two separate models: one using **ReLU** activation and the other using **tanh**.
- Compares how different activation functions affect convergence and final performance.

### Dropout Strategy
- Demonstrates the effect of including versus omitting dropout layers on model generalization.
- Dropout significantly reduces overfitting in certain scenarios, improving accuracy and robustness.

### Early Stopping Strategy
- Uses **Early Stopping** to monitor validation loss and halt training when improvements stagnate.
- Compares models trained with and without early stopping, illustrating its impact on model stability and generalization.


## Experimental Results

### Auto MPG Dataset (Regression Task)
- **Baseline**: RMSE = 8.2  
- **Deep Network**: RMSE = 4.6  
- **Wide Network**: RMSE = 4.0  
> **Observation**: A significant reduction in RMSE indicates both deep and wide networks substantially improve fuel efficiency predictions.

### del.icio.us Dataset (Multi-label Classification)
- **Baseline Accuracy**: 65.0%  
- **ReLU Model Accuracy**: 68.5%  
- **tanh Model Accuracy**: 68.3%  
> **Observation**: Although the improvement is a few percentage points, such gains can be critical in multi-label classification.

### UCI-HAR Dataset (Multi-class Classification)
- **Baseline Accuracy**: 18.2%  
- **Dropout Model Accuracy**: 80.9%  
- **Non-Dropout Model Accuracy**: 79.8%  
> **Observation**: Introducing dropout dramatically boosts accuracy, demonstrating its effectiveness in reducing overfitting.

### Census Income Dataset (Binary Classification)
- **Baseline Accuracy**: 75.4%  
- **Early Stopping Model Accuracy**: 77.5%  
- **Non-Early Stopping Model Accuracy**: 77.8%  
> **Observation**: Even small improvements in binary classification accuracy (a few percentage points) can result in more robust and reliable predictions.

---






