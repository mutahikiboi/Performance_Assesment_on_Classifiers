# Performance Assessment of Classifiers on German Credit Dataset
This project evaluates the performance of multiple machine learning classifiers on the German Credit dataset using the mlr3 framework in R. The analysis includes accuracy and balanced accuracy metrics with bootstrap resampling for robust validation.

## Installation
Required Packages

install.packages(c("tidyverse", "mlr3verse", "ranger", "mlr3viz"))
data(german_credit)  # Ensure the dataset is available
library(mlr3verse)

## Load German Credit task
task <- tsk("german_credit")

## Initialize learners
learners <- lrns(c(
  'classif.ranger',     # Random Forest
  'classif.kknn',       # k-Nearest Neighbors
  'classif.featureless',# Baseline Dummy Classifier
  'classif.rpart',      # Decision Tree
  "classif.lda"         # Linear Discriminant Analysis
), predict_type = 'prob')

### 2. Resampling Strategy (Bootstrap)

resampling <- rsmp('bootstrap', repeats = 100L)

### 3. Run Benchmark Experiment

design <- benchmark_grid(task = task, learners = learners, resampling = resampling)
bmr <- benchmark(design)

### 4. Evaluate Performance

## Aggregate results with Accuracy and Balanced Accuracy
results <- bmr$aggregate(msrs(c("classif.acc", "classif.bacc")))
print(results)
5. Visualization
r
Copy
library(mlr3viz)

## Plot Accuracy
autoplot(bmr, measure = msr("classif.acc")) + 
  ggtitle("Classifier Accuracy Comparison")

## Plot Balanced Accuracy
autoplot(bmr, measure = msr("classif.bacc")) + 
  ggtitle("Classifier Balanced Accuracy Comparison")

License
This project is licensed under the MIT License - see the LICENSE file for details. 
