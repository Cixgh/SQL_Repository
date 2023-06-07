-- More SP's and views

USE sportLeagues;
GO

----------------------------------- Task 1 ------------------------------------------------------------------------------

-- dbo.games TABLE
-- INSERT SP

CREATE OR ALTER PROCEDURE spGamesInsert
	   --@gameid int,
       @divid int,
       @Gamenum int,
       @gamedatetime date,
       @hometeam int,
	   @homescore int,
	   @visitteam int,
	   @visitscore int,
	   @locationid int,
	   @Isplayed int,
	   @notes nvarchar(50)
AS
BEGIN TRY
BEGIN

       INSERT INTO games
              (divid, Gamenum, gamedatetime, hometeam, homescore, visitteam, visitscore, locationid, Isplayed, notes)
       VALUES
              (@divid, @Gamenum, @gamedatetime, @hometeam, @homescore, @visitteam, @visitscore, @locationid, @Isplayed, @notes)

	   SELECT @@IDENTITY AS AUTONUMBER;

RETURN SCOPE_IDENTITY();
END
END TRY
BEGIN CATCH
SELECT ERROR_MESSAGE() as ErrorMessage;
SELECT ERROR_NUMBER() as ErrorNumber;
END CATCH

EXECUTE spGamesInsert @divid = '28', @Gamenum = '91', @gamedatetime = '2022-05-15', @hometeam= '218', @homescore = '1',
		@visitteam = '222', @visitscore = '0', @locationid = '84', @Isplayed = '1', @notes = '' ;


--UPDATE SP

GO
CREATE OR ALTER PROCEDURE spGamesUpdate
	   @gameid int,
       @divid int,
       @Gamenum int,
       @gamedatetime date,
       @hometeam int,
	   @homescore int,
	   @visitteam int,
	   @visitscore int,
	   @locationid int,
	   @Isplayed int,
	   @notes nvarchar(50)
AS
BEGIN TRY
BEGIN

       UPDATE games
	   SET divid = @divid , 
		   Gamenum = @Gamenum,
		   gamedatetime = @gamedatetime,
		   hometeam = @hometeam,
		   homescore = @homescore,
		   visitteam = @visitteam,
		   visitscore = @visitscore,
		   locationid = @locationid,
		   Isplayed = @Isplayed,
		   notes = @notes
	   WHERE gameid = @gameid

END
END TRY
BEGIN CATCH
SELECT ERROR_MESSAGE() as ErrorMessage;
SELECT ERROR_NUMBER() as ErrorNumber;
END CATCH

EXECUTE spGamesUpdate @gameid = '71', @divid = '28', @Gamenum = '91', @gamedatetime = '2022-05-15', @hometeam= '218', @homescore = '1',
		@visitteam = '222', @visitscore = '0', @locationid = '84', @Isplayed = '1', @notes = '' ;

--DELETE SP

GO
CREATE OR ALTER PROCEDURE spGamesDelete
	   @gameid int
AS
BEGIN TRY
BEGIN

       DELETE FROM games
	   WHERE gameid = @gameid

END
END TRY
BEGIN CATCH
SELECT ERROR_MESSAGE() as ErrorMessage;
SELECT ERROR_NUMBER() as ErrorNumber;
END CATCH

EXECUTE spGamesDelete @gameid = '91';

--SELECT SP

GO
CREATE OR ALTER PROCEDURE spGamesSelect
	   @gameid int
AS
BEGIN TRY
BEGIN

       SELECT * FROM games
	   WHERE gameid = @gameid

END
END TRY
BEGIN CATCH
SELECT ERROR_MESSAGE() as ErrorMessage;
SELECT ERROR_NUMBER() as ErrorNumber;
END CATCH

EXECUTE spGamesSelect @gameid = '1';

-- dbo.goalscorers TABLE
-- INSERT SP

GO
CREATE OR ALTER PROCEDURE spGoalscorersInsert
       @gameid int,
       @playerid int,
       @teamid int,
	   @numgoals int,
	   @numassists int
AS
BEGIN TRY
BEGIN

       INSERT INTO goalScorers
              (gameid, playerid, teamid, numgoals, numassists)
       VALUES
              (@gameid, @playerid, @teamid, @numgoals, @numassists)

	   SELECT @@IDENTITY AS PK_AUTONUMBER;

END
END TRY
BEGIN CATCH
SELECT ERROR_MESSAGE() as ErrorMessage;
SELECT ERROR_NUMBER() as ErrorNumber;
END CATCH

