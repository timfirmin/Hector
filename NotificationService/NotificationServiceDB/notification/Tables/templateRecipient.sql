CREATE TABLE [notification].[templateRecipient] (
    [templateID]  INT NOT NULL,
    [recipientID] INT NOT NULL,
    PRIMARY KEY CLUSTERED ([templateID] ASC, [recipientID] ASC)
);

