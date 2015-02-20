SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- ------------------------------------------------------------------------  
-- Copyright (c) 2007 QuickenLoans Inc.  
-- ------------------------------------------------------------------------  
-- Stored Procedure:  [OnCall_SetTeamLeader]  
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
-- 05/07/2009   John Hacker          Initiator  
-- ------------------------------------------------------------------------  
--  
-- Description: This procedure is set a contact as a leader for a team.  If the contact  
--     is not a member of the team currently they will be added.  
-- ------------------------------------------------------------------------  
  
----------------------------------------------------------------------------------  
  
CREATE PROCEDURE [dbo].[OnCall_SetTeamLeader]  
@ContactID  INTEGER,  
@TeamID     INTEGER,  
@IsLeader   BIT  
  
AS  
  
SET NOCOUNT ON   
--Local variables  
  
--These variables are standard variables and should be put in all the SPs.  
DECLARE @tempXML         VARCHAR(MAX)  
DECLARE @errorXML        XML  
DECLARE @errorTrackingId INT  
DECLARE @errorMessage    VARCHAR(500)  
  
DECLARE @TempKey INT  
  
BEGIN TRY  
  
 BEGIN TRANSACTION  
  
        SELECT @TempKey = TeamContactID  
          FROM OnCallTeamContacts  
         WHERE ContactID = @ContactID AND TeamID = @TeamID  
  
        IF (@TempKey IS NULL)  
          BEGIN  
     INSERT INTO OnCallTeamContacts  
       (TeamID, ContactID, IsLeader)  
    VALUES  
       (@TeamID, @ContactID, @IsLeader)  
          END  
        ELSE  
          BEGIN  
   UPDATE OnCallTeamContacts  
      SET IsLeader = @IsLeader  
    WHERE TeamContactID = @TempKey  
          END  
    
 COMMIT TRANSACTION  
  
END TRY  
  
BEGIN CATCH  
  
   --If any transaction is not committed, rollback.  
   IF @@TRANCOUNT > 0   
      ROLLBACK TRAN  
   
   --SELECT @tempXML = dbo.fn_GetProcParameterXML(@@PROCID)  
   --SELECT @errorXML = CAST(@tempXML AS XML)  
   --EXEC dba_TrackError @@PROCID, @errorXML, @errorTrackingId OUTPUT  
  
   
   --SET @errorMessage = 'Error in executing OnCall_SetTeamLeader. '  
   --SET @errorMessage = @errorMessage + ' Error message is "' + ERROR_MESSAGE() + '".'  
   --SET @errorMessage = @errorMessage + 'Please look at ErrorTrackingId = ' + CAST(@errorTrackingId AS VARCHAR(10))  
   --SET @errorMessage = @errorMessage + ' in ErrorTracking table.'  
   --RAISERROR(@errorMessage, 16, 1)  
  
   RETURN  
  
END CATCH  
  
RETURN  

GO
