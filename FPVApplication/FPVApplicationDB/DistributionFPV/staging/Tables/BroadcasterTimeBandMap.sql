CREATE TABLE [staging].[BroadcasterTimeBandMap] (
    [REPTimeBand]     VARCHAR (60) NOT NULL,
    [MappedTimeBand]  VARCHAR (60) NOT NULL,
    [TimeBandRank]    INT          NULL,
    [ValidFlag]       VARCHAR (1)  NULL,
    [InsertLoadId]    INT          NULL,
    [InsertTimeStamp] DATETIME     CONSTRAINT [DF_BroadcasterTimeBandMap_InsertTimeStamp] DEFAULT (getdate()) NULL
);






GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_BroadcasterTimeBandMap]
    ON [staging].[BroadcasterTimeBandMap]([REPTimeBand] ASC, [MappedTimeBand] ASC) WITH (IGNORE_DUP_KEY = ON);

