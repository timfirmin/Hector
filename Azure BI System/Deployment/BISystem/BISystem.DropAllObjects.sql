/****** Object:  StoredProcedure [Control].[CheckSourceFilesIfStagedInClean]    Script Date: 01/12/2016 16:15:18 ******/
DROP PROCEDURE IF EXISTS [Control].[CheckSourceFilesIfStagedInClean]
GO

/****** Object:  StoredProcedure [Azure].[UpdateETLProcessState]    Script Date: 01/12/2016 16:15:19 ******/
DROP PROCEDURE IF EXISTS [Azure].[UpdateETLProcessState]
GO

/****** Object:  StoredProcedure [Azure].[UpdateAction]    Script Date: 01/12/2016 16:15:19 ******/
DROP PROCEDURE IF EXISTS  [Azure].[UpdateAction]
GO

/****** Object:  StoredProcedure [Azure].[InsertAction]    Script Date: 01/12/2016 16:15:19 ******/
DROP PROCEDURE IF EXISTS [Azure].[InsertAction]
GO

/****** Object:  StoredProcedure [Azure].[GetLoadStartParameters]    Script Date: 01/12/2016 16:15:19 ******/
DROP PROCEDURE IF EXISTS [Azure].[GetLoadStartParameters]
GO

/****** Object:  StoredProcedure [Azure].[GetETLProcessState]    Script Date: 01/12/2016 16:15:19 ******/
DROP PROCEDURE IF EXISTS [Azure].[GetETLProcessState]
GO

/****** Object:  StoredProcedure [Azure].[GetActionStatusByOperatioinID]    Script Date: 01/12/2016 16:15:19 ******/
DROP PROCEDURE IF EXISTS [Azure].[GetActionStatusByOperatioinID]
GO

/****** Object:  StoredProcedure [Azure].[GetActionStatus]    Script Date: 01/12/2016 16:15:19 ******/
DROP PROCEDURE IF EXISTS [Azure].[GetActionStatus]
GO

/****** Object:  StoredProcedure [Azure].[GetAction]    Script Date: 01/12/2016 16:15:19 ******/
DROP PROCEDURE IF EXISTS [Azure].[GetAction]
GO

/****** Object:  StoredProcedure [Audit].[CompareSTG2CLNRowCounts]    Script Date: 01/12/2016 16:15:19 ******/
DROP PROCEDURE IF EXISTS [Audit].[CompareSTG2CLNRowCounts]
GO

/****** Object:  StoredProcedure [Audit].[CompareSRC2STGRowCounts]    Script Date: 01/12/2016 16:15:19 ******/
DROP PROCEDURE IF EXISTS [Audit].[CompareSRC2STGRowCounts]
GO

/****** Object:  StoredProcedure  [Control].[ObtainSourceFileId]   Script Date: 05/10/2016 19:21:46 ******/
DROP PROCEDURE IF EXISTS [Control].[InsertSourceFile]
GO
/****** Object:  StoredProcedure [Secure].[GetBlobConnectionKey]  Script Date: 05/10/2016 19:21:46 ******/
DROP PROCEDURE IF EXISTS [Config].[GetBlobContainers]
GO
/****** Object:  StoredProcedure  [Control].[ObtainSourceFileId]   Script Date: 05/10/2016 19:21:46 ******/
DROP PROCEDURE IF EXISTS [Control].[ObtainSourceFileId]
GO
/****** Object:  StoredProcedure [Secure].[GetBlobConnectionKey]  Script Date: 05/10/2016 19:21:46 ******/
DROP PROCEDURE IF EXISTS [Secure].[GetBlobConnectionKey]
GO
/****** Object:  StoredProcedure [Control].[ObtainBlobContainers]   Script Date: 05/10/2016 19:21:46 ******/
DROP PROCEDURE IF EXISTS [Control].[ObtainBlobContainers]
GO
/****** Object:  StoredProcedure [Control].[ObtainDistributionsReadyToProcess]   Script Date: 05/10/2016 19:21:46 ******/
DROP PROCEDURE IF EXISTS [Control].[ObtainDistributionsReadyToProcess]
GO
-----------------------------------------------------------------------------------------------------------
/****** Object:  StoredProcedure[Control].[WaitGlobalProcessPackageCompletion]    Script Date: 05/10/2016 19:21:46 ******/
DROP PROCEDURE IF EXISTS [Control].[WaitGlobalProcessPackageCompletion]
GO
/****** Object:  StoredProcedure [Secure].[ObtainConfiguration]    Script Date: 05/10/2016 19:21:46 ******/
DROP PROCEDURE IF EXISTS [Secure].[ObtainConfiguration]
GO
/****** Object:  StoredProcedure [Test].[ObtainValidationTests]    Script Date: 19/09/2016 19:21:46 ******/
DROP PROCEDURE IF EXISTS [Test].[ObtainValidationTests]
GO
/****** Object:  StoredProcedure [Test].[InsertValidationTestExecution]    Script Date: 19/09/2016 19:21:46 ******/
DROP PROCEDURE IF EXISTS [Test].[InsertValidationTestExecution]
GO
/****** Object:  StoredProcedure [Secure].[SetBlobConfiguration]    Script Date: 19/09/2016 19:21:46 ******/
DROP PROCEDURE IF EXISTS [Secure].[SetBlobConfiguration]
GO
/****** Object:  StoredProcedure [Secure].[GetBlobConnectionString]    Script Date: 19/09/2016 19:21:46 ******/
DROP PROCEDURE IF EXISTS [Secure].[GetBlobConnectionString]
GO
/****** Object:  StoredProcedure [OLAPControl].[ResetDirtyPartitions]    Script Date: 19/09/2016 19:21:46 ******/
DROP PROCEDURE IF EXISTS [OLAPControl].[ResetDirtyPartitions]
GO
/****** Object:  StoredProcedure [OLAPControl].[ObtainMGPartitionsToProcess]    Script Date: 19/09/2016 19:21:46 ******/
DROP PROCEDURE IF EXISTS [OLAPControl].[ObtainMGPartitionsToProcess]
GO
/****** Object:  StoredProcedure [OLAPControl].[ObtainMGDimensionsToProcess]    Script Date: 19/09/2016 19:21:46 ******/
DROP PROCEDURE IF EXISTS [OLAPControl].[ObtainMGDimensionsToProcess]
GO
/****** Object:  StoredProcedure [Control].[VerifyPackageLoadStatus]    Script Date: 19/09/2016 19:21:46 ******/
DROP PROCEDURE IF EXISTS [Control].[VerifyPackageLoadStatus]
GO
/****** Object:  StoredProcedure [Control].[VerifyPackageExecution]    Script Date: 19/09/2016 19:21:46 ******/
DROP PROCEDURE IF EXISTS [Control].[VerifyPackageExecution]
GO
/****** Object:  StoredProcedure [Control].[UpdateSourceFile]    Script Date: 19/09/2016 19:21:46 ******/
DROP PROCEDURE IF EXISTS [Control].[UpdateSourceFile]
GO
/****** Object:  StoredProcedure [Control].[UpdatePartitionLog]    Script Date: 19/09/2016 19:21:46 ******/
DROP PROCEDURE IF EXISTS [Control].[UpdatePartitionLog]
GO
/****** Object:  StoredProcedure [Control].[UpdatePackageLoad]    Script Date: 19/09/2016 19:21:46 ******/
DROP PROCEDURE IF EXISTS [Control].[UpdatePackageLoad]
GO
/****** Object:  StoredProcedure [Control].[UpdateNotificationProcessStatus]    Script Date: 19/09/2016 19:21:46 ******/
DROP PROCEDURE IF EXISTS [Control].[UpdateNotificationProcessStatus]
GO
/****** Object:  StoredProcedure [Control].[StartIncrementalLoad]    Script Date: 19/09/2016 19:21:46 ******/
DROP PROCEDURE IF EXISTS [Control].[StartIncrementalLoad]
GO
/****** Object:  StoredProcedure [Control].[RollbackIncrementalLoad]    Script Date: 19/09/2016 19:21:46 ******/
DROP PROCEDURE IF EXISTS [Control].[RollbackIncrementalLoad]
GO
/****** Object:  StoredProcedure [Control].[ObtainUnprocessedSourceFiles]    Script Date: 19/09/2016 19:21:46 ******/
DROP PROCEDURE IF EXISTS [Control].[ObtainUnprocessedSourceFiles]
GO
/****** Object:  StoredProcedure [Control].[ObtainNewLoadId]    Script Date: 19/09/2016 19:21:46 ******/
DROP PROCEDURE IF EXISTS [Control].[ObtainNewLoadId]
GO
/****** Object:  StoredProcedure [Control].[ObtainEntityUploadDetails]    Script Date: 19/09/2016 19:21:46 ******/
DROP PROCEDURE IF EXISTS [Control].[ObtainEntityUploadDetails]
GO
/****** Object:  StoredProcedure [Control].[ObtainEntityIdForFile]    Script Date: 19/09/2016 19:21:46 ******/
DROP PROCEDURE IF EXISTS [Control].[ObtainEntityIdForFile]
GO
/****** Object:  StoredProcedure [Control].[ObtainEntityId]    Script Date: 19/09/2016 19:21:46 ******/
DROP PROCEDURE IF EXISTS [Control].[ObtainEntityId]
GO
/****** Object:  StoredProcedure [Control].[NotificationSave]    Script Date: 19/09/2016 19:21:46 ******/
DROP PROCEDURE IF EXISTS [Control].[NotificationSave]
GO
/****** Object:  StoredProcedure [Control].[InsertEntityProcessStream]    Script Date: 19/09/2016 19:21:46 ******/
DROP PROCEDURE IF EXISTS [Control].[InsertEntityProcessStream]
GO
/****** Object:  StoredProcedure [Control].[InsertBatchControl]    Script Date: 19/09/2016 19:21:46 ******/
DROP PROCEDURE IF EXISTS [Control].[InsertBatchControl]
GO
/****** Object:  StoredProcedure [Control].[GetNotificationMessageTemplate]    Script Date: 19/09/2016 19:21:46 ******/
DROP PROCEDURE IF EXISTS [Control].[GetNotificationMessageTemplate]
GO
/****** Object:  StoredProcedure [Control].[GetEmailAddressForNotificationSeverity]    Script Date: 19/09/2016 19:21:46 ******/
DROP PROCEDURE IF EXISTS [Control].[GetEmailAddressForNotificationSeverity]
GO
/****** Object:  StoredProcedure [Control].[GetActiveNotificationsToProcess]    Script Date: 19/09/2016 19:21:46 ******/
DROP PROCEDURE IF EXISTS [Control].[GetActiveNotificationsToProcess]
GO
/****** Object:  StoredProcedure [Control].[CompleteIncrementalLoad]    Script Date: 19/09/2016 19:21:46 ******/
DROP PROCEDURE IF EXISTS [Control].[CompleteIncrementalLoad]
GO
/****** Object:  StoredProcedure [Control].[AttachSourceDatabase]    Script Date: 19/09/2016 19:21:46 ******/
DROP PROCEDURE IF EXISTS [Control].[AttachSourceDatabase]
GO
/****** Object:  StoredProcedure [Config].[AddVariable]    Script Date: 19/09/2016 19:21:46 ******/
DROP PROCEDURE IF EXISTS [Config].[AddVariable]
GO
/****** Object:  StoredProcedure [Azure].[GetLoadStartFlag]    Script Date: 19/09/2016 19:21:46 ******/
DROP PROCEDURE IF EXISTS [Azure].[GetLoadStartFlag]
GO
/****** Object:  StoredProcedure [Audit].[UpdateSourceFileProcessStream]    Script Date: 19/09/2016 19:21:46 ******/
DROP PROCEDURE IF EXISTS [Audit].[UpdateSourceFileProcessStream]
GO
/****** Object:  StoredProcedure [Audit].[ObtainLatestLoadDate]    Script Date: 19/09/2016 19:21:46 ******/
DROP PROCEDURE IF EXISTS [Audit].[ObtainLatestLoadDate]
GO
/****** Object:  StoredProcedure [Audit].[ObtainErrorLogId]    Script Date: 19/09/2016 19:21:46 ******/
DROP PROCEDURE IF EXISTS [Audit].[ObtainErrorLogId]
GO
/****** Object:  StoredProcedure [Audit].[InsertSourceFileProcessStream]    Script Date: 19/09/2016 19:21:46 ******/
DROP PROCEDURE IF EXISTS [Audit].[InsertSourceFileProcessStream]
GO
/****** Object:  StoredProcedure [Audit].[InsertRowThroughput]    Script Date: 19/09/2016 19:21:46 ******/
DROP PROCEDURE IF EXISTS [Audit].[InsertRowThroughput]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[OLAPControl].[MeasureGroupPartition]') AND type in (N'U'))
ALTER TABLE [OLAPControl].[MeasureGroupPartition] DROP CONSTRAINT IF EXISTS [fkMeasureGroupPartition_MeasureGroup]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[OLAPControl].[MeasureGroupDimension]') AND type in (N'U'))
ALTER TABLE [OLAPControl].[MeasureGroupDimension] DROP CONSTRAINT IF EXISTS [fkMeasureGroupDimensionMeasureGroup]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[OLAPControl].[MeasureGroupDimension]') AND type in (N'U'))
ALTER TABLE [OLAPControl].[MeasureGroupDimension] DROP CONSTRAINT IF EXISTS [fkMeasureGroupDimensionDimension]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[OLAPControl].[MeasureGroup]') AND type in (N'U'))
ALTER TABLE [OLAPControl].[MeasureGroup] DROP CONSTRAINT IF EXISTS [fkMeasureGroupCube]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[OLAPControl].[Cube]') AND type in (N'U'))
ALTER TABLE [OLAPControl].[Cube] DROP CONSTRAINT IF EXISTS [fkCubeDatabase]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Control].[SourceFile]') AND type in (N'U'))
ALTER TABLE [Control].[SourceFile] DROP CONSTRAINT IF EXISTS [fkSourceFile_SourceFileType]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Control].[SourceFile]') AND type in (N'U'))
ALTER TABLE [Control].[SourceFile] DROP CONSTRAINT IF EXISTS [fkSourceFile_SourceFile]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Control].[SourceFile]') AND type in (N'U'))
ALTER TABLE [Control].[SourceFile] DROP CONSTRAINT IF EXISTS [fkSourceFile_ExtensionType]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Control].[SourceFile]') AND type in (N'U'))
ALTER TABLE [Control].[SourceFile] DROP CONSTRAINT IF EXISTS [fkSourceFile_Application]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Control].[RuleSetObject]') AND type in (N'U'))
ALTER TABLE [Control].[RuleSetObject] DROP CONSTRAINT IF EXISTS [fkRuleSetObject_RuleSet]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Control].[NotificationGroupMembers]') AND type in (N'U'))
ALTER TABLE [Control].[NotificationGroupMembers] DROP CONSTRAINT IF EXISTS [fkNotificationGroupMembers_NotificationSubscriberID]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Control].[NotificationGroupMembers]') AND type in (N'U'))
ALTER TABLE [Control].[NotificationGroupMembers] DROP CONSTRAINT IF EXISTS [fkNotificationGroupMembers_NotificationGroupID]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Control].[NotificationEmailMessageFormats]') AND type in (N'U'))
ALTER TABLE [Control].[NotificationEmailMessageFormats] DROP CONSTRAINT IF EXISTS [fkNotificationEmailMessageFormats_NotificationMessageTypeId]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Control].[NotificationDistibutionConfig]') AND type in (N'U'))
ALTER TABLE [Control].[NotificationDistibutionConfig] DROP CONSTRAINT IF EXISTS [fkNotificationDistibutionConfig_NotificationSubscriberID]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Control].[NotificationDistibutionConfig]') AND type in (N'U'))
ALTER TABLE [Control].[NotificationDistibutionConfig] DROP CONSTRAINT IF EXISTS [fkNotificationDistibutionConfig_NotificationSeverityID]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Control].[NotificationDistibutionConfig]') AND type in (N'U'))
ALTER TABLE [Control].[NotificationDistibutionConfig] DROP CONSTRAINT IF EXISTS [fkNotificationDistibutionConfig_NotificationGroupID]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Control].[Notification]') AND type in (N'U'))
ALTER TABLE [Control].[Notification] DROP CONSTRAINT IF EXISTS [fkNotification_NotificationType]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Control].[Notification]') AND type in (N'U'))
ALTER TABLE [Control].[Notification] DROP CONSTRAINT IF EXISTS [fkNotification_NotificationStatus]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Control].[Notification]') AND type in (N'U'))
ALTER TABLE [Control].[Notification] DROP CONSTRAINT IF EXISTS [fkNotification_NotificationSeverity]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Control].[Notification]') AND type in (N'U'))
ALTER TABLE [Control].[Notification] DROP CONSTRAINT IF EXISTS [fkNotification_NotificationProcessTypeId]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Control].[FileExtensionType]') AND type in (N'U'))
ALTER TABLE [Control].[FileExtensionType] DROP CONSTRAINT IF EXISTS [fkFileExtensionType_FileTypeGroup]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Control].[Entity]') AND type in (N'U'))
ALTER TABLE [Control].[Entity] DROP CONSTRAINT IF EXISTS [fkEntity_SourceFile]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Control].[Entity]') AND type in (N'U'))
ALTER TABLE [Control].[Entity] DROP CONSTRAINT IF EXISTS [fkEntity_EntityType]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Control].[Entity]') AND type in (N'U'))
ALTER TABLE [Control].[Entity] DROP CONSTRAINT IF EXISTS [fkEntity_Application]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Control].[DistributionGroupUser]') AND type in (N'U'))
ALTER TABLE [Control].[DistributionGroupUser] DROP CONSTRAINT IF EXISTS [fkDistributionGroup]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Control].[DataQualityRule]') AND type in (N'U'))
ALTER TABLE [Control].[DataQualityRule] DROP CONSTRAINT IF EXISTS [fkDataQualityRule_RuleType]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Audit].[ErrorLog]') AND type in (N'U'))
ALTER TABLE [Audit].[ErrorLog] DROP CONSTRAINT IF EXISTS [fkErrorLog_Status]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Audit].[ErrorLog]') AND type in (N'U'))
ALTER TABLE [Audit].[ErrorLog] DROP CONSTRAINT IF EXISTS [fkErrorLog_Entity]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Audit].[ErrorInstanceLog]') AND type in (N'U'))
ALTER TABLE [Audit].[ErrorInstanceLog] DROP CONSTRAINT IF EXISTS [fkErrorInstanceLog_ErrorLog]
GO
/****** Object:  Table [Azure].[AutomationActionLog]    Script Date: 01/12/2016 16:15:46 ******/
DROP TABLE IF EXISTS [Azure].[AutomationActionLog]
GO
/****** Object:  Table [Test].[ValidationType]    Script Date: 19/09/2016 19:21:47 ******/
DROP TABLE IF EXISTS [Test].[ValidationType]
GO
/****** Object:  Table [Test].[ValidationTestExecution]    Script Date: 19/09/2016 19:21:47 ******/
DROP TABLE IF EXISTS [Test].[ValidationTestExecution]
GO
/****** Object:  Table [Test].[ValidationTest]    Script Date: 19/09/2016 19:21:47 ******/
DROP TABLE IF EXISTS [Test].[ValidationTest]
GO
/****** Object:  Table [Test].[ValidationSource]    Script Date: 19/09/2016 19:21:47 ******/
DROP TABLE IF EXISTS [Test].[ValidationSource]
GO
/****** Object:  Table [Test].[UnitDataTester]    Script Date: 19/09/2016 19:21:47 ******/
DROP TABLE IF EXISTS [Test].[UnitDataTester]
GO
/****** Object:  Table [Secure].[Configurations]    Script Date: 19/09/2016 19:21:47 ******/
DROP TABLE IF EXISTS [Secure].[Configurations]
GO
/****** Object:  Table [OLAPControl].[PartitionDefinition]    Script Date: 19/09/2016 19:21:47 ******/
DROP TABLE IF EXISTS [OLAPControl].[PartitionDefinition]
GO
/****** Object:  Table [OLAPControl].[MeasureGroupPartition]    Script Date: 19/09/2016 19:21:47 ******/
DROP TABLE IF EXISTS [OLAPControl].[MeasureGroupPartition]
GO
/****** Object:  Table [OLAPControl].[MeasureGroupDimension]    Script Date: 19/09/2016 19:21:47 ******/
DROP TABLE IF EXISTS [OLAPControl].[MeasureGroupDimension]
GO
/****** Object:  Table [OLAPControl].[MeasureGroup]    Script Date: 19/09/2016 19:21:47 ******/
DROP TABLE IF EXISTS [OLAPControl].[MeasureGroup]
GO
/****** Object:  Table [OLAPControl].[Dimension]    Script Date: 19/09/2016 19:21:48 ******/
DROP TABLE IF EXISTS [OLAPControl].[Dimension]
GO
/****** Object:  Table [OLAPControl].[Database]    Script Date: 19/09/2016 19:21:48 ******/
DROP TABLE IF EXISTS [OLAPControl].[Database]
GO
/****** Object:  Table [OLAPControl].[Cube]    Script Date: 19/09/2016 19:21:48 ******/
DROP TABLE IF EXISTS [OLAPControl].[Cube]
GO
/****** Object:  Table [Monitor].[FactCounters]    Script Date: 19/09/2016 19:21:48 ******/
DROP TABLE IF EXISTS [Monitor].[FactCounters]
GO
/****** Object:  Table [Monitor].[DimTime]    Script Date: 19/09/2016 19:21:48 ******/
DROP TABLE IF EXISTS [Monitor].[DimTime]
GO
/****** Object:  Table [Monitor].[DimEnvironment]    Script Date: 19/09/2016 19:21:48 ******/
DROP TABLE IF EXISTS [Monitor].[DimEnvironment]
GO
/****** Object:  Table [Monitor].[DimCounters]    Script Date: 19/09/2016 19:21:48 ******/
DROP TABLE IF EXISTS [Monitor].[DimCounters]
GO
/****** Object:  Table [Control].[Users]    Script Date: 19/09/2016 19:21:48 ******/
DROP TABLE IF EXISTS [Control].[Users]
GO
/****** Object:  Table [Control].[Status]    Script Date: 19/09/2016 19:21:48 ******/
DROP TABLE IF EXISTS [Control].[Status]
GO
/****** Object:  Table [Control].[SourceFileTypeIdentification]    Script Date: 19/09/2016 19:21:48 ******/
DROP TABLE IF EXISTS [Control].[SourceFileTypeIdentification]
GO
/****** Object:  Table [Control].[SourceFileType]    Script Date: 19/09/2016 19:21:49 ******/
DROP TABLE IF EXISTS [Control].[SourceFileType]
GO
/****** Object:  Table [Control].[SourceFile]    Script Date: 19/09/2016 19:21:49 ******/
DROP TABLE IF EXISTS [Control].[SourceFile]
GO
/****** Object:  Table [Control].[RuleType]    Script Date: 19/09/2016 19:21:49 ******/
DROP TABLE IF EXISTS [Control].[RuleType]
GO
/****** Object:  Table [Control].[RuleSetObject]    Script Date: 19/09/2016 19:21:49 ******/
DROP TABLE IF EXISTS [Control].[RuleSetObject]
GO
/****** Object:  Table [Control].[RuleSet]    Script Date: 19/09/2016 19:21:49 ******/
DROP TABLE IF EXISTS [Control].[RuleSet]
GO
/****** Object:  Table [Control].[ProcessStream]    Script Date: 19/09/2016 19:21:49 ******/
DROP TABLE IF EXISTS [Control].[ProcessStream]
GO
/****** Object:  Table [Control].[PatternMatchType]    Script Date: 19/09/2016 19:21:49 ******/
DROP TABLE IF EXISTS [Control].[PatternMatchType]
GO
/****** Object:  Table [Control].[PartitionLoad]    Script Date: 19/09/2016 19:21:49 ******/
DROP TABLE IF EXISTS [Control].[PartitionLoad]
GO
/****** Object:  Table [Control].[NotificationType]    Script Date: 19/09/2016 19:21:49 ******/
DROP TABLE IF EXISTS [Control].[NotificationType]
GO
/****** Object:  Table [Control].[NotificationSubscribers]    Script Date: 19/09/2016 19:21:49 ******/
DROP TABLE IF EXISTS [Control].[NotificationSubscribers]
GO
/****** Object:  Table [Control].[NotificationStatus]    Script Date: 19/09/2016 19:21:49 ******/
DROP TABLE IF EXISTS [Control].[NotificationStatus]
GO
/****** Object:  Table [Control].[NotificationSeverity]    Script Date: 19/09/2016 19:21:50 ******/
DROP TABLE IF EXISTS [Control].[NotificationSeverity]
GO
/****** Object:  Table [Control].[NotificationProcessTypes]    Script Date: 19/09/2016 19:21:50 ******/
DROP TABLE IF EXISTS [Control].[NotificationProcessTypes]
GO
/****** Object:  Table [Control].[NotificationMessageType]    Script Date: 19/09/2016 19:21:50 ******/
DROP TABLE IF EXISTS [Control].[NotificationMessageType]
GO
/****** Object:  Table [Control].[NotificationGroups]    Script Date: 19/09/2016 19:21:50 ******/
DROP TABLE IF EXISTS [Control].[NotificationGroups]
GO
/****** Object:  Table [Control].[NotificationGroupMembers]    Script Date: 19/09/2016 19:21:50 ******/
DROP TABLE IF EXISTS [Control].[NotificationGroupMembers]
GO
/****** Object:  Table [Control].[NotificationEmailMessageFormats]    Script Date: 19/09/2016 19:21:50 ******/
DROP TABLE IF EXISTS [Control].[NotificationEmailMessageFormats]
GO
/****** Object:  Table [Control].[NotificationDistibutionConfig]    Script Date: 19/09/2016 19:21:50 ******/
DROP TABLE IF EXISTS [Control].[NotificationDistibutionConfig]
GO
/****** Object:  Table [Control].[Notification]    Script Date: 19/09/2016 19:21:50 ******/
DROP TABLE IF EXISTS [Control].[Notification]
GO
/****** Object:  Table [Control].[LoadStatusType]    Script Date: 19/09/2016 19:21:50 ******/
DROP TABLE IF EXISTS [Control].[LoadStatusType]
GO
/****** Object:  Table [Control].[IncrementalLoad]    Script Date: 19/09/2016 19:21:50 ******/
DROP TABLE IF EXISTS [Control].[IncrementalLoad]
GO
/****** Object:  Table [Control].[FileTypeGroup]    Script Date: 19/09/2016 19:21:50 ******/
DROP TABLE IF EXISTS [Control].[FileTypeGroup]
GO
/****** Object:  Table [Control].[FileExtensionType]    Script Date: 19/09/2016 19:21:51 ******/
DROP TABLE IF EXISTS [Control].[FileExtensionType]
GO
/****** Object:  Table [Control].[EventActionType]    Script Date: 19/09/2016 19:21:51 ******/
DROP TABLE IF EXISTS [Control].[EventActionType]
GO
/****** Object:  Table [Control].[DistributionGroupUser]    Script Date: 19/09/2016 19:21:51 ******/
DROP TABLE IF EXISTS [Control].[DistributionGroupUser]
GO
/****** Object:  Table [Control].[DistributionGroup]    Script Date: 19/09/2016 19:21:51 ******/
DROP TABLE IF EXISTS [Control].[DistributionGroup]
GO
/****** Object:  Table [Control].[DataQualityRuleType]    Script Date: 19/09/2016 19:21:51 ******/
DROP TABLE IF EXISTS [Control].[DataQualityRuleType]
GO
/****** Object:  Table [Control].[DataQualityRule]    Script Date: 19/09/2016 19:21:51 ******/
DROP TABLE IF EXISTS [Control].[DataQualityRule]
GO
/****** Object:  Table [Control].[CleanseRuleType]    Script Date: 19/09/2016 19:21:51 ******/
DROP TABLE IF EXISTS [Control].[CleanseRuleType]
GO
/****** Object:  Table [Control].[CleanseRule]    Script Date: 19/09/2016 19:21:51 ******/
DROP TABLE IF EXISTS [Control].[CleanseRule]
GO
/****** Object:  Table [Control].[BatchControl]    Script Date: 19/09/2016 19:21:51 ******/
DROP TABLE IF EXISTS [Control].[BatchControl]
GO
/****** Object:  Table [Control].[Application]    Script Date: 19/09/2016 19:21:51 ******/
DROP TABLE IF EXISTS [Control].[Application]
GO
/****** Object:  Table [Config].[Variable]    Script Date: 19/09/2016 19:21:52 ******/
DROP TABLE IF EXISTS [Config].[Variable]
GO
/****** Object:  Table [Config].[Parameter]    Script Date: 19/09/2016 19:21:52 ******/
DROP TABLE IF EXISTS [Config].[Parameter]
GO
/****** Object:  Table [Azure].[AutomationLogs]    Script Date: 19/09/2016 19:21:52 ******/
DROP TABLE IF EXISTS [Azure].[AutomationLogs]
GO
/****** Object:  Table [Audit].[SourceFileProcessStream]    Script Date: 19/09/2016 19:21:52 ******/
DROP TABLE IF EXISTS [Audit].[SourceFileProcessStream]
GO
/****** Object:  Table [Audit].[RunLogs]    Script Date: 19/09/2016 19:21:52 ******/
DROP TABLE IF EXISTS [Audit].[RunLogs]
GO
/****** Object:  Table [Audit].[ExecutionPath]    Script Date: 19/09/2016 19:21:52 ******/
DROP TABLE IF EXISTS [Audit].[ExecutionPath]
GO
/****** Object:  Table [Audit].[ExecutionParameters]    Script Date: 19/09/2016 19:21:52 ******/
DROP TABLE IF EXISTS [Audit].[ExecutionParameters]
GO
/****** Object:  Table [Audit].[ExecutionLogs]    Script Date: 19/09/2016 19:21:52 ******/
DROP TABLE IF EXISTS [Audit].[ExecutionLogs]
GO
/****** Object:  Table [Audit].[EventFact]    Script Date: 19/09/2016 19:21:52 ******/
DROP TABLE IF EXISTS [Audit].[EventFact]
GO
/****** Object:  Table [Audit].[ErrorRows]    Script Date: 19/09/2016 19:21:52 ******/
DROP TABLE IF EXISTS [Audit].[ErrorRows]
GO
/****** Object:  Table [Audit].[ErrorLog]    Script Date: 19/09/2016 19:21:52 ******/
DROP TABLE IF EXISTS [Audit].[ErrorLog]
GO
/****** Object:  Table [Audit].[ErrorInstanceLog]    Script Date: 19/09/2016 19:21:52 ******/
DROP TABLE IF EXISTS [Audit].[ErrorInstanceLog]
GO
/****** Object:  Table [Audit].[DataQuality]    Script Date: 19/09/2016 19:21:53 ******/
DROP TABLE IF EXISTS [Audit].[DataQuality]
GO
/****** Object:  View [Control].[vLoadProcessStream]    Script Date: 19/09/2016 19:21:53 ******/
DROP VIEW IF EXISTS [Control].[vLoadProcessStream]
GO
/****** Object:  Table [Control].[EntityType]    Script Date: 19/09/2016 19:21:53 ******/
DROP TABLE IF EXISTS [Control].[EntityType]
GO
/****** Object:  Table [Control].[EntityProcessStream]    Script Date: 19/09/2016 19:21:53 ******/
DROP TABLE IF EXISTS [Control].[EntityProcessStream]
GO
/****** Object:  Table [Control].[Entity]    Script Date: 19/09/2016 19:21:53 ******/
DROP TABLE IF EXISTS [Control].[Entity]
GO
/****** Object:  View [Audit].[vProject]    Script Date: 19/09/2016 19:21:53 ******/
DROP VIEW IF EXISTS [Audit].[vProject]
GO
/****** Object:  Table [SSIS].[projects]    Script Date: 19/09/2016 19:21:53 ******/
DROP TABLE IF EXISTS [SSIS].[projects]
GO
/****** Object:  View [Audit].[vPackageLoadThroughput]    Script Date: 19/09/2016 19:21:53 ******/
DROP VIEW IF EXISTS [Audit].[vPackageLoadThroughput]
GO
/****** Object:  Table [Audit].[RowThroughput]    Script Date: 19/09/2016 19:21:53 ******/
DROP TABLE IF EXISTS [Audit].[RowThroughput]
GO
/****** Object:  Table [Audit].[PackageLoad]    Script Date: 19/09/2016 19:21:53 ******/
DROP TABLE IF EXISTS [Audit].[PackageLoad]
GO
/****** Object:  View [Audit].[vPackage]    Script Date: 19/09/2016 19:21:53 ******/
DROP VIEW IF EXISTS [Audit].[vPackage]
GO
/****** Object:  Table [SSIS].[packages]    Script Date: 19/09/2016 19:21:53 ******/
DROP TABLE IF EXISTS [SSIS].[packages]
GO
/****** Object:  View [Audit].[vExecutionParameterValues]    Script Date: 19/09/2016 19:21:53 ******/
DROP VIEW IF EXISTS [Audit].[vExecutionParameterValues]
GO
/****** Object:  Table [SSIS].[execution_parameter_values]    Script Date: 19/09/2016 19:21:53 ******/
DROP TABLE IF EXISTS [SSIS].[execution_parameter_values]
GO
/****** Object:  View [Audit].[vEnvironment]    Script Date: 19/09/2016 19:21:53 ******/
DROP VIEW IF EXISTS [Audit].[vEnvironment]
GO
/****** Object:  Table [SSIS].[environments]    Script Date: 19/09/2016 19:21:53 ******/
DROP TABLE IF EXISTS [SSIS].[environments]
GO
/****** Object:  View [Audit].[vAuditLog]    Script Date: 19/09/2016 19:21:53 ******/
DROP VIEW IF EXISTS [Audit].[vAuditLog]
GO
/****** Object:  Table [SSIS].[event_messages]    Script Date: 19/09/2016 19:21:54 ******/
DROP TABLE IF EXISTS [SSIS].[event_messages]
GO
-- start new stuff
/****** Object:  Table [REPORTING].[Date]    Script Date: 19/09/2016 19:21:54 ******/
DROP TABLE IF EXISTS [REPORTING].[Date]
GO
/****** Object:  Table [REPORTING].[ExecutionLogs]    Script Date: 19/09/2016 19:21:54 ******/
DROP TABLE IF EXISTS [REPORTING].[ExecutionLogs]
GO
/****** Object:  Table [REPORTING].[ExecutionParameters]    Script Date: 19/09/2016 19:21:54 ******/
DROP TABLE IF EXISTS [REPORTING].[ExecutionParameters]
GO
/****** Object:  Table [REPORTING].[ExecutionPath]    Script Date: 19/09/2016 19:21:54 ******/
DROP TABLE IF EXISTS [REPORTING].[ExecutionPath]
GO
/****** Object:  Table [REPORTING].[FormatTypes]    Script Date: 19/09/2016 19:21:54 ******/
DROP TABLE IF EXISTS [REPORTING].[FormatTypes]
GO
/****** Object:  Table [REPORTING].[Machines]    Script Date: 19/09/2016 19:21:54 ******/
DROP TABLE IF EXISTS [REPORTING].[Machines]
GO
/****** Object:  Table [REPORTING].[ReportActions]    Script Date: 19/09/2016 19:21:54 ******/
DROP TABLE IF EXISTS [REPORTING].[ReportActions]
GO
/****** Object:  Table [REPORTING].[Reports]    Script Date: 19/09/2016 19:21:54 ******/
DROP TABLE IF EXISTS [REPORTING].[Reports]
GO
/****** Object:  Table [REPORTING].[ReportTypes]    Script Date: 19/09/2016 19:21:54 ******/
DROP TABLE IF EXISTS [REPORTING].[ReportTypes]
GO
/****** Object:  Table [REPORTING].[RequestTypes]    Script Date: 19/09/2016 19:21:54 ******/
DROP TABLE IF EXISTS [REPORTING].[RequestTypes]
GO
/****** Object:  Table [REPORTING].[SourceTypes]    Script Date: 19/09/2016 19:21:54 ******/
DROP TABLE IF EXISTS [REPORTING].[SourceTypes]
GO
/****** Object:  Table [REPORTING].[StatusCodes]    Script Date: 19/09/2016 19:21:54 ******/
DROP TABLE IF EXISTS [REPORTING].[StatusCodes]
GO
/****** Object:  Table [REPORTING].[Users]    Script Date: 19/09/2016 19:21:54 ******/
DROP TABLE IF EXISTS [REPORTING].[Users]
GO
/****** Object:  Table [OLAPCONTROL].[OlapQueryLogArchive]    Script Date: 19/09/2016 19:21:54 ******/
DROP TABLE IF EXISTS [OLAPCONTROL].[OlapQueryLogArchive]
GO
/****** Object:  Table [METADATA].[ObjectAttribute]    Script Date: 19/09/2016 19:21:54 ******/
DROP TABLE IF EXISTS [METADATA].[ObjectAttribute]
GO
/****** Object:  Table [METADATA].[ObjectIdentifier]    Script Date: 19/09/2016 19:21:54 ******/
DROP TABLE IF EXISTS [METADATA].[ObjectIdentifier]
GO
/****** Object:  Table [METADATA].[ObjectRelationship]    Script Date: 19/09/2016 19:21:54 ******/
DROP TABLE IF EXISTS [METADATA].[ObjectRelationship]
GO
/****** Object:  Table [METADATA].[RelationshipType]    Script Date: 19/09/2016 19:21:54 ******/
DROP TABLE IF EXISTS [METADATA].[RelationshipType]
GO
/****** Object:  Table [METADATA].[Object]    Script Date: 19/09/2016 19:21:54 ******/
DROP TABLE IF EXISTS [METADATA].[Object]
GO
/****** Object:  Table [METADATA].[ObjectType]    Script Date: 19/09/2016 19:21:54 ******/
DROP TABLE IF EXISTS [METADATA].[ObjectType]
GO
/****** Object:  Table [METADATA].[Source]    Script Date: 19/09/2016 19:21:54 ******/
DROP TABLE IF EXISTS [METADATA].[Source]
GO
/****** Object:  Table [DATAQUALITY].[DataIntegrityType]    Script Date: 19/09/2016 19:21:54 ******/
DROP TABLE IF EXISTS [DATAQUALITY].[DataIntegrityType]
GO
/****** Object:  Table [DATAQUALITY].[HarmoniseRule]    Script Date: 19/09/2016 19:21:54 ******/
DROP TABLE IF EXISTS [DATAQUALITY].[HarmoniseRule]
GO
/****** Object:  Table [DATAQUALITY].[Screen]    Script Date: 19/09/2016 19:21:54 ******/
DROP TABLE IF EXISTS [DATAQUALITY].[Screen]
GO
/****** Object:  Table [DATAQUALITY].[ScreenSeverity]    Script Date: 19/09/2016 19:21:54 ******/
DROP TABLE IF EXISTS [DATAQUALITY].[ScreenSeverity]
GO
/****** Object:  Table [DATAQUALITY].[StandardiseRule]    Script Date: 19/09/2016 19:21:54 ******/
DROP TABLE IF EXISTS [DATAQUALITY].[StandardiseRule]
GO
/****** Object:  StoredProcedure [CONTROL].[CreateViewForStage]    Script Date: 19/09/2016 19:21:46 ******/
DROP PROCEDURE IF EXISTS [CONTROL].[CreateViewForStage]
GO
/****** Object:  StoredProcedure [CONTROL].[DeleteEntityProcessStream]    Script Date: 19/09/2016 19:21:46 ******/
DROP PROCEDURE IF EXISTS [CONTROL].[DeleteEntityProcessStream]
GO
/****** Object:  StoredProcedure [CONTROL].[GetSourceFileFromEntity]    Script Date: 19/09/2016 19:21:46 ******/
DROP PROCEDURE IF EXISTS [CONTROL].[GetSourceFileFromEntity]
GO
/****** Object:  StoredProcedure [CONTROL].[ObtainActivePartitionKeys]    Script Date: 19/09/2016 19:21:46 ******/
DROP PROCEDURE IF EXISTS [CONTROL].[ObtainActivePartitionKeys]
GO
/****** Object:  StoredProcedure [CONTROL].[ObtainBulkEntityId]    Script Date: 19/09/2016 19:21:46 ******/
DROP PROCEDURE IF EXISTS [CONTROL].[ObtainBulkEntityId]
GO
/****** Object:  StoredProcedure [CONTROL].[ObtainChangedPartitionKeys]    Script Date: 19/09/2016 19:21:46 ******/
DROP PROCEDURE IF EXISTS [CONTROL].[ObtainChangedPartitionKeys]
GO
/****** Object:  StoredProcedure [CONTROL].[ObtainDistributionCodeFromSourceFile]    Script Date: 19/09/2016 19:21:46 ******/
DROP PROCEDURE IF EXISTS [CONTROL].[ObtainDistributionCodeFromSourceFile]
GO
/****** Object:  StoredProcedure [CONTROL].[ObtainEntityTypesForBlobUpload]    Script Date: 19/09/2016 19:21:46 ******/
DROP PROCEDURE IF EXISTS [CONTROL].[ObtainEntityTypesForBlobUpload]
GO
/****** Object:  StoredProcedure [CONTROL].[ObtainFilesToUnload]    Script Date: 19/09/2016 19:21:46 ******/
DROP PROCEDURE IF EXISTS [CONTROL].[ObtainFilesToUnload]
GO
/****** Object:  StoredProcedure [CONTROL].[ObtainFilesToUnloadDataRetention]    Script Date: 19/09/2016 19:21:46 ******/
DROP PROCEDURE IF EXISTS [CONTROL].[ObtainFilesToUnloadDataRetention]
GO
/****** Object:  StoredProcedure [CONTROL].[ObtainPRBISourceFileId]    Script Date: 19/09/2016 19:21:46 ******/
DROP PROCEDURE IF EXISTS [CONTROL].[ObtainPRBISourceFileId]
GO
/****** Object:  StoredProcedure [CONTROL].[ObtainSourceEntityTypes]    Script Date: 19/09/2016 19:21:46 ******/
DROP PROCEDURE IF EXISTS [CONTROL].[ObtainSourceEntityTypes]
GO
/****** Object:  StoredProcedure [CONTROL].[ObtainSourceFileIdForBlobUpload]    Script Date: 19/09/2016 19:21:46 ******/
DROP PROCEDURE IF EXISTS [CONTROL].[ObtainSourceFileIdForBlobUpload]
GO
/****** Object:  StoredProcedure [CONTROL].[ObtainSourceFileIdForProcess]    Script Date: 19/09/2016 19:21:46 ******/
DROP PROCEDURE IF EXISTS [CONTROL].[ObtainSourceFileIdForProcess]
GO
/****** Object:  StoredProcedure [CONTROL].[ObtainSourceFiles]    Script Date: 19/09/2016 19:21:46 ******/
DROP PROCEDURE IF EXISTS [CONTROL].[ObtainSourceFiles]
GO
/****** Object:  StoredProcedure [CONTROL].[PartitionManagementReplicateIndexes]    Script Date: 19/09/2016 19:21:46 ******/
DROP PROCEDURE IF EXISTS [CONTROL].[PartitionManagementReplicateIndexes]
GO
/****** Object:  StoredProcedure [CONTROL].[PartitionManagementSetMOLAPPartitions]    Script Date: 19/09/2016 19:21:46 ******/
DROP PROCEDURE IF EXISTS [CONTROL].[PartitionManagementSetMOLAPPartitions]
GO
/****** Object:  StoredProcedure [CONTROL].[ProcessSourceFile]    Script Date: 19/09/2016 19:21:46 ******/
DROP PROCEDURE IF EXISTS [CONTROL].[ProcessSourceFile]
GO
/****** Object:  StoredProcedure [CONTROL].[VerifyIfPackageAlreadyRun]    Script Date: 19/09/2016 19:21:46 ******/
DROP PROCEDURE IF EXISTS [CONTROL].[VerifyIfPackageAlreadyRun]
GO
/****** Object:  StoredProcedure [OLAPCONTROL].[SetCubeProcessStatus]    Script Date: 19/09/2016 19:21:46 ******/
DROP PROCEDURE IF EXISTS [OLAPCONTROL].[SetCubeProcessStatus]
GO
/****** Object:  StoredProcedure [DATAQUALITY].[GetFeedTableColumnDetails]    Script Date: 19/09/2016 19:21:46 ******/
DROP PROCEDURE IF EXISTS [DATAQUALITY].[GetFeedTableColumnDetails]
GO
/****** Object:  StoredProcedure [DATAQUALITY].[GetFeedTableDetails]    Script Date: 19/09/2016 19:21:46 ******/
DROP PROCEDURE IF EXISTS [DATAQUALITY].[GetFeedTableDetails]
GO
/****** Object:  StoredProcedure [DATAQUALITY].[ObtainHarmoniseRules]    Script Date: 19/09/2016 19:21:46 ******/
DROP PROCEDURE IF EXISTS [DATAQUALITY].[ObtainHarmoniseRules]
GO
/****** Object:  StoredProcedure [DATAQUALITY].[ObtainScreens]    Script Date: 19/09/2016 19:21:46 ******/
DROP PROCEDURE IF EXISTS [DATAQUALITY].[ObtainScreens]
GO
/****** Object:  StoredProcedure [DATAQUALITY].[ObtainStandardiseRules]    Script Date: 19/09/2016 19:21:46 ******/
DROP PROCEDURE IF EXISTS [DATAQUALITY].[ObtainStandardiseRules]
GO
/****** Object:  View [REPORTING].[vwExecutionLog]    Script Date: 19/09/2016 19:21:53 ******/
DROP VIEW IF EXISTS [REPORTING].[vwExecutionLog]
GO
/****** Object:  View [REPORTING].[vwExecutionLogWithParameters]    Script Date: 19/09/2016 19:21:53 ******/
DROP VIEW IF EXISTS [REPORTING].[vwExecutionLogWithParameters]
GO
/****** Object:  View [METADATA].[vDatabaseStructure]    Script Date: 19/09/2016 19:21:53 ******/
DROP VIEW IF EXISTS [METADATA].[vDatabaseStructure]
GO
/****** Object:  View [METADATA].[vFileStructure]    Script Date: 19/09/2016 19:21:53 ******/
DROP VIEW IF EXISTS [METADATA].[vFileStructure]
GO
/****** Object:  Sequence [Control].[PartitionKey]    Script Date: 19/09/2016 19:21:54 ******/
DROP SEQUENCE IF EXISTS [Control].[PartitionKey]
GO
/****** Object:  Function [Control].[SpiltCSV]    Script Date: 19/09/2016 19:21:54 ******/
DROP FUNCTION IF EXISTS [Control].[SpiltCSV]
GO
-- end new stuff
/****** Object:  Function [Config].[ObtainVariable]    Script Date: 19/09/2016 19:21:54 ******/
DROP FUNCTION IF EXISTS [Config].[ObtainVariable]
GO
/****** Object:  Function [dbo].[SplitCSV]    Script Date: 19/09/2016 19:21:54 ******/
DROP FUNCTION IF EXISTS [dbo].[SplitCSV]
GO
/****** Object:  Function [dbo].[GenerateVarchar]   Script Date: 19/09/2016 19:21:54 ******/
DROP FUNCTION IF EXISTS [dbo].[GenerateVarchar]
GO
/****** Object:  Sequence [Audit].[seqErrorLogId]    Script Date: 19/09/2016 19:21:54 ******/
DROP SEQUENCE IF EXISTS [Audit].[seqErrorLogId]
GO
/****** Object:  Schema [Test]    Script Date: 19/09/2016 19:21:54 ******/
DROP SCHEMA IF EXISTS [Test]
GO
/****** Object:  Schema [SSIS]    Script Date: 19/09/2016 19:21:54 ******/
DROP SCHEMA IF EXISTS [SSIS]
GO
/****** Object:  Schema [Secure]    Script Date: 19/09/2016 19:21:54 ******/
DROP SCHEMA IF EXISTS [Secure]
GO
/****** Object:  Schema [Reporting]    Script Date: 19/09/2016 19:21:54 ******/
DROP SCHEMA IF EXISTS [Reporting]
GO
/****** Object:  Schema [OLAPControl]    Script Date: 19/09/2016 19:21:54 ******/
DROP SCHEMA IF EXISTS [OLAPControl]
GO
/****** Object:  Schema [Monitor]    Script Date: 19/09/2016 19:21:54 ******/
DROP SCHEMA IF EXISTS [Monitor]
GO
/****** Object:  Schema [Metadata]    Script Date: 19/09/2016 19:21:54 ******/
DROP SCHEMA IF EXISTS [Metadata]
GO
/****** Object:  Schema [DataRollback]    Script Date: 19/09/2016 19:21:54 ******/
DROP SCHEMA IF EXISTS [DataRollback]
GO
/****** Object:  Schema [Control]    Script Date: 19/09/2016 19:21:54 ******/
DROP SCHEMA IF EXISTS [Control]
GO
/****** Object:  Schema [Config]    Script Date: 19/09/2016 19:21:54 ******/
DROP SCHEMA IF EXISTS [Config]
GO
/****** Object:  Schema [Azure]    Script Date: 19/09/2016 19:21:54 ******/
DROP SCHEMA IF EXISTS [Azure]
GO
/****** Object:  Schema [Audit]    Script Date: 19/09/2016 19:21:54 ******/
DROP SCHEMA IF EXISTS [Audit]
GO
/****** Object:  Schema [DataQuality]    Script Date: 19/09/2016 19:21:54 ******/
DROP SCHEMA IF EXISTS [DataQuality]
GO

