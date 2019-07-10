-- =============================================
-- Author: Adatis Consulting - PS
-- Create date: 2016-11-03
-- Description:	Gets current state of ETL process
-- =============================================

CREATE PROCEDURE Azure.GetETLProcessState
	@ProcessState VARCHAR(50) OUT
AS
BEGIN
	SET NOCOUNT ON;
	SET @ProcessState = (SELECT TOP 1 [ParameterValue] 
						 FROM [Config].[Parameter]
						 WHERE [ParamaterCode] = 'ETLState')
	
END
