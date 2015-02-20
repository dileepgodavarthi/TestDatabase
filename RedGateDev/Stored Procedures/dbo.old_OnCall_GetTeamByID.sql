SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- ------------------------------------------------------------------------  
-- Copyright (c) 2007 QuickenLoans Inc.  
-- ------------------------------------------------------------------------  
-- Stored Procedure:  [OnCall_GetTeamByID]  
--  
----------------------------------------------------------------------------------  
--COPYRIGHT (C) 2007 Quicken Loans Inc.  
----------------------------------------------------------------------------------  
--OnCall_GetTeamByID STORED PROCEDURE CREATION SCRIPT  
----------------------------------------------------------------------------------  
--  
-- Revision History:  
--  
--  Date               Who             Description  
-- ---------    -------------------  --------------------------------------  
-- 06/06/2007   John Hacker          Initiator  
-- ------------------------------------------------------------------------  
--  
-- Description: This procedure is used to retrieve a Team by its ID  
-- ------------------------------------------------------------------------  
  
----------------------------------------------------------------------------------  
  
CREATE PROCEDURE [dbo].[old_OnCall_GetTeamByID]  
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
  RAISERROR('The TeamID must be provided in OnCall_GetTeamByID!',16,1)  
  RETURN -1  
 END  
  
 SELECT [TeamID], [Name], [OnCallEmail], [OnCallNumber], [OnCallExternalNumber], [AlternateContact1], [AlternateContact2], [AlternateContact3], [PrimaryRole], [Hidden], [EmailDefault], [TeamLeader]  
   FROM [OnCallTeams]  
      WHERE [TeamID]=@TeamID  
  
END TRY  
  
BEGIN CATCH  
  
   --If any transaction is not committed, rollback.  
   IF @@TRANCOUNT > 0   
      ROLLBACK TRAN  
   
   --SELECT @tempXML = dbo.fn_GetProcParameterXML(@@PROCID)  
   --SELECT @errorXML = CAST(@tempXML AS XML)  
   --EXEC dba_TrackError @@PROCID, @errorXML, @errorTrackingId OUTPUT  
  
   
   --SET @errorMessage = 'Error in executing OnCall_GetTeamByID. '  
   --SET @errorMessage = @errorMessage + ' Error message is "' + ERROR_MESSAGE() + '".'  
   --SET @errorMessage = @errorMessage + 'Please look at ErrorTrackingId = ' + CAST(@errorTrackingId AS VARCHAR(10))  
   --SET @errorMessage = @errorMessage + ' in ErrorTracking table.'  
   --RAISERROR(@errorMessage, 16, 1)  
  
   RETURN  
  
END CATCH  
  
RETURN  

GO
