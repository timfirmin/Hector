CREATE PROCEDURE [Control].[DeleteEntityProcessStream]
	@EntityId INT,			
	@ProcessStream VARCHAR(50),		
	@LoadProcess VARCHAR(50),		
	@LoadId INT,					
	@LoadStatusTypeId INT			
AS
BEGIN
	SET NOCOUNT ON;
	
	DELETE FROM Control.EntityProcessStream 
	WHERE EntityId = @EntityId 
	  AND ProcessStream = @ProcessStream 
	  AND LoadProcess = @LoadProcess
	  AND LoadId = @LoadId
	  AND LoadStatusTypeId = @LoadStatusTypeId

END

