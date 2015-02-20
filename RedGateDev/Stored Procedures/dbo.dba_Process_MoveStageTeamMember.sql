SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

---------------------------step 3 ---------------------------------------
-------------------Create below SP---------------------------------------
----------------------------------------------------------------------------------
--COPYRIGHT (C) 2010 QuickenLoans Inc.
----------------------------------------------------------------------------------
--dbo.[dba_Process_MoveStageTeamMember]  STORED PROCEDURE CREATION SCRIPT
----------------------------------------------------------------------------------
--
--Revision History
--
--Date           Who    Description
-----------      ----   ----------------------------------------------------------
-- 03/04/2010  NVK    Initial
----------------------------------------------------------------------------------
--
--Stored Procedure Name:  dbo.[dba_Process_MoveStageTeamMember]
--
--Purpose

/*
EXEC dbo.[dba_Process_MoveStageTeamMember]
*/
CREATE PROCEDURE [dbo].[dba_Process_MoveStageTeamMember] 
 AS    

SET NOCOUNT ON    

-- Standard error handling variables    

DECLARE @TempXML         VARCHAR(MAX)    
DECLARE @ErrorXML        XML    
DECLARE @ErrorTrackingId INT    
DECLARE @ErrorMessage    VARCHAR(500)    
DECLARE @StartTransaction           BIT 

BEGIN TRY    

    IF @@TRANCOUNT = 0    
    BEGIN    

      BEGIN TRAN    
      SET @StartTransaction = 1    

    END 
   
------------------------------------------- 2005 version --------------------------------------------------
-------------------------------------Begin: Insert/Update Teammember data----------------------------------
	
---------Update teammember records if exists 
	UPDATE [target]
	SET
		AdjustedFirstName = source.AdjustedFirstName
			,AdjustedLastName = source.AdjustedLastName
			,AvayaAgentId= source.AvayaAgentId
			,Branch= source.Branch
			,BranchCode= source.BranchCode
			,Company= source.Company
			,EmployeeId= source.EmployeeId
			,Prefix= source.Prefix
			,FirstName= source.FirstName
			,MiddleName= source.MiddleName
			,LastName= source.LastName
			,Suffix= source.Suffix
			,Division= source.Division
			,DivisionCode= source.DivisionCode
			,DMBCommonId= source.DMBCommonId
			,EecDateInJob= source.EecDateInJob
			,EecDateOfLastHire= source.EecDateOfLastHire
			,EecDateOfSeniority= source.EecDateOfSeniority
			,EecDateOfTermination= source.EecDateOfTermination
			,EmailAddress= source.EmailAddress
			,EmployeeType= source.EmployeeType
			,EmploymentStatus= source.EmploymentStatus
			,FaxNumber= source.FaxNumber
			,FullJobTitle= source.FullJobTitle
			,Gender= source.Gender
			,GraduationDate= source.GraduationDate
			,Hireday= source.Hireday
			,IsActive= source.IsActive
			,IsApplicationAccount= source.IsApplicationAccount
			,IsBanker= source.IsBanker
			,IsLeader= source.IsLeader
			,JobCode= source.JobCode
			,JobTitle= source.JobTitle
			,LakewoodUserName= source.LakewoodUserName
			,Location= source.Location
			,ManagerCommonId= source.ManagerCommonId
			,MobilePhone= source.MobilePhone
			,NumberOfDirectReports= source.NumberOfDirectReports
			,NMLSId = source.NMLSId
			,OfficeAddress= source.OfficeAddress
			,OfficeCity= source.OfficeCity
			,OfficeState= source.OfficeState
			,OfficeZipCode= source.OfficeZipCode
			,OriginalHireDate= source.OriginalHireDate
			,Pager= source.Pager
			,PictureURL= source.PictureURL
			,PreferredLastName= source.PreferredLastName
			,PreferredFirstName= source.PreferredFirstName
			,RemoteFlag= source.RemoteFlag
			,RVPCommonId= source.RVPCommonId
			,SalaryOrHourly= source.SalaryOrHourly
			,SIPAddress= source.SIPAddress
			,SubTeam= source.SubTeam
			,SubTeamCode= source.SubTeamCode
			,Team= source.Team
			,TeamCode= source.TeamCode
			,TeamLeadersTeamLeaderCommonid= source.TeamLeadersTeamLeaderCommonid
			,TRSCommonId= source.TRSCommonId
			,WindowsUserName= source.WindowsUserName
			,WorkPhone= source.WorkPhone
			,WorkPhoneExtension= source.WorkPhoneExtension
			,IsLicensableFlag = source.IsLicensableFlag
			,LastUpdateDate= GetDate()
	FROM dbo.StageTeamMember source
	INNER JOIN TeamMember [target] ON [target].CommonId = source.CommonId
		
