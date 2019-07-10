CREATE TABLE [rjr].[RajarData] (
    [tid]                        INT            IDENTITY (1, 1) NOT NULL,
    [monthyear]                  VARCHAR (6)    NULL,
    [Station_Group]              VARCHAR (200)  NULL,
    [Survey_Period]              VARCHAR (200)  NULL,
    [Population_000]             VARCHAR (250)  NULL,
    [Reach_000]                  VARCHAR (200)  NULL,
    [Reach_Percent]              VARCHAR (200)  NULL,
    [Average_Hours_Per_Head]     VARCHAR (250)  NULL,
    [Average_Hours_Per_Listener] VARCHAR (100)  NULL,
    [Total_Hours_000]            VARCHAR (100)  NULL,
    [Listening_Share_In_TSA]     VARCHAR (100)  NULL,
    [fileId]                     VARCHAR (100)  NULL,
    [fileNameShort]              VARCHAR (100)  NULL,
    [rowNumber]                  VARCHAR (100)  NULL,
    [parentRowDescr]             VARCHAR (1000) NULL,
    [TimeStamps]                 DATETIME       NULL
);

