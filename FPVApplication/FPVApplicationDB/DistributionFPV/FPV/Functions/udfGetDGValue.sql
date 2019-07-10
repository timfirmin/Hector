
CREATE FUNCTION [FPV].[udfGetDGValue]
--=============================================
-- TJF 2019MAY02 Return Distribution Group Value 
-- Test : SELECT FPV.udfGetDGValue('DefaultBroadcastHours', 'AV')
-- =============================================
(   
 @inField nvarchar(500),
 @inDistributionGroup nvarchar(10)
)
RETURNS nvarchar(500)
AS

BEGIN

DECLARE @ReturnValue nvarchar(500)
 
--[HighPeakTimeBandFactor]
IF @inField = 'HighPeakTimeBandFactor' 
	BEGIN
		SET @ReturnValue = (select HighPeakTimeBandFactor as ReturnValue from [FPV].[DistributionGroup] where [DistributionGroupCode] = @inDistributionGroup)
	END

--[LowPeakTimeBandFactor]
IF @inField = 'LowPeakTimeBandFactor' 
	BEGIN
		SET @ReturnValue = (select LowPeakTimeBandFactor as ReturnValue from [FPV].[DistributionGroup] where [DistributionGroupCode] = @inDistributionGroup)
	END

--[NonPeakTimeBandFactor]
IF @inField = 'NonPeakTimeBandFactor' 
	BEGIN
		SET @ReturnValue = (select NonPeakTimeBandFactor as ReturnValue from [FPV].[DistributionGroup] where [DistributionGroupCode] = @inDistributionGroup)
	END

--[DefaultStationAdminRate]
IF @inField = 'DefaultStationAdminRate' 
	BEGIN
		SET @ReturnValue = (select DefaultStationAdminRate as ReturnValue from [FPV].[DistributionGroup] where [DistributionGroupCode] = @inDistributionGroup)
	END

--[DefaultPRAdminRate]
IF @inField = 'DefaultPRAdminRate' 
	BEGIN
		SET @ReturnValue = (select DefaultPRAdminRate as ReturnValue from [FPV].[DistributionGroup] where [DistributionGroupCode] = @inDistributionGroup)
	END

--[DefaultPRSHedgedRate]
IF @inField = 'DefaultPRSHedgedRate' 
	BEGIN
		SET @ReturnValue = (select DefaultPRSHedgedRate as ReturnValue from [FPV].[DistributionGroup] where [DistributionGroupCode] = @inDistributionGroup)
	END

--[DefaultMCPSHedgedRate]
IF @inField = 'DefaultMCPSHedgedRate' 
	BEGIN
		SET @ReturnValue = (select DefaultMCPSHedgedRate as ReturnValue from [FPV].[DistributionGroup] where [DistributionGroupCode] = @inDistributionGroup)
	END

--[DefaultBroadcastHours]
IF @inField = 'DefaultBroadcastHours' 
	BEGIN
		SET @ReturnValue = (select DefaultBroadcastHours as ReturnValue from [FPV].[DistributionGroup] where [DistributionGroupCode] = @inDistributionGroup)
	END

RETURN @ReturnValue

END