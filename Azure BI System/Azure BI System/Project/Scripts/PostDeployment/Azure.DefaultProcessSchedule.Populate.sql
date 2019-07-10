MERGE INTO [Azure].[DefaultProcessSchedule] AS Tgt
USING 
	(
	VALUES
		(1,1,1,1,1,1,1,1),
		(2,1,1,1,1,1,1,1)
	) 
	AS Src
	(
		[ProcessId],
		[Monday],
		[Tuesday],
		[Wednesday],
		[Thursday],
		[Friday],
		[Saturday],
		[Sunday]  	    
	)
	ON Tgt.[ProcessId]= Src.[ProcessId]

-- Update matched rows
WHEN MATCHED THEN
	UPDATE SET
		[Monday]	= Src.[Monday],
		[Tuesday]	= Src.[Tuesday],
		[Wednesday] = Src.[Wednesday],
		[Thursday]	= Src.[Thursday],
		[Friday]	= Src.[Friday],
		[Saturday]	= Src.[Saturday],
		[Sunday]	= Src.[Sunday]  

-- Insert new rows
WHEN NOT MATCHED BY TARGET THEN
	INSERT
		(
			[ProcessId],
			[Monday],
			[Tuesday],
			[Wednesday],
			[Thursday],
			[Friday],
			[Saturday],
			[Sunday]   
		)
	VALUES
		(
			Src.[ProcessId],
			Src.[Monday],
			Src.[Tuesday],
			Src.[Wednesday],
			Src.[Thursday],
			Src.[Friday],
			Src.[Saturday],
			Src.[Sunday]  
		)
--  Delete rows that are in the target but not the source
WHEN NOT MATCHED BY SOURCE THEN
	DELETE;
GO
