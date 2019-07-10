CREATE PROCEDURE [Control].InsertEntityProcessStream
			@EntityId INT
		   ,@LoadProcess VARCHAR(100)
           ,@ProcessStream VARCHAR(100)
           ,@LoadId int
		   ,@LoadStatusType VARCHAR(100)
AS

DECLARE @LoadStatusId int
DECLARE @ProcessStreamId int
DECLARE @LoadProcessId int

SELECT @LoadStatusId = LoadStatusTypeId FROM LoadStatusType WHERE ShortName = @LoadStatusType


INSERT INTO [Control].[EntityProcessStream]
           ([EntityId]
           ,[ProcessStream]
		   ,LoadProcess 
           ,LoadStatusTypeId
           ,[LoadId])
     VALUES
           (@EntityId
           ,@ProcessStream
		    ,@LoadProcess
           ,@LoadStatusId
           ,@LoadId
         )
