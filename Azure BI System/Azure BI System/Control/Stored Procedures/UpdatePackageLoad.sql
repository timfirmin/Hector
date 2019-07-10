-- =============================================
-- Author:		Adatis Consulting
-- Create date:		Unknown
-- Description:		Used in conjunction with the SISS End Load Task 
-- ==========================================================================================
CREATE PROCEDURE [Control].[UpdatePackageLoad]
	@LoadId int, @LoadStatusShortName varchar(10), @EndTime datetime, @TotalRows int = 0, @BadRows int = 0
AS

DECLARE @LoadStatusId int
SELECT @LoadStatusId = LoadStatusTypeId FROM Control.LoadStatusType WHERE ShortName = @LoadStatusShortName

--catch bad @LoadStatusShortName values
IF @LoadStatusID IS NULL 
	Begin
		RaisError ('Invalid @LoadStatusShortName value in call to Update Package Load', 16, 1) WITH SETERROR
		Return;
	End
ELSE
	UPDATE Audit.PackageLoad 
		SET LoadStatusId = @LoadStatusId,
		EndTime = @EndTime,
		Duration = DateDiff(Second, StartTime, @EndTime)
	WHERE LoadId = @LoadId

Return;
