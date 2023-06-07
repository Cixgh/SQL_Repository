--Sample company report scenarios 1

USE dbs710Sample;
GO

/*
1.	Display the employee number, full employee name, job and hire date of all employees hired in May or November of any year, with the most recently hired employees displayed first. 
•	Also, exclude people hired in 2015 and 2016.  
•	Full name should be in the form “Lastname, Firstname”  with an alias called “FullName”.
•	Hire date should point to the last day in May or November of that year (NOT to the exact day) and be in the form of [May 31, 2016] with the heading Start Date. Do NOT use LIKE operator. 
•	You should display ONE row per output line by limiting the width of the Full Name to 25 characters. The output lines should look like this line (4 columns): */

SELECT employeeID, CONCAT (firstName,' ',lastName) as FullName, jobID, FORMAT(hireDate, 'MMMM dd "of" yyyy') as HireDate
FROM employees
WHERE YEAR(hireDate) NOT IN ('2015','2016');

/*
2.	List the employee number, full name, job and the modified salary for all employees whose monthly earning (without this increase) is outside the range $6,500 – $11,500 
    and who are employed as Vice Presidents or Managers (President is not counted here).  
•	You should use Wild Card characters for this. 
•	VP’s will get 25% and managers 18% salary increase.  
•	Sort the output by the top salaries (before this increase) firstly.
•	Heading will be like Employees with increased Pay
•	The output lines should look like this sample line (note: 1 column):*/

SELECT CONCAT('Emp# ',employeeID , ' named ',CONCAT(firstName,' ', lastName), ' who is ',jobID COLLATE Latin1_General_CS_AS,' will have a new salary of $',(monthlySalary + monthlySalary*0.25)) 
AS 'Employees with increased pay'
FROM employees
WHERE (monthlySalary NOT BETWEEN 6500 AND 11500) AND (jobID LIKE '%VP%')
UNION
SELECT CONCAT('Emp# ',employeeID , ' named ',CONCAT(firstName,' ', lastName), ' who is ',jobID COLLATE Latin1_General_CS_AS,' will have a new salary of $',(monthlySalary + monthlySalary *0.18))
AS 'Employees with increased pay'
FROM employees
WHERE (monthlySalary NOT BETWEEN 6500 AND 11500) AND (jobID LIKE '%MAN%')

/*
3.	Display the employee last name, salary, job title and manager# of all employees not earning a commission OR if they work in the SALES department, 
	but only  if their total monthly salary with $1000 included bonus and  commission (if  earned) is  greater  than  $15,000.  
•	Let’s assume that all employees receive this bonus.
•	If an employee does not have a manager, then display the word NONE 
instead. This column should have an alias Manager#.
•	Display the Total annual salary as well in the form of $135,600.00 with the heading Total Income. 
•	Sort the result so that best paid employees are shown first.
*/


SELECT lastName, monthlySalary, jobID, ISNULL(managerID, 0) AS ManagerID, CONCAT('$',(monthlySalary*12)) as AnnualSalary
FROM employees 
WHERE ((commissionPercent IS NULL) OR (departmentID = 80))
AND (monthlySalary + (monthlySalary* ISNULL(commissionPercent,0)) + 1000) > 15000;


/*
Question 4. Display DepartmentID, JobID and the Lowest salary for this combination under the alias Lowest Dept/Job Pay,
but only if that Lowest Pay falls in the range $6500 - $16800. Exclude people who work as some kind of Representative job
from this query and departments IT and SALES as well.
•	Sort the output according to the DepartmentID and then by JobID.
•	You MUST NOT use the Subquery method.
*/

SELECT
  e.departmentID,
  jobID,
  MIN(monthlySalary) AS "Lowest Dept/Job Pay"
FROM employees e INNER JOIN departments d
ON e.departmentID = d.departmentID
WHERE departmentName NOT IN ('IT', 'Sales') AND UPPER(jobID) NOT LIKE '%REP%'
GROUP BY e.departmentID, jobID
HAVING MIN(monthlySalary) BETWEEN 6500 AND 16800
ORDER BY e.departmentID ASC, jobID ASC;

/*
Question 5. Display last name, salary and job for all employees who earn more than all lowest paid employees per
department outside the US locations.
•	Exclude President and Vice Presidents from this query.
•	Sort the output by job title ascending.
•	You need to use a Subquery and Joining.
*/

SELECT
  lastName,
  monthlySalary,
  jobID
