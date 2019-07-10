CREATE VIEW Transform.v_RightType
AS

SELECT distinct [RightTypeCode],
        [RightTypeName]  
 FROM [Transform].[RightType]