﻿
/*Post Deployment Scripts for DDIStaging File Types*/


MERGE INTO [DDIstaging].[FileType] AS Target
USING
	(SELECT  
			1 AS [FileTypeUniqueKey]
		  ,'MusicMinutes' AS [FileTypeName]
		  ,'Music Minutes Forecast' AS [FileTypeDescription]
		  ,'Forecasts' AS [FileTypeNameMask]
		  ,'MusicMinutes\' AS [FileTypeImportFolderName]
		  ,'MusicMinutes\Failed\' AS [FileTypeFailedFolderName]
		  ,'MusicMinutes\Processed\' AS [FileTypeProcessedFolderName]
		  ,'MusicMinutes\Quarantined\' AS [FileTypeQuarantineFolderName]
		  ,'MusicMinutes\Archived\' AS [FileTypeArchiveFolderName]
		  ,'DDIstaging.DistributionMusicMinutes' AS [FileTypeStagingTable]
		  ,'csv' AS [FileTypeFormat]
		  ,',' AS [FileTypeDelimiter]
		  ,'TotalForecast' AS [FileTypeValueCheckColumn]
		  ,'Y' AS [FileTypeProcessFlag]
		  ,10 AS [FileTypeRetentionDays]
		  ,'' AS [InsertTimeStamp]
		  ,'' AS [InsertLoadId]
		  ,'' AS [InsertedBy]
	UNION
	SELECT  
			2 AS [FileTypeUniqueKey]
		  ,'PublicReception' AS [FileTypeName]
		  ,'Public Reception Data' AS [FileTypeDescription]
		  ,'PublicReception' AS [FileTypeNameMask]
		  ,'PublicReception\' AS [FileTypeImportFolderName]
		  ,'PublicReception\Failed\' AS [FileTypeFailedFolderName]
		  ,'PublicReception\Processed\' AS [FileTypeProcessedFolderName]
		  ,'PublicReception\Quarantined\' AS [FileTypeQuarantineFolderName]
		  ,'PublicReception\Archived\' AS [FileTypeArchiveFolderName]
		  ,'DDIstaging.DistributionPublicReception' AS [FileTypeStagingTable]
		  ,'csv' AS [FileTypeFormat]
		  ,',' AS [FileTypeDelimiter]
		  ,'TotalPRAllocation' AS [FileTypeValueCheckColumn]
		  ,'Y' AS [FileTypeProcessFlag]
		  ,30 AS [FileTypeRetentionDays]
		  ,'' AS [InsertTimeStamp]
		  ,'' AS [InsertLoadId]
		  ,'' AS [InsertedBy]
	UNION
	SELECT  
			3 AS [FileTypeUniqueKey]
		  ,'MissingMinutes' AS [FileTypeName]
		  ,'Music Minutes Forecast' AS [FileTypeDescription]
		  ,'MissingMinutes' AS [FileTypeNameMask]
		  ,'MissingMinutes\' AS [FileTypeImportFolderName]
		  ,'MissingMinutes\Failed\' AS [FileTypeFailedFolderName]
		  ,'MissingMinutes\Processed\' AS [FileTypeProcessedFolderName]
		  ,'MissingMinutes\Quarantined\' AS [FileTypeQuarantineFolderName]
		  ,'MissingMinutes\Archived\' AS [FileTypeArchiveFolderName]
		  ,'DDIstaging.DistributionMissingMinutes' AS [FileTypeStagingTable]
		  ,'csv' AS [FileTypeFormat]
		  ,',' AS [FileTypeDelimiter]
		  ,'RevenueTotal' AS [FileTypeValueCheckColumn]
		  ,'Y' AS [FileTypeProcessFlag]
		  ,10 AS [FileTypeRetentionDays]
		  ,'' AS [InsertTimeStamp]
		  ,'' AS [InsertLoadId]
		  ,'' AS [InsertedBy]
	
	) AS Source
		ON
			Target.[FileTypeUniqueKey] = Source.[FileTypeUniqueKey]			
