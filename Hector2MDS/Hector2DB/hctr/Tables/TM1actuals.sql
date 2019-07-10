CREATE TABLE [hctr].[TM1actuals] (
    [CodaCmpCode]              VARCHAR (12)  NULL,
    [DocAccount]               VARCHAR (437) NOT NULL,
    [CodaDocCode]              VARCHAR (12)  NULL,
    [AccountCode_EL1]          VARCHAR (72)  NOT NULL,
    [AccountCodeDescrFull_EL1] VARCHAR (50)  NOT NULL,
    [AccountCode_EL2]          VARCHAR (72)  NOT NULL,
    [AccountCodeDescrFull_EL2] VARCHAR (50)  NOT NULL,
    [DocCurrencyCode]          VARCHAR (12)  NULL,
    [CodaFiscalYear]           SMALLINT      NULL,
    [CodaFiscalPeriod]         INT           NULL,
    [Actuals]                  MONEY         NULL
);

