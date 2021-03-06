SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- ------------------------------------------------------------------------
-- Copyright (c) 2007 QuickenLoans Inc.
-- ------------------------------------------------------------------------
-- Stored Procedure:  [OnCall_MonitorKeywords]
--
----------------------------------------------------------------------------------
--COPYRIGHT (C) 2007 Quicken Loans Inc.
----------------------------------------------------------------------------------
--[OnCall_MonitorKeywords] STORED PROCEDURE CREATION SCRIPT
----------------------------------------------------------------------------------
--
-- Revision History:
--
--  Date               Who             Description
-- ---------    -------------------  --------------------------------------
-- 11/28/2007   Pratima Naik          Initiator
-- 12/18/2007	Cong Fan			  Display team/system name in email
-- ------------------------------------------------------------------------
--
-- Description:	Monitors KeywordHistoryTable and sends out an email incase of new ones
-- ------------------------------------------------------------------------
-- Example:
-- exec OnCall_MonitorKeywords 300000
----------------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[OnCall_MonitorKeywords]
	@timeframe int = 24

AS

SET NOCOUNT ON 
--Local variables

--These variables are standard variables and should be put in all the SPs.
DECLARE @tempXML         VARCHAR(MAX)
DECLARE @errorXML        XML
DECLARE @errorTrackingId INT
DECLARE @errorMessage    VARCHAR(500)

DECLARE @emailbody VARCHAR(8000),
		@keywordList VARCHAR(5000)

BEGIN TRY

		SELECT @keywordList = COALESCE(@keywordList + CHAR(13), '') + CONVERT(CHAR(51), a.Keyword) 
							+ CASE WHEN c.Name IS NOT NULL THEN c.Name
								   WHEN e.Name IS NOT NULL THEN e.Name
								   ELSE '' 
							  END
		  FROM OnCallKeywordHistory a (nolock)
		  LEFT OUTER JOIN dbo.OnCallTeamKeywords b (nolock)
			ON a.Keyword = b.Keyword 
		  LEFT OUTER JOIN dbo.OnCallTeams c (nolock)
			ON b.TeamID = c.TeamID
		  LEFT OUTER JOIN dbo.OnCallSystemKeywords d (nolock)
			ON a.Keyword = d.Keyword
		  LEFT OUTER JOIN dbo.OnCallSystems e (nolock)
			ON d.SystemID = e.SystemID
		 WHERE a.lastUpdateDate > DATEADD(Hour, -@timeframe, GETDATE())

		IF @keywordList IS NOT NULL
		BEGIN
			SELECT @emailBody = 'The following KEYWORDS are added to OnCall database. Please contact the application owner. '+CHAR(13)+CHAR(13)+
								'Keyword' + REPLICATE(' ', 44) + 'Team/System' + CHAR(13) +
								REPLICATE('-', 50) + ' ' + REPLICATE('-', 20) + CHAR(13)+ @keywordList            
			--select @emailBody
			EXEC msdb.dbo.sp_send_dbmail
				@recipients = 'ITTeamLoansPlatform@quickenloans.com; arpadKadar@quickenloans.com',
				--@recipients = 'congfan@quickenloans.com',
				@subject = 'OnCall application: New Keywords are added',
				@body = @emailBody
		END

END TRY

BEGIN CATCH

   --If any transaction is not committed, rollback.
   IF @@TRANCOUNT > 0 
      ROLLBACK TRAN
 
--   SELECT @tempXML = dbo.fn_GetProcParameterXML(@@PROCID)
--   SELECT @errorXML = CAST(@tempXML AS XML)
--   EXEC dba_TrackError @@PROCID, @errorXML, @errorTrackingId OUTPUT

	
   SET @errorMessage = 'Error in executing OnCall_MonitorKeywords. '
   SET @errorMessage = @errorMessage + ' Error message is "' + ERROR_MESSAGE() + '".'
--   SET @errorMessage = @errorMessage + 'Please look at ErrorTrackingId = ' + CAST(@errorTrackingId AS VARCHAR(10))
--   SET @errorMessage = @errorMessage + ' in ErrorTracking table.'
   RAISERROR(@errorMessage, 16, 1)

   RETURN

END CATCH

RETURN
GO
GRANT EXECUTE ON  [dbo].[OnCall_MonitorKeywords] TO [AllAccess]
GO
