CREATE TABLE [Audit].[EventFact] (
    [EventFactId] INT    IDENTITY (1, 1) NOT NULL,
    [DateId]      INT    NULL,
    [ScreenId]    INT    NULL,
    [LoadId]      INT    NULL,
    [RowId]       BIGINT NULL,
    [EntityId]    INT    NULL,
	[FileId]	  INT    NULL,
    CONSTRAINT [pkcEventFact] PRIMARY KEY CLUSTERED ([EventFactId] ASC)
);

