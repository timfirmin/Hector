SET IDENTITY_INSERT DataQuality.DataIntegrityType ON 
GO

MERGE INTO DataQuality.DataIntegrityType AS Tgt
USING 
	(VALUES
		(0, 'N', 'Not Checked'),
		(1, 'P', 'Passed'),
		(2, 'F', 'Failed')
	) AS Src
	(
		 IntegrityTypeId
		,Code
		,Name
	)
	ON Tgt.IntegrityTypeId = Src.IntegrityTypeId

-- Update matched rows
WHEN MATCHED THEN
	UPDATE
	SET
		 Code				= Src.Code
		,Name		= Src.Name

-- Insert new rows
WHEN NOT MATCHED BY TARGET THEN
	INSERT
		(
			 IntegrityTypeId
			,Code
			,Name
		)
	VALUES
		(
			 Src.IntegrityTypeId
			,Src.Code
			,Src.Name
		)

-- Delete rows that are in the target but not the source
WHEN NOT MATCHED BY SOURCE THEN
	DELETE;
GO
	SET IDENTITY_INSERT  DataQuality.DataIntegrityType  OFF
