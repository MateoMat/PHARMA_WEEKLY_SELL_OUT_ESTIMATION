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

```python
# creating Elastic Net model and appending weekly predictions to internal weekly data
ElasticNetModel = GridSearchCV(make_pipeline(PolynomialFeatures(degree=2), ElasticNet(alpha=1, tol=0.1)),
                    param_grid={'polynomialfeatures__degree': [1, 2, 3, 4, 5, 6],
                    'elasticnet__alpha': [22000]},
                    cv=kfold,
                    refit=True,
                    n_jobs=-1)
ElasticNetModel.fit(X_train, y_train)

weekly_data = []

for idx, row in WeekToMonth.iterrows():
    weekly_data.append([row.SELL_OUT_UNITS_S4U])

results =[]

for i in weekly_data:
    results.append(ElasticNetModel.predict([[i[0]]]))

ElasticNetModel_Predict = pd.Series([])

for idx,i in enumerate(results):
    ElasticNetModel_Predict[idx] = int(i)
    
WeekToMonth.insert(3,'ElasticNetModel_Predict',ElasticNetModel_Predict)
```

```python
# creating Lasso model and appending weekly predictions to internal weekly data
LassoModel = GridSearchCV(make_pipeline(PolynomialFeatures(degree=2), Lasso(alpha=1, tol=0.1)),
                    param_grid={'polynomialfeatures__degree': [1,2,3,4,5],
                    'lasso__alpha': [17000]},
                    cv=kfold,
                    refit=True,
                    n_jobs=-1)
LassoModel.fit(X_train, y_train)

weekly_data = []

for idx, row in WeekToMonth.iterrows():
    weekly_data.append([row.SELL_OUT_UNITS_S4U])

results =[]

for i in weekly_data:
    results.append(LassoModel.predict([[i[0]]]))

LassoModel_Predict = pd.Series([])

for idx,i in enumerate(results):
    LassoModel_Predict[idx] = int(i)
    
WeekToMonth.insert(4,'LassoModel_Predict',LassoModel_Predict)

```

```python
# creating linear model and appending weekly predictions to internal weekly data
linearModel_ = GridSearchCV(make_pipeline(PolynomialFeatures(degree=2), linear_model.LinearRegression()),
                    param_grid={'polynomialfeatures__degree': [12]},
                    cv=kfold,
                    refit=True,
                    n_jobs=-1)
linearModel_.fit(X_train, y_train)

weekly_data = []

for idx, row in WeekToMonth.iterrows():
    weekly_data.append([row.SELL_OUT_UNITS_S4U])

results =[]

for i in weekly_data:
    results.append(linearModel_.predict([[i[0]]]))

LinearModel_Predict = pd.Series([])

for idx,i in enumerate(results):
    LinearModel_Predict[idx] = int(i)
    
WeekToMonth.insert(5,'LinearModel_Predict',LinearModel_Predict)
```

```python
# creating SVR model and appending weekly predictions to internal weekly data
SVRModel = GridSearchCV(SVR(kernel='rbf'),
                   param_grid={"C": [1000000],
                               "gamma": [0.001,0.0001,0.00001,0.00000011]},
                    cv=kfold,
                    refit=True,
                    n_jobs=-1)
SVRModel.fit(X_train, y_train)

weekly_data = []

for idx, row in WeekToMonth.iterrows():
    weekly_data.append([row.SELL_OUT_UNITS_S4U])

results =[]

for i in weekly_data:
    results.append(SVRModel.predict([[i[0]]]))

SVRModel_Predict = pd.Series([])

for idx,i in enumerate(results):
    SVRModel_Predict[idx] = int(i)
    
WeekToMonth.insert(6,'SVRModel_Predict',SVRModel_Predict)
```

```python
# creating Ransac model and appending weekly predictions to internal weekly data
RansacModel = GridSearchCV(RANSACRegressor(random_state=0),
                  param_grid={
                   'min_samples': [5]},
                    cv=kfold,
                    refit=True,
                    n_jobs=-1)
RansacModel.fit(X_train, y_train)

weekly_data = []

for idx, row in WeekToMonth.iterrows():
    weekly_data.append([row.SELL_OUT_UNITS_S4U])

results =[]

for i in weekly_data:
    results.append(RansacModel.predict([[i[0]]]))

RansacModel_Predict = pd.Series([])

for idx,i in enumerate(results):
    RansacModel_Predict[idx] = int(i)
    
WeekToMonth.insert(7,'RansacModel_Predict',RansacModel_Predict)
```

