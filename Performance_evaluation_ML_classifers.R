
# performance assessment

#install relevant libraries
data(german_credit)
install.packages('german_credit')
library(tidyverse)
library(mlr3verse)
install.packages("mlr3viz")
library(mlr3viz)

#Load the task
task <- tsk("german_credit")
task

#viewing all mlr learners
mlr_learners %>%
  as.data.table %>%
  view

install.packages('ranger')
learner <- lrns(c(	
    'classif.ranger', 'classif.kknn', 'classif.featureless', 'classif.rpart', "classif.lda"), predict_type = 'prob')

#creating a resampling object using bootstrap
sample <- rsmp('bootstrap', repeats = 100L)


#benchmarking the learners on task with chosen resampling strategy
design <- benchmark_grid(task = task,learners = learner,resampling = sample)
design

#executing benchmark experiments

bmr <-benchmark(design)

#aggregrate benchmark results

bmr$aggregate()

#evaluating the results using acc and bacc(default is mce)
bmr$aggregate(msrs(list('classif.acc', 'classif.bacc')))

#plotting accuracy results
bmr %>%
  autoplot(measure = msr('classif.acc'))

#plotting balanced accuracy results
bmr %>%
  autoplot(measure = msr('classif.bacc'))

