-- Chapter 14 Questions
USE sakila;

-- ---------------------------------------------------------------------------
-- 1. Create a view definition called `film_ctgry_actor` 
-- that can be used by the following query to generate 
-- the given results from this query:

SELECT title
,      category_name
,      first_name
,      last_name
FROM   film_ctgry_actor
WHERE  last_name = 'FAWCETT';

-- The view should produce the following result set:

-- +---------------------+---------------+------------+-----------+
-- | title               | category_name | first_name | last_name |
-- +---------------------+---------------+------------+-----------+
-- | ACE GOLDFINGER      | Horror        | BOB        | FAWCETT   |
-- | ADAPTATION HOLES    | Documentary   | BOB        | FAWCETT   |
-- | CHINATOWN GLADIATOR | New           | BOB        | FAWCETT   |
-- | CIRCUS YOUTH        | Children      | BOB        | FAWCETT   |
-- | CONTROL ANTHEM      | Comedy        | BOB        | FAWCETT   |
-- | DARES PLUTO         | Animation     | BOB        | FAWCETT   |
-- | DARN FORRESTER      | Action        | BOB        | FAWCETT   |
-- | DAZED PUNK          | Games         | BOB        | FAWCETT   |
-- | DYNAMITE TARZAN     | Classics      | BOB        | FAWCETT   |
-- | HATE HANDICAP       | Comedy        | BOB        | FAWCETT   |
-- | HOMICIDE PEACH      | Family        | BOB        | FAWCETT   |
-- | JACKET FRISCO       | Drama         | BOB        | FAWCETT   |
-- | JUMANJI BLADE       | New           | BOB        | FAWCETT   |
-- | LAWLESS VISION      | Animation     | BOB        | FAWCETT   |
-- | LEATHERNECKS DWARFS | Travel        | BOB        | FAWCETT   |
-- | OSCAR GOLD          | Animation     | BOB        | FAWCETT   |
-- | PELICAN COMFORTS    | Documentary   | BOB        | FAWCETT   |
-- | PERSONAL LADYBUGS   | Music         | BOB        | FAWCETT   |
-- | RAGING AIRPLANE     | Sci-Fi        | BOB        | FAWCETT   |
-- | RUN PACIFIC         | New           | BOB        | FAWCETT   |
-- | RUNNER MADIGAN      | Music         | BOB        | FAWCETT   |
-- | SADDLE ANTITRUST    | Comedy        | BOB        | FAWCETT   |
-- | SCORPION APOLLO     | Drama         | BOB        | FAWCETT   |
-- | SHAWSHANK BUBBLE    | Travel        | BOB        | FAWCETT   |
-- | TAXI KICK           | Music         | BOB        | FAWCETT   |
-- | BERETS AGENT        | Action        | JULIA      | FAWCETT   |
-- | BOILED DARES        | Travel        | JULIA      | FAWCETT   |
-- | CHISUM BEHAVIOR     | Family        | JULIA      | FAWCETT   |
-- | CLOSER BANG         | Comedy        | JULIA      | FAWCETT   |
-- | DAY UNFAITHFUL      | New           | JULIA      | FAWCETT   |
-- | HOPE TOOTSIE        | Classics      | JULIA      | FAWCETT   |
-- | LUKE MUMMY          | Animation     | JULIA      | FAWCETT   |
-- | MULAN MOON          | Comedy        | JULIA      | FAWCETT   |
-- | OPUS ICE            | Foreign       | JULIA      | FAWCETT   |
-- | POLLOCK DELIVERANCE | Foreign       | JULIA      | FAWCETT   |
-- | RIDGEMONT SUBMARINE | New           | JULIA      | FAWCETT   |
-- | SHANGHAI TYCOON     | Travel        | JULIA      | FAWCETT   |
-- | SHAWSHANK BUBBLE    | Travel        | JULIA      | FAWCETT   |
-- | THEORY MERMAID      | Animation     | JULIA      | FAWCETT   |
-- | WAIT CIDER          | Animation     | JULIA      | FAWCETT   |
-- +---------------------+---------------+------------+-----------+
-- 40 rows in set (0.39 sec)
-- ---------------------------------------------------------------------------


