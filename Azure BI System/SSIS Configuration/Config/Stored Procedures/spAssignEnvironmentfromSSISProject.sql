
/*
exec [Config].[spAssignEnvironmentfromSSISPackage] 'MDSStationIntegration','DEvX','MDS_StationIntegration_SourceToStage'
*/

CREATE PROCEDURE [Config].[spAssignEnvironmentfromSSISProject]
          @folder sysname
        , @env sysname
		, @ProjectName sysname
AS
        SET NOCOUNT ON;

        DECLARE @project_id int,
                @reference_location char(1),
                @folder_description nvarchar(1024),
                @sql varchar(max) = '',
                @name sysname,
                @cr char(1) = char(10),
                @tab char(4) = SPACE(4),
                @ver nvarchar(128) = CAST(serverproperty('ProductVersion') AS nvarchar);

        SET @ver = CAST(SUBSTRING(@ver, 1, CHARINDEX('.', @ver) - 1) as int);       
        IF (@ver < 11)
        BEGIN
                RAISERROR ('This procedure is not supported on versions prior SQL 2012', 16, 1) WITH NOWAIT;
                RETURN 1;
        END;
        IF NOT EXISTS(SELECT TOP 1 1 FROM sys.databases WHERE name = 'SSISDB')
        BEGIN
                RAISERROR('The SSISDB database does not exist on this server', 16, 1) WITH NOWAIT;
                RETURN 1;
        END;


		/****************************** Fill temp Table ***/
		  select distinct parameter_name as name,	
		                 data_type as base_data_type, 
						 design_default_value as value,
						 sensitive,
						 parameter_name as description,
						 data_type   as Type
			INTO #env_varbase
			From  SSISDB.catalog.object_parameters par
			Where Project_Id in (Select project_id from SSISDB.[catalog].[projects] p INNER JOIN
														SSISDB.[catalog].[folders] F on p.folder_id =F.folder_id
								  Where f.name =  @folder ) 
			and object_type =20
			and parameter_name  NOT LIKE 'CM.%'
			and object_Name = @ProjectName

        SET @sql = 'DECLARE @ReturnCode INT=0, @folder_id bigint' + @cr + @cr;       
        SET @sql += 'DECLARE @folder sysname = ''' + @folder + ''' /* this is the name of the new folder you want to assign */'  + @cr;
        SET @sql += @tab + ', @env sysname = ''' + @env + ''' /* this is the name of the new environment you want to assign */'  + @cr ;
		SET @sql += @tab + ', @ProjectName sysname = ''' + @ProjectName + ''' /* this is the name of the Project you want to assign */';
       
        PRINT @sql;

        SET @sql  = @tab + '/******************************************************' + @cr;
        SET @sql += @tab + @tab + 'Variable Assigment Scripts                      ' + @cr;
        SET @sql += @tab + '******************************************************/' ;     
        PRINT @sql;

        /* Generate the variable creation */
        SELECT [cmd] = @tab + 'RAISERROR(''SEtting variable: ' + ev.name + ' ...'', 10, 1) WITH NOWAIT;' + @cr
                                        + @tab + 'EXEC @ReturnCode = [SSISDB].[catalog].[set_object_parameter_value] ' + @cr
                                        + @tab + @tab + '@object_type=20 ' + @cr
								 	    + @tab + @tab + ', @parameter_name=N''' + ev.name + '''' + @cr
                                        + @tab + @tab + ', @object_name=@env' + @cr
                                        + @tab + @tab + ', @folder_name=@folder' + @cr
										+ @tab + @tab + ', @project_name=@ProjectName ' + @cr
                                        + @tab + @tab + ', @value_Type= R' + @cr
                                        + @tab + @tab + ', @parameter_value =''' + ev.name + '''' + @cr
                                        + @tab + 'IF (@@ERROR <> 0 OR @ReturnCode <> 0) Print ''Error Assigning Variable! '';' + @cr
                                , [name] = ev.name
        INTO #cmd
        FROM #env_varbase as ev

        /*Print out the variable creation procs */
        WHILE EXISTS (SELECT TOP 1 1 FROM #cmd)
        BEGIN
                SELECT TOP 1 @sql = cmd, @name = name FROM #cmd ORDER BY name;
                PRINT @sql;
               
                DELETE FROM #cmd WHERE name = @name;
        END;




        RETURN 0;






GO


