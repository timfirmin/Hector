USE [BISystem_Paas]
GO

/****** Object:  Table [Control].[SourceFile]    Script Date: 05/05/2017 14:39:20 ******/

CREATE SCHEMA [Control]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Control].[SourceFile](
	[SourceFileId] [int] NOT NULL,
	[ParentSourceFileId] [int] NULL,
	[SourceFileName] [nvarchar](255) NOT NULL,
	[SourceFileTypeId] [int] NULL,
	[FileExtensionTypeId] [smallint] NULL,
	[ApplicationId] [smallint] NULL,
	[OriginalFileId] [int] NULL,
	[ModifiedDate] [datetime] NOT NULL,
	[FileSizeBytes] [bigint] NOT NULL,
	[DataSourceType] [nvarchar](100) NULL,
	[IsCompressed] [bit] NULL,
	[Source] [nvarchar](400) NULL,
	[FileExtractedDate] [datetime] NULL,
	[FileExtractedParentLoadId] [int] NULL,
	[BlobUploadDate] [datetime] NULL,
	[StageDate] [datetime] NULL,
	[StageParentLoadId] [int] NULL,
	[CleanDate] [datetime] NULL,
	[CleanParentLoadId] [int] NULL,
	[TransformDate] [datetime] NULL,
	[TransformParentLoadId] [int] NULL,
	[WarehouseDate] [datetime] NULL,
	[OLAPDate] [datetime] NULL,
	[ArchivePath] [nvarchar](400) NULL,
	[ArchiveDate] [datetime] NULL,
	[UnloadFile] [bit] NULL,
	[FileUnloaded] [bit] NULL,
	[FileUnloadedDate] [datetime] NULL,
	[LoadId] [int] NULL,
	[CreatedBy] [nvarchar](128) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[TotalNoOfUses] [bigint] NULL,
	[32BitStageRequired] [bit] NULL,
	[MDSDate] [datetime] NULL,
	[ScrubDate] [datetime] NULL,
	[LDSDate] [datetime] NULL,
	[PartitionKey] [int] NULL,
	[PurgeFromArchive] [bit] NULL,
	[ArchivePurged] [bit] NULL,
	[ArchivePurgedDate] [datetime] NULL,
	[PreStageDate] [datetime] NULL,
	[IsLoaded] [bit] NULL,
	[IsToBeLoaded] [bit] NULL,
	[SourceFileType] [nvarchar](255) NULL,
	[WarehouseParentLoadId] [int] NULL
) ON [PRIMARY]

GO


