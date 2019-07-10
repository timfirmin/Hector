-- =============================================
-- Author:		Adatis
-- Create date: 24/04/2014
-- Description:	Returns the start time for an incremental load. If the load has not been run before and no date is passed it will return
--				all records from the table.
-- =============================================
CREATE PROCEDURE [Control].[StartIncrementalLoad]
	@PackageName varchar(100), 
	@LoadStartDate Datetime = null,
	@LoadId int = -1

AS
BEGIN
	SET NOCOUNT ON;

--If no date has been passed then default to 1900-01-01.
IF @LoadStartDate IS NULL
	SET @LoadStartDate = '1900-01-01'

IF (SELECT COUNT(*) FROM Control.IncrementalLoad WHERE PackageName = @PackageName) = 0
	INSERT INTO Control.IncrementalLoad(PackageName, LoadDate, PreviousLoadDate, LoadStatus) VALUES(@PackageName, @LoadStartDate, @LoadStartDate, 1);

--If the Load Status flag has a value of 0 the data has not arrived in Clean_History. As such we want to set the LoadDate Value to PreviousLoadDate value and run again.
IF (SELECT COUNT(*) FROM Control.IncrementalLoad WHERE PackageName = @PackageName AND LoadStatus = 0) > 0
	UPDATE Control.IncrementalLoad SET LoadDate = PreviousLoadDate WHERE PackageName = @PackageName

--Set Load Status to 0 For the load
UPDATE Control.IncrementalLoad SET LoadStatus = 0 WHERE PackageName = @PackageName

--Return The Load Date for the current Load
SELECT LoadDate FROM Control.IncrementalLoad 
WHERE PackageName = @PackageName

END
