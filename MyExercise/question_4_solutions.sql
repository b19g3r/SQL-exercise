-- https://en.wikibooks.org/wiki/SQL_Exercises/Movie_theatres

-- 4.1
-- Select the title of all Movies.
select title from Movies;

-- 4.2
-- Show all the distinct ratings in the database.
select distinct rating from Movies;

-- 4.3
-- Show all unrated Movies.
select *
from Movies
where rating is NULL;

-- 4.4
-- Select all movie theaters that are not currently showing a movie.
select * from MovieTheaters
where Movie is NULL;

-- 4.5
-- Select all data from all movie theaters
-- and, additionally, the data from the movie that is being shown in the theater (if one is being shown).

-- This query below would fail as it will only return the theaters with Movies shown.
-- we need to use left outer join instead.
-- This is a great example to demonstrate why we need to use left join rather than inner join sometimes.
select *
from MovieTheaters join Movies
on MovieTheaters.movie = Movies.code;

-- correct query
SELECT *
   FROM MovieTheaters LEFT JOIN Movies
   ON MovieTheaters.Movie = Movies.Code;


-- 4.6
-- Select all data from all Movies and, if that movie is being shown in a theater, show the data from the theater.

-- the query below would fail
select *
from Movies right join MovieTheaters
on Movies.code = MovieTheaters.movie;

-- Correct solution
 SELECT *
   FROM MovieTheaters RIGHT JOIN Movies
   ON MovieTheaters.Movie = Movies.Code;
 -- or
 SELECT *
   FROM Movies LEFT JOIN MovieTheaters
   ON Movies.Code = MovieTheaters.Movie;

-- 4.7
-- Show the titles of Movies not currently being shown in any theaters.
-- VERY IMPORTANT!!!

-- the query below would FAIL due to the NULL value returned by the subquery !!!
select title
from Movies
where code not in (
select movie from MovieTheaters
);

 /* With JOIN */
 SELECT Movies.Title
   FROM MovieTheaters RIGHT JOIN Movies
   ON MovieTheaters.Movie = Movies.Code
   WHERE MovieTheaters.Movie IS NULL;

 /* With subquery */
 SELECT Title FROM Movies
   WHERE Code NOT IN
   (
     SELECT Movie FROM MovieTheaters
     WHERE Movie IS NOT NULL
   );


 -- 4.8
-- Add the unrated movie "One, Two, Three".

INSERT INTO Movies(Title,Rating) VALUES('One, Two, Three',NULL);


-- 4.9
-- Set the rating of all unrated Movies to "G".
UPDATE Movies
SET Rating = 'G'
WHERE Rating is NULL;

-- 4.10
-- Remove movie theaters projecting Movies rated "NC-17".
delete from MovieTheaters
where Movie in (
select Code from Movies where Rating = 'NC-17'
);
