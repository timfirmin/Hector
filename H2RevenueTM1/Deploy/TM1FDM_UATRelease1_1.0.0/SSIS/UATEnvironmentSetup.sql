USE [SSISDB]
GO

/****** Adds reference of Environment Variable to projects ******/
IF(OBJECT_ID('ReferenceEnvironmentVariableToProject') IS NOT NULL)
	DROP PROCEDURE ReferenceEnvironmentVariableToProject
GO
CREATE PROCEDURE ReferenceEnvironmentVariableToProject
	@pProjectName NVARCHAR(255),
	@pEnvironmentName NVARCHAR(255),
	@pFolderName NVARCHAR(255)
AS 
BEGIN
    DECLARE @GP_ProjectName  NVARCHAR(255) = N'H2PlanningTM1';

	-- common to all projects
        PRINT 'Setting Parameter strApplicationCode'; --01
	EXEC [SSISDB].[catalog].[set_object_parameter_value] 
		@object_type=20, 
		@parameter_name=N'strApplicationCode', 
		@object_name=@pEnvironmentName, 
		@folder_name=@pFolderName, 
		@project_name=@pProjectName,
		@value_type=R, 
		@parameter_value=N'strApplicationCode';
	
        PRINT 'Setting Parameter strBISystemADOConnectionString'; --02
	EXEC [SSISDB].[catalog].[set_object_parameter_value] 
		@object_type=20, 
		@parameter_name=N'strBISystemADOConnectionString', 
		@object_name=@pEnvironmentName, 
		@folder_name=@pFolderName, 
		@project_name=@pProjectName,
		@value_type=R, 
		@parameter_value=N'strBISystemADOConnectionString';


		PRINT 'Setting Parameter strBITDataMartDBName'; --03
	EXEC [SSISDB].[catalog].[set_object_parameter_value] 
		@object_type=20, 
		@parameter_name=N'strBITDataMartDBName', 
		@object_name=@pEnvironmentName, 
		@folder_name=@pFolderName, 
		@project_name=@pProjectName,
		@value_type=R, 
		@parameter_value=N'strBITDataMartDBName';

		PRINT 'Setting Parameter strBITStageDBName'; --04
	EXEC [SSISDB].[catalog].[set_object_parameter_value] 
		@object_type=20, 
		@parameter_name=N'strBITStageDBName', 
		@object_name=@pEnvironmentName, 
		@folder_name=@pFolderName, 
		@project_name=@pProjectName,
		@value_type=R, 
		@parameter_value=N'strBITStageDBName';

		PRINT 'Setting Parameter strHectorADONETConnectionString'; --05
	EXEC [SSISDB].[catalog].[set_object_parameter_value] 
		@object_type=20, 
		@parameter_name=N'strHectorADONETConnectionString', 
		@object_name=@pEnvironmentName, 
		@folder_name=@pFolderName, 
		@project_name=@pProjectName,
		@value_type=R, 
		@parameter_value=N'strHectorADONETConnectionString';


		PRINT 'Setting Parameter strFinanceDataMartADONETConnectionString'; --06
	EXEC [SSISDB].[catalog].[set_object_parameter_value] 
		@object_type=20, 
		@parameter_name=N'strFinanceDataMartADONETConnectionString', 
		@object_name=@pEnvironmentName, 
		@folder_name=@pFolderName, 
		@project_name=@pProjectName,
		@value_type=R, 
		@parameter_value=N'strFinanceDataMartADONETConnectionString';

		PRINT 'Setting Parameter strFinanceStageADONETConnectionString'; --07
	EXEC [SSISDB].[catalog].[set_object_parameter_value] 
		@object_type=20, 
		@parameter_name=N'strFinanceStageADONETConnectionString', 
		@object_name=@pEnvironmentName, 
		@folder_name=@pFolderName, 
		@project_name=@pProjectName,
		@value_type=R, 
		@parameter_value=N'strFinanceStageADONETConnectionString';

	PRINT 'Setting Parameter strMailProfileName'; --08
	EXEC [SSISDB].[catalog].[set_object_parameter_value] 
		@object_type=20, 
		@parameter_name=N'strMailProfileName', 
		@object_name=@pEnvironmentName, 
		@folder_name=@pFolderName, 
		@project_name=@pProjectName,
		@value_type=R, 
		@parameter_value=N'strMailProfileName';

	PRINT 'Setting Parameter strSISDatabaseMail'; --09
	EXEC [SSISDB].[catalog].[set_object_parameter_value] 
		@object_type=20, 
		@parameter_name=N'strSISDatabaseMail', 
		@object_name=@pEnvironmentName, 
		@folder_name=@pFolderName, 
		@project_name=@pProjectName,
		@value_type=R, 
		@parameter_value=N'strSISDatabaseMail';

	PRINT 'Setting Parameter strMailRecipientList'; --10
	EXEC [SSISDB].[catalog].[set_object_parameter_value] 
		@object_type=20, 
		@parameter_name=N'strMailRecipientList', 
		@object_name=@pEnvironmentName, 
		@folder_name=@pFolderName, 
		@project_name=@pProjectName,
		@value_type=R, 
		@parameter_value=N'strMailRecipientList';

	PRINT 'Setting Parameter strMailRecipientListSupport'; --11
	EXEC [SSISDB].[catalog].[set_object_parameter_value] 
		@object_type=20, 
		@parameter_name=N'strMailRecipientListSupport', 
		@object_name=@pEnvironmentName, 
		@folder_name=@pFolderName, 
		@project_name=@pProjectName,
		@value_type=R, 
		@parameter_value=N'strMailRecipientListSupport';

	PRINT 'Setting Parameter strMDSADOConnectionString'; --12
	EXEC [SSISDB].[catalog].[set_object_parameter_value] 
		@object_type=20, 
		@parameter_name=N'strMDSADOConnectionString', 
		@object_name=@pEnvironmentName, 
		@folder_name=@pFolderName, 
		@project_name=@pProjectName,
		@value_type=R, 
		@parameter_value=N'strMDSADOConnectionString';

	PRINT 'Setting Parameter strMDSConnectionString'; --13
	EXEC [SSISDB].[catalog].[set_object_parameter_value] 
		@object_type=20, 
		@parameter_name=N'strMDSConnectionString', 
		@object_name=@pEnvironmentName, 
		@folder_name=@pFolderName, 
		@project_name=@pProjectName,
		@value_type=R, 
		@parameter_value=N'strMDSConnectionString';

	PRINT 'Setting Parameter strMDSUserName'; --14
	EXEC [SSISDB].[catalog].[set_object_parameter_value] 
		@object_type=20, 
		@parameter_name=N'strMDSUserName', 
		@object_name=@pEnvironmentName, 
		@folder_name=@pFolderName, 
		@project_name=@pProjectName,
		@value_type=R, 
		@parameter_value=N'strMDSUserName';

	PRINT 'Setting Parameter strSourceFileFolder'; --15
	EXEC [SSISDB].[catalog].[set_object_parameter_value] 
		@object_type=20, 
		@parameter_name=N'strSourceFileFolder', 
		@object_name=@pEnvironmentName, 
		@folder_name=@pFolderName, 
		@project_name=@pProjectName,
		@value_type=R, 
		@parameter_value=N'strSourceFileFolder';

	PRINT 'Setting Parameter strSSISConfigurationConnectionString'; --16
	EXEC [SSISDB].[catalog].[set_object_parameter_value] 
		@object_type=20, 
		@parameter_name=N'strSSISConfigurationConnectionString', 
		@object_name=@pEnvironmentName, 
		@folder_name=@pFolderName, 
		@project_name=@pProjectName,
		@value_type=R, 
		@parameter_value=N'strSSISConfigurationConnectionString';

	PRINT 'Setting Parameter strSSISDBConnectionString'; --17
	EXEC [SSISDB].[catalog].[set_object_parameter_value] 
		@object_type=20, 
		@parameter_name=N'strSSISDBConnectionString', 
		@object_name=@pEnvironmentName, 
		@folder_name=@pFolderName, 
		@project_name=@pProjectName,
		@value_type=R, 
		@parameter_value=N'strSSISDBConnectionString';

	PRINT 'Setting Parameter strSSISDBProjectFolder'; --18
	EXEC [SSISDB].[catalog].[set_object_parameter_value] 
		@object_type=20, 
		@parameter_name=N'strSSISDBProjectFolder', 
		@object_name=@pEnvironmentName, 
		@folder_name=@pFolderName, 
		@project_name=@pProjectName,
		@value_type=R, 
		@parameter_value=N'strSSISDBProjectFolder';

	PRINT 'Setting Parameter strSSISProjectEnvironment'; --19
	EXEC [SSISDB].[catalog].[set_object_parameter_value] 
		@object_type=20, 
		@parameter_name=N'strSSISProjectEnvironment', 
		@object_name=@pEnvironmentName, 
		@folder_name=@pFolderName, 
		@project_name=@pProjectName,
		@value_type=R, 
		@parameter_value=N'strSSISProjectEnvironment';



