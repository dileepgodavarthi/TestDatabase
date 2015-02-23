CREATE TABLE [dbo].[RGTest]
(
[RGTestId] [int] NOT NULL IDENTITY(1, 1),
[FirstName] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LastName] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [OnCall_Data]
GO
ALTER TABLE [dbo].[RGTest] ADD CONSTRAINT [PK__RGTest__A55BEC485D96A726] PRIMARY KEY CLUSTERED  ([RGTestId]) ON [OnCall_Data]
GO
