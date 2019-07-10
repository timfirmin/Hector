CREATE PROC [Control].[NotificationSave]
              @PackageLoadID             INT,
              @FeedName                  NVARCHAR(256) ,
              @Stage                     NVARCHAR(200) ,
              @LoadStatusType			 VARCHAR(20),
              @ErrorCode                 NVARCHAR(128),
              @ErrorDescription			 NVARCHAR(MAX) , 
              @systemExecutionInstanceGuid      NVARCHAR(100) ,            
              @SystemUserName            NVARCHAR(128),
			  @FeedStartTime			 DATETIME,
              @NotificationProcessTypeId INT
AS 
BEGIN 
       DECLARE @ShortDescription NVARCHAR(250) 
       DECLARE @Description NVARCHAR(MAX) 
       DECLARE @VerboseDescription NVARCHAR(MAX) 
       DECLARE @NotificationTypeID INT
       DECLARE @NotificationSeverityId INT
       DECLARE @NotificationStatusId INT    
       DECLARE @TimeOfCompletion DATETIME 
       DECLARE @RetryOnFailure INT       
       DECLARE @EntityName NVARCHAR(50)

       DECLARE @ProcessTypeID INT

       SET @NotificationTypeID = 10                    -- EMAIL
       SELECT @NotificationStatusId      = NotificationStatusId FROM [Control].[NotificationStatus] WHERE Name = 'New'                       -- NEW NOTIFICATION
       
       IF @LoadStatusType = 0 -- IN ERROR CASE
       BEGIN
			  SET @LoadStatusType ='Failed'
              SET @ShortDescription = 'Feed ' + @FeedName + ' uploaded by ' + @SystemUserName + ' Failed on '  + @Stage 
              SELECT @NotificationSeverityId = NotificationSeverityId FROM Control.NotificationSeverity where Name = 'High Priority' 
              SET @Description = NULL
									
									 IF (@ErrorDescription = NULL) OR (LEN(RTRIM(LTRIM(@ErrorDescription))) = 0) 	--IF ERROR DESCRIPTION HAS NULL VALUE THAN SET THE CUSTOM MESSAGE 
										BEGIN
											SET @VerboseDescription =' Package Failed due to more than one reason '      
										END
									 ELSE								--WHATEVER THE FAILURE REASON IS SHOW THE ERROR DETAILS
										BEGIN
											SET @VerboseDescription = @ErrorDescription      
										END			   
       END
       ELSE
       BEGIN
			  SET @LoadStatusType ='Succeeded'
              SET @ShortDescription='Feed ' + @FeedName + ' uploaded by ' + @SystemUserName + ' succeeded on '  + @Stage
              SELECT @NotificationSeverityId = NotificationSeverityId FROM Control.NotificationSeverity where Name = 'Normal Priority' 
              SET @Description = NULL
              SET @VerboseDescription = ' ' + @ErrorDescription + ' '
       END    

       IF @NotificationProcessTypeId = 1        -- PROCESS TYPE
       BEGIN
              SET @ProcessTypeID = 1
       END 
       ELSE IF @NotificationProcessTypeId = 2
       BEGIN
              SET @ProcessTypeID = 2
       END 

       DECLARE @ExistCheck INT
       SET @ExistCheck = 0


       SELECT @ExistCheck = COUNT([ExecutionInstanceGuid]) FROM [Control].[Notification] WHERE  [LoadId] = @PackageLoadID

       IF @ExistCheck = 0
       BEGIN
              --print 'insert option'
              INSERT INTO [Control].Notification
              (
                     [NotificationTypeId]
                     ,[ExecutionInstanceGuid]
                     ,[LoadId]
                     ,[ShortDescription]
                     ,[Description]
					 ,[ErrorCode]
                     ,[VerboseDescription]
                     ,[NotificationSeverityId]
                     ,[NotificationStatusId]
                     ,NotificationProcessTypeId
					,[LoadStatusType]
                     ,[FeedName]
                     ,[Stage]
                     ,[EntityName]
                     ,[SourceFileName]
                     ,[SuccessRows]
                     ,[FailedRows]
                     ,[BadRows]
					 ,[FeedStartTime]
                     ,[TimeOfCompletion]
                     ,[RetryOnFailure]
              )
              SELECT 
                     10,
                     @systemExecutionInstanceGuid,
                     @PackageLoadID,
                     @ShortDescription,
                     NULL,
				  @ErrorCode ,
                     @VerboseDescription,
                     @NotificationSeverityId,
                     @NotificationStatusId,
                     @ProcessTypeID,
					 @LoadStatusType,
                     @FeedName,                 
                     @Stage,
                     '',
                     '',
                     0, 
                     0, 
                     0,
					 @FeedStartTime,
                     GETDATE(),
                     0     
       END
       ELSE 
       BEGIN
             -- 'UPDATE THE VERBOSE DESCRIPTION BY CONCATINATING THE OTHER ERROR IF MORE THAN 1 ERROR OCCURRED'
              UPDATE NOTIFICATIONS 
                     SET NOTIFICATIONS.VerboseDescription =  NOTIFICATIONS.VerboseDescription + @VerboseDescription--,
                   FROM [Control].[Notification] AS [NOTIFICATIONS]
              WHERE NOTIFICATIONS.LoadId = @PackageLoadID
       END
END
