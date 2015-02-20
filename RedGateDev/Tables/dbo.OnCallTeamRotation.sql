CREATE TABLE [dbo].[OnCallTeamRotation]
(
[TeamRotationID] [int] NOT NULL IDENTITY(1, 1),
[TeamID] [int] NOT NULL,
[RoleID] [int] NOT NULL,
[ContactID] [int] NOT NULL,
[RotationOrder] [int] NOT NULL,
[InRotation] [bit] NOT NULL,
[CreateDate] [datetime] NOT NULL,
[LastUpdateDate] [datetime] NOT NULL
) ON [OnCall_Data]
GO
ALTER TABLE [dbo].[OnCallTeamRotation] ADD CONSTRAINT [PK_OnCallTeamRotation] PRIMARY KEY CLUSTERED  ([TeamRotationID]) ON [OnCall_Data]
GO
ALTER TABLE [dbo].[OnCallTeamRotation] WITH NOCHECK ADD CONSTRAINT [FK_OnCallTeamRotation_OnCallContacts] FOREIGN KEY ([ContactID]) REFERENCES [dbo].[OnCallContacts] ([ContactID])
GO
ALTER TABLE [dbo].[OnCallTeamRotation] WITH NOCHECK ADD CONSTRAINT [FK_OnCallTeamRotation_OnCallRoles] FOREIGN KEY ([RoleID]) REFERENCES [dbo].[OnCallRoles] ([RoleID])
GO
ALTER TABLE [dbo].[OnCallTeamRotation] WITH NOCHECK ADD CONSTRAINT [FK_OnCallTeamRotation_OnCallTeams] FOREIGN KEY ([TeamID]) REFERENCES [dbo].[OnCallTeams] ([TeamID])
GO
