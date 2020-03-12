# Data source overview

#### Description of data providers:
* INTERNAL - data collecting from the customers by the external provider from clients sales system, it downloads data about the contracted products such as status, purchase, sale to the customer, and push them to central database

* EXTERNAL - data receiving from the external company


#### Description of data :
* MONTHLY_EXTERNAL_SELL_OUT - table contains monthly product sales units to the customers at national level. Data are the result of estimation based on a sample of 45% of customers in Poland.
* WEEKLY_EXTERNAL_SELL_OUT - Table contains weekly product sales units to customers at national level. Data are the result of estimation based on a sample of 45% of customers in Poland.

* WEEKLY_INTERNAL_SELL_OUT - table contains information about the sum of sales units to the customer collected from sales points in the S4U system. Aggregation for weeks. Source data transformed, which are described in aaaa. 

* MONTHLY_INTERNAL_SELL_OUT - table contains information about the sum of sales units to the customer collected from sales points in the S4U system. Aggregation for months. Source data transformed (details in aaa).

# Model assumptions:
* ISO 8601 leap week calendar system
* Data date scope : 2018-08-27 - 2019-12-29
* Observation consists of sum of unit sales from all clients aggregated to weeks
* The number of all observations available for weekly data - 70
    * training set - 56 observations
    * test set - 14 observations
* Monthly accuracy will be compared on validation set consist:
    * validation external monthly set - 15 
    * based on model monthly prediction - 15
    
* The number of all observations available for monthly data data - 16
    
# Internal Data description & conclusions:

Data comes from customer transactional systems. Understanding database rules and changes to identifiers is an extremely important element.

The assumption that individual customer IDs are permanent should be rejected.
The only common feature describing a single point of sale is the address, however, there are duplicates too.

An important element in the selection of clients for the research panel is:
  
* obligatory value 1 in the 'Active' field of the source customer dimension table (dbo.stanSynchronizacji)
* examine the availability of data during the period considered.
  

* To maintain the usefulness of the model in the long term - an important element of customer selection is verified internal knowledge about maintaining reporting continuity. 
    * Based on this analysis, **82** were rejected from the database

* The data shows a delay in synchronizing some clients to the database. As recommended by the software owner, the data achieve high convergence within +3 business days from the end of the analyzed period.
    
    
* On the day the clients were defined, **1938** unique clients entered the research panel.


 :+1: SQL Script: *01.Data Mining - 1.Creating table _01_PHARMACIES_PANEL* - not available in remote repository
 
 :white_check_mark: After completing the above steps, a table was created **_01_PHARMACIES_PANEL**


* ***content available only in local repository*** -  In order to verify the current data scope availability for pharmacies, a sql script was created in the panel: model_Panel_Chek.sql

:point_left: [Back to main page](https://github.com/MateoMat/PHARMA_WEEKLY_SELL_OUT_ESTIMATION#scope-of-work)





