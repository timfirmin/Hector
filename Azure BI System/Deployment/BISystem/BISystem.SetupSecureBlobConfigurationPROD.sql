EXECUTE [Secure].[SetBlobConfiguration] @pName = 'PRODBlobKey',
                                        @pDescription = 'PRODBlobKey',
                                        @pValue = <tba>;

SELECT *
FROM [Secure].[Configurations];