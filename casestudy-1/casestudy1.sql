CREATE Database CASESTUDY1;

use CASESTUDY1;

CREATE TABLE LOCATION (
  Location_ID INT PRIMARY KEY,
  City VARCHAR(50)
);

INSERT INTO LOCATION (Location_ID, City)
VALUES (122, 'New York'),
       (123, 'Dallas'),
       (124, 'Chicago'),
       (167, 'Boston');


  CREATE TABLE DEPARTMENT (
  Department_Id INT PRIMARY KEY,
  Name VARCHAR(50),
  Location_Id INT,
  FOREIGN KEY (Location_Id) REFERENCES LOCATION(Location_ID)
);


INSERT INTO DEPARTMENT (Department_Id, Name, Location_Id)
VALUES (10, 'Accounting', 122),
       (20, 'Sales', 124),
       (30, 'Research', 123),
       (40, 'Operations', 167);

	   CREATE TABLE JOB (
  Job_ID INT PRIMARY KEY,
  Designation VARCHAR(50)
);


INSERT  INTO JOB VALUES
(667, 'CLERK'),
(668,'STAFF'),
(669,'ANALYST'),
(670,'SALES_PERSON'),
(671,'MANAGER'),
(672, 'PRESIDENT')


CREATE TABLE EMPLOYEE
(EMPLOYEE_ID INT,
LAST_NAME VARCHAR(20),
FIRST_NAME VARCHAR(20),
MIDDLE_NAME CHAR(1),
JOB_ID INT FOREIGN KEY
REFERENCES JOB(JOB_ID),
MANAGER_ID INT,
HIRE_DATE DATE,
SALARY INT,
COMM INT,
DEPARTMENT_ID  INT FOREIGN KEY
REFERENCES DEPARTMENT(DEPARTMENT_ID))

INSERT INTO EMPLOYEE VALUES
(7369,'SMITH','JOHN','Q',667,7902,'17-DEC-84',800,NULL,20),
(7499,'ALLEN','KEVIN','J',670,7698,'20-FEB-84',1600,300,30),
(7505,'DOYLE','JEAN','K',671,7839,'04-APR-85',2850,NULl,30),
(7506,'DENNIS','LYNN','S',671,7839,'15-MAY-85',2750,NULL,30),
(7507,'BAKER','LESLIE','D',671,7839,'10-JUN-85',2200,NULL,40),
(7521,'WARK','CYNTHIA','D',670,7698,'22-FEB-85',1250,500,30)



-- Simple Queries: 
-- 1. List all the employee details. 
SELECT * FROM dbo.employee;

-- 2. List all the department details. 
SELECT * FROM dbo.department;

-- 3. List all job details. 
SELECT * FROM dbo.JOB;

-- 4. List all the locations. 
SELECT * FROM dbo.location;

-- 5. List out the First Name, Last Name, Salary, Commission for all Employees. 
SELECT First_name, last_name, salary, comm FROM dbo.employee;

/* 6. List out the Employee ID, Last Name, Department ID for all employees and 
alias 
Employee ID as "ID of the Employee", Last Name as "Name of the 
Employee", Department ID as "Dep_id". 
*/
SELECT Employee_ID as "ID of the Employee", 
Last_Name as "Name of the Employee",
Department_ID as "Dep_id" 
FROM dbo.employee; 

-- 7. List out the annual salary of the employees with their names only. 
SELECT CONCAT(FIRST_NAME,' ', Middle_name,' ', Last_name), 
(Salary * 12) as Annual_salary 
from dbo.employee;

-- WHERE Condition: 
--1. List the details about "Smith". 
SELECT * from dbo.employee where last_name = 'smith';

--2. List out the employees who are working in department 20. 
SELECT * from dbo.employee where department_id = 20;

-- 3. List out the employees who are earning salary between 2000 and 3000. 
SELECT * from dbo.employee where salary between 2000 and 3000;

-- 4. List out the employees who are working in department 10 or 20. 
SELECT * from dbo.employee where department_id in (10,20);

-- 5. Find out the employees who are not working in department 10 or 30. 
SELECT * from dbo.employee where department_id not in (10,20);

-- 6. List out the employees whose name starts with 'L'. 
SELECT * from dbo.employee where first_name like 'L%';

-- 7. List out the employees whose name starts with 'L' and ends with 'E'. 
SELECT * from dbo.employee where first_name like 'L%E';

-- 8. List out the employees whose name length is 4 and start with 'J'. 
SELECT * from dbo.employee where first_name like 'J%' and len(first_name) = 4;

-- 9. List out the employees who are working in department 30 and draw the salaries more than 2500.
SELECT * from dbo.employee where department_id = 30 and salary > 2500;

-- 10. List out the employees who are not receiving commission. 
SELECT * from dbo.employee where comm is null;

