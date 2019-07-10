CREATE PROC [admin].[uspApplyBasicMetadata]
AS
/****************************************************************************
THIS PROC ENSURES CODE METADATA IS PRESENT FOR NORMAL APPLICATION USE
The following Entities are updated by FPV Integration SSIS : [FPV].[Society], [FPV].[Distribution], [FPV].[DistributionGroup], [FPV].[DistributionRevenueCalendar]
****************************************************************************/
MERGE [FPV].[ReferenceData] T
USING (
		VALUES ('FPVCalculation','Status','Pending','String','PENDING','APPCONFIG')
				,('FPVCalculation','Status','Approved','String','APPROVED','APPCONFIG')
				,('FPVCalculation','Status','Locked','String','LOCKED','APPCONFIG')
				,('DataRetention','ApplicationRequest','Days','Int','3','ADMIN')
				,('DataRetention','ApplicationResponse','Days','Int','3','ADMIN')
				,('Measure','HedgePercentage','PRS','Decimal','0.05','APPCONFIG')
				,('Measure','HedgePercentage','MCPS','Decimal','0.1','APPCONFIG')
	) S ([RefDataCategory],[RefDataGroup],[RefDataName],[RefDataType],[RefDataValue],[UsageType])
ON T.[RefDataCategory]=S.[RefDataCategory]
	AND T.[RefDataGroup]=S.[RefDataGroup]
	AND T.[RefDataName]=S.[RefDataName]

WHEN NOT MATCHED BY TARGET THEN 
INSERT ([RefDataCategory],[RefDataGroup],[RefDataName],[RefDataType],[RefDataValue],[UsageType])
VALUES (S.[RefDataCategory],S.[RefDataGroup],S.[RefDataName],S.[RefDataType],S.[RefDataValue],S.[UsageType])

--WHEN MATCHED AND (T.[RefDataType] != S.[RefDataType] OR T.[RefDataValue]!=S.[RefDataValue] OR T.[UsageType]!=S.[UsageType]) THEN
--UPDATE SET [RefDataType]=S.[RefDataType],[RefDataValue]=S.[RefDataValue],[UsageType]=S.[UsageType]

--WHEN NOT MATCHED BY SOURCE THEN DELETE
;

/****************************************************************************
APPLICATION REQUEST DEFINITIONS
****************************************************************************/
;MERGE [FPV].[RequestDef] T
USING (
			VALUES ('GET','DISTRIBUTIONGROUPS','[FPV].[uspJSONRequest_GetDistributionGroups]',0)
					,('GET','DISTRIBUTIONS','[FPV].[uspJSONRequest_GetDistributions]',0)
					,('GET','SOCIETIES','[FPV].[uspJSONRequest_GetSocieties]',0)
					,('GET','CALCULATIONGROUP','[FPV].[uspJSONRequest_GetCalculationGroups]',0)			
					,('GET','STATIONS','[FPV].[uspJSONRequest_GetStations]',0)
					,('GET','CONFIG','[FPV].[uspJSONRequest_GetConfig]',0)
					,('GET','REVENUE','[FPV].[uspJSONRequest_GetRevenue]',0)
					,('GET','MISSINGMINUTES','[FPV].[uspJSONRequest_GetMissingMinutes]',0)
					,('GET','MUSICMINUTES','[FPV].[uspJSONRequest_GetMusicMinutes]',0)
					,('GET','PUBLICRECEPTION','[FPV].[uspJSONRequest_GetPublicReception]',0)
					,('GET','FPVCALCULATIONS','[FPV].[uspJSONRequest_GetFPVCalculations]',0)
					,('PUT','CALCULATIONGROUP','[FPV].[uspJSONRequest_PutCalculationGroups]',0)	
					,('PUT','STATIONS','[FPV].[uspJSONRequest_PutStations]',0)
					,('PUT','REVENUE','[FPV].[uspJSONRequest_PutRevenue]',0)
					,('PUT','MISSINGMINUTES','[FPV].[uspJSONRequest_PutMissingMinutes]',0)
					,('PUT','MUSICMINUTES','[FPV].[uspJSONRequest_PutMusicMinutes]',0)
					,('PUT','PUBLICRECEPTION','[FPV].[uspJSONRequest_PutPublicReception]',0)
					,('PUT','FPVCALCULATIONS','[FPV].[uspJSONRequest_PutFPVCalculations]',0)
					,('GET','LICENCEGROUPS','[FPV].[uspJSONRequest_GetLicenceGroups]',0)
					,('PUT','LICENCEGROUPS','[FPV].[uspJSONRequest_PutLicenceGroups]',0)
					,('GET','AUDIENCEREACH','[FPV].[uspJSONRequest_GetAudienceReach]',0)
					,('PUT','AUDIENCEREACH','[FPV].[uspJSONRequest_PutAudienceReach]',0)
					,('GET','UDC','[FPV].[uspJSONRequest_GetUDC]',0)
					,('PUT','UDC','[FPV].[uspJSONRequest_PutUDC]',0)
					,('TRIGGER','RESETCALCULATIONGROUP','[FPV].[uspJSONRequest_TriggerResetCalculationGroup]',0)
		) S ([RequestType],[RequestEntity],[ProcName],[ValidateData])
ON	T.[RequestType]=S.[RequestType] AND T.[RequestEntity]=S.[RequestEntity]
WHEN NOT MATCHED THEN
INSERT ([RequestType],[RequestEntity],[ProcName],[ValidateData])
VALUES (S.[RequestType],S.[RequestEntity],S.[ProcName],S.[ValidateData])

--WHEN MATCHED THEN
--UPDATE SET [ProcName]=S.[ProcName],[ValidateData]=S.[ValidateData]

--WHEN NOT MATCHED BY SOURCE THEN DELETE
;

/****************************************************************************
FPV CALCULATION DEFS
****************************************************************************/
merge [FPV].[FPVCalculationDef] t
using (
select [CalculationName],[CalculationDetails],[Enabled]
from (values	('BasePoundPerMin','BasePoundPerMin',1)
,('BasePublicReceptionRate' ,'BasePublicReceptionRate',1)
,('HedgedFPVPoundsPerMin',	'HedgedFPVPoundsPerMin',1)
,('HedgedFPVPencePerMin','HedgedFPVPencePerMin',1)
,('CommsPointValuePoundsPerMin'	,'CommsPointValuePoundsPerMin',1)
,('CommsPointValuePencePerMin'	,'CommsPointValuePencePerMin',1)
,('CensusPointValue'	,'CensusPointValue',1)
,('EstimatedPoints'	,'EstimatedPoints',1)
,('EstimatedRevenue'	,'EstimatedRevenue',1))c([CalculationName],[CalculationDetails],[Enabled])
	)s([CalculationName],[CalculationDetails],[Enabled])
	on t.[CalculationName]=s.[CalculationName]

	when not matched then
	insert ([CalculationName],[CalculationDetails],[Enabled])
	values (s.[CalculationName],s.[CalculationDetails],s.[Enabled])
;

/****************************************************************************
SOCIETIES
****************************************************************************/
MERGE [FPV].[Society] T
USING (VALUES('PRS',1),('MCPS',1)) S ([Society],[Enabled])
ON T.[Society]=S.[Society]

WHEN NOT MATCHED THEN
INSERT ([Society],[Enabled]) VALUES (S.[Society],S.[Enabled])

--WHEN MATCHED THEN 
--UPDATE SET T.[Enabled]=S.[Enabled]
;


/****************************************************************************
Populate IntegrationControl - Sets Control Packages for the External to Abacus Database
****************************************************************************/

MERGE [Config].[IntegrationControl] T
USING (
		VALUES 
			 (1,'Revenue','Sync from Finance Data Mart (TM1)','FPVRevenueIntegration','uspMergeMasterRevenue')
			,(2,'AudienceMartBARB','Sync from Audience DataMart (BARB/RAJAR)','AudienceMartToFPV','uspMergeAudienceReachBARB')
			,(3,'RevenueGroup','Sync from MDS','RevenueGroupToFPV','uspMergeRevenueGroup')
			,(4,'MasterStation','Sync from MDS','MasterStationToFPV','uspMergeMasterStations')
			,(5,'MissingMinutes','Sync from FDM (DDI)','MissingMinutesToFPV','uspMergeMissingMinutes')
			,(6,'MusicMinutes','Sync from FDM (DDI)','MusicMinutesToFPV','uspMergeMusicMinutes')
			,(7,'PublicReception','Sync from FDM (DDI)','PublicReceptionToFPV','uspMergePublicReception')
			,(8,'UDC','Sync from MDS','UDCToFPV','uspMergeUDC')
			,(9,'AudienceMartRAJAR','Sync from Audience DataMart (BARB/RAJAR)','AudienceMartToFPV','uspMergeAudienceReachRAJAR')
) S ([IntegrationId], [IntegrationName], [IntegrationDescription], [ControlPackage], [UpdateProcedure])
ON T.[IntegrationName]=S.[IntegrationName]

