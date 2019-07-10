CREATE PROCEDURE [DataQuality].[ObtainStandardiseRules]
	@EntityType aS VARCHAR(50) = NULL
AS
BEGIN
	SET NOCOUNT ON;




	IF (@EntityType IS NOT NULL)
	BEGIN
		SELECT
			StandardiseRuleId
			,DataQualityRuleId
			,SR.ColumnName
			,SR.PatternMatchType
			,SR.Criteria 
			,SR.StandardiseType
			,SR.StandardiseTypeValue
		FROM DataQuality.StandardiseRule SR 
		INNER JOIN Control.EntityType ET 
			ON SR.EntityTypeID = ET.EntityTypeId
		WHERE ET.Name = @EntityType 
	END
	ELSE 
	BEGIN 
		SELECT
			StandardiseRuleId
			,DataQualityRuleId
			,SR.ColumnName
			,SR.PatternMatchType
			,SR.Criteria 
			,SR.StandardiseType
			,SR.StandardiseTypeValue
		FROM DataQuality.StandardiseRule SR
	END
END