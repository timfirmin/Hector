/*

Change the column length to support new codes -- VBA - 04/10/2017
--ALTER TABLE control.ProcessStream
--ALTER COLUMN Code CHAR(12)

*/


SET IDENTITY_INSERT [Control].[ProcessStream] ON;
GO
MERGE INTO [Control].[ProcessStream] AS Tgt
USING 
	(VALUES
		(1,'EXT2STG',		'Blob External To Stage', ''	,5),
		(2,'STG2CLN',		'Stage To Clean', '' ,8),
		(3,'CLN2TRN',		'Clean To Transform','',12),
		(4,'TRN2WAR',		'Transform To Warehouse','',18),
		(5,'REF2TRN',		'Reference To Transform','',14),
		(6,'CLN2WAR',		'Clean To Warehouse','',24),
		(7,'TRN2TRN',		'Transform To Transform','',22),
		(8,'TRN2REJ',		'Transform To Reject','',21),
		(9,'SRC2FILE',		'Source To File Extract','',3),
		(10,'STG2TRN',		'Stage to Transform','',16),
		(11,'FILE2EXT',		'File Extract To External','',1),
		(12,'SRC2STG',		'Source System to Staging','',10),
		(13,'WAR2TAB',		'Warehouse To Tabular','',28),
		(14,'MDS2STG',		'MDS Data to Staging','',14),	
		(15,'STG2MDS',		'Staging to MDS','',20),
		(16,'STG2DMT',		'Staging to DataMart','',19),
		(17,'DMT2EXT',		'DataMart to External','',27),
		(18,'WAR2OLP',		'Warehouse To OLAP','',29),
		(19,'EXT2STGMF',	'Blob External To Stage Multiple Files','',30),
		(20,'CLN2DS',		'Clean to DataStore','',25),
		(21,'TRN2DS',		'Transform to DataStore','',26)
		

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