-- ---------------------------------------------------------------------------
-- 2. The film rental company manager would like to have a report 
-- that includes the name of every country, 
-- along with the total payments for all customers who live in each country. 
-- Generate a view definition that queries the country table 
-- and uses a correlated subquery that calculates a value 
-- for a column named tot_payments. 
-- (HINT: A correlated query like this works inside the SELECT-list.)

-- You should return 109 rows like these below:

-- +---------------------------------------+--------------+
-- | country                               | tot_payments |
-- +---------------------------------------+--------------+
-- | Afghanistan                           |        67.82 |
-- | Algeria                               |       383.10 |
-- | American Samoa                        |        71.80 |
-- | Angola                                |       215.48 |
-- ...
-- | Vietnam                               |       746.28 |
-- | Virgin Islands, U.S.                  |       122.68 |
-- | Yemen                                 |       510.83 |
-- | Yugoslavia                            |       259.43 |
-- | Zambia                                |       134.67 |
-- +---------------------------------------+--------------+
-- 109 rows in set (1.14 sec)
-- ---------------------------------------------------------------------------


-- ---------------------------------------------------------------------------
-- 3. Assuming you create the `film_ctgry_actor` view correctly from exercise #1, 
-- and create the `film_actor_count` view with the following query:

SELECT first_name
,        last_name
,        COUNT(*) AS films_by_actor
FROM     film_ctgry_actor
WHERE    last_name = 'FAWCETT'
GROUP BY first_name
,        last_name;

-- Then, you should insert the following row, as noted below:

INSERT INTO film_actor_count
( first_name
, last_name )
VALUES
('John','Doe');

-- 3.1 Answer the mutliple choice question
-- ---------------------------------------------------------------------------


-- ---------------------------------------------------------------------------
-- 4. Create an updatable film_actor_v view that 
-- joins the film, film_actor, and actor tables. 
-- The film_actor_v view should return the following 
-- when you describe it after creating it:

-- +----------------------+------------------------------------+------+-----+-------------------+
-- | Field                | Type                               | Null | Key | Default           |
-- +----------------------+------------------------------------+------+-----+-------------------+
-- | actor_id             | smallint unsigned                  | NO   |     | 0                 |
-- | first_name           | varchar(45)                        | NO   |     | NULL              |
-- | last_name            | varchar(45)                        | NO   |     | NULL              |
-- | last_update_actor    | timestamp                          | NO   |     | CURRENT_TIMESTAMP |
-- | film_id              | smallint unsigned                  | NO   |     | 0                 |
-- | title                | varchar(128)                       | NO   |     | NULL              |
-- | description          | text                               | YES  |     | NULL              |
-- | release_year         | year                               | YES  |     | NULL              |
-- | language_id          | tinyint unsigned                   | NO   |     | NULL              |
-- | original_language_id | tinyint unsigned                   | YES  |     | NULL              |
-- | rental_duration      | tinyint unsigned                   | NO   |     | 3                 |
-- | rental_rate          | decimal(4,2)                       | NO   |     | 4.99              |
-- | length               | smallint unsigned                  | YES  |     | NULL              |
-- | replacement_cost     | decimal(5,2)                       | NO   |     | 19.99             |
-- | rating               | enum('G','PG','PG-13','R','NC-17') | YES  |     | G                 |
-- | special_features     | set('Trailers','Commentaries',...) | YES  |     | NULL              |
-- | last_update_film     | timestamp                          | NO   |     | CURRENT_TIMESTAMP |
-- +----------------------+------------------------------------+------+-----+-------------------+
-- 17 rows in set (0.00 sec)
-- ---------------------------------------------------------------------------


-- ---------------------------------------------------------------------------
-- 5. Using the following query as a starting point, create a self-join film_franchise view that displays 'None' for the top-most element in a series of sequels because it has no prequel:

SELECT   f.title AS film
,        fp.title AS prequel
FROM     film f LEFT JOIN film fp
ON       f.prequel_id = fp.film_id
WHERE    f.series_name = 'Harry Potter'
AND      fp.series_name = 'Harry Potter'
ORDER BY f.series_number;

