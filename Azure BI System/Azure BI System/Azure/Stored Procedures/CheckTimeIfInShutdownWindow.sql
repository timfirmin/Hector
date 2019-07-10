CREATE PROCEDURE [Azure].[CheckTimeIfInShutdownWindow]
	@AssertedTime Time,
	@InShutdownWindow bit OUT
/*
 * Checks if current time is between shutdown window - this logic can be extended here
 */
AS
BEGIN
	SET @InShutdownWindow = 0;

	IF EXISTS (
		SELECT * 
		FROM [Azure].[ShutdownConfiguration]
		WHERE [From] < [To] AND @AssertedTime BETWEEN [From] AND [To]
	) SET @InShutdownWindow = 1;

	IF EXISTS (
		SELECT * 
		FROM [Azure].[ShutdownConfiguration]
		WHERE [From] > [To]
	) THROW 51000, 'Not implemented exception-End date smaller than from date ', 1;
END