EXECUTE spGoalscorersInsert @gameid = '89', @playerid = '2323742', @teamid = '223', @numgoals = '1', @numassists = '1' ;

-- UPDATE SP

GO
CREATE OR ALTER PROCEDURE spGoalscorersUpdate
	   @goalid int,
	   @gameid int,
       @playerid int,
       @teamid int,
	   @numgoals int,
	   @numassists int
AS
BEGIN TRY
BEGIN

       UPDATE goalScorers
	   SET gameid = @gameid , 
		   playerid = @playerid,
		   teamid = @teamid,
		   numgoals = @numgoals,
		   numassists = @numassists
	   WHERE goalid = @goalid

END
END TRY
BEGIN CATCH
SELECT ERROR_MESSAGE() as ErrorMessage;
SELECT ERROR_NUMBER() as ErrorNumber;
END CATCH

EXECUTE spGoalscorersUpdate @goalid = '252', @gameid = '89', @playerid = '2323742', @teamid = '223', @numgoals = '1', @numassists = '0';

-- DELETE SP

GO
CREATE OR ALTER PROCEDURE spGoalscorersDelete
	   @goalid int
AS
BEGIN TRY
BEGIN

       DELETE FROM goalScorers
	   WHERE goalid = @goalid

END
END TRY
BEGIN CATCH
SELECT ERROR_MESSAGE() as ErrorMessage;
SELECT ERROR_NUMBER() as ErrorNumber;
END CATCH

EXECUTE spGoalscorersDelete @goalid = '90';


--SELECT SP

GO
CREATE OR ALTER PROCEDURE spGoalscorersSelect
	   @goalid int
AS
BEGIN TRY
BEGIN

       SELECT * FROM goalScorers
	   WHERE goalid = @goalid

END
END TRY
BEGIN CATCH
SELECT ERROR_MESSAGE() as ErrorMessage;
SELECT ERROR_NUMBER() as ErrorNumber;
END CATCH

EXECUTE spGoalscorersSelect @goalid = '77';

-- dbo.players TABLE
-- INSERT SP

GO
CREATE OR ALTER PROCEDURE spPlayersInsert
       @playerid int,
       @regnumber nvarchar,
       @lastname nvarchar,
	   @firstname nvarchar,
	   @isactive int
AS
BEGIN TRY
BEGIN

       INSERT INTO players
              (playerid, regnumber, lastname, firstname, isactive)
       VALUES
              (@playerid, @regnumber, @lastname, @firstname, @isactive)

	   SELECT 'No autonumber field for Players Table' AS PK_AUTONUMBER;

END
END TRY
BEGIN CATCH
SELECT ERROR_MESSAGE() as ErrorMessage;
SELECT ERROR_NUMBER() as ErrorNumber;
END CATCH

EXECUTE spPlayersInsert @playerid = '3000000', @regnumber = '90222', @lastname = 'Kaur', @firstname = 'Harjeet', @isactive = '1' ;


-- UPDATE SP

GO
CREATE OR ALTER PROCEDURE spPlayersUpdate
	   @playerid int,
       @regnumber nvarchar,
       @lastname nvarchar,
	   @firstname nvarchar,
	   @isactive int
AS
BEGIN TRY
BEGIN

       UPDATE players
	   SET regnumber = @regnumber , 
		   lastname = @lastname,
		   firstname = @firstname,
		   isactive = @isactive
	   WHERE playerid = @playerid

END
END TRY
BEGIN CATCH
SELECT ERROR_MESSAGE() as ErrorMessage;
SELECT ERROR_NUMBER() as ErrorNumber;
END CATCH

EXECUTE spPlayersUpdate @playerid = '3000000', @regnumber = '90222', @lastname = 'Kaur', @firstname = 'Harjeet', @isactive = '1';

-- DELETE SP

GO
CREATE OR ALTER PROCEDURE spPlayersDelete
	   @playerid int
AS
BEGIN TRY
BEGIN

       DELETE FROM players
	   WHERE playerid = @playerid

END
END TRY
BEGIN CATCH
SELECT ERROR_MESSAGE() as ErrorMessage;
SELECT ERROR_NUMBER() as ErrorNumber;
END CATCH

EXECUTE spPlayersDelete @playerid = '3000000';

--SELECT SP

GO
CREATE OR ALTER PROCEDURE spPlayersSelect
	   @playerid int
AS
BEGIN TRY
BEGIN

       SELECT * FROM players
	   WHERE playerid = @playerid