FROM employees
WHERE monthlySalary > (
	SELECT MAX(ed.minSalary)
	FROM (
		SELECT
		  MIN(monthlySalary) AS minSalary
		FROM employees e INNER JOIN (
			SELECT
			  departmentID
			FROM departments
			WHERE locationID NOT IN (SELECT locationID FROM locations WHERE UPPER(countryID) = 'US')
		) d
		ON e.departmentID = d.departmentID
		GROUP BY e.departmentID
	) AS ed
) AND (jobID NOT LIKE '%PRES%' AND jobID NOT LIKE '%VP%')
ORDER BY jobID ASC;

/*
Question 6. Who are the employees (show last name, salary and job) who work either in IT or MARKETING department and earn
more than the worst paid person in the ACCOUNTING department. 
•	Sort the output by the last name alphabetically.
•	You need to use ONLY the Subquery method (NO joins allowed).
*/

SELECT
  lastName,
  monthlySalary,
  jobID
FROM employees
WHERE monthlySalary > (
	SELECT MIN(monthlySalary)
	FROM employees
	WHERE departmentID = (SELECT departmentID FROM departments WHERE UPPER(departmentName) = 'ACCOUNTING')
) AND departmentID IN (SELECT departmentID FROM departments WHERE UPPER(departmentName) IN ('MARKETING', 'IT'))
ORDER BY lastName ASC;


/*
7.	Display alphabetically the full name, job, salary (formatted as a currency amount incl. thousand separator, but no decimals) 
and department number for each employee who earns less than the best paid unionized employee (i.e. not the president nor any manager nor any VP), 
and who work in either SALES or MARKETING department.  
•	Full name should be displayed as Firstname Lastname and should have the heading Employee. 
•	Salary should be left-padded with the = symbol till the width of 15 characters. It should have an alias Salary.
•	You should display ONE row per output line by limiting the width of the 	Employee to 24 characters.
*/

SELECT CONVERT(varchar, CONCAT (firstName, ' ', lastName)) AS Employee, jobID AS Job,
CONCAT('$ ',FORMAT(monthlySalary, 'N0')) AS Salary, departmentID AS "DepartmentID"
FROM employees 
WHERE (departmentID IN 
(SELECT departmentID  FROM departments WHERE UPPER (departmentName) IN ('SALES', 'MARKETING')))
 AND (monthlySalary < (SELECT MAX(monthlySalary) AS MaxSalary
 FROM employees WHERE (jobID NOT LIKE '%MAN%') AND (jobID NOT LIKE '%MGR%') AND (jobID NOT IN ('AD_PRES', 'AD_VP'))))
ORDER BY "Employee";

/*
8.  Display department name, city and number of different jobs in each department. If city is null, you should print Not Assigned Yet.
•	This column should have alias City.
•	Column that shows # of different jobs in a department should have the heading # of Jobs
•	You should display ONE row per output line by limiting the width of the City to 22 characters.
•	You need to show complete situation from the EMPLOYEE point of view, meaning include also employees who work for NO department 
    (but do NOT display empty departments) and from the CITY point of view meaning you need to display all cities without departments as well.
*/

SELECT departmentName, CONVERT(nvarchar(22), ISNULL(city, 'Not Assigned Yet')) AS City, "# of Jobs"
FROM locations l 
RIGHT OUTER JOIN ( SELECT departmentName, locationID, jobs.departmentID, "# of Jobs" FROM departments d 
RIGHT OUTER JOIN ( SELECT departmentID, COUNT (jobID) AS "# of Jobs" FROM 
( SELECT DISTINCT departmentID, jobID FROM employees ) job GROUP BY departmentID) jobs
ON d.departmentID = jobs.departmentID
WHERE "# of Jobs" IS NOT NULL)dep
ON l.locationID = dep.locationID
UNION
SELECT departmentName, CONVERT(nvarchar(22), ISNULL(city, 'Not Assigned Yet')) AS City, "# of Jobs"
FROM locations l 
LEFT OUTER JOIN ( SELECT departmentName, locationID, jobs.departmentID, "# of Jobs" FROM departments d 
RIGHT OUTER JOIN ( SELECT departmentID, COUNT (jobID) AS "# of Jobs" FROM 
( SELECT DISTINCT departmentID, jobID FROM employees ) job GROUP BY departmentID ) jobs
ON d.departmentID = jobs.departmentID
WHERE "# of Jobs" IS NOT NULL)dep
ON l.locationID = dep.locationID
;