CREATE TABLE [Monitor].[DimCounters] (
    [CounterKey]      INT           NULL,
    [PerfGroup]       VARCHAR (50)  NULL,
    [PerfCounter]     VARCHAR (50)  NULL,
    [FullCounterName] VARCHAR (125) NULL,
	[CounterScript]   NVARCHAR (4000) NULL,
	[EnvironmentKey]  INT             NULL
);

