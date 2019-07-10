SET IDENTITY_INSERT Control.DataQualityRuleType ON;
GO
MERGE INTO Control.DataQualityRuleType AS Tgt
USING 
	(VALUES
		(10, 'Regex'),
		(20, 'Range'),
		(30, 'Containts'),
		(40, 'BeginsWith'),
		(50, 'Pattern'),
		(60, 'MDM')
	) AS Src
	(
		  DataQualityRuleTypeId
		 ,Name    
	)
	ON Tgt.DataQualityRuleTypeId = Src.DataQualityRuleTypeId

-- Update matched rows
WHEN MATCHED THEN
	UPDATE
	SET
		  Name = Src.Name

-- Insert new rows
WHEN NOT MATCHED BY TARGET THEN
	INSERT
		(
			 DataQualityRuleTypeId
			,Name      
		)
	VALUES
		(
			 Src.DataQualityRuleTypeId
			,Src.Name 
		);

-- Delete rows that are in the target but not the source
--WHEN NOT MATCHED BY SOURCE THEN
--	DELETE;

SET IDENTITY_INSERT Control.DataQualityRuleType OFF;