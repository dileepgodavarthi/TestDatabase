SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- ------------------------------------------------------------------------  
-- Copyright (c) 2007 QuickenLoans Inc.  
-- ------------------------------------------------------------------------  
-- Stored Procedure:  [OnCall_DeleteContact]  
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
-- 09/09/2010   SP                   Delete from OnCallTeamRotation,OnCallSystems,OnCallTeams  
-- ------------------------------------------------------------------------  
--  
-- Description: This procedure is used to delete an OnCal Sytem  
-- ------------------------------------------------------------------------  
-- [OnCall_DeleteContact] 3512976  
----------------------------------------------------------------------------------  
  
CREATE PROCEDURE [dbo].[OnCall_DeleteContact]  
@ContactID INT  
  
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
  RAISERROR('The ContactID must be provided in OnCall_DeleteContact!',16,1)  
  RETURN -1  
 END  
   INSERT INTO AuditTeamContacts(TeamId,ContactId,StoredProcedureName,AddedBy,CreateDate)  
 SELECT NULL,@ContactID,'[OnCall_DeleteContact]',SUSER_NAME(),GETDATE()   
 
 BEGIN TRANSACTION   
  
   DELETE FROM [OnCallSchedules]  
    WHERE [ContactID] = @ContactID  
  
   DELETE FROM [OnCallRecurrance]  
    WHERE [ContactID] = @ContactID  
  
   DELETE FROM [OnCallTeamContacts]  
    WHERE [ContactID] = @ContactID  
     
   DELETE FROM [OnCallTeamRotation]  
    WHERE [ContactID] = @ContactID  
     
    UPDATE OnCallSystems  
     SET PrimaryTechID = NULL  
    WHERE PrimaryTechID = @ContactID      
         
    UPDATE OnCallTeams  
     SET AlternateContact1 = NULL  
    WHERE AlternateContact1 = @ContactID      
         
    UPDATE OnCallTeams  
     SET AlternateContact2 = NULL  
    WHERE AlternateContact2 = @ContactID      
         
    UPDATE OnCallTeams  
     SET AlternateContact3 = NULL  
    WHERE AlternateContact3 = @ContactID      
         
    UPDATE OnCallTeams  
     SET TeamLeader = NULL  
    WHERE TeamLeader = @ContactID      
  
   DELETE FROM [OnCallContacts]  
      WHERE [ContactID] = @ContactID  
  
 COMMIT TRANSACTION  
END TRY  
  
BEGIN CATCH  
  
   --If any transaction is not committed, rollback.  
   IF @@TRANCOUNT > 0   
      ROLLBACK TRAN  
   
   --SELECT @tempXML = dbo.fn_GetProcParameterXML(@@PROCID)  
   --SELECT @errorXML = CAST(@tempXML AS XML)  
   --EXEC dba_TrackError @@PROCID, @errorXML, @errorTrackingId OUTPUT  
  
   
   --SET @errorMessage = 'Error in executing OnCall_DeleteContact. '  
   --SET @errorMessage = @errorMessage + ' Error message is "' + ERROR_MESSAGE() + '".'  
   --SET @errorMessage = @errorMessage + 'Please look at ErrorTrackingId = ' + CAST(@errorTrackingId AS VARCHAR(10))  
   --SET @errorMessage = @errorMessage + ' in ErrorTracking table.'  
   --RAISERROR(@errorMessage, 16, 1)  
  
   RETURN  
  
END CATCH  
  
RETURN  
GO
