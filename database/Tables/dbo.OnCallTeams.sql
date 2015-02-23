CREATE TABLE [dbo].[OnCallTeams]
(
[TeamID] [int] NOT NULL IDENTITY(1, 1),
[TeamCode] [varchar] (35) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Name] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[OnCallEmail] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[OnCallNumber] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AlternateContact1] [int] NULL,
[AlternateContact2] [int] NULL,
[AlternateContact3] [int] NULL,
[PrimaryRole] [int] NULL,
[Hidden] [bit] NOT NULL,
[CreateDate] [datetime] NOT NULL,
[LastUpdateDate] [datetime] NOT NULL,
[OnCallExternalNumber] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EmailDefault] [bit] NULL,
[TeamLeader] [int] NULL,
[EmailReminderText] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [OnCall_Data] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[OnCallTeams] ADD CONSTRAINT [PK_Teams] PRIMARY KEY CLUSTERED  ([TeamID]) ON [OnCall_Data]
GO
CREATE UNIQUE NONCLUSTERED INDEX [UK_OnCallTeams] ON [dbo].[OnCallTeams] ([Name]) ON [OnCall_Index]
GO
ALTER TABLE [dbo].[OnCallTeams] WITH NOCHECK ADD CONSTRAINT [FK_Teams_AltContact1] FOREIGN KEY ([AlternateContact1]) REFERENCES [dbo].[OnCallContacts] ([ContactID])
GO
ALTER TABLE [dbo].[OnCallTeams] WITH NOCHECK ADD CONSTRAINT [FK_Teams_AltContact2] FOREIGN KEY ([AlternateContact2]) REFERENCES [dbo].[OnCallContacts] ([ContactID])
GO
ALTER TABLE [dbo].[OnCallTeams] WITH NOCHECK ADD CONSTRAINT [FK_Teams_AltContact3] FOREIGN KEY ([AlternateContact3]) REFERENCES [dbo].[OnCallContacts] ([ContactID])
GO
ALTER TABLE [dbo].[OnCallTeams] WITH NOCHECK ADD CONSTRAINT [FK_Teams_Roles] FOREIGN KEY ([PrimaryRole]) REFERENCES [dbo].[OnCallRoles] ([RoleID])
GO
ALTER TABLE [dbo].[OnCallTeams] WITH NOCHECK ADD CONSTRAINT [FK_Teams_TeamLeader] FOREIGN KEY ([TeamLeader]) REFERENCES [dbo].[OnCallContacts] ([ContactID])
GO
