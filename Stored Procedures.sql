-- Stored Procedures


/*1.	Write a code procedure that declares an integer number and prints
The number is even.
If a number is divisible by 2.
Otherwise, it prints 
The number is odd.*/

USE dbs710Sample
GO

DROP PROCEDURE IF EXISTS EvenOddChecker;

CREATE PROCEDURE EvenOddChecker( 
@num INT = 2,
@result INT = 0)
AS
SET @result=@num % 2
IF @result = 0
PRINT cast(@num as varchar) + ' is Even!'
ELSE
PRINT cast(@num as varchar) + ' is Odd!'
GO

EXECUTE EvenOddChecker @num = 21232211;


/*2.	Write a code procedure that contains a while loop to solve the following problem.  
The procedure will declare an input parameter of any number less than 
1000 and determines and displays if that number is a prime number or not.
A number is prime if it is not evenly divisible by anything other than 1 and itself.
a.	The loop should work regardless of the number chosen up to 1000
b.	The loop should exit immediately once a result has been determined
c.	You only even number you will need to check is 2, otherwise only check odd numbers
d.	You will only need to check numbers up to ½ of the input number, as any number found 
above half the input number that is evenly divisible, would already
been found by the complimentary number less than ½ the input number. */

DROP PROCEDURE IF EXISTS PrimeNumChecker;

CREATE PROCEDURE PrimeNumChecker (
@num int
)
AS
DECLARE @counter int
SET @counter = 2
BEGIN
IF (@num>1000)
	BEGIN
	SELECT 'Number should be less than 1000';
	RETURN
	END
ELSE
	WHILE(@counter)< @num/2
	BEGIN
	IF(@num%@counter=0)
	BEGIN
	SELECT 'Not Prime'
	Return
	END
	SET @counter = @counter + 1
	END
	SELECT 'PRIME'
	RETURN
END


EXECUTE PrimeNumChecker @num = 2211;


/*3.	Create a code procedure that declares an employee number and prints the following employee information using parameters:
•	First name 
•	Last name 
•	Email
•	Phone 	
•	Hire date 
•	Job title
The procedure gets a value as the employee ID of type NUMBER.
The procedure should display a proper error message if any error occurs. */

DROP PROCEDURE IF EXISTS employeeReport;

CREATE PROCEDURE employeeReport (@empID INT)
AS
DECLARE
@firstname NVARCHAR(256),
@lastname NVARCHAR(256),
@email NVARCHAR(256),
@phone NVARCHAR(256),
@hireDate DATE,
@jobTitle NVARCHAR(256),
@errorMessage NVARCHAR(256)
BEGIN TRY
SET @firstname = (SELECT firstName FROM employees WHERE employeeID = @empID)
SET @lastname = (SELECT lastName FROM employees WHERE employeeID = @empID)
SET @email = (SELECT email FROM employees WHERE employeeID = @empID)
SET @phone = (SELECT phoneNumber FROM employees WHERE employeeID = @empID)
SET @hireDate = (SELECT hireDate FROM employees WHERE employeeID = @empID)
SET @jobTitle = (SELECT jobID FROM employees WHERE employeeID = @empID)
BEGIN
PRINT 'First name: '+ @firstname
PRINT 'Last name: '+@lastname
PRINT 'Email: ' + @email
PRINT 'Phone: ' + @phone
PRINT 'Hire Date: ' + convert(nvarchar,@hireDate)
PRINT 'Job title: ' + @jobTitle
END
END TRY
BEGIN CATCH
SELECT ERROR_NUMBER() as ErrorNumber
SELECT ERROR_MESSAGE() as ErrorMessage;
END CATCH

EXECUTE employeeReport @empID = 100



/*4.	In a unionized company, the collective bargaining agreement often contains a requirement for staff to 
receive a given percentage salary increase an on annual basis.  These salary increases are different for different departments. 
For example, the company must give all employees who work in the marketing department an annual 2.5% raise.  

Write a code procedure to update the salaries of all employees in a given department and the given percentage increase to be added
to the current salary if the salary is greater than 0. The procedure displays the number of updated rows if the update is successful.
The procedure declares two input parameters (department ID and percentage increase) and one local parameter to store the number of rows updated.
*/

