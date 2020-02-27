# 02.Data preprocessing - stage 1
    
### 1.Creating table with raw aggregated data for weekly model



After finalizing the decision to qualify customers for the model described in [previous section](https://github.com/MateoMat/PHARMA_WEEKLY_SELL_OUT_ESTIMATION/tree/master/01.Data%20Mining), we collect from the database the sum of sales volumes aggregated by weeks for modeling product.
We also transform named weeks and products to be consistent with subsequent sources.

*It is extremely important to exclude from the source all transactions that are not selling to the consumer but only selling to another entity*

SQL Script: *02.Data preprocessing - 2.Cleaning and transforming _02_S4U_AGGR_WEEKS_SELL_OUT_RAW* - not available in remote repository

:+1: After completing the above steps, a table was created **_02_S4U_AGGR_WEEKS_SELL_OUT_RAW**

### 2.Cleaning and transforming 

In the next step, we have to transform week dimension, because internal sources are not ISO standarized.
It means, that the data from every 53 week should be delete and sales have to be added to 01 week of next year.

:+1: After completing the above steps, a table was created **2.Cleaning and transforming _02_S4U_AGGR_WEEKS_SELL_OUT_RAW**





At this stage 

* This notebook contains:
     * operations of downloading raw sales units data for a single product for each panel pharmacy aggregated into weeks
     * verification of completeness of data and lack of deviations
     * missing data implementation
     