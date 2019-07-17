-- LINK : https://en.wikibooks.org/wiki/SQL_Exercises/Employee_management

-- 2.1 Select the last name of all Employees.
select LastName
from Employees;


-- 2.2 Select the last name of all Employees, without duplicates.
select distinct LastName
from Employees;


-- 2.3 Select all the data of Employees whose last name is "Smith".
select *
from Employees
where lastname = 'Smith';


-- 2.4 Select all the data of Employees whose last name is "Smith" or "Doe".
select *
from Employees
where lastname in ('Smith', 'Doe');
select *
from Employees
where lastname = 'Smith'
   or lastname = 'Doe';


-- 2.5 Select all the data of Employees that work in department 14.
select *
from Employees
where department = 14;

-- 2.6 Select all the data of Employees that work in department 37 or department 77.
select *
from Employees
where department = 37
   or department = 77;
select *
from Employees
where department in (37, 77);


-- 2.7 Select all the data of Employees whose last name begins with an "S".
select *
from Employees
where LastName like 'S%';


-- 2.8 Select the sum of all the Departments' budgets.
select sum(budget)
from Departments;

select Name, sum(Budget)
from Departments
group by Name;


-- 2.9 Select the number of Employees in each department (you only need to show the department code and the number of Employees).
select Department, count(*)
from Employees
group by department;

SELECT Department, COUNT(*)
FROM Employees
GROUP BY Department;


-- 2.10 Select all the data of Employees, including each employee's department's data.
select a.*, b.*
from Employees a
         join Departments b on a.department = b.code;

SELECT SSN, E.Name AS Name_E, LastName, D.Name AS Name_D, Department, Code, Budget
FROM Employees E
         INNER JOIN Departments D
                    ON E.Department = D.Code;


-- 2.11 Select the name and last name of each employee, along with the name and budget of the employee's department.
select a.name, a.lastname, b.name Department_name, b.Budget
from Employees a
         join Departments b
              on a.department = b.code;

/* Without labels */
SELECT Employees.Name, LastName, Departments.Name AS DepartmentsName, Budget
FROM Employees
         INNER JOIN Departments
                    ON Employees.Department = Departments.Code;

/* With labels */
SELECT E.Name, LastName, D.Name AS DepartmentsName, Budget
FROM Employees E
         INNER JOIN Departments D
                    ON E.Department = D.Code;


-- 2.12 Select the name and last name of Employees working for Departments with a budget greater than $60,000.
select name, lastname
from Employees
where department in (
    select code
    from Departments
    where Budget > 60000
);

/* Without subquery */
SELECT Employees.Name, LastName
FROM Employees
         INNER JOIN Departments
                    ON Employees.Department = Departments.Code
                        AND Departments.Budget > 60000;

/* With subquery */
SELECT Name, LastName
FROM Employees
WHERE Department IN
      (SELECT Code FROM Departments WHERE Budget > 60000);


-- 2.13 Select the Departments with a budget larger than the average budget of all the Departments.
select *
from Departments
where budget > (
    select avg(budget)
    from Departments
);

SELECT *
FROM Departments
WHERE Budget >
      (
          SELECT AVG(Budget)
          FROM Departments
      );


-- 2.14
-- Select the names of Departments with more than two Employees.
select b.name
from Departments b
where code in (
    select department
    from Employees
    group by department
    having count(*) > 2
);

/* With subquery */
SELECT Name
FROM Departments
WHERE Code IN
      (
          SELECT Department
          FROM Employees
          GROUP BY Department
          HAVING COUNT(*) > 2
      );

/* With UNION. This assumes that no two Departments have
   the same name */
SELECT Departments.Name
FROM Employees
         INNER JOIN Departments
                    ON Department = Code
GROUP BY Departments.Name
HAVING COUNT(*) > 2;


-- 2.15
-- Very Important
-- Select the name and last name of Employees working for Departments with second lowest budget.

select name, lastname
from Employees
where department = (
    select temp.code
    from (select * from Departments order by budget limit 2) temp
    order by temp.budget desc
    limit 1
);


/* With subquery */
SELECT e.Name, e.LastName
FROM Employees e
WHERE e.Department = (
    SELECT sub.Code
    FROM (SELECT * FROM Departments d ORDER BY d.budget LIMIT 2) sub
    ORDER BY budget DESC
    LIMIT 1);


-- 2.16
-- Add a new department called "Quality Assurance", with a budget of $40,000 and departmental code 11.
-- Add an employee called "Mary Moore" in that department, with SSN 847-21-9811.
insert into Departments
values (11, 'Quality Assurance', 40000);
insert into Employees
values (847219811, 'Mary', 'Moore', 11);


-- 2.17
-- Reduce the budget of all Departments by 10%.
update Departments
set budget = 0.9 * budget;


-- 2.18
-- Reassign all Employees from the Research department (code 77) to the IT department (code 14).
update Employees
set department = 14
where department = 77;

-- 2.19
-- Delete from the table all Employees in the IT department (code 14).

delete
from Employees
where department = 14;

-- 2.20
-- Delete from the table all Employees who work in Departments with a budget greater than or equal to $60,000.
delete
from Employees
where department in (
    select code
    from Departments
    where budget >= 60000
);


-- 2.21
-- Delete from the table all Employees.
delete
from Employees;
