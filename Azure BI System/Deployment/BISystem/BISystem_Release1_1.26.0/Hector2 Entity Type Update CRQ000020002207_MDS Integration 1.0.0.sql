SET IDENTITY_INSERT [Control].[EntityType] ON;
GO
MERGE INTO [Control].[EntityType] AS Tgt
USING 
	(VALUES
	  --[EI],	[PETI],	[AI],	[IS],	[HMS],	[Name],										[Code],									[Description],													[Schema],				[Table],									[CreatedBy]							[CreatedDate]   
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
	
		--  Master Station Integration (SampleDays AudioPolicy Changes)
		(1294,	NULL,	19,		0,		0,		N'Stage_SampleDays',	                   N'Stage_SampleDays',	                N'Stage_SampleDays',				                          	N'staging',		     	N'BroadcastSampleDays',	                    N'tim.firmin@prsformusic.com',	SYSDATETIME()),
		(1295,	NULL,	19,		0,		0,		N'Clean_SampleDays',	                   N'Clean_SampleDays',	                N'Clean_SampleDays',				                          	N'MDSI',		     	N'Clean_SampleDays',	                    N'tim.firmin@prsformusic.com',	SYSDATETIME()),
		(1296,	NULL,	19,		0,		0,		N'SampleDays',							   N'SampleDays',			          	N'SampleDays Data from Clean',									N'MDSI',		     	N'SampleDays',				             	N'tim.firmin@prsformusic.com',	SYSDATETIME()),
		(1297,	NULL,	19,		0,		0,		N'Stage_AudioPolicy',	                   N'Stage_AudioPolicy',	            N'Stage_AudioPolicy',				                          	N'staging',		     	N'BroadcastAudioPolicy',	                    N'tim.firmin@prsformusic.com',	SYSDATETIME()),
		(1298,	NULL,	19,		0,		0,		N'Clean_AudioPolicy',	                   N'Clean_AudioPolicy',	            N'Clean_AudioPolicy',				                          	N'MDSI',		     	N'Clean_AudioPolicy',	                    N'tim.firmin@prsformusic.com',	SYSDATETIME()),
		(1299,	NULL,	19,		0,		0,		N'AudioPolicy',							   N'AudioPolicy',			          	N'AudioPolicy Data from Clean',									N'MDSI',		     	N'AudioPolicy',				             	N'tim.firmin@prsformusic.com',	SYSDATETIME()),

		---  Master Station Integration (Licence Groups)
		(1500,	NULL,	19,		0,		0,		N'Stage_CustomObjects1',					N'Stage_CustomObjects1',				N'Stage_CustomObjects1',	         							N'MDSI',		     	N'Stage_CustomObjects1',					N'emma.williams@prsformusic.com',	SYSDATETIME()),
		(1501,	NULL,	19,		0,		0,		N'Stage_CustomObjects4',					N'Stage_CustomObjects4',				N'Stage_CustomObjects4',	         							N'MDSI',		     	N'Stage_CustomObjects4',					N'emma.williams@prsformusic.com',	SYSDATETIME()),
		(1502,	NULL,	19,		0,		0,		N'Stage_CustomObjects5',					N'Stage_CustomObjects5',				N'Stage_CustomObjects5',	         							N'MDSI',		     	N'Stage_CustomObjects5',					N'emma.williams@prsformusic.com',	SYSDATETIME()),
		(1503,	NULL,	19,		0,		0,		N'Stage_CustomObjects6',					N'Stage_CustomObjects6',				N'Stage_CustomObjects6',	         							N'MDSI',		     	N'Stage_CustomObjects6',					N'emma.williams@prsformusic.com',	SYSDATETIME()),
		(1504,	NULL,	19,		0,		0,		N'Clean_CustomObjects1',					N'Clean_CustomObjects1',				N'Clean_CustomObjects1',	         							N'MDSI',		     	N'Clean_CustomObjects1',					N'emma.williams@prsformusic.com',	SYSDATETIME()),
		(1505,	NULL,	19,		0,		0,		N'Clean_CustomObjects4',					N'Clean_CustomObjects4',				N'Clean_CustomObjects4',	         							N'MDSI',		     	N'Clean_CustomObjects4',					N'emma.williams@prsformusic.com',	SYSDATETIME()),
		(1506,	NULL,	19,		0,		0,		N'Clean_CustomObjects5',					N'Clean_CustomObjects5',				N'Clean_CustomObjects5',	         							N'MDSI',		     	N'Clean_CustomObjects5',					N'emma.williams@prsformusic.com',	SYSDATETIME()),
		(1507,	NULL,	19,		0,		0,		N'Clean_CustomObjects6',					N'Clean_CustomObjects6',				N'Clean_CustomObjects6',	         							N'MDSI',		     	N'Clean_CustomObjects6',					N'emma.williams@prsformusic.com',	SYSDATETIME()),
		(1508,	NULL,	19,		0,		0,		N'Transform_LicenceGroup',					N'Transform_LicenceGroup',           	N'Transform_LicenceGroup',	         							N'MDSI',		     	N'Transform_LicenceGroup',					N'emma.williams@prsformusic.com',	SYSDATETIME()),
		(1509,	NULL,	19,		0,		0,		N'Clean_SuppliedStation',					N'Clean_SuppliedStation',				N'Clean_SuppliedStation',				                  		N'MDSI',		     	N'Clean_SuppliedStation',					N'senay.yilmaz@prsformusic.com',	SYSDATETIME()),
		(1510,	NULL,	19,		0,		0,		N'MDS_LicenceGroup',						N'MDS_LicenceGroup',	                N'MDS_LicenceGroup',				                         	N'MDSI',		     	N'MDS_LicenceGroup',	                    N'emma.williams@prsformusic.com',	SYSDATETIME()),

				-- Audience Mart
		(1550,	-1,		23,		1,		0,		N'DailyBARB',		         				N'DailyBARB',		     				N'Daily BARB File',		        								N'Staging',				N'Daily_BARB_Data',							N'asingh@prsformusic.com',			SYSDATETIME()),		
		(1551,	-1,		23,		1,		0,		N'WeeklyBARB',		         				N'WeeklyBARB',		     				N'Weekly BARB File',		        							N'Staging',				N'Weekly_BARB_Data',						N'asingh@prsformusic.com',			SYSDATETIME()),
		(1552,	-1,		23,		1,		0,		N'QuartHrRAJAR',		         			N'QuartHrRAJAR',		     			N'Quart Hr RAJAR File',		        							N'Staging',				N'QuartHr_RAJAR_Data',						N'victor.mendes@prsformusic.com',	SYSDATETIME()),		
		(1553,	-1,		23,		1,		0,		N'QuartDayRAJAR',		         			N'QuartDayRAJAR',		     			N'Quart Day RAJAR File',		        						N'Staging',				N'QuartDay_RAJAR_Data',						N'victor.mendes@prsformusic.com',	SYSDATETIME()),
		(1554,	-1,		23,		1,		0,		N'QuartListenRAJAR',		         		N'QuartListenRAJAR',		     		N'Quart Listening RAJAR File',		        					N'Staging',				N'QuartListening_RAJAR_Data',				N'victor.mendes@prsformusic.com',	SYSDATETIME()),		
			

		-- Master Station Integration (UDC Integration Work)
		(1600,	NULL,	19,		0,		0,		N'Stage_Third_Parties',	                   N'Stage_Third_Parties',					N'Stage_Third_Parties',				                          	N'staging',		     	N'Stage_Third_Parties',	                    N'tim.firmin@prsformusic.com',	SYSDATETIME()),
		(1602,	NULL,	19,		0,		0,		N'Stage_Bands',								N'Stage_Bands',							N'Stage_Bands',				                          			N'staging',		     	N'Stage_Bands',								N'tim.firmin@prsformusic.com',	SYSDATETIME()),
		(1603,	NULL,	19,		0,		0,		N'Stage_Usage_Distribution_Groups',			N'Stage_Usage_Distribution_Groups',		N'Stage_Usage_Distribution_Groups',				                          		N'staging',		     	N'Stage_REPSpare',							N'tim.firmin@prsformusic.com',	SYSDATETIME()),
		(1604,	NULL,	19,		0,		0,		N'Stage_Usage_Group',						N'Stage_Usage_Group',					N'Stage_Usage_Group',				                          	N'staging',		     	N'Stage_Usage_Group',	                    N'tim.firmin@prsformusic.com',	SYSDATETIME()),
		(1605,	NULL,	19,		0,		0,		N'Stage_Usage_Group_Summary',	            N'Stage_Usage_Group_Summary',			N'Stage_Usage_Group_Summary',									N'staging',		     	N'Stage_Usage_Group_Summary',				N'tim.firmin@prsformusic.com',	SYSDATETIME()),
		(1606,	NULL,	19,		0,		0,		N'Stage_Usage_Group_Type',	                N'Stage_Usage_Group_Type',				N'Stage_Usage_Group_Type',										N'staging',		     	N'Stage_Usage_Group_Type',					N'tim.firmin@prsformusic.com',	SYSDATETIME()),
		(1607,	NULL,	19,		0,		0,		N'Stage_Usage_Group_Summary_Reports',	    N'Stage_Usage_Group_Summary_Reports',	N'Stage_Usage_Group_Summary_Reports',							N'staging',		     	N'Stage_Usage_Group_Summary_Reports',		N'tim.firmin@prsformusic.com',	SYSDATETIME()),
		(1608,	NULL,	19,		0,		0,		N'Stage_DandM_Spare',						N'Stage_DandM_Spare',					N'Stage_DandM_Spare',											N'staging',		     	N'Stage_DandM_Spare',		N'tim.firmin@prsformusic.com',	SYSDATETIME()),

		-- Master Station Integration (UDC Integration Work)
		(1620,	NULL,	19,		0,		0,		N'Clean_Third_Parties',	                    N'Clean_Third_Parties',					N'Clean_Third_Parties',				                          	N'clean',		     	N'Clean_Third_Parties',	                    N'tim.firmin@prsformusic.com',	SYSDATETIME()),
		(1622,	NULL,	19,		0,		0,		N'Clean_Bands',								N'Clean_Bands',							N'Clean_Bands',				                          			N'clean',		     	N'Clean_Bands',								N'tim.firmin@prsformusic.com',	SYSDATETIME()),
		(1623,	NULL,	19,		0,		0,		N'Clean_Usage_Distribution_Groups',			N'Clean_Usage_Distribution_Groups',		N'Clean_Usage_Distribution_Groups',				                N'clean',		     	N'Clean_REPSpare',							N'tim.firmin@prsformusic.com',	SYSDATETIME()),
		(1624,	NULL,	19,		0,		0,		N'Clean_Usage_Group',						N'Clean_Usage_Group',					N'Clean_Usage_Group',				                          	N'clean',		     	N'Clean_Usage_Group',	                    N'tim.firmin@prsformusic.com',	SYSDATETIME()),
		(1625,	NULL,	19,		0,		0,		N'Clean_Usage_Group_Summary',	            N'Clean_Usage_Group_Summary',			N'Clean_Usage_Group_Summary',									N'clean',		     	N'Clean_Usage_Group_Summary',				N'tim.firmin@prsformusic.com',	SYSDATETIME()),
		(1626,	NULL,	19,		0,		0,		N'Clean_Usage_Group_Type',	                N'Clean_Usage_Group_Type',				N'Clean_Usage_Group_Type',										N'clean',		     	N'Clean_Usage_Group_Type',					N'tim.firmin@prsformusic.com',	SYSDATETIME()),
		(1627,	NULL,	19,		0,		0,		N'Clean_Usage_Group_Summary_Reports',	    N'Clean_Usage_Group_Summary_Reports',	N'Clean_Usage_Group_Summary_Reports',							N'clean',		     	N'Clean_Usage_Group_Summary_Reports',		N'tim.firmin@prsformusic.com',	SYSDATETIME()),
		(1628,	NULL,	19,		0,		0,		N'Clean_DandM_Spare',						N'Clean_DandM_Spare',					N'Clean_DandM_Spare',											N'clean',		     	N'Clean_DandM_Spare',						N'tim.firmin@prsformusic.com',	SYSDATETIME()),

		-- Master Station Integration (UDC Integration Work)
		(1640,	NULL,	19,		0,		0,		N'Transform_BroadcasterUDCMapping',	        N'Transform_BroadcasterUDCMapping',		N'Transform_BroadcasterUDCMapping',				                N'transform',		    N'Transform_BroadcasterUDCMapping',	        N'tim.firmin@prsformusic.com',	SYSDATETIME()),
		(1641,	NULL,	19,		0,		0,		N'Transform_StationUDCDeltas',				N'Transform_StationUDCDeltas',			N'Transform_StationUDCDeltas',				                    N'transform',		    N'Transform_StationUDCDeltas',				N'tim.firmin@prsformusic.com',	SYSDATETIME()),
		(1642,	NULL,	19,		0,		0,		N'Transform_MasterUDC',						N'Transform_MasterUDC',					N'Transform_MasterUDC',											N'transform',		    N'Transform_MasterUDC',						N'tim.firmin@prsformusic.com',	SYSDATETIME()),
		(1643,	NULL,	19,		0,		0,		N'MDS_MasterUDC',							N'MDS_MasterUDC',						N'MDS_MasterUDC',												N'transform',		    N'MDS_MasterUDC',							N'tim.firmin@prsformusic.com',	SYSDATETIME()),
 		(1644,	NULL,	19,		0,		0,		N'MDS_StationUDC',							N'MDS_StationUDC',						N'MDS_StationUDC',												N'transform',		    N'MDS_StationUDC',							N'tim.firmin@prsformusic.com',	SYSDATETIME()),
		(1645,	NULL,	19,		0,		0,		N'Transform_Spare',							N'Transform_Spare',						N'Transform_Spare',												N'transform',		    N'Transform_Spare',							N'tim.firmin@prsformusic.com',	SYSDATETIME()),


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


