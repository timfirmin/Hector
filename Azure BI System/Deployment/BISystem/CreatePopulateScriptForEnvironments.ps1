$projectDirectory = "C:\@Source\Releases\UAT Release1_1.0.0\BISystem\Deployment\BISystem"

$environments = @(
             "DEV" ,
             "UAT" ,
             "TEST",
             "POC" ,
             "PROD"
   )

foreach($env in $environments)
{
    #Handles environment specific version of config.variable script
    $envBISystemPopulate = $projectDirectory+"\Deployment\BISystem$($env)VariablePopulateScript.sql" 
    $cmd = "INSERT INTO [Config].[Variable]( [VariableId] ,[Name] ,[Value] ,[Type] ) VALUES (1, 'SSISEnvironment', '$($env)', 'Environment Variable')"
    New-Item $envBISystemPopulate -type file -force -value $cmd
    Write-Output "Creating $($env) script: $($envBISystemPopulate)"
}
Write-Output "Creatioin of the deployment script has finished"
