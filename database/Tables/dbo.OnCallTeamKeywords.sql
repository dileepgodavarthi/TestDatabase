CREATE TABLE [dbo].[OnCallTeamKeywords]
(
[TeamKeywordID] [int] NOT NULL IDENTITY(1, 1),
[TeamID] [int] NOT NULL,
[Keyword] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreateDate] [datetime] NOT NULL,
[LastUpdateDate] [datetime] NOT NULL
) ON [OnCall_Data]
GO
ALTER TABLE [dbo].[OnCallTeamKeywords] ADD CONSTRAINT [PK_OnCallTeamKeywords] PRIMARY KEY CLUSTERED  ([TeamKeywordID]) ON [OnCall_Data]
GO
ALTER TABLE [dbo].[OnCallTeamKeywords] WITH NOCHECK ADD CONSTRAINT [FK_OnCallTeamKeywords_OnCallTeams] FOREIGN KEY ([TeamID]) REFERENCES [dbo].[OnCallTeams] ([TeamID])
GO
