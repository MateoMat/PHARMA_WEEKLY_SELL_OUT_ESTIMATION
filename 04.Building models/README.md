# 04. Building models

## At this stage, we will create models and find suitable hyperparameters

1. Importing libraries

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

2. Importing prepared data

```python
# Creating connection variable
conn = pyodbc.connect('DRIVER={SQLServer};SERVER=blind;DATABASE=blind;UID=blind;PWD=blind;Trusted_Connection=no')

# Creating variable with product name
product = ["'Product_1'"]

# Importing data to dataframe
df = pd.read_sql_query(
f'''SELECT * FROM _05_WEEKLY_MODEL_DATA_CLEAN WHERE PRODUCT_OE={product[0]}
 ''', conn
#     params="SACHOL JEL. 1 10 G"
)
product = product_query[0][1:-1]

```

3. Checking data describe

```python
df.describe()
```
![image info](./img/dfDescribe.PNG.png)
