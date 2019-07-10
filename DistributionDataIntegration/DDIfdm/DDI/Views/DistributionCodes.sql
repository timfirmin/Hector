
CREATE view [DDI].[DistributionCodes]
as

with cte_yrs
as
(SELECT TOP (5) DistributionYear = year(getdate())+1 - CONVERT(INT, ROW_NUMBER() OVER (ORDER BY s1.[object_id]))
FROM sys.all_objects AS s1 CROSS JOIN sys.all_objects AS s2)
,cte_Distributions
as
(
select DistributionYear, 'D' + right(cast(DistributionYear as char(4)),2) + '1' as DistributionCode
	, cast('01-01-' + cast(DistributionYear as char(4)) as datetime) as DistributionStartDate , cast('04-15-' + cast(DistributionYear as char(4)) as datetime) as DistributionEndDate from cte_yrs cte
union
select DistributionYear, 'D' + right(cast(DistributionYear as char(4)),2) + '2'
	, cast('04-16-' + cast(DistributionYear as char(4)) as datetime) as DistributionStartDate , cast('07-15-' + cast(DistributionYear as char(4)) as datetime) as DistributionEndDate from cte_yrs cte
union
select DistributionYear, 'D' + right(cast(DistributionYear as char(4)),2) + '3'
	, cast('07-16-' + cast(DistributionYear as char(4)) as datetime) as DistributionStartDate , cast('10-15-' + cast(DistributionYear as char(4)) as datetime) as DistributionEndDate from cte_yrs cte
union
select DistributionYear, 'D' + right(cast(DistributionYear as char(4)),2) + '4'
	, cast('10-16-' + cast(DistributionYear as char(4)) as datetime) as DistributionStartDate , cast('12-31-' + cast(DistributionYear as char(4)) as datetime) as DistributionEndDate from cte_yrs cte
)
select *
,row_number() OVER(ORDER BY DistributionCode ASC) as SortOrder 
,case when getdate() between DistributionStartDate and DistributionEndDate then 1 else 0 end as CurrentDistribution
from cte_Distributions