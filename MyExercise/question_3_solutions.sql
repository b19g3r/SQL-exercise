--  The Warehouse
--  lINK: https://en.wikibooks.org/wiki/SQL_Exercises/The_warehouse

--  3.1
--   Select all Warehouses.
select * from Warehouses;

--  3.2
--   Select all Boxes with a value larger than $150.
select * from Boxes where Value>150;

-- 3.3
--  Select all distinct contents in all the Boxes.
select distinct contents from Boxes;

-- 3.4
--  Select the average value of all the Boxes.
select avg(value) from Boxes;

-- 3.5
--  Select the warehouse code and the average value of the Boxes in each warehouse.
select warehouse, avg(value) from Boxes group by warehouse;

SELECT Warehouse, AVG(Value)
    FROM Boxes
GROUP BY Warehouse;

-- 3.6
--  Same as previous exercise, but select only those Warehouses where the average value of the Boxes is greater than 150.
select warehouse, avg(value)
from Boxes
group by warehouse
having avg(value)> 150;


-- 3.7
--  Select the code of each box, along with the name of the city the box is located in.
select Boxes.code, Warehouses.location
from Boxes join Warehouses
on Boxes.Warehouse = Warehouses.Code;

SELECT Boxes.Code, Location
      FROM Warehouses
INNER JOIN Boxes ON Warehouses.Code = Boxes.Warehouse;


-- 3.8
--  Select the warehouse codes, along with the number of Boxes in each warehouse.
--  Optionally, take into account that some Warehouses are empty (i.e., the box count should show up as zero, instead of omitting the warehouse from the result).
select Warehouse, count(*)
from Boxes
group by warehouse;


-- 3.9
--  Select the codes of all Warehouses that are saturated (a warehouse is saturated if the number of Boxes in it is larger than the warehouse's capacity).
select Code
from Warehouses join (select warehouse temp_a, count(*) temp_b from Boxes group by warehouse) temp
on (Warehouses.code = temp.temp_a)
where Warehouses.Capacity<temp.temp_b;


SELECT Code
   FROM Warehouses
   WHERE Capacity <
   (
     SELECT COUNT(*)
       FROM Boxes
       WHERE Warehouse = Warehouses.Code
   );



-- 3.10
--  Select the codes of all the Boxes located in Chicago.

select Boxes.code
from Boxes join Warehouses
on Boxes.warehouse = Warehouses.code
where Warehouses.location = 'Chicago';

/* Without subqueries */
 SELECT Boxes.Code
   FROM Warehouses LEFT JOIN Boxes
   ON Warehouses.Code = Boxes.Warehouse
   WHERE Location = 'Chicago';

 /* With a subquery */
 SELECT Code
   FROM Boxes
   WHERE Warehouse IN
   (
     SELECT Code
       FROM Warehouses
       WHERE Location = 'Chicago'
   );


-- 3.11
--  Create a new warehouse in New York with a capacity for 3 Boxes.
INSERT INTO Warehouses VALUES (6, 'New York', 3);


-- 3.12
--  Create a new box, with code "H5RT", containing "Papers" with a value of $200, and located in warehouse 2.
INSERT INTO Boxes VALUES('H5RT', 'Papers', 200, 2);


-- 3.13
--  Reduce the value of all Boxes by 15%.
update Boxes
set value = value * 0.85;


-- 3.14
--  Remove all Boxes with a value lower than $100.
delete from Boxes
where value < 100;

--  3.15
--  Remove all Boxes from saturated Warehouses.
select * from Boxes
where warehouse in
(
SELECT Code
   FROM Warehouses
   WHERE Capacity <
   (
     SELECT COUNT(*)
       FROM Boxes
       WHERE Warehouse = Warehouses.Code
   )
);

--  3.16
--  Add Index for column "Warehouse" in table "Boxes"
--  !!!NOTE!!!: index should NOT be used on small tables in practice
CREATE INDEX INDEX_WAREHOUSE ON Boxes (warehouse);

--  3.17
--  Print all the existing indexes
--  !!!NOTE!!!: index should NOT be used on small tables in practice

--  MySQL
SHOW INDEX FROM Boxes FROM leaning_db;
SHOW INDEX FROM leaning_db.Boxes;

/*--  SQLite
.indexes Boxes
--  OR
SELECT * FROM SQLITE_MASTER WHERE type = "index";

--  Oracle
select INDEX_NAME, TABLE_NAME, TABLE_OWNER
from SYS.ALL_INDEXES
order by TABLE_OWNER, TABLE_NAME, INDEX_NAME*/

--  3.18
--  Remove (drop) the index you added just
--  !!!NOTE!!!: index should NOT be used on small tables in practice
DROP INDEX INDEX_WAREHOUSE;
