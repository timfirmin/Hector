

CREATE  view [FPV].[vResponseCalcGroupFilters]
as
SELECT  [RequestID]
		,json_value(replace(replace(res.[data],'[',''),']',''),'$.DistributionGroupCode')[DistributionGroupCode]
		,json_value(replace(replace(res.[data],'[',''),']',''),'$.DistributionCode')[DistributionCode]
		,json_value(replace(replace(res.[data],'[',''),']',''),'$.Society')[Society]
 
FROM [FPV].[ApplicationResponse] res 
where exists 
(select null from [FPV].[ApplicationRequest] req where res.RequestID = req.RequestID and req.RequestEntity = 'CALCULATIONGROUP' and req.RequestType='GET') 
 and
ISJSON(Response) > 0