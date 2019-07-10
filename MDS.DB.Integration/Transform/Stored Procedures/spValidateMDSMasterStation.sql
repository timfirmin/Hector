
--------------------------------------------------------------------------
--Created By : Senay 2018SEP07 ~ MDS Integration Hector 2 Project
--Loop Validation UDFs and Log Data JSON plus Affected Row Counts
--Last Change : tjf 2017NOV29 Data Count Logging was HardCoded to 
--Test001 SingleUser : EXEC [Transform].[spValidateMDSMasterStation] @LoadId=101517
--------------------------------------------------------------------------
CREATE PROCEDURE [Transform].[spValidateMDSMasterStation]
 @LoadId int
AS

DECLARE @data nvarchar(MAX)
DECLARE @datarowcount int
DECLARE @sqlCommand nvarchar(1000)

DECLARE @RuleId int, @UdfName varchar(100), @AttributeName varchar(100)

DECLARE @ParmDefinition nvarchar(500); 

DECLARE CUR CURSOR FOR SELECT RuleId,AttributeName,RuleUdf FROM [Config].[MDSBusinessRules] WHERE EnitytName ='MasterStation' AND RuleActiveYN = 'Y'
OPEN CUR
FETCH NEXT FROM cur INTO @RuleId, @AttributeName,@UdfName

WHILE @@FETCH_STATUS = 0 BEGIN

        /******** Create Output JSON *********************/ 
		SET @sqlCommand = ' SELECT @DataOUT = ( SELECT *  FROM  ' + @UdfName + ' FOR JSON PATH, INCLUDE_NULL_VALUES )';
		SET @ParmDefinition = N'@DataOUT nvarchar(max) OUTPUT'; 

		exec sp_executesql @sqlCommand,@ParmDefinition, @DataOUT = @data out

		--SET @data =  replace(replace(@data,']',''),'[','')
		/******** Calculate Number of Rows In Output JSON *********************/
		--NOOOOOOO!!!!!!!!!!    SET @sqlCommand = ' SELECT @DatarowcountOUT = COUNT(*) FROM [Transform].[udfValidateBroadcasterName]() ';
		SET @sqlCommand = ' SELECT @DatarowcountOUT = COUNT(*) FROM ' + @UdfName + '';
		SET @ParmDefinition = N'@DatarowcountOUT int OUTPUT'; 

		exec sp_executesql @sqlCommand,@ParmDefinition, @DatarowcountOUT = @datarowcount out						
						
/****** Log Insert JSON and Row Count ********/
INSERT [Transform].[MDSMasterStationValidated] (LoadId,RuleId,Data,DataRowCount,LogDate )
VALUES (@LoadId,@RuleId,@data,@datarowcount,GETDATE()) 
	
FETCH NEXT FROM CUR INTO @RuleId, @AttributeName,@UdfName
END

CLOSE CUR    
DEALLOCATE CUR


