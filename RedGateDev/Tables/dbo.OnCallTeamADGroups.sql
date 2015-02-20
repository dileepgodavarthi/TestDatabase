CREATE TABLE [dbo].[OnCallTeamADGroups]
(
[TeamADGroupID] [int] NOT NULL IDENTITY(1, 1),
[TeamID] [int] NOT NULL,
[ADGroup] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreateDate] [datetime] NOT NULL,
[LastUpdateDate] [datetime] NOT NULL
) ON [OnCall_Data]
GO
ALTER TABLE [dbo].[OnCallTeamADGroups] ADD CONSTRAINT [PK_TeamADGroups] PRIMARY KEY CLUSTERED  ([TeamADGroupID]) ON [OnCall_Data]
GO
ALTER TABLE [dbo].[OnCallTeamADGroups] WITH NOCHECK ADD CONSTRAINT [FK_TeamADGroups_Teams] FOREIGN KEY ([TeamID]) REFERENCES [dbo].[OnCallTeams] ([TeamID])
GO
EXEC sp_bindefault N'[dbo].[dfNow]', N'[dbo].[OnCallTeamADGroups].[CreateDate]'
GO
EXEC sp_bindefault N'[dbo].[dfNow]', N'[dbo].[OnCallTeamADGroups].[LastUpdateDate]'
GO
