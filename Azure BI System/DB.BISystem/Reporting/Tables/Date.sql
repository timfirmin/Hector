﻿CREATE TABLE [Reporting].[Date] (
    [DateKey]                 INT           NOT NULL,
    [CalendarDate]            VARCHAR (20)  NOT NULL,
    [DayNumberOfWeek]         VARCHAR (10)  NOT NULL,
    [DayNameOfWeek]           VARCHAR (20)  NOT NULL,
    [DayNumberOfMonth]        VARCHAR (10)  NOT NULL,
    [DayNumberOfYear]         VARCHAR (10)  NOT NULL,
    [CalendarWeekId]          INT           NOT NULL,
    [CalendarWeek]            VARCHAR (20)  NOT NULL,
    [CalendarWeekNumberId]    SMALLINT      NOT NULL,
    [CalendarWeekNumber]      VARCHAR (10)  NOT NULL,
    [CalendarMonthId]         INT           NOT NULL,
    [CalendarMonthNumber]     SMALLINT      NOT NULL,
    [CalendarMonthName]       VARCHAR (30)  NOT NULL,
    [CalendarShortMonthName]  VARCHAR (10)  NOT NULL,
    [CalendarMonthYearName]   VARCHAR (30)  NOT NULL,
    [CalendarQuarterId]       INT           NOT NULL,
    [CalendarQuarterName]     VARCHAR (30)  NOT NULL,
    [CalendarQuarterNumber]   SMALLINT      NOT NULL,
    [CalendarQuarterYearName] VARCHAR (30)  NOT NULL,
    [CalendarYear]            INT           NOT NULL,
    [CalendarYearName]        VARCHAR (20)  NOT NULL,
    [FiscalWeekNumber]        VARCHAR (10)  NOT NULL,
    [FiscalMonthId]           INT           NOT NULL,
    [FiscalMonthName]         VARCHAR (30)  NOT NULL,
    [FiscalQuarterId]         INT           NOT NULL,
    [FiscalQuarterName]       VARCHAR (30)  NOT NULL,
    [FiscalYearId]            INT           NOT NULL,
    [FiscalYearName]          VARCHAR (30)  NOT NULL,
    [AnacapWeekNumberId]      INT           NULL,
    [AnacapWeekNumber]        VARCHAR (10)  NULL,
    [IsWeekend]               BIT           NOT NULL,
    [IsHoliday]               BIT           NOT NULL,
    [HolidayName]             VARCHAR (50)  NULL,
    [IsLeapYear]              BIT           NOT NULL,
    [IsWorkingDay]            BIT           NOT NULL,
    [CreatedBy]               VARCHAR (40)  NOT NULL,
    [CreatedDate]             SMALLDATETIME NOT NULL,
    [UpdatedBy]               VARCHAR (40)  NOT NULL,
    [UpdatedDate]             SMALLDATETIME NOT NULL,
    CONSTRAINT [PK_Date] PRIMARY KEY CLUSTERED ([DateKey] ASC)
);

