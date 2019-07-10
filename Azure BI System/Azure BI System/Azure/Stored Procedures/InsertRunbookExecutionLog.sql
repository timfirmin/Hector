CREATE PROCEDURE Azure.InsertRunbookExecutionLog
	@Name VARCHAR(255),
	@Status smallint
AS
BEGIN
	INSERT INTO Azure.RunbookExecutionLog
		([Name],[Status],[CreatedAt])
	VALUES
		(@Name,@Status,SYSDATETIME())
END
GO

