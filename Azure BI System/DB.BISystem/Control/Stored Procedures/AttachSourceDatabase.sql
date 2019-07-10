
CREATE PROCEDURE [Control].[AttachSourceDatabase]
	@NewDatabaseName NVARCHAR(128),
	@DataFile NVARCHAR(1000), 
	@LogFile NVARCHAR(1000) = NULL, 
	@QueueTaskId int
AS
BEGIN
	
	SET NOCOUNT ON;

	DECLARE	@return_value int
	DECLARE @AttachStatement NVARCHAR(MAX)
    
	SET @AttachStatement = N'CREATE DATABASE SourceData_'+ @NewDatabaseName+' ON (FILENAME = ''' + @DataFile + ''')' 

	IF @LogFile IS NOT NULL 
	BEGIN 
		SET @AttachStatement = @AttachStatement + ',(FILENAME = ''' + @LogFile + ''')' 
	END 

	SET @AttachStatement = @AttachStatement + 'FOR ATTACH;'

	CREATE TABLE #ErrFile (ExecError INT, ErrorMessage NVARCHAR(4000))
	DECLARE @ExecError INT
	DECLARE @ExecErrorMessage VARCHAR(4000)

		SET @AttachStatement =  @AttachStatement + 'INSERT #ErrFile VALUES(@@ERROR, ERROR_MESSAGE())'
		EXEC (@AttachStatement)
	    SELECT 
			@ExecError = ExecError,  
			@ExecErrorMessage = ErrorMessage 
		FROM 
			#ErrFile
		IF @ExecError <> 0 
		RAISERROR (@ExecErrorMessage, 16,1,4,@ExecError)

END
