CREATE TABLE [FPV].[ApplicationResponse] (
    [ResponseID]       INT            IDENTITY (1, 1) NOT NULL,
    [RequestID]        INT            NULL,
    [InvalidRequestID] INT            NULL,
    [Response]         NVARCHAR (MAX) NULL,
    [SysResponseTime]  DATETIME2 (7)  CONSTRAINT [DF_ApplicationResponse_SysResponseTime] DEFAULT (sysutcdatetime()) NOT NULL,
    [type]             VARCHAR (20)   NULL,
    [data]             NVARCHAR (MAX) NULL,
    [DataRowcount]     INT            DEFAULT ((0)) NULL,
    PRIMARY KEY CLUSTERED ([ResponseID] ASC)
);
GO

CREATE NONCLUSTERED INDEX [_dta_index_ApplicationResponse_25_978102525__K5_1_2_3_4_6_7_8]
    ON [FPV].[ApplicationResponse]([SysResponseTime] ASC)
    INCLUDE([ResponseID], [RequestID], [InvalidRequestID], [Response], [type], [data], [DataRowcount]);
GO

CREATE NONCLUSTERED INDEX [IX_ApplicationRequestId]
    ON [FPV].[ApplicationResponse]([RequestID] ASC);
GO

