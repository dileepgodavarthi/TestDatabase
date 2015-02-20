CREATE TABLE [dbo].[OnCallTeamContacts]
(
[TeamContactID] [int] NOT NULL IDENTITY(1, 1),
[TeamID] [int] NOT NULL,
[ContactID] [int] NOT NULL,
[IsLeader] [bit] NOT NULL CONSTRAINT [DF_OnCallTeamContacts_IsLeader] DEFAULT ((0)),
[CreateDate] [datetime] NOT NULL,
[LastUpdateDate] [datetime] NOT NULL
) ON [OnCall_Data]
GO
ALTER TABLE [dbo].[OnCallTeamContacts] ADD CONSTRAINT [PK_OnCallTeamContacts] PRIMARY KEY CLUSTERED  ([TeamContactID]) ON [OnCall_Data]
GO
CREATE NONCLUSTERED INDEX [IX_OnCallTeamContacts] ON [dbo].[OnCallTeamContacts] ([TeamContactID]) ON [OnCall_Index]
GO
CREATE UNIQUE NONCLUSTERED INDEX [UK_OnCallTeamContacts] ON [dbo].[OnCallTeamContacts] ([TeamID], [ContactID]) ON [OnCall_Index]
GO
ALTER TABLE [dbo].[OnCallTeamContacts] WITH NOCHECK ADD CONSTRAINT [FK_OnCallTeamContacts_OnCallContacts] FOREIGN KEY ([ContactID]) REFERENCES [dbo].[OnCallContacts] ([ContactID])
GO
ALTER TABLE [dbo].[OnCallTeamContacts] WITH NOCHECK ADD CONSTRAINT [FK_OnCallTeamContacts_OnCallTeams] FOREIGN KEY ([TeamID]) REFERENCES [dbo].[OnCallTeams] ([TeamID])
GO
EXEC sp_bindefault N'[dbo].[dfNow]', N'[dbo].[OnCallTeamContacts].[CreateDate]'
GO
EXEC sp_bindefault N'[dbo].[dfNow]', N'[dbo].[OnCallTeamContacts].[LastUpdateDate]'
GO
