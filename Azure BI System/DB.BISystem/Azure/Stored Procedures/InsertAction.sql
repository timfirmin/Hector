-- =============================================
-- Author:		Adatis Consulting - SAW
-- Create date: 2016-05-03
-- Description:	Inserts Action state to AutomationActionLog about the state of the action performed on the object
-- =============================================

CREATE PROCEDURE [Azure].[InsertAction]
	@ObjectName VARCHAR(255),
	@ActionName VARCHAR(255),
	@ActionDescription VARCHAR(Max),
	@Result	INT,
	@OperationId UNIQUEIDENTIFIER
AS
BEGIN
	INSERT INTO [Azure].[AutomationActionLog]
		(ObjectName,ActionName, ActionDescription, InsertedDate, Result, OperationID)
	VALUES
		(@ObjectName, @ActionName, @ActionDescription, SYSDATETIME(), @Result, @OperationId);
END;
