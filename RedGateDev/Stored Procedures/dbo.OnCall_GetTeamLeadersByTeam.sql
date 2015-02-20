SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- ------------------------------------------------------------------------  
-- Copyright (c) 2007 QuickenLoans Inc.  
-- ------------------------------------------------------------------------  
-- Stored Procedure:  [OnCall_GetTeamLeadersByTeam]  
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
-- 05/14/2009   SamI				 Added Distinct 
-- ------------------------------------------------------------------------  
--  
-- Description: This procedure is used to get all leaders for a given team.  
-- ------------------------------------------------------------------------  
  
----------------------------------------------------------------------------------  
  
CREATE PROCEDURE [dbo].[OnCall_GetTeamLeadersByTeam]  
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
  RAISERROR('The TeamID must be provided in OnCall_GetTeamLeadersByTeam!',16,1)  
  RETURN -1  
 END  
  
 SELECT DISTINCT con.[ContactID], tc.[TeamID], con.[FirstName], con.[LastName], con.[EMail],  
   con.[WorkPhone], con.[CellPhone], con.[HomePhone], con.[PreferredContactType], con.[Username],  
   con.[StartTime], con.[EndTime], con.[OffHoursPreferredContactType], con.[OnCallAdmin]  
  FROM [OnCallContacts] con     
  LEFT OUTER JOIN [OnCallTeamContacts] tc ON con.[ContactID] = tc.[ContactID]  
  WHERE  
   tc.[TeamID] = @TeamID AND tc.[IsLeader] = 1  
  ORDER BY con.[FirstName], con.[LastName]  
  
END TRY  
  
BEGIN CATCH  
  
   --If any transaction is not committed, rollback.  
   IF @@TRANCOUNT > 0   
      ROLLBACK TRAN  
   
   --SELECT @tempXML = dbo.fn_GetProcParameterXML(@@PROCID)  
   --SELECT @errorXML = CAST(@tempXML AS XML)  
   --EXEC dba_TrackError @@PROCID, @errorXML, @errorTrackingId OUTPUT  
  
   
   --SET @errorMessage = 'Error in executing OnCall_GetTeamLeadersByTeam. '  
   --SET @errorMessage = @errorMessage + ' Error message is "' + ERROR_MESSAGE() + '".'  
   --SET @errorMessage = @errorMessage + 'Please look at ErrorTrackingId = ' + CAST(@errorTrackingId AS VARCHAR(10))  
   --SET @errorMessage = @errorMessage + ' in ErrorTracking table.'  
   --RAISERROR(@errorMessage, 16, 1)  
  
   RETURN  
  
END CATCH  
  
RETURN  

GO
