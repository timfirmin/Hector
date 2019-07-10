-- =============================================
-- Author: Adatis Consulting - PS
-- Create date: 2016-11-03
-- Description:	Updates Parameter that holds current state of ETL process
-- =============================================

CREATE PROCEDURE Azure.UpdateETLProcessState
	@ProcessState VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON;
	UPDATE [Config].[Parameter]
	   SET [ParameterValue] = @ProcessState    
	 WHERE [ParamaterCode] = 'ETLState'
END
