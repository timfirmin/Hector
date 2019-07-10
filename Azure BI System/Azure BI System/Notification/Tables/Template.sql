CREATE TABLE [notification].[template](
	[templateID] [int] IDENTITY(1,1) NOT NULL,
	[templateName] [varchar](100) NOT NULL,
	[category] [varchar](50) NULL,
	[enabled] [bit] NULL,
	[profileName] [varchar](255) NULL,
	[greeting] [varchar](100) NULL,
	[bodyText] [varchar](4000) NULL,
	[signature] [varchar](255) NULL
)

GO

ALTER TABLE [notification].[template] ADD  DEFAULT ((1)) FOR [enabled]
GO