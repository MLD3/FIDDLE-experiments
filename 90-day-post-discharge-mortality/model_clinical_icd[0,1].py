import numpy as np
import pandas as pd
from collections import Counter

from sklearn.model_selection import train_test_split
from sklearn.model_selection import ShuffleSplit

df = pd.read_csv('input/label.csv').rename(columns={'HADM_ID': 'ID'})

from sklearn.linear_model import LogisticRegression
from sklearn.ensemble import RandomForestClassifier
from sklearn.model_selection import StratifiedShuffleSplit, StratifiedKFold, GridSearchCV, RandomizedSearchCV
from sklearn import metrics, feature_selection, utils
import scipy.stats
from joblib import Parallel, delayed
from tqdm import tqdm#_notebook as tqdm
import random

def train_model(Xtr, ytr, Xte, yte, model_name, exp_name):
    np.random.seed(0)
    random.seed(0)

    clf = helper(model_name)

    clf.fit(Xtr, ytr)
    print('best_params_', clf.best_params_)
    print('best_score_ ', clf.best_score_)
    try:
        np.savetxt(
            'output/{}.{},coef.txt'.format(exp_name, model_name), 
            clf.best_estimator_.coef_,
            delimiter=',',
        )
    except:
        print('Coefficients not saved')
        pass

    ###### 
    # Eval
    # Bootstrapped 95% Confidence Interval
    try:
        yte_pred = clf.predict_proba(Xte)[:,1]
    except AttributeError:
        print('Cannot produce probabilistic estimates')
        raise

    def func(i):
        yte_true_b, yte_pred_b = utils.resample(yte, yte_pred, replace=True, random_state=i)
        return metrics.roc_auc_score(yte_true_b, yte_pred_b)

    test_scores = Parallel(n_jobs=2)(delayed(func)(i) for i in tqdm(range(1000), leave=False))
    print('Test AUC: {:.3f} ({:.3f}, {:.3f})'.format(np.median(test_scores), np.percentile(test_scores, 2.5), np.percentile(test_scores, 97.5)))

    save_test_predictions(yte, yte_pred, model_name, 'output/'+exp_name+'.')


n_jobs=12
search_budget=50

def helper(model_type):
    if model_type == 'LR':
        clf = RandomizedSearchCV(
            LogisticRegression(solver='lbfgs'), 
            {'C': scipy.stats.reciprocal(1e-5, 1e5)},
            n_iter=search_budget,
            cv=StratifiedKFold(5),
            scoring='roc_auc',
            n_jobs=n_jobs, verbose=2,
        )
    elif model_type == 'RF':
        clf = RandomizedSearchCV(
            RandomForestClassifier(), 
            {
                "criterion": ["gini", "entropy"],
                "max_depth": [4, 8, 16, 32, None],
                "max_features": scipy.stats.randint(1, 100),
                "min_samples_split": scipy.stats.randint(2, 11),
                "min_samples_leaf": scipy.stats.randint(1, 11),
                "n_estimators": scipy.stats.randint(50,500),
                "bootstrap": [True],
            },
            n_iter=search_budget,
            cv=StratifiedKFold(5),
            scoring='roc_auc',
            n_jobs=n_jobs, verbose=2,
        )
    else:
        assert False
    
    return clf

def save_test_predictions(y_true, y_score, model_name, save_dir):
#     import pathlib
#     pathlib.Path(save_dir).mkdir(parents=True, exist_ok=True)
    
    fname = save_dir + '{}.test.npz'.format(model_name)
    np.savez(
        open(fname, 'wb'),
        y_score = y_score,
        y_true  = y_true,
    )
    print('Test predictions saved to', fname)



import sparse
X = sparse.load_npz('output.clinical/X.npz').todense().squeeze()
s = sparse.load_npz('output.icd[0,1]/s.npz').todense()
X = np.concatenate((s, X), axis=1)

Xtr = X[df.partition=="train"]
ytr = df[df.partition=="train"]['label']
Xte = X[df.partition=="test"]
yte = df[df.partition=="test"]['label']
print(Xtr.shape, ytr.shape, Xte.shape, yte.shape)

train_model(Xtr, ytr, Xte, yte, 'LR', 'clinical+ICD[0,1]')
train_model(Xtr, ytr, Xte, yte, 'RF', 'clinical+ICD[0,1]')
