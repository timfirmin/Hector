USE [SSISConfiguration]
GO
/****** Object:  StoredProcedure [Control].[ProcessLoadPackage]    Script Date: 18/10/2016 12:06:00 ******/
DROP PROCEDURE IF EXISTS [Control].[ProcessLoadPackage]
GO
/****** Object:  StoredProcedure [Control].[ProcessGlobalExecuter]    Script Date: 18/10/2016 12:06:00 ******/
DROP PROCEDURE IF EXISTS [Control].[ProcessGlobalExecuter]
GO
/****** Object:  StoredProcedure [Config].[AddVariable]    Script Date: 18/10/2016 12:06:00 ******/
DROP PROCEDURE IF EXISTS [Config].[AddVariable]
GO
/****** Object:  UserDefinedFunction [Config].[ObtainVariable]    Script Date: 18/10/2016 12:06:00 ******/
DROP FUNCTION IF EXISTS [Config].[ObtainVariable]
GO
/****** Object:  Table [Config].[Variable]    Script Date: 18/10/2016 12:06:00 ******/
DROP TABLE IF EXISTS [Config].[Variable]
GO
/****** Object:  Schema [Control]    Script Date: 18/10/2016 12:06:00 ******/
DROP SCHEMA IF EXISTS [Control]
GO
/****** Object:  Schema [Config]    Script Date: 18/10/2016 12:06:00 ******/
DROP SCHEMA IF EXISTS [Config]
GO
