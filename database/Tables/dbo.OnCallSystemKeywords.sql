CREATE TABLE [dbo].[OnCallSystemKeywords]
(
[SystemKeywordID] [int] NOT NULL IDENTITY(1, 1),
[SystemID] [int] NOT NULL,
[Keyword] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreateDate] [datetime] NOT NULL,
[LastUpdateDate] [datetime] NOT NULL
) ON [OnCall_Data]
GO
ALTER TABLE [dbo].[OnCallSystemKeywords] ADD CONSTRAINT [PK_OnCallSystemKeywords] PRIMARY KEY CLUSTERED  ([SystemKeywordID]) ON [OnCall_Data]
GO
ALTER TABLE [dbo].[OnCallSystemKeywords] WITH NOCHECK ADD CONSTRAINT [FK_OnCallSystemKeywords_OnCallSystems] FOREIGN KEY ([SystemID]) REFERENCES [dbo].[OnCallSystems] ([SystemID])
GO
EXEC sp_bindefault N'[dbo].[dfNow]', N'[dbo].[OnCallSystemKeywords].[CreateDate]'
GO
EXEC sp_bindefault N'[dbo].[dfNow]', N'[dbo].[OnCallSystemKeywords].[LastUpdateDate]'
GO
