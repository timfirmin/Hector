-- =============================================
-- Author:		Adatis Consulting - SAW
-- Create date: 2016-10-12
-- Description:	Updates Action in AutomationActionLog about the state of the action performed on the object
-- =============================================

CREATE PROCEDURE [Azure].[UpdateAction]
	@ObjectName VARCHAR(255),
	@ActionName VARCHAR(255),
	@Result	INT
AS
BEGIN
	DECLARE @LastActionId INT = (SELECT TOP(1) ActionId 
								FROM [Azure].[AutomationActionLog]
								WHERE ObjectName = @ObjectName
								  AND ActionName = @ActionName
								  AND UpdatedDate IS NULL
								ORDER BY InsertedDate DESC);

	UPDATE [Azure].[AutomationActionLog] SET	
		UpdatedDate = SYSDATETIME(),
		Result = @Result
	WHERE ObjectName = @ObjectName
	  AND ActionName = @ActionName
	  AND ActionId = @LastActionId
END;
