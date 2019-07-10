CREATE TABLE [notification].[recipient](
	[recipientID] [int] IDENTITY(1,1) NOT NULL,
	[recipientName] [varchar](100) NOT NULL,
	[recipientEmail] [varchar](255) NULL,
	[friendlyName] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[recipientID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO



