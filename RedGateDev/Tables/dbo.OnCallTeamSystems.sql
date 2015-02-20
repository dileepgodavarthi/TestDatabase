CREATE TABLE [dbo].[OnCallTeamSystems]
(
[TeamSystemID] [int] NOT NULL IDENTITY(1, 1),
[TeamID] [int] NOT NULL,
[SystemID] [int] NOT NULL,
[CreateDate] [datetime] NOT NULL,
[LastUpdateDate] [datetime] NOT NULL
) ON [OnCall_Data]
GO
ALTER TABLE [dbo].[OnCallTeamSystems] ADD CONSTRAINT [PK_OnCallTeamSystems] PRIMARY KEY CLUSTERED  ([TeamSystemID]) ON [OnCall_Data]
GO
CREATE UNIQUE NONCLUSTERED INDEX [UK_OnCallTeamSystems] ON [dbo].[OnCallTeamSystems] ([SystemID], [TeamID]) ON [OnCall_Index]
GO
ALTER TABLE [dbo].[OnCallTeamSystems] WITH NOCHECK ADD CONSTRAINT [FK_OnCallTeamSystems_OnCallTeamSystems] FOREIGN KEY ([SystemID]) REFERENCES [dbo].[OnCallSystems] ([SystemID])
GO
ALTER TABLE [dbo].[OnCallTeamSystems] WITH NOCHECK ADD CONSTRAINT [FK_OnCallTeamSystems_OnCallTeams] FOREIGN KEY ([TeamID]) REFERENCES [dbo].[OnCallTeams] ([TeamID])
GO
EXEC sp_bindefault N'[dbo].[dfNow]', N'[dbo].[OnCallTeamSystems].[CreateDate]'
GO
EXEC sp_bindefault N'[dbo].[dfNow]', N'[dbo].[OnCallTeamSystems].[LastUpdateDate]'
GO
