CREATE TABLE [Config].[StationID_Bank] (
    [StationId]      VARCHAR (10)     NOT NULL,
    [AllocationDate] DATETIME2 (7)    NULL,
    [RequestorID]    VARCHAR (20)     NULL,
    [RequestID]      UNIQUEIDENTIFIER NULL,
    PRIMARY KEY CLUSTERED ([StationId] ASC)
);


