﻿/*
Deployment script for BISystemDev

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "BiSystemTest"
:setvar DefaultFilePrefix "BiSystemTest"
:setvar DefaultDataPath ""
:setvar DefaultLogPath ""

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
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;

GO
PRINT N'Altering table [Audit].[RowThroughput]...';

GO
SET QUOTED_IDENTIFIER ON;
SET ANSI_NULLS OFF;

GO

ALTER TABLE [Audit].[RowThroughput]
    ADD [SourceFileName] VARCHAR (100) NULL,
        [EntityName]     VARCHAR (100) NULL;

GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;

GO
PRINT N'Altering table [Control].[SourceFile]...';

GO
SET QUOTED_IDENTIFIER ON;
SET ANSI_NULLS OFF;

ALTER TABLE [Control].[SourceFile]
    ADD [FileExtractedParentLoadId] INT NULL,
        [StageParentLoadId]         INT NULL,
        [CleanParentLoadId]         INT NULL;

ALTER TABLE [Control].[SourceFile]
  ADD DEFAULT ((0)) FOR [FileExtractedParentLoadId];

GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;

GO
PRINT N'Creating [Control].[CheckSourceFilesIfStagedInClean]...';

GO
SET QUOTED_IDENTIFIER ON;
SET ANSI_NULLS OFF;

GO
DROP PROCEDURE [Control].[CheckSourceFilesIfStagedInClean];

GO
CREATE PROCEDURE [Control].[CheckSourceFilesIfStagedInClean]
	@pShouldCleanBlob BIT OUT
AS
BEGIN
/*
 *	Gets the last inserted connections string for BLOB storage
 */
	SET NOCOUNT ON;
	DECLARE @shouldCleanBlob BIT;

	IF EXISTS (SELECT TOP(1) *
			   FROM [Control].[SourceFile] 
			   WHERE [FileExtractedDate] IS NOT NULL
			     AND [BlobUploadDate] IS NOT NULL
			     AND [StageDate] IS NOT NULL
			     AND [CleanDate] IS NOT NULL
			     AND [WarehouseDate] IS NULL
				 ORDER BY [SourceFileName]) 
		SET @shouldCleanBlob = 1; 
	ELSE 
		SET @shouldCleanBlob = 0;

	SET @pShouldCleanBlob = @shouldCleanBlob;
		
END
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;

GO
PRINT N'Creating [Control].[InsertSourceFile]...';

GO
SET QUOTED_IDENTIFIER ON;
SET ANSI_NULLS OFF;

GO
DROP PROCEDURE [Control].[InsertSourceFile];

GO
CREATE PROCEDURE [Control].[InsertSourceFile]
				 @FileName VARCHAR(250),
				 @LoadId int
AS


DECLARE @ApplicationId int


SELECT @ApplicationId = [ApplicationId] FROM [Control].[Application]  WHERE Code = 'DEOS'


IF NOT EXISTS (SELECT (1) FROM [Control].[SourceFile] WHERE [SourceFileName]= @FileName)
  BEGIN
    INSERT INTO [Control].[SourceFile] (
										[SourceFileName],
										[SourceFileTypeId],
										[ModifiedDate],
										[FileSizeBytes],
										[IsCompressed],
										[Source],
										[FileExtractedDate],
										[FileExtractedParentLoadId],
										[UnloadFile],
										[LoadId],
										[ApplicationId] )
       SELECT    @FileName
				,1
				,SYSDATETIME()
				,0 
				,0 
				,'DX' 
				,SYSDATETIME()
				,@LoadId
				,0 
				, @LoadId
				, @ApplicationId


  END
ELSE
  BEGIN
    UPDATE Control.SourceFile
	   SET [FileExtractedDate]         = SYSDATETIME(),
           [FileExtractedParentLoadId] = @LoadId
     WHERE [SourceFileName]= @FileName
  END
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;

GO
PRINT N'Creating [Control].[ObtainDistributionsReadyToProcess]...';

GO
SET QUOTED_IDENTIFIER ON;
SET ANSI_NULLS OFF;

GO
DROP PROCEDURE [Control].[ObtainDistributionsReadyToProcess];

GO
CREATE PROCEDURE [Control].[ObtainDistributionsReadyToProcess]
	@pSourceFileName nvarchar(255) OUT
