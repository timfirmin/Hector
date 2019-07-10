MERGE INTO DataQuality.HarmoniseRule AS Tgt
USING 
	(VALUES
		 (1,'PostCode','ToUpper',1)
		,(2,'Group','ToUpper',1)
			
	) AS Src
	(
	   [HarmoniseRuleId]
      ,[ColumnName]
      ,[CleanseType]
      ,[EntityTypeID]
	)
	ON Tgt.[HarmoniseRuleId] = Src.[HarmoniseRuleId]

-- Update matched rows
WHEN MATCHED THEN
UPDATE 
   SET [HarmoniseRuleId]	=		src.[HarmoniseRuleId]
      ,[ColumnName]			=		src.[ColumnName]
      ,[CleanseType]		=		src.[CleanseType]
      ,[EntityTypeID]		=		src.[EntityTypeID]
      

-- Insert new rows
WHEN NOT MATCHED BY TARGET THEN
	INSERT
		(
	   [HarmoniseRuleId]
      ,[ColumnName]
      ,[CleanseType]
      ,[EntityTypeID]
     
		)
	VALUES
		(
		 src.[HarmoniseRuleId]
		,src.[ColumnName]
		,src.[CleanseType]
		,src.[EntityTypeID]
		
		);

-- Delete rows that are in the target but not the source
--WHEN NOT MATCHED BY SOURCE THEN
--	DELETE;

	--SET IDENTITY_INSERT  DataQuality.HarmoniseRule  OFF;