END
END TRY
BEGIN CATCH
SELECT ERROR_MESSAGE() as ErrorMessage;
SELECT ERROR_NUMBER() as ErrorNumber;
END CATCH

EXECUTE spPlayersSelect @playerid = '2311402';

-- dbo.teams TABLE
-- INSERT SP

GO
CREATE OR ALTER PROCEDURE spTeamsInsert
       @teamid int,
       @teamname varchar(10),
       @isactive int,
	   @jerseycolour varchar(10)
AS
BEGIN TRY
BEGIN

       INSERT INTO teams
              (teamid, teamname, isactive, jerseycolour)
       VALUES
              (@teamid, @teamname, @isactive, @jerseycolour)

	   SELECT 'No autonumber field for Teams Table' AS PK_AUTONUMBER;

END
END TRY
BEGIN CATCH
SELECT ERROR_MESSAGE() as ErrorMessage;
SELECT ERROR_NUMBER() as ErrorNumber;
END CATCH

EXECUTE spTeamsInsert @teamid = '401', @teamname = 'Seneca FC', @isactive = '1', @jerseycolour = 'Red' ;

-- UPDATE SP

GO
CREATE OR ALTER PROCEDURE spTeamsUpdate
	   @teamid int,
       @teamname varchar(10),
       @isactive int,
	   @jerseycolour varchar(10)
AS
BEGIN TRY
BEGIN

       UPDATE teams
	   SET teamname = @teamname , 
		   isactive = @isactive,
		   jerseycolour = @jerseycolour
	   WHERE teamid = @teamid

END
END TRY
BEGIN CATCH
SELECT ERROR_MESSAGE() as ErrorMessage;
SELECT ERROR_NUMBER() as ErrorNumber;
END CATCH

EXECUTE spTeamsUpdate @teamid = '401', @teamname = 'Seneca FC', @isactive = '1', @jerseycolour = 'White';

-- DELETE SP

GO
CREATE OR ALTER PROCEDURE spTeamsDelete
	   @teamid int
AS
BEGIN TRY
BEGIN

       DELETE FROM teams
	   WHERE teamid = @teamid

END
END TRY
BEGIN CATCH
SELECT ERROR_MESSAGE() as ErrorMessage;
SELECT ERROR_NUMBER() as ErrorNumber;
END CATCH

EXECUTE spTeamsDelete @teamid = '401';

--SELECT SP

GO
CREATE OR ALTER PROCEDURE spTeamsSelect
	   @teamid int
AS
BEGIN TRY
BEGIN

       SELECT * FROM teams
	   WHERE teamid = @teamid

END
END TRY
BEGIN CATCH
SELECT ERROR_MESSAGE() as ErrorMessage;
SELECT ERROR_NUMBER() as ErrorNumber;
END CATCH

EXECUTE spTeamsSelect @teamid = '400';

-- dbo.rosters TABLE
-- INSERT SP

GO
CREATE OR ALTER PROCEDURE spRostersInsert
       @playerid int,
       @teamid int,
       @isactive int,
	   @jerseynumber int
AS
BEGIN TRY
BEGIN

       INSERT INTO rosters
              (playerid, teamid, isactive, jerseynumber)
       VALUES
              (@playerid, @teamid, @isactive, @jerseynumber)

	   SELECT @@IDENTITY AS PK_AUTONUMBER;

END
END TRY
BEGIN CATCH
SELECT ERROR_MESSAGE() as ErrorMessage;
SELECT ERROR_NUMBER() as ErrorNumber;
END CATCH

EXECUTE spRostersInsert @playerid = '2323799', @teamid = '400', @isactive = '1', @jerseynumber = '7' ;

-- UPDATE SP

GO
CREATE OR ALTER PROCEDURE spRostersUpdate
	   @playerid int,
       @teamid int,
       @isactive int,
	   @jerseynumber int,
	   @rosterid int
AS
BEGIN TRY
BEGIN

       UPDATE rosters
	   SET playerid = @playerid ,
	       teamid = @teamid,
		   isactive = @isactive,
		   jerseynumber = @jerseynumber
	   WHERE rosterid = @rosterid

END
END TRY
BEGIN CATCH
SELECT ERROR_MESSAGE() as ErrorMessage;
SELECT ERROR_NUMBER() as ErrorNumber;
END CATCH

EXECUTE spRostersUpdate @rosterid = '231', @playerid = '2323899', @teamid = '400', @isactive = '1', @jerseynumber = '8';


-- DELETE SP

GO
CREATE OR ALTER PROCEDURE spRostersDelete
	   @rosterid int
AS
BEGIN TRY
BEGIN

       DELETE FROM rosters
	   WHERE rosterid = @rosterid

END
END TRY
BEGIN CATCH
SELECT ERROR_MESSAGE() as ErrorMessage;
SELECT ERROR_NUMBER() as ErrorNumber;
END CATCH

EXECUTE spRostersDelete @rosterid = '231';


--SELECT SP

GO
CREATE OR ALTER PROCEDURE spRostersSelect
	   @rosterid int
AS
BEGIN TRY
BEGIN

       SELECT * FROM rosters
	   WHERE rosterid = @rosterid

END
END TRY
BEGIN CATCH
SELECT ERROR_MESSAGE() as ErrorMessage;
SELECT ERROR_NUMBER() as ErrorNumber;
END CATCH

EXECUTE spRostersSelect @rosterid = '230';

-- dbo.slLocations TABLE
-- INSERT SP

GO
CREATE OR ALTER PROCEDURE spslLocationsInsert
       @locationid int,
       @locationname nvarchar(50),
       @fieldlength int,
	   @isactive int
AS
BEGIN TRY
BEGIN

       INSERT INTO slLocations
              (locationid, locationname, fieldlength, isactive)
       VALUES
              (@locationid, @locationname, @fieldlength, @isactive)

	   SELECT 'No autonumber field for Teams Table' AS PK_AUTONUMBER;

END
END TRY
BEGIN CATCH
SELECT ERROR_MESSAGE() as ErrorMessage;
SELECT ERROR_NUMBER() as ErrorNumber;
END CATCH

EXECUTE spslLocationsInsert @locationid = '90', @locationname = 'Central Park', @fieldlength = '110', @isactive = '1' ;


-- UPDATE SP

GO
CREATE OR ALTER PROCEDURE spslLocationsUpdate
	   @locationid int,
       @locationname nvarchar(50),
       @fieldlength int,
	   @isactive int
AS
BEGIN TRY
BEGIN

       UPDATE slLocations
	   SET locationname = @locationname ,
	       fieldlength = @fieldlength,
		   isactive = @isactive
	   WHERE locationid = @locationid

END
END TRY
BEGIN CATCH
SELECT ERROR_MESSAGE() as ErrorMessage;
SELECT ERROR_NUMBER() as ErrorNumber;
END CATCH

EXECUTE spslLocationsUpdate @locationid = '90', @locationname = 'Eastern Park', @fieldlength = '110', @isactive = '1';

-- DELETE SP

GO
CREATE OR ALTER PROCEDURE spslLocationsDelete
	   @locationid int
AS
BEGIN TRY
BEGIN

       DELETE FROM slLocations
	   WHERE locationid = @locationid

END
END TRY
BEGIN CATCH
SELECT ERROR_MESSAGE() as ErrorMessage;
SELECT ERROR_NUMBER() as ErrorNumber;
END CATCH

EXECUTE spslLocationsDelete @locationid = '90';

--SELECT SP

GO
CREATE OR ALTER PROCEDURE spslLocationsSelect
	   @locationid int
AS
BEGIN TRY
BEGIN

       SELECT * FROM slLocations
	   WHERE locationid = @locationid

END
END TRY
BEGIN CATCH
SELECT ERROR_MESSAGE() as ErrorMessage;
SELECT ERROR_NUMBER() as ErrorNumber;
END CATCH

EXECUTE spslLocationsSelect @locationid = '11';

-----------------------------------------END OF TASK 1-------------------------------------------

-----------------------------------------TASK 2--------------------------------------------------

-----------------------------------Games table output--------------------------------------------

GO
CREATE OR ALTER PROCEDURE spGamesOutput
AS
BEGIN TRY
BEGIN
---Initialize variables to hold table data------
DECLARE @gameid int;
DECLARE @divid int;
DECLARE @gamenum int;
DECLARE @gamedate date;
DECLARE @hometeam int;
DECLARE @homescore int;
DECLARE @visitteam int;
DECLARE @visitscore int;
DECLARE @locationid int;
DECLARE @isplayed int;
DECLARE @notes nvarchar(50);
-- declare cursor
DECLARE cursor_games CURSOR FOR
SELECT * FROM games

OPEN cursor_games; -- open cursor
 
-- loop through a cursor
FETCH NEXT FROM cursor_games INTO  @gameid, @divid, @gamenum, @gamedate, @hometeam, @homescore, @visitteam, @visitscore, @locationid, @isplayed, @notes;
WHILE @@FETCH_STATUS = 0
    BEGIN
    PRINT CONCAT('game id: ', @gameid, ' | divid: ', @divid, ' | gamenum: ', @gamenum, ' | gamedate: ', @gamedate, ' | hometeam: ', @hometeam
	, ' | homescore: ', @homescore, ' | visitteam: ', @visitteam, ' | visitscore: ', @visitscore, ' | locationid: ', @locationid, ' | isplayed: ', @isplayed
	, ' | notes: ', @notes);
    FETCH NEXT FROM cursor_games INTO  @gameid, @divid, @gamenum, @gamedate, @hometeam, @homescore, @visitteam, @visitscore, @locationid, @isplayed, @notes;;
    END;
 
-- close and deallocate cursor
CLOSE cursor_games;
DEALLOCATE cursor_games;
END
END TRY
BEGIN CATCH
SELECT ERROR_MESSAGE() as ErrorMessage;
SELECT ERROR_NUMBER() as ErrorNumber;
END CATCH


EXECUTE spGamesOutput;

------------------------------------GoalScorers table output---------------------------------------------

GO
CREATE OR ALTER PROCEDURE spGoalScorersOutput
AS
BEGIN TRY
BEGIN
---Initialize variables to hold table data------
DECLARE @goalid int;
DECLARE @gameid int;
DECLARE @playerid int;
DECLARE @teamid int;
DECLARE @numgoals int;
DECLARE @numassists int;

-- declare cursor
DECLARE cursor_goalscorers CURSOR FOR
SELECT * FROM goalScorers

OPEN cursor_goalscorers; -- open cursor
 
-- loop through a cursor
FETCH NEXT FROM cursor_goalscorers INTO  @goalid, @gameid, @playerid, @teamid, @numgoals, @numassists;
WHILE @@FETCH_STATUS = 0
    BEGIN
    PRINT CONCAT('goal id: ', @goalid, ' | game id: ', @gameid, ' | player id: ', @playerid, ' | team id: ', @teamid, ' | num goals: ', @numgoals
	, ' | num assists: ', @numassists);
    FETCH NEXT FROM cursor_goalscorers INTO  @goalid, @gameid, @playerid, @teamid, @numgoals, @numassists;
    END;
 
-- close and deallocate cursor
CLOSE cursor_goalscorers;
DEALLOCATE cursor_goalscorers;
END
END TRY
BEGIN CATCH
SELECT ERROR_MESSAGE() as ErrorMessage;
SELECT ERROR_NUMBER() as ErrorNumber;
END CATCH


EXECUTE spGoalScorersOutput;


----------------------------------------------Players table output------------------------------------------------

GO
CREATE OR ALTER PROCEDURE spPlayersOutput
AS
BEGIN TRY
BEGIN
---Initialize variables to hold table data------
DECLARE @playerid int;
DECLARE @regnumber nvarchar(15);
DECLARE @lastname nvarchar(25);
DECLARE @firstname nvarchar(25);
DECLARE @isactive int;

-- declare cursor
DECLARE cursor_players CURSOR FOR
SELECT * FROM players

OPEN cursor_players; -- open cursor
 
-- loop through a cursor
FETCH NEXT FROM cursor_players INTO  @playerid, @regnumber, @lastname, @firstname, @isactive;
WHILE @@FETCH_STATUS = 0
    BEGIN
    PRINT CONCAT('Player id: ', @playerid, ' | Reg number: ', @regnumber, ' | Last name: ', @lastname, ' | First Name: ', @firstname, ' | Isactive: ', @isactive);
    FETCH NEXT FROM cursor_players INTO  @playerid, @regnumber, @lastname, @firstname, @isactive;
    END;
 
-- close and deallocate cursor
CLOSE cursor_players;
DEALLOCATE cursor_players;
END
END TRY
BEGIN CATCH
SELECT ERROR_MESSAGE() as ErrorMessage;
SELECT ERROR_NUMBER() as ErrorNumber;
END CATCH


EXECUTE spPlayersOutput;

----------------------------------------------Teams table output------------------------------------------------

GO
CREATE OR ALTER PROCEDURE spTeamsOutput
AS
BEGIN TRY
BEGIN
---Initialize variables to hold table data------
DECLARE @teamid int;
DECLARE @teamname varchar(10);
DECLARE @isactive int;
DECLARE @jerseycolour varchar(10);

-- declare cursor
DECLARE cursor_teams CURSOR FOR
SELECT * FROM teams

OPEN cursor_teams; -- open cursor
 
-- loop through a cursor
FETCH NEXT FROM cursor_teams INTO  @teamid, @teamname, @isactive, @jerseycolour;
WHILE @@FETCH_STATUS = 0
    BEGIN
    PRINT CONCAT('Team id: ', @teamid, ' | Team Name: ', @teamname, ' | Isactive: ', @isactive, ' | Jersey Colour: ', @jerseycolour);
    FETCH NEXT FROM cursor_teams INTO @teamid, @teamname, @isactive, @jerseycolour;
    END;
 
-- close and deallocate cursor
CLOSE cursor_teams;
DEALLOCATE cursor_teams;
END
END TRY
BEGIN CATCH
SELECT ERROR_MESSAGE() as ErrorMessage;
SELECT ERROR_NUMBER() as ErrorNumber;
END CATCH


EXECUTE spTeamsOutput;

----------------------------------------------Rosters table output------------------------------------------------

GO
CREATE OR ALTER PROCEDURE spRostersOutput
AS
BEGIN TRY
BEGIN
---Initialize variables to hold table data------
DECLARE @rosterid int;
DECLARE @playerid int;
DECLARE @teamid int;
DECLARE @isactive int;
DECLARE @jerseynumber int;

-- declare cursor
DECLARE cursor_rosters CURSOR FOR
SELECT * FROM rosters

OPEN cursor_rosters; -- open cursor
 
-- loop through a cursor
FETCH NEXT FROM cursor_rosters INTO  @rosterid, @playerid, @teamid, @isactive, @jerseynumber;
WHILE @@FETCH_STATUS = 0
    BEGIN
    PRINT CONCAT('Roster id: ', @rosterid, ' | Player id: ', @playerid, ' | Team id: ', @teamid, ' | Isactive: ', @isactive, ' | jersey number: ', @jerseynumber);
    FETCH NEXT FROM cursor_rosters INTO  @rosterid, @playerid, @teamid, @isactive, @jerseynumber;
    END;
 
-- close and deallocate cursor
CLOSE cursor_rosters;
DEALLOCATE cursor_rosters;
END
END TRY
BEGIN CATCH
SELECT ERROR_MESSAGE() as ErrorMessage;
SELECT ERROR_NUMBER() as ErrorNumber;
END CATCH


EXECUTE spRostersOutput;

----------------------------------------------slLocations table output------------------------------------------------

GO
CREATE OR ALTER PROCEDURE spslLocationsOutput
AS
BEGIN TRY
BEGIN
---Initialize variables to hold table data------
DECLARE @locationid int;
DECLARE @locationname nvarchar(50);
DECLARE @fieldlength int;
DECLARE @isactive int;

-- declare cursor
DECLARE cursor_locations CURSOR FOR
SELECT * FROM slLocations

OPEN cursor_locations; -- open cursor
 
-- loop through a cursor
FETCH NEXT FROM cursor_locations INTO  @locationid, @locationname, @fieldlength, @isactive;
WHILE @@FETCH_STATUS = 0
    BEGIN
    PRINT CONCAT('Location id: ', @locationid, ' | Location Name: ', @locationname, ' | Field Length: ', @fieldlength, ' | Isactive: ', @isactive);
    FETCH NEXT FROM cursor_locations INTO @locationid, @locationname, @fieldlength, @isactive;
    END;
 
-- close and deallocate cursor
CLOSE cursor_locations;
DEALLOCATE cursor_locations;
END
END TRY
BEGIN CATCH
SELECT ERROR_MESSAGE() as ErrorMessage;
SELECT ERROR_NUMBER() as ErrorNumber;
END CATCH


EXECUTE spslLocationsOutput;

--------------------------------------------------END OF TASK 2---------------------------------------------------------------------

--Create a view which stores the “players on teams” information, called vwPlayerRosters which includes all fields from players, 
--rosters, and teams in a single output table.  You only need to include records that have exact matches.

GO

CREATE OR ALTER VIEW vwPlayerRosters
AS
SELECT p.playerid, p.regnumber, p.lastname, p.firstname,
r.rosterid,r.Isactive,r.jerseynumber,
t.teamid,t.teamname,t.jerseycolour 
FROM players p INNER JOIN rosters r ON p.playerid = r.playerid INNER JOIN teams t ON r.teamid = t.teamid;

GO

SELECT * FROM
vwPlayerRosters

--TASK 4--------------------------------------------------------------------------------------------------------  spTeamRosterByID;

GO
CREATE or ALTER PROCEDURE spTeamRosterByID @teamid int
AS
DECLARE @name VARCHAR(500);
DECLARE db_cursor CURSOR FOR 
SELECT CONCAT(FIRSTNAME, ' ', LASTNAME,' ', 'of team', teamname, ' whose player id is ', playerid) FROM vwPlayerRosters WHERE teamid = @teamid;
OPEN db_cursor

FETCH NEXT FROM db_cursor INTO @name 
WHILE @@FETCH_STATUS = 0
 
BEGIN  
	PRINT(@name)
 	FETCH NEXT FROM db_cursor INTO @name;
END

CLOSE db_cursor;
DEALLOCATE db_cursor;
EXECUTE spTeamRosterByID @teamid=221;

--TASK 5------------------------------------------------------------------------------------------------------------------------------

GO
CREATE or ALTER PROCEDURE spTeamRosterByName @searchstring VARCHAR(50)
AS
DECLARE @name VARCHAR(500);
DECLARE db_cursor CURSOR FOR 
SELECT CONCAT(FIRSTNAME, ' ', LASTNAME,' ', 'of team', teamname, ' whose player id is ', playerid) FROM vwPlayerRosters WHERE firstname like '%'+@searchstring+'%' or lastname like '%'+@searchstring+'%' or teamname like '%'+@searchstring+'%'; 
OPEN db_cursor

FETCH NEXT FROM db_cursor INTO @name 
WHILE @@FETCH_STATUS = 0
 
BEGIN  
	PRINT(@name)
 	FETCH NEXT FROM db_cursor INTO @name;
END

CLOSE db_cursor;
DEALLOCATE db_cursor;
EXECUTE spTeamRosterByName @searchstring='drew';

/*
Create a view that returns the number of players currently registered on each team, called vwTeamsNumPlayers.
*/

GO

CREATE OR ALTER VIEW vwTeamsNumPlayers
AS
SELECT t.teamid, COUNT(playerid) "NumPlayers" 
FROM teams t LEFT OUTER JOIN rosters r
ON t.teamid = r.teamid
GROUP BY t.teamid;

GO

SELECT * FROM vwTeamsNumPlayers;
GO

/*
Using vwTeamsNumPlayers create a user defined function, that given the team PK, will return the number of players
currently registered, called fncNumPlayersByTeamID.
*/

CREATE OR ALTER FUNCTION fncNumPlayersByTeamID (@teamId INT)
RETURNS INT
AS
BEGIN
	DECLARE @numPlayers INT = (SELECT NumPlayers FROM vwTeamsNumPlayers WHERE teamid = @teamId);
	RETURN @numPlayers;
END

GO

SELECT dbo.fncNumPlayersByTeamID(221) AS "numPlayers(221)";
GO


/*
Create a view, called vwSchedule, that shows all games, but includes the written names for teams and locations, in
addition to the PK/FK values. Do not worry about division here.
*/

CREATE OR ALTER VIEW vwSchedule
AS
SELECT
	gameid,
	hometeam,
	(SELECT teamname FROM teams WHERE teamid = g.hometeam) AS "hometeamname",
	visitteam,
	(SELECT teamname FROM teams WHERE teamid = g.visitteam) AS "visitteamname",
	locationid,
	(SELECT locationname FROM slLocations WHERE locationid = g.locationid) AS "locationname"
FROM games g;

GO

SELECT * FROM vwSchedule;
GO

/*
Create a stored procedure, spSchedUpcomingGames, using PRINT, that displays the games to be played in the next n
days, where n is an input parameter. Make sure your code will work on any day of the year.
*/

