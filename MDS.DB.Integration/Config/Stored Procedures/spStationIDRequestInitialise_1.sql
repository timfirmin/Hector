

CREATE PROC [Config].[spStationIDRequestInitialise](@NoOfIDsRequested INT, @RequestorID VARCHAR(20), @RequestID UNIQUEIDENTIFIER OUTPUT) 
AS
BEGIN
	-- Check if requested number of IDs are avialable, Call maintenance proc if not.
	DECLARE @NumOfIDsAvl INT
	SELECT @NumOfIDsAvl= COUNT(*) FROM [Config].[StationID_Bank] WHERE AllocationDate IS NULL 
	IF (@NumOfIDsAvl <= @NoOfIDsRequested) 
	BEGIN
		EXEC [Config].[spMaintainStationIDBank] @NoOfIDsRequested
	END
	-- Get specified number of Station IDs and update the Allocation Date.
	SET @RequestID = newid()
	BEGIN TRY
		BEGIN TRAN
			SELECT TOP (@NoOfIDsRequested) StationID INTO #ReqStnIDs FROM [Config].[StationID_Bank] WHERE AllocationDate IS NULL;
			UPDATE [Config].[StationID_Bank] 
			SET 
				AllocationDate = GETDATE()
				, RequestorID= @RequestorID 
				, RequestID= @RequestID
			FROM
				[Config].[StationID_Bank] s 
				INNER JOIN  #ReqStnIDs r on s.StationID = r.StationID
		COMMIT TRAN
		-- Call maintenance proc again so that minimum number of unallocated IDs are available.
		EXEC [Config].[spMaintainStationIDBank]
	END TRY
	BEGIN CATCH
		ROLLBACK TRAN
		SELECT  
			ERROR_NUMBER() AS ErrorNumber   
			,ERROR_PROCEDURE() AS ErrorProcedure  
			,ERROR_MESSAGE() AS ErrorMessage;
	END CATCH
END