AS
BEGIN
/*
 *	Gets the last inserted connections string for BLOB storage
 */
	SET NOCOUNT ON;
	SET @pSourceFileName = (SELECT TOP(1) [SourceFileName] 
							    FROM [Control].[SourceFile] 
							   WHERE [BlobUploadDate] IS NULL
								 AND [StageDate] IS NULL
								 AND [CleanDate] IS NULL
								 AND [WarehouseDate] IS NULL
								 AND NOT EXISTS (SELECT * 
												   FROM [Control].[SourceFile] 
												  WHERE [BlobUploadDate] IS NOT NULL
													 AND ([StageDate] IS NULL
													 OR [CleanDate] IS NULL
													 OR [WarehouseDate] IS NULL))
							ORDER BY [SourceFileName]);

END
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;

GO
PRINT N'Creating [Control].[UpdateSourceFile]...';

GO
SET QUOTED_IDENTIFIER ON;
SET ANSI_NULLS OFF;

GO
DROP PROCEDURE [Control].[UpdateSourceFile];

GO
-- =============================================
-- Author:		Adatis
-- Create date: 18/03/2013
-- Description:	Updates Source File milestone dates
-- =============================================
CREATE PROCEDURE [Control].[UpdateSourceFile]
	@SourceFileId	INT, 
	@Stream			VARCHAR(10),
	@ParentLoadId	INT = NULL
AS

SET NOCOUNT ON;

IF @Stream = 'SRC2EXT'
BEGIN
	UPDATE Control.SourceFile
	SET	BlobUploadDate = GETDATE() 
	WHERE SourceFileId = @SourceFileId
END

IF @Stream = 'EXT2STG'
BEGIN
	UPDATE Control.SourceFile
	SET	StageDate = GETDATE()
	, [StageParentLoadId] = @ParentLoadId
	WHERE SourceFileId = @SourceFileId
END

IF @Stream = 'STG2CLN'
BEGIN
	UPDATE Control.SourceFile
	SET	CleanDate = GETDATE()
	, [CleanParentLoadId] = @ParentLoadId
	WHERE SourceFileId = @SourceFileId
END




IF @Stream = 'CLN2WAR'
BEGIN
	UPDATE Control.SourceFile
	SET	WarehouseDate = GETDATE()
	WHERE SourceFileId = @SourceFileId
END
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;