CREATE OR ALTER PROCEDURE spSchedUpcomingGames
@n INT
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @gameId INT, @gameDate DATE, @homeTeam INT, @visitTeam INT, @locationId INT, @numDays INT;

	BEGIN TRY
		/*Create a cursor to traverse over all games within n days and print their details*/
		DECLARE curGamesNxtn CURSOR FOR
		/*Used datediff to get number of days from today that the game will take place. It will come negative for the games that
		have already taken place in past. Then select only those games where these number of days is from 0 to n*/
		SELECT gameid, gamedatetime, hometeam, visitteam, locationid,
			DATEDIFF(dd, GETDATE(), gamedatetime) AS "numDays"
		FROM games
		WHERE DATEDIFF(dd, GETDATE(), gamedatetime) BETWEEN 0 AND @n;

		/*Open cursor and fetch 1st row*/
		OPEN curGamesNxtn;
		FETCH NEXT FROM curGamesNxtn INTO @gameId, @gameDate, @homeTeam, @visitTeam, @locationId, @numDays;

		PRINT 'GameId | Date | Home Team | Visit Team | LocationId | NumDays'
		/*fetch until no more rows left*/
		WHILE @@FETCH_STATUS = 0
		BEGIN
			/*Print fields related to games, can add other too acc. to requirements*/
			PRINT CONVERT(VARCHAR, @gameId) + ' | ' + CONVERT(VARCHAR, @gameDate) + ' | ' + CONVERT(VARCHAR, @homeTeam) + ' | ' +
			CONVERT(VARCHAR, @visitTeam) + ' | ' + CONVERT(VARCHAR, @locationId) + ' | ' + CONVERT(VARCHAR, @numDays);
			FETCH NEXT FROM curGamesNxtn INTO @gameId, @gameDate, @homeTeam, @visitTeam, @locationId, @numDays;
		END

		/*Close and deallocate the cursor*/
		CLOSE curGamesNxtn;
		DEALLOCATE curGamesNxtn;
	END TRY
	/*Catch any errors that may occur while traversing over the cursor*/
	BEGIN CATCH
		/*Print error with proper code and message*/
		PRINT 'Error ' + CONVERT(VARCHAR, ERROR_NUMBER(), 1) + ' : ' + ERROR_MESSAGE()
		/*Close and deallocate the cursor cause if error occured then cursor would have haulted in the middle and will not go back*/
		CLOSE curGamesNxtn;
		DEALLOCATE curGamesNxtn;
	END CATCH
END
GO

EXEC spSchedUpcomingGames 20;
GO

/*
Create a stored procedure, spSchedPastGames, using PRINT, that displays the games that have been played in the
past n days, where n is an input parameter. Make sure your code will work on any day of the year.
*/

CREATE OR ALTER PROCEDURE spSchedPastGames
@n INT
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @gameId INT, @gameDate DATE, @homeTeam INT, @homeScore INT, @visitTeam INT, @visitScore INT, @locationId INT, @numDays INT;

	BEGIN TRY
		DECLARE curGamesPastn CURSOR FOR
		/*Same approach as the previous query, here we calculate number of days from today that game has already taken place. So
		just swap the 2 dates in DATEDIFF function. In this case it will be negative for the games which will take place in future.*/
		SELECT gameid, gamedatetime, hometeam, homescore, visitteam, visitscore, locationid,
			DATEDIFF(dd, gamedatetime, GETDATE()) AS "numDays"
		FROM games
		WHERE DATEDIFF(dd, gamedatetime, GETDATE()) BETWEEN 0 AND @n;

		OPEN curGamesPastn;
		FETCH NEXT FROM curGamesPastn INTO @gameId, @gameDate, @homeTeam, @homeScore, @visitTeam, @visitScore, @locationId, @numDays;

		PRINT 'GameId | Date | Home Team | Home Score | Visit Team | Visit Score | LocationId | NumDays'
		WHILE @@FETCH_STATUS = 0
		BEGIN
			/*Added scores fields also in this as games have already taken place.*/
			PRINT CONVERT(VARCHAR, @gameId) + ' | ' + CONVERT(VARCHAR, @gameDate) + ' | ' + CONVERT(VARCHAR, @homeTeam) + ' | ' +
			CONVERT(VARCHAR, @homeScore) + ' | ' + CONVERT(VARCHAR, @visitTeam) + ' | ' + CONVERT(VARCHAR, @visitScore) + ' | ' +
			CONVERT(VARCHAR, @locationId) + ' | ' + CONVERT(VARCHAR, @numDays);
			FETCH NEXT FROM curGamesPastn INTO @gameId, @gameDate, @homeTeam, @homeScore, @visitTeam, @visitScore, @locationId, @numDays;
		END

		CLOSE curGamesPastn;
		DEALLOCATE curGamesPastn;
	END TRY
	BEGIN CATCH
		PRINT 'Error ' + CONVERT(VARCHAR, ERROR_NUMBER(), 1) + ' : ' + ERROR_MESSAGE()
		CLOSE curGamesPastn;
		DEALLOCATE curGamesPastn;
	END CATCH
END
GO

EXEC spSchedPastGames 10;
GO