----------Insert teammember records if new		
	
	INSERT INTO TeamMember
	(	CommonId
		,AdjustedFirstName
		,AdjustedLastName
		,AvayaAgentId
		,Branch
		,BranchCode
		,Company
		,EmployeeId
		,Prefix
		,FirstName
		,MiddleName
		,LastName
		,Suffix
		,Division
		,DivisionCode
		,DMBCommonId
		,EecDateInJob
		,EecDateOfLastHire
		,EecDateOfSeniority
		,EecDateOfTermination
		,EmailAddress
		,EmployeeType
		,EmploymentStatus
		,FaxNumber
		,FullJobTitle
		,Gender
		,GraduationDate
		,Hireday
		,IsActive
		,IsApplicationAccount
		,IsBanker
		,IsLeader
		,JobCode
		,JobTitle
		,LakewoodUserName
		,Location
		,ManagerCommonId
		,MobilePhone
		,NumberOfDirectReports
      ,NMLSId
		,OfficeAddress
		,OfficeCity
		,OfficeState
		,OfficeZipCode
		,OriginalHireDate
		,Pager
		,PictureURL
		,PreferredLastName
		,PreferredFirstName
		,RemoteFlag
		,RVPCommonId
		,SalaryOrHourly
		,SIPAddress
		,SubTeam
		,SubTeamCode
		,Team
		,TeamCode
		,TeamLeadersTeamLeaderCommonid
		,TRSCommonId
		,WindowsUserName
		,WorkPhone
		,WorkPhoneExtension
		,IsLicensableFlag
		,CreateDate
		,LastUpdateDate
	)
	SELECT
		source.CommonId
		,source.AdjustedFirstName
		,source.AdjustedLastName
		,source.AvayaAgentId
		,source.Branch
		,source.BranchCode
		,source.Company
		,source.EmployeeId
		,source.Prefix
		,source.FirstName
		,source.MiddleName
		,source.LastName
		,source.Suffix
		,source.Division
		,source.DivisionCode
		,source.DMBCommonId
		,source.EecDateInJob
		,source.EecDateOfLastHire
		,source.EecDateOfSeniority
		,source.EecDateOfTermination
		,source.EmailAddress
		,source.EmployeeType
		,source.EmploymentStatus
		,source.FaxNumber
		,source.FullJobTitle
		,source.Gender
		,source.GraduationDate
		,source.Hireday
		,source.IsActive
		,source.IsApplicationAccount
		,source.IsBanker
		,source.IsLeader
		,source.JobCode
		,source.JobTitle
		,source.LakewoodUserName
		,source.Location
		,source.ManagerCommonId
		,source.MobilePhone
		,source.NumberOfDirectReports
      ,source.NMLSId
		,source.OfficeAddress
		,source.OfficeCity
		,source.OfficeState
		,source.OfficeZipCode
		,source.OriginalHireDate
		,source.Pager
		,source.PictureURL
		,source.PreferredLastName
		,source.PreferredFirstName
		,source.RemoteFlag
		,source.RVPCommonId
		,source.SalaryOrHourly
		,source.SIPAddress
		,source.SubTeam
		,source.SubTeamCode
		,source.Team
		,source.TeamCode
		,source.TeamLeadersTeamLeaderCommonid
		,source.TRSCommonId
		,source.WindowsUserName
		,source.WorkPhone
		,source.WorkPhoneExtension
		,source.IsLicensableFlag
		,GetDate()
		,GetDate()
	FROM StageTeamMember source
	LEFT OUTER JOIN TeamMember 
	ON  TeamMember.CommonId = source.CommonId
	WHERE TeamMember.CommonId IS NULL

