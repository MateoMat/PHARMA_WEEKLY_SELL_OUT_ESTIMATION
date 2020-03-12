
# 06. Summary of model results

### Metrics code

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

:point_left: [Back to main page](https://github.com/MateoMat/PHARMA_WEEKLY_SELL_OUT_ESTIMATION)

### Conclusions













