CREATE VIEW [TM1Control].[BatchLastCalendarArrival]
as

SELECT  TOP 50
      
      cast([PlanningYear] as char(4))+ ' ' + py.[PlanningScenario]   as Scenario
      ,[ScenarioFirstArrivedDate]
	  ,case isnull(datediff(DAY, [ScenarioFirstArrivedDate], getdate()),0) when 1 then 'Y' when 2 then 'Y' when 3 then 'Y'  when 0 then 'X' else 'N' end AlertMe
      ,[ScenarioLastUpdatedDate]
 
  FROM [TM1Control].[PlanningCalendar] py
  JOIN [TM1Control].[PlanningScenario] ps on py.PlanningScenarioKey = ps.PlanningScenarioUniqueKey
  WHERE PlanningYear >= year(getdate())-1 and PlanningYear< year(getdate())+2
  and [PlanningFileType] = 'Revenue' and [PlanningScenarioValidFDM] = 'Y'
  order by 1