-- Chapter 9 questions
USE sakila;

-- --------------------------------------------------------------------------
-- 1. Construct a query against the film table that uses a filter condition 
-- with a NON CORRELATED subquery against the category table 
-- to find all action films (category.name = 'Action').
-- +-------------------------+
-- | title                   |
-- +-------------------------+
-- | AMADEUS HOLY            |
-- | AMERICAN CIRCUS         |
-- | ANTITRUST TOMATOES      |
-- | ARK RIDGEMONT           |
-- | BAREFOOT MANCHURIAN     |
-- | BERETS AGENT            |
-- ...
-- | TRUMAN CRAZY            |
-- | UPRISING UPTOWN         |
-- | WATERFRONT DELIVERANCE  |
-- | WEREWOLF LOLA           |
-- | WOMEN DORADO            |
-- | WORST BANGER            |
-- +-------------------------+
-- --------------------------------------------------------------------------


-- --------------------------------------------------------------------------
-- 2. Rework the query from Exercise 9-1 using a CORRELATED subquery 
-- against the category and film_category tables 
-- to achieve the same results.
-- It should return 64 rows, like:
-- +-------------------------+
-- | title                   |
-- +-------------------------+
-- | AMADEUS HOLY            |
-- | AMERICAN CIRCUS         |
-- | ANTITRUST TOMATOES      |
-- | ARK RIDGEMONT           |
-- | BAREFOOT MANCHURIAN     |
-- | BERETS AGENT            |
-- ...
-- | TRUMAN CRAZY            |
-- | UPRISING UPTOWN         |
-- | WATERFRONT DELIVERANCE  |
-- | WEREWOLF LOLA           |
-- | WOMEN DORADO            |
-- | WORST BANGER            |
-- +-------------------------+
-- --------------------------------------------------------------------------

-- --------------------------------------------------------------------------
-- 3. Join the following query to a subquery 
-- against the film_actor table to show the level of each actor:
SELECT 'Hollywood Star' AS level
,       30 AS min_roles
,       99999 AS max_roles
UNION ALL
SELECT 'Prolific Actor' AS level
,       20 AS min_roles
,       29 AS max_roles
UNION ALL
SELECT 'Newcomer' AS level
,        1 AS min_roles
,       19 AS max_roles;
-- The subquery against the film_actor table should 
-- count the number of rows for each actor using group by actor_id, 
-- and the count should be compared to the min_roles/max_roles columns 
-- to determine which level each actor belongs to.
-- It should return 200 rows, like:
-- +----------+----------------+
-- | actor_id | level          |
-- +----------+----------------+
-- |        1 | Newcomer       |
-- |        2 | Prolific Actor |
-- |        3 | Prolific Actor |
-- |        4 | Prolific Actor |
-- |        5 | Prolific Actor |
-- |        6 | Prolific Actor |
-- |        7 | Hollywwod Star |
-- |        8 | Prolific Actor |
-- ...
-- |      195 | Prolific Actor |
-- |      196 | Hollywwod Star |
-- |      197 | Hollywwod Star |
-- |      198 | Hollywwod Star |
-- |      199 | Newcomer       |
-- |      200 | Prolific Actor |
-- +----------+----------------+
-- --------------------------------------------------------------------------


-- --------------------------------------------------------------------------
-- 4. Rewrite the following query with 
-- two subqueries into multicolumn subquery. 
-- The subquery should use a filtered cross join 
-- between the film and actor tables.
SELECT   fa.actor_id
,        fa.film_id
FROM     film_actor fa
WHERE    fa.actor_id IN
           (SELECT actor_id FROM actor WHERE last_name = 'MONROE')
AND      fa.film_id IN
           (SELECT film_id FROM film WHERE rating = 'PG');
-- The foregoing query returns the following result set, 
-- and so should the new query:
-- +----------+---------+
-- | actor_id | film_id |
-- +----------+---------+
-- |      120 |      63 |
-- |      120 |     144 |
-- |      120 |     414 |
-- |      120 |     590 |
-- |      120 |     715 |
-- |      120 |     894 |
-- |      178 |     164 |
-- |      178 |     194 |
-- |      178 |     273 |
-- |      178 |     311 |
-- |      178 |     983 |
-- +----------+---------+
-- --------------------------------------------------------------------------


-- --------------------------------------------------------------------------
-- 5. Rewrite the following query with two subqueries 
-- into one with two correlated subqueries. 
-- Both of the subqueries should return null values.
SELECT   fa.actor_id
,        fa.film_id
FROM     film_actor fa
WHERE    fa.actor_id IN
           (SELECT actor_id FROM actor WHERE last_name = 'MONROE')
AND      fa.film_id IN
           (SELECT film_id FROM film WHERE rating = 'PG');
-- The foregoing query returns the following result set, and so should the new query:
-- +----------+---------+
-- | actor_id | film_id |
-- +----------+---------+
-- |      120 |      63 |
-- |      120 |     144 |
-- |      120 |     414 |
-- |      120 |     590 |
-- |      120 |     715 |
-- |      120 |     894 |
-- |      178 |     164 |
-- |      178 |     194 |
-- |      178 |     273 |
-- |      178 |     311 |
-- |      178 |     983 |
-- +----------+---------+
-- --------------------------------------------------------------------------

