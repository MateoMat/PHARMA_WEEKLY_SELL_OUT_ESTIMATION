# PHARMA_WEEKLY_SELL_OUT_ESTIMATION


## Overview
The volume of sales to the consumer should be the basis for strategic analyzes of sales-based organizations.
It is using in many areas such as sales,marketing, finance, production.


Demand  directly affects the next links in the distribution chain.


Short and long-term product strategies are based on achieving a specific result in monthly data.

It is a strong business need for weekly data monitoring.
This knowledge is useful for monitoring of the current performance level in the relation to the assumptions, predict monthly performance, and take action in case of deviations.

Such data provided by external companies is expensive, so this project aims to use internal data to estimate weekly data at national level.

## Goals

The goal is to build a ML Regression model for predicting national weekly data for each SKU (Stock Keeping Unit) from internal source, which the sum of predicted values meets the closest score to external monthly data.

This project describes the methodology and procedure for one SKU whose actual name has been blinded.

## Data overview:
The effect of data mining analysis and assumptions is described in [01.Data Mining](https://github.com/MateoMat/PHARMA_WEEKLY_SELL_OUT_ESTIMATION/tree/master/01.Data%20Mining) folder.

## Dependencies
* python 3.7
* pandas
* numpy
* matplotlib
* scikit-learn
* pandas_profiling

## Action plan
After data cleaning and features enginearing build a several ensembling models using the best simple classifiers of each type.
## Scope of work
* [01.Data mining :](https://github.com/MateoMat/PHARMA_WEEKLY_SELL_OUT_ESTIMATION/tree/master/01.Data%20Mining)
    * [Data source overview](https://github.com/MateoMat/PHARMA_WEEKLY_SELL_OUT_ESTIMATION/tree/master/01.Data%20Mining#data-source-overview)
    * [Model assumptions](https://github.com/MateoMat/PHARMA_WEEKLY_SELL_OUT_ESTIMATION/tree/master/01.Data%20Mining#model-assumptions)
    * [Internal Data description & conclusions](https://github.com/MateoMat/PHARMA_WEEKLY_SELL_OUT_ESTIMATION/tree/master/01.Data%20Mining#internal-data-description--conclusions)
* [02.Data preprocessing - stage 1 :](https://github.com/MateoMat/PHARMA_WEEKLY_SELL_OUT_ESTIMATION/tree/master/02.Data%20preprocessing%20-%20stage%201)
    * [0.Cleaning product dimension](https://github.com/MateoMat/PHARMA_WEEKLY_SELL_OUT_ESTIMATION/tree/master/02.Data%20preprocessing%20-%20stage%201#0cleaning-product-dimension)
    * [1.Creating table with raw aggregated data for weekly model](https://github.com/MateoMat/PHARMA_WEEKLY_SELL_OUT_ESTIMATION/tree/master/02.Data%20preprocessing%20-%20stage%201#1-creating-table-with-raw-aggregated-data-for-weekly-model)
    * [2.Cleaning and transforming](https://github.com/MateoMat/PHARMA_WEEKLY_SELL_OUT_ESTIMATION/tree/master/02.Data%20preprocessing%20-%20stage%201#2-cleaning-and-transforming)
    * [3.Joining External to Internal Data](https://github.com/MateoMat/PHARMA_WEEKLY_SELL_OUT_ESTIMATION/tree/master/02.Data%20preprocessing%20-%20stage%201#3-joining-external-to-internal-data)
* [03.Data preprocessing - stage 2 :](https://github.com/MateoMat/PHARMA_WEEKLY_SELL_OUT_ESTIMATION/tree/master/03.Data%20preprocessing%20-%20stage%202)
    
   Verification of products for models that meets's observations sum assumption
    * [1.Removing products that do not have external data](https://github.com/MateoMat/PHARMA_WEEKLY_SELL_OUT_ESTIMATION/tree/master/03.Data%20preprocessing%20-%20stage%202#1removing-products-that-do-not-have-external-data)
    * [2.Removing products without obligatory number of observations.](https://github.com/MateoMat/PHARMA_WEEKLY_SELL_OUT_ESTIMATION/tree/master/03.Data%20preprocessing%20-%20stage%202#2removing-products-without-obligatory-number-of-observations)
     
* [04.Verification of processed data :](https://github.com/MateoMat/PHARMA_WEEKLY_SELL_OUT_ESTIMATION/tree/master/04.Verification%20of%20processed%20data)  
     
## Final results

