CREATE TABLE [dbo].[AuditTeamContacts]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[TeamId] [int] NULL,
[ContactId] [int] NULL,
[StoredProcedureName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AddedBy] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CreateDate] [datetime] NULL
) ON [OnCall_Data]
GO
ALTER TABLE [dbo].[AuditTeamContacts] ADD CONSTRAINT [PK__AuditTeamContact__65370702] PRIMARY KEY CLUSTERED  ([ID]) ON [OnCall_Data]
GO
