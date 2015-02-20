SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- ------------------------------------------------------------------------
-- Copyright (c) 2007 QuickenLoans Inc.
-- ------------------------------------------------------------------------
-- Stored Procedure:  [OnCall_GetContactTeams]
--
----------------------------------------------------------------------------------
--COPYRIGHT (C) 2007 Quicken Loans Inc.
----------------------------------------------------------------------------------
--OnCall_GetContactTeams STORED PROCEDURE CREATION SCRIPT
----------------------------------------------------------------------------------
--
-- Revision History:
--
--  Date               Who             Description
-- ---------    -------------------  --------------------------------------
-- 06/06/2007   John Hacker          Initiator
-- ------------------------------------------------------------------------
--
-- Description:	This procedure is used to retrieve the Contacts associated with a team
-- ------------------------------------------------------------------------

----------------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[OnCall_GetContactTeams]
@ContactID INTEGER

AS

SET NOCOUNT ON 
--Local variables

--These variables are standard variables and should be put in all the SPs.
DECLARE @tempXML         VARCHAR(MAX)
DECLARE @errorXML        XML
DECLARE @errorTrackingId INT
DECLARE @errorMessage    VARCHAR(500)

BEGIN TRY

	-- Validate ContactID
	IF (@ContactID IS NULL)
	BEGIN
		RAISERROR('The ContactID must be provided in OnCall_GetContactTeams!',16,1)
		RETURN -1
	END

	SELECT distinct con.[TeamID], con.[IsLeader], t.[Name]
		FROM [OnCallTeamContacts] con
		INNER JOIN [OnCallTeams] t ON con.[TeamID] = t.[TeamID]
		WHERE
			con.[ContactID] = @ContactID
		ORDER BY 
			t.[Name]

END TRY

BEGIN CATCH

   --If any transaction is not committed, rollback.
   IF @@TRANCOUNT > 0 
      ROLLBACK TRAN
 
   --SELECT @tempXML = dbo.fn_GetProcParameterXML(@@PROCID)
   --SELECT @errorXML = CAST(@tempXML AS XML)
   --EXEC dba_TrackError @@PROCID, @errorXML, @errorTrackingId OUTPUT

	
   --SET @errorMessage = 'Error in executing OnCall_GetContactTeams. '
   --SET @errorMessage = @errorMessage + ' Error message is "' + ERROR_MESSAGE() + '".'
   --SET @errorMessage = @errorMessage + 'Please look at ErrorTrackingId = ' + CAST(@errorTrackingId AS VARCHAR(10))
   --SET @errorMessage = @errorMessage + ' in ErrorTracking table.'
   --RAISERROR(@errorMessage, 16, 1)

   RETURN

END CATCH

RETURN

GO
