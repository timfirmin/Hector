
-- =============================================
-- Author: Adatis Consulting - ES
-- Create date: 2017-02-09
-- Description:	Updates the Azure.JobLog table to set Result= 2 when ETL has finished
-- 1=running, 2=successful pending shutdown  3= failed 4= Complete
-- =============================================

CREATE PROCEDURE [Azure].[UpdateJobSuccessLog] 
@JobId int,
@OperationId varchar(250)

AS
BEGIN
	SET NOCOUNT ON;


DECLARE @OperationGUID uniqueidentifier 
SET @OperationGUID = CONVERT(uniqueidentifier, @OperationId)


UPDATE L
SET L.[Result] = 2,
L.[OperationID]= @OperationGUID
FROM  [Azure].[JobLog] L
WHERE [JobId] = @JobId
				
	
END