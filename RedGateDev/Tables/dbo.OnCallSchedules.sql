CREATE TABLE [dbo].[OnCallSchedules]
(
[ScheduleID] [int] NOT NULL IDENTITY(1, 1),
[TeamID] [int] NOT NULL,
[StartDate] [datetime] NOT NULL,
[EndDate] [datetime] NOT NULL,
[RoleID] [int] NOT NULL,
[ContactID] [int] NOT NULL,
[RecurranceID] [int] NULL,
[CreateDate] [datetime] NOT NULL,
[LastUpdateDate] [datetime] NOT NULL
) ON [OnCall_Data]
GO
ALTER TABLE [dbo].[OnCallSchedules] ADD CONSTRAINT [PK_Schedules] PRIMARY KEY CLUSTERED  ([ScheduleID]) ON [OnCall_Data]
GO
ALTER TABLE [dbo].[OnCallSchedules] WITH NOCHECK ADD CONSTRAINT [FK_Schedules_Contacts] FOREIGN KEY ([ContactID]) REFERENCES [dbo].[OnCallContacts] ([ContactID])
GO
ALTER TABLE [dbo].[OnCallSchedules] WITH NOCHECK ADD CONSTRAINT [FK_Schedules_Recurrance] FOREIGN KEY ([RecurranceID]) REFERENCES [dbo].[OnCallRecurrance] ([RecurranceID])
GO
ALTER TABLE [dbo].[OnCallSchedules] WITH NOCHECK ADD CONSTRAINT [FK_Schedules_Roles] FOREIGN KEY ([RoleID]) REFERENCES [dbo].[OnCallRoles] ([RoleID])
GO
ALTER TABLE [dbo].[OnCallSchedules] WITH NOCHECK ADD CONSTRAINT [FK_Schedules_Teams] FOREIGN KEY ([TeamID]) REFERENCES [dbo].[OnCallTeams] ([TeamID])
GO
EXEC sp_bindefault N'[dbo].[dfNow]', N'[dbo].[OnCallSchedules].[CreateDate]'
GO
EXEC sp_bindefault N'[dbo].[dfNow]', N'[dbo].[OnCallSchedules].[LastUpdateDate]'
GO
