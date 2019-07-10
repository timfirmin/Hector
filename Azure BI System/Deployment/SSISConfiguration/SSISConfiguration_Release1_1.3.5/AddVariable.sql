
CREATE PROCEDURE Config.AddVariable
( 
 -- Add the parameters for the function here
 @VariableValue Varchar(50),
 @Default Varchar(10) = NULL
)
AS
BEGIN

	DECLARE @Max_id INT

	IF @Default IS NULL 
	BEGIN
		IF EXISTS(SELECT 1 FROM [Config].[Variable] WHERE [Name] = 'SSISEnvironment' AND [Value] = @VariableValue)  
		BEGIN 
			RETURN 
		END 
		ELSE
		BEGIN
			
			SELECT @Max_id = ISNULL(MAX(VariableId),0) FROM [Config].[Variable]

			INSERT INTO [Config].[Variable]( [VariableId] ,[Name] ,[Value] ,[Type] )
			VALUES ( @Max_id + 1 ,'SSISEnvironment' ,@VariableValue ,'Environment Variable' )
		END
	END
	ELSE
	BEGIN
		IF EXISTS(SELECT 1 FROM [Config].[Variable] WHERE [Name] = 'SSISEnvironmentDefault' AND [Value] = @VariableValue)  
		BEGIN 
			RETURN 
		END 
		ELSE
		BEGIN
	
			SELECT @Max_id = ISNULL(MAX(VariableId),0) FROM [Config].[Variable]

			INSERT INTO [Config].[Variable]( [VariableId] ,[Name] ,[Value] ,[Type] )
			VALUES ( @Max_id + 1 ,'SSISEnvironmentDefault' ,@VariableValue ,'Environment Variable' )
		END
	END
END
