SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE TRIGGER [trg_DDLAuditLog]
 ON DATABASE 
   FOR DDL_DATABASE_LEVEL_EVENTS 
AS

DECLARE @data         XML
DECLARE @emailbody    NVARCHAR(MAX)
DECLARE @emailsubject VARCHAR(200)

SET @data = EVENTDATA()

IF (@data.value('(/EVENT_INSTANCE/EventType)[1]', 'NVARCHAR(200)') <> N'ALTER_QUEUE'
AND @data.value('(/EVENT_INSTANCE/EventType)[1]', 'NVARCHAR(200)') <> N'CREATE_STATISTICS'
AND @data.value('(/EVENT_INSTANCE/EventType)[1]', 'NVARCHAR(200)') <> N'UPDATE_STATISTICS')

BEGIN

   INSERT INTO DDLAuditLog (
          DBUser, 
          Event, 
          TSQL) 
   VALUES (
        @data.value('(/EVENT_INSTANCE/LoginName)[1]', 'NVARCHAR(128)'), 
          @data.value('(/EVENT_INSTANCE/EventType)[1]', 'NVARCHAR(200)'), 
          @data.value('(/EVENT_INSTANCE/TSQLCommand)[1]', 'NVARCHAR(MAX)')) ;

  

END
GO
