# 04. Building models

## At this stage, we will create models and find suitable hyperparameters

### 1. Importing libraries

```python
import pandas as pd
import numpy as np
import pyodbc
import matplotlib.pyplot as plt
from sklearn.model_selection import train_test_split
from sklearn import model_selection
from sklearn.model_selection import GridSearchCV
from sklearn import linear_model
from sklearn.preprocessing import PolynomialFeatures
from sklearn.linear_model import Ridge
from sklearn.linear_model import Lasso
from sklearn.linear_model import ElasticNet
from sklearn.pipeline import make_pipeline
from sklearn import model_selection
from sklearn.svm import SVR
from sklearn.ensemble import RandomForestRegressor
from sklearn.neural_network import MLPRegressor
from sklearn.linear_model import RANSACRegressor
from sklearn import  metrics

```

### 2. Importing prepared data

```python
# Creating connection variable
conn = pyodbc.connect('DRIVER={SQLServer};SERVER=blind;DATABASE=blind;UID=blind;PWD=blind;Trusted_Connection=no')

# Creating variable with product name
product = ["'Product_1'"]

# Importing data to dataframe
df = pd.read_sql_query(
f'''SELECT * FROM _05_WEEKLY_MODEL_DATA_CLEAN WHERE PRODUCT_OE={product[0]}
 ''', conn

)
product = product_query[0][1:-1]

```

### 3. Model workflow

* Setting seed and kfold

```python
seed=42
kfold = model_selection.KFold(n_splits=5, random_state=seed)
```

* spliting the data

```python
y=df[["SELLOUT_UNITS_IMS"]]
X=df[["SELLOUT_UNITS_S4U"]]

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)
```

* ElasticNet grid search

```python
ElasticNetModel = GridSearchCV(make_pipeline(PolynomialFeatures(degree=2), ElasticNet(alpha=1, tol=0.1)),
                    param_grid={'polynomialfeatures__degree': [1, 2, 3, 4, 5, 6],
                    'elasticnet__alpha': [10000,20000,21000,22000,23000,24000,25000,26000]},
                    cv=kfold,
                    refit=True,
                    n_jobs=-1)
ElasticNetModel.fit(X_train, y_train)
ElasticNetModel.best_params_

```
**best_params:** {'elasticnet__alpha': 22000, 'polynomialfeatures__degree': 2}

* Lasso grid search

```python
LassoModel = GridSearchCV(make_pipeline(PolynomialFeatures(degree=2), Lasso(alpha=1, tol=0.1)),
                    param_grid={'polynomialfeatures__degree': [1,2,3,4,5],
                    'lasso__alpha': [0.001,0.002]},
                    cv=kfold,
                    refit=True,
                    n_jobs=-1)
LassoModel.fit(X_train, y_train)
LassoModel.best_params_
```

**best_params:** {'lasso__alpha': 17000, 'polynomialfeatures__degree': 1}

* Ridge Model

```python
RidgeModel = GridSearchCV(make_pipeline(PolynomialFeatures(degree=2), linear_model.Ridge(alpha=1, tol=0.2)),
                    param_grid={'polynomialfeatures__degree': [1,0.9, 2, 3, 4,5,6,7,8,9,10],
                    'ridge__alpha': [0.4,0.5,0.6,0.7,0.8,9,0.04,0.05,0.1]},
                    cv=kfold,
                    refit=True,
                    n_jobs=-1)
RidgeModel.fit(X_train, y_train)
RidgeModel.best_params_
```

**best_params:** {'polynomialfeatures__degree': 4, 'ridge__alpha': 0.05}

* Linear Model

```python
linearModel_ = GridSearchCV(make_pipeline(PolynomialFeatures(degree=2), linear_model.LinearRegression()),
                    param_grid={'polynomialfeatures__degree': [1,0.5, 2, 3, 4,5,6,7,8,9,10,11,12,13,14,15]},
                    cv=kfold,
                    refit=True,
                    n_jobs=-1)
linearModel_.fit(X_train, y_train)
print(linearModel_.best_params_)
```

**best_params:** {'polynomialfeatures__degree': 12}

* SVR (kernel:rbf) Model

```python
SVRModel = GridSearchCV(SVR(kernel='rbf'),
                   param_grid={"C": [100,200,300,400,500,600,700,800,1000000,1100000],
                               "gamma": [0.001,0.0001,0.00001,0.00000011]},
                    cv=kfold,
                    refit=True,
                    n_jobs=-1)
SVRModel.fit(X_train, y_train)
print(SVRModel.best_params_)

```

**best params:**{'C':1000000,'gamma': 1.1e-07}

* Random Forrest Regressor Model

```python
RandomForrestRegressorModel = GridSearchCV(RandomForestRegressor(n_jobs=-1, max_features= 'sqrt', n_estimators=50, oob_score = True),
                   param_grid={
                   'n_estimators': [100, 150, 300,400],
                    'max_features': ['auto', 'sqrt', 'log2'],  
                    'max_depth': [ 200,300,350, 400, 500, 600]
                   },
                    cv=kfold,
                    refit=True,
                    n_jobs=-1)
RandomForrestRegressorModel.fit(X_train, y_train)
print(RandomForrestRegressorModel.best_params_)
```

**best params:** {'max_depth': 350, 'max_features': 'auto', 'n_estimators': 100}

* RANSAC Regressor Model

```python
from sklearn.linear_model import RANSACRegressor

RansacModel = GridSearchCV(RANSACRegressor(random_state=0),
                  param_grid={
                   'min_samples': [1,2,3,4,5,6,7,8,9]},
                    cv=kfold,
                    refit=True,
                    n_jobs=-1)
RansacModel.fit(X_train, y_train)
print(RansacModel.best_params_)
```

**best params:** {'min_samples': 5}