----------------------------------- 2008 version ----------------------------------------------------------
  -----------------------------------Begin: Insert/Update Teammember data----------------------------------
	
	
	---using Merge
	--MERGE TeamMember AS target
	--USING StageTeamMember AS source
	--ON target.CommonId = source.CommonId
	--WHEN MATCHED THEN
	--	UPDATE SET 
	--		AdjustedFirstName = source.AdjustedFirstName
	--		,AdjustedLastName = source.AdjustedLastName
	--		,AvayaAgentId= source.AvayaAgentId
	--		,Branch= source.Branch
	--		,BranchCode= source.BranchCode
	--		,Company= source.Company
	--		,EmployeeId= source.EmployeeId
	--		,Prefix= source.Prefix
	--		,FirstName= source.FirstName
	--		,MiddleName= source.MiddleName
	--		,LastName= source.LastName
	--		,Suffix= source.Suffix
	--		,Division= source.Division
	--		,DivisionCode= source.DivisionCode
	--		,DMBCommonId= source.DMBCommonId
	--		,EecDateInJob= source.EecDateInJob
	--		,EecDateOfLastHire= source.EecDateOfLastHire
	--		,EecDateOfSeniority= source.EecDateOfSeniority
	--		,EecDateOfTermination= source.EecDateOfTermination
	--		,EmailAddress= source.EmailAddress
	--		,EmployeeType= source.EmployeeType
	--		,EmploymentStatus= source.EmploymentStatus
	--		,FaxNumber= source.FaxNumber
	--		,FullJobTitle= source.FullJobTitle
	--		,Gender= source.Gender
	--		,GraduationDate= source.GraduationDate
	--		,Hireday= source.Hireday
	--		,IsActive= source.IsActive
	--		,IsApplicationAccount= source.IsApplicationAccount
	--		,IsBanker= source.IsBanker
	--		,IsLeader= source.IsLeader
	--		,JobCode= source.JobCode
	--		,JobTitle= source.JobTitle
	--		,LakewoodUserName= source.LakewoodUserName
	--		,Location= source.Location
	--		,ManagerCommonId= source.ManagerCommonId
	--		,MobilePhone= source.MobilePhone
	--		,NumberOfDirectReports= source.NumberOfDirectReports
	--		,NMLSId = source.NMLSId
	--		,OfficeAddress= source.OfficeAddress
	--		,OfficeCity= source.OfficeCity
	--		,OfficeState= source.OfficeState
	--		,OfficeZipCode= source.OfficeZipCode
	--		,OriginalHireDate= source.OriginalHireDate
	--		,Pager= source.Pager
	--		,PictureURL= source.PictureURL
	--		,PreferredLastName= source.PreferredLastName
	--		,PreferredFirstName= source.PreferredFirstName
	--		,RemoteFlag= source.RemoteFlag
	--		,RVPCommonId= source.RVPCommonId
	--		,SalaryOrHourly= source.SalaryOrHourly
	--		,SIPAddress= source.SIPAddress
	--		,SubTeam= source.SubTeam
	--		,SubTeamCode= source.SubTeamCode
	--		,Team= source.Team
	--		,TeamCode= source.TeamCode
	--		,TeamLeadersTeamLeaderCommonid= source.TeamLeadersTeamLeaderCommonid
	--		,TRSCommonId= source.TRSCommonId
	--		,WindowsUserName= source.WindowsUserName
	--		,WorkPhone= source.WorkPhone
	--		,WorkPhoneExtension= source.WorkPhoneExtension
	--		,IsLicensableFlag = source.IsLicensableFlag
	--		,LastUpdateDate= GetDate()
	--	WHEN NOT MATCHED BY TARGET THEN				
	--		INSERT (CommonId
	--				,AdjustedFirstName
	--				,AdjustedLastName
	--				,AvayaAgentId
	--				,Branch
	--				,BranchCode
	--				,Company
	--				,EmployeeId
	--				,Prefix
	--				,FirstName
	--				,MiddleName
	--				,LastName
	--				,Suffix
	--				,Division
	--				,DivisionCode
	--				,DMBCommonId
	--				,EecDateInJob
	--				,EecDateOfLastHire
	--				,EecDateOfSeniority
	--				,EecDateOfTermination
	--				,EmailAddress
	--				,EmployeeType
	--				,EmploymentStatus
	--				,FaxNumber
	--				,FullJobTitle
	--				,Gender
	--				,GraduationDate
	--				,Hireday
	--				,IsActive
	--				,IsApplicationAccount
	--				,IsBanker
	--				,IsLeader
	--				,JobCode
	--				,JobTitle
	--				,LakewoodUserName
	--				,Location
	--				,ManagerCommonId
	--				,MobilePhone
	--				,NumberOfDirectReports
	--				,NMLSId
	--				,OfficeAddress
	--				,OfficeCity
	--				,OfficeState
	--				,OfficeZipCode
	--				,OriginalHireDate
	--				,Pager
	--				,PictureURL
	--				,PreferredLastName
	--				,PreferredFirstName
	--				,RemoteFlag
	--				,RVPCommonId
	--				,SalaryOrHourly
	--				,SIPAddress
	--				,SubTeam
	--				,SubTeamCode
	--				,Team
	--				,TeamCode
	--				,TeamLeadersTeamLeaderCommonid
	--				,TRSCommonId
	--				,WindowsUserName
	--				,WorkPhone
	--				,WorkPhoneExtension
	--				,IsLicensableFlag
	--				,CreateDate
	--				,LastUpdateDate)
	--		VALUES (source.CommonId
	--				,source.AdjustedFirstName
	--				,source.AdjustedLastName
	--				,source.AvayaAgentId
	--				,source.Branch
	--				,source.BranchCode
	--				,source.Company
	--				,source.EmployeeId
	--				,source.Prefix
	--				,source.FirstName
	--				,source.MiddleName
	--				,source.LastName
	--				,source.Suffix
	--				,source.Division
	--				,source.DivisionCode
	--				,source.DMBCommonId
	--				,source.EecDateInJob
	--				,source.EecDateOfLastHire
	--				,source.EecDateOfSeniority
	--				,source.EecDateOfTermination
	--				,source.EmailAddress
	--				,source.EmployeeType
	--				,source.EmploymentStatus
	--				,source.FaxNumber
	--				,source.FullJobTitle
	--				,source.Gender
	--				,source.GraduationDate
	--				,source.Hireday
	--				,source.IsActive
	--				,source.IsApplicationAccount
	--				,source.IsBanker
	--				,source.IsLeader
	--				,source.JobCode
	--				,source.JobTitle
	--				,source.LakewoodUserName
	--				,source.Location
	--				,source.ManagerCommonId
	--				,source.MobilePhone
	--				,source.NumberOfDirectReports
	--				,source.NMLSId
	--				,source.OfficeAddress
	--				,source.OfficeCity
	--				,source.OfficeState
	--				,source.OfficeZipCode
	--				,source.OriginalHireDate
	--				,source.Pager
	--				,source.PictureURL
	--				,source.PreferredLastName
	--				,source.PreferredFirstName
	--				,source.RemoteFlag
	--				,source.RVPCommonId
	--				,source.SalaryOrHourly
	--				,source.SIPAddress
	--				,source.SubTeam
	--				,source.SubTeamCode
	--				,source.Team
	--				,source.TeamCode
	--				,source.TeamLeadersTeamLeaderCommonid
	--				,source.TRSCommonId
	--				,source.WindowsUserName
	--				,source.WorkPhone
	--				,source.WorkPhoneExtension
	--				,source.IsLicensableFlag
	--				,GetDate()
	--				,GetDate()
	--				);

