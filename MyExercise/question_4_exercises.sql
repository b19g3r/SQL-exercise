-- https://en.wikibooks.org/wiki/SQL_Exercises/Movie_theatres
-- 4.1 Select the title of all movies.
select Title from Movies;

-- 4.2 Show all the distinct ratings in the database.
select DISTINCT Rating from Movies;

-- 4.3  Show all unrated movies.
select * from Movies where Rating is null;

-- 4.4 Select all movie theaters that are not currently showing a movie.
select * from MovieTheaters where Movie is NULL;

-- 4.5 Select all data from all movie theaters
    -- and, additionally, the data from the movie that is being shown in the theater (if one is being shown).
select MovieTheaters.*, Movies.Title, Movies.Rating
from MovieTheaters
         left join Movies on MovieTheaters.Movie = Movies.Code;

-- 4.6 Select all data from all movies and, if that movie is being shown in a theater, show the data from the theater.
select Movies.*, MT.Code, name
from Movies
         left join MovieTheaters MT on Movies.Code = MT.Movie;

-- 4.7 Show the titles of movies not currently being shown in any theaters.
-- 参考: https://www.cnblogs.com/xwdreamer/archive/2012/06/01/2530597.html
select Movies.Title
from Movies
         left join MovieTheaters MT on Movies.Code = MT.Movie
where MT.Movie is NULL;

select Title
from Movies
where code not in (
    select Movie
    from MovieTheaters
    where Movie IS NOT null
);


-- 4.8 Add the unrated movie "One, Two, Three".
insert into Movies (Code)
values ('One, Two, Three');

-- 4.9 Set the rating of all unrated movies to "G".
update Movies set Rating = 'G' where Rating is NULL;

-- 4.10 Remove movie theaters projecting movies rated "NC-17".
select *
from MovieTheaters
where Movie = (select code from Movies where Rating = 'NC-17');

