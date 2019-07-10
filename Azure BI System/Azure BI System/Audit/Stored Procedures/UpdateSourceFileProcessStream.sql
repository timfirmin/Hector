

CREATE PROCEDURE [Audit].[UpdateSourceFileProcessStream]
			@SourceFileId INT
		   ,@LoadProcess VARCHAR(100)
           ,@ProcessStream VARCHAR(100)
           ,@LoadId int
		   ,@LoadStatusType VARCHAR(100)
AS

DECLARE @LoadStatusId int
DECLARE @ProcessStreamId int
DECLARE @LoadProcessId int

SELECT @LoadStatusId = LoadStatusTypeId FROM Control.LoadStatusType WHERE ShortName = @LoadStatusType

IF EXISTS (SELECT 1 FROM [Audit].[SourceFileProcessStream] WHERE LoadId = @LoadId AND SourceFileId = @SourceFileId)
BEGIN 
UPDATE [Audit].[SourceFileProcessStream]
   SET 
      [LoadStatusTypeId] = @LoadStatusId
 WHERE LoadId = @LoadId AND SourceFileId = @SourceFileId
END 
ELSE 
BEGIN  
INSERT INTO [Audit].[SourceFileProcessStream]
           ([SourceFileId]
           ,[ProcessStream]
		   ,LoadProcess 
           ,LoadStatusTypeId
           ,[LoadId])
     VALUES
           (@SourceFileId
           ,@ProcessStream
		   ,@LoadProcess
           ,@LoadStatusId
           ,@LoadId
         )
END


IF @ProcessStream = 'SRC2STG' AND  @LoadStatusType = 'Success'
BEGIN
	UPDATE Control.SourceFile
	SET	StageDate = GETDATE()
	WHERE SourceFileId = @SourceFileId
END

IF @ProcessStream = 'SCR2CLN'  AND  @LoadStatusType = 'Success'
BEGIN
	UPDATE Control.SourceFile
	SET	CleanDate = GETDATE()
	WHERE SourceFileId = @SourceFileId
END



IF @ProcessStream = 'LDS2CDW'  AND  @LoadStatusType = 'Success'
BEGIN
	UPDATE Control.SourceFile
	SET	WarehouseDate = GETDATE()
	WHERE SourceFileId = @SourceFileId
END