-----------------------------Add your logic to update extra fields--------------------------------
-- Enable this if you want to populate CompanyId to TeamMember table.
--	UPDATE TeamMember
--	SET TeamMember.RockCompanyId = RockCompany.RockCompanyId
--	FROM TeamMember
--	Left outer join  dbo.RockCompany on dbo.RockCompany.Name = Company
--	
-- Enable this to add TimeZones to TeamMember table (Example In LoanMod database query TeamMember table, it has this information).	
--	UPDATE TeamMember
--	SET TeamMember.Timezone = ZipLookup.TimeZone
--	FROM TeamMember
--	Left outer join  dbo.ZipLookup on  dbo.ZipLookup.Zip = SubString(OfficeZipCode, 0, 6)
	
------------------------------------End of your logic---------------------------------------------		
---------------------------------------------------------------------------------------------------								
	
  IF @StartTransaction = 1    
      COMMIT TRAN    

   RETURN    

END TRY    
BEGIN CATCH    

   IF @@TRANCOUNT > 0    
   AND @StartTransaction = 1    
      ROLLBACK TRAN    

   SELECT @TempXML = dbo.fn_GetProcParameterXML(@@PROCID)
  
   SELECT @ErrorXML = CAST(@TempXML AS XML)    
   EXEC dba_TrackError @@PROCID, @ErrorXML, @ErrorTrackingId OUTPUT    

   SET @ErrorMessage = 'Error in executing dba_Process_MoveStageTeamMember.'    
   SET @ErrorMessage = @ErrorMessage + ' Error message is "' + ERROR_MESSAGE() + '".'    
   SET @ErrorMessage = @ErrorMessage + ' Please Check --SELECT * FROM ErrorTracking WHERE ErrorTrackingId = ' + CAST(@ErrorTrackingId AS VARCHAR(10))    
   RAISERROR(@ErrorMessage, 16, 1)    

   RETURN    

END CATCH

GO
