CREATE TABLE [notification].[recipient] (
    [recipientID]    INT           IDENTITY (1, 1) NOT NULL,
    [recipientName]  VARCHAR (100) NOT NULL,
    [recipientEmail] VARCHAR (255) NULL,
    [friendlyName]   VARCHAR (100) NULL,
    PRIMARY KEY CLUSTERED ([recipientID] ASC)
);



