# 02.Data preprocessing - stage 1

### 0.Cleaning product dimension
Internal data comes from 1938 customers. Each of them has an independent transaction system - this means that product names and identifiers will never be unique and in addition it changes over time. The most labor-intensive process before starting the analysis is to create a product dimension that will 100% download data for a specific product - taking into account the correct ID, names and changes over time for each.

:white_check_mark: After completing the above steps, a table was created **dim.PRODUCTS**
    
### 1. Creating table with raw aggregated data for weekly model


After finalizing the decision to qualify customers for the model described in [previous section](https://github.com/MateoMat/PHARMA_WEEKLY_SELL_OUT_ESTIMATION/tree/master/01.Data%20Mining#model-assumptions), we collect from the database the sum of sales volumes aggregated by weeks for modeling product.
We also transform named weeks and products to be consistent with subsequent sources.

*It is extremely important to exclude from the source all transactions that are not selling to the consumer but only selling to another entity*

:+1: SQL Script: *02.Data preprocessing - 1.Creating table with raw aggregated data for model* - not available in remote repository

:white_check_mark: After completing the above steps, a table was created **_02_S4U_AGGR_WEEKS_SELL_OUT_RAW**

### 2. Cleaning and transforming 

In the next step, we have to transform week dimension, because internal sources are not ISO standarized.
It means, that the data from every 53 week should be delete and sales have to be added to 01 week of next year.

:+1: SQL Script: *02.Data preprocessing - 2.Cleaning and transforming _02_S4U_AGGR_WEEKS_SELL_OUT_RAW* - not available in remote repository

:white_check_mark: After completing the above steps, a table was created **_03_S4U_AGGR_WEEKS_SELL_OUT_CLEAN**

### 3. Joining External to Internal Data

At the end of this stage, we only have to join to table _03_S4U_AGGR_WEEKS_SELL_OUT_CLEAN external data for each product and week


:+1: SQL Script: *02.Data preprocessing - 3.Joining External to Internal Data* - not available in remote repository

:white_check_mark: After completing the above steps, a table was created **_04_WEEKLY_MODEL_DATA_RAW**


:point_left: [Back to main page](https://github.com/MateoMat/PHARMA_WEEKLY_SELL_OUT_ESTIMATION#scope-of-work)


     