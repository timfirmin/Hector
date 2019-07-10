
CREATE VIEW [DDItransform].[vNotificationLogFull]
AS
SELECT 
		nl.[NotificationUniqueKey]
		,nl.NotificationFileLogKey
		,fl.DerivedFileType
		,fl.FileName
		,fl.FileSourcePath
		,fl.DerivedDistributionCode
		,fl.DerivedCompany
		,fl.DerivedDistributionGroupCode
		,nl.[NotificationPackageName]
		,nl.[NotificationTaskName]
		,nl.[NotificationFieldName]
		,nl.[NotificationFieldCode]
		,nl.[NotificationFieldDescription]
		,nl.[InsertTimeStamp]
		,nl.[InsertBy]
		,fl.LoadId
  FROM [DDIstaging].[NotificationLog] nl
  JOIN [DDIstaging].[FileLog] fl on nl.[NotificationFileLogKey]  = fl.FileLogUniqueKey