```python
# aggregating weekly data to monthly
MONTHLY_MODEL_COMPARISON = WeekToMonth.groupby("MONTH",as_index=False).sum()
MONTHLY_MODEL_COMPARISON.describe()

```
![MonthlyModelComparison.PNG](https://github.com/MateoMat/PHARMA_WEEKLY_SELL_OUT_ESTIMATION/blob/master/07.Testing%20models%20results%20with%20monthly%20data/img/MonthlyModelComparison.PNG )

```python
# Removing product column from external data
EXTERNAL_MONTHLY_DATA.drop('PRODUCT',axis=1,inplace=True)

# changing month column data type
EXTERNAL_MONTHLY_DATA[["MONTH"]] = EXTERNAL_MONTHLY_DATA[["MONTH"]].apply(pd.to_datetime)

# merging internal aggregated data to external monthly data
COMPARISON_DATA=MONTHLY_MODEL_COMPARISON.merge(EXTERNAL_MONTHLY_DATA,left_on='MONTH', right_on='MONTH')
COMPARISON_DATA.describe()

```
![ComparisonDataDescribe.PNG](https://github.com/MateoMat/PHARMA_WEEKLY_SELL_OUT_ESTIMATION/blob/master/07.Testing%20models%20results%20with%20monthly%20data/img/ComparisonDataDescribe.PNG )

## 2. Visualization and summary of monthly predictions in relation to external data

```python
%matplotlib inline
import numpy as np

x = COMPARISON_DATA[['MONTH']]
from matplotlib.pyplot import figure
# plt.figure(num=None, figsize=(10, 12), dpi=200, facecolor='w', edgecolor='k')

fig, ax = plt.subplots()
ax.plot(x, COMPARISON_DATA[['ElasticNetModel_Predict']], ':b', label='ElasticNet',linewidth=4)
ax.plot(x, COMPARISON_DATA[['LinearModel_Predict']], ':y', label='Linear',linewidth=3)
ax.plot(x, COMPARISON_DATA[['SVRModel_Predict']], ':c', label='SVR',linewidth=3)
ax.plot(x, COMPARISON_DATA[['LassoModel_Predict']], ':g', label='Lasso',linewidth=3)
ax.plot(x, COMPARISON_DATA[['RansacModel_Predict']], ':m', label='Ransac',linewidth=3)
ax.plot(x, COMPARISON_DATA[['SELL_OUT_UNITS_IMS']], '--g', label='External Data',linewidth=3)

fig.set_size_inches(15, 8, forward=True)
plt.title("Monthly prediction vs external monthly data",fontsize= 24)
# figure(figsize=(1,1))
# ax.axis('equal')
leg = ax.legend(prop={"size":16});
```
![MonthlyPredictionVsExternalMonthlyData.PNG](https://github.com/MateoMat/PHARMA_WEEKLY_SELL_OUT_ESTIMATION/blob/master/07.Testing%20models%20results%20with%20monthly%20data/img/MonthlyPredictionVsExternalMonthlyData.png)

```python
dd = COMPARISON_DATA
dd.drop('MONTH', axis=1,inplace=True)
PercentageOfMonthlyDataAccuracy = dd.div(dd['SELL_OUT_UNITS_IMS'],axis=0)
PercentageOfMonthlyDataAccuracy.round(3)*100
```
![PercentageOfMonthlyDataAccuracy.PNG](https://github.com/MateoMat/PHARMA_WEEKLY_SELL_OUT_ESTIMATION/blob/master/07.Testing%20models%20results%20with%20monthly%20data/img/PercentageOfMonthlyDataAccuracy.PNG)


:point_left: [Back to main page](https://github.com/MateoMat/PHARMA_WEEKLY_SELL_OUT_ESTIMATION#scope-of-work)


