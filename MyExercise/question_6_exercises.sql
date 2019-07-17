-- https://en.wikibooks.org/wiki/SQL_Exercises/Scientists
-- 6.1 List all the scientists' names, their projects' names,
select Scientists.name, P.Name
from Scientists
         join AssignedTo A on Scientists.SSN = A.Scientist
         join Projects P on A.Project = P.Code;
-- and the hours worked by that scientist on each project,
select Scientists.name, P.name, P.Hours
from Scientists
         join AssignedTo A on Scientists.SSN = A.Scientist
         join Projects P on A.Project = P.Code
group by Project
order by Scientists.Name;
-- in alphabetical order of project name, then scientist name.


select Scientists.name, P.name, P.Hours
from Scientists
         join AssignedTo A on Scientists.SSN = A.Scientist
         join Projects P on A.Project = P.Code
group by Project
order by P.Name, Scientists.Name;


-- 6.2 Select the project names which are not assigned yet
-- see question4.7
-- solution1
select Projects.Name
from Projects
where not exists(
        select *
        from AssignedTo
        where Code = AssignedTo.Project
    );

-- solution2
select Projects.Name
from Projects
         left join AssignedTo A on Projects.Code = A.Project
where Project is NULL;

-- solution3
select Projects.Name
from Projects
where Code not in (select Project from AssignedTo);