END;
GO


/****** Adds reference of Environment and Varaibles to projects ******/
IF(OBJECT_ID('ReferenceEnvironmentToProject') IS NOT NULL)
	DROP PROCEDURE ReferenceEnvironmentToProject
GO
CREATE PROCEDURE ReferenceEnvironmentToProject
	@pProjectName NVARCHAR(255),
	@pEnvironmentName NVARCHAR(255),
	@pFolderName NVARCHAR(255)
AS
BEGIN
	SET NOCOUNT OFF;
	DECLARE @reference_id BIGINT;
	SET @reference_id = ISNULL((SELECT TOP(1) [reference_id]
						FROM [SSISDB].[internal].[environment_references] AS er
						LEFT JOIN [SSISDB].[internal].[projects] AS p
							ON p.[project_id] = er.[project_id]
						LEFT JOIN [SSISDB].[internal].[folders] AS f
							ON  p.[folder_id] = f.[folder_id]
						WHERE p.[name]				= @pProjectName
						  AND f.[name]				= @pFolderName
						  AND er.[environment_name]	= @pEnvironmentName),-1);

	IF @reference_id = -1
		BEGIN
			PRINT CONCAT('Adding ',@pEnvironmentName,' Environment Reference To ',@pFolderName,'.',@pProjectName,' Project.');
			/*** reference Environment to a project ***/
			EXEC [SSISDB].[catalog].[create_environment_reference] 
				@environment_name=@pEnvironmentName, 
				@reference_id=@reference_id OUTPUT, 
				@project_name=@pProjectName, 
				@folder_name=@pFolderName, 
				@reference_type=R;
		END
	ELSE
		BEGIN
			PRINT 'Reference already exists - Deleting';
			EXEC [SSISDB].[catalog].[delete_environment_reference] 
			    @reference_id=@reference_id;
			PRINT CONCAT('Adding ',@pEnvironmentName,' Environment Reference To ',@pFolderName,'.',@pProjectName,' Project.');
			/*** reference Environment to a project ***/
			EXEC [SSISDB].[catalog].[create_environment_reference] 
				@environment_name=@pEnvironmentName, 
				@reference_id=@reference_id OUTPUT, 
				@project_name=@pProjectName, 
				@folder_name=@pFolderName, 
				@reference_type=R;
		END
	PRINT 'EnvironmentReferenceId: ' + CONVERT(varchar(20),ISNULL(@reference_id,-1));
	/*** reference Environment Variables to a project ***/
	EXEC ReferenceEnvironmentVariableToProject	
		@pProjectName		= @pProjectName,
		@pEnvironmentName	= @pEnvironmentName,
		@pFolderName		= @pFolderName;
	SET NOCOUNT ON;
