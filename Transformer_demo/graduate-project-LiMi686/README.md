[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/4qYqiPqz)
# Objectives

The learning objectives of this assignment are to:
1. build a neural network for a text sentiment classification task 
2. practice tuning model hyper-parameters

# Read about the CodaBench Competition

You will be participating in a class-wide competition.
The competition website is:

```https://www.codabench.org/competitions/6936/?secret_key=25750dff-a857-4909-92ef-2f249095f514```

You should visit that site and read all the details of the competition, which
include the task definition, how your model will be evaluated, the format of
submissions to the competition, etc.

# Create a CodaBench account

You must create a CodaBench account and join the competition:
1. Visit the competition website: [https://www.codabench.org](https://www.codabench.org)

2. In the upper right corner of the page, you should see a "Sign Up" button.
Click that and go through the process to create an account.
**Please use your @arizona.edu account when signing up.**
Your username will be displayed publicly on a leaderboard showing everyone's
scores.
**If you wish to remain anonymous, please select a username that does not reveal
your identity.**
Your instructor will still be able to match your score with your name via your
email address, but your email address will not be visible to other students. 

3. Return to the competition website and click the "My Submissions" tab, accept
the terms and conditions of the competition, and register for the task.

4. Wait for your instructor to manually approve your request.
This may take a few days.

5. You should then be able to return to the "My Submissions" tab and see a
"Submission upload" form.
That means you are fully registered for the task.

# Clone the repository

The GitHub Classroom link for creating your project repository will be 
provided in a course announcement (and on D2L).
Once you have created your repository using the provided GitHub Classroom 
link, clone the repository to your local machine:
```
git clone https://github.com/ml4ai-2025-spring-nn/graduate-project-<your-username>.git
```
You are now ready to begin working on the assignment.

# Download the data

Go to the "Get Started" tab on the CodaBench site, and click on the "Files"
sub-tab.
You should see a button to download the training and validation (info-557-2025spr-PUBLIC-train_dev ; 
referred to below as just 'dev') data for the task.
Download and unzip that data into your cloned repository directory.

Please **do NOT commit the data to the repository**.

When the test phase of the competition (Test Phase) begins, you may return to the "Files"
tab to download the unlabeled test data for the task (info-557-2025spr-PUBLIC-test); this will 
not be available until the test phase.

# Write your code

You should design a neural network model to perform the task described on the
CodaBench site.
Your code should train a model on the provided training data and tune
hyper-parameters on the provided validation (dev) data.
Your code should be able to make predictions on either the dev data
or (once available) the test data.
Your code should package up its predictions in a `submission.zip` file,
following the formatting instructions on CodaBench.

You must create and train your neural network in the Keras framework.
You should train and tune your model using the training and development data
that you downloaded from the CodaBench site.

**If you would like to use any additional resource to train your model, you must
first ask for permission by contacting the instructors by email 
(Clay and Jiacheng)**

There is some sample code in this repository you can use in any way you like to get started.
This code is described briefly on the CodaBench site.
If you prefer to delete this code entirely and start from scratch, that is fine, too!

# Test your model predictions on the validation (dev) set

During the development phase of the competition, the CodaBench site will expect
predictions on the dev set.
To test the performance of your model, run your model on the dev data,
format your model predictions as instructed on the CodaBench site, and upload
your model's predictions (in the `submission.zip` file) on the "My Submissions" tab of the CodaBench site.

During the development phase, you are allowed to upload predictions many times.
You are **strongly** encouraged to upload your model's dev set
predictions to CodaBench after every significant change to your code to make
sure you have all the formatting correct.

# Submit your model predictions on the test set

When the test phase of the competition begins (consult the CodaBench site for
the exact timing), the instructor will update the CodaBench site to expect
predictions on the test set, rather than predictions on the development set.
The instructor will also release the unlabeled test set on CodaBench as
described above under "Download the Data".
To test the performance of your model, download the test data, run your model on
the test data, format your model predictions as instructed on the CodaBench
site, and upload your model's predictions (again, in the `submission.zip` file) 
on the "My Submissions" tab of the CodaBench site.

During the test phase, you are allowed to upload predictions **only once**.
This is why it is critical to debug any formatting problems during the
development phase.

Also be sure to push the final state of your model code to your GitHub 
repository during this phase. This will constitute your code submission 
for the project.
 
# Grading

You will be graded first by your model's accuracy, and second on how well your
model ranks in the competition.
If your model achieves better accuracy on the test set than the baseline model
included in this repository, you will get at least a B.
If your model achieves better accuracy on the test set than a second baseline
that the instructor will reveal during the test phase of the competition, you will get an A.
All models within the same letter grade will be assigned a numeric grade based on how they are ranked across the
range, evenly distributing the ranked performance across the letter grade.
So for example, the highest ranked model in the A range will get 100%, and the
lowest ranked model in the B range will get 80%.

**If you train your neural network with any library other than Tensorflow/Keras,
or you use an external resource that you do not obtain permission for from the 
instructors (Clay and Jiacheng), you will lose 10% (a letter grade) from 
your score.**
