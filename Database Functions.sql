-- Database Functions.



--1.	Write a user-defined function, called fncCalcFactorial, that gets an integer number n and calculates and returns its factorial.  
--      Create a non-saved procedure that executes the above function and outputs the result for 3 different input values.

USE dbs710Sample;

DROP FUNCTION IF EXISTS fncCalcFactorial;

GO

CREATE FUNCTION fncCalcFactorial(@num int)
RETURNS bigint
AS
BEGIN
DECLARE @i int = 1

 WHILE @num>1
 BEGIN
  SET @i = @num *  @i
  SET @num=@num-1
  END

RETURN @i
END

GO

DROP PROCEDURE IF EXISTS ExecFncCalcFactorial;

GO

CREATE PROCEDURE ExecFncCalcFactorial
AS
BEGIN
SELECT dbo.fncCalcFactorial(3) AS Factorial3, dbo.fncCalcFactorial(4) AS Factorial4, dbo.fncCalcFactorial(5) AS Factorial5
END

GO

EXECUTE ExecFncCalcFactorial;


/*Write a stored procedure named spCalcCurrentSalary which gets an employee ID and for that employee calculates the current salary
based on the number of FULL years the employee has been working in the company.  
(Use a loop construct to calculate the salary) and the number of weeks vacation they will receive.
The procedure calculates and prints the salary.*/

DROP PROCEDURE IF EXISTS spCalcCurrentSalary;

GO

CREATE PROCEDURE spCalcCurrentSalary (@empID INT)
AS
DECLARE
@firstname NVARCHAR(256),
@lastname NVARCHAR(256),
@hiredate DATE,
@currentdate DATE,
@salary FLOAT,
@years INT,
@vacation INT,
@errorMessage NVARCHAR(256)
BEGIN TRY
SET @firstname = (SELECT firstName FROM employees WHERE employeeID = @empID)
SET @lastname = (SELECT lastName FROM employees WHERE employeeID = @empID)
SET @hiredate = (SELECT hireDate FROM employees WHERE employeeID = @empID)
SET @salary = (SELECT monthlySalary FROM employees WHERE employeeID = @empID)
SET @currentdate = GETDATE()
SET @vacation = 2
SET @years = DATEDIFF (year ,CAST(@hiredate as DATE), @currentdate) -1
BEGIN
IF (@years = 0)
	BEGIN
	PRINT 'First Name: ' + @firstname
	PRINT 'Last Name: ' + @lastname
	PRINT 'Hire Date: ' + cast(@hiredate as varchar)
	PRINT 'Salary: ' + cast(@salary as varchar)
	PRINT 'Vacation Weeks: ' + cast(@vacation as varchar)
	END
ELSE IF (@years = 2) OR (@years = 1)
	BEGIN
	WHILE (@years > 0)
		BEGIN
			SET @salary = (0.04 * @salary) + @salary
			SET @years = @years - 1
		END
	PRINT 'First Name: ' + @firstname
	PRINT 'Last Name: ' + @lastname
	PRINT 'Hire Date: ' + cast(@hiredate as varchar)
	PRINT 'Salary: ' + cast(@salary as varchar)
	PRINT 'Vacation Weeks: ' + cast(@vacation as varchar)
	END
ELSE IF (@years = 3) OR (@years = 4)
	BEGIN
	SET @vacation = @vacation + @years
	WHILE (@years > 0)
		BEGIN
			SET @salary = (0.04 * @salary) + @salary
			SET @years = @years - 1
		END
	PRINT 'First Name: ' + @firstname
	PRINT 'Last Name: ' + @lastname
	PRINT 'Hire Date: ' + cast(@hiredate as varchar)
	PRINT 'Salary: ' + cast(@salary as varchar)
	PRINT 'Vacation Weeks: ' + cast(@vacation as varchar)
	END
