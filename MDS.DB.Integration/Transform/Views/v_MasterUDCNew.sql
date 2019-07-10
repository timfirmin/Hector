






CREATE VIEW [Transform].[v_MasterUDCNew]
AS

SELECT DISTINCT 
	   [UDCCode]
      ,[UDCDescription]
      ,cast(isnull(nullif(replace([UDCInactiveDate],'4000','1900'),''),'')  as datetime) as [UDCInactiveDate]
	  ,[LoadId]   
  FROM [Transform].[MasterUDCAlerts]
  where [DeltaAction] in ('Insert', 'Update') and  [MDSSyncActionedLoadId] is null
  UNION 
  SELECT DISTINCT 
	   [UDCCode]
      ,isnull([MDSUDCDescription],UDCDescription) as [MDSUDCDescription]
	  ,cast(isnull(replace([UDCInactiveDate],'Jan  1 1900 12:00AM',GETDATE()),getdate()) as datetime) as [UDCInactiveDate]
      ,[LoadId]
  FROM [Transform].[MasterUDCAlerts]
  --just Persist on dates, alert on Descr Change
  WHERE [DeltaAction] = 'Delete'  and  [MDSSyncActionedLoadId] is null --and [UDCDescription] = [MDSUDCDescription]