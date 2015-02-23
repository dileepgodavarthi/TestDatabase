CREATE TABLE [dbo].[RGDev2]
(
[RGTestId] [int] NOT NULL IDENTITY(1, 1),
[FirstName] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LastName] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [OnCall_Data]
GO
ALTER TABLE [dbo].[RGDev2] ADD CONSTRAINT [PK__RGDev2__A55BEC48DEEA6599] PRIMARY KEY CLUSTERED  ([RGTestId]) ON [OnCall_Data]
GO
