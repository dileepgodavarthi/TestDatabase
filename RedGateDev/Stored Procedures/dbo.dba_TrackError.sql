SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----------------------------------------------------------------------------------
--COPYRIGHT (C) 2006 QUICKENLOANS INC.
----------------------------------------------------------------------------------
--dba_TrackError STORED PROCEDURE CREATION SCRIPT
----------------------------------------------------------------------------------
--
--Revision History
--
--Date           Who    Description
-----------      ----   -------------------------------------------------------
--24 Jul 06      RL     Initiator
---------------------------------------------------------------------------------
--
--Stored Procedure Name:  dba_TrackError
--
--Purpose
----------------------------------------------------------------------------------
--This will insert error record in table "ErrorTracking" whenever there is any
--error from any stored procedures.
----------------------------------------------------------------------------------

/*
DECLARE @errorTrackingId INT

EXEC dba_TrackError 123, 
'<StoredProcedureParameterXML>
  <StoredProcedureName>blah</StoredProcedureName>
  <StoredProcedureParameters>
    <inXML>
      <Candidate>
        <CandidateContactInfo>
          <CandidateId>0</CandidateId>
          <AuthenticationId>12345</AuthenticationId>
          <Prefix>Mr</Prefix>
          <FirstName>Rajeev</FirstName>
          <MiddleName>T</MiddleName>
          <LastName>Lahoty</LastName>
          <Suffix>Sr</Suffix>
          <PreferName>Raj</PreferName>
          <CandidateType>External</CandidateType>
          <CollegeName>CMU</CollegeName>
          <DOB>2005-01-01 00:00:00.000</DOB>
          <EmploymentType>Full Time</EmploymentType>
          <Ethnicity>Asian</Ethnicity>
          <Gender>M</Gender>
          <HighestEducationLevel>Graduation</HighestEducationLevel>
          <IsLead>1</IsLead>
          <SendNotification>1</SendNotification>
          <SourceId>28</SourceId>
          <SystemSourceId>1</SystemSourceId>
          <SSN>123-45-6789</SSN>
          <CreatorId>10</CreatorId>
          <LastModifiedById>10</LastModifiedById>
        </CandidateContactInfo>
      </Candidate>
    </inXML>
  </StoredProcedureParameters>
</StoredProcedureParameterXML>, @errorTrackingId OUTPUT

SELECT @errorTrackingId

*/

CREATE PROCEDURE [dbo].[dba_TrackError] (
   @errorCallingProcedureId INT,
   @errorDataXML            XML,
   @errorTrackingId         INT OUTPUT)
AS

SET NOCOUNT ON

INSERT INTO ErrorTracking (
       ErrorCallingProcedure,
       ErrorProcedure,
       ErrorNumber,
       ErrorSeverity,
       ErrorState,
       ErrorLine,
       ErrorMessage,
       ErrorDataXML,
       ErrorUserName,
       ErrorHostName)
VALUES (OBJECT_NAME(@errorCallingProcedureId),
       ERROR_PROCEDURE(),
       ERROR_NUMBER(),
       ERROR_SEVERITY(),
       ERROR_STATE(),
       ERROR_LINE(),
       ERROR_MESSAGE(),
       @errorDataXML,
       SUSER_SNAME(),
       HOST_NAME())

SELECT @errorTrackingId = SCOPE_IDENTITY()

RETURN



GO
