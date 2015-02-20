SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- ---------------------------------------------------------------------------------
-- COPYRIGHT (C) 2006 QUICKENLOANS INC.
-- ---------------------------------------------------------------------------------
-- fn_GetProcParameterXML FUNCTION CREATION SCRIPT
-- ---------------------------------------------------------------------------------
--
-- Revision History
--
-- Date       Who      Description
-- ---------  ------   -------------------------------------------------------------
-- 08 Aug 06  RL       Initiator
-- ---------------------------------------------------------------------------------
--
-- Function Name:  fn_GetProcParameterXML
--
-- Purpose
-- ---------------------------------------------------------------------------------
-- This function returns a xml that has all parameter names for a given stored proc.
-- ---------------------------------------------------------------------------------

CREATE FUNCTION [dbo].[fn_GetProcParameterXML] (
   @storedProcedureId INT)
RETURNS VARCHAR(MAX)
AS
BEGIN

   DECLARE @paramName SYSNAME
   DECLARE @returnXML VARCHAR(MAX)

   SET @returnXML = '<StoredProcedureParameterXML>'
   SET @returnXML = @returnXML + '<StoredProcedureName>' + OBJECT_NAME(@storedProcedureId) + '</StoredProcedureName>'
   SET @returnXML = @returnXML + '<StoredProcedureParameters>'

   SELECT @returnXML = COALESCE(@returnXML, '') + '<' +  + REPLACE(name, '@', '') + '>' + '</' +  + REPLACE(name, '@', '') + '>'
     FROM sys.Parameters
    WHERE object_id = @storedProcedureId
      AND is_output = 0
    ORDER BY parameter_id

   SET @returnXML = @returnXML + '</StoredProcedureParameters></StoredProcedureParameterXML>'

   RETURN @returnXML

END

GO
