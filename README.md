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

The goal is to build a ML model for predicting national weekly data for each SKU (Stock Keeping Unit) from internal source, which the sum of this predeicted values meets min. 97% accuracy compared to external monthly data.

This project describes the methodology and procedure for one SKU whose actual name has been blinded.

## Data overview:
The effect of data mining analysis and assumptions is described in [01.Data Mining](https://github.com/MateoMat/PHARMA_WEEKLY_SELL_OUT_ESTIMATION/tree/master/01.Data%20Mining) folder.

## Dependencies
* python 3.7
* pandas
* numpy
* matplotlib
* scikit-learn

## Action plan
After data cleaning and features enginearing build a several ensembling models using the best simple classifiers of each type.
## Scope of work
* [01.Data mining :](https://github.com/MateoMat/PHARMA_WEEKLY_SELL_OUT_ESTIMATION/tree/master/01.Data%20Mining)
    * Data source overview
    * Model assumptions
    * Internal Data description & conclusions
* [02.Data preprocessing - stage 1 :](https://github.com/MateoMat/PHARMA_WEEKLY_SELL_OUT_ESTIMATION/tree/master/02.Data%20preprocessing%20-%20stage%201)
    * 0.Cleaning product dimension
    * 1.Creating table with raw aggregated data for weekly model
    * 2.Cleaning and transforming
    * 3.Joining External to Internal Data
* [03.Data preprocessing - stage 2 :](https://github.com/MateoMat/PHARMA_WEEKLY_SELL_OUT_ESTIMATION/tree/master/03.Data%20preprocessing%20-%20stage%202)
    
    Verification and qualification of products for models
    * 1.Removing products that do not have external data
    * 2.Removing products without obligatory number of observations.
     
     
     
## Final results

