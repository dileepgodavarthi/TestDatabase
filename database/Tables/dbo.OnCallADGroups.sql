CREATE TABLE [dbo].[OnCallADGroups]
(
[ADGroupID] [int] NOT NULL IDENTITY(1, 1),
[ADTeam] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ADSubTeam] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TeamID] [int] NULL,
[CreateDate] [datetime] NOT NULL
) ON [OnCall_Data]
GO
ALTER TABLE [dbo].[OnCallADGroups] ADD CONSTRAINT [PK_OnCallADGroups] PRIMARY KEY CLUSTERED  ([ADGroupID]) ON [OnCall_Data]
GO
ALTER TABLE [dbo].[OnCallADGroups] WITH NOCHECK ADD CONSTRAINT [FK_OnCallADGroups_OnCallTeams] FOREIGN KEY ([TeamID]) REFERENCES [dbo].[OnCallTeams] ([TeamID])
GO
EXEC sp_bindefault N'[dbo].[dfNow]', N'[dbo].[OnCallADGroups].[CreateDate]'
GO
