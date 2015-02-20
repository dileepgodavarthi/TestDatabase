SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- ------------------------------------------------------------------------  
-- Copyright (c) 2007 QuickenLoans Inc.  
-- ------------------------------------------------------------------------  
-- Stored Procedure:  [OnCall_DeleteTeam]  
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
-- Description: This procedure is used to delete an OnCall Team  
-- ------------------------------------------------------------------------  
  
----------------------------------------------------------------------------------  

/* EXEC dbo.OnCall_DeleteTeam 76 */
 
CREATE PROCEDURE [dbo].[OnCall_DeleteTeam]  
@TeamID INTEGER  
  
AS  
  
SET NOCOUNT ON   
--Local variables  
  
--These variables are standard variables and should be put in all the SPs.  
DECLARE @tempXML         VARCHAR(MAX)  
DECLARE @errorXML        XML  
DECLARE @errorTrackingId INT  
DECLARE @errorMessage    VARCHAR(500)  
  
BEGIN TRY  
  
 -- Validate TeamID  
 IF (@TeamID IS NULL)  
 BEGIN  
  RAISERROR('The TeamID must be provided in OnCall_DeleteTeam!',16,1)  
  RETURN -1  
 END  
   
 BEGIN TRANSACTION   
  
  UPDATE [OnCallADGroups]  
     SET [TeamID] = NULL  
   WHERE [TeamID] = @TeamID  
  
  DELETE FROM [OnCallSchedules]  
   WHERE [TeamID] = @TeamID  
  
  DELETE FROM [OnCallRecurrance]  
   WHERE [TeamID] = @TeamID  
  
  DELETE FROM [OnCallTeamADGroups]  
   WHERE [TeamID] = @TeamID  
  
  DELETE FROM [OnCallTeamContacts]  
   WHERE [TeamID] = @TeamID  
  
  DELETE FROM [OnCallTeamKeywords]  
   WHERE [TeamID] = @TeamID  
  
  DELETE FROM [OnCallTeamRoles]  
   WHERE [TeamID] = @TeamID  
  
  DELETE FROM [OnCallTeamRotation]  
   WHERE [TeamID] = @TeamID  
  
  DELETE FROM [OnCallTeamSystems]  
   WHERE [TeamID] = @TeamID  
  
  DELETE FROM [OnCallTeams]  
   WHERE [TeamID] = @TeamID  
   
 COMMIT TRANSACTION  
END TRY  
  
BEGIN CATCH  
  
   --If any transaction is not committed, rollback.  
   IF @@TRANCOUNT > 0   
      ROLLBACK TRAN  
   
   SELECT @tempXML = dbo.fn_GetProcParameterXML(@@PROCID)  
   SELECT @errorXML = CAST(@tempXML AS XML)  
   EXEC dba_TrackError @@PROCID, @errorXML, @errorTrackingId OUTPUT  
  
   
   SET @errorMessage = 'Error in executing OnCall_DeleteTeam. '  
   SET @errorMessage = @errorMessage + ' Error message is "' + ERROR_MESSAGE() + '".'  
   SET @errorMessage = @errorMessage + 'Please look at ErrorTrackingId = ' + CAST(@errorTrackingId AS VARCHAR(10))  
   SET @errorMessage = @errorMessage + ' in ErrorTracking table.'  
   RAISERROR(@errorMessage, 16, 1)  
  
   RETURN  
  
END CATCH  
  
RETURN  

GO
