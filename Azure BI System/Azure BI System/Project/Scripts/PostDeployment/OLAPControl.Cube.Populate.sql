SET IDENTITY_INSERT OLAPControl.[Cube] ON;

MERGE INTO OLAPControl.[Cube] AS Tgt
USING 
	(VALUES
		(1, 1, 'PRS Analytics', 1)
	) AS Src
	(
		  CubeId
		 ,DatabaseId
		 ,CubeName
		 ,RequiresProcess
	)
	ON Tgt.CubeId = Src.CubeId

-- Update matched rows
WHEN MATCHED THEN
	UPDATE
	SET
		  CubeName				= Src.CubeName
-- Insert new rows
WHEN NOT MATCHED BY TARGET THEN
	INSERT
		(
			 CubeId
			,DatabaseId
			,CubeName
			,RequiresProcess
		)
	VALUES
		(
			 Src.CubeId
			,Src.DatabaseId
			,Src.CubeName
			,Src.RequiresProcess
		)

-- Delete rows that are in the target but not the source
WHEN NOT MATCHED BY SOURCE THEN
	DELETE;

SET IDENTITY_INSERT OLAPControl.[Cube] OFF;