EXECUTE [Secure].[SetBlobConfiguration] @pName = 'DevBlobKey',
                                        @pDescription = 'DevBlobKey',
                                        @pValue = 'xYF9MDyF+4X/9O2kB3TMo7yowWx6qTUtFslJubq4nSyQVIC87+LM+1D6bNJtzRGatIwLjaTlgLjCMq7ep65orw==';

SELECT *
FROM [Secure].[Configurations];