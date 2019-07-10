SET IDENTITY_INSERT [Control].[EntityType] ON;
GO
MERGE INTO [Control].[EntityType] AS Tgt
USING 
	(VALUES
	  --[EI],	[PETI],	[AI],	[IS],	[HMS],	[Name],										[Code],									[Description],													[Schema],				[Table],									[CreatedBy]							[CreatedDate]
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
		(1279,	NULL,	19,		0,		0,		N'Clean_Usage_Distribution_Codes',	       N'Clean_Usage_Distribution_Codes',	    N'Clean_Usage_Distribution_Codes',	    		               	N'MDSI',		     	N'Clean_Usage_Distribution_Codes',	        N'senay.yilmaz@prsformusic.com',	SYSDATETIME())
		

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

-- Insert new rowsa
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