DROP PROCEDURE IF EXISTS SalaryUpdate;

CREATE PROCEDURE SalaryUpdate ( 
@deptID INT ,
@increment INT)
AS
BEGIN
UPDATE employees
SET monthlySalary = ((monthlySalary*(@increment/100)) + (monthlySalary))
WHERE departmentID = @deptID;
PRINT 'Number of rows updated: '+ cast(@@ROWCOUNT as varchar)
END

EXECUTE SalaryUpdate @deptID = 90, @increment = 2;


/*5.	To equalize salaries over time, every year, the company increase the monthly salary of all employees who make less than the average salary by 1% (salary *1.01).  

Write a code procedure that will not have any input parameters. You need to find the average salary of all employees and store it in a declared parameter of the same type and size. 
a.	If the average salary is less than or equal to $9000, update the employees’ salary by 2% if the salary of the employee is less than the calculated average. 
b.	If the average salary is greater than $9000, update employees’ salary by 1% if the salary of the employee is less than the calculated average. 
The query displays the number of updated rows.
*/

DROP PROCEDURE IF EXISTS SalaryEqual;

CREATE PROCEDURE SalaryEqual
AS
BEGIN
DECLARE @avgSalary INT
SET @avgSalary = (Select AVG(monthlySalary) from employees) 
IF (@avgSalary <= 9000)
	BEGIN
	UPDATE employees
	SET monthlySalary = ((monthlySalary*(2/100)) + (monthlySalary))
	WHERE monthlySalary < @avgSalary ;
	PRINT 'Number of rows updated: '+ cast(@@ROWCOUNT as varchar)
	END
ELSE
	BEGIN
	UPDATE employees
	SET monthlySalary = ((monthlySalary*(1/100)) + (monthlySalary))
	WHERE monthlySalary < @avgSalary ;
	PRINT 'Number of rows updated: '+ cast(@@ROWCOUNT as varchar)
	END
END

EXECUTE SalaryEqual;

/*6.	The company needs a report that shows three categories of employees based their salaries. The company needs to know if the salary is low, fair, or high. Let’s assume that
	If the salary is less than 
	(avg salary – min salary) / 2
The salary is low.
	If the salary is greater than 
	(max salary – avg salary) / 2
The salary is high.
	If the salary is between 
	(avg salary - min salary) / 2
	and
	(max salary - avg salary) / 2
	the end values included
The salary is fair.
Write a procedure named spSalaryReport to show the number of employees in each price category:
The following is a sample output of the procedure if no error occurs:
Low: 4
Fair: 12
High: 6  
The values in the above examples are just random values and may not match the real numbers in your result.
Make sure you choose a proper data type for each variable. You may need to define more variables based on your solution.
*/

DROP PROCEDURE IF EXISTS spSalaryReport;

CREATE PROCEDURE spSalaryReport
AS
BEGIN
DECLARE
	 @count INT= (select COUNT(monthlySalary) from employees),
	 @counter INT= 1,
	 @avg DECIMAL = (select AVG(monthlySalary) from employees),
	 @minSalary DECIMAL = (select MIN(monthlySalary) from employees),
	 @max DECIMAL = (select MAX(monthlySalary) from employees),
	 @low INT = 0,
	 @fair INT = 0,
	 @high INT = 0,
	 @checker DECIMAL = 0;
WHILE
	@counter <= @count
BEGIN
SET @checker  = (Select monthlySalary from (Select monthlySalary,ROW_NUMBER() over (order by monthlySalary) AS RowNum 
			 from employees) AS Table1 where Table1.RowNum Between @counter and @counter);
SET @counter  = @counter + 1;
IF (@checker < (@avg - @minSalary)/2) 
SET @low = @low +1;
ELSE IF (@checker > (@max - @avg)/2)
SET @high = @high + 1;
ELSE IF (@checker >= (@avg- @minSalary) / 2 AND @checker <= (@max - @avg)/2)
SET @fair = @fair + 1;
END
	PRINT 'Low = ' + cast(@low as varchar);
	PRINT 'High = ' + cast(@high as varchar);
	PRINT 'Fair = ' + cast(@fair as varchar);	
END

EXECUTE spSalaryReport;