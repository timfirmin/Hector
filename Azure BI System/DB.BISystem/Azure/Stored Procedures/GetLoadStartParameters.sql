-- =============================================
-- Author: Adatis Consulting - PS
-- Create date: 2016-11-02
-- Description:	Checks the source file control table and determines whether load is required
-- PS: Output object is a JSON object that contains 2 flags if there is something to process or if there is somthing running
-- =============================================

CREATE PROCEDURE Azure.GetLoadStartParameters 
	@ApplicationId smallint,
	@Output VARCHAR(500) OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @IsETLReady BIT = 0;
	DECLARE @IsAnythingToProcess BIT = 0;

	DECLARE @ETLProgressState VARCHAR(50) = 'NotSpecified'

	EXEC Azure.GetETLProcessState 
		@ProcessState = @ETLProgressState OUT;
	
	/* Checks if there is anything to process */
	IF EXISTS (SELECT *
				 FROM [Control].[SourceFile] As A
				WHERE [ApplicationId] = 1
			      AND StageParentLoadId IS NULL
				  AND FileExtractedDate IS NOT NULL
				  AND [BlobUploadDate]  IS NOT NULL
				  AND [StageDate]	    IS NULL
				  AND [CleanDate]		IS NULL
				  AND [WarehouseDate]	IS NULL
				)
    SET @IsAnythingToProcess = 1

	/* Checks if there is anything running */
	IF @ETLProgressState NOT IN ('InProgress','Error')
		    SET @IsETLReady = 1


	/* Return JSON result to output variable that will be consumed by ETL-ProcessStart, ETL-ProcessEnd Runbook*/
	SET @Output=(SELECT 
				 	@IsAnythingToProcess AS [IsAnythingToProcess],
					@IsETLReady AS [IsETLReady]
				 FOR JSON PATH);
END
