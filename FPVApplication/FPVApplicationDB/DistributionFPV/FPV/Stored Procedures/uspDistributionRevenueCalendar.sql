

 --------------------------------------------------------------------------
--Created By : Tim Firmin 2018JUN11 ~ FPV Hector 2 Application Project
--Self Contained RevenueCalendar Date  builder - joins startard calendar to distribution metadata
--Last Change : Tim Firmin 2018JUN12 - Output Parameter changed to @pInsertedRowCount
--Test: EXEC FPV.[uspDistributionRevenueCalendar] @pLoadId = 321, @pInsertedRowCount = 0
 --------------------------------------------------------------------------
CREATE PROCEDURE [FPV].[uspDistributionRevenueCalendar]
  @pLoadId			int,
  @pInsertedRowCount	bigint OUT
AS
BEGIN
	DECLARE @pStartDate as datetime = '2013-12-31 00:00:00.000'
    DECLARE @pEndDate as datetime = '2019-12-31 00:00:00.000'
  
   IF OBJECT_ID('FPV.DistributionRevenueCalendar') IS NOT NULL
	  DROP TABLE FPV.DistributionRevenueCalendar;

	  SET @pEndDate = cast(cast(year(getdate()) + 3 as char(4)) + '-12-31 00:00:00.000' as datetime);

      WITH Pass0 AS (SELECT 1 AS C UNION all SELECT 1),			--2 rows
		 Pass1 AS (SELECT 1 AS C FROM Pass0 AS A, Pass0 AS B),	--4 rows
		 Pass2 AS (SELECT 1 AS C FROM Pass1 AS A, Pass1 AS B),	--16 rows
		 Pass3 AS (SELECT 1 AS C FROM Pass2 AS A, Pass2 AS B),	--256 rows
		 Pass4 AS (SELECT 1 AS C FROM Pass3 AS A, Pass3 AS B),	--65536 rows
		 Tally AS (SELECT row_number() over(order by C) AS Number FROM Pass4)
		
		 SELECT Number,[Date] = dateadd(Day, Number - 1, @pStartDate) 
		   INTO #tempdates
		   FROM Tally
		  WHERE dateadd(Day, Number - 1, @pStartDate) <= @pEndDate;

	 SELECT
	 GCSE.DistributionGroup	,
	 GCSE.DistributionCode,	
	 CONCAT(GCSE.LicensingStartPeriod,'-',GCSE.LicensingStartYear	) as 	LicensingRevenuePeriodStart,
	 CONCAT(GCSE.LicensingEndPeriod,'-',GCSE.LicensingEndYear	) 	  as 	LicensingRevenuePeriodEnd,
		CAST(CONVERT(VARCHAR,ttd.[Date],112) AS INT) as DateKey,								--Key					# 20160210
		ttd.[Date] as CalendarDate,																	--Calendar Date			# 10/02/2016
		DATEPART(YEAR, ttd.[Date]) as CalendarYear,													--Calendar Year			# 2016
		CASE 
		  WHEN DATEPART(MONTH , ttd.[Date]) < 10 THEN
		    CONCAT(DATEPART(YEAR, ttd.[Date]),'-0', DATEPART(MONTH , ttd.[Date]))
		  ELSE
		    CONCAT(DATEPART(YEAR, ttd.[Date]),'-' , DATEPART(MONTH , ttd.[Date]))
		END as CalendarYearMonth,																		--CalendarYearMonth		# 2016-02
		DATEPART(MONTH , ttd.[Date]) as CalendarMonth,												--CalendarMonth			# 2
		CONCAT(DATEPART(YEAR, ttd.[Date]),'-Q',DATEPART(QUARTER, ttd.[Date])) as CalendarYearQuarter,		--CalendarYearQuarter	# 2016-Q1
		DATEPART(QUARTER, ttd.[Date]) as CalendarQuarter,												--CalendarQuarter		# 1
		--LEFT(DATENAME(Month,ttd.[Date]),3) as ShortMonthNameOfYear,											--ShortMonthNameOfYear	# Feb
		DATENAME(Month,ttd.[Date]) as MonthYearName,													--MonthYearName			# February
		DATENAME(Weekday,ttd.[Date]) as DayNameOfWeek,												--DayNameOfWeek			# Wednesday
		--LEFT(CONVERT(VARCHAR,DATENAME(Weekday,[Date])),3) as ShortDayNameOfWeek,							--ShortDayNameOfWeek	# Wed
		DATEPART (DW , ttd.[Date]) as [DayOfWeek],													--DayOfWeek				# 3
		DATEPART (DAY, ttd.[Date]) as [DayOfMonth],													--DayOfMonth			# 10
		DATEPART (DY , ttd.[Date]) as DayOfYear,													--DayOfYear				# 41
		@pLoadId as InsertLoadId,
		--0 as UpdateLoadId,
		SYSDATETIME() as InsertTimestamp
		--,'1900-01-01 00:00:00.000' as UpdateTimestamp
	  INTO FPV.DistributionRevenueCalendar
	  FROM #tempdates AS ttd
	  
	  JOIN [staging].[vDistributionGroupCodeStartEnd] GCSE
	  ON (ttd.[Date] >= GCSE.LicensingStartDate AND ttd.[Date] <= GCSE.LicensingEndDate)
	  --AND GCSE.DistributionGroup = 'ILR' AND GCSE.DistributionCode = 'D181'

	    /* Return the Insert row count */
 SET @pInsertedRowCount = @@ROWCOUNT

  DROP TABLE #tempdates;

END