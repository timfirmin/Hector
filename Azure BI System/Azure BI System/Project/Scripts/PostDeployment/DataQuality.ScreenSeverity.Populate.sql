--SET IDENTITY_INSERT DataQuality.ScreenSeverity ON 

MERGE INTO DataQuality.ScreenSeverity AS Tgt
USING 
	(VALUES
		(1,'Low','Low'),
		(2,'Medium','Medium'),
		(3,'High','High')				     	
	) AS Src
	(
		ScreenSeverityID, 
		SeverityName, 
		SeverityCategory
	)
	ON Tgt.[ScreenSeverityID] = Src.[ScreenSeverityID]

-- Update matched rows
WHEN MATCHED THEN
UPDATE 
   SET [SeverityName] = src.SeverityName
      ,[SeverityCategory] = src.SeverityCategory

-- Insert new rows
WHEN NOT MATCHED BY TARGET THEN
	INSERT
		(
		ScreenSeverityID, 
		SeverityName, 
		SeverityCategory
		)
	VALUES
		(
			src.ScreenSeverityID, 
			src.SeverityName, 
			src.SeverityCategory
		);
-- Delete rows that are in the target but not the source
--WHEN NOT MATCHED BY SOURCE THEN
--	DELETE;

--SET IDENTITY_INSERT  DataQuality.ScreenSeverity  OFF;
