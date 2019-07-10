SET IDENTITY_INSERT [Control].[EntityType] ON;
GO
MERGE INTO [Control].[EntityType] AS Tgt
USING 
	(VALUES
	  --[EI],	[PETI],	[AI],	[IS],	[HMS],	[Name],										[Code],									[Description],													[Schema],				[Table],									[CreatedBy]							[CreatedDate]
		(2001,	NULL,	16,		1,		0,		N'Address',									N'dmsaddress',							N'DMS Address Table',											N'DMOWN',				N'DMS_ADDRESS',								N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2002,	NULL,	16,		1,		0,		N'Country',									N'dmscountry',							N'DMS Country Table',											N'DMOWN',				N'DMS_COUNTRY',								N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2003,	NULL,	16,		1,		0,		N'StatementWorkDetail',						N'dmsstmtwkdt',							N'DMS Statement Work Details',									N'DMOWN',				N'DMS_STMT_WKDT',							N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2004,	NULL,	16,		1,		0,		N'Society',									N'dmssociety',							N'DMS Society Table',											N'DMOWN',				N'DMS_SOCIETY',								N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2016,	NULL,	16,		1,		0,		N'AffiliateStatement',						N'dmsastmt',							N'DMS Affilate Statement table',								N'DMOWN',				N'DMS_A_STMT',								N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2017,	NULL,	16,		1,		0,		N'AffiliateStatementEDetail',				N'dmsastmtedet',						N'DMS Affiliate Statement E Detail table',						N'DMOWN',				N'DMS_A_STMT_EDET',							N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2018,	NULL,	16,		1,		0,		N'AffiliateStatementFDetail',				N'dmsastmtfdet',						N'DMS Affiliate Statement F Detail table',						N'DMOWN',				N'DMS_A_STMT_FDET',							N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2019,	NULL,	16,		1,		0,		N'BroadcastRegion',							N'dmsbroadcastregion',					N'DMS broadcast region table',									N'DMOWN',				N'DMS_BROADCAST_REGION',					N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2021,	NULL,	16,		1,		0,		N'CAE',										N'dmscae',								N'DMS Cae table',												N'DMOWN',				N'DMS_CAE',									N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2022,	NULL,	16,		1,		0,		N'Currency',								N'dmscurrency',							N'DMS Currency table',											N'DMOWN',				N'DMS_CURRENCY',							N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2023,	NULL,	16,		1,		0,		N'Distribution',							N'dmsdistribution',						N'DMS Distribution table',										N'DMOWN',				N'DMS_DISTRIBUTION',						N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2026,	NULL,	16,		1,		0,		N'OSDMExtractControl',						N'dmsosdmextractcontrol',				N'DMS OS DM Extract Control table',								N'DMOWN',				N'DMS_OS_DM_EXTRACT_CONTROL',				N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2027,	NULL,	16,		1,		0,		N'EEAStatementDetails',						N'dmseeastmtdet',						N'DMS EEA Statement Details Table',								N'DMOWN',				N'DMS_EEA_STMT_DET',						N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2028,	NULL,	16,		1,		0,		N'EEAStatementSummary',						N'dmseeastmtsumm',						N'DMS EEA Statement Summary table',								N'DMOWN',				N'DMS_EEA_STMT_SUMM',						N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2029,	NULL,	16,		1,		0,		N'ElectronicStatement',						N'dmsestmt',							N'DMS ElectronicStatement table',								N'DMOWN',				N'DMS_E_STMT',								N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2030,	NULL,	16,		1,		0,		N'ElectronicStatementGeneralAdjustment',	N'dmsestmtgnad',						N'DMS Electronic statement general adjustment table',			N'DMOWN',				N'DMS_E_STMT_GNAD',							N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2031,	NULL,	16,		1,		0,		N'ElectronicStatementPaymentDetail',		N'dmsestmtpymtdet',						N'DMS Elecronic Statement Payment Details table',				N'DMOWN',				N'DMS_E_STMT_PYMT_DET',						N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2032,	NULL,	16,		1,		0,		N'Invoices',								N'dmsinvoices',							N'DMS Invoices table',											N'DMOWN',				N'DMS_INVOICES',							N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2033,	NULL,	16,		1,		0,		N'Licensees',								N'dmslicensees',						N'DMS Licensees table',											N'DMOWN',				N'DMS_LICENSEES',							N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2034,	NULL,	16,		1,		0,		N'LicensingBodies',							N'dmslicensingbodies',					N'DMS Licensing Bodies table',									N'DMOWN',				N'DMS_LICENSING_BODIES',					N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2035,	NULL,	16,		1,		0,		N'MajorMember',								N'dmsmajormember',						N'DMS Major member table',										N'DMOWN',				N'DMS_MAJOR_MEMBER',						N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2036,	NULL,	16,		1,		0,		N'Membership',								N'dmsmembership',						N'DMS Membership tables',										N'DMOWN',				N'DMS_MEMBERSHIP',							N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2037,	NULL,	16,		1,		0,		N'MembershipType',							N'dmsmembershiptype',					N'DMS Membership Type table',									N'DMOWN',				N'DMS_MEMBERSHIP_TYPE',						N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2040,	NULL,	16,		1,		0,		N'MemberSourceSocieties',					N'dmsmembersourcesocieties',			N'DMS Member Source Societies table',							N'DMOWN',				N'DMS_MEMBER_SOURCE_SOCIETIES',				N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
--		(2041,	NULL,	16,		1,		0,		N'MemberStatements',						N'dmsmemberstatements',					N'DMS Member Statements table',									N'DMOWN',				N'DMS_MEMBER_STATEMENTS',					N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2042,	NULL,	16,		1,		0,		N'StatementInstructionLicensingBodies',		N'dmsmvstmtinstrlibos',					N'DMS Statement Instruction Licensing Bodies table',			N'DMOWN',				N'DMS_MV_STMT_INSTR_LIBOS',					N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2043,	NULL,	16,		1,		0,		N'ProductTypes',							N'dmsproducttypes',						N'DMS Product Types table',										N'DMOWN',				N'DMS_PRODUCT_TYPES',						N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2044,	NULL,	16,		1,		0,		N'PaymentInstruction',						N'dmspymtinstruction',					N'DMS PaymentInstruction table',								N'DMOWN',				N'DMS_PYMT_INSTRUCTION',					N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2045,	NULL,	16,		1,		0,		N'PaperStatement',							N'dmspstmt',							N'DMS Paper Statement table',									N'DMOWN',				N'DMS_P_STMT',								N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2046,	NULL,	16,		1,		0,		N'PaperStatementAccountDetails',			N'dmspstmtaccdet',						N'DMS Paper Statement Account Details table',					N'DMOWN',				N'DMS_P_STMT_ACC_DET',						N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2047,	NULL,	16,		1,		0,		N'PaperStatementCommissionInvoice',			N'dmspstmtcomminvoice',					N'DMS Paper Statement Commission Invoice table',				N'DMOWN',				N'DMS_P_STMT_COMM_INVOICE',					N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2048,	NULL,	16,		1,		0,		N'PaperStatementGeneralAdjustmentLines',	N'dmspstmtgad',							N'DMS Paper Statement General Adjustment Lines table',			N'DMOWN',				N'DMS_P_STMT_GAD',							N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2049,	NULL,	16,		1,		0,		N'PaperStatementNOPEarningLines',			N'dmspstmtnopearndet',					N'DMS Paper Statement NOP Earning Lines table',					N'DMOWN',				N'DMS_P_STMT_NOP_EARN_DET',					N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2050,	NULL,	16,		1,		0,		N'PaperStatementNOPPaymentLines',			N'dmspstmtnoppymtdet',					N'DMS Paper Statement NOP Payment Lines table',					N'DMOWN',				N'DMS_P_STMT_NOP_PYMT_DET',					N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2055,	NULL,	16,		1,		0,		N'PaperStatementTopFiveEarners',			N'dmspstmttopfiveearners',				N'DMS Paper Statement Top Five Eaners table',					N'DMOWN',				N'DMS_P_STMT_TOP_FIVE_EARNERS',				N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2056,	NULL,	16,		1,		0,		N'PaperStatementVATLines',					N'dmspstmtvtdt',						N'DMS Paper Stateent VAT Lines table',							N'DMOWN',				N'DMS_P_STMT_VTDT',							N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2057,	NULL,	16,		1,		0,		N'RollupMember',							N'dmsrollupmember',						N'DMS Rollup Member table',										N'DMOWN',				N'DMS_ROLLUP_MEMBER',						N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2058,	NULL,	16,		1,		0,		N'ScottishPostCodes',						N'dmsscottishpostcodes',				N'DMS Scottish PostCodes table',								'DMOWN',				N'DMS_SCOTTISH_POST_CODES',					N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2059,	NULL,	16,		1,		0,		N'ServiceTypes',							N'dmsservicetypes',						N'DMS Service Types table',										N'DMOWN',				N'DMS_SERVICE_TYPES',						N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2060,	NULL,	16,		1,		0,		N'SocietyUsageLink',						N'dmssocietyusagelink',					N'DMS Society Usage Link table',								N'DMOWN',				N'DMS_SOCIETY_USAGE_LINK',					N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2063,	NULL,	16,		1,		0,		N'StatementInstruction',					N'dmsstatementinstruction',				N'DMS Statement Instruction table',								N'DMOWN',				N'DMS_STATEMENT_INSTRUCTION',				N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2064,	NULL,	16,		1,		0,		N'StatementRun',							N'dmsstatementrun',						N'DMS Statement Run table',										N'DMOWN',				N'DMS_STATEMENT_RUN',						N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2065,	NULL,	16,		1,		0,		N'StandardTaxRate',							N'dmsstdtaxrate',						N'DMS Standard Tax Rate table',									N'DMOWN',				N'DMS_STD_TAX_RATE',						N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2066,	NULL,	16,		1,		0,		N'StatementInstructionSocieties',			N'dmsstinsocieties',					N'DMS Statement Instruction Societies table',					N'DMOWN',				N'DMS_STIN_SOCIETIES',						N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2067,	NULL,	16,		1,		0,		N'StatementAddition',						N'dmsstmtaddt',							N'DMS Statement addition table',								N'DMOWN',				N'DMS_STMT_ADDT',							N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2068,	NULL,	16,		1,		0,		N'StatementDetails',						N'dmsstmtdetail',						N'DMS Statement Detail table',									N'DMOWN',				N'DMS_STMT_DETAIL',							N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2069,	NULL,	16,		1,		0,		N'StatementDummyAddress',					N'dmsstmtdummyaddress',					N'DMS Statement Dummy Address table',							N'DMOWN',				N'DMS_STMT_DUMMY_ADDRESS',					N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2070,	NULL,	16,		1,		0,		N'Territory',								N'dmsterritorytis',						N'DMS Territory table',											N'DMOWN',				N'DMS_TERRITORY_TIS',						N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2071,	NULL,	16,		1,		0,		N'UsageCategories',							N'dmsusagecategories',					N'DMS Usage Categories table',									N'DMOWN',				N'DMS_USAGE_CATEGORIES',					N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2072,	NULL,	16,		1,		0,		N'UsageGroup',								N'dmsusagegroup',						N'DMS Usage Group table',										N'DMOWN',				N'DMS_USAGE_GROUP',							N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2073,	NULL,	16,		1,		0,		N'UsageGroupSummary',						N'dmsusagegroupsumm',					N'DMS Usage Group Summary table',								N'DMOWN',				N'DMS_USAGE_GROUP_SUMM',					N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2074,	NULL,	16,		1,		0,		N'UsageGroupType',							N'dmsusagegrouptype',					N'DMS Usage Group Type table',									N'DMOWN',				N'DMS_USAGE_GROUP_TYPE',					N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2075,	NULL,	16,		1,		0,		N'WithheldSocietyTax',						N'dmswithheldsocietytax',				N'DMS Withheld society tax table',								N'DMOWN',				N'DMS_WITHHELD_SOCIETY_TAX',				N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2076,	NULL,	16,		1,		0,		N'PaperStatementAccountShare',				N'dmspstmtaccshare',					N'DMS Paper Statement Account Share table',						N'DMOWN',				N'DMS_P_STMT_ACC_SHARE',					N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
--		(2137,	NULL,	16,		1,		0,		N'ReportsText',								N'dmsreportstext',						N'DMS Reports Text',											N'DMOWN',				N'DMS_REPORTS_TEXT',						N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
--		(2138,	NULL,	16,		1,		0,		N'ReportTypes',								N'dmsreporttypes',						N'DMS Report Types',											N'DMOWN',				N'DMS_REPORT_TYPES',						N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2139,	NULL,	16,		1,		0,		N'StatementInstrumentLiboList',				N'dmsstmtinstrlibolist',				N'DMS StatementInstrumentLicensingBodyList table',				N'DMOWN',				N'DMS_STMT_INSTR_LIBO_LIST',				N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2153,	NULL,	16,		1,		0,		N'StatementMembershipLiboList',				N'dmsstmtmbrlibolist',					N'DMS StatementMembershipLicensingBodyList table',				N'DMOWN',				N'DMS_STMT_MBR_LIBO_LIST',					N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(21127,	NULL,	16,		1,		0,		N'ThirdPartyParents',		   			    N'dmsvthirdpartyparents',    			N'DMS Third Party Parents view',								N'DMOWN',				N'DMS_V_THIRD_PARTY_PARENTS',       		N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2006,	NULL,	16,		0,		0,		N'DimSociety',								N'dimSociety',							N'Online Statements Dim Society',								N'Warehouse',			N'DimSociety',								N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2007,	NULL,	16,		0,		0,		N'DimMember',								N'dimMember',							N'Online Statements Dim Member',								N'Warehouse',			N'DimMember',								N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2008,	NULL,	16,		0,		0,		N'DimDistribution',							N'dimDistribution',						N'Online Statements Dim Distribution',							N'Warehouse',			N'DimDistribution',							N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2011,	NULL,	16,		0,		0,		N'FactDistributedRoyalty',					N'DistRoyalty',							N'Fact Distributed Royalty',									N'Warehouse',			N'FactDistributedRoyalty',					N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2077,	NULL,	16,		0,		0,		N'AdjustmentLine',							N'AdjustmentLine',						N'Online Statements Adjustment Line',							N'Warehouse',			N'AdjustmentLine',							N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2078,	NULL,	16,		0,		0,		N'CommissionInvoice',						N'CommissionInvoice',					N'OnlineStatements Commission Invoice',							N'Warehouse',			N'CommissionInvoice',						N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2084,	NULL,	16,		0,		0,		N'CommissionInvoiceLine',					N'CommInvoiceLine',						N'Online Statements Comm Invoice Line',							N'Warehouse',			N'CommissionInvoiceLine',					N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2085,	NULL,	16,		0,		0,		N'DimAdjustmentReason',						N'dimAdjustmentReason',					N'Online Statements Adjustment Reason',							N'Warehouse',			N'DimAdjustmentReason',						N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2086,	NULL,	16,		0,		0,		N'DimBroadcaster',							N'dimBroadcaster',						N'Online Statements Dim Broadcaster',							N'Warehouse',			N'DimBroadcaster',							N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2087,	NULL,	16,		0,		0,		N'DimCountry',								N'dimCountry',							N'Online Statements Dim Country',								N'Warehouse',			N'DimCountry',								N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2090,	NULL,	16,		0,		0,		N'DimDate',									N'dimDate',								N'Online Statements Dim Date',									N'Warehouse',			N'DimDate',									N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2092,	NULL,	16,		0,		0,		N'DimInterestedParty',						N'dimInterestedParty',					N'Online Statements Dim Interested Party',						N'Warehouse',			N'DimInterestedParty',						N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2093,	NULL,	16,		0,		0,		N'DimInvoice',								N'dimInvoice',							N'Online Statements Dim Invoice',								N'Warehouse',			N'DimInvoice',								N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2094,	NULL,	16,		0,		0,		N'DimLicensingBody',						N'dimLicensingBody',					N'Online Statements Dim Licensing Body',						N'Warehouse',			N'DimLicensingBody',						N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2096,	NULL,	16,		0,		0,		N'DimProduct',								N'dimProduct',							N'Online Statements Dim Product',								N'Warehouse',			N'DimProduct',								N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2097,	NULL,	16,		0,		0,		N'DimRecording',							N'dimRecording',						N'Online Statements Dim Recording',								N'Warehouse',			N'DimRecording',							N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2098,	NULL,	16,		0,		0,		N'DimRoleType',								N'dimRoleType',							N'Online Statements Dim Role Type',								N'Warehouse',			N'DimRoleType',								N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2105,	NULL,	16,		0,		0,		N'DimRoyaltyClassification',				N'dimRoyaltyClass',						N'Dim Royalty Classification',									N'Warehouse',			N'DimRoyaltyClassification',				N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2106,	NULL,	16,		0,		0,		N'DimUsageClassification',					N'dimUsageClass',						N'Dim Usage Classification',									N'Warehouse',			N'DimUsageClassification',					N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2107,	NULL,	16,		0,		0,		N'DimUsageGroup',							N'dimUsageGroup',						N'Online Statements Dim Usage Group',							N'Warehouse',			N'DimUsageGroup',							N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2108,	NULL,	16,		0,		0,		N'DimWork',									N'dimWork',								N'Online Stateents Dim Work',									N'Warehouse',			N'DimWork',									N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2110,	NULL,	16,		0,		0,		N'GeneralRoyaltyLine',						N'GeneralRoyaltyLine',					N'General Loyalty Line',										N'Warehouse',			N'GeneralRoyaltyLine',						N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2112,	NULL,	16,		0,		0,		N'NopEarningLine',							N'NopEarningLine',						N'Nop Earning Line',											N'Warehouse',			N'NopEarningLine',							N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2113,	NULL,	16,		0,		0,		N'NopNoteText',								N'NopNoteText',							N'Nop Note Text ',												N'Warehouse',			N'NopNoteText',								N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2114,	NULL,	16,		0,		0,		N'NopPaymentLine',							N'NopPaymentLine',						N'Nop Payment Line',											N'Warehouse',			N'NopPaymentLine',							N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2115,	NULL,	16,		0,		0,		N'NoteText',								N'NoteText',							N'Note Text',													N'Warehouse',			N'NoteText',								N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2116,	NULL,	16,		0,		0,		N'OnlineStatement',							N'OnlineStatement',						N'Online Statement',											N'Warehouse',			N'OnlineStatement',							N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2117,	NULL,	16,		0,		0,		N'SourceStatement',							N'SourceStatement',						N'Source Statement',											N'Warehouse',			N'SourceStatement',							N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2119,	NULL,	16,		0,		0,		N'StatementLicensingBody',					N'StatemtLicensingBody',				N'Statement Licensing Body',									N'Warehouse',			N'StatementLicensingBody',					N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2120,	NULL,	16,		0,		0,		N'ThirdPartyStatementGroup',				N'ThrdPrtyStmtGroup',					N'Third Party Statement Group',									N'Warehouse',			N'ThirdPartyStatementGroup',				N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2126,	NULL,	16,		0,		0,		N'ThirdPartyStatementGroupOnlineStatement',	N'ThrdPrtyStmtGrpOlSt',					N'Third Party Statement Group Online Statement',				N'Warehouse',			N'ThirdPartyStatementGroupOnlineStatement',	N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2127,	NULL,	16,		0,		0,		N'UsageGroupRoyaltyLine',					N'UsageGrpRoyLine',						N'Usage Group Royalty Line',									N'Warehouse',			N'UsgaeGroupRoyaltyLine',					N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2128,	NULL,	16,		0,		0,		N'VATInvoice',								N'VATInvoice',							N'VATInvoice',													N'Warehouse',			N'VATInvoice',								N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2129,	NULL,	16,		0,		0,		N'VATInvoiceLine',							N'VATInvoiceLine',						N'VATInvoiceLine',												N'Warehouse',			N'VATInvoiceLine',							N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2130,	NULL,	16,		0,		0,		N'DistributionLoadControl',					N'DMSDistributionLoadControl',			N'DMS Distribution Load Control table',							N'Clean',				N'DMS_DISTRIBUTION_LOAD_CONTROL',			N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2131,	NULL,	16,		0,		0,		N'TempDistributedRoyalty',					N'TempDistributedRoyalty',				N'Temp Distributed Royalty',									N'Transform',			N'TempDistributedRoyalty',					N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2132,	NULL,	16,		0,		0,		N'TempDistributedRoyaltyWkdt',				N'TempDistributedRoyaltyWkdt',			N'Temp Distributed Royalty Wkdt',								N'Transform',			N'TempDistributedRoyaltyWkdt',				N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2133,	NULL,	16,		0,		0,		N'TempDistributedRoyaltyAddt',				N'TempDistributedRoyaltyAddt',			N'Temp Distributed Royalty Addt',								N'Transform',			N'TempDistributedRoyaltyAddt',				N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2134,	NULL,	16,		0,		0,		N'TempStatement',							N'TempStatement',						N'Temp Statement',												N'Transform',			N'TempStatement',							N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2135,	NULL,	16,		0,		0,		N'TempStatementShare',						N'TempStatementShare',					N'Temp Statement Share',										N'Transform ',			N'TempStatementShare',						N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2151,	NULL,	16,		0,		0,		N'TempFactDistributedRoyalty',				N'TempFactDistributedRoyalty',			N'Temp Fact Distributed Royalty',								N'Transform',			N'TempFactDistributedRoyalty',				N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2154,	NULL,	16,		0,		0,		N'TempPayeeStatement',						N'TempPayeeStatement',					N'Temp Payee Statement table',									N'Transform',			N'TempPayeeStatement',						N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2155,	NULL,	16,		0,		0,		N'TempMbrStatement',						N'TempMbrStatement',					N'Temp Mbr Statement table',									N'Transform',			N'TempMbrStatement',						N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),		
		(2177,	NULL,	16,		0,		0,		N'TempMbrStatementSociety',					N'TempMbrStatementSociety',				N'Temp Mbr Statement Society table',							N'Transform',			N'TempMbrStatementSociety',					N'Jonathan.Myers@prsformusic.com',	SYSDATETIME()),
		(2180,	NULL,	16,		0,		0,		N'TempPayeeStatementSociety',				N'TempPayeeStatementSociety',	    	N'Temp Payee Statement Society table',							N'Transform',			N'TempPayeeStatementSociety',				N'Jonathan.Myers@prsformusic.com',	SYSDATETIME())
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

-- Insert new rows
WHEN NOT MATCHED BY TARGET THEN
	INSERT
		(
			[EntityTypeId],
			[ApplicationId],
			[IsSourceEntity],
			[HasMultipleSourceFile],
			[Name],				
			[Code],				
			[ParentEntityTypeId],
			[Description],		
			[Schema],			
			[Table],				
			[CreatedBy],			
			[CreatedDate]		
		)
	VALUES
		(
			Src.[EntityTypeId],
			Src.[ApplicationId],
			Src.[IsSourceEntity],
			Src.[HasMultipleSourceFile],
			Src.[Name],
			Src.[Code],
			src.[ParentEntityTypeId],
			src.[Description],
			src.[Schema],
			src.[Table],
			src.[CreatedBy],			
			src.[CreatedDate]
		)
;

GO
SET IDENTITY_INSERT [Control].[EntityType] OFF;