WHEN NOT MATCHED BY TARGET THEN 
INSERT ([IntegrationId], [IntegrationName], [IntegrationDescription], [ControlPackage], [UpdateProcedure])
VALUES (S.[IntegrationId], S.[IntegrationName], S.[IntegrationDescription], S.[ControlPackage], S.[UpdateProcedure])
;

/****************************************************************************
SOCIETIES
****************************************************************************/
MERGE [FPV].[Society] T
USING (VALUES('PRS',1),('MCPS',1)) S ([Society],[Enabled])
ON T.[Society]=S.[Society]

WHEN NOT MATCHED THEN
INSERT ([Society],[Enabled]) VALUES (S.[Society],S.[Enabled])

--WHEN MATCHED THEN 
--UPDATE SET T.[Enabled]=S.[Enabled]
;

/****************************************************************************
[staging].[BroadcasterTimeBandMap]
****************************************************************************/
MERGE [staging].[BroadcasterTimeBandMap] T
USING (
		VALUES 
			  ('PEAK',	'HIGH PEAK',2,	'Y')
			 ,('OFF-PEAK',	'NON PEAK',2,	'Y')
			 ,('HIGH PEAK',	'HIGH PEAK',1,	'Y')
			 ,('~Not Supplied',	'~Not Supplied',9,	'N')
			 ,('NON PEAK',	'NON PEAK',1,	'Y')
			 ,('LOW PEAK',	'LOW PEAK',1,	'Y')
			 ,('NO BAND',	'NON BAND',2,	'Y')
) S ([REPTimeBand], [MappedTimeBand], [TimeBandRank], [ValidFlag])
ON T.[REPTimeBand]=S.[REPTimeBand] and T.[MappedTimeBand]=S.[MappedTimeBand] 

WHEN NOT MATCHED THEN
INSERT ([REPTimeBand], [MappedTimeBand], [TimeBandRank], [ValidFlag]) VALUES (S.[REPTimeBand], S.[MappedTimeBand], S.[TimeBandRank], S.[ValidFlag]);


/****************************************************************************
[Config].[ValidationRules]
****************************************************************************/

MERGE [Config].[ValidationRules] T
USING
(
VALUES 
(N'FPV.MasterRevenue', N'ValueGBP', N'Check Valid FPV Station has Source Revenue', N'staging.udfValidateSourceRevenue()', N'Abacus Validation', N'Validation Rule')
,(N'FPV.MasterMusicMinutes', N'PeakPercent', N'Peak Percent Alignments', N'staging.udfValidatePeakPercentSplits()', N'N/A', N'Alignment Info')
,(N'FPV.MasterUDC', N'UDC', N'Missing UDC for a station   ', N'staging.udfValidateStationUDCExists()', N'Abacus Validation', N'Validation Rule')
,(N'FPV.MasterStation', N'StationName', N'Application Status does not match MDS – ie over-ridden in Abacus from ‘Ceased’    ', N'staging.udfValidateActiveStationsCeased()', N'Abacus Validation', N'Validation Rule')
,(N'FPV.MasterUDC', N'UDC', N'UDC / Station descriptions labelled as Ceased yet part of the FPV dataset', N'staging.udfValidateCeasedStationUDCs()', N'Abacus Validation', N'Validation Rule')
,(N'FPV.MasterUDC', N'UDC', N'Incorrect number of UDC for Dist Group Category  ', N'staging.udfValidateStationUDCCounts()', N'Abacus Validation', N'Validation Rule')
,(N'FPV.MasterStation', N'CODA Customer Code', N'CODA Customer Code Not Unique for ILR Stations ', N'staging.udfValidateCODACustomerCode()', N'Abacus Validation', N'Validation Rule')
,(N'FPV.MasterStation', N'Sample Days', N'Sample Days must be same Commercial/NonCommercial for AV ', N'staging.udfValidateAVSampleDays()', N'Abacus Validation', N'Validation Rule')
) S ([AbacusTableName], [AttributeCheckName], [RuleDescription], [RuleUdf], [NotificationTemplate], [ValidationType])
ON T.[RuleUdf]=S.[RuleUdf]

WHEN NOT MATCHED BY TARGET THEN 
INSERT ([AbacusTableName], [AttributeCheckName], [RuleDescription], [RuleUdf], [NotificationTemplate], [ValidationType])
VALUES (S.[AbacusTableName], S.[AttributeCheckName], S.[RuleDescription], S.[RuleUdf], S.[NotificationTemplate], S.[ValidationType]);
GO

