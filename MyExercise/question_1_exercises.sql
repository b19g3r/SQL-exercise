-- LINK: https://en.wikibooks.org/wiki/SQL_Exercises/The_computer_store
use leaning_db;
-- 1.1 Select the names of all the products in the store.
select name
from Products;
-- 1.2 Select the names and the prices of all the products in the store.
select name, Price
from Products;
-- 1.3 Select the name of the products with a price less than or equal to $200.
select name
from Products
where Price <= 200;
-- 1.4 Select all the products with a price between $60 and $120.
select *
from Products
where Price between 60 and 120;
-- 1.5 Select the name and price in cents (i.e., the price must be multiplied by 100).
select name, price * 100 as cents
from Products;
-- 1.6 Compute the average price of all the products.
select avg(Price)
from Products;
-- 1.7 Compute the average price of all products with manufacturer code equal to 2.
select avg(Price)
from Products
where Manufacturer = 2;
-- 1.8 Compute the number of products with a price larger than or equal to $180.
select count(1)
from Products
where Price >= 180;
-- 1.9 Select the name and price of all products with a price larger than or equal to $180, and sort first by price (in descending order), and then by name (in ascending order).
select name, price
from Products
where Price >= 180
order by price desc, name asc;
-- 1.10 Select all the data from the products, including all the data for each product's manufacturer.
select *
from Products,
     Manufacturers
where Products.Manufacturer = Manufacturers.Code;
-- or
select *
from Products
         join Manufacturers M on Products.Manufacturer = M.Code;
-- 1.11 Select the product name, price, and manufacturer name of all the products.
select P.name, price, M.name as name
from Products P
         join Manufacturers M on P.Manufacturer = M.Code;
-- 1.12 Select the average price of each manufacturer's products, showing only the manufacturer's code.
select avg(Price), Manufacturer
from Products
group by Manufacturer;
-- 1.13 Select the average price of each manufacturer's products, showing the manufacturer's name.
select avg(Price), M.name ManufacturerName
from Products
         join Manufacturers M on Products.Manufacturer = M.Code
group by Manufacturer;
-- 1.14 Select the names of manufacturer whose products have an average price larger than or equal to $150.
select avg(Price), M.name ManufacturerName
from Products
         join Manufacturers M on Products.Manufacturer = M.Code
group by Manufacturer
having avg(Price) > 150;
-- 1.15 Select the name and price of the cheapest product.
select name, price
from Products
where Price = (select min(Price) from Products);

select name, price
from Products
order by Price
limit 0,1;
-- 1.16 Select the name of each manufacturer along with the name and price of its most expensive product.
-- 查询每个厂家最贵的商品

select max(Price), M.name
from Products P
         join Manufacturers M on P.Manufacturer = M.Code
group by P.Manufacturer
order by M.code;

select  M_with_max_p.Name menu_name, Products.Price price, Products.name product_name
from Products
         join (select max(Price) max_price, P.Manufacturer M_code, M.name
               from Products P
                        join Manufacturers M on P.Manufacturer = M.Code
               group by P.Manufacturer) M_with_max_p on (Products.Manufacturer = M_with_max_p.M_code
    and Products.Price = M_with_max_p.max_price)
order by menu_name;


-- step1
select Products.*, Manufacturers.name manu_name
from Products
         join Manufacturers
              on (Products.manufacturer = Manufacturers.code);
# result: Products_with_manu_name
# +------+-----------------+-------+--------------+-----------------+
# | Code | Name            | Price | Manufacturer | manu_name       |
# +------+-----------------+-------+--------------+-----------------+
# |    1 | Hard drive      |   240 |            5 | Fujitsu         |
# |    2 | Memory          |   120 |            6 | Winchester      |
# |    3 | ZIP drive       |   150 |            4 | Iomega          |
# |    4 | Floppy disk     |     5 |            6 | Winchester      |
# |    5 | Monitor         |   240 |            1 | Sony            |
# |    6 | DVD drive       |   180 |            2 | Creative Labs   |
# |    7 | CD drive        |    90 |            2 | Creative Labs   |
# |    8 | Printer         |   270 |            3 | Hewlett-Packard |
# |    9 | Toner cartridge |    66 |            3 | Hewlett-Packard |
# |   10 | DVD burner      |   180 |            2 | Creative Labs   |
# +------+-----------------+-------+--------------+-----------------+


-- step2
SELECT Manufacturers.Name, MAX(Price) price
FROM Products,
     Manufacturers
WHERE Manufacturer = Manufacturers.Code
GROUP BY Manufacturers.Name

# result: max_price_mapping, max price of every Manufacture
# +-----------------+-------+
# | Name            | price |
# +-----------------+-------+
# | Creative Labs   |   180 |
# | Fujitsu         |   240 |
# | Hewlett-Packard |   270 |
# | Iomega          |   150 |
# | Sony            |   240 |
# | Winchester      |   120 |
# +-----------------+-------+


-- 1.17 Add a new product: Loudspeakers, $70, manufacturer 2.
insert into Products(Code, Name, Price, Manufacturer) value (11, 'Loudspeakers', 70, 2);

select * from Products;

-- 1.18 Update the name of product 8 to "Laser Printer".
update Products set Name = 'Laser Printer' where Code = 8;

-- 1.19 Apply a 10% discount to all products.

update Products set Price = Price*0.9;

-- 1.20 Apply a 10% discount to all products with a price larger than or equal to $120.

update Products set Price = Price*0.9 where Price >= 120;