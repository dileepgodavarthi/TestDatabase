SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- ------------------------------------------------------------------------
-- Copyright (c) 2007 QuickenLoans Inc.
-- ------------------------------------------------------------------------
-- Stored Procedure:  [OnCall_ContactNameSearch]
--
----------------------------------------------------------------------------------
--COPYRIGHT (C) 2007 Quicken Loans Inc.
----------------------------------------------------------------------------------
--OnCall_GetTeamRoles STORED PROCEDURE CREATION SCRIPT
----------------------------------------------------------------------------------
--
-- Revision History:
--
--  Date               Who             Description
-- ---------    -------------------  --------------------------------------
-- 06/06/2007   John Hacker          Initiator
-- 11/27/2007   Pratima Naik         Changed to find a substring 
-- ------------------------------------------------------------------------
--
-- Description:	This procedure is used to retrieve an OnCall contact by First 
--              and Last Names.
-- ------------------------------------------------------------------------

----------------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[OnCall_ContactNameSearch]
@SearchName VARCHAR(50)

AS

SET NOCOUNT ON 
--Local variables

--These variables are standard variables and should be put in all the SPs.
DECLARE @tempXML         VARCHAR(MAX)
DECLARE @errorXML        XML
DECLARE @errorTrackingId INT
DECLARE @errorMessage    VARCHAR(500)
DECLARE @pos SMALLINT
BEGIN TRY
	SET @pos = -1
	SELECT con.[ContactID], con.[FirstName], con.[LastName], con.[EMail],
			con.[WorkPhone], con.[CellPhone], con.[HomePhone], con.[PreferredContactType], con.[Username],
			con.[StartTime], con.[EndTime], con.[OffHoursPreferredContactType], con.[OnCallAdmin]
		FROM [OnCallContacts] con	
		WHERE
			con.[FirstName] LIKE @SearchName  OR con.[LastName] LIKE @SearchName  OR  ((CHARINDEX(con.[FirstName], @SearchName) > 0) AND  (CHARINDEX(con.[LastName], @SearchName) > 0))

END TRY

BEGIN CATCH

   --If any transaction is not committed, rollback.
   IF @@TRANCOUNT > 0 
      ROLLBACK TRAN
 
   --SELECT @tempXML = dbo.fn_GetProcParameterXML(@@PROCID)
   --SELECT @errorXML = CAST(@tempXML AS XML)
   --EXEC dba_TrackError @@PROCID, @errorXML, @errorTrackingId OUTPUT

	
   --SET @errorMessage = 'Error in executing OnCall_ContactNameSearch. '
   --SET @errorMessage = @errorMessage + ' Error message is "' + ERROR_MESSAGE() + '".'
   --SET @errorMessage = @errorMessage + 'Please look at ErrorTrackingId = ' + CAST(@errorTrackingId AS VARCHAR(10))
   --SET @errorMessage = @errorMessage + ' in ErrorTracking table.'
   --RAISERROR(@errorMessage, 16, 1)

   RETURN

END CATCH

RETURN

GO