-- Hint: You need to use an IFNULL() and CASE statement to achieve the desired output. 
-- The output should display the following when you seed the film table with the 
-- Harry Potter franchise movies:

-- +----------------------------------------------+----------------------------------------------+
-- | film                                         | prequel                                      |
-- +----------------------------------------------+----------------------------------------------+
-- | Harry Potter and the Sorcerer's Stone        | None                                         |
-- | Harry Potter and the Chamber of Secrets      | Harry Potter and the Sorcerer's Stone        |
-- | Harry Potter and the Prisoner of Azkaban     | Harry Potter and the Chamber of Secrets      |
-- | Harry Potter and the Goblet of Fire          | Harry Potter and the Prisoner of Azkaban     |
-- | Harry Potter and the Order of the Phoenix    | Harry Potter and the Goblet of Fire          |
-- | Harry Potter and the Half Blood Prince       | Harry Potter and the Order of the Phoenix    |
-- | Harry Potter and the Deathly Hallows: Part 1 | Harry Potter and the Half Blood Prince       |
-- | Harry Potter and the Deathly Hallows: Part 2 | Harry Potter and the Deathly Hallows: Part 1 |
-- +----------------------------------------------+----------------------------------------------+
-- 8 rows in set (0.01 sec)

-- You will need to add three new columns to the film table and 
-- the following rows to the film table with the following set of INSERT statements. 
-- Copy the following (lines 186 - 491) into a seed.sql preparation script 
-- and run it before you begin working on the recursive query. 
-- Convert your query to a view when it works as noted above.

-- seed.sql
-- --------------------------------------------------
-- Use sakila database.
USE sakila;

-- Add a prequel_id column to the sakila.film table.
ALTER TABLE film
ADD (series_name    varchar(20)),
ADD (series_number  int unsigned),
ADD (prequel_id     int unsigned);
 
-- Set primary to foreign key local variable.
SET @sv_film_id = 0;
 
-- Insert Harry Potter films in sakila.film table with classic values clause.
INSERT INTO film
( title
, description
, release_year
, language_id
, original_language_id
, rental_duration
, rental_rate
, length
, replacement_cost
, rating
, special_features
, last_update
, series_name
, series_number
, prequel_id )
VALUES
('Harry Potter and the Sorcerer''s Stone'
,'A film about a young boy who on his eleventh birthday discovers, he is the orphaned boy of two powerful wizards and has unique magical powers.'
, 2001
, 1
, NULL
, 3
, 0.99
, 152
, 19.99
,'PG'
,'Trailers'
,'2001-11-04'
,'Harry Potter'
, 1
, NULL );
 
-- Assign the last generated primary key value to the local variable.
SET @sv_film_id := last_insert_id();
 
-- Insert 2nd film in sakila.film table with classic values clause.
INSERT INTO film
( title
, description
, release_year
, language_id
, original_language_id
, rental_duration
, rental_rate
, length
, replacement_cost
, rating
, special_features
, last_update
, series_name
, series_number
, prequel_id )
VALUES
('Harry Potter and the Chamber of Secrets'
,'A film where Harry returning to Hogwarts, still famous and a hero, when strange things start to happen ... people are turning to stone and no-one knows what, or who, is doing it.'
, 2002
, 1
, NULL
, 3
, 0.99
, 160
, 19.99
,'PG'
,'Trailers'
,'2002-11-15'
,'Harry Potter'
, 2
, @sv_film_id );
 
-- Assign the last generated primary key value to the local variable.
SET @sv_film_id := last_insert_id();
 
-- Insert 3rd film in sakila.film table with classic values clause.
INSERT INTO film
( title
, description
, release_year
, language_id
, original_language_id
, rental_duration
, rental_rate
, length
, replacement_cost
, rating
, special_features
, last_update
, series_name
, series_number
, prequel_id )
VALUES
('Harry Potter and the Prisoner of Azkaban'
,'A film where Harry, Ron, and Hermione return for their third year at Hogwarts and are forced to face escaped prisoner, Sirius Black.'
, 2004
, 1
, NULL
, 3
, 0.99
, 141
, 19.99
,'PG'
,'Trailers'
,'2004-06-04'
,'Harry Potter'
, 3
, @sv_film_id );
 
