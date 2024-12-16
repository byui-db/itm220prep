-- Chapter 8 questions
USE sakila;

-- --------------------------------------------------------------------------
-- 1. Construct a query that counts the number of rows in the payment table.
-- +----------------+
-- | Number of Rows |
-- +----------------+
-- |          16044 |
-- +----------------+
-- 1 row in set (0.00 sec)
-- --------------------------------------------------------------------------
SELECT COUNT(*) AS 'Number of Rows'
FROM   payment;

-- --------------------------------------------------------------------------
-- 2. Modify your query from Exercise 11-1 
-- to count the number of payments made by each customer. 
-- Show the customer_id and the total amount paid for each customer.
-- Assign Aliases to them.
-- +-------------+----------+-------------+
-- | customer_id | COUNT(*) | SUM(amount) |
-- +-------------+----------+-------------+
-- |           1 |       32 |      118.68 |
-- |           2 |       27 |      128.73 |
-- |           3 |       26 |      135.74 |
-- |           4 |       22 |       81.78 |
-- |           5 |       38 |      144.62 |
-- |           6 |       28 |       93.72 |
-- ...
-- |         594 |       27 |      130.73 |
-- |         595 |       30 |      117.70 |
-- |         596 |       28 |       96.72 |
-- |         597 |       25 |       99.75 |
-- |         598 |       22 |       83.78 |
-- |         599 |       19 |       83.81 |
-- +-------------+----------+-------------+
-- 599 rows in set (0.02 sec)
-- --------------------------------------------------------------------------
SELECT customer_id, COUNT(*) AS '# of Customer Payments',  SUM(amount) AS 'Total amount paid'
FROM payment
GROUP BY customer_id;


-- --------------------------------------------------------------------------
-- 3. Modify your query from Exercise 11-2 to include 
-- only those customers who have at least 40 payments.
-- +-------------+----------+-------------+
-- | customer_id | COUNT(*) | SUM(amount) |
-- +-------------+----------+-------------+
-- |          75 |       41 |      155.59 |
-- |         144 |       42 |      195.58 |
-- |         148 |       46 |      216.54 |
-- |         197 |       40 |      154.60 |
-- |         236 |       42 |      175.58 |
-- |         469 |       40 |      177.60 |
-- |         526 |       45 |      221.55 |
-- +-------------+----------+-------------+
-- 7 rows in set (0.04 sec)
-- --------------------------------------------------------------------------
SELECT customer_id, COUNT(*) AS '# of Customer Payments',  SUM(amount) AS 'Total amount paid'
FROM payment
GROUP BY customer_id
HAVING COUNT(*) >= 40;


-- --------------------------------------------------------------------------
-- 4. Construct a query that displays the following results 
-- from a query against the film, film_actor, and actor tables 
-- where the film's rating is either 'G', 'PG', or 'PG-13' 
-- with a row count between 9 and 12 rows.
-- Order the results by ascending order of title.
-- +------------------------+--------+----------+
-- | title                  | rating | COUNT(*) |
-- +------------------------+--------+----------+
-- | ACADEMY DINOSAUR       | PG     |       10 |
-- | ALABAMA DEVIL          | PG-13  |        9 |
-- | ANGELS LIFE            | G      |        9 |
-- | ATLANTIS CAUSE         | G      |        9 |
-- | BERETS AGENT           | PG-13  |       10 |
-- | BONNIE HOLOCAUST       | G      |        9 |
-- | BORN SPINAL            | PG     |        9 |
-- | CHINATOWN GLADIATOR    | PG     |       10 |
-- ...
-- | TELEMARK HEARTBREAKERS | PG-13  |       11 |
-- | TOMATOES HELLFIGHTERS  | PG     |        9 |
-- | WAIT CIDER             | PG-13  |        9 |
-- | WAR NOTTING            | G      |        9 |
-- | WEDDING APOLLO         | PG     |       10 |
-- | WEST LION              | G      |        9 |
-- | WIZARD COLDBLOODED     | PG     |        9 |
-- | WRONG BEHAVIOR         | PG-13  |        9 |
-- +------------------------+--------+----------+
-- 61 rows in set (0.03 sec)
-- --------------------------------------------------------------------------
SELECT title, rating, COUNT(*) AS 'row count'
FROM film f INNER JOIN film_actor fa
ON f.film_id = fa.film_id
INNER JOIN actor a
ON fa.actor_id = a.actor_id
WHERE rating IN('G','PG','PG-13')
GROUP BY title, rating
HAVING COUNT(*) BETWEEN 9 AND 12
ORDER BY title;

-- --------------------------------------------------------------------------
-- 5. Construct a query that displays the following results 
-- from a query against the film, inventory, rental, and customer tables 
-- where the film's title starts with 'C' and 
-- the film has been rented at least twice. 
-- Order the results by ascending order of title.
-- +------------------------+--------+----------+
-- | title                  | rating | COUNT(*) |
-- +------------------------+--------+----------+
-- | CABIN FLASH            | NC-17  |       15 |
-- | CADDYSHACK JEDI        | NC-17  |       16 |
-- | CALENDAR GUNFIGHT      | NC-17  |       21 |
-- | CALIFORNIA BIRDS       | NC-17  |       12 |
-- ...
-- | CRUSADE HONEY          | R      |        8 |
-- | CUPBOARD SINNERS       | R      |       23 |
-- | CURTAIN VIDEOTAPE      | PG-13  |       27 |
-- | CYCLONE FAMILY         | PG     |       15 |
-- +------------------------+--------+----------+
-- 85 rows in set (0.04 sec)
-- --------------------------------------------------------------------------
SELECT title, rating, COUNT(*) AS 'row count'
FROM film f INNER JOIN inventory i
ON f.film_id = i.film_id
INNER JOIN rental r
ON i.inventory_id = r.inventory_id
INNER JOIN customer c
ON r.customer_id = c.customer_id
WHERE title LIKE 'C%'
GROUP BY title, rating
HAVING COUNT(return_date) >= 2
ORDER by title;