SET IDENTITY_INSERT [Control].[EntityType] ON;
GO
MERGE INTO [Control].[EntityType] AS Tgt
USING 
	(VALUES
	  --[EI],	[PETI],	[AI],	[IS],	[HMS],	[Name],										[Code],									[Description],													[Schema],				[Table],									[CreatedBy]							[CreatedDate]
		(1250,	NULL,	18,		0,		0,		N'TM1RevenueLoad',							N'tm1revenueload',						N'TM1RevenueLoad',												N'TM1Staging',			N'TM1RevenueLoad',							N'tim.firmin@prsformusic.com',	SYSDATETIME()),
		(1251,	NULL,	18,		0,		0,		N'TM1CostsLoad',							N'tm1costsload',						N'TM1CostsLoad',												N'TM1Staging',			N'TM1CostsLoad',							N'tim.firmin@prsformusic.com',	SYSDATETIME()),
        
		---  Master Station Integration
		(1252,	NULL,	19,		0,		0,		N'Domain',							        N'Domain',					        	N'Domain Data from Clean',										N'MDSI',		     	N'Domain',						        	N'senay.yilmaz@prsformusic.com',	SYSDATETIME()),
		(1253,	NULL,	19,		0,		0,		N'Territory',							    N'Territory',			          	    N'Territory Data from Clean',									N'MDSI',		     	N'Territory',				             	N'senay.yilmaz@prsformusic.com',	SYSDATETIME()),
		(1254,	NULL,	19,		0,		0,		N'RightType',							    N'RightType',			          	    N'RightType Data from Clean',									N'MDSI',		     	N'RightType',				             	N'senay.yilmaz@prsformusic.com',	SYSDATETIME()),
		(1255,	NULL,	19,		0,		0,		N'MCPSLicenceType',							N'MCPSLicenceType',			          	N'MCPSLicenceType Data from Clean',								N'MDSI',		     	N'MCPSLicenceType',				            N'senay.yilmaz@prsformusic.com',	SYSDATETIME()),
		(1256,	NULL,	19,		0,		0,		N'MasterStationData',						N'MasterStationData',			       	N'MasterStationData Data from Clean',							N'MDSI',		     	N'MasterStationData',				        N'senay.yilmaz@prsformusic.com',	SYSDATETIME()),

		(1257,	NULL,	19,		0,		0,		N'MDS_Domains',						    	N'MDS_Domains',			             	N'MDS_Domains Data from Transform',								N'MDSI',		     	N'MDS_Domains',						        N'senay.yilmaz@prsformusic.com',	SYSDATETIME()),
		(1258,	NULL,	19,		0,		0,		N'MDS_MasterStationData',				   	N'MDS_MasterStationData',		      	N'MDS_MasterStationData Data from Transform',					N'MDSI',		     	N'MDS_MasterStationData',				    N'senay.yilmaz@prsformusic.com',	SYSDATETIME()),
		(1259,	NULL,	19,		0,		0,		N'MDS_MCPSLicenceType',				      	N'MDS_MCPSLicenceType',		        	N'MDS_MCPSLicenceType Data from Transform',				    	N'MDSI',		     	N'MDS_MCPSLicenceType',				        N'senay.yilmaz@prsformusic.com',	SYSDATETIME()),
		(1260,	NULL,	19,		0,		0,		N'MDS_RightType',				         	N'MDS_RightType',		            	N'MDS_RightType Data from Transform',				        	N'MDSI',		     	N'MDS_RightType',				            N'senay.yilmaz@prsformusic.com',	SYSDATETIME()),
		(1261,	NULL,	19,		0,		0,		N'MDS_Territory',				         	N'MDS_Territory',		            	N'MDS_Territory Data from Transform',				        	N'MDSI',		     	N'MDS_Territory',				            N'senay.yilmaz@prsformusic.com',	SYSDATETIME()),

		(1262,	NULL,	19,		0,		0,		N'Stage_Broadcaster_MCPS_Licence_Types',   N'Stage_Broadcaster_MCPS_Licence_Types',	N'Stage_Broadcaster_MCPS_Licence_Types',	         	        N'MDSI',		     	N'Stgae_Broadcaster_MCPS_Licence_Types',	N'senay.yilmaz@prsformusic.com',	SYSDATETIME()),
		(1263,	NULL,	19,		0,		0,		N'Stage_Broadcaster_Right_Types',	       N'Stage_Broadcaster_Right_Types',	    N'Stage_Broadcaster_Right_Types',				                N'MDSI',		     	N'Stage_Broadcaster_Right_Types',	        N'senay.yilmaz@prsformusic.com',	SYSDATETIME()),
		(1264,	NULL,	19,		0,		0,		N'Stage_Broadcaster_UDCS',	               N'Stage_Broadcaster_UDCS',	            N'Stage_Broadcaster_UDCS',		                         	    N'MDSI',		     	N'Stage_Broadcaster_UDCS',	                N'senay.yilmaz@prsformusic.com',	SYSDATETIME()),
		(1265,	NULL,	19,		0,		0,		N'Stage_Broadcasters',	                   N'Stage_Broadcasters',	                N'Stage_Broadcasters',				                          	N'MDSI',		     	N'Stage_Broadcasters',	                    N'senay.yilmaz@prsformusic.com',	SYSDATETIME()),
		(1266,	NULL,	19,		0,		0,		N'Stage_CG_Ref_Codes',	                   N'Stage_CG_Ref_Codes',	                N'Stage_CG_Ref_Codes',			                             	N'MDSI',		     	N'Stage_CG_Ref_Codes',	                    N'senay.yilmaz@prsformusic.com',	SYSDATETIME()),
		(1267,	NULL,	19,		0,		0,		N'Stage_Domains',	                       N'Stage_Domains',	                    N'Stage_Domains',				                              	N'MDSI',		     	N'Stage_Domains',	                        N'senay.yilmaz@prsformusic.com',	SYSDATETIME()),
		(1268,	NULL,	19,		0,		0,		N'Stage_Elementary_Territories',	       N'Stage_Elementary_Territories',	        N'Stage_Elementary_Territories',				               	N'MDSI',		     	N'Stage_Elementary_Territories',	        N'senay.yilmaz@prsformusic.com',	SYSDATETIME()),
		(1269,	NULL,	19,		0,		0,		N'Stage_MCPS_Licence_Types',	           N'Stage_MCPS_Licence_Types',	            N'Stage_MCPS_Licence_Types',		     		               	N'MDSI',		     	N'Stage_MCPS_Licence_Types',	            N'senay.yilmaz@prsformusic.com',	SYSDATETIME()),
		(1270,	NULL,	19,		0,		0,		N'Stage_Usage_Distribution_Codes',	       N'Stage_Usage_Distribution_Codes',	    N'Stage_Usage_Distribution_Codes',	    		               	N'MDSI',		     	N'Stage_Usage_Distribution_Codes',	        N'senay.yilmaz@prsformusic.com',	SYSDATETIME()),

		(1271,	NULL,	19,		0,		0,		N'Clean_Broadcaster_MCPS_Licence_Types',   N'Clean_Broadcaster_MCPS_Licence_Types',	N'Clean_Broadcaster_MCPS_Licence_Types',	         	        N'MDSI',		     	N'Clean_Broadcaster_MCPS_Licence_Types',	N'senay.yilmaz@prsformusic.com',	SYSDATETIME()),
		(1272,	NULL,	19,		0,		0,		N'Clean_Broadcaster_Right_Types',	       N'Clean_Broadcaster_Right_Types',	    N'Clean_Broadcaster_Right_Types',				                N'MDSI',		     	N'Clean_Broadcaster_Right_Types',	        N'senay.yilmaz@prsformusic.com',	SYSDATETIME()),
		(1273,	NULL,	19,		0,		0,		N'Clean_Broadcaster_UDCS',	               N'Clean_Broadcaster_UDCS',	            N'Clean_Broadcaster_UDCS',		                         	    N'MDSI',		     	N'Clean_Broadcaster_UDCS',	                N'senay.yilmaz@prsformusic.com',	SYSDATETIME()),
		(1274,	NULL,	19,		0,		0,		N'Clean_Broadcasters',	                   N'Clean_Broadcasters',	                N'Clean_Broadcasters',				                          	N'MDSI',		     	N'Clean_Broadcasters',	                    N'senay.yilmaz@prsformusic.com',	SYSDATETIME()),
		(1275,	NULL,	19,		0,		0,		N'Clean_CG_Ref_Codes',	                   N'Clean_CG_Ref_Codes',	                N'Clean_CG_Ref_Codes',			                             	N'MDSI',		     	N'Clean_CG_Ref_Codes',	                    N'senay.yilmaz@prsformusic.com',	SYSDATETIME()),
		(1276,	NULL,	19,		0,		0,		N'Clean_Domains',	                       N'Clean_Domains',	                    N'Clean_Domains',				                              	N'MDSI',		     	N'Clean_Domains',	                        N'senay.yilmaz@prsformusic.com',	SYSDATETIME()),
		(1277,	NULL,	19,		0,		0,		N'Clean_Elementary_Territories',	       N'Clean_Elementary_Territories',	        N'Clean_Elementary_Territories',				               	N'MDSI',		     	N'Clean_Elementary_Territories',	        N'senay.yilmaz@prsformusic.com',	SYSDATETIME()),
		(1278,	NULL,	19,		0,		0,		N'Clean_MCPS_Licence_Types',	           N'Clean_MCPS_Licence_Types',	            N'Clean_MCPS_Licence_Types',		     		               	N'MDSI',		     	N'Clean_MCPS_Licence_Types',	            N'senay.yilmaz@prsformusic.com',	SYSDATETIME()),
		(1279,	NULL,	19,		0,		0,		N'Clean_Usage_Distribution_Codes',	       N'Clean_Usage_Distribution_Codes',	    N'Clean_Usage_Distribution_Codes',	    		               	N'MDSI',		     	N'Clean_Usage_Distribution_Codes',	        N'senay.yilmaz@prsformusic.com',	SYSDATETIME()),

		---  Master Station Integration (Continued)
		(1281,	NULL,	19,		0,		0,		N'Transform_CodaAccountEL2',               N'Transform_CodaAccountEL2',           	N'Transform_CodaAccountEL2',	         	                    N'MDSI',		     	N'Transform_CodaAccountEL2',	            N'senay.yilmaz@prsformusic.com',	SYSDATETIME()),
		(1282,	NULL,	19,		0,		0,		N'Transform_CodaCustomerCodes',	           N'Transform_CodaCustomerCodes',	        N'Transform_CodaCustomerCodes',				                    N'MDSI',		     	N'Transform_CodaCustomerCodes',	            N'senay.yilmaz@prsformusic.com',	SYSDATETIME()),
		(1283,	NULL,	19,		0,		0,		N'MDS_CodaAccountCodeEL2',	               N'MDS_CodaAccountCodeEL2',	            N'MDS_CodaAccountCodeEL2',		                         	    N'MDSI',		     	N'MDS_CodaAccountCodeEL2',	                N'senay.yilmaz@prsformusic.com',	SYSDATETIME()),
		(1284,	NULL,	19,		0,		0,		N'MDS_CodaCustomer',	                   N'MDS_CodaCustomer',	                    N'MDS_CodaCustomer',				                          	N'MDSI',		     	N'MDS_CodaCustomer',	                    N'senay.yilmaz@prsformusic.com',	SYSDATETIME()),
		(1285,	NULL,	19,		0,		0,		N'Alerts_CodaCodes',	                   N'Alerts_CodaCodes',	                    N'Alerts_CodaCodes',			                             	N'MDSI',		     	N'Alerts_CodaCodes',	                    N'senay.yilmaz@prsformusic.com',	SYSDATETIME()),
		(1286,	NULL,	19,		0,		0,		N'Transform_SuppliedStation',	           N'Transform_SuppliedStation',	        N'Transform_SuppliedStation',				                  	N'MDSI',		     	N'Transform_SuppliedStation',	            N'senay.yilmaz@prsformusic.com',	SYSDATETIME()),
		(1287,	NULL,	19,		0,		0,		N'MDS_SuppliedStation',	                   N'MDS_SuppliedStation',	                N'MDS_SuppliedStation',				                         	N'MDSI',		     	N'MDS_SuppliedStation',	                    N'senay.yilmaz@prsformusic.com',	SYSDATETIME()),
		(1288,	NULL,	19,		0,		0,		N'Alerts_SuppliedStation',	               N'Alerts_SuppliedStation',	            N'Alerts_SuppliedStation',		     		                 	N'MDSI',		     	N'Alerts_SuppliedStation',	                N'senay.yilmaz@prsformusic.com',	SYSDATETIME()),
	    (1289,	NULL,	19,		0,		0,		N'Transform_AnalogyStation',	           N'Transform_AnalogyStation',	            N'Transform_AnalogyStation',				                    N'MDSI',		     	N'Transform_AnalogyStation',	            N'omoadoni.ayonote@prsformusic.com',	 SYSDATETIME()),
		(1290,	NULL,	19,		0,		0,		N'MDS_AnalogyStation',	                   N'MDS_AnalogyStation',	                N'MDS_AnalogyStation',				                         	N'MDSI',		     	N'MDS_AnalogyStation',	                    N'omoadoni.ayonote@prsformusic.com',	SYSDATETIME()),
		(1291,	NULL,	19,		0,		0,		N'Alerts_AnalogyStation',	               N'Alerts_AnalogyStation',	            N'Alerts_AnalogyStation',		     		                 	N'MDSI',		     	N'Alerts_AnalogyStation',	                N'omoadoni.ayonote@prsformusic.com',	SYSDATETIME()),
	
		-- FPV Application and Integration

		(1300,	-1,		20,		1,		0,		N'RevenueIntegrationTM1',					N'revenueintegrationtm1',	     		N'FPV TM1 Revenue Integration',									N'staging',				N'DistributionRevenueTM1',					N'tim.firmin@prsformusic.com',	SYSDATETIME()),
		(1301,	-1,		20,		1,		0,		N'DistributionRevenueCalendar',				N'distributionrevenuecalendar',			N'Distribution Revenue Calendar',								N'FPV',					N'DistributionRevenueCalendar',				N'tim.firmin@prsformusic.com',	SYSDATETIME()),
		(1302,	-1,		20,		1,		0,		N'MasterStation',		     				N'masterstation',						N'MasterStation',												N'FPV',					N'MasterStation',							N'tim.firmin@prsformusic.com',	SYSDATETIME()),
		(1303,	-1,		20,		1,		0,		N'MasterDistributionGroup',				    N'masterdistributiongroup',				N'Master Distribution Group',									N'FPV',					N'MasterDistributionGroup',					N'tim.firmin@prsformusic.com',	SYSDATETIME()),
		(1304,	-1,		20,		1,		0,		N'MasterDistributionPeriod',				N'masterdistributionperiod',			N'Master Distribution Period',									N'FPV',					N'MasterDistributionPeriod',				N'tim.firmin@prsformusic.com',	SYSDATETIME()),
		(1305,	-1,		20,		1,		0,		N'MasterPlanningScenario',					N'masterplanningscenario',				N'Master Planning Scenario',									N'FPV',					N'MasterPlanningScenario',					N'tim.firmin@prsformusic.com',	SYSDATETIME()),

		-- DDI Disribution Data Integration

		(1350,	-1,		20,		1,		0,		N'MusicMinutes',							N'musicminutes',	     				N'Music Minutes',												N'DDIstaging',			N'DistributionMissingMinutes',				N'tim.firmin@prsformusic.com',	SYSDATETIME()),
		(1351,	-1,		20,		1,		0,		N'SampleDates',								N'sampledates',							N'SampleDates',													N'DDIstaging',			N'DistributionSampleDates',					N'tim.firmin@prsformusic.com',	SYSDATETIME()),
		(1352,	-1,		20,		1,		0,		N'PublicReception',		     				N'publicreception',						N'Public Reception',											N'DDIstaging',			N'DistributionPublicReception',				N'tim.firmin@prsformusic.com',	SYSDATETIME()),
		(1353,	-1,		20,		1,		0,		N'RevenueApportionment',					N'revenueapportionment',				N'Revenue Apportionment',										N'DDIstaging',			N'DistributionRevenueApportionment',		N'tim.firmin@prsformusic.com',	SYSDATETIME()),
		(1354,	-1,		20,		1,		0,		N'RAJAR',									N'rajar',								N'RAJAR',														N'DDIstaging',			N'DistributionRAJAR',						N'tim.firmin@prsformusic.com',	SYSDATETIME()),
		(1355,	-1,		20,		1,		0,		N'BARB',									N'barb',								N'BARB',														N'DDIstaging',			N'DistributionBARB',						N'tim.firmin@prsformusic.com',	SYSDATETIME()),

		
		(1356,	-1,		6,		1,		0,		N'ETL_STATION_REPLICATION',		         	N'etlstationreplication',		     	N'ETLSystem Data File ETL_STATION_REPLICATION',		        	N'staging',				N'ETL_STATION_REPLICATION',			        N'senay.yilmaz@prsformusic.com',SYSDATETIME()),		
		(1357,	-1,		6,		0,		0,		N'EtlStationReplication',					N'dmt_EtlStationReplication',			N'ETLSystem Datamart Table EtlStationReplication',				N'datamart',			N'EtlStationReplication',					N'senay.yilmaz@prsformusic.com',	SYSDATETIME())

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
--  Delete rows that are in the target but not the source
/*
WHEN NOT MATCHED BY SOURCE THEN
	DELETE;
GO
SET IDENTITY_INSERT [Control].[EntityType] OFF;
*/


