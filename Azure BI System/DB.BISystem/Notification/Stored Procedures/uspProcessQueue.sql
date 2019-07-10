CREATE PROCEDURE [notification].[uspProcessQueue]
AS
BEGIN

	declare @notificationID int
	declare @recipients varchar(max)
	declare @subject nvarchar(255)
	declare @profile_name sysname
	declare @body nvarchar(max)

/********************************************************************************************************************
       while there are unprocessed notifications
********************************************************************************************************************/
       while ((select count([notificationID]) from [notification].[vNotification] where [Processed]=0) > 0)
       begin
       /********************************************************************************************************************
              get the notification parameters
       ********************************************************************************************************************/
              select @notificationID=n.[notificationID]
                           ,@recipients=n.[recipientList]
                           ,@subject=n.[notificationSubject]
                           ,@body = n.notificationResponse
                           ,@profile_name = n.[profileName]
              from [notification].[vNotification] n
              where n.[Processed]=0 and n.[Priority]=1 and n.[enabled]=1

       /********************************************************************************************************************
              send notification
       ********************************************************************************************************************/
              --exec msdb.dbo.sp_send_dbmail @recipients=@recipients,@subject = @subject,@profile_name = @profile_name,@body = @body;

       /********************************************************************************************************************
              set the notification to be processed
       ********************************************************************************************************************/
              --update [notification].[notification]
              --set [processSysTime]=sysutcdatetime()
              --where [notificationID] = @notificationID
 END
END

