SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- ------------------------------------------------------------------------
-- Copyright (c) 2007 QuickenLoans Inc.
-- ------------------------------------------------------------------------
-- Stored Procedure:  [OnCall_GetOnCallContact]
--
----------------------------------------------------------------------------------
--COPYRIGHT (C) 2007 Quicken Loans Inc.
----------------------------------------------------------------------------------
--OnCall_GetOnCallContact STORED PROCEDURE CREATION SCRIPT
----------------------------------------------------------------------------------
--
-- Revision History:
--
--  Date               Who             Description
-- ---------    -------------------  --------------------------------------
-- 06/06/2007   John Hacker          Initiator
-- 10/04/2010   SP                   Get Pager info
-- ------------------------------------------------------------------------
--
-- Description:	This procedure is used to get the OnCall contact by
--				team and time.
-- ------------------------------------------------------------------------

----------------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[OnCall_GetOnCallContact]
@TeamID INTEGER,
@Time DATETIME

AS

SET NOCOUNT ON 
--Local variables

--These variables are standard variables and should be put in all the SPs.
DECLARE @tempXML         VARCHAR(MAX)
DECLARE @errorXML        XML
DECLARE @errorTrackingId INT
DECLARE @errorMessage    VARCHAR(500)

BEGIN TRY

	-- Validate date parameters
	IF (@Time IS NULL)
	BEGIN
		RAISERROR('A Time has to be provided in OnCall_GetOnCallContact!',16,1)
		RETURN -1
	END

	-- Validate TeamID
	IF (@TeamID IS NULL)
	BEGIN
		RAISERROR('The TeamID must be provided in OnCall_GetOnCallContact!',16,1)
		RETURN -1
	END

	SELECT DISTINCT con.[ContactID], con.[FirstName], con.[LastName], con.[Email], con.[WorkPhone], 
			con.[CellPhone], con.[HomePhone], con.[PreferredContactType], con.[Username],
			con.[StartTime], con.[EndTime], con.[OffHoursPreferredContactType], con.[OnCallAdmin],con.Pager
		FROM [OnCallSchedules] sch
			INNER JOIN [OnCallContacts] con ON sch.[ContactID] = con.[ContactID]
			INNER JOIN [OnCallTeams] tm ON sch.[TeamID] = tm.[TeamID]
			INNER JOIN [OnCallTeamRoles] trol ON sch.[RoleID] = trol.[RoleID]
		WHERE
			(@Time >= sch.[StartDate] AND @Time < sch.[EndDate])
			 AND sch.[TeamID] = @TeamID AND tm.[PrimaryRole]=trol.[RoleID]

END TRY

BEGIN CATCH

   --If any transaction is not committed, rollback.
   IF @@TRANCOUNT > 0 
      ROLLBACK TRAN
 
   --SELECT @tempXML = dbo.fn_GetProcParameterXML(@@PROCID)
   --SELECT @errorXML = CAST(@tempXML AS XML)
   --EXEC dba_TrackError @@PROCID, @errorXML, @errorTrackingId OUTPUT

	
   --SET @errorMessage = 'Error in executing OnCall_GetOnCallContact. '
   --SET @errorMessage = @errorMessage + ' Error message is "' + ERROR_MESSAGE() + '".'
   --SET @errorMessage = @errorMessage + 'Please look at ErrorTrackingId = ' + CAST(@errorTrackingId AS VARCHAR(10))
   --SET @errorMessage = @errorMessage + ' in ErrorTracking table.'
   --RAISERROR(@errorMessage, 16, 1)

   RETURN

END CATCH

RETURN

GO
