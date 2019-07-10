CREATE TABLE [notification].[templateRecipient](
	[templateID] [int] NOT NULL,
	[recipientID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[templateID] ASC,
	[recipientID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO



