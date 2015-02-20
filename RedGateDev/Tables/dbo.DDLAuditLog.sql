CREATE TABLE [dbo].[DDLAuditLog]
(
[DDLAuditLogId] [int] NOT NULL IDENTITY(1, 1),
[DBUser] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Event] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TSQL] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LogDate] [datetime] NOT NULL
) ON [OnCall_Data] TEXTIMAGE_ON [OnCall_Data]
GO
ALTER TABLE [dbo].[DDLAuditLog] ADD CONSTRAINT [PKC_DDLAuditLog] PRIMARY KEY CLUSTERED  ([DDLAuditLogId]) WITH (FILLFACTOR=90) ON [OnCall_Data]
GO
EXEC sp_bindefault N'[dbo].[dfNow]', N'[dbo].[DDLAuditLog].[LogDate]'
GO
