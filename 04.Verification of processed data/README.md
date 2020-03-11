# 04. Verification of processed data

## At this stage, we will verify the processed data in terms of regression models

### 1. Importing libraries

```python
import pandas as pd
import numpy as np
import pyodbc
import matplotlib.pyplot as plt
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

### 3. Checking data describe

```python
df.describe()
```
![Dataframe describe results](https://github.com/MateoMat/PHARMA_WEEKLY_SELL_OUT_ESTIMATION/blob/master/04.Verification%20of%20processed%20data/img/dfDescribe.PNG )

### 4. Data set linearity and correlation

As we can see below:
- high linear correlation (Pearson) occurs
- high monotonic correlation (Spearman, Tau Kendall) occurs

```python
plt.figure(figsize=(6,6))
axes = plt.gca()
plt.title("DataFrame scatter plot ")
plt.scatter(df['SELLOUT_UNITS_IMS'], df['SELLOUT_UNITS_S4U'],  color='orange')
plt.show()
```
![DataFrameScatterPlot](https://github.com/MateoMat/PHARMA_WEEKLY_SELL_OUT_ESTIMATION/blob/master/04.Verification%20of%20processed%20data/img/DataFrameScatterPlot.png)


```python
# Creating variables with correlation results
Spearman = df['SELLOUT_UNITS_IMS'].corr(df['SELLOUT_UNITS_S4U'], method='spearman')
Pearson = df['SELLOUT_UNITS_IMS'].corr(df['SELLOUT_UNITS_S4U'], method='pearson')
Kendall = df['SELLOUT_UNITS_IMS'].corr(df['SELLOUT_UNITS_S4U'], method='kendall')

# printing a summary
Correlation = pd.DataFrame(data={'Spearman': [Spearman], 'Pearson': [Pearson], 'Kendall':[Kendall]})
Correlation.style.hide_index()
```
![Correlation](https://github.com/MateoMat/PHARMA_WEEKLY_SELL_OUT_ESTIMATION/blob/master/04.Verification%20of%20processed%20data/img/Correlation.PNG)

### 5. Outliers verification

As we can see in the box chart - we observe two outliers in both internal and external data. We assume that they do not significantly affect the result (we know from domain knowledge that they can be repeated in future internal values).

![SellOutUnitsIMSBoxPlot](https://github.com/MateoMat/PHARMA_WEEKLY_SELL_OUT_ESTIMATION/blob/master/04.Verification%20of%20processed%20data/img/SellOutUnitsIMSBoxPlot.PNG)
![SellOutUnitsS4UBoxPlot](https://github.com/MateoMat/PHARMA_WEEKLY_SELL_OUT_ESTIMATION/blob/master/04.Verification%20of%20processed%20data/img/SellOutUnitsS4UBoxPlot.PNG)

:point_left: [Back to main page](https://github.com/MateoMat/PHARMA_WEEKLY_SELL_OUT_ESTIMATION)