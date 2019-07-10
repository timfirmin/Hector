CREATE TABLE [Control].[DistributionGroupUser] (
    [DistributionGroupUserId] INT IDENTITY (1, 1) NOT NULL,
    [DistributionGroupId]     INT NOT NULL,
    [UserId]                  INT NOT NULL,
    CONSTRAINT [pkcDistributionGroupUserId] PRIMARY KEY CLUSTERED ([DistributionGroupUserId] ASC),
    CONSTRAINT [fkDistributionGroup] FOREIGN KEY ([DistributionGroupId]) REFERENCES [Control].[DistributionGroup] ([DistributionGroupId])
);

