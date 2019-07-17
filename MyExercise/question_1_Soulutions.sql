-- LINK: https://en.wikibooks.org/wiki/SQL_Exercises/The_computer_store
use leaning_db;

-- 1.1 Select the names of all the Products in the store.
select Name
from Products;

-- 1.2 Select the names and the prices of all the Products in the store.
select name, price
from Products;

-- 1.3 Select the name of the Products with a price less than or equal to $200.
select name
from Products
where price <= 200;


-- 1.4 Select all the Products with a price between $60 and $120.
select *
from Products
where price between 60 and 120;
select *
from Products
where price >= 60
  and price <= 120;

-- 1.5 Select the name and price in cents (i.e., the price must be multiplied by 100).
select name, price * 100
from Products;

select name, concat(price * 100, ' cents')
from Products;

-- 1.6 Compute the average price of all the Products.
select avg(price)
from Products;
select sum(price) / count(price)
from Products;

-- 1.7 Compute the average price of all Products with manufacturer code equal to 2.
select avg(price)
from Products
where Manufacturer = 2;

-- 1.8 Compute the number of Products with a price larger than or equal to $180.
select count(*)
from Products
where price >= 180;

-- 1.9 Select the name and price of all Products with a price larger than or equal to $180, and sort first by price (in descending order), and then by name (in ascending order).
select name, price
from Products
where price >= 180
order by price desc, name asc;

-- 1.10 Select all the data from the Products, including all the data for each product's manufacturer.
select a.*, b.name
from Products a
         join Manufacturers b on (a.manufacturer = b.code);
select a.*, b.name
from Products a,
     Manufacturers b
where a.manufacturer = b.code;

-- 1.11 Select the product name, price, and manufacturer name of all the Products.
select a.name, a.price, b.name
from Products a
         join Manufacturers b on (a.manufacturer = b.code);

SELECT Products.Name, Price, Manufacturers.Name
FROM Products
         INNER JOIN Manufacturers
                    ON Products.Manufacturer = Manufacturers.Code;

-- 1.12 Select the average price of each manufacturer's Products, showing only the manufacturer's code.
SELECT AVG(Price), Manufacturer
FROM Products
GROUP BY Manufacturer;


-- 1.13 Select the average price of each manufacturer's Products, showing the manufacturer's name.
select avg(a.price), b.name
from Products a
         join Manufacturers b
              on a.manufacturer = b.code
group by b.name;


-- 1.14 Select the names of manufacturer whose Products have an average price larger than or equal to $150.
select avg(a.price), b.name
from Manufacturers b
         join Products a
              on b.code = a.Manufacturer
group by b.name
having avg(a.price) >= 150;

SELECT AVG(Price), Manufacturers.Name
FROM Products,
     Manufacturers
WHERE Products.Manufacturer = Manufacturers.Code
GROUP BY Manufacturers.Name
HAVING AVG(Price) >= 150;


-- 1.15 Select the name and price of the cheapest product.
select name, price
from Products
where price = (
    select min(price)
    from Products);

SELECT name, price
FROM Products
ORDER BY price ASC
LIMIT 1;

--SQL SERVER SOLUTION (T-SQL)
SELECT TOP 1 name
     , price
FROM Products
ORDER BY price ASC


-- 1.16 Select the name of each manufacturer along with the name and price of its most expensive product.
select max_price_mapping.name as manu_name, max_price_mapping.price, Products_with_manu_name.name as product_name
from (SELECT Manufacturers.Name, MAX(Price) price
      FROM Products,
           Manufacturers
      WHERE Manufacturer = Manufacturers.Code
      GROUP BY Manufacturers.Name)
         as max_price_mapping
         left join
     (select Products.*, Manufacturers.name manu_name
      from Products
               join Manufacturers
                    on (Products.manufacturer = Manufacturers.code))
         as Products_with_manu_name
     on
         (max_price_mapping.name = Products_with_manu_name.manu_name
             and
          max_price_mapping.price = Products_with_manu_name.price);

-- 1 max_price_mapping
SELECT Manufacturers.Name, MAX(Price) price
      FROM Products,
           Manufacturers
      WHERE Manufacturer = Manufacturers.Code
      GROUP BY Manufacturers.Name;

-- 2 Products_with_manu_name
select Products.*, Manufacturers.name manu_name
      from Products
               join Manufacturers
                    on (Products.manufacturer = Manufacturers.code)

-- 1.17 Add a new product: Loudspeakers, $70, manufacturer 2.
insert into Products
values (11, 'Loudspeakers', 70, 2);


-- 1.18 Update the name of product 8 to "Laser Printer".
update Products
set name = 'Laser Printer'
where code = 8;

-- 1.19 Apply a 10% discount to all Products.
update Products
set price=price * 0.9;


-- 1.20 Apply a 10% discount to all Products with a price larger than or equal to $120.
update Products
set price = price * 0.9
where price >= 120;


