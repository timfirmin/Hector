/*
Deployment script for FinanceDataMart

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "FinanceDataMart"
:setvar DefaultFilePrefix "FinanceDataMart"
:setvar DefaultDataPath "F:\SQLServerDatabases\"
:setvar DefaultLogPath "G:\SQLServerXLogs\"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];



GO
PRINT N'Dropping [CodaWarehouse].[DF_FactTransactions_CurrentYN]...';


GO
PRINT N'Altering [CodaTabular]...';


GO
ALTER AUTHORIZATION
    ON SCHEMA::[CodaTabular]
    TO [PRS\SQLProxyBIUAT];


GO
PRINT N'Altering [CodaWarehouse]...';


GO
ALTER AUTHORIZATION
    ON SCHEMA::[CodaWarehouse]
    TO [PRS\SQLProxyBIUAT];


GO
PRINT N'Starting rebuilding table [CodaWarehouse].[FactTransactions]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [CodaWarehouse].[tmp_ms_xx_FactTransactions] (
    [CodaDetailsKey]          BIGINT        NULL,
    [CodaDetailsCode]         VARCHAR (51)  NULL,
    [PipelinePivotKey]        BIGINT        NULL,
    [PipelinePivotCode]       VARCHAR (111) NULL,
    [PerformanceRange]        VARCHAR (500) NULL,
    [PipelineAccountKey_EL1]  BIGINT        NULL,
    [PipelineAccountCode_El1] VARCHAR (72)  NOT NULL,
    [PipelineAccountKey_EL2]  BIGINT        NULL,
    [PipelineAccountCode_El2] VARCHAR (72)  NOT NULL,
    [PipelineAccountKey_EL3]  BIGINT        NULL,
    [PipelineAccountCode_El3] VARCHAR (72)  NOT NULL,
    [PipelineDocCode]         VARCHAR (12)  NULL,
    [PipelineDocNum]          VARCHAR (12)  NULL,
    [CodaCompanyKey]          BIGINT        NULL,
    [CodaCmpCode]             VARCHAR (12)  NULL,
    [CodaDocumentKey]         BIGINT        NULL,
    [CodaDocCode]             VARCHAR (12)  NULL,
    [CodaDocNum]              VARCHAR (12)  NULL,
    [CodaDocLinenum]          VARCHAR (12)  NULL,
    [CodaHeaderModifiedDate]  DATETIME      NULL,
    [CodaLineModifiedDate]    DATETIME      NULL,
    [CodaOrigCmpCode]         VARCHAR (12)  NULL,
    [CodaOrigDocCode]         VARCHAR (12)  NULL,
    [CodaOrigDocNum]          VARCHAR (12)  NULL,
    [OriginatingDocument]     VARCHAR (38)  NULL,
    [CodaFiscalPeriod]        INT           NULL,
    [CodaFiscalYear]          SMALLINT      NULL,
    [CodaFiscalDate]          DATETIME      NULL,
    [CodaLineUserName]        VARCHAR (12)  NOT NULL,
    [CustomerSupplierFlag]    SMALLINT      NOT NULL,
    [DocAccount]              VARCHAR (437) NOT NULL,
    [AccountKey_EL1]          BIGINT        NULL,
    [AccountCode_EL1]         VARCHAR (72)  NOT NULL,
    [AccountKey_EL2]          BIGINT        NULL,
    [AccountCode_EL2]         VARCHAR (72)  NOT NULL,
    [AccountKey_EL3]          BIGINT        NULL,
    [AccountCode_EL3]         VARCHAR (72)  NOT NULL,
    [AccountKey_EL4]          BIGINT        NULL,
    [AccountCode_EL4]         VARCHAR (72)  NOT NULL,
    [AccountKey_EL5]          BIGINT        NULL,
    [AccountCode_EL5]         VARCHAR (72)  NOT NULL,
    [AccountKey_EL6]          BIGINT        NULL,
    [AccountCode_EL6]         VARCHAR (72)  NOT NULL,
    [ExchangeRate]            MONEY         NULL,
    [DebitCredit]             VARCHAR (6)   NOT NULL,
    [CodaHeaderDescr]         VARCHAR (36)  NULL,
    [CodaLineDescr]           VARCHAR (36)  NOT NULL,
    [CodaLineType]            SMALLINT      NOT NULL,
    [CodaLineTypeDescr]       VARCHAR (8)   NOT NULL,
    [DocXRef]                 VARCHAR (72)  NULL,
    [DocCurrencyAmount]       MONEY         NOT NULL,
    [DocDualCurrencyAmount]   MONEY         NOT NULL,
    [DocAmount]               MONEY         NOT NULL,
    [DocTaxAmount]            MONEY         NOT NULL,
    [FXRate]                  MONEY         NULL,
    [TaxLineCode]             VARCHAR (12)  NOT NULL,
    [TemplateCode]            VARCHAR (12)  NULL,
    [AuthUser]                VARCHAR (12)  NULL,
    [OrigUser]                VARCHAR (12)  NULL,
    [StatUser]                VARCHAR (1)   NOT NULL,
    [DocApprover]             VARCHAR (12)  NULL,
    [DocumentDate]            DATETIME      NULL,
    [RegistrationDate]        DATETIME      NULL,
    [DocInputDate]            DATETIME      NULL,
    [DocInputTime]            DATETIME      NULL,
    [PaymentDate]             DATETIME      NULL,
    [ClearsDate]              DATETIME      NULL,
    [ReminderDate]            DATETIME      NULL,
    [CodaRef1]                VARCHAR (32)  NOT NULL,
    [CodaRef2]                VARCHAR (32)  NOT NULL,
    [CodaRef3]                VARCHAR (32)  NOT NULL,
    [CodaRef4]                VARCHAR (32)  NULL,
    [CodaRef5]                VARCHAR (32)  NULL,
    [CodaRef6]                VARCHAR (32)  NULL,
    [SalesInvoiceStatus]      SMALLINT      NULL,
    [PaymentMatchingStatus]   SMALLINT      NULL,
    [ReconciliationStatus]    SMALLINT      NULL,
    [ReminderStatus]          SMALLINT      NULL,
    [DocumentStatus]          SMALLINT      NULL,
    [WorkFlowStatus]          SMALLINT      NULL,
    [DocumentMatchUniqueRef]  INT           NULL,
    [MatchLevel]              SMALLINT      NULL,
    [DocLineSeverity]         SMALLINT      NULL,
    [DocLetterSeverity]       SMALLINT      NULL,
    [CurrentYN]               VARCHAR (1)   CONSTRAINT [DF_FactTransactionsPRD_CurrentYN] DEFAULT ('Y') NULL,
    [InsertLoadId]            INT           NULL,
    [UpdateLoadId]            INT           NULL,
    [InsertTimestamp]         DATETIME      CONSTRAINT [DF_FactTransactionsPRD_InsertTimestamp] DEFAULT (getdate()) NULL,
    [UpdateTimestamp]         DATETIME      NULL,
    [AccountKey_EL12]         BIGINT        NULL,
    [AccountCode_EL12]        VARCHAR (72)  NULL,
    [AccountKey_EL123]        BIGINT        NULL,
    [AccountCode_EL123]       VARCHAR (72)  NULL,
    [DocXRefDescr]            VARCHAR (100) NULL,
    [CodaDocListOrder]        SMALLINT      NULL,
    [DocCurrencyCodeKey]      BIGINT        NULL,
    [DocCurrencyCode]         VARCHAR (12)  NULL,
    [CodaDocLineComment]      VARCHAR (255) NULL
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [CodaWarehouse].[FactTransactions])
    BEGIN
        INSERT INTO [CodaWarehouse].[tmp_ms_xx_FactTransactions] ([CodaDetailsKey], [CodaDetailsCode], [PipelinePivotKey], [PipelinePivotCode], [PerformanceRange], [PipelineAccountKey_EL1], [PipelineAccountCode_El1], [PipelineAccountKey_EL2], [PipelineAccountCode_El2], [PipelineAccountKey_EL3], [PipelineAccountCode_El3], [PipelineDocCode], [PipelineDocNum], [CodaCompanyKey], [CodaCmpCode], [CodaDocumentKey], [CodaDocCode], [CodaDocNum], [CodaDocLinenum], [CodaHeaderModifiedDate], [CodaLineModifiedDate], [CodaOrigCmpCode], [CodaOrigDocCode], [CodaOrigDocNum], [OriginatingDocument], [CodaFiscalPeriod], [CodaFiscalYear], [CodaFiscalDate], [CodaLineUserName], [CustomerSupplierFlag], [DocAccount], [AccountKey_EL1], [AccountCode_EL1], [AccountKey_EL2], [AccountCode_EL2], [AccountKey_EL3], [AccountCode_EL3], [AccountKey_EL4], [AccountCode_EL4], [AccountKey_EL5], [AccountCode_EL5], [AccountKey_EL6], [AccountCode_EL6], [ExchangeRate], [DebitCredit], [CodaHeaderDescr], [CodaLineDescr], [CodaLineType], [CodaLineTypeDescr], [DocXRef], [DocCurrencyAmount], [DocDualCurrencyAmount], [DocAmount], [DocTaxAmount], [FXRate], [TaxLineCode], [TemplateCode], [AuthUser], [OrigUser], [StatUser], [DocApprover], [DocumentDate], [RegistrationDate], [DocInputDate], [DocInputTime], [PaymentDate], [ClearsDate], [ReminderDate], [CodaRef1], [CodaRef2], [CodaRef3], [CodaRef4], [CodaRef5], [CodaRef6], [SalesInvoiceStatus], [PaymentMatchingStatus], [ReconciliationStatus], [ReminderStatus], [DocumentStatus], [WorkFlowStatus], [DocumentMatchUniqueRef], [MatchLevel], [DocLineSeverity], [DocLetterSeverity], [AccountKey_EL12], [AccountCode_EL12], [AccountKey_EL123], [AccountCode_EL123], [DocXRefDescr], [CodaDocListOrder], [DocCurrencyCodeKey], [DocCurrencyCode], [CodaDocLineComment], [CurrentYN], [InsertLoadId], [UpdateLoadId], [InsertTimestamp], [UpdateTimestamp])
        SELECT [CodaDetailsKey],
               [CodaDetailsCode],
               [PipelinePivotKey],
               [PipelinePivotCode],
               [PerformanceRange],
               [PipelineAccountKey_EL1],
               [PipelineAccountCode_El1],
               [PipelineAccountKey_EL2],
               [PipelineAccountCode_El2],
               [PipelineAccountKey_EL3],
               [PipelineAccountCode_El3],
               [PipelineDocCode],
               [PipelineDocNum],
               [CodaCompanyKey],
               [CodaCmpCode],
               [CodaDocumentKey],
               [CodaDocCode],
               [CodaDocNum],
               [CodaDocLinenum],
               [CodaHeaderModifiedDate],
               [CodaLineModifiedDate],
               [CodaOrigCmpCode],
               [CodaOrigDocCode],
               [CodaOrigDocNum],
               [OriginatingDocument],
               [CodaFiscalPeriod],
               [CodaFiscalYear],
               [CodaFiscalDate],
               [CodaLineUserName],
               [CustomerSupplierFlag],
               [DocAccount],
               [AccountKey_EL1],
               [AccountCode_EL1],
               [AccountKey_EL2],
               [AccountCode_EL2],
               [AccountKey_EL3],
               [AccountCode_EL3],
               [AccountKey_EL4],
               [AccountCode_EL4],
               [AccountKey_EL5],
               [AccountCode_EL5],
               [AccountKey_EL6],
               [AccountCode_EL6],
               [ExchangeRate],
               [DebitCredit],
               [CodaHeaderDescr],
               [CodaLineDescr],
               [CodaLineType],
               [CodaLineTypeDescr],
               [DocXRef],
               [DocCurrencyAmount],
               [DocDualCurrencyAmount],
               [DocAmount],
               [DocTaxAmount],
               [FXRate],
               [TaxLineCode],
               [TemplateCode],
               [AuthUser],
               [OrigUser],
               [StatUser],
               [DocApprover],
               [DocumentDate],
               [RegistrationDate],
               [DocInputDate],
               [DocInputTime],
               [PaymentDate],
               [ClearsDate],
               [ReminderDate],
               [CodaRef1],
               [CodaRef2],
               [CodaRef3],
               [CodaRef4],
               [CodaRef5],
               [CodaRef6],
               [SalesInvoiceStatus],
               [PaymentMatchingStatus],
               [ReconciliationStatus],
               [ReminderStatus],
               [DocumentStatus],
               [WorkFlowStatus],
               [DocumentMatchUniqueRef],
               [MatchLevel],
               [DocLineSeverity],
               [DocLetterSeverity],
               [AccountKey_EL12],
               [AccountCode_EL12],
               [AccountKey_EL123],
               [AccountCode_EL123],
               [DocXRefDescr],
               [CodaDocListOrder],
               [DocCurrencyCodeKey],
               [DocCurrencyCode],
               [CodaDocLineComment],
               [CurrentYN],
               [InsertLoadId],
               [UpdateLoadId],
               [InsertTimestamp],
               [UpdateTimestamp]
        FROM   [CodaWarehouse].[FactTransactions];
    END

DROP TABLE [CodaWarehouse].[FactTransactions];

EXECUTE sp_rename N'[CodaWarehouse].[tmp_ms_xx_FactTransactions]', N'FactTransactions';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Creating [CodaWarehouse].[FactTransactions].[IX_AccountID_EL1]...';


GO
CREATE NONCLUSTERED INDEX [IX_AccountID_EL1]
    ON [CodaWarehouse].[FactTransactions]([AccountKey_EL1] ASC);


GO
PRINT N'Creating [CodaWarehouse].[FactTransactions].[IX_AccountID_EL2]...';


GO
CREATE NONCLUSTERED INDEX [IX_AccountID_EL2]
    ON [CodaWarehouse].[FactTransactions]([AccountKey_EL2] ASC);


GO
PRINT N'Creating [CodaWarehouse].[FactTransactions].[IX_CodaDetailsID]...';


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_CodaDetailsID]
    ON [CodaWarehouse].[FactTransactions]([CodaDetailsKey] ASC) WITH (IGNORE_DUP_KEY = ON);


GO
PRINT N'Creating [CodaWarehouse].[FactTransactions].[IX_CodaFiscalDate]...';


GO
CREATE NONCLUSTERED INDEX [IX_CodaFiscalDate]
    ON [CodaWarehouse].[FactTransactions]([CodaFiscalDate] ASC);


GO
PRINT N'Creating [CodaWarehouse].[FactTransactions].[IX_CurrencyCode]...';


GO
CREATE NONCLUSTERED INDEX [IX_CurrencyCode]
    ON [CodaWarehouse].[FactTransactions]([DocCurrencyCode] ASC);


GO
PRINT N'Creating [CodaWarehouse].[FactTransactions].[IX_FactTransactions]...';


GO
CREATE NONCLUSTERED INDEX [IX_FactTransactions]
    ON [CodaWarehouse].[FactTransactions]([CodaCmpCode] ASC, [CodaFiscalYear] ASC);


GO
PRINT N'Creating [CodaWarehouse].[FactTransactions].[IX_FactTransactions_Account]...';


GO
CREATE NONCLUSTERED INDEX [IX_FactTransactions_Account]
    ON [CodaWarehouse].[FactTransactions]([AccountCode_EL1] ASC);


GO
PRINT N'Creating [CodaWarehouse].[FactTransactions].[IX_ModifiedDates]...';


GO
CREATE NONCLUSTERED INDEX [IX_ModifiedDates]
    ON [CodaWarehouse].[FactTransactions]([CodaHeaderModifiedDate] ASC, [CodaLineModifiedDate] ASC);


GO
PRINT N'Creating [CodaWarehouse].[FactTransactions].[IX_PipelineEl1]...';


GO
CREATE NONCLUSTERED INDEX [IX_PipelineEl1]
    ON [CodaWarehouse].[FactTransactions]([PipelineAccountKey_EL1] ASC);


GO
PRINT N'Creating [CodaWarehouse].[FactTransactions].[IX_PipelineEl2]...';


GO
CREATE NONCLUSTERED INDEX [IX_PipelineEl2]
    ON [CodaWarehouse].[FactTransactions]([PipelineAccountKey_EL2] ASC);


GO
PRINT N'Creating [CodaWarehouse].[FactTransactions].[IX_PipelinePivotID]...';


GO
CREATE NONCLUSTERED INDEX [IX_PipelinePivotID]
    ON [CodaWarehouse].[FactTransactions]([PipelinePivotKey] ASC);


GO
PRINT N'Creating [CodaWarehouse].[FactTransactions].[IX_SummaryReport]...';


GO
CREATE NONCLUSTERED INDEX [IX_SummaryReport]
    ON [CodaWarehouse].[FactTransactions]([CodaFiscalYear] ASC, [CodaCmpCode] ASC)
    INCLUDE([CodaDetailsKey], [CodaLineModifiedDate], [DocAmount]);


GO
PRINT N'Refreshing [CodaTabular].[DimCodaEL1]...';


GO
EXECUTE sp_refreshsqlmodule N'[CodaTabular].[DimCodaEL1]';


GO
PRINT N'Refreshing [CodaTabular].[DimCodaEL2]...';


GO
EXECUTE sp_refreshsqlmodule N'[CodaTabular].[DimCodaEL2]';


GO
PRINT N'Refreshing [CodaTabular].[DimCurrency]...';


GO
EXECUTE sp_refreshsqlmodule N'[CodaTabular].[DimCurrency]';


GO
PRINT N'Refreshing [CodaTabular].[DimPipelineEL1]...';


GO
EXECUTE sp_refreshsqlmodule N'[CodaTabular].[DimPipelineEL1]';


GO
PRINT N'Refreshing [CodaTabular].[DimPipelineEL2]...';


GO
EXECUTE sp_refreshsqlmodule N'[CodaTabular].[DimPipelineEL2]';


GO
PRINT N'Refreshing [CodaTabular].[FactBalanceSheetDefinition]...';


GO
EXECUTE sp_refreshsqlmodule N'[CodaTabular].[FactBalanceSheetDefinition]';


GO
PRINT N'Refreshing [CodaTabular].[FactRevenueDefinition]...';


GO
EXECUTE sp_refreshsqlmodule N'[CodaTabular].[FactRevenueDefinition]';


GO
PRINT N'Refreshing [IFR].[v_GetCodaTransactionsFromFdm]...';


GO
EXECUTE sp_refreshsqlmodule N'[IFR].[v_GetCodaTransactionsFromFdm]';


GO
PRINT N'Altering [CodaTabular].[DimDates]...';


GO





ALTER  VIEW [CodaTabular].[DimDates]
AS  
	SELECT 
	*
	,MonthYearName as MonthNameOfYear
		  ,CASE  
		  WHEN DATEDIFF(MONTH, [DateDt], GetDate()) BETWEEN -9999 and 11 then '<1 Year'
		  WHEN DATEDIFF(MONTH, [DateDt], GetDate()) BETWEEN 12 and 24 then '1-2 Years'
		  WHEN DATEDIFF(MONTH, [DateDt], GetDate()) BETWEEN 24 and 9999 then '2> Years'
		  ELSE 'Other' END as DateAgeing

  FROM [CodaWarehouse].[DimDates]
GO
PRINT N'Altering [CodaTabular].[FactFinancials]...';


GO


ALTER VIEW [CodaTabular].[FactFinancials]
AS  
	SELECT TOP 10000
	   fct.[CodaDetailsKey]
      ,[CodaDetailsCode]
      ,[PipelinePivotKey]
      ,[PipelinePivotCode]
      ,[PerformanceRange]
      ,[PipelineAccountKey_EL1] 
      ,[PipelineAccountCode_El1] 
      ,[PipelineAccountKey_EL2] 
      ,[PipelineAccountCode_El2] 
      ,[PipelineAccountKey_EL3] 
      ,[PipelineAccountCode_El3] 
      ,[PipelineDocCode]
      ,[PipelineDocNum]
      ,isnull([CodaCompanyKey],-1) as [CodaCompanyKey] 
      ,[CodaCmpCode]
      ,isnull([CodaDocumentKey],-1) as [CodaDocumentKey] 
      ,[CodaDocCode]
      ,[CodaDocNum]
      ,[CodaDocLinenum]
	  ,[CodaDocLineComment]
      ,[CodaDocListOrder]
      ,[CodaHeaderModifiedDate]
      ,[CodaLineModifiedDate]
      ,[CodaOrigCmpCode]
      ,[CodaOrigDocCode]
      ,[CodaOrigDocNum]
      ,[OriginatingDocument]
      ,[CodaFiscalPeriod]
      ,[CodaFiscalYear]
      ,[CodaFiscalDate]
      ,[CodaLineUserName]
      ,[CustomerSupplierFlag]
      ,[DocAccount]
      ,[AccountKey_EL1] 
      ,[AccountCode_EL1] 
      ,[AccountKey_EL2] 
      ,[AccountCode_EL2] 
      ,[AccountKey_EL3] 
      ,[AccountCode_EL3]
      ,[AccountKey_EL4] 
      ,[AccountCode_EL4] 
      ,[AccountKey_EL5] 
      ,[AccountCode_EL5] 
      ,[AccountKey_EL6]
      ,[AccountCode_EL6] 
      ,[AccountKey_EL12]
      ,[AccountKey_EL123]
      ,isnull([DocCurrencyCodeKey],-1) as [DocCurrencyCodeKey] 
      ,[DocCurrencyCode]
      ,cast([ExchangeRate]/10000000 as decimal(9,5)) as [ExchangeRate]
      ,[DebitCredit]
      ,[CodaHeaderDescr]
      ,[CodaLineDescr]
      ,[CodaLineType]
      ,[CodaLineTypeDescr]
      ,[DocXRef]
      ,[DocXRefDescr]
      ,[DocCurrencyAmount]
      ,[DocDualCurrencyAmount]
      ,[DocAmount]
	  ,[DocAmount] * lkp1.IsRevenue as DocAmountRevenue
	  ,[DocAmount] * lkp2.IsBalanceSheet as DocAmountBalanceSheet
      ,[DocTaxAmount]
      --,[FXRate] Needs Removing This Field is a Duplicate of ExchangeRate
      ,[TaxLineCode]
      ,[TemplateCode]
      ,[AuthUser]
      ,[OrigUser]
      ,[StatUser]
      ,[DocApprover]
      ,[DocumentDate]
      ,[RegistrationDate]
      ,[DocInputDate]
      ,[DocInputTime]
      ,[PaymentDate]
      ,[ClearsDate] as [ValueDate] --Change 2018APR
      ,[ReminderDate]
	  	  
	  --Value Date Aging  --Change 2018APR
	  		  ,CASE  
		  WHEN DATEDIFF(MONTH, [ClearsDate], GetDate()) BETWEEN -9999 and 11 then '<1 Year'
		  WHEN DATEDIFF(MONTH, [ClearsDate], GetDate()) BETWEEN 12 and 24 then '1-2 Years'
		  WHEN DATEDIFF(MONTH, [ClearsDate], GetDate()) BETWEEN 24 and 9999 then '2> Years'
		  ELSE 'Other' END as ValueDateAgeing

	  --Paid/Unpaid --Change 2018APR
	  ,case [CodaRef2] 
						when 'P' then 'Paid' 
						when 'U' then 'Unpaid' 
					else NULL
				end  as InvoicePaidStatus 
	  --Held Reason PRS 410/414/ MCPS 411/413/414 --Change 2018APR
	  ,case when AccountKey_EL1 in (-6197557476500757963, -3953940277789029555, 1211753744370998085, 5306900047198564451, -2967453201623546202)
	  then
	  		case [CodaRef1]
			when 'Data Issue' then 'Data Issue' 
			when 'Policy Issue' then 'Policy Issue' 
			when 'Residuals' then 'Residuals'
			when 'Licensing' then 'Licensing'
		else 'Other' end
	  end as HeldReason

      ,[CodaRef1]
      ,[CodaRef2]
      ,[CodaRef3]
      ,[CodaRef4]
      ,[CodaRef5]
      ,[CodaRef6]
	  --Transform Status int to Usable Report Char

      ,case [SalesInvoiceStatus]
			when 2415 then 'Not Yet Invoiced'
			when 2416 then 'Partially invoiced'
			when 2417 then 'Awaiting authorisation'
			when 2418 then 'Awaiting preview'
			when 2419 then 'Fully Invoiced'
		else 'Unknown' end as [SalesInvoiceStatus]

      ,case [PaymentMatchingStatus]
			when 84 then 'A - Available'
			when 87 then 'H - Held'
			when 88 then 'N - Proposed by bill'
			when 89 then 'P - Paid'
			when 93 then 'R - Proposed in Pay list'
			when 648 then 'S - Payment suppressed'
			when 665 then 'C - Cancel matched'
			when 171 then 'X - Not Matchable'
			when 369 then 'D - Draft Available'
			when 420 then 'B - Draft Paid'
			when 506 then 'J - Draft Held'
		else 'Unknown' end as [PaymentMatchingStatus]

      ,case [ReconciliationStatus]
			when 84 then 'Available'
			when 86 then 'Reconciled'
		else 'Unknown' end as [ReconciliationStatus]

      ,case [ReminderStatus]
			when 1 then 'Yes'
			when 0 then 'No'
		else 'Unknown' end as [ReminderStatus]
		
      ,case [DocumentStatus]
			when 78 then 'Posted'
			when 79 then 'Cancelled'
		else 'Unknown' end as [DocumentStatus]

      ,case [WorkFlowStatus]
			when 530 then 'None'
			when 531 then 'In progress'
			when 532 then '(Authorised'
			when 533 then 'Authorisation failed'
		else 'Unknown' end as [WorkFlowStatus]

      ,[DocumentMatchUniqueRef]
      ,[MatchLevel]
      ,[DocLineSeverity]
      ,[DocLetterSeverity]
      ,[CurrentYN]
      ,[InsertLoadId]
      ,[UpdateLoadId]
      ,[InsertTimestamp]
      ,[UpdateTimestamp]
  FROM [CodaWarehouse].FactTransactions fct WITH (NOLOCK)
	LEFT JOIN [CodaTabular].[FactRevenueDefinition] lkp1 WITH (NOLOCK) ON fct.[CodaDetailsKey] = lkp1.[CodaDetailsKey]
	LEFT JOIN [CodaTabular].[FactBalanceSheetDefinition] lkp2 WITH (NOLOCK) ON fct.[CodaDetailsKey] = lkp2.[CodaDetailsKey]


	where CodaRef2 = 'P'
GO
PRINT N'Altering [CodaWarehouse].[LoadChangedFactTransactions]...';


GO






/*
 * Load changed Warehouse.FactTransactions from Clean using a SCD Type 1 pattern
 * Test:    EXEC CodaWarehouse.LoadChangedFactTransactions @pBatchId = 123, @pLoadId = 321, @pUpdateRowCount = 0
 */
