CREATE FUNCTION [Config].[ObtainVariable]
( 
 -- Add the parameters for the function here
 @VariableName Varchar(50)
)
RETURNS TABLE 
AS
RETURN 
(
 -- Add the SELECT statement with parameter references here
 SELECT [VariableId], 
    [Name], 
    [Value],
    [Type] 
FROM [Config].[Variable] 
WHERE [Name] = @VariableName
)
