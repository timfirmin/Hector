CREATE TABLE [FPV].[DistributionRevenueCalendar] (
    [DistributionGroup]           NVARCHAR (250) NULL,
    [DistributionCode]            NVARCHAR (250) NOT NULL,
    [LicensingRevenuePeriodStart] NVARCHAR (113) NOT NULL,
    [LicensingRevenuePeriodEnd]   NVARCHAR (113) NOT NULL,
    [DateKey]                     INT            NULL,
    [CalendarDate]                DATETIME       NULL,
    [CalendarYear]                INT            NULL,
    [CalendarYearMonth]           VARCHAR (26)   NOT NULL,
    [CalendarMonth]               INT            NULL,
    [CalendarYearQuarter]         VARCHAR (26)   NOT NULL,
    [CalendarQuarter]             INT            NULL,
    [MonthYearName]               NVARCHAR (30)  NULL,
    [DayNameOfWeek]               NVARCHAR (30)  NULL,
    [DayOfWeek]                   INT            NULL,
    [DayOfMonth]                  INT            NULL,
    [DayOfYear]                   INT            NULL,
    [InsertLoadId]                INT            NULL,
    [InsertTimestamp]             DATETIME2 (7)  NOT NULL
);

