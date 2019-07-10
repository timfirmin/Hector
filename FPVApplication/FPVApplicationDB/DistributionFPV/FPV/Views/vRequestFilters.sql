
CREATE view [FPV].[vRequestFilters]
as
SELECT [RequestID]
		,json_value([RequestFilters],'$.DistributionGroupCode')[DistributionGroupCode]
		,json_value([RequestFilters],'$.DistributionCode')[DistributionCode]
		,json_value([RequestFilters],'$.Society')[Society]
		,json_value([RequestFilters],'$.StationID')[StationID]
		,json_value([RequestFilters],'$.CodaCustomerCode')[CodaCustomerCode]
		,json_value([RequestFilters],'$.FPVStatus')[FPVStatus]
		,json_value([RequestFilters],'$.Enabled')[Enabled]
		,json_value([RequestFilters],'$.TemporalView')[TemporalView]
		,json_value([RequestFilters],'$.CalculationGroupStatus')[CalculationGroupStatus]
		,json_value([RequestFilters],'$.UsageType')[UsageType]
		,json_value([RequestFilters],'$.RefDataCategory')[RefDataCategory]
		,json_value([RequestFilters],'$.RefDataGroup')[RefDataGroup]
		,json_value([RequestFilters],'$.RefDataName')[RefDataName]
		,json_value([RequestFilters],'$.WithDelete')[WithDelete]
		,json_value([RequestFilters],'$.UpdatedBy')[UpdatedBy]
		,json_value([RequestFilters],'$.UpdateComment')[UpdateComment]
FROM [FPV].[ApplicationRequest]
GO

