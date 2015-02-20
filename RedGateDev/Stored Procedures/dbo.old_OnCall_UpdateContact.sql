SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- ------------------------------------------------------------------------
-- Copyright (c) 2007 QuickenLoans Inc.
-- ------------------------------------------------------------------------
-- Stored Procedure:  [OnCall_UpdateContact]
--
----------------------------------------------------------------------------------
--COPYRIGHT (C) 2007 Quicken Loans Inc.
----------------------------------------------------------------------------------
--OnCall_UpdateContact STORED PROCEDURE CREATION SCRIPT
----------------------------------------------------------------------------------
--
-- Revision History:
--
--  Date               Who             Description
-- ---------    -------------------  --------------------------------------
-- 06/06/2007   John Hacker          Initiator
-- ------------------------------------------------------------------------
--
-- Description:	This procedure is update a Contact
-- ------------------------------------------------------------------------

----------------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[old_OnCall_UpdateContact]
@ContactID INTEGER,
@FirstName VARCHAR(50),
@LastName VARCHAR(50),
@Email VARCHAR(50),
@WorkPhone VARCHAR(25),
@CellPhone VARCHAR(25),
@HomePhone VARCHAR(25),
@PreferredContactType VARCHAR(10),
@Username VARCHAR(50),
@StartTime DATETIME,
@EndTime DATETIME,
@OffHoursPreferredContactType VARCHAR(10),
@OnCallAdmin BIT

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
		RAISERROR('The ContactID must be provided in OnCall_UpdateContact!',16,1)
		RETURN -1
	END

	UPDATE [OnCallContacts]
	
	SET [FirstName] = @FirstName,
        [LastName] = @LastName,
        [Email] = @Email,
        [WorkPhone] = @WorkPhone,
        [CellPhone] = @CellPhone,
        [HomePhone] = @HomePhone,
        [PreferredContactType] = @PreferredContactType,
        [Username] = @Username,
		[LastUpdateDate] = getdate(),
		[StartTime] = @StartTime,
		[EndTime] = @EndTime,
		[OffHoursPreferredContactType] = @OffHoursPreferredContactType,
		[OnCallAdmin] = @OnCallAdmin
	
	WHERE [ContactID]=@ContactID
END TRY

BEGIN CATCH

   --If any transaction is not committed, rollback.
   IF @@TRANCOUNT > 0 
      ROLLBACK TRAN
 
   --SELECT @tempXML = dbo.fn_GetProcParameterXML(@@PROCID)
   --SELECT @errorXML = CAST(@tempXML AS XML)
   --EXEC dba_TrackError @@PROCID, @errorXML, @errorTrackingId OUTPUT

	
   --SET @errorMessage = 'Error in executing OnCall_UpdateContact. '
   --SET @errorMessage = @errorMessage + ' Error message is "' + ERROR_MESSAGE() + '".'
   --SET @errorMessage = @errorMessage + 'Please look at ErrorTrackingId = ' + CAST(@errorTrackingId AS VARCHAR(10))
   --SET @errorMessage = @errorMessage + ' in ErrorTracking table.'
   --RAISERROR(@errorMessage, 16, 1)

   RETURN

END CATCH

RETURN

GO
