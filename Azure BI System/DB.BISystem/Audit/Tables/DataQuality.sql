CREATE TABLE [Audit].[DataQuality] (
    [DataQualityId] BIGINT          IDENTITY (1, 1) NOT NULL,
    [RowId]         BIGINT          NOT NULL,
    [SourceColumn]  VARCHAR (50)    NULL,
    [OriginalValue] NVARCHAR (1000) NULL,
    [NewValue]      NVARCHAR (1000) NULL,
    [ScreenId]      INT             NOT NULL,
    [ProcessStream] VARCHAR (10)    NOT NULL,
    [EntityId]      INT             NOT NULL,
    [LoadId]        INT             NOT NULL,
    CONSTRAINT [pkcDataQuality] PRIMARY KEY CLUSTERED ([DataQualityId] ASC)
);

