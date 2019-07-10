-- Procedure to maitain Station Ids
exec [Config].[spMaintainStationIDBank]
select count(*) AS NoOfUnallocatedIDsBeforeRequest from [Config].[StationID_Bank] where AllocationDate is null

-- Request to allocate Station IDs 
declare @requestid uniqueidentifier
exec [Config].[spStationIDRequestInitialise] 10, 'CRM',@requestid output
select * from Config.udfGetStationIDFromBank(@requestid)

-- Check and count newly allocated Station ID.
select count(*) NoOfIDsAllocated  from [Config].[StationID_Bank] where RequestorID= 'CRM'

-- Check number of unallocated Station IDs are maintained.
select count(*) AS NoOfUnallocatedIDsAfterRequest from [Config].[StationID_Bank] where AllocationDate is null


