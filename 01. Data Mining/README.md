# Data source overview

#### Description of data providers:
* INTERNAL - data collecting from the customers by the external provider from clients sales system, it downloads data about the contracted products such as status, purchase, sale to the customer, and push them to central database

* EXTERNAL - data receiving from the external company


#### Description of data :
* MONTHLY_EXTERNAL_SELL_OUT - table contains monthly product sales units to the customers at national level. Data are the result of estimation based on a sample of 45% of customers in Poland.
* WEEKLY_EXTERNAL_SELL_OUT - Table contains weekly product sales units to customers at national level. Data are the result of estimation based on a sample of 45% of customers in Poland.

* WEEKLY_INTERNAL_SELL_OUT - table contains information about the sum of sales units to the customer collected from sales points in the S4U system. Aggregation for weeks. Source data transformed, which are described in aaaa. 

* MONTHLY_INTERNAL_SELL_OUT - table contains information about the sum of sales units to the customer collected from sales points in the S4U system. Aggregation for months. Source data transformed, which are described in aaaa.