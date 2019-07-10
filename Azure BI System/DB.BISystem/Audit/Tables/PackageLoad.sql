CREATE TABLE [Audit].[PackageLoad] (
    [LoadId]             INT              IDENTITY (1, 1) NOT NULL,
    [ParentLoadId]       INT              NULL,
    [ExecutionId]        INT              NULL,
    [EnvironmentId]      INT              NULL,
    [ProjectId]          INT              NULL,
    [ExecutionGUID]      UNIQUEIDENTIFIER NULL,
    [PackageVersionGUID] UNIQUEIDENTIFIER NULL,
    [PackageGUID]        UNIQUEIDENTIFIER NULL,
    [PackageName]        VARCHAR (250)    NULL,
    [LoadProcess]        VARCHAR (20)     NULL,
    [LoadStatusId]       INT              NULL,
    [StartTime]          DATETIME         NULL,
    [EndTime]            DATETIME         NULL,
    [Duration]           BIGINT           NULL,
    [CreatedBy]          [sysname]        DEFAULT (suser_sname()) NOT NULL,
    [CreatedDate]        DATETIME         DEFAULT (getdate()) NOT NULL,
    [UpdatedBy]          [sysname]        DEFAULT (suser_sname()) NOT NULL,
    [UpdatedDate]        DATETIME         DEFAULT (getdate()) NOT NULL,
    [RowVersion]         ROWVERSION       NOT NULL,
    CONSTRAINT [pkcPackageLoad] PRIMARY KEY CLUSTERED ([LoadId] ASC)
);

