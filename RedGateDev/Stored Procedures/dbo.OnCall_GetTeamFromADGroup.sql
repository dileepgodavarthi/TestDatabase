SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- ------------------------------------------------------------------------
-- Copyright (c) 2007 QuickenLoans Inc.
-- ------------------------------------------------------------------------
-- Stored Procedure:  [OnCall_GetTeamFromADGroup]
--
----------------------------------------------------------------------------------
--COPYRIGHT (C) 2007 Quicken Loans Inc.
----------------------------------------------------------------------------------
--OnCall_GetTeamFromADGroup STORED PROCEDURE CREATION SCRIPT
----------------------------------------------------------------------------------
--
-- Revision History:
--
--  Date               Who             Description
-- ---------    -------------------  --------------------------------------
-- 06/06/2007   John Hacker          Initiator
-- 05/07/2009   John Hacker          Changed to use new OnCallADGroups table
-- 02/29/2010   John Hacker			 Added EmailReminderText column
-- ------------------------------------------------------------------------
--
-- Description:	This procedure is get a team based off of it's AD groups
-- ------------------------------------------------------------------------

----------------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[OnCall_GetTeamFromADGroup]
@ADGroup VARCHAR(50)

AS

SET NOCOUNT ON 
--Local variables

--These variables are standard variables and should be put in all the SPs.
DECLARE @tempXML         VARCHAR(MAX)
DECLARE @errorXML        XML
DECLARE @errorTrackingId INT
DECLARE @errorMessage    VARCHAR(500)

BEGIN TRY

	SELECT t.[TeamID], t.[Name], t.[OnCallEmail], t.[OnCallNumber], t.[OnCallExternalNumber], 
		t.[AlternateContact1], t.[AlternateContact2], t.[AlternateContact3],
		t.[PrimaryRole], t.[Hidden], t.[EmailDefault], t.[TeamLeader], t.[EmailReminderText]
	  FROM [OnCallADGroups] adg
		INNER JOIN [OnCallTeams] t ON adg.[TeamID] = t.[TeamID]
	 WHERE adg.[ADSubTeam]= @ADGroup

END TRY

BEGIN CATCH

   --If any transaction is not committed, rollback.
   IF @@TRANCOUNT > 0 
      ROLLBACK TRAN
 
   --SELECT @tempXML = dbo.fn_GetProcParameterXML(@@PROCID)
   --SELECT @errorXML = CAST(@tempXML AS XML)
   --EXEC dba_TrackError @@PROCID, @errorXML, @errorTrackingId OUTPUT

	
   SET @errorMessage = 'Error in executing OnCall_GetTeamFromADGroup. '
   SET @errorMessage = @errorMessage + ' Error message is "' + ERROR_MESSAGE() + '".'
   --SET @errorMessage = @errorMessage + 'Please look at ErrorTrackingId = ' + CAST(@errorTrackingId AS VARCHAR(10))
   --SET @errorMessage = @errorMessage + ' in ErrorTracking table.'
   RAISERROR(@errorMessage, 16, 1)

   RETURN

END CATCH

RETURN


GO
