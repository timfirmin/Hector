CREATE PROCEDURE [DataQuality].[ObtainHarmoniseRules]
	@EntityType aS VARCHAR(50)
AS
BEGIN

SET NOCOUNT ON;

	DECLARE @EntityTypeID INT

	SELECT TOP 1 @EntityTypeID = EntityTypeID 
	FROM Control.EntityType 
	WHERE Name = @EntityType

	SELECT  HarmoniseRuleId CleanseRuleId,
			ColumnName ,
			CleanseType 
	FROM DataQuality.HarmoniseRule
	WHERE EntityTypeID = @EntityTypeID
			
END