﻿
CREATE view [notification].[vNotification]
as

	select  n.[notificationID]
				,n.[templateID]
				,t.[category]
				,t.[enabled]
				, [greeting]
				,l.[recipientList]
				,n.[notificationSubject]
				,t.bodyText
				,n.[notificationdata]
				,[notificationResponse]
				,t.[profileName]
				,t.[signature]
				,n.[suser_name]
				,n.[queueSysTime]
				,n.[processSysTime]
				,p.[Processed] 
		  	   ,rank() over (partition by t.[enabled],p.[Processed] order by n.[queueSysTime])[Priority]
       FROM [notification].[notification] n
			join [notification].[template] t on t.templateID=n.templateID
			join [notification].[vTemplateRecipientList] l on l.templateID=t.templateID
			join (select [notificationID],case when [processSysTime] is null then 0 else 1 end [processed] from [notification].[notification] ) p on p.[notificationID]=n.notificationID
			
