CREATE PROC [FPV_Public].[uspApplicationRequestHandler]
 @RequestIn NVARCHAR(MAX)
,@RowDataCount INT = NULL OUTPUT
AS
BEGIN

DECLARE @RequestID INT
DECLARE @RequestString NVARCHAR(MAX) = N'{}'
DECLARE @RequestValid INT


--TRANSFER INPUT REQUEST STRING TO LOCAL REQUEST STRING TO PREVENT EARLY COMPILATION ERROR 
SELECT @RequestString=@RequestIn
SELECT @RequestString = REPLACE(REPLACE(REPLACE(@RequestString, CHAR(9), ''), CHAR(10), ''), CHAR(13), '') 
IF EXISTS (SELECT 1 WHERE ISJSON(@RequestString)=1)
BEGIN
	--IF VALID JSON
	
	INSERT [FPV].[ApplicationRequest]([Request])
	VALUES (@RequestString)
	SELECT @RequestID=SCOPE_IDENTITY();

	EXEC @RequestValid=[FPV].[uspValidateRequest]@RequestID
	IF (@RequestValid!=1)
	BEGIN
		INSERT [FPV].[ApplicationResponse]([RequestID],[type],[data])
		SELECT	[RequestID],'error', N'{"message":"'+ [RequestValidationComment] +'"}'
		FROM	[FPV].[ApplicationRequest]
		WHERE	[RequestID]=@RequestID
	END
	ELSE
	BEGIN
		--VALID REQUEST
		DECLARE @sql NVARCHAR(255)
		SELECT @sql = 'EXEC ' + D.[ProcName] + ' ' + CAST(@RequestID AS NVARCHAR(10))
		FROM [FPV].[RequestDef] D
		JOIN [FPV].[ApplicationRequest] R ON R.RequestType=D.RequestType AND R.RequestEntity=D.RequestEntity
		WHERE R.RequestID=@RequestID

		BEGIN TRY
		EXECUTE sp_executesql @sql; 
		END TRY
		BEGIN CATCH
		INSERT [FPV].[ApplicationResponse]([RequestID],[type],[data])
		VALUES (@RequestID,'error"', N'{"' + ERROR_MESSAGE() + '"}')
		END CATCH

	END

END
ELSE 
BEGIN
	INSERT [FPV].[ApplicationRequest]([InvalidRequest])
	VALUES (@RequestString);
	SELECT @RequestID=SCOPE_IDENTITY();

	INSERT [FPV].[ApplicationResponse]([RequestID],[type],[data])
	VALUES (@RequestID,'error"', N'{"Invalid JSON string ' + @RequestString + '"}')
END


--formulate response
DECLARE @JSON NVARCHAR(MAX)
SELECT @JSON = (	SELECT	*
					FROM	[FPV].[ApplicationResponse]
					WHERE	[RequestID]=@RequestID
					FOR JSON PATH, INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER)

--FORMAT THE RESPONSE
SELECT @JSON='{"response":' + @JSON + '}'
SELECT @JSON= REPLACE(@JSON,'\"','"')
SELECT @JSON= REPLACE(@JSON,'"[','[')
SELECT @JSON= REPLACE(@JSON,']"',']')
UPDATE [FPV].[ApplicationResponse] SET [Response] = @JSON WHERE [RequestID]=@RequestID

SET @RowDataCount = (SELECT [DataRowcount] FROM [FPV].[ApplicationResponse] WHERE [RequestID]=@RequestID)

--SEND RESPONSE
SELECT [Response],[DataRowcount]
FROM [FPV].[ApplicationResponse]
WHERE [RequestID]=@RequestID

END