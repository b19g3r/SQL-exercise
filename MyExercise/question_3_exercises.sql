-- The Warehouse
-- lINK: https://en.wikibooks.org/wiki/SQL_Exercises/The_warehouse
-- 3.1 Select all warehouses.
select * from Warehouses;

-- 3.2 Select all boxes with a value larger than $150.
select * from Boxes where Value > 150;

-- 3.3 Select all distinct contents in all the boxes.
select distinct Contents from Boxes;

-- 3.4 Select the average value of all the boxes.
select avg(Value) from Boxes;

-- 3.5 Select the warehouse code and the average value of the boxes in each warehouse.
select Warehouse, avg(value) from Boxes group by Warehouse;

-- 3.6 Same as previous exercise, but select only those warehouses where the average value of the boxes is greater than 150.
select Warehouse, avg(value) as avg_value
from Boxes
group by Warehouse
having avg_value > 150;


-- 3.7 Select the code of each box, along with the name of the city the box is located in.
select B.code, W.Location
from Boxes B
         join Warehouses W on B.Warehouse = W.Code;

-- 3.8 Select the warehouse codes, along with the number of boxes in each warehouse.
-- Optionally, take into account that some warehouses are empty (i.e., the box count should show up as zero, instead of omitting the warehouse from the result).
select W.Code, count(*) from Warehouses W join Boxes B on W.Code = B.Warehouse group by W.Code;

select Warehouse, count(*) from Boxes group by Warehouse;



-- 3.9 Select the codes of all warehouses that are saturated (a warehouse is saturated if the number of boxes in it is larger than the warehouse's capacity).
select code
from Warehouses W
         join (select count(*) num, Warehouse from Boxes group by Warehouse) T
              on T.Warehouse = W.Code and T.num > W.Capacity;

select Code
from Warehouses W
where Capacity < (select count(*) from Boxes where Warehouse = W.Code);



-- 3.10 Select the codes of all the boxes located in Chicago.
select Code from Boxes where Warehouse in (select code from Warehouses where Location = 'Chicago');

select B.code
from Boxes B
         join Warehouses W on B.Warehouse = W.Code
    and W.Location = 'Chicago';

-- 3.11 Create a new warehouse in New York with a capacity for 3 boxes.
insert into Warehouses value (6, 'New York', 3);

-- 3.12 Create a new box, with code "H5RT", containing "Papers" with a value of $200, and located in warehouse 2.
insert into Boxes value ('H5RT', 'Papers', 200, 2);

-- 3.13 Reduce the value of all boxes by 15%.
update Boxes set Value = Value * 0.85;

-- 3.14 Remove all boxes with a value lower than $100.
select * from Boxes where Value < 100;

-- 3.15 Remove all boxes from saturated warehouses.
select *
from Boxes
where Warehouse in (
    select code from Warehouses where Capacity < (select count(*) from Boxes where Warehouse = Warehouses.code));


-- saturated warehouses
select code
from Warehouses W
         join (select count(*) num, Warehouse from Boxes group by Warehouse) T
              on T.Warehouse = W.Code and T.num > W.Capacity;


select Boxes.code
from Boxes
         join (select code
               from Warehouses W
                        join (select count(*) num, Warehouse from Boxes group by Warehouse) T
                             on T.Warehouse = W.Code and T.num > W.Capacity) temp
              on Boxes.Warehouse = temp.Code;


-- 3.16 Add Index for column "Warehouse" in table "boxes"
-- !!!NOTE!!!: index should NOT be used on small tables in practice
create index ware_idx on Boxes(Warehouse);



-- 3.17 Print all the existing indexes
-- !!!NOTE!!!: index should NOT be used on small tables in practice
show index from Boxes from leaning_db;
show index from leaning_db.Boxes;


-- 3.18 Remove (drop) the index you added just
alter table Boxes drop foreign key Boxes_ibfk_1;

drop index ware_idx on Boxes;

-- !!!NOTE!!!: index should NOT be used on small tables in practice


