CREATE TABLE [dbo].[ErrorTracking]
(
[ErrorTrackingId] [int] NOT NULL IDENTITY(1, 1),
[ErrorCallingProcedure] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ErrorProcedure] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ErrorNumber] [int] NOT NULL,
[ErrorSeverity] [int] NOT NULL,
[ErrorState] [int] NOT NULL,
[ErrorLine] [int] NOT NULL,
[ErrorMessage] [nvarchar] (4000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ErrorDataXML] [xml] NULL,
[ErrorUserName] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ErrorHostName] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ErrorCreateDate] [datetime] NOT NULL
) ON [OnCall_Data] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[ErrorTracking] ADD CONSTRAINT [PKC_ErrorTracking] PRIMARY KEY CLUSTERED  ([ErrorTrackingId]) ON [OnCall_Data]
GO
