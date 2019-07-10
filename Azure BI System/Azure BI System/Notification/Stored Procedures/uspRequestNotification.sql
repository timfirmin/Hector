CREATE PROCEDURE [notification].[uspRequestNotification]
	@notificationTemplate varchar(100),
	@notificationSubject nvarchar(255),
	@notificationData nvarchar(max),
	@notificationExpiryDate varchar(8) = null,
	@requestSource varchar(100) = null
as
declare @templateid int
declare @notificationid int

	if exists (select templateID from [notification].[template] where [templateName]=@notificationTemplate)
	begin

		select @templateid=templateID from [notification].[template] where [templateName]=@notificationTemplate

		--insert a pending notification record
		insert [notification].[notification]([templateID],
		                                     [notificationSubject],
											 [notificationData],
											 [notificationResponse],
		                                 	 [ExpiryDate],
											 [Processed],
											 [suser_name],
											 [requestSource]
											 )
		select	[templateID]
				,@notificationSubject
				,@notificationData
				,[bodyText]
				,ISNULL(@notificationExpiryDate, convert(varchar(8),dateadd(day,2,getdate()),112))
				,0
				,suser_name()
				,@requestSource
		from	[notification].[template] n 
		where	templateID=@templateid

		select @notificationid = scope_identity()

		--update the body text with logged parameter values
		exec [notification].[uspUpdateNotificationBody] @notificationid
		

	end
GO

