CREATE TABLE [notification].[template] (
    [templateID]   INT            IDENTITY (1, 1) NOT NULL,
    [templateName] VARCHAR (100)  NOT NULL,
    [category]     VARCHAR (50)   NULL,
    [enabled]      BIT            DEFAULT ((1)) NULL,
    [profileName]  VARCHAR (255)  NULL,
    [greeting]     VARCHAR (100)  NULL,
    [bodyText]     VARCHAR (4000) NULL,
    [signature]    VARCHAR (255)  NULL
);



