CREATE TABLE [dbo].[Teams]
(
[TeamID] [int] NOT NULL IDENTITY(1, 1),
[Name] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[OnCallEmail] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[OnCallNumber] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TeamEmail] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CreateDate] [datetime] NOT NULL,
[LastUpdateDate] [datetime] NOT NULL,
[OnCallExternalNumber] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EmailDefault] [bit] NULL,
[TeamLeader] [int] NULL
) ON [OnCall_Data]
GO
ALTER TABLE [dbo].[Teams] ADD CONSTRAINT [PK_Teams1] PRIMARY KEY CLUSTERED  ([TeamID]) ON [OnCall_Data]
GO
ALTER TABLE [dbo].[Teams] ADD CONSTRAINT [FK_Teams_TeamMember] FOREIGN KEY ([TeamLeader]) REFERENCES [dbo].[TeamMember] ([CommonId])
GO
