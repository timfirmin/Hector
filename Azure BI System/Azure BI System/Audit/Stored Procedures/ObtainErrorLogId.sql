
-- =============================================
-- Author:		Adatis
-- Create date: 18/03/2013
-- Description:	Gets the next Avaialble Sequence for the Error Log Id
-- Required By Aptitude Bulk logging
-- =============================================
CREATE PROCEDURE Audit.ObtainErrorLogId
	@NextErrorLogId		BIGINT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

    SELECT @NextErrorLogId = NEXT VALUE FOR [Audit].[seqErrorLogId];
END