-- ORDER BY Clause: 
-- 1. List out the Employee ID and Last Name in ascending order based on the Employee ID. 
SELECT employee_id, last_name 
from dbo.employee order by employee_id;

-- 2. List out the Employee ID and Name in descending order based on salary. 
SELECT employee_id, first_name + ' ' + last_name as fullname
from dbo.employee order by salary desc;

-- 3. List out the employee details according to their Last Name in ascending-order. 
SELECT * from dbo.employee order by last_name asc;

/* 4. List out the employee details according to their Last Name in ascending order 
and then Department ID in descending order. 
*/
SELECT * from dbo.employee 
order by Last_name asc, department_id desc;

-- GROUP BY and HAVING Clause: 
/* 1. List out the department wise maximum salary, 
minimum salary and average salary of the employees. 
*/
SELECT department_id,
max(salary) as min_salary,
min(salary) as max_salary,
avg(salary) as avg_salary
from dbo.employee 
GROUP by department_id;

/* 2. List out the job wise maximum salary,
minimum salary and average salary of the employees. */
SELECT job_id,
max(salary) as min_salary,
min(salary) as max_salary,
avg(salary) as avg_salary
from dbo.employee 
GROUP by job_id;

/*3. List out the number of employees 
who joined each month in ascending order. 
*/
SELECT DATENAME(Month, HIRE_DATE) as month_name,
count(*) as total_emp 
from dbo.employee
GROUP BY DATENAME(MONTH, Hire_Date), MONTH(Hire_Date)
ORDER BY MONTH(Hire_Date);

/* 4. List out the number of employees 
for each month and year in 
ascending order based on the year and month. 
*/
SELECT YEAR(Hire_date) as year, MONTH(Hire_date) as month,
count(*) as total_emp 
FROM dbo.employee
GROUP BY YEAR(Hire_date), MONTH(Hire_date)
ORDER BY year, month;

-- 5. List out the Department ID having at least four employees.
SELECT department_id, count(*) as emp_count
from dbo.employee
Group by department_id 
having count(*) >=4;

-- 6. How many employees joined in February month. 
SELECT count(*) as feb_emp_count
from dbo.employee
where MONTH(hire_date) =2;

--7. How many employees joined in May or June month. 
SELECT count(*) as may_june_count
from dbo.employee
where MONTH(hire_date) in (5,6);

-- 8. How many employees joined in 1985? 
SELECT count(*) as emp_1985_count
from dbo.employee
where YEAR(hire_date) = 1985;

-- 9. How many employees joined each month in 1985? 
SELECT Month(hire_date) as months, count(*) as emp_count
from dbo.employee
WHERE YEAR(hire_date) = 1985
Group by Month(hire_date);


-- 10. How many employees were joined in April 1985? 
SELECT count(*) as april_1985_count
from dbo.employee
where MONTH(hire_date) = 4 and year(hire_date) = 1985;

/* 11. Which is the Department ID 
having greater than or equal to 3 employees 
joining in April 1985?
*/
SELECT department_id,  count(*) as april_1985_count
from dbo.employee
where MONTH(hire_date) = 4 
and YEAR(hire_date) = 1985
GROUP BY Department_Id
HAVING COUNT(*) >= 3;

--Joins: 
--1. List out employees with their department names. 
SELECT em.*, dp.name from dbo.employee as em
JOIN dbo.department as dp
ON em.department_id = dp.department_id;

-- 2. Display employees with their designations. 
SELECT em.*, jb.designation from dbo.employee as em
JOIN dbo.job as jb
ON em.job_id = jb.job_id;

-- 3. Display the employees with their department names and city. 
SELECT em.*, dp.name, lo.city FROM dbo.employee as em
JOIN dbo.department as dp
ON em.department_id = dp.department_id
JOIN dbo.location as lo
ON dp.location_id = lo.location_id;

-- 4. How many employees are working in different departments? Display with department names. 
SELECT dp.name as department_name, count(*) as emp_count
FROM dbo.employee as em
JOIN dbo.department as dp
ON em.department_id = dp.department_id
GROUP BY dp.name;

-- 5. How many employees are working in the sales department? 
SELECT count(*) as emp_count
FROM dbo.employee as em
JOIN dbo.department as dp
ON em.department_id = dp.department_id
Where dp.name = 'Sales';

/*6. Which is the department having greater than or equal to 3 
employees and display the department names in ascending order.
*/
SELECT dp.name as department_name, count(*) as emp_count
FROM dbo.employee as em
JOIN dbo.department as dp
ON em.department_id = dp.department_id
GROUP By dp.name
Having count(*) >=3
order by dp.name;

-- 7. How many employees are working in 'Dallas'? 
SELECT count(*) as emp_count FROM dbo.employee as em
JOIN dbo.department as dp
ON em.department_id = dp.department_id
JOIN dbo.location as lo
ON dp.location_id = lo.location_id
where lo.city = 'Dallas';

