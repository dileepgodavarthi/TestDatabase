CREATE TABLE [dbo].[TeamMember]
(
[CommonId] [int] NOT NULL,
[AdjustedFirstName] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AdjustedLastName] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AvayaAgentId] [int] NULL,
[Branch] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BranchCode] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Company] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EmployeeId] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Prefix] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FirstName] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MiddleName] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LastName] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Suffix] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Division] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DivisionCode] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DMBCommonId] [int] NULL,
[EecDateInJob] [datetime] NULL,
[EecDateOfLastHire] [datetime] NULL,
[EecDateOfSeniority] [datetime] NULL,
[EecDateOfTermination] [datetime] NULL,
[EmailAddress] [varchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EmployeeType] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EmploymentStatus] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FaxNumber] [bigint] NULL,
[FullJobTitle] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Gender] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[GraduationDate] [datetime] NULL,
[Hireday] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsActive] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsApplicationAccount] [bit] NULL,
[IsBanker] [tinyint] NOT NULL,
[IsLeader] [bit] NULL,
[JobCode] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[JobTitle] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LakewoodUserName] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Location] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ManagerCommonId] [bigint] NULL,
[MobilePhone] [bigint] NULL,
[NumberOfDirectReports] [int] NULL,
[NMLSId] [int] NULL,
[OfficeAddress] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[OfficeCity] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[OfficeState] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[OfficeZipCode] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[OriginalHireDate] [datetime] NULL,
[Pager] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PictureURL] [varchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PreferredLastName] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PreferredFirstName] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RemoteFlag] [bit] NOT NULL,
[RVPCommonId] [int] NULL,
[SalaryOrHourly] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SIPAddress] [varchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SubTeam] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SubTeamCode] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Team] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TeamCode] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TeamLeadersTeamLeaderCommonid] [int] NULL,
[TRSCommonId] [int] NULL,
[WindowsUserName] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[WorkPhone] [bigint] NULL,
[WorkPhoneExtension] [int] NULL,
[IsLicensableFlag] [bit] NULL,
[CreateDate] [datetime] NOT NULL,
[LastUpdateDate] [datetime] NOT NULL
) ON [OnCall_Data]
GO
ALTER TABLE [dbo].[TeamMember] ADD CONSTRAINT [PK_TeamMember] PRIMARY KEY CLUSTERED  ([CommonId]) ON [OnCall_Data]
GO
EXEC sp_bindefault N'[dbo].[dfNow]', N'[dbo].[TeamMember].[CreateDate]'
GO
EXEC sp_bindefault N'[dbo].[dfNow]', N'[dbo].[TeamMember].[LastUpdateDate]'
GO
GRANT SELECT ON  [dbo].[TeamMember] TO [OnCall]
GRANT INSERT ON  [dbo].[TeamMember] TO [OnCall]
GRANT UPDATE ON  [dbo].[TeamMember] TO [OnCall]
GO
