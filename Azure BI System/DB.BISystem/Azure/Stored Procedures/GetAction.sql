-- =============================================
-- Author:		Adatis Consulting - SAW
-- Create date: 2016-10-11
-- Description:	Gets Action Details from Automationmatrix about the state of the action performed on the object
-- =============================================
CREATE PROCEDURE [Azure].[GetAction]
	@ObjectName varchar(255),
	@ActionName varchar(255)
AS
BEGIN
	SELECT TOP(1) 
	   [ObjectName]
      ,[ActionName]
      ,[ActionDescription]
      ,[InsertedDate]
      ,[UpdatedDate]
      ,[Result]
      ,[OperationID] 
	FROM [Azure].[AutomationActionLog]
	WHERE ObjectName = @ObjectName
	  AND ActionName = @ActionName
	ORDER BY InsertedDate DESC
END;
