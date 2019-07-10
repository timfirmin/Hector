-- =============================================
-- Author:		Adatis Consulting - SAW
-- Create date: 2016-05-03
-- Description:	Checks the source file control table and determines whether load is required
-- =============================================
CREATE PROCEDURE Azure.GetLoadStartFlag (@Trigger bit OUTPUT)
AS
BEGIN
	SET NOCOUNT ON;

    SET @Trigger = 1

	RETURN;
END
