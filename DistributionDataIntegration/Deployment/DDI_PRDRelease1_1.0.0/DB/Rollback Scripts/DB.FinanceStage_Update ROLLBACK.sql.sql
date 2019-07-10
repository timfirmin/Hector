
DROP TABLE [DDIstaging].[FileLog]
DROP TABLE [DDIstaging].[FileType]

DROP TABLE [DDIstaging].[DistributionMissingMinutes]
DROP TABLE [DDIstaging].[DistributionMusicMinutes]


DROP TABLE [DDIstaging].[ErrorLog]
DROP TABLE [DDIstaging].[DistributionPublicReception]
DROP VIEW [DDItransform].[vDistributionMusicMinutes]
DROP VIEW [DDItransform].[vDistributionMissingMinutes]
DROP VIEW [DDItransform].[vDistributionPublicReception]
DROP TABLE [DDIstaging].[NotificationLog]
DROP VIEW [DDItransform].[vNotificationLogFull]

DROP SCHEMA [DDIstaging]
DROP SCHEMA [DDItransform]

