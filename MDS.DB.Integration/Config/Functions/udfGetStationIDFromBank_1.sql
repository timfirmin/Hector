

CREATE FUNCTION [Config].[udfGetStationIDFromBank] (@RequestID UNIQUEIDENTIFIER)
RETURNS TABLE
AS
RETURN
(
	SELECT StationID FROM [Config].Stationid_Bank WHERE RequestID=@RequestID
)