ALTER PROCEDURE [CodaWarehouse].[LoadChangedFactTransactions]
  @pBatchId			varchar(10),
  @pLoadId			int,
  @pUpdateRowCount	bigint OUT
AS
BEGIN
  /*
   * Update existing rows if they have changed
   */
  UPDATE CodaWarehouse.FactTransactions		
     SET	
         CodaWarehouse.FactTransactions.[CodaDetailsCode]  = cttrn.[CodaDetailsCode]      , 
         CodaWarehouse.FactTransactions.[PipelinePivotKey]  = cttrn.[PipelinePivot_KEY]      , 
         CodaWarehouse.FactTransactions.[PipelinePivotCode]  = cttrn.[PipelinePivotCode]      , 
         CodaWarehouse.FactTransactions.[PerformanceRange]  = cttrn.[PerformanceRange]      , 
         CodaWarehouse.FactTransactions.[PipelineAccountKey_EL1]  = cttrn.[PipelineAccountEL1_KEY]      , 
         CodaWarehouse.FactTransactions.[PipelineAccountCode_El1]  = cttrn.[PipelineAccountCode_El1]      , 
         CodaWarehouse.FactTransactions.[PipelineAccountKey_EL2]  = cttrn.[PipelineAccountEL2_KEY]      , 
         CodaWarehouse.FactTransactions.[PipelineAccountCode_El2]  = cttrn.[PipelineAccountCode_El2]      , 
         CodaWarehouse.FactTransactions.[PipelineAccountKey_EL3]  = cttrn.[PipelineAccountEL3_KEY]      , 
         CodaWarehouse.FactTransactions.[PipelineAccountCode_El3]  = cttrn.[PipelineAccountCode_El3]      , 
         CodaWarehouse.FactTransactions.[PipelineDocCode]  = cttrn.[PipelineDocCode]      , 
         CodaWarehouse.FactTransactions.[PipelineDocNum]  = cttrn.[PipelineDocNum]      , 
         CodaWarehouse.FactTransactions.[CodaCompanyKey]  = cttrn.[CodaCompany_KEY]      , 
         CodaWarehouse.FactTransactions.[CodaCmpCode]  = cttrn.[CodaCmpCode]      , 
         CodaWarehouse.FactTransactions.[CodaDocumentKey]  = cttrn.[CodaDocument_KEY]      , 
         CodaWarehouse.FactTransactions.[CodaDocCode]  = cttrn.[CodaDocCode]      , 
         CodaWarehouse.FactTransactions.[CodaDocNum]  = cttrn.[CodaDocNum]      , 
         CodaWarehouse.FactTransactions.[CodaDocLinenum]  = cttrn.[CodaDocLinenum]      ,
	     CodaWarehouse.FactTransactions.[CodaDocListOrder]  = cttrn.[CodaDocListOrder]      ,	  
	     CodaWarehouse.FactTransactions.CodaDocLineComment = cttrn.CodaDocLineComment      ,	 
         CodaWarehouse.FactTransactions.[CodaHeaderModifiedDate]  = cttrn.[CodaHeaderModifiedDate]      , 
         CodaWarehouse.FactTransactions.[CodaLineModifiedDate]  = cttrn.[CodaLineModifiedDate]      , 
         CodaWarehouse.FactTransactions.[CodaOrigCmpCode]  = cttrn.[CodaOrigCmpCode]      , 
         CodaWarehouse.FactTransactions.[CodaOrigDocCode]  = cttrn.[CodaOrigDocCode]      , 
         CodaWarehouse.FactTransactions.[CodaOrigDocNum]  = cttrn.[CodaOrigDocNum]      , 
         CodaWarehouse.FactTransactions.[OriginatingDocument]  = cttrn.[OriginatingDocument]      , 
         CodaWarehouse.FactTransactions.[CodaFiscalPeriod]  = cttrn.[CodaFiscalPeriod]      , 
         CodaWarehouse.FactTransactions.[CodaFiscalYear]  = cttrn.[CodaFiscalYear]      , 
         CodaWarehouse.FactTransactions.[CodaFiscalDate]  = cttrn.[CodaFiscalDate]      , 
         CodaWarehouse.FactTransactions.[CodaLineUserName]  = cttrn.[CodaLineUserName]      , 
         CodaWarehouse.FactTransactions.[CustomerSupplierFlag]  = cttrn.[CustomerSupplierFlag]      , 
         CodaWarehouse.FactTransactions.[DocAccount]  = cttrn.[DocAccount]      , 
         CodaWarehouse.FactTransactions.[AccountKey_EL1]  = cttrn.[AccountEL1_KEY]      , 
         CodaWarehouse.FactTransactions.[AccountCode_EL1]  = cttrn.[AccountCode_EL1]      , 
         CodaWarehouse.FactTransactions.[AccountKey_EL2]  = cttrn.[AccountEL2_KEY]      , 
         CodaWarehouse.FactTransactions.[AccountCode_EL2]  = cttrn.[AccountCode_EL2]      , 
         CodaWarehouse.FactTransactions.[AccountKey_EL3]  = cttrn.[AccountEL3_KEY]      , 
         CodaWarehouse.FactTransactions.[AccountCode_EL3]  = cttrn.[AccountCode_EL3]      , 
         CodaWarehouse.FactTransactions.[AccountKey_EL4]  = cttrn.[AccountEL4_KEY]      , 
         CodaWarehouse.FactTransactions.[AccountCode_EL4]  = cttrn.[AccountCode_EL4]      , 
         CodaWarehouse.FactTransactions.[AccountKey_EL5]  = cttrn.[AccountEL5_KEY]      , 
         CodaWarehouse.FactTransactions.[AccountCode_EL5]  = cttrn.[AccountCode_EL5]      , 
         CodaWarehouse.FactTransactions.[AccountKey_EL6]  = cttrn.[AccountEL6_KEY]      , 
         CodaWarehouse.FactTransactions.[AccountCode_EL6]  = cttrn.[AccountCode_EL6]      , 
         CodaWarehouse.FactTransactions.[AccountKey_EL12]  = cttrn.[AccountEL12_KEY]      , 
         CodaWarehouse.FactTransactions.[AccountCode_EL12]  = cttrn.[AccountCode_EL12]      , 
         CodaWarehouse.FactTransactions.[AccountKey_EL123]  = cttrn.[AccountEL123_KEY]      , 
         CodaWarehouse.FactTransactions.[AccountCode_EL123]  = cttrn.[AccountCode_EL123]      , 
         CodaWarehouse.FactTransactions.[DocCurrencyCodeKey]  = cttrn.[DocCurrency_KEY]      , 
         CodaWarehouse.FactTransactions.[DocCurrencyCode]  = cttrn.[DocCurrencyCode]      , 
         CodaWarehouse.FactTransactions.[ExchangeRate]  = cttrn.[ExchangeRate]      , 
         CodaWarehouse.FactTransactions.[DebitCredit]  = cttrn.[DebitCredit]      , 	
         CodaWarehouse.FactTransactions.[CodaHeaderDescr]  = cttrn.[CodaHeaderDescr]      , 
         CodaWarehouse.FactTransactions.[CodaLineDescr]  = cttrn.[CodaLineDescr]      , 
         CodaWarehouse.FactTransactions.[CodaLineType]  = cttrn.[CodaLineType]      , 
         CodaWarehouse.FactTransactions.[CodaLineTypeDescr]  = cttrn.[CodaLineTypeDescr]      , 
         CodaWarehouse.FactTransactions.[DocXRef]  = cttrn.[DocXRef]      , 
         CodaWarehouse.FactTransactions.[DocXRefDescr]  = cttrn.DocXRefDescr      , 
         CodaWarehouse.FactTransactions.[DocCurrencyAmount]  = cttrn.[DocCurrencyAmount]      , 
         CodaWarehouse.FactTransactions.[DocDualCurrencyAmount]  = cttrn.[DocDualCurrencyAmount]      , 
         CodaWarehouse.FactTransactions.[DocAmount]  = cttrn.[DocAmount]      , 
         CodaWarehouse.FactTransactions.[DocTaxAmount]  = cttrn.[DocTaxAmount]      , 
         CodaWarehouse.FactTransactions.[FXRate]  = cttrn.[FXRate]      , 
         CodaWarehouse.FactTransactions.[TaxLineCode]  = cttrn.[TaxLineCode]      , 
         CodaWarehouse.FactTransactions.[TemplateCode]  = cttrn.[TemplateCode]      , 
         CodaWarehouse.FactTransactions.[AuthUser]  = cttrn.[AuthUser]      , 
         CodaWarehouse.FactTransactions.[OrigUser]  = cttrn.[OrigUser]      , 
         CodaWarehouse.FactTransactions.[StatUser]  = cttrn.[StatUser]      , 
         CodaWarehouse.FactTransactions.[DocApprover]  = cttrn.[DocApprover]      , 
         CodaWarehouse.FactTransactions.[DocumentDate]  = cttrn.[DocumentDate]      , 	
         CodaWarehouse.FactTransactions.[DocInputDate]  = cttrn.[DocInputDate]      , 
         CodaWarehouse.FactTransactions.[DocInputTime]  = cttrn.[DocInputTime]      , 
         CodaWarehouse.FactTransactions.[ReminderDate]  = cttrn.[ReminderDate]      , 
         CodaWarehouse.FactTransactions.[CodaRef1]  = cttrn.[CodaRef1]      , 
         CodaWarehouse.FactTransactions.[CodaRef2]  = cttrn.[CodaRef2]      , 
         CodaWarehouse.FactTransactions.[CodaRef3]  = cttrn.[CodaRef3]      , 
         CodaWarehouse.FactTransactions.[CodaRef4]  = cttrn.[CodaRef4]      , 
         CodaWarehouse.FactTransactions.[CodaRef5]  = cttrn.[CodaRef5]      , 
         CodaWarehouse.FactTransactions.[CodaRef6]  = cttrn.[CodaRef6]      ,	
		 --Added APR 2018
         CodaWarehouse.FactTransactions.SalesInvoiceStatus  = cttrn.SalesInvoiceStatus      ,
         CodaWarehouse.FactTransactions.PaymentMatchingStatus = cttrn.PaymentMatchingStatus      ,
         CodaWarehouse.FactTransactions.ReconciliationStatus = cttrn.ReconciliationStatus      ,
         CodaWarehouse.FactTransactions.ReminderStatus = cttrn.ReminderStatus      ,
         CodaWarehouse.FactTransactions.DocumentStatus = cttrn.DocumentStatus      ,
         CodaWarehouse.FactTransactions.WorkFlowStatus = cttrn.WorkFlowStatus      ,
         CodaWarehouse.FactTransactions.MatchLevel = cttrn.MatchLevel      ,
         CodaWarehouse.FactTransactions.DocLineSeverity = cttrn.DocLineSeverity      ,
         CodaWarehouse.FactTransactions.DocLetterSeverity = cttrn.DocLetterSeverity      ,
         CodaWarehouse.FactTransactions.PaymentDate = cttrn.PaymentDate      ,
         CodaWarehouse.FactTransactions.ClearsDate = cttrn.ClearsDate      ,
         CodaWarehouse.FactTransactions.RegistrationDate = cttrn.RegistrationDate      ,

		 CodaWarehouse.FactTransactions.[UpdateLoadId]		= @pLoadId,
		 CodaWarehouse.FactTransactions.[UpdateTimestamp] = SYSDATETIME()
    FROM FinanceStage.CodaTransform.Fact_Transactions cttrn	
   WHERE cttrn.CodaDetails_KEY = CodaWarehouse.FactTransactions.CodaDetailsKey
     AND cttrn.RejectRowYN = 'N'
	 AND (		
		 (isnull(CodaWarehouse.FactTransactions.[CodaDetailsCode],0)   <>   isnull(cttrn.[CodaDetailsCode],0)      ) OR  
         (isnull(CodaWarehouse.FactTransactions.[PipelinePivotKey],0)   <>   isnull(cttrn.[PipelinePivot_KEY],0)      ) OR  
         (isnull(CodaWarehouse.FactTransactions.[PipelinePivotCode],0)   <>   isnull(cttrn.[PipelinePivotCode],0)      ) OR  
         (isnull(CodaWarehouse.FactTransactions.[PerformanceRange],0)   <>   isnull(cttrn.[PerformanceRange],0)      ) OR  
         (isnull(CodaWarehouse.FactTransactions.[PipelineAccountKey_EL1],0)   <>   isnull(cttrn.[PipelineAccountEL1_KEY],0)      ) OR  
         (isnull(CodaWarehouse.FactTransactions.[PipelineAccountKey_EL2],0)   <>   isnull(cttrn.[PipelineAccountEL2_KEY],0)      ) OR  
         (isnull(CodaWarehouse.FactTransactions.[PipelineAccountKey_EL3],0)   <>   isnull(cttrn.[PipelineAccountEL3_KEY],0)      ) OR  
         (isnull(CodaWarehouse.FactTransactions.[PipelineDocCode],0)   <>   isnull(cttrn.[PipelineDocCode],0)      ) OR  
         (isnull(CodaWarehouse.FactTransactions.[PipelineDocNum],0)   <>   isnull(cttrn.[PipelineDocNum],0)      ) OR  
         (isnull(CodaWarehouse.FactTransactions.[CodaCompanyKey],0)   <>   isnull(cttrn.[CodaCompany_KEY],0)      ) OR  
         (isnull(CodaWarehouse.FactTransactions.[CodaCmpCode],0)   <>   isnull(cttrn.[CodaCmpCode],0)      ) OR  
         (isnull(CodaWarehouse.FactTransactions.[CodaDocumentKey],0)   <>   isnull(cttrn.[CodaDocument_KEY],0)      ) OR  
         (isnull(CodaWarehouse.FactTransactions.[CodaDocCode],0)   <>   isnull(cttrn.[CodaDocCode],0)      ) OR  
         (isnull(CodaWarehouse.FactTransactions.[CodaDocNum],0)   <>   isnull(cttrn.[CodaDocNum],0)      ) OR  
         (isnull(CodaWarehouse.FactTransactions.[CodaDocLinenum],0)   <>   isnull(cttrn.[CodaDocLinenum],0)      ) OR  
         (isnull(CodaWarehouse.FactTransactions.[CodaDocListOrder],0)   <>   isnull(cttrn.[CodaDocListOrder],0)      ) OR  
         (isnull(CodaWarehouse.FactTransactions.CodaDocLineComment,0)   <>   isnull(cttrn.CodaDocLineComment,0)      ) OR  
         (isnull(CodaWarehouse.FactTransactions.[CodaHeaderModifiedDate],0)   <>   isnull(cttrn.[CodaHeaderModifiedDate],0)      ) OR  
         (isnull(CodaWarehouse.FactTransactions.[CodaLineModifiedDate],0)   <>   isnull(cttrn.[CodaLineModifiedDate],0)      ) OR  
         (isnull(CodaWarehouse.FactTransactions.[CodaOrigCmpCode],0)   <>   isnull(cttrn.[CodaOrigCmpCode],0)      ) OR  
         (isnull(CodaWarehouse.FactTransactions.[CodaOrigDocCode],0)   <>   isnull(cttrn.[CodaOrigDocCode],0)      ) OR  
         (isnull(CodaWarehouse.FactTransactions.[CodaOrigDocNum],0)   <>   isnull(cttrn.[CodaOrigDocNum],0)      ) OR  
         (isnull(CodaWarehouse.FactTransactions.[OriginatingDocument],0)   <>   isnull(cttrn.[OriginatingDocument],0)      ) OR  
         (isnull(CodaWarehouse.FactTransactions.[CodaFiscalPeriod],0)   <>   isnull(cttrn.[CodaFiscalPeriod],0)      ) OR  
         (isnull(CodaWarehouse.FactTransactions.[CodaFiscalYear],0)   <>   isnull(cttrn.[CodaFiscalYear],0)      ) OR  
         (isnull(CodaWarehouse.FactTransactions.[CodaFiscalDate],0)   <>   isnull(cttrn.[CodaFiscalDate],0)      ) OR  
         (isnull(CodaWarehouse.FactTransactions.[CodaLineUserName],0)   <>   isnull(cttrn.[CodaLineUserName],0)      ) OR  
         (isnull(CodaWarehouse.FactTransactions.[CustomerSupplierFlag],0)   <>   isnull(cttrn.[CustomerSupplierFlag],0)      ) OR  
         (isnull(CodaWarehouse.FactTransactions.[DocAccount],0)   <>   isnull(cttrn.[DocAccount],0)      ) OR  
         (isnull(CodaWarehouse.FactTransactions.[AccountKey_EL1],0)   <>   isnull(cttrn.[AccountEL1_KEY],0)      ) OR  
         (isnull(CodaWarehouse.FactTransactions.[AccountKey_EL2],0)   <>   isnull(cttrn.[AccountEL2_KEY],0)      ) OR  
         (isnull(CodaWarehouse.FactTransactions.[AccountKey_EL3],0)   <>   isnull(cttrn.[AccountEL3_KEY],0)      ) OR  
         (isnull(CodaWarehouse.FactTransactions.[AccountKey_EL4],0)   <>   isnull(cttrn.[AccountEL4_KEY],0)      ) OR  
         (isnull(CodaWarehouse.FactTransactions.[AccountKey_EL5],0)   <>   isnull(cttrn.[AccountEL5_KEY],0)      ) OR  
         (isnull(CodaWarehouse.FactTransactions.[AccountKey_EL6],0)   <>   isnull(cttrn.[AccountEL6_KEY],0)      ) OR  
         (isnull(CodaWarehouse.FactTransactions.[DocCurrencyCodeKey] ,0)   <>   isnull(cttrn.[DocCurrency_KEY],0)      ) OR  
         (isnull(CodaWarehouse.FactTransactions.[ExchangeRate],0)   <>   isnull(cttrn.[ExchangeRate],0)      ) OR  
         (isnull(CodaWarehouse.FactTransactions.[DebitCredit],0)   <>   isnull(cttrn.[DebitCredit],0)      ) OR  	
         (isnull(CodaWarehouse.FactTransactions.[CodaHeaderDescr],0)   <>   isnull(cttrn.[CodaHeaderDescr],0)      ) OR  
         (isnull(CodaWarehouse.FactTransactions.[CodaLineDescr],0)   <>   isnull(cttrn.[CodaLineDescr],0)      ) OR  
         (isnull(CodaWarehouse.FactTransactions.[CodaLineType],0)   <>   isnull(cttrn.[CodaLineType],0)      ) OR  
         (isnull(CodaWarehouse.FactTransactions.[CodaLineTypeDescr],0)   <>   isnull(cttrn.[CodaLineTypeDescr],0)      ) OR  
         (isnull(CodaWarehouse.FactTransactions.[DocXRef],0)   <>   isnull(cttrn.[DocXRef],0)      ) OR  
         (isnull(CodaWarehouse.FactTransactions.[DocCurrencyAmount],0)   <>   isnull(cttrn.[DocCurrencyAmount],0)      ) OR  
         (isnull(CodaWarehouse.FactTransactions.[DocDualCurrencyAmount],0)   <>   isnull(cttrn.[DocDualCurrencyAmount],0)      ) OR  
         (isnull(CodaWarehouse.FactTransactions.[DocAmount],0)   <>   isnull(cttrn.[DocAmount],0)      ) OR  
         (isnull(CodaWarehouse.FactTransactions.[DocTaxAmount],0)   <>   isnull(cttrn.[DocTaxAmount],0)      ) OR  
         (isnull(CodaWarehouse.FactTransactions.[FXRate],0)   <>   isnull(cttrn.[FXRate],0)      ) OR  
         (isnull(CodaWarehouse.FactTransactions.[TaxLineCode],0)   <>   isnull(cttrn.[TaxLineCode],0)      ) OR  
         (isnull(CodaWarehouse.FactTransactions.[TemplateCode],0)   <>   isnull(cttrn.[TemplateCode],0)      ) OR  
         (isnull(CodaWarehouse.FactTransactions.[AuthUser],0)   <>   isnull(cttrn.[AuthUser],0)      ) OR  
         (isnull(CodaWarehouse.FactTransactions.[OrigUser],0)   <>   isnull(cttrn.[OrigUser],0)      ) OR  
         (isnull(CodaWarehouse.FactTransactions.[StatUser],0)   <>   isnull(cttrn.[StatUser],0)      ) OR  
         (isnull(CodaWarehouse.FactTransactions.[DocApprover],0)   <>   isnull(cttrn.[DocApprover],0)      ) OR  
         (isnull(CodaWarehouse.FactTransactions.[DocumentDate],0)   <>   isnull(cttrn.[DocumentDate],0)      ) OR  	
         (isnull(CodaWarehouse.FactTransactions.[DocInputDate],0)   <>   isnull(cttrn.[DocInputDate],0)      ) OR  
         (isnull(CodaWarehouse.FactTransactions.[DocInputTime],0)   <>   isnull(cttrn.[DocInputTime],0)      ) OR  
         (isnull(CodaWarehouse.FactTransactions.[ReminderDate],0)   <>   isnull(cttrn.[ReminderDate],0)      ) OR  
         (isnull(CodaWarehouse.FactTransactions.[CodaRef1],0)   <>   isnull(cttrn.[CodaRef1],0)      ) OR  
         (isnull(CodaWarehouse.FactTransactions.[CodaRef2],0)   <>   isnull(cttrn.[CodaRef2],0)      ) OR  
         (isnull(CodaWarehouse.FactTransactions.[CodaRef3],0)   <>   isnull(cttrn.[CodaRef3],0)      ) OR  
         (isnull(CodaWarehouse.FactTransactions.[CodaRef4],0)   <>   isnull(cttrn.[CodaRef4],0)      ) OR  
         (isnull(CodaWarehouse.FactTransactions.[CodaRef5],0)   <>   isnull(cttrn.[CodaRef5],0)      ) OR  
		 --Added APR 2018
         (isnull(CodaWarehouse.FactTransactions.SalesInvoiceStatus,0)   <>   isnull(cttrn.SalesInvoiceStatus,0)      ) OR  
         (isnull(CodaWarehouse.FactTransactions.PaymentMatchingStatus,0)   <>   isnull(cttrn.PaymentMatchingStatus,0)      ) OR  
         (isnull(CodaWarehouse.FactTransactions.ReconciliationStatus,0)   <>   isnull(cttrn.ReconciliationStatus,0)      ) OR  
         (isnull(CodaWarehouse.FactTransactions.ReminderStatus,0)   <>   isnull(cttrn.ReminderStatus,0)      ) OR  
         (isnull(CodaWarehouse.FactTransactions.DocumentStatus,0)   <>   isnull(cttrn.DocumentStatus,0)      ) OR  
         (isnull(CodaWarehouse.FactTransactions.WorkFlowStatus,0)   <>   isnull(cttrn.WorkFlowStatus,0)      ) OR  
         (isnull(CodaWarehouse.FactTransactions.MatchLevel,0)   <>   isnull(cttrn.MatchLevel,0)      ) OR  
         (isnull(CodaWarehouse.FactTransactions.DocLineSeverity,0)   <>   isnull(cttrn.DocLineSeverity,0)      ) OR  
         (isnull(CodaWarehouse.FactTransactions.DocLetterSeverity,0)   <>   isnull(cttrn.DocLetterSeverity,0)      ) OR  
         (isnull(CodaWarehouse.FactTransactions.PaymentDate,0)   <>   isnull(cttrn.PaymentDate,0)      ) OR  
         (isnull(CodaWarehouse.FactTransactions.ClearsDate,0)   <>   isnull(cttrn.ClearsDate,0)      ) OR  
         (isnull(CodaWarehouse.FactTransactions.RegistrationDate,0)   <>   isnull(cttrn.RegistrationDate,0)      ) OR  
         (isnull(CodaWarehouse.FactTransactions.DocCurrencyCode,0)   <>   isnull(cttrn.DocCurrencyCode,0)      ) OR  

         (isnull(CodaWarehouse.FactTransactions.[CodaRef6],0)   <>   isnull(cttrn.[CodaRef6] ,0)      ) 
	     )	

    /* Return the Insert row count */
  SET @pUpdateRowCount = @@ROWCOUNT

END


GO
