USE [FinanceDataMart]
GO

/****** Object:  View [CodaTabular].[FactTM1Planning]    Script Date: 01/05/2018 11:14:22 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


--USE [FinanceDataMart]
--GO

--/****** Object:  View [CodaTabular].[FactTM1Planning]    Script Date: 18/04/2018 10:40:07 ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO


ALTER view	[CodaTabular].[FactTM1Planning] 
as

	SELECT 
	    [CompanyKey]
	  , [DocumentKey]
		  --,tm1.[Company]
		  , TM1CostRevenue
		  , TM1Class
		  , TM1Level4
		  , TM1Level3
		  , TM1Level2
		  , TM1Level1

		  ,AccountKey_EL1 as [AccountEL1Key]
		  --,tm1.[EL1Description]
		  --,tm1.[EL1Code]
		  ,AccountKey_EL2 as [AccountEL2Key]

		  ,[CodaFiscalDate] as DateDt		 
		   , BudgetValue
		  , ForecastQ1Value
		  , ForecastQ2Value
		  , ForecastQ3Value
		  , 0 as ActualValue

	  FROM [CodaWarehouse].[FactTM1Planning]



GO