END;
GO
----------------------------------------------------------------------------------------------

/* SETUP */
-- variables

DECLARE @strApplicationCode SQL_VARIANT = N'TM1FDM'
DECLARE @strBISystemADOConnectionString SQL_VARIANT = N'Data Source=AZP-MS-SQL-T001.database.windows.net;Initial Catalog=BISystemUAT;Connect Timeout=60;ConnectRetryCount=3;ConnectRetryInterval=20;Authentication="Active Directory Integrated"';
DECLARE @strBITDataMartDBName SQL_VARIANT = N'FinanceDataMart'
DECLARE @strBITStageDBName SQL_VARIANT = N'FinanceStage'
DECLARE @strFinanceDataMartADONETConnectionString SQL_VARIANT =  N'Data Source=AZI-MS-SQL-U001,50501;Initial Catalog=FinanceDataMart;Integrated Security=True;'
DECLARE @strFinanceStageADONETConnectionString SQL_VARIANT = N'Data Source=AZI-MS-SQL-U001,50501;Initial Catalog=FinanceStage;Integrated Security=True;'
DECLARE @strHectorADONETConnectionString SQL_VARIANT = N'Data Source=AZI-MS-SQL-U001,50501;Initial Catalog=Hector2;Integrated Security=True;'
DECLARE @strMailProfileName SQL_VARIANT = N'AZI-MS-SQL-U001 SQL Database Mail'
DECLARE @strSISDatabaseMail SQL_VARIANT = N'AZI-MS-SIS-U001 SQL Database Mail'
DECLARE @strMailRecipientList SQL_VARIANT = N'tim.firmin@prsformusic.com; support-bi-apps@prsformusic.com'
DECLARE @strMailRecipientListSupport SQL_VARIANT = N'tim.firmin@prsformusic.com; support-bi-apps@prsformusic.com'
DECLARE @strMDSADOConnectionString SQL_VARIANT = N'Data Source=AZI-MS-SQL-U001,50501;Initial Catalog=MDS;Integrated Security=True;'
DECLARE @strMDSConnectionString SQL_VARIANT = N'Data Source=AZI-MS-SQL-U001,50501;Initial Catalog=mds;Provider=SQLOLEDB;Integrated Security=SSPI;Auto Translate=false;'
DECLARE @strMDSUserName SQL_VARIANT = N'PRS\ServiceDevSQLU001MDS'
DECLARE @strSourceFileFolder SQL_VARIANT = N'\\ONP-MS-FSS-DV01\Data\Proj\Hector2\UAT\'
DECLARE @strSSISConfigurationConnectionString SQL_VARIANT = N'Data Source=AZI-MS-SIS-U001,50501;Initial Catalog=SSISConfiguration;Integrated Security=True;'
DECLARE @strSSISDBConnectionString SQL_VARIANT = N'Data Source=AZI-MS-SIS-U001,50501;Initial Catalog=SSISDB;Integrated Security=True;'
DECLARE @strSSISDBProjectFolder SQL_VARIANT = N'TM1FDM'
DECLARE @strSSISProjectEnvironment SQL_VARIANT = N'UAT'

