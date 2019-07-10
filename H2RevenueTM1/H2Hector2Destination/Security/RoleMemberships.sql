ALTER ROLE [db_datareader] ADD MEMBER [PRS\SQLServerReader-AZI-MS-SQL-T001];


GO
ALTER ROLE [db_datareader] ADD MEMBER [PowerBISysTest];


GO
ALTER ROLE [db_datareader] ADD MEMBER [PRS\SQLProxyBISysTest];


GO
ALTER ROLE [db_datawriter] ADD MEMBER [PRS\SQLServerWriter-AZI-MS-SQL-T001];


GO
ALTER ROLE [db_datawriter] ADD MEMBER [PowerBISysTest];


GO
ALTER ROLE [db_datawriter] ADD MEMBER [PRS\SQLProxyBISysTest];

