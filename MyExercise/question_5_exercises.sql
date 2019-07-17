-- https://en.wikibooks.org/wiki/SQL_Exercises/Pieces_and_providers
-- 5.1 Select the name of all the pieces.
select name from Pieces;

-- 5.2  Select all the providers' data.
select * from Providers;

-- 5.3 Obtain the average price of each piece (show only the piece code and the average price).
select Piece,avg(price) from Provides group by Piece;

-- 5.4  Obtain the names of all providers who supply piece 1.
select *
from Providers
         join Provides on Providers.Code = Provides.Provider and Piece = 1;


-- 5.5 Select the name of pieces provided by provider with code "HAL".
select Pieces.name
from Pieces
         join Provides P on Pieces.Code = P.Piece and Provider = 'HAL';


select Name
from Pieces
where Code in (select Piece from Provides where Provider = 'HAL');

select name
from Pieces
where EXISTS(
              select Piece
              from Provides
              where Provider = 'HAL'
                and Piece = Pieces.Code);


-- 5.6
-- ---------------------------------------------
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- Interesting and important one.
-- For each piece, find the most expensive offering of that piece and include the piece name, provider name, and price
-- (note that there could be two providers who supply the same piece at the most expensive price).
-- ---------------------------------------------
-- 查每组最贵的价格
select MAX(Price), Pieces.Code
from Pieces
         join Provides P on Pieces.Code = P.Piece
         join Providers P2 on P.Provider = P2.Code
group by Pieces.Code;


select Pieces.name, P2.Name, Price
from Pieces
         join Provides P on Pieces.Code = P.Piece
         join Providers P2 on P.Provider = P2.Code
where Price = (select MAX(Price) from Provides where Provides.Piece = Pieces.code);



select P4.Name, P3.Name, T.price
from Provides pr
         join Providers P3 on pr.Provider = P3.Code
         join Pieces P4 on pr.Piece = P4.Code
         join (select MAX(Price) price, Pieces.Code
               from Pieces
                        join Provides P on Pieces.Code = P.Piece
                        join Providers P2 on P.Provider = P2.Code
               group by Pieces.Code) T on (T.Code = pr.Piece and T.price = pr.Price);

-- 5.7 Add an entry to the database to indicate that "Skellington Supplies" (code "TNBC") will provide sprockets (code "1") for 7 cents each.
insert into Provides value (1, 'TNBC', 7);

-- 5.8 Increase all prices by one cent.
update Provides set Price = Piece + 1;

-- 5.9 Update the database to reflect that "Susan Calvin Corp." (code "RBT") will not supply bolts (code 4).
select * from Provides where Provider = 'RBT' and Piece = 4;

-- 5.10 Update the database to reflect that "Susan Calvin Corp." (code "RBT") will not supply any pieces
    -- (the provider should still remain in the database).
select * from Provides where Provider = 'RBT';