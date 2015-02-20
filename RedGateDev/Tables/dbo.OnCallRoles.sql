CREATE TABLE [dbo].[OnCallRoles]
(
[RoleID] [int] NOT NULL IDENTITY(1, 1),
[RoleCode] [varchar] (35) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Role] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreateDate] [datetime] NOT NULL,
[LastUpdateDate] [datetime] NOT NULL
) ON [OnCall_Data]
GO
ALTER TABLE [dbo].[OnCallRoles] ADD CONSTRAINT [PK_OnCallTypes] PRIMARY KEY CLUSTERED  ([RoleID]) ON [OnCall_Data]
GO
EXEC sp_bindefault N'[dbo].[dfNow]', N'[dbo].[OnCallRoles].[CreateDate]'
GO
EXEC sp_bindefault N'[dbo].[dfNow]', N'[dbo].[OnCallRoles].[LastUpdateDate]'
GO
