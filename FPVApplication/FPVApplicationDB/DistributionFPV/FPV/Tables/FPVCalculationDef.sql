CREATE TABLE [FPV].[FPVCalculationDef] (
    [FPVCalculationDefID]   INT            IDENTITY (1, 1) NOT NULL,
    [CalculationName]       VARCHAR (100)  NOT NULL,
    [CalculationDetails]    VARCHAR (1000) NOT NULL,
    [DistributionGroupCode] VARCHAR (20)   NULL,
    [Enabled]               BIT            DEFAULT ((1)) NULL,
    [Society]               VARCHAR (10)   NULL,
    PRIMARY KEY CLUSTERED ([FPVCalculationDefID] ASC)
);

