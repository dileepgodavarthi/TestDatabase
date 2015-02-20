SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[dba_CSAGetOncallSchedule]
AS


DECLARE @StartDate DATETIME
DECLARE @EndDate DATETIME
SET @StartDate = GETDATE()
SET @EndDate = DATEADD(dd,2,@StartDate)


SELECT 
	con.[LastName] + ', ' + con.[FirstName] AS TeamMember, 
	con.[Email],
	con.[WorkPhone], 
	NULLIF(con.[CellPhone],'N/A') AS CellPhone,
	tm.[Name],
	sch.[StartDate], 
	sch.[EndDate], 
	NULLIF(tm.OnCallEmail,'') AS TeamEmail,
	CASE 
		WHEN LEN(NULLIF(tm.OnCallNumber,'')) = 5 THEN '(734) 80' + LEFT(NULLIF(tm.OnCallNumber,''),1) + '-' + RIGHT(NULLIF(tm.OnCallNumber,''),4)
		ELSE NULLIF(
			'(' + 
			LEFT(REPLACE(REPLACE(REPLACE(REPLACE(tm.OnCallNumber,'-',''),'(',''),')',''),'.',''),3) + ') ' + 
			SUBSTRING(REPLACE(REPLACE(REPLACE(REPLACE(tm.OnCallNumber,'-',''),'(',''),')',''),'.',''),4,3) + '-' +
			RIGHT(REPLACE(REPLACE(REPLACE(REPLACE(tm.OnCallNumber,'-',''),'(',''),')',''),'.',''),4)
			,'() -')
	END AS TeamPhone, 
	rol.[Role]
FROM [OnCallSchedules] sch
INNER JOIN [OnCallContacts] con 
	ON sch.[ContactID] = con.[ContactID]
INNER JOIN [OnCallRoles] rol 
	ON sch.[RoleID] = rol.[RoleID]
INNER JOIN [OnCallTeams] tm 
	ON sch.[TeamID] = tm.[TeamID]
WHERE
(@StartDate BETWEEN sch.[StartDate] AND sch.[EndDate] OR
 @EndDate BETWEEN sch.[StartDate] AND sch.[EndDate]) 
ORDER BY tm.[Name],rol.[Role],sch.[StartDate]
			 

GO
