CREATE TABLE [dbo].[RGMigrationTest]
(
[RGMigrationTestId] [int] NOT NULL IDENTITY(1, 1),
[FirstName] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LastName] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CreateDate] [datetime] NOT NULL
) ON [OnCall_Data]
GO
ALTER TABLE [dbo].[RGMigrationTest] ADD CONSTRAINT [PK__RGMigrat__1CFE28607B9B2589] PRIMARY KEY CLUSTERED  ([RGMigrationTestId]) ON [OnCall_Data]
GO
