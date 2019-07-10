CREATE FUNCTION [Config].[udfGetStationIDFromBank] (@RequestID UNIQUEIDENTIFIER)
RETURNS TABLE
AS
RETURN
(
	SELECT StationId FROM [Config].StationID_Bank WHERE RequestID=@RequestID
)
