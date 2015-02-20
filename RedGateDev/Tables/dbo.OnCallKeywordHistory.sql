CREATE TABLE [dbo].[OnCallKeywordHistory]
(
[KeywordHistoryID] [int] NOT NULL IDENTITY(1, 1),
[Keyword] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Type] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Association] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Action] [nchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SignOff] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CreateDate] [datetime] NOT NULL,
[LastUpdateDate] [datetime] NOT NULL
) ON [OnCall_Data]
GO
ALTER TABLE [dbo].[OnCallKeywordHistory] ADD CONSTRAINT [PK_OnCallKeywordHistory] PRIMARY KEY CLUSTERED  ([KeywordHistoryID]) ON [OnCall_Data]
GO
