SET IDENTITY_INSERT OLAPControl.[Database] ON;

MERGE INTO OLAPControl.[Database] AS Tgt
USING 
	(VALUES
		(1,'Adventure Works Example')
	) AS Src
	(
		  DatabaseId
		 ,DatabaseName
	)
	ON Tgt.DatabaseId = Src.DatabaseId

-- Update matched rows
WHEN MATCHED THEN
	UPDATE
	SET
		  DatabaseName				= Src.DatabaseName
-- Insert new rows
WHEN NOT MATCHED BY TARGET THEN
	INSERT
		(
			 DatabaseId
			,DatabaseName
		)
	VALUES
		(
			 Src.DatabaseId
			,Src.DatabaseName
		)

-- Delete rows that are in the target but not the source
WHEN NOT MATCHED BY SOURCE THEN
	DELETE;

SET IDENTITY_INSERT OLAPControl.[Database] OFF;