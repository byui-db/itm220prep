-- *********************************
-- W11 STUDENT SQL WORKBOOK
-- Chapter 8 questions
-- *********************************

/*
  ORDER OF OPERATION (The way we write our queries):
    SELECT     column_name AS 'Alias1'
    ,          Function(column_name_2) AS 'Alias2'
    ,          CASE column_name_3
                WHEN condition THEN # ELSE # (Condition is usually a number or string value. Can also contain calculations)
              END AS 'Alias 3' -- ALWAYS use an alias with CASE contitions
    FROM       table1 t1   -- t1 and t2 are table aliases
      JOIN       table2 t2   -- join types: INNER, LEFT, RIGHT
      ON         t1.table1_id = t2.table1_id -- PK and FK might not always be the same name
    WHERE      column_name = condition (Cannot contain an aggregate function)
    GROUP BY   column_name (Must be a column in the SELECT clause that is NOT in an aggregate function)
    HAVING     aggregate_function(column_name) = group condition
    ORDER BY   column_name (DESC)
    LIMIT      # of rows;
    To remember this: Stay Firm (JOINED) With God, Honoring Our Lord
*/

/*
  ORDER OF EXECUTION (The way the code actually runs):
    FROM       table1 t1   
      JOIN       table2 t2  
      ON         t1.table1_id = t2.table1_id
    WHERE      column_name = condition
    GROUP BY   column_name 
    HAVING     aggregate_function(column_name) = group condition
    SELECT     column_name AS 'Alias1'
    ,          Function(column_name_2) AS 'Alias2'
    ORDER BY   column_name (DESC)
    LIMIT      # of rows;
    To remember this: For with God, He sends out love
*/

/*
  Common Aggregate Functions:
  COUNT()
  SUM()
  AVG()
  MAX()
  MIN()
*/

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
SELECT customer_id, COUNT(*) AS '# of Customer Payments'
,      SUM(amount) AS 'Total amount paid'
FROM   payment
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
SELECT customer_id
,      COUNT(*) AS '# of Customer Payments'
,      SUM(amount) AS 'Total amount paid'
FROM   payment
GROUP BY customer_id
HAVING   COUNT(*) >= 40;

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
SELECT title
,      rating
,      COUNT(*) AS 'row count'
FROM   film f 
INNER JOIN film_actor fa
ON         f.film_id = fa.film_id
INNER JOIN actor a
ON         fa.actor_id = a.actor_id
WHERE rating IN('G','PG','PG-13')
GROUP BY title
,        rating
HAVING   COUNT(*) BETWEEN 9 AND 12
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
SELECT title
,      rating
,      COUNT(*) AS 'row count'
FROM   film f 
INNER JOIN inventory i
ON         f.film_id = i.film_id
INNER JOIN rental r
ON         i.inventory_id = r.inventory_id
INNER JOIN customer c
ON         r.customer_id = c.customer_id
WHERE title LIKE 'C%'
GROUP BY title
,        rating
HAVING   COUNT(return_date) >= 2
ORDER by title;

-- ----------------------------------
-- PRACTICE
-- ----------------------------------

-- ------------------------------------------------------------------------------------------
-- 1. Find the total number of films in the film table.
--    Example Output:
--    +-------------+
--    | Total Films |
--    +-------------+
--    |        1000 |
--    +-------------+
--    1 row in set (0.06 sec)
--    The column will look like the following:
--    | Total Films |
-- ------------------------------------------------------------------------------------------


-- ------------------------------------------------------------------------------------------
-- 2. Calculate the average rental duration for all films.
--    Example Output:
--    +-------------------------+
--    | Average Rental Duration |
--    +-------------------------+
--    |                  4.9850 |
--    +-------------------------+
--    1 row in set (0.00 sec)
--    The column will look like the following:
--    | Average Rental Duration |
-- ------------------------------------------------------------------------------------------


-- ------------------------------------------------------------------------------------------
-- 3. Find the total number of films for each rating.
--    Example Output:
--    +--------+-------------+
--    | Rating | Total Films |
--    +--------+-------------+
--    | PG     |         194 |
--    | G      |         178 |
--    | NC-17  |         210 |
--    | PG-13  |         223 |
--    | R      |         195 |
--    +--------+-------------+
--    5 rows in set (0.00 sec)
--    Columns will look like the following:
--    | Rating | Total Films |
-- ------------------------------------------------------------------------------------------


-- ------------------------------------------------------------------------------------------
-- 4. List the total number of films by category that has more than 50 films.
--    Sort from greatest to lowest.
--    Example Output:
--    +---------------+-------------+
--    | Category Name | Total Films |
--    +---------------+-------------+
--    | Sports        |          74 |
--    | Foreign       |          73 |
--    | Family        |          69 |
--    | Documentary   |          68 |
--    | Animation     |          66 |
--    | Action        |          64 |
--    | New           |          63 |
--    | Drama         |          62 |
--    | Games         |          61 |
--    | Sci-Fi        |          61 |
--    | Children      |          60 |
--    | Comedy        |          58 |
--    | Classics      |          57 |
--    | Travel        |          57 |
--    | Horror        |          56 |
--    | Music         |          51 |
--    +---------------+-------------+
--    16 rows in set (0.02 sec)
--    Column names will look like the following:
--    | Category Name | Total Films |
-- ------------------------------------------------------------------------------------------


-- ------------------------------------------------------------------------------------------
-- 5. For each store, calculate the total rental revenue (amount) grouped by the store's ID.
--    Only include stores that have generated more than $15,000 in revenue.
--    Sort the results by total revenue in descending order. 
--    Format the revenue to 2 decimal places and add a $.
--    Example Output:
--    +----------+---------------+
--    | Store ID | Total Revenue |
--    +----------+---------------+
--    |        2 | $33,726.77    |
--    |        1 | $33,679.79    |
--    +----------+---------------+
--    2 rows in set (0.19 sec)
--    Columns will look like the following:
--    | Store ID | Total Revenue |
-- ------------------------------------------------------------------------------------------

