SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- ------------------------------------------------------------------------
-- Copyright (c) 2007 QuickenLoans Inc.
-- ------------------------------------------------------------------------
-- Stored Procedure:  [OnCall_GetTeamByName]
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
-- 02/29/2010   John Hacker			 Added EmailReminderText column
-- ------------------------------------------------------------------------
--
-- Description:	This procedure is used to retrieve a Team by its Name
-- ------------------------------------------------------------------------

----------------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[OnCall_GetTeamByName]
@Name VARCHAR(50)

AS

SET NOCOUNT ON 
--Local variables

--These variables are standard variables and should be put in all the SPs.
DECLARE @tempXML         VARCHAR(MAX)
DECLARE @errorXML        XML
DECLARE @errorTrackingId INT
DECLARE @errorMessage    VARCHAR(500)

BEGIN TRY

	SELECT [TeamID], [Name], [OnCallEmail], [OnCallNumber], [OnCallExternalNumber], [AlternateContact1], 
			[AlternateContact2], [AlternateContact3], [PrimaryRole], [EmailDefault], [TeamLeader], [EmailReminderText]
	  FROM [OnCallTeams]
      WHERE [Name] LIKE @Name

END TRY

BEGIN CATCH

   --If any transaction is not committed, rollback.
   IF @@TRANCOUNT > 0 
      ROLLBACK TRAN
 
   --SELECT @tempXML = dbo.fn_GetProcParameterXML(@@PROCID)
   --SELECT @errorXML = CAST(@tempXML AS XML)
   --EXEC dba_TrackError @@PROCID, @errorXML, @errorTrackingId OUTPUT

	
   SET @errorMessage = 'Error in executing OnCall_GetTeamByName. '
   SET @errorMessage = @errorMessage + ' Error message is "' + ERROR_MESSAGE() + '".'
   --SET @errorMessage = @errorMessage + 'Please look at ErrorTrackingId = ' + CAST(@errorTrackingId AS VARCHAR(10))
   --SET @errorMessage = @errorMessage + ' in ErrorTracking table.'
   RAISERROR(@errorMessage, 16, 1)

   RETURN

END CATCH

RETURN


GO
