CREATE PROCEDURE [Audit].[ObtainLatestLoadDate] 

AS

-- =============================================
-- Author:		Adatis Consulting
-- Create date: Unknown
-- =============================================

	--Note this will need altering if the S2W spans multiple days, e.g. over midnight
	SELECT	CAST(MAX(StartTime) AS DATE) AS StartTime 
	FROM	Audit.PackageLoad
	-- WHERE ExecutionId > 0  -- This line was uncommented in the original DQ BISystem version -- VBA
