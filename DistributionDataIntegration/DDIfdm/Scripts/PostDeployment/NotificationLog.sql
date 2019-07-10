

CREATE VIEW [DDI].[NotificationLog]
AS

SELECT 
		nl.[NotificationUniqueKey]
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
  FROM [FinanceStage].[DDIstaging].[NotificationLog] nl
  JOIN [FinanceStage].[DDIstaging].[FileLog] fl on nl.[NotificationFileLogKey]  = fl.FileLogUniqueKey;