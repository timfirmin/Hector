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

/*************************************************************************************

*************************************************************************************/


/************************************************************************************
register the deployment
************************************************************************************/
insert [Control].[DeploymentLog]([Environment],[Version])
select [environment]
		,'1.0.0.0' 
from [Control].[Environment] 
where [servername]=@@servername  