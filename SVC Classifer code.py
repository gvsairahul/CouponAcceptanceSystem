# -*- coding: utf-8 -*-
"""
Created on Sun Apr  4 13:00:41 2021

@author: ayomy
"""

from sklearn.preprocessing import OneHotEncoder
from sklearn.model_selection import train_test_split
import pandas as pd
import numpy as np

np.random.seed (12)
df = pd.read_csv("Data_restaurant_expensive.csv") 
y_df = df["Y"]
Features = df.columns.tolist()
Features = Features[0:23]

Data1 = OneHotEncoder()
Data1 = Data1.fit_transform(df[Features])
Data1 = Data1.toarray()

X_train = Data1
y_train = y_df
X_train,X_test,y_train,y_test = train_test_split(X_train,y_train, test_size = 0.2)
X_train = np.array(X_train)
y_train = np.array(y_train)


# SVC Classifier
import matplotlib.pyplot as plt
from statistics import mean , stdev 
from sklearn.svm import SVC
from sklearn.metrics import accuracy_score,roc_auc_score
from sklearn.model_selection import StratifiedKFold
from sklearn.base import clone 

def tuning(a,d,c):
    svm_clf = SVC(kernel = a , degree=d, coef0 =0, C= c)
    skfolds = StratifiedKFold(n_splits=5, shuffle = True , random_state= 20)
    roc_auc_scores = []
    for train_index,test_index in skfolds.split(X_train,y_train):
        
        clone_clf = clone(svm_clf)
        X_train_folds = X_train[train_index]
        y_train_folds = y_train[train_index]
        X_test_fold = X_train[test_index]
        y_test_fold = y_train[test_index]
        
        clone_clf.fit(X_train_folds, y_train_folds)
        y_scores_test = clone_clf.decision_function(X_test_fold)
        a = roc_auc_score(y_test_fold,y_scores_test)
        roc_auc_scores.append(a)
    return mean(roc_auc_scores),stdev(roc_auc_scores)    #,stdev(roc_auc_scores)
#print(tuning("poly",3,0.81))
   


def score_max(d):
    mean_auc_scores = [] 
    t = np.arange(0.01,30,0.1).tolist()    
    for c in range(len(t)):
        mean_auc_scores.append(tuning("poly",d,t[c])[0])#plt.plot(t,mean_auc_scores)
    a = np.argsort(mean_auc_scores)    
    p = a[-1] 
    c_max = t[p]
    mean_auc_scores_max = mean_auc_scores[p]
    return c_max,mean_auc_scores,mean_auc_scores_max


t = np.arange(0.01,30,0.1).tolist()
mean_auc_score =  score_max(3)[1]   
plt.plot(t,mean_auc_score)
plt.title("SVC Polynomial_kernel with C_max = "+str(score_max(3)[0])+", degree = 3")
plt.xlabel("C hyperparameter")
plt.ylabel("Mean AUC_score")
C_max = score_max(3)[0]
print(C_max)


print(tuning("poly",3,score_max(3)[0]))

 