CREATE TABLE [FPV].[ApplicationRequest] (
    [RequestID]                INT            IDENTITY (1, 1) NOT NULL,
    [Request]                  NVARCHAR (MAX) NULL,
    [RequestValidationCode]    INT            NULL,
    [RequestValidationComment] VARCHAR (255)  NULL,
    [RequestSysTime]           DATETIME2 (7)  CONSTRAINT [DF_ApplicationRequest_SysTime] DEFAULT (sysutcdatetime()) NOT NULL,
    [RequestType]              AS             (json_value([Request],'$.request.type')),
    [RequestEntity]            AS             (json_value([Request],'$.request.entity')),
    [RequestOriginator]        AS             (json_value([Request],'$.request.originator')),
    [RequestComment]           AS             (json_value([Request],'$.request.comment')),
    [RequestFilters]           AS             (json_query([Request],'$.request."filters"')),
    [RequestData]              AS             (json_query([Request],'$.request."data"')),
    [InvalidRequest]           NVARCHAR (MAX) NULL,
    PRIMARY KEY CLUSTERED ([RequestID] ASC)
);

