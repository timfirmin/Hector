--SET IDENTITY_INSERT DataQuality.[CleanseRule] ON 

MERGE INTO [DataQuality].[StandardiseRule] AS Tgt
USING 
	(VALUES
		 (1,1,'Name','Contains','Central','ReplaceWith','Middle',1)
		,(2,2,'Name','EndsWith','Cty','ReplaceWith','City',1)

		
	) AS Src
	(
	   [StandardiseRuleId]
      ,[DataQualityRuleId]
      ,[ColumnName]
      ,[PatternMatchType]
      ,[Criteria]
      ,[StandardiseType]
      ,[StandardiseTypeValue]
      ,[EntityTypeID]
	)
	ON Tgt.[StandardiseRuleId] = Src.[StandardiseRuleId]

-- Update matched rows
WHEN MATCHED THEN
UPDATE 
   SET [StandardiseRuleId] = src.[StandardiseRuleId]
      ,[DataQualityRuleId] = src.[DataQualityRuleId]
      ,[ColumnName] = src.[ColumnName]
      ,[PatternMatchType] = src.[PatternMatchType]
      ,[Criteria] = src.[Criteria]
      ,[StandardiseType] = src.[StandardiseType]
      ,[StandardiseTypeValue] = src.[StandardiseTypeValue]
      ,[EntityTypeID] = src.[EntityTypeID]
    

-- Insert new rows
WHEN NOT MATCHED BY TARGET THEN
	INSERT
		(
	   [StandardiseRuleId]
      ,[DataQualityRuleId]
      ,[ColumnName]
      ,[PatternMatchType]
      ,[Criteria]
      ,[StandardiseType]
      ,[StandardiseTypeValue]
      ,[EntityTypeID]
		)
	VALUES
		(
		   src.[StandardiseRuleId]
		  ,src.[DataQualityRuleId]
		  ,src.[ColumnName]
		  ,src.[PatternMatchType]
		  ,src.[Criteria]
		  ,src.[StandardiseType]
		  ,src.[StandardiseTypeValue]
		  ,src.[EntityTypeID]

		);

-- Delete rows that are in the target but not the source
--WHEN NOT MATCHED BY SOURCE THEN
--	DELETE;

	--SET IDENTITY_INSERT  DataQuality.[CleanseRule]  OFF;
