# Credit-Card-Fraud-Detection
Detecting credit card fraud using  an approach with imbalanced classification and model ensembling

## Background
While an incredible amount of transactions are made everyday, it is no doubt that some transactions may be fraudulent. As a result, credit card companies usually deploy sophisticated algorithms to identify suspicious transactions and prevent them from going through.Here we will demonstrate a stacked classification model in R.

## Dataset
The datasets contains transactions made by credit cards in September 2013 by european cardholders. This dataset presents transactions that occurred in two days, where we have 492 frauds out of 284,807 transactions. The dataset is highly unbalanced, the positive class (frauds) account for 0.172% of all transactions.

It contains only numerical input variables which are the result of a PCA transformation. Unfortunately, due to confidentiality issues, we cannot provide the original features and more background information about the data. Features V1, V2, ... V28 are the principal components obtained with PCA, the only features which have not been transformed with PCA are 'Time' and 'Amount'. Feature 'Time' contains the seconds elapsed between each transaction and the first transaction in the dataset. The feature 'Amount' is the transaction Amount, this feature can be used for example-dependant cost-senstive learning. Feature 'Class' is the response variable and it takes value 1 in case of fraud and 0 otherwise.

Given the class imbalance ratio, we recommend measuring the accuracy using the Area Under the Precision-Recall Curve (AUPRC). Confusion matrix accuracy is not meaningful for unbalanced classification.

## Objective
Our objective is to construct a model to predict which transactions could be fraudulent, with high accuracy.

## Approach
Given the imbalanced dataset, we will first evaluate different resampling methods to overcome the skewed distribution in class. We will then build different models and stack them together to increase the overall accuracy.

### The final report with findings can be found [here](http://rpubs.com/nitishghosal/370771).
