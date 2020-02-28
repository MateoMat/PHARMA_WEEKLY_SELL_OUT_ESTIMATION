# 03.Data preprocessing - stage 2

## Verification of products for models that meet's observations sum assumption

### 1.Removing products that do not have external data

**important** If there are products that have weeks without sales in the internal source data, they should also be removed.
The previous scripts have internal data as the primary table for thethe left-join relations, so we prevented it at an earlier stage.

:+1: SQL Script: *03.Data preprocessing - 1.Deleting products without external data* - not available in remote repository

:white_check_mark: After completing the above steps, a table was created **_05_WEEKLY_MODEL_DATA_RAW_1**

### 2.Removing products without obligatory number of observations.

As we assumed in model have to be build on 65 observations. Some products are launching in the mean time, so we have to remove them.

:+1: SQL Script: *03.Data preprocessing - 2.Removing products without obligatory number of observations* - not available in remote repository

:white_check_mark: After completing the above steps, a table was created **_06_WEEKLY_MODEL_DATA_CLEAN**

After analyzing our own sources - finally **104** products have a sufficient number of observations.


:point_left: [Back to main page](https://github.com/MateoMat/PHARMA_WEEKLY_SELL_OUT_ESTIMATION)