-- Assign the last generated primary key value to the local variable.
SET @sv_film_id := last_insert_id();
 
-- Insert 4th film in sakila.film table with classic values clause.
INSERT INTO film
( title
, description
, release_year
, language_id
, original_language_id
, rental_duration
, rental_rate
, length
, replacement_cost
, rating
, special_features
, last_update
, series_name
, series_number
, prequel_id )
VALUES
('Harry Potter and the Goblet of Fire'
,'A film where where Harry Potter''s name emerges from the Goblet of Fire, and he becomes a competitor in a grueling battle for glory among three wizarding schools - the Triwizard Tournament.'
, 2005
, 1
, NULL
, 3
, 0.99
, 157
, 19.99
,'PG'
,'Trailers'
,'2005-11-18'
,'Harry Potter'
, 4
, @sv_film_id );
 
-- Assign the last generated primary key value to the local variable.
SET @sv_film_id := last_insert_id();
 
-- Insert 5th film in sakila.film table with classic values clause.
INSERT INTO film
( title
, description
, release_year
, language_id
, original_language_id
, rental_duration
, rental_rate
, length
, replacement_cost
, rating
, special_features
, last_update
, series_name
, series_number
, prequel_id )
VALUES
('Harry Potter and the Order of the Phoenix'
,'A film where Lord Voldemort has returned, but the Ministry of Magic is doing everything it can to keep the wizarding world from knowing the truth.'
, 2007
, 1
, NULL
, 3
, 0.99
, 138
, 19.99
,'PG-13'
,'Trailers'
,'2007-07-12'
,'Harry Potter'
, 5
, @sv_film_id );
 
-- Assign the last generated primary key value to the local variable.
SET @sv_film_id := last_insert_id();
 
-- Insert 6th film in sakila.film table with classic values clause.
INSERT INTO film
( title
, description
, release_year
, language_id
, original_language_id
, rental_duration
, rental_rate
, length
, replacement_cost
, rating
, special_features
, last_update
, series_name
, series_number
, prequel_id )
VALUES
('Harry Potter and the Half Blood Prince'
,'A film where Voldemort is tightening his grip on Hogwarts and it is no longer the safe haven it once was. Harry and Dumbledore work to find the key to unlock the Dark Lord''s defenses.'
, 2009
, 1
, NULL
, 3
, 0.99
, 153
, 19.99
,'PG'
,'Trailers'
,'2009-07-15'
,'Harry Potter'
, 6
, @sv_film_id );
 
-- Assign the last generated primary key value to the local variable.
SET @sv_film_id := last_insert_id();
 
-- Insert 7th film in sakila.film table with classic values clause.
INSERT INTO film
( title
, description
, release_year
, language_id
, original_language_id
, rental_duration
, rental_rate
, length
, replacement_cost
, rating
, special_features
, last_update
, series_name
, series_number
, prequel_id )
VALUES
('Harry Potter and the Deathly Hallows: Part 1'
,'A film where Harry, Ron and Hermione set out on their perilous mission to track down and destroy the Horcruxes - the keys to Voldemort''s immortality.'
, 2010
, 1
, NULL
, 3
, 0.99
, 146
, 19.99
,'PG-13'
,'Trailers'
,'2010-11-19'
,'Harry Potter'
, 7
, @sv_film_id );
 
-- Assign the last generated primary key value to the local variable.
SET @sv_film_id := last_insert_id();
 
-- Insert 8th film in sakila.film table with classic values clause.
INSERT INTO film
( title
, description
, release_year
, language_id
, original_language_id
, rental_duration
, rental_rate
, length
, replacement_cost
, rating
, special_features
, last_update
, series_name
, series_number
, prequel_id )
VALUES
('Harry Potter and the Deathly Hallows: Part 2'
,'A film where Harry, Ron and Hermione set out on their perilous mission to track down and destroy the Horcruxes - the keys to Voldemort''s immortality.'
, 2011
, 1
, NULL
, 3
, 0.99
, 130
, 19.99
,'PG-13'
,'Trailers'
,'2011-07-15'
,'Harry Potter'
, 8
, @sv_film_id );
-- --------------------------------------------------

-- ---------------------------------------------------------------------------

