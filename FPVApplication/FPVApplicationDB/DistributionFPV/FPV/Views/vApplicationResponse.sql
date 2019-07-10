
CREATE VIEW [FPV].[vApplicationResponse]
AS
SELECT	COALESCE([RequestID],[InvalidRequestID])[RequestID]
		,[type]
		,[data]
FROM	[FPV].[ApplicationResponse]