SET IDENTITY_INSERT [Control].[EntityType] ON;
GO
MERGE INTO [Control].[EntityType] AS Tgt
USING 
	(VALUES
	  --[EI],	[PETI],	[AI],	[IS],	[HMS],	[Name],										[Code],									[Description],													[Schema],				[Table],									[CreatedBy]							[CreatedDate]   
		-- DDI Disribution Data Integration

		(1350,	-1,		20,		1,		0,		N'MusicMinutes',							N'musicminutes',	     				N'Music Minutes',												N'DDIstaging',			N'DistributionMissingMinutes',				N'tim.firmin@prsformusic.com',	SYSDATETIME()),
		(1351,	-1,		20,		1,		0,		N'SampleDates',								N'sampledates',							N'SampleDates',													N'DDIstaging',			N'DistributionSampleDates',					N'tim.firmin@prsformusic.com',	SYSDATETIME()),
		(1352,	-1,		20,		1,		0,		N'PublicReception',		     				N'publicreception',						N'Public Reception',											N'DDIstaging',			N'DistributionPublicReception',				N'tim.firmin@prsformusic.com',	SYSDATETIME()),
		(1353,	-1,		20,		1,		0,		N'RevenueApportionment',					N'revenueapportionment',				N'Revenue Apportionment',										N'DDIstaging',			N'DistributionRevenueApportionment',		N'tim.firmin@prsformusic.com',	SYSDATETIME()),
		(1354,	-1,		20,		1,		0,		N'RAJAR',									N'rajar',								N'RAJAR',														N'DDIstaging',			N'DistributionRAJAR',						N'tim.firmin@prsformusic.com',	SYSDATETIME()),
		(1355,	-1,		20,		1,		0,		N'BARB',									N'barb',								N'BARB'														N'DDIstaging',			N'DistributionBARB',						N'tim.firmin@prsformusic.com',	SYSDATETIME()),


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


