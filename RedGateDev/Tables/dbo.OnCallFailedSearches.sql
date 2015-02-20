CREATE TABLE [dbo].[OnCallFailedSearches]
(
[FailedSearchID] [int] NOT NULL IDENTITY(1, 1),
[FailedSearchTerm] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CreateDate] [datetime] NOT NULL,
[LastUpdateDate] [datetime] NOT NULL
) ON [OnCall_Data]
GO
ALTER TABLE [dbo].[OnCallFailedSearches] ADD CONSTRAINT [PK_OnCallFailedSearches] PRIMARY KEY CLUSTERED  ([FailedSearchID]) ON [OnCall_Data]
GO
