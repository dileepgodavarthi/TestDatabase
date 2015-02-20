CREATE TABLE [dbo].[OnCallRecurrance]
(
[RecurranceID] [int] NOT NULL IDENTITY(1, 1),
[TeamID] [int] NOT NULL,
[ContactID] [int] NOT NULL,
[RoleID] [int] NOT NULL,
[StartTime] [datetime] NOT NULL,
[Duration] [int] NOT NULL,
[Type] [int] NOT NULL,
[SubType] [int] NOT NULL,
[Count] [int] NULL,
[DayMask] [int] NULL,
[CreateDate] [datetime] NOT NULL,
[LastUpdateDate] [datetime] NOT NULL
) ON [OnCall_Data]
GO
ALTER TABLE [dbo].[OnCallRecurrance] ADD CONSTRAINT [PK_Recurrance] PRIMARY KEY CLUSTERED  ([RecurranceID]) ON [OnCall_Data]
GO
ALTER TABLE [dbo].[OnCallRecurrance] WITH NOCHECK ADD CONSTRAINT [FK_Recurrance_Contacts] FOREIGN KEY ([ContactID]) REFERENCES [dbo].[OnCallContacts] ([ContactID])
GO
ALTER TABLE [dbo].[OnCallRecurrance] WITH NOCHECK ADD CONSTRAINT [FK_Recurrance_Roles] FOREIGN KEY ([RoleID]) REFERENCES [dbo].[OnCallRoles] ([RoleID])
GO
ALTER TABLE [dbo].[OnCallRecurrance] WITH NOCHECK ADD CONSTRAINT [FK_Recurrance_Teams] FOREIGN KEY ([TeamID]) REFERENCES [dbo].[OnCallTeams] ([TeamID])
GO
EXEC sp_bindefault N'[dbo].[dfNow]', N'[dbo].[OnCallRecurrance].[CreateDate]'
GO
EXEC sp_bindefault N'[dbo].[dfNow]', N'[dbo].[OnCallRecurrance].[LastUpdateDate]'
GO