-- 8. Display all employees in sales or operation departments. 
SELECT E.*
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.Department_Id = D.Department_Id
WHERE D.Name IN ('Sales', 'Operations');


-- CONDITIONAL STATEMENT 
/*1. Display the employee details with salary grades. 
Use conditional statement to create a grade column. 
*/
SELECT *,
     CASE 
           WHEN Salary >= 3000 THEN 'A'
           WHEN Salary BETWEEN 2000 AND 2999 THEN 'B'
           WHEN Salary BETWEEN 1000 AND 1999 THEN 'C'
           ELSE 'D'
       END AS Grade
From dbo.EMPLOYEE;
/*
2. List out the number of employees grade wise. 
Use conditional statement to create a grade column. 
*/
SELECT
     CASE 
           WHEN Salary >= 3000 THEN 'A'
           WHEN Salary BETWEEN 2000 AND 2999 THEN 'B'
           WHEN Salary BETWEEN 1000 AND 1999 THEN 'C'
           ELSE 'D'
       END AS grade,
       Count(*) as total_employe
From dbo.EMPLOYEE
GROUP BY 
    CASE 
           WHEN Salary >= 3000 THEN 'A'
           WHEN Salary BETWEEN 2000 AND 2999 THEN 'B'
           WHEN Salary BETWEEN 1000 AND 1999 THEN 'C'
           ELSE 'D'
       END;
/*
3. Display the employee salary grades and the number of employees between 
2000 to 5000 range of salary. 
*/
SELECT
     CASE 
           WHEN Salary >= 3000 THEN 'A'
           WHEN Salary BETWEEN 2000 AND 2999 THEN 'B'
           WHEN Salary BETWEEN 1000 AND 1999 THEN 'C'
           ELSE 'D'
       END AS grade,
       Count(*) as total_employe
From dbo.EMPLOYEE
WHERE Salary BETWEEN 2000 AND 5000
GROUP BY 
    CASE 
           WHEN Salary >= 3000 THEN 'A'
           WHEN Salary BETWEEN 2000 AND 2999 THEN 'B'
           WHEN Salary BETWEEN 1000 AND 1999 THEN 'C'
           ELSE 'D'
       END;

-- Subqueries: 
-- 1. Display the employees list who got the maximum salary.
SELECT * FROM dbo.EMPLOYEE 
WHERE salary = (
                SELECT max(salary) 
                from dbo.EMPLOYEE);

-- 2. Display the employees who are working in the sales department. 
SELECT * FROM dbo.EMPLOYEE 
WHERE DEPARTMENT_ID = (
                SELECT DEPARTMENT_ID 
                from dbo.DEPARTMENT
                WHERE name = 'sales');
-- 3. Display the employees who are working as 'Clerk'.
SELECT * FROM dbo.EMPLOYEE 
WHERE JOB_ID = (
                SELECT JOB_ID 
                from dbo.JOB
                WHERE Designation = 'clerk');

-- 4. Display the list of employees who are living in 'Boston'. 
SELECT * FROM dbo.EMPLOYEE 
WHERE DEPARTMENT_ID = (
                SELECT DEPARTMENT_ID 
                from dbo.DEPARTMENT
                WHERE Location_Id = (
                    SELECT Location_Id FROM LOCATION
                    WHERE city = 'Boston'
                )
            );

/*
5. Find out the number of employees
working in the sales department. 
*/
SELECT count(*) as emp_count FROM dbo.EMPLOYEE 
WHERE DEPARTMENT_ID = (
                SELECT DEPARTMENT_ID 
                from dbo.DEPARTMENT
                WHERE name = 'sales');

/*
6. Update the salaries of employees who are working as clerks 
on the basis of 10%.
*/
UPDATE EMPLOYEE
SET Salary = Salary * 1.10
WHERE Job_Id = (
    SELECT Job_Id FROM JOB WHERE Designation = 'Clerk'
);

-- 7. Display the second highest salary drawing employee details. 
SELECT * FROM EMPLOYEE
WHERE Salary = (
    SELECT MAX(Salary) FROM EMPLOYEE
    WHERE Salary < (
        SELECT MAX(Salary) FROM EMPLOYEE
    )
);
/*
8. List out the employees who earn more than every employee 
in department 30. 
*/
SELECT * FROM EMPLOYEE
WHERE Salary > ALL (
    SELECT Salary FROM EMPLOYEE WHERE Department_Id = 30
);

-- 9. Find out which department has no employees. 
SELECT * FROM DEPARTMENT
WHERE Department_Id NOT IN (
    SELECT DISTINCT Department_Id FROM EMPLOYEE
);

/*
10. Find out the employees who earn greater than the 
average salary for their department. 
*/
SELECT * FROM EMPLOYEE E
WHERE Salary > (
    SELECT AVG(Salary) FROM EMPLOYEE
    WHERE Department_Id = E.Department_Id
);