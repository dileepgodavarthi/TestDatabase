SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- ------------------------------------------------------------------------  
-- Copyright (c) 2007 QuickenLoans Inc.  
-- ------------------------------------------------------------------------  
-- Stored Procedure:  [OnCall_InsertTeamKeyword]  
--  
----------------------------------------------------------------------------------  
--COPYRIGHT (C) 2007 Quicken Loans Inc.  
----------------------------------------------------------------------------------  
--OnCall_InsertTeamKeyword STORED PROCEDURE CREATION SCRIPT  
----------------------------------------------------------------------------------  
--  
-- Revision History:  
--  
--  Date               Who             Description  
-- ---------    -------------------  --------------------------------------  
-- 06/06/2007   John Hacker          Initiator  
-- ------------------------------------------------------------------------  
--  
-- Description: This procedure is used to insert a Contact   
-- ------------------------------------------------------------------------  
  
----------------------------------------------------------------------------------  
  
CREATE PROCEDURE [dbo].[OnCall_InsertTeamKeyword]  
@TeamID INTEGER,  
@Keyword VARCHAR(50)  
  
AS  
  
SET NOCOUNT ON   
--Local variables  
  
--These variables are standard variables and should be put in all the SPs.  
DECLARE @tempXML         VARCHAR(MAX)  
DECLARE @errorXML        XML  
DECLARE @errorTrackingId INT  
DECLARE @errorMessage    VARCHAR(500)  
  
BEGIN TRY  
  
 INSERT INTO [OnCallTeamKeywords]   
  ([TeamID], [Keyword], [CreateDate], [LastUpdateDate])  
     VALUES  
           (@TeamID, @Keyword, getdate(), getdate())  
  
  SELECT @@IDENTITY  
  
 INSERT INTO [OnCall].[dbo].[OnCallKeywordHistory]  
      ([Keyword], [Type], [Association], [Action], [CreateDate], [LastUpdateDate])  
  SELECT @Keyword, 'Team', t.[Name], 'Added', GETDATE(), GETDATE()  
   FROM [OnCallTeams] t  
  WHERE t.[TeamID] = @TeamID    
END TRY  
  
BEGIN CATCH  
  
   --If any transaction is not committed, rollback.  
   IF @@TRANCOUNT > 0   
      ROLLBACK TRAN  
   
   --SELECT @tempXML = dbo.fn_GetProcParameterXML(@@PROCID)  
   --SELECT @errorXML = CAST(@tempXML AS XML)  
   --EXEC dba_TrackError @@PROCID, @errorXML, @errorTrackingId OUTPUT  
  
   
   --SET @errorMessage = 'Error in executing OnCall_InsertTeamKeyword. '  
   --SET @errorMessage = @errorMessage + ' Error message is "' + ERROR_MESSAGE() + '".'  
   --SET @errorMessage = @errorMessage + 'Please look at ErrorTrackingId = ' + CAST(@errorTrackingId AS VARCHAR(10))  
   --SET @errorMessage = @errorMessage + ' in ErrorTracking table.'  
   --RAISERROR(@errorMessage, 16, 1)  
  
   RETURN  
  
END CATCH  
  
RETURN  

GO
