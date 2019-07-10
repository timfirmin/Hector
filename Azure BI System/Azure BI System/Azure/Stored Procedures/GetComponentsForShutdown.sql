CREATE PROCEDURE [Azure].[GetComponentsForShutdown]
	@Date DATE
AS
BEGIN
	SELECT DISTINCT
		c.ComponentTag
	FROM Control.SourceFile sf
		JOIN [Azure].[Process] p				ON p.ApplicationId = sf.ApplicationId
		JOIN [Control].[Application] a			ON a.ApplicationId = sf.ApplicationId
		JOIN [Azure].[ProcessScheduleLog] ps	ON ps.ProcessId = p.ProcessId
		JOIN [Azure].[ProcessComponent] pc		ON pc.ProcessId = p.ProcessId
		JOIN [Azure].[Component] c				ON c.ComponentId = pc.ComponentId
	WHERE ps.Date = @Date
	  AND ps.Status = 2
	  AND sf.ApplicationId NOT IN (SELECT ApplicationId FROM Azure.vwSourceFileInProgress)
	  AND a.Code IN ('FDM','DEOS','BRDPTP'); --Temporarly limits to three application only (To be removed when vwSourceFileInProgress updated for all application)
END;  