-- 9.1 give the total number of recordings in this table
select count(1)
from log;
-- 62325
-- 9.2 the number of packages listed in this table?
select count(package)
from log;
-- 62324

-- 9.3 How many times the package "Rcpp" was downloaded?

select count(*)
from log
where package = 'Rcpp';

-- 9.4 How many recordings are from China ("CN")?
select count(*)
from log
where country = 'CN';

-- 9.5 Give the package name and how many times they're downloaded. Order by the 2nd column descently.
select package, count(1)
from log
group by package
order by 2 desc;

-- 9.6 Give the package ranking (based on how many times it was downloaded) during 9AM to 11AM
-- wrong
select package, count(*)
from log
where substr(time, 1, 5) >= '09:00'
  and substr(time, 1, 5) <= '11:00'
group by package
order by 2 desc;
-- wrong !!!!!

-- correctly
select a.package, count(*)
from (select *
      from log
      where substr(time, 1, 5) < '11:00'
        and substr(time, 1, 5) > '09:00')
         as a
group by a.package
order by 2 desc;

-- 9.7 How many recordings are from China ("CN") or Japan("JP") or Singapore ("SG")?
select count(*)
from log
where country in ('CN', 'JP', 'SG');

-- 9.8 Print the countries whose downloaded are more than the downloads from China ("CN")
select country
from log
group by country
having count(*) > (select count(*) from log where country = 'cn');


SELECT TEMP.country
FROM (SELECT country,
             COUNT(*) AS downloads
      FROM log
      GROUP BY country) AS TEMP
WHERE TEMP.downloads > (SELECT COUNT(*)
                        FROM log
                        WHERE country = 'CN');

-- 9.9 Print the average length of the package name of all the UNIQUE packages
-- Answer1
select avg(alias.length)
from (select length(package) as length from log group by package) alias;

-- Answer2
SELECT AVG(LENGTH(package))
from log;

-- 9.10 Get the package whose downloading count ranks 2nd (print package name and it's download count).
select package, count(*) as num
from log
group by package
order by 2 desc
limit 1,1;

-- Answer2
SELECT temp.a package, temp.b count
FROM (
         SELECT package a, count(*) b
         FROM log
         GROUP BY package
         ORDER BY b DESC
         LIMIT 2
     ) temp
ORDER BY temp.b ASC
LIMIT 1;

-- 9.11 Print the name of the package whose download count is bigger than 1000.
SELECT package
FROM log
GROUP BY package
HAVING count(*) > 1000;

-- Solution 2 (with sub-query)
SELECT temp.package
FROM (
         SELECT package, COUNT(*) AS count
         FROM log
         GROUP BY package
     ) AS temp
WHERE temp.count > 1000;
-- 9.12 The field "r_os" is the operating system of the users.
-- 	Here we would like to know what main system we have (ignore version number), the relevant counts, and the proportion (in percentage).


select count(*)
from log;

select t1.os, concat(SUBSTR(t1.num / t2.num * 100, 1, 5), '%')
from (select SUBSTR(r_os, 1, 6) as os, count(*) as num from log group by os) as t1
         join (select count(*) as num from log) as t2;



SELECT SUBSTR(r_os, 1, 5) AS OS,
       COUNT(*)           AS Download_Count,
       SUBSTR(COUNT(*) / ((SELECT COUNT(*) FROM log) * 1.0) * 100, 1, 4) ||
       '%'                AS PROPORTION
FROM log
GROUP BY SUBSTR(r_os, 1, 5);