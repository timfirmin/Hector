CREATE PROCEDURE [Test].[ObtainValidationTests]

@PackageName VARCHAR(200)

AS

-- ==========================================================================================
-- Author:		Adatis
-- Create date: 03/07/2014
-- Description:	Returns all the validation tests that must be run for a given package
-- ==========================================================================================

SELECT			ValidationTestId,
				--Casting these as SSIS is fussy with tiny ints
				CAST(ValidationTypeId AS SMALLINT) AS ValidationTypeId,
				CAST(ValidationSourceId AS SMALLINT) AS ValidationSourceId,
				SourceObject,
				TargetObject,
				WarningPercent,
				EnableWarning,
				HaltPercent,
				EnableHalt
FROM			Test.ValidationTest V
WHERE			LOWER(PackageName) = LOWER(@PackageName)
