﻿CREATE TABLE [notification].[Solution](
	[solutionID] [int] IDENTITY(1,1) NOT NULL,
	[solutionName] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[solutionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO


