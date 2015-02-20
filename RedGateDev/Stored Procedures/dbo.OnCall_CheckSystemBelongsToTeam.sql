SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Pratima Naik>
-- Create date: <Nov 30th 2007>
-- Description:	<Checks whether a give System belongs to a team>
-- =============================================
CREATE PROCEDURE [dbo].[OnCall_CheckSystemBelongsToTeam] (
@systemId int)
AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    DECLARE @systemCount int
	DECLARE @returnedVal int
	DECLARE @teamId int

	Select @systemCount = Count(*) 
	FROM dbo.OnCallTeamSystems
	WHERE systemId=@systemId 
END

BEGIN
	if @systemCount > 0 
	BEGIN
		Select @returnedVal = A.TeamId  
		FROM dbo.OnCallTeamSystems A
		WHERE A.systemId=@systemId 

	END
	else
		SET @returnedVal = 0

	SELECT @returnedVal
END

GO
