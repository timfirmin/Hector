-- =============================================
-- Author:		Adatis
-- Create date: 24/04/2014
-- Description:	Upon completion of a load this logs the time that the next load should start from.
-- =============================================
CREATE PROCEDURE [Control].[CompleteIncrementalLoad]
	@PackageName varchar(100), 
	@LoadStartDate Datetime,
	@LoadId int = -1

AS
BEGIN
	SET NOCOUNT ON;

UPDATE Control.IncrementalLoad
SET 
	 PreviousLoadDate = LoadDate
	,LoadDate = @LoadStartDate
WHERE PackageName = @PackageName

END
