 
CREATE FUNCTION [FPV].[udfRemoveStringCharacters] 
(
	-- Add the parameters for the function here
	@string nvarchar(max) 
	 
)
RETURNS nvarchar(max)
AS
BEGIN
	-- loop untill all characters are replaced
	WHILE PATINDEX('%[^a-zA-Z 0-9]%',@string) <> 0
	BEGIN
    -- remove characters with empty space
    SET @string = STUFF(@string,PATINDEX('%[^a-zA-Z 0-9]%',@string),1,'')
	END
	
	RETURN @string
END