-- environment
DECLARE @environmentName NVARCHAR(255) = N'UAT';

-- projects
DECLARE @folderName NVARCHAR(255) = N'TM1FDM';
DECLARE @GP_ProjectName  NVARCHAR(255) = N'H2PlanningTM1';


-- delete environment (if exists)
DECLARE @EnvId BIGINT;
	SET @EnvId = ISNULL((SELECT environment_id FROM [SSISDB].[internal].[environments] en
                          INNER JOIN [SSISDB].[internal].[folders] fl ON en.folder_id = fl.folder_id
                         where environment_name = @environmentName
								and fl.[name]=@folderName),-1);
	IF @EnvId != -1
      BEGIN
		  /* Delete existing environement */
		  EXEC [SSISDB].[catalog].[delete_environment]
      		@folder_name=@folderName,
			@environment_name=@environmentName;
      END

/* Creates new environment */
EXEC [SSISDB].[catalog].[create_environment] 
	@environment_name=@environmentName, 
	@environment_description=N'', 
	@folder_name=@folderName;

/* Creates new strApplicationCode environment variable */ --01
EXEC [SSISDB].[catalog].[create_environment_variable] 
	@variable_name=N'strApplicationCode', 
	@sensitive=False, 
	@description=N'', 
	@environment_name=@environmentName, 
	@folder_name=@folderName, 
	@value=@strApplicationCode,
	@data_type=N'String';


