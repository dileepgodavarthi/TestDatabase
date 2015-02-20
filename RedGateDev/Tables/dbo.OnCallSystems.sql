CREATE TABLE [dbo].[OnCallSystems]
(
[SystemID] [int] NOT NULL IDENTITY(1, 1),
[SystemCode] [varchar] (35) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Name] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PrimaryTechID] [int] NULL,
[CreateDate] [datetime] NOT NULL,
[LastUpdateDate] [datetime] NOT NULL
) ON [OnCall_Data]
GO
ALTER TABLE [dbo].[OnCallSystems] ADD CONSTRAINT [PK_Systems] PRIMARY KEY CLUSTERED  ([SystemID]) ON [OnCall_Data]
GO
CREATE UNIQUE NONCLUSTERED INDEX [UK_OnCallSystems] ON [dbo].[OnCallSystems] ([Name]) ON [OnCall_Index]
GO
ALTER TABLE [dbo].[OnCallSystems] WITH NOCHECK ADD CONSTRAINT [FK_Systems_Contacts] FOREIGN KEY ([PrimaryTechID]) REFERENCES [dbo].[OnCallContacts] ([ContactID])
GO
EXEC sp_bindefault N'[dbo].[dfNow]', N'[dbo].[OnCallSystems].[CreateDate]'
GO
EXEC sp_bindefault N'[dbo].[dfNow]', N'[dbo].[OnCallSystems].[LastUpdateDate]'
GO
