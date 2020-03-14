# 07. Testing models results with monthly data

## Overview
As a result of the analysis carried out in the previous section, we will now perform a comparison external monthly data vs predicted by models:
* ElasticNet
* Lasso
* Linear
* SVR
* Ransac

## 1. Preparing DataFrame

```python
# importing libraries
import pandas as pd
import numpy as np
import pyodbc
import matplotlib.pyplot as plt
from sklearn.model_selection import train_test_split
from sklearn.model_selection import GridSearchCV
from sklearn import linear_model
from sklearn.preprocessing import PolynomialFeatures
from sklearn.linear_model import Ridge
from sklearn.linear_model import Lasso
from sklearn.linear_model import ElasticNet
from sklearn.pipeline import make_pipeline
from sklearn import model_selection
from sklearn.svm import SVR
from sklearn.linear_model import RANSACRegressor
import warnings
warnings.filterwarnings('ignore')
warnings.filterwarnings(action='ignore',category=DeprecationWarning)
warnings.filterwarnings(action='ignore',category=FutureWarning)
from sklearn import model_selection

# DB connection
conn_int = pyodbc.connect('DRIVER={SQL Server};SERVER=blind;DATABASE=blind;UID=blind;PWD=blind;Trusted_Connection=no')

# importing DataFrame - internal data
product_query = ["blind"]
df = pd.read_sql_query(
f'''SELECT * FROM model032020._05_WEEKLY_MODEL_DATA_CLEAN WHERE PRODUCT_OE={product_query[0]}
 ''', conn_int
)
product = product_query[0][1:-1]
df.drop('Week', axis=1,inplace=True)
df.drop('BLOZ_VALID',axis=1,inplace=True)
df.drop('PRODUCT_OE',axis=1,inplace=True)

df.describe()
```

![ModelData.PNG](https://github.com/MateoMat/PHARMA_WEEKLY_SELL_OUT_ESTIMATION/blob/master/07.Testing%20models%20results%20with%20monthly%20data/img/ModelDataDescribe.PNG )

```python
# importing DataFrame - internal data from different server
conn_ext = pyodbc.connect('DRIVER={SQL Server};SERVER=blind;DATABASE=blind;UID=blind;PWD=blind;Trusted_Connection=no')
EXTERNAL_MONTHLY_DATA = pd.read_sql_query(
f'''
select 
	CAST(Miesiac as date) as [MONTH]
	,Produkt as [PRODUCT]
	,CAST(Sprzedaz_Ilosc as int)as [SELL_OUT_UNITS_IMS]
from dbo.v_BR_SprzValSku_Sellout
WHERE Produkt={product_query[0]}
AND Miesiac>='2019-01-01' order by Miesiac
''',conn_ext
)

EXTERNAL_MONTHLY_DATA.describe()
```

![ModelData.PNG](https://github.com/MateoMat/PHARMA_WEEKLY_SELL_OUT_ESTIMATION/blob/master/07.Testing%20models%20results%20with%20monthly%20data/img/ExternalMonthlyDataDescribe.PNG )

```python
# importing internal data for prediction in ISO Weeks with month mark
WeekToMonth = pd.read_excel('06.WeekToMonth.xlsx')
```
![ModelData.PNG](https://github.com/MateoMat/PHARMA_WEEKLY_SELL_OUT_ESTIMATION/blob/master/07.Testing%20models%20results%20with%20monthly%20data/img/WeekToMonthDescribe.PNG )

```python
# setting kFold and split data set
seed=42
kfold = model_selection.KFold(n_splits=5, random_state=seed)
y=df[["SELLOUT_UNITS_IMS"]]
X=df[["SELLOUT_UNITS_S4U"]]
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

```