WHEN MATCHED AND
			(
			Target.[FileTypeName] <> Source.[FileTypeName]
			OR Target.[FileTypeDescription] <> Source.[FileTypeDescription]
			OR Target.[FileTypeNameMask] <> Source.[FileTypeNameMask]
			OR Target.[FileTypeImportFolderName] <> Source.[FileTypeImportFolderName]
			OR Target.[FileTypeFailedFolderName] <> Source.[FileTypeFailedFolderName]
			OR Target.[FileTypeProcessedFolderName] <> Source.[FileTypeProcessedFolderName]
			OR Target.[FileTypeQuarantineFolderName] <> Source.[FileTypeQuarantineFolderName]
			OR Target.[FileTypeArchiveFolderName] <> Source.[FileTypeArchiveFolderName]
			OR Target.[FileTypeStagingTable] <> Source.[FileTypeStagingTable]
			OR Target.[FileTypeFormat] <> Source.[FileTypeFormat]
			OR Target.[FileTypeDelimiter] <> Source.[FileTypeDelimiter]
			OR Target.[FileTypeValueCheckColumn] <> Source.[FileTypeValueCheckColumn]
			OR Target.[FileTypeProcessFlag] <> Source.[FileTypeProcessFlag]
			OR Target.[FileTypeRetentionDays] <> Source.[FileTypeRetentionDays]
			) THEN
				UPDATE SET 
				   Target.[FileTypeDescription] = Source.[FileTypeDescription]
					, Target.[FileTypeNameMask] = Source.[FileTypeNameMask]
					, Target.[FileTypeImportFolderName] = Source.[FileTypeImportFolderName]
					, Target.[FileTypeFailedFolderName] = Source.[FileTypeFailedFolderName]
					, Target.[FileTypeProcessedFolderName] = Source.[FileTypeProcessedFolderName]
					, Target.[FileTypeQuarantineFolderName] = Source.[FileTypeQuarantineFolderName]
					, Target.[FileTypeArchiveFolderName] = Source.[FileTypeArchiveFolderName]
					, Target.[FileTypeStagingTable] = Source.[FileTypeStagingTable]
					, Target.[FileTypeFormat] = Source.[FileTypeFormat]
					, Target.[FileTypeDelimiter] = Source.[FileTypeDelimiter]
					, Target.[FileTypeValueCheckColumn] = Source.[FileTypeValueCheckColumn]
					, Target.[FileTypeProcessFlag] = Source.[FileTypeProcessFlag]
					, Target.[FileTypeRetentionDays] = Source.[FileTypeRetentionDays]
WHEN NOT MATCHED THEN 
		INSERT (
					[FileTypeName]
				  ,[FileTypeDescription]
				  ,[FileTypeNameMask]
				  ,[FileTypeImportFolderName]
				  ,[FileTypeFailedFolderName]
				  ,[FileTypeProcessedFolderName]
				  ,[FileTypeQuarantineFolderName]
				  ,[FileTypeArchiveFolderName]
				  ,[FileTypeStagingTable]
				  ,[FileTypeFormat]
				  ,[FileTypeDelimiter]
				  ,[FileTypeValueCheckColumn]
				  ,[FileTypeProcessFlag]
				  ,[FileTypeRetentionDays]
				  ,[InsertTimeStamp]
				  ,[InsertLoadId]
				  ,[InsertedBy]
				) 
				VALUES 
				(	Source.[FileTypeName]
				  ,Source.[FileTypeDescription]
				  ,Source.[FileTypeNameMask]
				  ,Source.[FileTypeImportFolderName]
				  ,Source.[FileTypeFailedFolderName]
				  ,Source.[FileTypeProcessedFolderName]
				  ,Source.[FileTypeQuarantineFolderName]
				  ,Source.[FileTypeArchiveFolderName]
				  ,Source.[FileTypeStagingTable]
				  ,Source.[FileTypeFormat]
				  ,Source.[FileTypeDelimiter]
				  ,Source.[FileTypeValueCheckColumn]
				  ,Source.[FileTypeProcessFlag]
				  ,Source.[FileTypeRetentionDays]
				  ,GETDATE()
				  ,0
				  ,'SystemUser'
				); 

