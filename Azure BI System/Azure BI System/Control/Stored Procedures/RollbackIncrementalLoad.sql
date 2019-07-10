-- =============================================
-- Author:		Adatis
-- Create date: 09/06/2014
-- Description:	Sets the package load date for an incremental Load to the previous sucessfull run date in the event of a failiure.
-- =============================================
CREATE PROCEDURE [Control].[RollbackIncrementalLoad]
	@PackageName varchar(100)

AS
BEGIN
	SET NOCOUNT ON;

SET @PackageName = REPLACE(REPLACE(@PackageName, 'Clean ', ''), 'Stage ', '')

UPDATE Control.IncrementalLoad 
SET LoadDate = PreviousLoadDate
WHERE PackageName like '%' + @PackageName

END