/* Creates new strBISystemADOConnectionString environment variable */ --02
EXEC [SSISDB].[catalog].[create_environment_variable] 
	@variable_name=N'strBISystemADOConnectionString', 
	@sensitive=False, 
	@description=N'', 
	@environment_name=@environmentName, 
	@folder_name=@folderName, 
	@value=@strBISystemADOConnectionString, 
	@data_type=N'String';

/* Creates new strBITDataMartDBName environment variable */ --03
EXEC [SSISDB].[catalog].[create_environment_variable] 
	@variable_name=N'strBITDataMartDBName', 
	@sensitive=False, 
	@description=N'', 
	@environment_name=@environmentName, 
	@folder_name=@folderName, 
	@value=@strBITDataMartDBName, 
	@data_type=N'String';

/* Creates new strBITStageDBName environment variable */ --04
EXEC [SSISDB].[catalog].[create_environment_variable] 
	@variable_name=N'strBITStageDBName', 
	@sensitive=False, 
	@description=N'', 
	@environment_name=@environmentName, 
	@folder_name=@folderName, 
	@value=@strBITStageDBName, 
	@data_type=N'String';

/* Creates new strHectorADONETConnectionString environment variable */ --05
EXEC [SSISDB].[catalog].[create_environment_variable] 
	@variable_name=N'strCodaDestinationADONETConnectionString', 
	@sensitive=False, 
	@description=N'', 
	@environment_name=@environmentName, 
	@folder_name=@folderName, 
	@value=@strHectorADONETConnectionString, 
	@data_type=N'String';

/* Creates new strFinanceDataMartADONETConnectionString environment variable */ --06
EXEC [SSISDB].[catalog].[create_environment_variable] 
	@variable_name=N'strFinanceDataMartADONETConnectionString', 
	@sensitive=False, 
	@description=N'', 
	@environment_name=@environmentName, 
	@folder_name=@folderName, 
	@value=@strFinanceDataMartADONETConnectionString, 
	@data_type=N'String';

/* Creates new strFinanceStageADONETConnectionString environment variable */ --07
EXEC [SSISDB].[catalog].[create_environment_variable] 
	@variable_name=N'strFinanceStageADONETConnectionString', 
	@sensitive=False, 
	@description=N'', 
	@environment_name=@environmentName, 
	@folder_name=@folderName, 
	@value=@strFinanceStageADONETConnectionString, 
	@data_type=N'String';

/* Creates new strMailProfileName environment variable */ --08
EXEC [SSISDB].[catalog].[create_environment_variable] 
	@variable_name=N'strMailProfileName', 
	@sensitive=False, 
	@description=N'', 
	@environment_name=@environmentName, 
	@folder_name=@folderName, 
	@value=@strMailProfileName, 
	@data_type=N'String';

/* Creates new strSISDatabaseMail environment variable */ --09
EXEC [SSISDB].[catalog].[create_environment_variable] 
	@variable_name=N'strSISDatabaseMail', 
	@sensitive=False, 
	@description=N'', 
	@environment_name=@environmentName, 
	@folder_name=@folderName, 
	@value=@strSISDatabaseMail, 
	@data_type=N'String';

/* Creates new strMailRecipientList environment variable */ --10
EXEC [SSISDB].[catalog].[create_environment_variable] 
	@variable_name=N'strMailRecipientList', 
	@sensitive=False, 
	@description=N'', 
	@environment_name=@environmentName, 
	@folder_name=@folderName, 
	@value=@strMailRecipientList, 
	@data_type=N'String';

