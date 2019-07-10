/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/
:r .\Control.EntityType.Populate.sql
:r .\Control.LoadStatusType.Populate.sql
:r .\Control.ProcessStream.Populate.sql
:r .\Control.SourceFileType.Populate.sql
:r .\Control.Application.Populate.sql
:r .\Config.Parameter.Populate.sql
:r .\Control.CleanseRuleType.Populate.sql
:r .\Control.DataQualityRuleType.Populate.sql
:r .\DataQuality.HarmoniseRule.Populate.sql
:r .\DataQuality.IntegrityType.Populate.sql
:r .\DataQuality.Screen.Populate.sql
:r .\DataQuality.ScreenSeverity.Populate.sql
:r .\DataQuality.StandardiseRule.Populate.sql
:r .\OLAPControl.Cube.Populate.sql
:r .\OLAPControl.Database.Populate.sql
--:r .\TabularControl.ProcessLevel.Populate.sql
--:r .\TabularControl.ProcessStatus.Populate.sql
--:r .\TabularControl.Database.Populate.sql
--:r .\TabularControl.ModelTable.Populate.sql
--:r .\TabularControl.ModelTablePartition.Populate.sql


