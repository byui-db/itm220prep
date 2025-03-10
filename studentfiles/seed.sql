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