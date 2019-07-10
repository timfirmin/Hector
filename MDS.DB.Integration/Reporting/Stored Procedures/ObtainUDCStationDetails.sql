CREATE PROCEDURE [Reporting].[ObtainUDCStationDetails]
	@LoadId bigint,
	@Action varchar(20),
	@MDSEntityChange varchar(50)
AS

SELECT Headline, Code, Descr, DeltaAction, DeltaMessage, ChangeDetail_REP, ChangeDetail_MDS, MDSSyncActionedTimeStamp, MDSSyncActionedLoadId
FROM
(
	SELECT 
	'Master UDC Change' as Headline
	,[UDCCode] as Code
	,UDCDescription as Descr
	,[DeltaAction]
	,[DeltaMessage]
	,case [DeltaAction] 
		when 'Update' then UDCDescription + ' [' + cast( [UDCInactiveDate] as varchar(20)) + ']. MDS is ' + MDSUDCDescription  + ' [' + cast( [MDSUDCInactiveDate] as varchar(20)) + + ']. ' 
		when 'Delete' then 'InactiveDate Updated to : ' + isnull(convert(varchar(10),UDCInactiveDate ,103),getdate()) 
		when 'Insert' then 'UDC ' + UDCCode + ' [' + UDCDescription + '] Added to MDS'
	 end as ChangeDetail_REP

	,case [DeltaAction] 
		when 'Update' then  MDSUDCDescription  + ' [' + isnull(cast( [MDSUDCInactiveDate] as varchar(20)),'[Null]') + ']. ' 
		when 'Delete' then ''
		when 'Insert' then ''
	 end as ChangeDetail_MDS

	,[MDSSyncActionedTimeStamp]
	,[MDSSyncActionedLoadId]
	  FROM [Transform].[MasterUDCAlerts]
	  WHERE not (DeltaAction = 'Update' and  UDCDescription <>  MDSUDCDescription)
	  AND [LoadId]        = @LoadId  
	  and ([DeltaAction] = @Action  OR @Action  = '<All>')

	UNION


	SELECT 
	'Station-UDC Mapping Change' as Headline
	,BroadcasterUDCCode as Code
	,[UDCDescription] + ' / ' + [StationName] as Descr
	,[DeltaAction]
	,[DeltaMessage]
	,case [DeltaAction] 
	when 'Update' then 'TimeBand/UsedForPurpose = ' + UDCTimeBand + '/' + UDCUsedForPurposeDescription  
	when 'Delete' then 'Mapping Status Flag Set to No'
	when 'Insert' then 'UDC ' + BroadcasterUDCCode + ' Added to MDS Mapping'
	end as ChangeDetail_REP
	,case [DeltaAction] 
	when 'Update' then 'TimeBand/UsedForPurpose = ' + isnull(MDSTimeBand,'[Null]') + '/' + isnull(MDSUsedForPurposeDescription,'[Null]') 
	when 'Delete' then ''
	when 'Insert' then ''
	end as ChangeDetail_MDS
		
		   ,[MDSSyncActionedTimeStamp]
		  ,[MDSSyncActionedLoadId]
	  FROM [Transform].BroadcasterUDCAlerts
	  WHERE not (DeltaAction = 'Update' and  UDCTimeBand <>  MDSTimeBand and UDCUsedForPurposeDescription <> MDSUsedForPurposeDescription)
		 AND [LoadId]        = @LoadId  
	  and ([DeltaAction]              = @Action  OR @Action  = '<All>')
) A
WHERE Headline = @MDSEntityChange OR @MDSEntityChange = '<All>'
GO

