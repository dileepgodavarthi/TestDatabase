SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- ------------------------------------------------------------------------  
-- Copyright (c) 2007 QuickenLoans Inc.  
-- ------------------------------------------------------------------------  
-- Stored Procedure:  [OnCall_DeleteSystem]  
--  
----------------------------------------------------------------------------------  
--COPYRIGHT (C) 2007 Quicken Loans Inc.  
----------------------------------------------------------------------------------  
--OnCall_DeleteSystem STORED PROCEDURE CREATION SCRIPT  
----------------------------------------------------------------------------------  
--  
-- Revision History:  
--  
--  Date               Who             Description  
-- ---------    -------------------  --------------------------------------  
-- 06/06/2007   John Hacker          Initiator  
-- ------------------------------------------------------------------------  
--  
-- Description: This procedure is used to delete an OnCal Sytem  
-- ------------------------------------------------------------------------  
  
----------------------------------------------------------------------------------  
  
CREATE PROCEDURE [dbo].[OnCall_DeleteSystem]  
@SystemID INTEGER  
  
AS  
  
SET NOCOUNT ON   
--Local variables  
  
--These variables are standard variables and should be put in all the SPs.  
DECLARE @tempXML         VARCHAR(MAX)  
DECLARE @errorXML        XML  
DECLARE @errorTrackingId INT  
DECLARE @errorMessage    VARCHAR(500)  
  
DECLARE @SysName VARCHAR(50)  
BEGIN TRY  
  
 -- Validate SystemID  
 IF (@SystemID IS NULL)  
 BEGIN  
  RAISERROR('The SystemID must be provided in OnCall_DeleteSystem!',16,1)  
  RETURN -1  
 END  
   
 BEGIN TRANSACTION  
    
  SET @SysName = (SELECT [Name] FROM [OnCallSystems]  
   WHERE [SystemID] = @SystemID)  
  
  DELETE FROM [OnCallTeamSystems]  
   WHERE [SystemID] = @SystemID  
  
  DELETE FROM [OnCallSystemKeywords]  
   WHERE [SystemID] = @SystemID  
  
  DELETE FROM [OnCallSystems]  
   WHERE [SystemID] = @SystemID  
  
  INSERT INTO [OnCall].[dbo].[OnCallKeywordHistory]  
       ([Keyword], [Type], [Association], [Action], [CreateDate], [LastUpdateDate])  
   VALUES (@SysName, 'System', @SysName, 'Deleted', GETDATE(), GETDATE())  
  
 COMMIT TRANSACTION  
END TRY  
  
BEGIN CATCH  
  
   --If any transaction is not committed, rollback.  
   IF @@TRANCOUNT > 0   
      ROLLBACK TRAN  
   
   --SELECT @tempXML = dbo.fn_GetProcParameterXML(@@PROCID)  
   --SELECT @errorXML = CAST(@tempXML AS XML)  
   --EXEC dba_TrackError @@PROCID, @errorXML, @errorTrackingId OUTPUT  
  
   
   --SET @errorMessage = 'Error in executing OnCall_DeleteSystem. '  
   --SET @errorMessage = @errorMessage + ' Error message is "' + ERROR_MESSAGE() + '".'  
   --SET @errorMessage = @errorMessage + 'Please look at ErrorTrackingId = ' + CAST(@errorTrackingId AS VARCHAR(10))  
   --SET @errorMessage = @errorMessage + ' in ErrorTracking table.'  
   --RAISERROR(@errorMessage, 16, 1)  
  
   RETURN  
  
END CATCH  
  
RETURN  

GO
