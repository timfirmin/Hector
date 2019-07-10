SET IDENTITY_INSERT [Control].[EntityType] ON;
GO
MERGE INTO [Control].[EntityType] AS Tgt
USING 
	(VALUES
		(137,	NULL,	1,		1,		0,		N'ReportsText',								N'dxreportstext',						N'DX Reports Text',												N'DATAXCHANGE',			N'DX_REPORTS_TEXT',							N'Emma.Stewart@prsformusic.com',	SYSDATETIME()),
		(138,	NULL,	1,		1,		0,		N'ReportTypes',								N'dxreporttypes',						N'DX Report Types',												N'DATAXCHANGE',			N'DX_REPORT_TYPES',							N'Emma.Stewart@prsformusic.com',	SYSDATETIME()),
		(518,	-1,		8,		1,		0,		N'SASPayments',								N'saspayments',							N'SAS Payments table',											N'SAS',					N'SAS_PAYMENTS',							N'Emma.Stewart@prsformusic.com',	SYSDATETIME()),
		(519,	-1,		8,		1,		0,		N'SASAccountSummaries',						N'sasaccountsummaries',					N'SAS Account Summaries table',									N'SAS',					N'SAS_ACCOUNT_SUMMARIES',					N'Emma.Stewart@prsformusic.com',	SYSDATETIME()),
		(520,	-1,		8,		1,		0,		N'SASCommissionInvoice',					N'sascommissioninvoice',				N'SAS Commission Invoice table',								N'SAS',					N'SAS_COMMISSION_INVOICE',					N'Emma.Stewart@prsformusic.com',	SYSDATETIME()),
		(521,	-1,		8,		1,		0,		N'SASEarnings',								N'sasearnings',							N'SAS Earnings table',											N'SAS',					N'SAS_EARNINGS',							N'Emma.Stewart@prsformusic.com',	SYSDATETIME()),
		(522,	-1,		8,		1,		0,		N'SASGeneralAdjDetails',					N'sasgeneraladjdetails',				N'SAS General Adj Details table',								N'SAS',					N'SAS_GENERAL_ADJ_DETAILS',					N'Emma.Stewart@prsformusic.com',	SYSDATETIME()),
		(523,	-1,		8,		1,		0,		N'SASStatementSocieties',					N'sasstatementsocieties',				N'SAS Statement Societies table',								N'SAS',					N'SAS_STATEMENT_SOCIETIES',					N'Emma.Stewart@prsformusic.com',	SYSDATETIME()),
		(524,	-1,		8,		1,		0,		N'SASStatements',							N'sasstatements',						N'SAS Statements table',										N'SAS',					N'SAS_STATEMENTS',							N'Emma.Stewart@prsformusic.com',	SYSDATETIME()),
		(525,	-1,		8,		1,		0,		N'SASVATInvoices',							N'sasvatinvoices',						N'SAS VAT Invoices table',										N'SAS',					N'SAS_VAT_INVOICES',						N'Emma.Stewart@prsformusic.com',	SYSDATETIME()),
		(526,	-1,		8,		1,		0,		N'SASNoticeOfPayments',						N'sasnoticeofpayments',					N'SAS Notice Of Payments table',								N'SAS',					N'SAS_NOTICE_OF_PAYMENTS',					N'Emma.Stewart@prsformusic.com',	SYSDATETIME()),
		(720,	-1,		8,		1,		0,		N'SASStatementChanges',						N'sasstatementchanges',					N'SAS Statement Changes table',									N'SAS',					N'SAS_STATEMENT_CHANGES',					N'vandana.bangera@prsformusic.com',	SYSDATETIME()),
		(753,	NULL,	8,		0,		0,		N'AdjustmentLine',							N'AdjustmentLine',						N'Online Statements Adjustment Line',							N'Warehouse',			N'AdjustmentLine',							N'Emma.Stewart@prsformusic.com',	SYSDATETIME()),
		(755,	NULL,	8,		0,		0,		N'CommissionInvoiceLine',					N'CommInvoiceLine',						N'Online Statements Comm Invoice Line',							N'Warehouse',			N'CommissionInvoiceLine',					N'Emma.Stewart@prsformusic.com',	SYSDATETIME()),
		(756,	NULL,	8,		0,		0,		N'GeneralRoyaltyLine',						N'GeneralRoyaltyLine',					N'General Loyalty Line',										N'Warehouse',			N'GeneralRoyaltyLine',						N'Emma.Stewart@prsformusic.com',	SYSDATETIME()),
		(757,	NULL,	8,		0,		0,		N'NopEarningLine',							N'NopEarningLine',						N'Nop Earning Line',											N'Warehouse',			N'NopEarningLine',							N'Emma.Stewart@prsformusic.com',	SYSDATETIME()),
		(759,	NULL,	8,		0,		0,		N'NopPaymentLine',							N'NopPaymentLine',						N'Nop Payment Line',											N'Warehouse',			N'NopPaymentLine',							N'Emma.Stewart@prsformusic.com',	SYSDATETIME()),
		(761,	NULL,	8,		0,		0,		N'OnlineStatement',							N'OnlineStatement',						N'Online Statement',											N'Warehouse',			N'OnlineStatement',							N'Emma.Stewart@prsformusic.com',	SYSDATETIME()),
		(762,	NULL,	8,		0,		0,		N'SourceStatement',							N'SourceStatement',						N'Source Statement',											N'Warehouse',			N'SourceStatement',							N'Emma.Stewart@prsformusic.com',	SYSDATETIME()),
		(763,	NULL,	8,		0,		0,		N'UsageGroupRoyaltyLine',					N'UsageGrpRoyLine',						N'Usage Group Royalty Line',									N'Warehouse',			N'UsgaeGroupRoyaltyLine',					N'Emma.Stewart@prsformusic.com',	SYSDATETIME()),
		(765,	NULL,	8,		0,		0,		N'VATInvoiceLine',							N'VATInvoiceLine',						N'VATInvoiceLine',												N'Warehouse',			N'VATInvoiceLine',							N'Emma.Stewart@prsformusic.com',	SYSDATETIME())
	) AS Src
	(
		 EntityTypeId
		,ParentEntityTypeId
		,ApplicationId
		,IsSourceEntity
		,[HasMultipleSourceFile]
		,Name
		,Code
		,[Description]
		,[Schema]
		,[Table]
		,[CreatedBy]
        ,[CreatedDate]
	)
	ON Tgt.EntityTypeId = Src.EntityTypeId

-- Update matched rows
WHEN MATCHED THEN
	UPDATE
	SET
		[ApplicationId]			= Src.[ApplicationId],
		[IsSourceEntity]	    = Src.[IsSourceEntity],
		[HasMultipleSourceFile]	= Src.[HasMultipleSourceFile],
		[Name]					= Src.[Name],
		[Code]					= Src.[Code],
		[ParentEntityTypeId]	= Src.[ParentEntityTypeId],
		[Description]			= Src.[Description],
		[Schema]				= Src.[Schema],
		[Table]					= Src.[Table],
		[CreatedBy]				= Src.[CreatedBy],
        [CreatedDate]			= Src.[CreatedDate]
;
GO
SET IDENTITY_INSERT [Control].[EntityType] OFF;

