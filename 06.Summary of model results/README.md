
# 06. Summary of model results

### 01.Metrics code

```python
from sklearn import  metrics
# Creating a table with models best estimators
models = []
models.append(('ElasticNet', ElasticNetModel.best_estimator_))
models.append(('Lasso', LassoModel.best_estimator_))
models.append(('RidgeModel', RidgeModel.best_estimator_))
models.append(('LR', linearModel_.best_estimator_))
models.append(('SVRModel', SVRModel.best_estimator_))
models.append(('RFR', RandomForrestRegressorModel.best_estimator_))
models.append(('MLP_R', MLP_RegressorModel.best_estimator_))
models.append(('Ransac', RansacModel.best_estimator_))


# Creating a table with metrics
r2 = []
explained_variance_score = []
median_absolute_error = []
mean_squared_error = []
mean_absolute_error = []

# Adding metrics
for name, model in models:
    r2.append(metrics.r2_score(y_test, model.predict(X_test)))
    explained_variance_score.append(metrics.explained_variance_score(y_test, model.predict(X_test)))
    median_absolute_error.append( metrics.median_absolute_error(y_test, model.predict(X_test)))
    mean_squared_error.append(metrics.mean_squared_error(y_test, model.predict(X_test)))
    mean_absolute_error.append(metrics.mean_absolute_error(y_test, model.predict(X_test)))
```

```python
import pandas as pd

# Creating Dataframe with metrics
d = {
    'r2': r2, 
     'explained_variance_score': explained_variance_score, 
     'median_absolute_error': median_absolute_error,
     'mean_squared_error' : mean_squared_error,
     'mean_absolute_error' : mean_absolute_error,
    }
metrics = pd.DataFrame(data=d)
metrics.insert(loc=0, column='Method', value=['ElasticNet','Lasso','Ridge','LR','SVR','RFR','MLP_R','Ransac'])
          
metrics
```
![MetricsResults.PNG](https://github.com/MateoMat/PHARMA_WEEKLY_SELL_OUT_ESTIMATION/blob/master/06.Summary%20of%20model%20results/img/MetricsResults.PNG )

![SummaryGraph.PNG](https://github.com/MateoMat/PHARMA_WEEKLY_SELL_OUT_ESTIMATION/blob/master/06.Summary%20of%20model%20results/img/Summary.png )



### 02.Conclusions

Analyzing the metrics of individual models, we can see that the r2 values for the models are similar and oscillate in the range of 0.815-0.853 (MLP Regressor is excluded from further analysis).

The best result for both R2 and the lowest errors were achieved using a model using the Random Forrest algorithm.

It should also be noted that this algorithm works best, but only for data whose value falls within the min-max range for observations on the training set.

When analyzing the product history, we do not notice many significant outliers and significant deviations from the average.

**We can therefore qualify this model for prediction of full weeks as best suited.**

However, referring to the assumptions of the project - **our goal is to find the model that will best predict the data of the explained variable, based on which the sum of the week will be closest to the external monthly data**.

So we must note that in the weekly sales volume in internal data narrowed to full months there will be weeks in which the quantity will be significantly different from the average. This will be due to fewer days of the specific month in the ISO week number.

As a result - this algorithm will not work for sales predictions that differ significantly from the average.

**Accordingly, we exclude the Random Forest and Ridge algorithm from the weekly prediction for aggregated monthly data.**

Therefore, we qualify models for further testing :
* ElasticNet,
* Lasso,
* Linear,
* SVR

:point_left: [Back to main page](https://github.com/MateoMat/PHARMA_WEEKLY_SELL_OUT_ESTIMATION)












