

CREATE PROC  [Config].[spMaintainStationIDBank](@NumOfIDsRequired INT =100)
as
-- SP to maintain a minimum number of unallocated Station Ids alongwith MDS station ids.
BEGIN
	SET NOCOUNT ON
	DECLARE @NumOfIDsAvailable INT
	DECLARE @NewStnID VARCHAR(6)

	-- Load existing Station IDs from MDS.
	MERGE [Config].[StationID_Bank] AS TARGET
	USING (SELECT StationID, LoadingDateTime FROM [Staging].[ExistingStationID])  AS SOURCE 
	ON   
		TARGET.StationId = SOURCE.StationId 
	WHEN NOT MATCHED BY TARGET THEN  
	INSERT (StationID, AllocationDate, RequestorID)
	VALUES (SOURCE.StationID, Source.LoadingDateTime, 'MDS');

	-- If unallocated Station IDs go below minimum level, refresh with new IDs.
	SELECT @NumOfIDsAvailable= COUNT(*) FROM [Config].[StationID_Bank] WHERE AllocationDate IS NULL

	WHILE @NumOfIDsAvailable < @NumOfIDsRequired
	BEGIN
		BEGIN TRY
			-- Get numbers from a function for a specified range.
			SET @NewStnID = 'ZX' + LEFT(NEWID(), 4)	
			INSERT [Config].[StationID_Bank](StationID)
			SELECT @NewStnID 
			SET @NumOfIDsAvailable = @NumOfIDsAvailable + 1
		END TRY
		BEGIN CATCH
			IF @@ERROR <> 2627	-- Non Duplicate Key error.
			BEGIN
				SET @NumOfIDsAvailable = @NumOfIDsRequired + 1
				SELECT  
					ERROR_NUMBER() AS ErrorNumber   
					,ERROR_PROCEDURE() AS ErrorProcedure  
					,ERROR_MESSAGE() AS ErrorMessage;
			END
		END CATCH
	END
	SET NOCOUNT OFF
END