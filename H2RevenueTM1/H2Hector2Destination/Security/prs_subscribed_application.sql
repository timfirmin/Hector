CREATE ROLE [prs_subscribed_application]
    AUTHORIZATION [dbo];


GO
ALTER ROLE [prs_subscribed_application] ADD MEMBER [PRS\SQLProxyBISysTest];

