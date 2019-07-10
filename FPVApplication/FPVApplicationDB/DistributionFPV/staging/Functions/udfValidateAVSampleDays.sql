create FUNCTION [staging].[udfValidateAVSampleDays] ()

RETURNS TABLE 
AS
RETURN 
(
select	s.[Code][StationID]
		,dg.DistributionGroupCode
		,replace(replace(left(s.[Name],100),'[',''),']','')[StationName]
	    ,1 as InvalidSampleDaysAV
		--,isnull(s.CommercialSampleDays,0)[CommercialSampleDays]
		--,isnull(s.NonCommercialSampleDays,0)[NonCommercialSampleDays]

from	[staging].[MasterStation] s
 
join [FPV].[DistributionGroup] dg on s.DistributionGroup = dg.DistributionGroupCode
where dg.Enabled = 1 and not (s.ExcludeFromFPV = 'No') and isnull(s.[LicencedStatus],'U')	<> 'Ceased'
and dg.DistributionGroupCode = 'AV'
and 	isnull(s.CommercialSampleDays,0) <> isnull(s.NonCommercialSampleDays,0)
)