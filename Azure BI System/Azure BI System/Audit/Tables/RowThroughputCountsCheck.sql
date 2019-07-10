CREATE TABLE [Audit].[RowThroughputCountsCheck](
	[RowThroughputCountsCheckId] [int] IDENTITY(1,1) NOT NULL,
	[ExecutionId] [int] NULL,
	[EnvironmentId] [int] NULL,
	[EntityId] [int] NULL,
	[LoadProcess] [varchar](20) NULL,
	[TaskName] [varchar](100) NULL,
	[ProcessStream] [varchar](50) NULL,
	[ProcessLoadId]  [int] NULL,
	[ProcessExecutionId]  [int] NULL,
	[MatchedCounts_YN] bit Null,
	[SourceRowCount] [int] NULL,
	[TargetRowCount] [int] NULL,
	[LoadId] [int] NOT NULL,
	[CreatedBy] [sysname] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedBy] [sysname] NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[RowVersion] [timestamp] NOT NULL,
	[ApplicationId] [smallint] NULL,
	[SourceFileName] [varchar](100) NULL,
	[EntityName] [varchar](100) NULL
)

GO

ALTER TABLE [Audit].[RowThroughputCountsCheck] ADD  DEFAULT (suser_sname()) FOR [CreatedBy]
GO

ALTER TABLE [Audit].[RowThroughputCountsCheck] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO

ALTER TABLE [Audit].[RowThroughputCountsCheck] ADD  DEFAULT (suser_sname()) FOR [UpdatedBy]
GO

ALTER TABLE [Audit].[RowThroughputCountsCheck] ADD  DEFAULT (getdate()) FOR [UpdatedDate]
GO