ELSE
	BEGIN
		SET @vacation = @vacation + 4
		WHILE (@years > 0)
		BEGIN
			SET @salary = (0.04 * @salary) + @salary
			SET @years = @years - 1
		END
	PRINT 'First Name: ' + @firstname
	PRINT 'Last Name: ' + @lastname
	PRINT 'Hire Date: ' + cast(@hiredate as varchar)
	PRINT 'Salary: ' + cast(@salary as varchar)
	PRINT 'Vacation Weeks: ' + cast(@vacation as varchar)
	END
END
END TRY
BEGIN CATCH
SELECT ERROR_NUMBER() as ErrorNumber
SELECT ERROR_MESSAGE() as ErrorMessage;
END CATCH


EXECUTE spCalcCurrentSalary @empID = 100;


/*3.	Write a stored procedure named spDepartmentsReport to print the department ID, department name,
the city where the department is located, and the number of employees working in the department. 
Include ALL departments, even if there are no employees, and show the output as 0 for those with no employees (not null). 
Use cursor attributes to determine this.
Create a non-saved procedure that executes the above stored procedure and outputs the results as specified.
It is OKAY to PRINT statements inside your stored procedure for now, although we would normally avoid this practice. */


DROP PROCEDURE IF EXISTS spDepartmentsReport

GO

CREATE OR ALTER PROCEDURE spDepartmentsReport AS
BEGIN
	DECLARE @deptID int;
	DECLARE @deptName varchar(20);
	DECLARE @city varchar(20);
	DECLARE @numEmps int;
	DECLARE curDepts CURSOR FOR 
		SELECT d.departmentID,d.departmentName,l.city,count(e.employeeID) AS numEmps
		FROM employees e
		INNER JOIN departments d ON e.departmentID=d.departmentID 
		INNER JOIN locations l ON l.locationID = d.locationID
		group by d.departmentID,d.departmentName,l.city;

	OPEN curDepts;
	
	FETCH NEXT FROM curDepts INTO @deptID,@deptName,@city,@numEmps;

	WHILE @@FETCH_STATUS = 0
		BEGIN
			PRINT '-------------------------';
			PRINT 'DepartmentID: ' + CONVERT(varchar, @deptID);
			PRINT 'Department Name: ' + @deptName;
			PRINT 'City: ' + @city;
			PRINT 'Num Employees: ' + CONVERT(varchar, @numEmps);
			
			FETCH NEXT FROM curDepts INTO @deptID, @deptName,@city,@numEmps;
		END
	CLOSE curDepts;
	DEALLOCATE curDepts;
END  

EXEC dbo.spDepartmentsReport ;

/*4.	Using the SportLeagues database tables:  
a.	Create a user defined function, called spDetermineWinningTeam that receives a gameID and determines the teamID of the winning team.
- if the game has not yet been played, return -1
- if the game is a tie, return 0
b.	Create an SQL statement that outputs ALL teams and the total number of games they have won using the UDF created in part A.  */

GO

USE sportLeagues;

DROP FUNCTION IF EXISTS spDetermineWinningTeam;

GO

CREATE OR ALTER FUNCTION spDetermineWinningTeam (@gameid int)
RETURNS bigint
AS
BEGIN
DECLARE @Played int;
DECLARE @Tie int;
DECLARE @homescore int;
DECLARE @visitscore int;
DECLARE @winTeam int;
	SET @Played = (SELECT isplayed FROM games WHERE gameid = @gameid)
	SET @homescore = (SELECT homescore FROM games WHERE gameid = @gameid)
	SET @visitscore = (SELECT visitscore FROM games WHERE gameid = @gameid)
IF (@Played = 0)
BEGIN
SET @Played = -1
RETURN @Played 
END
ELSE IF (@Played = 1) AND (@homescore = @visitscore)
BEGIN
SET @Tie = 0
RETURN @Tie
END
ELSE IF (@homescore > @visitscore)
BEGIN
SET @winTeam = (SELECT hometeam FROM games WHERE gameid = @gameid)
RETURN @winTeam
END
ELSE IF (@visitscore > @homescore)
BEGIN
SET @winTeam = (SELECT visitteam FROM games WHERE gameid = @gameid)
RETURN @winTeam
END
RETURN 1
END

GO

select dbo.spDetermineWinningTeam(1) as gameOutput

