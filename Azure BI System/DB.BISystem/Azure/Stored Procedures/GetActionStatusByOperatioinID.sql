-- =============================================
-- Author:		Adatis Consulting - SAW
-- Create date: 2016-10-11
-- Description:	Gets Action Details from Automation Action Log Table about the state of the action (identified by OperationID) performed on the object
-- =============================================
CREATE PROCEDURE [Azure].[GetActionStatusByOperatioinID]
	@OperationID uniqueidentifier,
	@ActionStatus int OUT
AS
BEGIN
/* @uOperationID has been used as a middle parameter as SSIS had problems with conversion from varchar to GUID/uniqueidentifier */
DECLARE @ActionStatusTemp INT = (SELECT TOP(1) [Result]
								 FROM [Azure].[AutomationActionLog]
								 WHERE ISNULL(OperationID,NEWID()) = @OperationID
								 ORDER BY InsertedDate DESC)

	SET @ActionStatus = ISNULL(@ActionStatusTemp ,-1)
END;
