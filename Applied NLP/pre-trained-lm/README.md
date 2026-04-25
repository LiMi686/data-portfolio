# Objectives

The learning objectives of this assignment are to:

1. combine and pre-process two input texts for a text maching problem
2. combine and pre-process a context with several possible answers for a multiple choice problem
3. fine-tune pre-trained language models for both tasks

Graduate students will also acquire skills to implement an end-to-end solution based on pre-trained models for a sequence-to-sequence problem.

# Setup your environment and prepare data

First, carefully follow the *General Instructions for Programming Assignments*.

To install the libraries required for this assignment run:

    pip install -r requirements.txt

Clone the MeasEval repository:

    git clone https://github.com/wangcunxiang/SemEval2020-Task4-Commonsense-Validation-and-Explanation.git SemEval2020-Task4-Data

# Grading

This repository includes a set of tests for the exercises in `pretrainedlmA.ipynb` and `pretrainedlmB.ipynb` that all students must complete. They can be run with:

    pytest test.py

The grading distribution for this assignment is listed below:
- test_load_model_a = 10%
- test_preprocess_data_a = 10%
- test_create_training_arguments_a = 10%
- test_create_trainer_a = 10%
- test_make_predictions_a = 10%
- test_load_model_b = 10%
- test_preprocess_data_b = 10%
- test_create_training_arguments_b = 10%
- test_create_trainer_b = 10%
- test_make_predictions_b = 10%

Graduate students must also complete the additional set of exercises in `pretrainedlmC.ipynb`. To run the tests for the graduate studen assignment, use the command:

    pytest test_grads.py

The grading distribution for this graduate student assignment is listed below:
- test_load_model_c = 16%
- test_load_data_c = 10%
- test_preprocess_data_c = 16%
- test_create_training_arguments_c = 16%
- test_create_trainer_c = 16%
- test_make_predictions_c = 16%
- test_evaluate_c = 10%
