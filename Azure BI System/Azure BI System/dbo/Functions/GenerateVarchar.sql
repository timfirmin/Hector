
-- =============================================
-- Author:		Adatis - Simon Whiteley
-- Create date: 2014-03-14
-- Description:	Function to generate a varchar of a random length using dummy characters
-- =============================================
CREATE FUNCTION [dbo].[GenerateVarchar]
(
	@Length INT, @Rand1 decimal(10,8)
)
RETURNS Varchar(MAX)
AS
BEGIN
	-- get a random varchar ascii char 32 to 128
	DECLARE @TextValue VARCHAR(MAX),
			@DesiredLength int = @Length,
			@RandomLength INT,
			@CurrentLength INT,
			@Char int = 1
	SELECT @TextValue = ''
	SET @RandomLength = CAST(@Rand1 * @DesiredLength as INT)
	SET	@CurrentLength = @RandomLength
	WHILE @CurrentLength <> 0
		BEGIN
			SELECT @TextValue = @TextValue + CHAR(@Char+64)
			SET @CurrentLength = @CurrentLength - 1
			SET @Char = case when @Char > 25 then 1 else @Char + 1 end
		END

	RETURN @TextValue
END

