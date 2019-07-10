if exists(select [environment] from [Control].[Environment] where [servername]=@@servername and [environment]='DEV')
begin
:r .\DevelopmentConfig.sql
end 
else if exists(select [environment] from [Control].[Environment] where [servername]=@@servername and [environment]='TEST')
begin
:r .\TestConfig.sql
end 
else if exists(select [environment] from [Control].[Environment] where [servername]=@@servername and [environment]='UAT')
begin
:r .\UATConfig.sql
end 
else if exists(select [environment] from [Control].[Environment] where [servername]=@@servername and [environment]='PROD')
begin
:r .\ProductionConfig.sql
end