/* Creates new strMailRecipientListSupport environment variable */ --11
EXEC [SSISDB].[catalog].[create_environment_variable] 
	@variable_name=N'strMailRecipientListSupport', 
	@sensitive=False, 
	@description=N'', 
	@environment_name=@environmentName, 
	@folder_name=@folderName, 
	@value=@strMailRecipientListSupport, 
	@data_type=N'String';

/* Creates new strMDSADOConnectionString environment variable */ --12
EXEC [SSISDB].[catalog].[create_environment_variable] 
	@variable_name=N'strMDSADOConnectionString', 
	@sensitive=False, 
	@description=N'', 
	@environment_name=@environmentName, 
	@folder_name=@folderName, 
	@value=@strMDSADOConnectionString, 
	@data_type=N'String';

/* Creates new strMDSConnectionString environment variable */ --13
EXEC [SSISDB].[catalog].[create_environment_variable] 
	@variable_name=N'strMDSConnectionString', 
	@sensitive=False, 
	@description=N'', 
	@environment_name=@environmentName, 
	@folder_name=@folderName, 
	@value=@strMDSConnectionString, 
	@data_type=N'String';

/* Creates new strMDSUserName environment variable */ --14
EXEC [SSISDB].[catalog].[create_environment_variable] 
	@variable_name=N'strMDSUserName', 
	@sensitive=False, 
	@description=N'', 
	@environment_name=@environmentName, 
	@folder_name=@folderName, 
	@value=@strMDSUserName, 
	@data_type=N'String';

/* Creates new strSourceFileFolder environment variable */ --15
EXEC [SSISDB].[catalog].[create_environment_variable] 
	@variable_name=N'strSourceFileFolder', 
	@sensitive=False, 
	@description=N'', 
	@environment_name=@environmentName, 
	@folder_name=@folderName, 
	@value=@strSourceFileFolder, 
	@data_type=N'String';

/* Creates new strSSISConfigurationConnectionString environment variable */ --16
EXEC [SSISDB].[catalog].[create_environment_variable] 
	@variable_name=N'strSSISConfigurationConnectionString', 
	@sensitive=False, 
	@description=N'', 
	@environment_name=@environmentName, 
	@folder_name=@folderName, 
	@value=@strSSISConfigurationConnectionString, 
	@data_type=N'String';

/* Creates new strSSISConfigurationDBString environment variable */ --17
EXEC [SSISDB].[catalog].[create_environment_variable] 
	@variable_name=N'strSSISDBConnectionString', 
	@sensitive=False, 
	@description=N'', 
	@environment_name=@environmentName, 
	@folder_name=@folderName, 
	@value=@strSSISDBConnectionString, 
	@data_type=N'String';

/* Creates new strSSISDBProjectFolder environment variable */ --18
EXEC [SSISDB].[catalog].[create_environment_variable] 
	@variable_name=N'strSSISDBProjectFolder', 
	@sensitive=False, 
	@description=N'', 
	@environment_name=@environmentName, 
	@folder_name=@folderName, 
	@value=@strSSISDBProjectFolder, 
	@data_type=N'String';

/* Creates new strSSISProjectEnvironment environment variable */ --19
EXEC [SSISDB].[catalog].[create_environment_variable] 
	@variable_name=N'strSSISProjectEnvironment', 
	@sensitive=False, 
	@description=N'', 
	@environment_name=@environmentName, 
	@folder_name=@folderName, 
	@value=@strSSISProjectEnvironment, 
	@data_type=N'String';


/******* H2PlanningTM1 *******/
PRINT '******* H2PlanningTM1 *******';
EXEC ReferenceEnvironmentToProject
	@pProjectName		= @GP_ProjectName,
	@pEnvironmentName	= @environmentName,
	@pFolderName		= @folderName;

