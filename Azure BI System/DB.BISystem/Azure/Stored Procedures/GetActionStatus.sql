-- =============================================
-- Author:		Adatis Consulting - SAW
-- Create date: 2016-10-11
-- Description:	Gets Action Details from Automationmatrix about the state of the action performed on the object
-- =============================================
CREATE PROCEDURE [Azure].[GetActionStatus]
	@ObjectName varchar(255),
	@ActionName varchar(255),
	@ActionStatus int OUT
AS
BEGIN
DECLARE @ActionStatusTemp INT = (SELECT TOP(1) [Result]
								 FROM [Azure].[AutomationActionLog]
								 WHERE ObjectName = @ObjectName
								   AND ActionName = @ActionName
								 ORDER BY InsertedDate DESC)

	SET @ActionStatus = ISNULL(@ActionStatusTemp ,-1)
END;