USE [BISystemUAT]
GO

DECLARE @RoleName sysname
set @RoleName = N'prs_subscribed_application'

IF @RoleName <> N'public' and (select is_fixed_role from sys.database_principals where name = @RoleName) = 0
BEGIN
    DECLARE @RoleMemberName sysname
    DECLARE Member_Cursor CURSOR FOR
    select [name]
    from sys.database_principals 
    where principal_id in ( 
        select member_principal_id
        from sys.database_role_members
        where role_principal_id in (
            select principal_id
            FROM sys.database_principals where [name] = @RoleName AND type = 'R'))

    OPEN Member_Cursor;

    FETCH NEXT FROM Member_Cursor
    into @RoleMemberName
    
    DECLARE @SQL NVARCHAR(4000)

    WHILE @@FETCH_STATUS = 0
    BEGIN
        
        SET @SQL = 'ALTER ROLE '+ QUOTENAME(@RoleName,'[') +' DROP MEMBER '+ QUOTENAME(@RoleMemberName,'[')
        EXEC(@SQL)
        
        FETCH NEXT FROM Member_Cursor
        into @RoleMemberName
    END;

    CLOSE Member_Cursor;
    DEALLOCATE Member_Cursor;
END
/****** Object:  DatabaseRole [prs_subscribed_application]    Script Date: 18/01/2017 09:53:32 ******/
DROP ROLE [prs_subscribed_application]
GO

PRINT 'Check existing objects'
Select * from Sysobjects where uid not in (1,4)
Select * from Sys.objects where principal_id not in (1,4) and principal_id is not null

