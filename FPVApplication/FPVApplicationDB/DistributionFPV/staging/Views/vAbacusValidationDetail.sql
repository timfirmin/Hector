


CREATE VIEW [staging].[vAbacusValidationDetail]
AS  

  SELECT  
		avl.LoadId,
		avl.RuleId,
		vr.[AbacusTableName],
		replace(replace(vr.[RuleUdf],'staging.udf',''),'()','') as RuleSummary,
		vr.AttributeCheckName as ValidationOutcome,
		vd.StationID,
		vd.StationName,
		vd.DistributionGroupCode,
		vd.DistributionGroupCategory,
		vd.UDCCode,
		vd.UDCDescription,
		vd.StationCategory,
		Cast(avl.InsertTimeStamp  as smalldatetime ) as ProcessDate
   FROM staging.AbacusValidationLog avl
	   CROSS APPLY OPENJSON([ValidationData]) WITH (
											[StationID]					varchar(200) '$.StationID',
											[StationName]				varchar(200) '$.StationName',
											[DistributionGroupCode]	    varchar(200) '$.DistributionGroupCode',
											[DistributionGroupCategory]	varchar(200) '$.DistributionGroupCategory',
											[UDCCode]					varchar(200) '$.UDCCode',
											[UDCDescription]			varchar(200) '$.UDCDescription',
											[StationCategory]			varchar(200) '$.StationCategory'
									  ) as vd
		JOIN [Config].[ValidationRules] vr on avl.RuleId = vr.RuleId