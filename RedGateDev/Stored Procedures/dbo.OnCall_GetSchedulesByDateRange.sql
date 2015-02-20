SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- ------------------------------------------------------------------------
-- Copyright (c) 2007 QuickenLoans Inc.
-- ------------------------------------------------------------------------
-- Stored Procedure:  [OnCall_GetSchedulesByDateRange]
--
----------------------------------------------------------------------------------
--COPYRIGHT (C) 2007 Quicken Loans Inc.
----------------------------------------------------------------------------------
--OnCall_GetSchedulesByDateRange STORED PROCEDURE CREATION SCRIPT
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
-- Description:	This procedure is used to retrieve OnCall schedules
--              that conflict with a time range for a team/role
-- ------------------------------------------------------------------------

----------------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[OnCall_GetSchedulesByDateRange]
@StartDate DATETIME,
@EndDate DATETIME

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
	IF (@StartDate IS NULL OR @EndDate IS NULL)
	BEGIN
		RAISERROR('Both StartDate and EndDate have to be provided in OnCall_GetSchedulesByDateRange!',16,1)
		RETURN -1
	END

	SELECT con.[FirstName], con.[LastName], rol.[Role], sch.[StartDate], sch.[EndDate], 
			sch.[ScheduleID], sch.[TeamID], sch.[ContactID], sch.[RoleID], con.[Email], sch.[RecurranceID], tm.[Name], tm.[EmailReminderText]
		FROM [OnCallSchedules] sch
			INNER JOIN [OnCallContacts] con ON sch.[ContactID] = con.[ContactID]
			INNER JOIN [OnCallRoles] rol ON sch.[RoleID] = rol.[RoleID]
			INNER JOIN [OnCallTeams] tm ON sch.[TeamID] = tm.[TeamID]
		WHERE
			(@StartDate <= sch.[StartDate] AND @EndDate >= sch.[StartDate])
		ORDER BY
			sch.[StartDate]

END TRY

BEGIN CATCH

   --If any transaction is not committed, rollback.
   IF @@TRANCOUNT > 0 
      ROLLBACK TRAN
 
   --SELECT @tempXML = dbo.fn_GetProcParameterXML(@@PROCID)
   --SELECT @errorXML = CAST(@tempXML AS XML)
   --EXEC dba_TrackError @@PROCID, @errorXML, @errorTrackingId OUTPUT

	
   SET @errorMessage = 'Error in executing OnCall_GetSchedulesByDateRange. '
   SET @errorMessage = @errorMessage + ' Error message is "' + ERROR_MESSAGE() + '".'
   --SET @errorMessage = @errorMessage + 'Please look at ErrorTrackingId = ' + CAST(@errorTrackingId AS VARCHAR(10))
   --SET @errorMessage = @errorMessage + ' in ErrorTracking table.'
   RAISERROR(@errorMessage, 16, 1)

   RETURN

END CATCH

RETURN


GO
