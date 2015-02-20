CREATE TABLE [dbo].[OnCallTeamRoles]
(
[TeamRoleID] [int] NOT NULL IDENTITY(1, 1),
[TeamID] [int] NOT NULL,
[RoleID] [int] NOT NULL,
[AllowUnscheduled] [bit] NOT NULL,
[CreateDate] [datetime] NOT NULL,
[LastUpdateDate] [datetime] NOT NULL
) ON [OnCall_Data]
GO
ALTER TABLE [dbo].[OnCallTeamRoles] ADD CONSTRAINT [PK_TeamRoles] PRIMARY KEY CLUSTERED  ([TeamRoleID]) ON [OnCall_Data]
GO
CREATE UNIQUE NONCLUSTERED INDEX [UK_OnCallTeamRoles] ON [dbo].[OnCallTeamRoles] ([RoleID], [TeamID]) ON [OnCall_Index]
GO
ALTER TABLE [dbo].[OnCallTeamRoles] WITH NOCHECK ADD CONSTRAINT [FK_TeamRoles_Roles] FOREIGN KEY ([RoleID]) REFERENCES [dbo].[OnCallRoles] ([RoleID])
GO
ALTER TABLE [dbo].[OnCallTeamRoles] WITH NOCHECK ADD CONSTRAINT [FK_TeamRoles_Teams] FOREIGN KEY ([TeamID]) REFERENCES [dbo].[OnCallTeams] ([TeamID])
GO
EXEC sp_bindefault N'[dbo].[dfNow]', N'[dbo].[OnCallTeamRoles].[CreateDate]'
GO
EXEC sp_bindefault N'[dbo].[dfNow]', N'[dbo].[OnCallTeamRoles].[LastUpdateDate]'
GO
