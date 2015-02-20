CREATE TABLE [dbo].[OnCallContacts]
(
[ContactID] [int] NOT NULL IDENTITY(1, 1),
[FirstName] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LastName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Email] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[WorkPhone] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CellPhone] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[HomePhone] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PreferredContactType] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Username] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CreateDate] [datetime] NOT NULL,
[LastUpdateDate] [datetime] NOT NULL,
[StartTime] [datetime] NULL,
[EndTime] [datetime] NULL,
[OffHoursPreferredContactType] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[OnCallAdmin] [bit] NULL,
[Pager] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [OnCall_Data]
GO
ALTER TABLE [dbo].[OnCallContacts] ADD CONSTRAINT [PK_Contacts] PRIMARY KEY CLUSTERED  ([ContactID]) ON [OnCall_Data]
GO
CREATE UNIQUE NONCLUSTERED INDEX [UK_OnCallContacts] ON [dbo].[OnCallContacts] ([Username]) ON [OnCall_Index]
GO
EXEC sp_bindefault N'[dbo].[dfNow]', N'[dbo].[OnCallContacts].[CreateDate]'
GO
EXEC sp_bindefault N'[dbo].[dfNow]', N'[dbo].[OnCallContacts].[LastUpdateDate]'
GO
