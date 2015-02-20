SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- ------------------------------------------------------------------------  
-- Copyright (c) 2007 QuickenLoans Inc.  
-- ------------------------------------------------------------------------  
-- Stored Procedure:  [OnCall_InsertSystemKeyword]  
--  
----------------------------------------------------------------------------------  
--COPYRIGHT (C) 2007 Quicken Loans Inc.  
----------------------------------------------------------------------------------  
--OnCall_InsertSystemKeyword STORED PROCEDURE CREATION SCRIPT  
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
  
CREATE PROCEDURE [dbo].[OnCall_InsertSystemKeyword]  
@SystemID INTEGER,  
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
  
 INSERT INTO [OnCallSystemKeywords]   
  ([SystemID], [Keyword], [CreateDate], [LastUpdateDate])  
     VALUES  
           (@SystemID, @Keyword, getdate(), getdate())  
  
  SELECT @@IDENTITY  
  
 INSERT INTO [OnCall].[dbo].[OnCallKeywordHistory]  
      ([Keyword], [Type], [Association], [Action], [CreateDate], [LastUpdateDate])  
  SELECT @Keyword, 'System', sys.[Name], 'Added', GETDATE(), GETDATE()  
   FROM [OnCallSystems] sys  
  WHERE sys.[SystemID] = @SystemID       
  
END TRY  
  
BEGIN CATCH  
  
   --If any transaction is not committed, rollback.  
   IF @@TRANCOUNT > 0   
      ROLLBACK TRAN  
   
   --SELECT @tempXML = dbo.fn_GetProcParameterXML(@@PROCID)  
   --SELECT @errorXML = CAST(@tempXML AS XML)  
   --EXEC dba_TrackError @@PROCID, @errorXML, @errorTrackingId OUTPUT  
  
   
   --SET @errorMessage = 'Error in executing OnCall_InsertSystemKeyword. '  
   --SET @errorMessage = @errorMessage + ' Error message is "' + ERROR_MESSAGE() + '".'  
   --SET @errorMessage = @errorMessage + 'Please look at ErrorTrackingId = ' + CAST(@errorTrackingId AS VARCHAR(10))  
   --SET @errorMessage = @errorMessage + ' in ErrorTracking table.'  
   --RAISERROR(@errorMessage, 16, 1)  
  
   RETURN  
  
END CATCH  
  
RETURN  

GO
