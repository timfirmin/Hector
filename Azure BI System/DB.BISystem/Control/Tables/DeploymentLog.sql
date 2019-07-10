CREATE TABLE [Control].[DeploymentLog]
(
	[DeploymentLogId] INT NOT NULL PRIMARY KEY,
	[Environment] VARCHAR(50) NOT NULL,
	[Version] VARCHAR(20) NOT NULL,
	[DeploymentTimestamp] DATETIME NOT NULL DEFAULT GETDATE()
)
