﻿SET IDENTITY_INSERT [Control].[Application] ON;
GO
MERGE INTO [Control].[Application] AS Tgt
USING 
	(VALUES
	-- 	[ApplicationId],[Name],												[Code],			[Description],													  [Priority],	[UpTimeHours],	[ETLType],	[WarehouseType],[Prefix],	[CreatedDate]
		(16,			'Data Experience Online Statements DM Stmt Rerun',  'DEOSDM',		'Data Experience DM Stmt Rerun Solution',								null,	 null,			null,		'Azure DW ',	'DMS',		SYSDATETIME())
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
		[Prefix],
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
		[WarehouseType]	   = Src.[WarehouseType],
		[Prefix]		   = Src.[Prefix]
-- Insert new rows
WHEN NOT MATCHED BY TARGET THEN
	INSERT
		(
			[ApplicationId],
			[Name],
     		[Code],
			[Description],
			[WarehouseType],
			[Prefix]		
		)
	VALUES
		(
			Src.[ApplicationId],
			Src.[Name],
			Src.[Code],
			Src.[Description],
			Src.[WarehouseType],
			Src.[Prefix]
		);
GO
SET IDENTITY_INSERT [Control].[Application] OFF;