GO
/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/
SET IDENTITY_INSERT [Control].[EntityType] ON;
GO
MERGE INTO [Control].[EntityType] AS Tgt
USING 
	(VALUES	
		(1, -1, N'Address', N'dxaddress', N'Address Table', N'DATAXCHANGE', N'DX_ADDRESS', N'Simon.Whiteley@prsformusic.com',SYSDATETIME()),
		(2, -1, N'Country', N'dxcountry', N'DX Country Table', N'DATAXCHANGE', N'DX_COUNTRY', N'Simon.Whiteley@prsformusic.com',SYSDATETIME()),
		(3, -1, N'StatementWorkDetail', N'dxstmtwkdt', N'DX Statement Work Details', N'DATAXCHANGE', N'DX_STMT_WKDT', N'Simon.Whiteley@prsformusic.com',SYSDATETIME()),
		(4, -1, N'Society', N'dxsociety', N'DX Society Table', N'DATAXCHANGE', N'DX_SOCIETY', N'Simon.Whiteley@prsformusic.com',SYSDATETIME()),
		(6, NULL, N'DimSociety', N'dimSociety', N'Online Statements Dim Society', N'Warehouse', N'DimSociety', N'Simon.Whiteley@prsformusic.com',SYSDATETIME()),
		(7, NULL, N'DimMember', N'dimMember', N'Online Statements Dim Member', N'Warehouse', N'DimMember', N'Simon.Whiteley@prsformusic.com',SYSDATETIME()),
		(8, NULL, N'DimDistribution', N'dimDistribution', N'Online Statements Dim Distribution', N'Warehouse', N'DimDistribution', N'Simon.Whiteley@prsformusic.com',SYSDATETIME()),
		(11, NULL, N'FactDistributedRoyalty', N'DistRoyalty', N'Fact Distributed Royalty', N'Warehouse', N'FactDistributedRoyalty', N'Simon.Whiteley@prsformusic.com',SYSDATETIME()),
		(16, -1, N'AffiliateStatement', N'dxastmt', N'Affilate Statement table', N'DATAXCHANGE', N'DX_A_STMT', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(17, -1, N'AffiliateStatementEDetail', N'dxastmtedet', N'Affiliate Statement E Detail table', N'DATAXCHANGE', N'DX_A_STMT_EDET', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(18, -1, N'AffiliateStatementFDetail', N'dxastmtfdet', N'Affiliate Statement F Detail table', N'DATAXCHANGE', N'DX_A_STMT_FDET', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(19, -1, N'BroadcastRegion', N'dxbroadcastregion', N'DX broadcast region table', N'DATAXCHANGE', N'DX_BROADCAST_REGION', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(21, -1, N'CAE', N'dxcae', N'Dx cae table', N'DATAXCHANGE', N'DX_CAE', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(22, -1, N'Currency', N'dxcurrency', N'DX Currency table', N'DATAXCHANGE', N'DX_CURRENCY', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(23, -1, N'Distribution', N'dxdistribution', N'DX Distribution table', N'DATAXCHANGE', N'DX_DISTRIBUTION', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(26, -1, N'DistributionLoadControl', N'dxdistributionloadcontrol', N'DX Distribution Load Control table', N'DATAXCHANGE', N'DX_DISTRIBUTION_LOAD_CONTROL', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(27, -1, N'EEAStatementDetails', N'dxeeastmtdet', N'DX EEA Statement Details Table', N'DATAXCHANGE', N'DX_EEA_STMT_DET', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(28, -1, N'EEAStatementSummary', N'dxeeastmtsumm', N'DX EEA Statement Summary table', N'DATAXCHANGE', N'DX_EEA_STMT_SUMM', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(29, -1, N'ElectronicStatement', N'dxestmt', N'DX ElectronicStatement table', N'DATAXCHANGE', N'DX_E_STMT', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(30, -1, N'ElectronicStatementGeneralAdjustment', N'dxestmtgnad', N'DX Electronic statement general adjustment table', N'DATAXCHANGE', N'DX_E_STMT_GNAD', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(31, -1, N'ElectronicStatementPaymentDetail', N'dxestmtpymtdet', N'DX Elecronic Statement Payment Details table', N'DATAXCHANGE', N'DX_E_STMT_PYMT_DET', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(32, -1, N'Invoices', N'dxinvoices', N'DX Invoices table', N'DATAXCHANGE', N'DX_INVOICES', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(33, -1, N'Licensees', N'dxlicensees', N'DX Licensees table', N'DATAXCHANGE', N'DX_LICENSEES', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(34, -1, N'LicensingBodies', N'dxlicensingbodies', N'DX Licensing Bodies table', N'DATAXCHANGE', N'DX_LICENSING_BODIES', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(35, -1, N'MajorMember', N'dxmajormember', N'DX Major member table', N'DATAXCHANGE', N'DX_MAJOR_MEMBER', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(36, -1, N'Membership', N'dxmembership', N'DX Membership tables', N'DATAXCHANGE', N'DX_MEMBERSHIP', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(37, -1, N'MembershipType', N'dxmembershiptype', N'DX Membership Type table', N'DATAXCHANGE', N'DX_MEMBERSHIP_TYPE', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(40, -1, N'MemberSourceSocieties', N'dxmembersourcesocieties', N'DX Member Source Societies table', N'DATAXCHANGE', N'DX_MEMBER_SOURCE_SOCIETIES', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(41, -1, N'MemberStatements', N'dxmemberstatements', N'DX Member Statements table', N'DATAXCHANGE', N'DX_MEMBER_STATEMENTS', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(42, -1, N'StatementInstructionLicensingBodies', N'dxmvstmtinstrlibos', N'DX Statement Instruction Licensing Bodies table', N'DATAXCHANGE', N'DX_MV_STMT_INSTR_LIBOS', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(43, -1, N'ProductTypes', N'dxproducttypes', N'DX Product Types table', N'DATAXCHANGE', N'DX_PRODUCT_TYPES', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(44, -1, N'PaymentInstruction', N'dxpymtinstruction', N'DX PaymentInstruction table', N'DATAXCHANGE', N'DX_PYMT_INSTRUCTION', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(45, -1, N'PaperStatement', N'dxpstmt', N'DX Paper Statement table', N'DATAXCHANGE', N'DX_P_STMT', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(46, -1, N'PaperStatementAccountDetails', N'dxpstmtaccdet', N'DX Paper Statement Account Details table', N'DATAXCHANGE', N'DX_P_STMT_ACC_DET', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(47, -1, N'PaperStatementCommissionInvoice', N'dxpstmtcomminvoice', N'DX Paper Statement Commission Invoice table', N'DATAXCHANGE', N'DX_P_STMT_COMM_INVOICE', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(48, -1, N'PaperStatementGeneralAdjustmentLines', N'dxpstmtgad', N'DX Paper Statement General Adjustment Lines table', N'DATAXCHANGE', N'DX_P_STMT_GAD', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(49, -1, N'PaperStatementNOPEarningLines', N'dxpstmtnopearndet', N'DX Paper Statement NOP Earning Lines table', N'DATAXCHANGE', N'DX_P_STMT_NOP_EARN_DET', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(50, -1, N'PaperStatementNOPPaymentLines', N'dxpstmtnoppymtdet', N'DX Paper Statement NOP Payment Lines table', N'DATAXCHANGE', N'DX_P_STMT_NOP_PYMT_DET', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(55, -1, N'PaperStatementTopFiveEarners', N'dxpstmttopfiveearners', N'DX Paper Statement Top Five Eaners table', N'DATAXCHANGE', N'DX_P_STMT_TOP_FIVE_EARNERS', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(56, -1, N'PaperStatementVATLines', N'dxpstmtvtdt', N'DX Paper Stateent VAT Lines table', N'DATAXCHANGE', N'DX_P_STMT_VTDT', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(57, -1, N'RollupMember', N'dxrollupmember', N'DX Rollup Member table', N'DATAXCHANGE', N'DX_ROLLUP_MEMBER', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(58, -1, N'ScottishPostCodes', N'dxscottishpostcodes', N'DX Scottish PostCodes table', N'DATAXCHANGE', N'DX_SCOTTISH_POST_CODES', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(59, -1, N'ServiceTypes', N'dxservicetypes', N'DX Service Types table', N'DATAXCHANGE', N'DX_SERVICE_TYPES', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(60, -1, N'SocietyUsageLink', N'dxsocietyusagelink', N'DX Society Usage Link table', N'DATAXCHANGE', N'DX_SOCIETY_USAGE_LINK', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(63, -1, N'StatementInstruction', N'dxstatementinstruction', N'DX Statement Instruction table', N'DATAXCHANGE', N'DX_STATEMENT_INSTRUCTION', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(64, -1, N'StatementRun', N'dxstatementrun', N'DX Statement Run table', N'DATAXCHANGE', N'DX_STATEMENT_RUN', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(65, -1, N'StandardTaxRate', N'dxstdtaxrate', N'DX Standard Tax Rate table', N'DATAXCHANGE', N'DX_STD_TAX_RATE', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(66, -1, N'StatementInstructionSocieties', N'dxstinsocieties', N'DX Statement Instruction Societies table', N'DATAXCHANGE', N'DX_STIN_SOCIETIES', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(67, -1, N'StatementAddition', N'dxstmtaddt', N'DX Statement addition table', N'DATAXCHANGE', N'DX_STMT_ADDT', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(68, -1, N'StatementDetails', N'dxstmtdetail', N'DX Statement Detail table', N'DATAXCHANGE', N'DX_STMT_DETAIL', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(69, -1, N'StatementDummyAddress', N'dxstmtdummyaddress', N'DX Statement Dummy Address table', N'DATAXCHANGE', N'DX_STMT_DUMMY_ADDRESS', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(70, -1, N'Territory', N'dxterritorytis', N'DX Territory table', N'DATAXCHANGE', N'DX_TERRITORY_TIS', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(71, -1, N'UsageCategories', N'dxusagecategories', N'DX Usage Categories table', N'DATAXCHANGE', N'DX_USAGE_CATEGORIES', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(72, -1, N'UsageGroup', N'dxusagegroup', N'DX Usage Group table', N'DATAXCHANGE', N'DX_USAGE_GROUP', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(73, -1, N'UsageGroupSummary', N'dxusagegroupsumm', N'DX Usage Group Summary table', N'DATAXCHANGE', N'DX_USAGE_GROUP_SUMM', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(74, -1, N'UsageGroupType', N'dxusagegrouptype', N'DX Usage Group Type table', N'DATAXCHANGE', N'DX_USAGE_GROUP_TYPE', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(75, -1, N'WithheldSocietyTax', N'dxwithheldsocietytax', N'DX Withheld society tax table', N'DATAXCHANGE', N'DX_WITHHELD_SOCIETY_TAX', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(76, -1, N'PaperStatementAccountShare', N'dxpstmtaccshare', N'DX Paper Statement Account Share table', N'DATAXCHANGE', N'DX_P_STMT_ACC_SHARE', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(77, NULL, N'AdjustmentLine', N'AdjustmentLine', N'Online Statements Adjustment Line', N'Warehouse', N'AdjustmentLine', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(78, NULL, N'CommissionInvoice', N'CommissionInvoice', N'OnlineStatements Commission Invoice', N'Warehouse', N'CommissionInvoice', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(84, NULL, N'CommissionInvoiceLine', N'CommInvoiceLine', N'Online Statements Comm Invoice Line', N'Warehouse', N'CommissionInvoiceLine', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(85, NULL, N'DimAdjustmentReason', N'dimAdjustmentReason', N'Online Statements Adjustment Reason', N'Warehouse', N'DimAdjustmentReason', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(86, NULL, N'DimBroadcaster', N'dimBroadcaster', N'Online Statements Dim Broadcaster', N'Warehouse', N'DimBroadcaster', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(87, NULL, N'DimCountry', N'dimCountry', N'Online Statements Dim Country', N'Warehouse', N'DimCountry', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(90, NULL, N'DimDate', N'dimDate', N'Online Statements Dim Date', N'Warehouse', N'DimDate', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(92, NULL, N'DimInterestedParty', N'dimInterestedParty', N'Online Statements Dim Interested Party', N'Warehouse', N'DimInterestedParty', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(93, NULL, N'DimInvoice', N'dimInvoice', N'Online Statements Dim Invoice', N'Warehouse', N'DimInvoice', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(94, NULL, N'DimLicensingBody', N'dimLicensingBody', N'Online Statements Dim Licensing Body', N'Warehouse', N'DimLicensingBody', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(96, NULL, N'DimProduct', N'dimProduct', N'Online Statements Dim Product', N'Warehouse', N'DimProduct', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(97, NULL, N'DimRecording', N'dimRecording', N'Online Statements Dim Recording', N'Warehouse', N'DimRecording', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(98, NULL, N'DimRoleType', N'dimRoleType', N'Online Statements Dim Role Type', N'Warehouse', N'DimRoleType', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(105, NULL, N'DimRoyaltyClassification', N'dimRoyaltyClass', N'Dim Royalty Classification', N'Warehouse', N'DimRoyaltyClassification', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(106, NULL, N'DimUsageClassification', N'dimUsageClass', N'Dim Usage Classification', N'Warehouse', N'DimUsageClassification', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(107, NULL, N'DimUsageGroup', N'dimUsageGroup', N'Online Statements Dim Usage Group', N'Warehouse', N'DimUsageGroup', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(108, NULL, N'DimWork', N'dimWork', N'Online Stateents Dim Work', N'Warehouse', N'DimWork', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(109, NULL, N'FactDistributedRoyalty2', N'DistRoyalty2', N'Fact Distributed Royalty2', N'Warehouse', N'FactDistributedRoyalty2', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(110, NULL, N'GeneralRoyaltyLine', N'GeneralRoyaltyLine', N'General Loyalty Line', N'Warehouse', N'GeneralRoyaltyLine', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(112, NULL, N'NopEarningLine', N'NopEarningLine', N'Nop Earning Line', N'Warehouse', N'NopEarningLine', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(113, NULL, N'NopNoteText', N'NopNoteText', N'Nop Note Text ', N'Warehouse', N'NopNoteText', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(114, NULL, N'NopPaymentLine', N'NopPaymentLine', N'Nop Payment Line', N'Warehouse', N'NopPaymentLine', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(115, NULL, N'NoteText', N'NoteText', N'Note Text', N'Warehouse', N'NoteText', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(116, NULL, N'OnlineStatement', N'OnlineStatement', N'Online Statement', N'Warehouse', N'OnlineStatement', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(117, NULL, N'SourceStatement', N'SourceStatement', N'Source Statement', N'Warehouse', N'SourceStatement', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(119, NULL, N'StatementLicensingBody', N'StatemtLicensingBody', N'Statement Licensing Body', N'Warehouse', N'StatementLicensingBody', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(120, NULL, N'ThirdPartyStatementGroup', N'ThrdPrtyStmtGroup', N'Third Party Statement Group', N'Warehouse', N'ThirdPartyStatementGroup', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(126, NULL, N'ThirdPartyStatementGroupOnlineStatement', N'ThrdPrtyStmtGrpOlSt', N'Third Party Statement Group Online Statement', N'Warehouse', N'ThirdPartyStatementGroupOnlineStatement', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(127, NULL, N'UsageGroupRoyaltyLine', N'UsageGrpRoyLine', N'Usage Group Royalty Line', N'Warehouse', N'UsgaeGroupRoyaltyLine', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(128, NULL, N'VATInvoice', N'VATInvoice', N'VATInvoice', N'Warehouse', N'VATInvoice', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(129, NULL, N'VATInvoiceLine', N'VATInvoiceLine', N'VATInvoiceLine', N'Warehouse', N'VATInvoiceLine', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(130, NULL, N'DimWorkAttributes', N'dimWorkAttributes', N'Online Statements Dim Work Attributes', N'Warehouse', N'DimWorkAttributes', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(131, NULL, N'TempDistributedRoyalty', N'TempDistributedRoyalty', N'Temp Distributed Royalty', N'Transform', N'TempDistributedRoyalty', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(132, NULL, N'TempDistributedRoyaltyWkdt', N'TempDistributedRoyaltyWkdt', N'Temp Distributed Royalty Wkdt', N'Transform', N'TempDistributedRoyaltyWkdt', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(133, NULL, N'TempDistributedRoyaltyAddt', N'TempDistributedRoyaltyAddt', N'Temp Distributed Royalty Addt', N'Transform', N'TempDistributedRoyaltyAddt', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(134, NULL, N'TempStatement', N'TempStatement', N'Temp Statement', N'Transform', N'TempStatement', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(135, NULL, N'TempStatementShare', N'TempStatementShare', N'Temp Statement Share', N'Transform ', N'TempStatementShare', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(136, NULL, N'SourceStatement', N'SourceStatement', N'Source Statement', N'Warehouse', N'SourceStatement', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(137, NULL, N'ReportsText', N'reportstext', N'Reports Text', N'DATAXCHANGE', N'REPORTS_TEXT', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(138, NULL, N'ReportTypes', N'reporttypes', N'Report Types', N'DATAXCHANGE', N'REPORT_TYPES', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(139, NULL, N'StatementInstrumentLiboList', N'dxstmtinstrlibolist', N'StatementInstrumentLicensingBodyList table', N'DATAXCHANGE', N'DX_STMT_INSTR_LIBO_LIST', N'Emma.Stewart@prsformusic.com',SYSDATETIME()),
		(140, NULL, N'BroadcastDataQualityFormat5', N'brcdqformat5', N'Broadcast DataQuality Format5', N'BRCDataQuality', N'BRC_DQ_Format5', N'vandana.bangera@prsformusic.com',SYSDATETIME()),
		(143, NULL, N'BroadcastDataQualityFormat50', N'brcdqformat50', N'Broadcast DataQuality Format50', N'BRCDataQuality', N'BRC_DQ_Format50', N'vandana.bangera@prsformusic.com',SYSDATETIME()),
		(144, NULL, N'BroadcastDataQualityFormat52', N'brcdqformat52', N'Broadcast DataQuality Format52', N'BRCDataQuality', N'BRC_DQ_Format52', N'vandana.bangera@prsformusic.com',SYSDATETIME()),
		(146, NULL, N'BroadcastDataQualityFormat303', N'brcdqformat303', N'Broadcast DataQuality Format303', N'BRCDataQuality', N'BRC_DQ_Format303', N'vandana.bangera@prsformusic.com',SYSDATETIME()),
		(147, NULL, N'BroadcastDataQualityFormat51', N'brcdqformat51', N'Broadcast DataQuality Format51', N'BRCDataQuality', N'BRC_DQ_Format51', N'vandana.bangera@prsformusic.com',SYSDATETIME()),
		(148, NULL, N'BroadcastDataQualityFormat51a', N'brcdqformat51a', N'Broadcast DataQuality Format51a', N'BRCDataQuality', N'BRC_DQ_Format51a', N'vandana.bangera@prsformusic.com',SYSDATETIME()),
		(149, NULL, N'BroadcastDataQualityFormatS1', N'brcdqformats1', N'Broadcast DataQuality FormatS1', N'BRCDataQuality', N'BRC_DQ_FormatS1', N'vandana.bangera@prsformusic.com',SYSDATETIME()),
		(150, NULL, N'BroadcastDataQualityFormatS2', N'brcdqformats2', N'Broadcast DataQuality FormatS2', N'BRCDataQuality', N'BRC_DQ_FormatS2', N'vandana.bangera@prsformusic.com',SYSDATETIME()),
		(151, NULL, N'TempFactDistributedRoyalty', N'TempFactDistributedRoyalty', N'Temp Fact Distributed Royalty', N'Transform', N'TempFactDistributedRoyalty', N'Chris.Ellis@prsformusic.com',SYSDATETIME()),
		(152, NULL, N'FactDistributedRoyalty3', N'FactDistributedRoyalty3', N'Transform Fact Distributed Royalty', N'Transform', N'FactDistributedRoyalty', N'vandana.bangera@prsformusic.com',SYSDATETIME())
	) AS Src
	(
		 EntityTypeId
		,ParentEntityTypeId
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
			Src.[Name],
			Src.[Code],
			src.[ParentEntityTypeId],
			src.[Description],
			src.[Schema],
			src.[Table],
			src.[CreatedBy],			
			src.[CreatedDate]
		)

--  Delete rows that are in the target but not the source
WHEN NOT MATCHED BY SOURCE THEN
	DELETE;
GO
SET IDENTITY_INSERT [Control].[EntityType] OFF;


SET IDENTITY_INSERT [Control].[LoadStatusType] ON;
GO
MERGE INTO [Control].[LoadStatusType] AS Tgt
USING 
	(VALUES
		(1,'In Progress','Load In Progress','InProgress','PostDeployment Script', SYSDATETIME()),
		(2,'Successful','Load Completed Successfully','Success','PostDeployment Script',SYSDATETIME()),
		(3,'Failed','Load Failed','Failed','PostDeployment Script',SYSDATETIME()),
		(4,'Reset','Load flagged for reset','Reset','PostDeployment Script',SYSDATETIME())
	) AS Src
	(
		[LoadStatusTypeId],
		[Name],
		[Description],
		[ShortName],
		[UpdateUser],
		[UpdateTime]
	)
	ON Tgt.[LoadStatusTypeId] = Src.[LoadStatusTypeId]

-- Update matched rows
WHEN MATCHED THEN
	UPDATE
	SET
		[Name]			   = Src.[Name],
		[Description]	   = Src.[Description],
		[ShortName]		   = src.[ShortName],
		[UpdateUser]	   = Src.[UpdateUser],
		[UpdateTime]	   = Src.[UpdateTime]
-- Insert new rows
WHEN NOT MATCHED BY TARGET THEN
	INSERT
		(
			[LoadStatusTypeId],
			[Name],			
			[Description],	
			[ShortName],		
			[UpdateUser],		
			[UpdateTime]	
		)
	VALUES
		(
			Src.[LoadStatusTypeId],
			Src.[Name],			
			Src.[Description],	
			src.[ShortName],		
			src.[UpdateUser],		
			src.[UpdateTime]	
		)

--  Delete rows that are in the target but not the source
WHEN NOT MATCHED BY SOURCE THEN
	DELETE;
GO
SET IDENTITY_INSERT [Control].[LoadStatusType] OFF;


SET IDENTITY_INSERT [Control].[ProcessStream] ON;
GO
MERGE INTO [Control].[ProcessStream] AS Tgt
USING 
	(VALUES
		(1,'EXT2STG',	'External To Stage', ''	,1),
		(2,'STG2CLN',	'Stage To Clean', '' ,2),
		(3,'CLN2TRN',	'Clean To Transform','',3),
		(4,'TRN2WAR',	'Transform To Warehouse','',4),
		(5,'REF2TRN',	'Reference To Transform','',5),
		(6,'CLN2WAR',	'Clean To Warehouse','',6),
		(7,'TRN2TRN',	'Transform To Transform','',7),
		(8,'TRN2REJ',	'Transform To Reject','',8),
		(9,'SRC2EXT',	'Source To Extract','',9)
	) AS Src
	(
		[ProcessStreamId],
		[Code],
		[Name],
		[Description],
		[ProcessStreamOrder]
	)
	ON Tgt.[ProcessStreamId] = Src.[ProcessStreamId]

-- Update matched rows
WHEN MATCHED THEN
	UPDATE
	SET
		 [Code]					= Src.[Code]
		,[Name]					= src.[Name]
		,[Description]			= src.[Description]
		,[ProcessStreamOrder]	= src.[ProcessStreamOrder]

-- Insert new rows
WHEN NOT MATCHED BY TARGET THEN
	INSERT
		(
			[ProcessStreamId],
			[Code],
			[Name],
			[Description],
			[ProcessStreamOrder]
		)
	VALUES
		(
			Src.[ProcessStreamId],
			Src.[Code],
			Src.[Name],
			src.[Description],
			src.[ProcessStreamOrder]
		)

-- Delete rows that are in the target but not the source
WHEN NOT MATCHED BY SOURCE THEN
	DELETE;
GO
SET IDENTITY_INSERT [Control].[ProcessStream] OFF;

SET IDENTITY_INSERT [Control].[SourceFileType] ON;
GO
MERGE INTO [Control].[SourceFileType] AS Tgt
USING 
	(VALUES
		(1, 'DX','DataXchange Distribution Context', 'DX Partition', 'Out',0,''),
		(2,'UNK','UNKNOWN','Unknown','OUT',0,'UNKNOWN'),
		(3,'SAS','SASOWN','SASOWN','OUT',0,'')) AS Src
	(
		[SourceFileTypeId],	
		[Code],
		[Description],
		[Name],
		[Direction],
		[32BitStageRequired],
		[Collection]
	)
	ON Tgt.[SourceFileTypeId] = Src.[SourceFileTypeId]

-- Update matched rows
WHEN MATCHED THEN
	UPDATE
	SET	
		[Code]					= Src.[Code],
		[Description]			= Src.[Description],
		[Name]					= Src.[Name],
		[Direction]				= Src.[Direction],
		[32BitStageRequired]	= src.[32BitStageRequired],
		[Collection]			= src.[Collection]

-- Insert new rows
WHEN NOT MATCHED BY TARGET THEN
	INSERT
		(
			[SourceFileTypeId],	
			[Code],
			[Description],
			[Name],
			[Direction],
			[32BitStageRequired],
			[Collection]          
		)
	VALUES
		(
			SRC.[SourceFileTypeId],	
			SRC.[Code],
			SRC.[Description],
			SRC.[Name],
			SRC.[Direction],
			SRC.[32BitStageRequired],
			SRC.[Collection]
		)

-- Delete rows that are in the target but not the source
WHEN NOT MATCHED BY SOURCE THEN
	DELETE;
GO
SET IDENTITY_INSERT [Control].[SourceFileType] OFF;

SET IDENTITY_INSERT [Control].[Application] ON;
GO
MERGE INTO [Control].[Application] AS Tgt
USING 
	(VALUES
		(1,'Data Experience Online Statements','DEOS','Data Experience Solution', null, null, null ,'Azure DW ', SYSDATETIME()),
		(2,'BroadcastDataQuality','BRDDQ','DataQuality Solution for AV', null, null, null , 'DataMart', SYSDATETIME())
	) AS Src
	(
		[ApplicationId],
		[Name],
     	[Code],
		[Description],
		[Priority],		   
		[UpTimeHours],	   
		[ETLType],		   
        [WarehouseType],
		[CreatedDate]
	)
	ON Tgt.[ApplicationId] = Src.[ApplicationId]

-- Update matched rows
WHEN MATCHED THEN
	UPDATE
	SET
		[Name]			   = Src.[Name],
		[Code]			   = Src.[Code],
		[Description]	   = Src.[Description],
		[Priority]		   = Src.[Priority],
		[UpTimeHours]	   = Src.[UpTimeHours],
		[ETLType]		   = Src.[ETLType],
		[WarehouseType]	   = Src.[WarehouseType]
-- Insert new rows
WHEN NOT MATCHED BY TARGET THEN
	INSERT
		(
			[ApplicationId],
			[Name],
     		[Code],
			[Description],
			[WarehouseType]		
		)
	VALUES
		(
			Src.[ApplicationId],
			Src.[Name],
			Src.[Code],
			Src.[Description],
			Src.[WarehouseType]
		)
--  Delete rows that are in the target but not the source
WHEN NOT MATCHED BY SOURCE THEN
	DELETE;
GO
SET IDENTITY_INSERT [Control].[Application] OFF;


GO

GO
