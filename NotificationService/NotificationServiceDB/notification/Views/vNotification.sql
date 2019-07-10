






CREATE view [notification].[vNotification]
as
		select n.[notificationID]
				,n.[templateID]
				,t.[category]
				,t.[enabled]
				,replace(t.[greeting],'%recipientList%',l.[friendlyNameList])[greeting]
				,t.[signature]
				,l.[recipientList]
				,l.[recipientNameList]
				,l.[friendlyNameList]
				,n.[notificationSubject]
				,n.[notificationBody]
				,t.[profileName]
				,n.[reportLink]
				,case when n.[reportLink] is not null then 'Full details can be found at:' + n.[reportLink] else '' end [reportLinkText]
				,n.[suser_name]
				,n.[queueSysTime]
				,n.[processSysTime]
				,p.[Processed] 
				,rank() over (partition by t.[enabled],p.[Processed] order by n.[queueSysTime])[Priority]
		from [notification].[notification] n
		join [notification].[template] t on t.templateID=n.templateID
		join [notification].[vTemplateRecipientList] l on l.templateID=t.templateID
		join (select [notificationID],case when [processSysTime] is null then 0 else 1 end [processed] from [notification].[notification] ) p on p.[notificationID]=n.notificationID

