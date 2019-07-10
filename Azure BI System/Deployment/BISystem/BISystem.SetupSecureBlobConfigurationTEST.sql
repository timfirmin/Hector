EXECUTE [Secure].[SetBlobConfiguration] @pName = 'TestBlobKey',
                                        @pDescription = 'TestBlobKey',
                                        @pValue = 'K7wRWhy3e2UYMBNIQCGB1arQdKIjLyRuT9V6qp2b9fKq4pVMMExNFba6vEimJlCPxoysWPGGxUzkQaYcMsXeDg==';

SELECT *
FROM [Secure].[Configurations];