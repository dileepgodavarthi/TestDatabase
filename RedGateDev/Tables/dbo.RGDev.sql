CREATE TABLE [dbo].[RGDev]
(
[RGTestId] [int] NOT NULL IDENTITY(1, 1),
[FirstName] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[LastName] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CommonID] [int] NOT NULL,
[Address] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [OnCall_Data]
GO
ALTER TABLE [dbo].[RGDev] ADD CONSTRAINT [PK__RGDev__A55BEC48E682C496] PRIMARY KEY CLUSTERED  ([RGTestId]) ON [OnCall_Data]
GO
