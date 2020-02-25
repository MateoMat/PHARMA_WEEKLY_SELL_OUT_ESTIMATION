
 USE STAGE_S4U
 GO

 DECLARE @date  as DATE
 SET @date='2020-02-21';

 WITH CTE AS
	(
		SELECT [apteka]
			  ,[nazwa]
	    FROM [STAGE_S4U].[model022020].[PHARMACIES_PANEL]
  )
  ,CTE2 AS
  (
	SELECT 
		a.*
		,b.SprzedazMax
		,CASE
			WHEN b.SprzedazMax>=@date then 1 
			else 0 
		END as [Check]
	FROM CTE as a
	LEFT JOIN SOFT4U.PSDT_WIDOKI.dbo.synchStanAktualizacji as b on a.apteka=b.apteka
  )
  SELECT 
	CAST(CAST(SUM(a.[Check]) as numeric(10,2))/count(a.apteka) as numeric(10,2))*100 as [PHARMACIES_PANEL_AVAILABILITY]
	FROM CTE2 as a
