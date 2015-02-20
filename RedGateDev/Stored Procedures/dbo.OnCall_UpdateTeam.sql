SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- ------------------------------------------------------------------------
-- Copyright (c) 2007 QuickenLoans Inc.
-- ------------------------------------------------------------------------
-- Stored Procedure:  [OnCall_UpdateTeam]
--
----------------------------------------------------------------------------------
--COPYRIGHT (C) 2007 Quicken Loans Inc.
----------------------------------------------------------------------------------
--OnCall_UpdateTeam STORED PROCEDURE CREATION SCRIPT
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
-- Description:	This procedure is used to update a Team 
-- ------------------------------------------------------------------------

----------------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[OnCall_UpdateTeam]
@TeamID INTEGER,
@Name VARCHAR(50),
@OnCallEmail VARCHAR(50),
@OnCallNumber VARCHAR(50),
@OnCallExternalNumber VARCHAR(50),
@AlternateContact1 INTEGER,
@AlternateContact2 INTEGER,
@AlternateContact3 INTEGER,
@PrimaryRole INTEGER,
@TeamLeader INTEGER,
@EmailDefault BIT,
@EmailReminderText VARCHAR(MAX)

AS

SET NOCOUNT ON 
--Local variables

--These variables are standard variables and should be put in all the SPs.
DECLARE @tempXML         VARCHAR(MAX)
DECLARE @errorXML        XML
DECLARE @errorTrackingId INT
DECLARE @errorMessage    VARCHAR(500)

DECLARE @TeamName VARCHAR(50)

BEGIN TRY

	-- Validate TeamID
	IF (@TeamID IS NULL)
	BEGIN
		RAISERROR('The TeamID must be provided in OnCall_UpdateTeam!',16,1)
		RETURN -1
	END

	SET @TeamName = (SELECT [Name] FROM [OnCallTeams]
		WHERE [TeamID] = @TeamID)

	UPDATE [OnCallTeams]
	   SET [Name] = @Name,
		   [OnCallEmail] = @OnCallEmail,
		   [OnCallNumber] = @OnCallNumber,
		   [OnCallExternalNumber] = @OnCallExternalNumber,
		   [AlternateContact1] = @AlternateContact1,
		   [AlternateContact2] = @AlternateContact2,
		   [AlternateContact3] = @AlternateContact3,
		   [PrimaryRole] = @PrimaryRole,
		   [TeamLeader] = @TeamLeader,
		   [EmailDefault] = @EmailDefault,
		   [EmailReminderText] = @EmailReminderText,			
		   [LastUpdateDate] = getdate()
	 WHERE [TeamID]=@TeamID

	IF NOT (@TeamName = @Name)
	BEGIN
		INSERT INTO [OnCall].[dbo].[OnCallKeywordHistory]
				   ([Keyword], [Type], [Association], [Action], [CreateDate], [LastUpdateDate])
			VALUES 
					(@TeamName, 'Team', @TeamName, 'Deleted', GETDATE(), GETDATE())

		INSERT INTO [OnCall].[dbo].[OnCallKeywordHistory]
				   ([Keyword], [Type], [Association], [Action], [CreateDate], [LastUpdateDate])
			VALUES 
					(@Name, 'System', @Name, 'Added', GETDATE(), GETDATE())	
	END

END TRY

BEGIN CATCH

   --If any transaction is not committed, rollback.
   IF @@TRANCOUNT > 0 
      ROLLBACK TRAN
 
   --SELECT @tempXML = dbo.fn_GetProcParameterXML(@@PROCID)
   --SELECT @errorXML = CAST(@tempXML AS XML)
   --EXEC dba_TrackError @@PROCID, @errorXML, @errorTrackingId OUTPUT

	
   SET @errorMessage = 'Error in executing OnCall_UpdateTeam. '
   SET @errorMessage = @errorMessage + ' Error message is "' + ERROR_MESSAGE() + '".'
   --SET @errorMessage = @errorMessage + 'Please look at ErrorTrackingId = ' + CAST(@errorTrackingId AS VARCHAR(10))
   --SET @errorMessage = @errorMessage + ' in ErrorTracking table.'
   RAISERROR(@errorMessage, 16, 1)

   RETURN

END CATCH

RETURN


GO
