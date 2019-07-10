--------------------------------------------------------------------------
--Created By : Tim Firmin 2018DEC10 ~ MDS Integration Hector 2 Project
--Loop Validation UDFs and Log Data JSON plus Affected Row Counts
 
--Test001 SingleUser : EXEC [staging].[spValidateAbacus] @LoadId=101517
--------------------------------------------------------------------------
CREATE PROCEDURE [staging].[spValidateAbacus]
 @LoadId int
AS

DECLARE @data nvarchar(MAX)
DECLARE @datarowcount int
DECLARE @sqlCommand nvarchar(1000)

DECLARE @RuleId int, @UdfName varchar(100), @AttributeName varchar(100)

DECLARE @ParamDefinition nvarchar(500); 

DECLARE CUR CURSOR FOR SELECT RuleId,[AbacusTableName],RuleUdf FROM [Config].[ValidationRules]  WHERE [ValidationType] = 'Validation Rule'
OPEN CUR
FETCH NEXT FROM cur INTO @RuleId, @AttributeName,@UdfName

WHILE @@FETCH_STATUS = 0 BEGIN

        /******** Create Output JSON *********************/ 
		SET @sqlCommand = ' SELECT @DataOUT = ( SELECT *  FROM ' + @UdfName + ' FOR JSON PATH, INCLUDE_NULL_VALUES )';
		SET @ParamDefinition = N'@DataOUT nvarchar(max) OUTPUT'; 

		exec sp_executesql @sqlCommand,@ParamDefinition, @DataOUT = @data out

		--SET @data =  replace(replace(@data,']',''),'[','')
		/******** Calculate Number of Rows In Output JSON *********************/
		SET @sqlCommand = ' SELECT @DatarowcountOUT = COUNT(*) FROM ' + @UdfName + '';
		SET @ParamDefinition = N'@DatarowcountOUT int OUTPUT'; 

		--PRINT @sqlCommand

		exec sp_executesql @sqlCommand,@ParamDefinition, @DatarowcountOUT = @datarowcount out						
						
/****** Log Insert JSON and Row Count ********/
INSERT [staging].AbacusValidationLog (LoadId,RuleId,ValidationData,ValidationRowCount)
VALUES (@LoadId,@RuleId,@data,@datarowcount) 
	
FETCH NEXT FROM CUR INTO @RuleId, @AttributeName,@UdfName
END

CLOSE CUR    
DEALLOCATE CUR