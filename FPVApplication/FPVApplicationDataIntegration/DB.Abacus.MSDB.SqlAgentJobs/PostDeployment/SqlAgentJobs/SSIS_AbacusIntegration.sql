﻿/* Audience Mart BARB Import - SQL Server Agent Job Deployment */
:setvar JobName "SSIS_AbacusIntegration"

PRINT 'SSIS_AbacusIntegration  SQL Server Agent Job Deployment';

PRINT 'Redploy SQL Agent Job = $(ReDeployJob_SSIS_AbacusIntegration)'
IF '$(ReDeployJob_SSIS_AbacusIntegration)' != 'YES'
	BEGIN;		
		RETURN;
	END;

/*Global Variable Setting*/
PRINT 'Job Owner = $(JobOwner)';
PRINT 'Job Step Runner = $(JobStepRunner)'
PRINT 'SSIS Server = $(SSIS_Server)'


PRINT 'Deploying job: $(JobName)';
DECLARE @SqlAgentJobId  UNIQUEIDENTIFIER;

SELECT  @SqlAgentJobId = job_id
FROM    msdb.dbo.sysjobs
WHERE   name = '$(JobName)';

IF @SqlAgentJobId IS NOT NULL
    BEGIN;
        PRINT ' Deleting existing job';
        EXEC msdb.dbo.sp_delete_job @Job_id = @SqlAgentJobId;

        /*
         * Set the @JobId variable to NULL for the sp_add_job command later on.  If it is not null the
         * server things the job is from a MSX server
         */
        SET @SqlAgentJobId = NULL;
    END;

BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 21/01/2019 15:02:30 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'$(JobName)', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'$(JobOwner)', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [001 Process DDI]    Script Date: 21/01/2019 15:02:31 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'001 Process AbacusIntegration', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'SSIS', 
		@command=N'/ISSERVER "\"\SSISDB\FPVApplication\FPVDataIntegration\DataIntegration.LoadControl.dtsx\"" /SERVER "\"$(SSIS_Server)\"" /Par "\"$ServerOption::LOGGING_LEVEL(Int16)\"";1 /Par "\"$ServerOption::SYNCHRONIZED(Boolean)\"";True /CALLERINFO SQLAGENT /REPORTING E', 
		@database_name=N'master', 
		@flags=0, 
		@proxy_name=N'$(JobStepRunner)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO


