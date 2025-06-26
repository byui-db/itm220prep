-- *********************************
-- W10 STUDENT SQL WORKBOOK
-- Chapter 5 questions
-- DO NOT RUN THIS FILE ALL AT ONCE
-- USE CTRL(OR CMD) + ENTER TO RUN ONE QUESTION AT A TIME
-- *********************************

/*
    SELECT     column_name AS 'Alias1'
    ,          Function(column_name_2) AS 'Alias2'
    ,          CASE column_name_3
                WHEN condition THEN # ELSE # (Condition is usually a number or string value. Can also contain calculations)
              END AS 'Alias 3' -- ALWAYS use an alias with CASE contitions
    FROM       table1 t1   -- t1 and t2 are table aliases
    JOIN       table2 t2   -- join types: INNER, LEFT, RIGHT
    ON         t1.table1_id = t2.table1_id -- PK and FK might not always be the same name
    WHERE      column_name = condition
    ORDER BY   column_name (DESC)
    LIMIT      # of rows;
    To remember this: Stay Firm (JOINED) With Our Lord
*/


USE sakila;

-- --------------------------------------------------------------------------
-- 1. Fill in the blanks (denoted by <#>) for the following query 
-- to obtain the results that follow

-- SELECT   c.first_name, c.last_name, a.address, ct.city
-- FROM     customer c INNER JOIN address <1>
-- ON       c.address_id = a.address_id INNER JOIN city ct
-- ON       a.city_id = <2>
-- WHERE    a.district = 'California';

-- +------------+-----------+------------------------+----------------+
-- | first_name | last_name | address                | city           |
-- +------------+-----------+------------------------+----------------+
-- | PATRICIA   | JOHNSON   | 1121 Loja Avenue       | San Bernardino |
-- | BETTY      | WHITE     | 770 Bydgoszcz Avenue   | Citrus Heights |
-- | ALICE      | STEWART   | 1135 Izumisano Parkway | Fontana        |
-- | ROSA       | REYNOLDS  | 793 Cam Ranh Avenue    | Lancaster      |
-- | RENEE      | LANE      | 533 al-Ayn Boulevard   | Compton        |
-- | KRISTIN    | JOHNSTON  | 226 Brest Manor        | Sunnyvale      |
-- | CASSANDRA  | WALTERS   | 920 Kumbakonam Loop    | Salinas        |
-- | JACOB      | LANCE     | 1866 al-Qatif Avenue   | El Monte       |
-- | RENE       | MCALISTER | 1895 Zhezqazghan Drive | Garden Grove   |
-- +------------+-----------+------------------------+----------------+
-- --------------------------------------------------------------------------
SELECT   c.first_name
,        c.last_name
,        a.address
,        ct.city
FROM     customer c 
INNER JOIN address a
ON       c.address_id = a.address_id 
INNER JOIN city ct
ON       a.city_id = ct.city_id
WHERE    a.district = 'California';

-- --------------------------------------------------------------------------
-- 2. Construct a query that returns all addresses from the address table 
-- that are in the same city but different addresses. 
-- The SELECT-list should display the two addresses and the city name.

-- For example, you should return one copy of the address column 
-- from two copies of the address table. 
-- You can do that by using a column alias of addr1 and addr2 for 
-- the two copies of the address column returned in the SELECT-list.

-- You need to join the two copies of the address table on the 
-- city_id foreign key column that links them to the city table. 
-- Then, you need to join on one copy of the address table using
--  city_id foreign key column to the city_id primary key column 
-- in the city table.

-- The result set returns the eight rows below. 
-- It contains two copies of the different addresses; 
-- one row will have the frist address on the left and 
-- second address on the right, and the other row will have 
-- the address displayed in opposite columns.

-- +----------------------+----------------------+------------+
-- | addr1                | addr2                | city       |
-- +----------------------+----------------------+------------+
-- | 47 MySakila Drive    | 23 Workhaven Lane    | Lethbridge |
-- | 28 MySQL Boulevard   | 1411 Lillydale Drive | Woodridge  |
-- | 23 Workhaven Lane    | 47 MySakila Drive    | Lethbridge |
-- | 1411 Lillydale Drive | 28 MySQL Boulevard   | Woodridge  |
-- | 1497 Yuzhou Drive    | 548 Uruapan Street   | London     |
-- | 587 Benguela Manor   | 43 Vilnius Manor     | Aurora     |
-- | 548 Uruapan Street   | 1497 Yuzhou Drive    | London     |
-- | 43 Vilnius Manor     | 587 Benguela Manor   | Aurora     |
-- +----------------------+----------------------+------------+
-- --------------------------------------------------------------------------
SELECT a1.address AS addr1
,      a2.address AS addr2
,      c.city
FROM   address a1
INNER JOIN address a2
ON     a1.city_id = a2.city_id
INNER JOIN city c
ON     a1.city_id = c.city_id
WHERE NOT a1.address = a2.address;

-- --------------------------------------------------------------------------
-- 3. Write a query that shows all the films starring Joe Swank 
-- that have a length between 90 and 120 minutes. 
-- You will use the actor, film_actor and film tables 
-- to answer this question. 
-- It should display the following data set:
-- +----------------------+--------+
-- | title                | length |
-- +----------------------+--------+
-- | CHOCOLAT HARRY       |    101 |
-- | DALMATIONS SWEDEN    |    106 |
-- | PERDITION FARGO      |     99 |
-- | RUNNER MADIGAN       |    101 |
-- | SWEETHEARTS SUSPECTS |    108 |
-- | TIES HUNGER          |    111 |
-- | UNTOUCHABLES SUNRISE |    120 |
-- +----------------------+--------+
-- --------------------------------------------------------------------------
SELECT f.title
,      f.length
FROM   film f
INNER JOIN film_actor fa
ON     f.film_id = fa.film_id
INNER JOIN actor a
ON     fa.actor_id = a.actor_id
WHERE  f.length BETWEEN 90 AND 120
AND    CONCAT(a.first_name, ' ', a.last_name) = 'Joe Swank';

-- Week 6 questions

-- --------------------------------------------------------------------------
-- 4. Write a compound query that finds the 
-- first and last names of all actors and customers 
-- whose last name starts with L, sorted by last_name.
-- This should return the following result set:
-- +------------+--------------+
-- | first_name | last_name    |
-- +------------+--------------+
-- | MISTY      | LAMBERT      |
-- | JACOB      | LANCE        |
-- | RENEE      | LANE         |
-- | HEIDI      | LARSON       |
-- | DARYL      | LARUE        |
-- | LAURIE     | LAWRENCE     |
-- | JEANNE     | LAWSON       |
-- | LAWRENCE   | LAWTON       |
-- | KIMBERLY   | LEE          |
-- | MATTHEW    | LEIGH        |
-- | LOUIS      | LEONE        |
-- | SARAH      | LEWIS        |
-- | GEORGE     | LINTON       |
-- | MAUREEN    | LITTLE       |
-- | JOHNNY     | LOLLOBRIGIDA |
-- | DWIGHT     | LOMBARDI     |
-- | JACQUELINE | LONG         |
-- | AMY        | LOPEZ        |
-- | BARRY      | LOVELACE     |
-- | PRISCILLA  | LOWE         |
-- | VELMA      | LUCAS        |
-- | WILLARD    | LUMPKIN      |
-- | LEWIS      | LYMAN        |
-- | JACKIE     | LYNCH        |
-- +------------+--------------+
-- --------------------------------------------------------------------------
SELECT * FROM
(SELECT a.first_name
,       a.last_name
FROM    actor a
UNION
SELECT  c.first_name
,       c.last_name
FROM    customer c) A
WHERE last_name LIKE 'L%'
ORDER BY last_name;

-- --------------------------------------------------------------------------
-- 5. Write a compound query that finds the id and name of all cities 
-- and countries that have a name starting with 
-- an 'S', containing an 'o', and ending with an 'a' 
-- in descending order by city name.
-- +-----+----------------------------+
-- | id  | name                       |
-- +-----+----------------------------+
-- | 450 | San Felipe de Puerto Plata |
-- | 458 | Santa Rosa                 |
-- | 459 | Santiago de Compostela     |
-- | 473 | Shimoga                    |
-- | 489 | Songkhla                   |
-- | 490 | Sorocaba                   |
-- | 495 | Southend-on-Sea            |
-- | 498 | Stara Zagora               |
-- |  84 | Slovakia                   |
-- |  85 | South Africa               |
-- |  86 | South Korea                |
-- +-----+----------------------------+
-- --------------------------------------------------------------------------
SELECT ct.city_id AS id
,      ct.city AS name
FROM   city ct
WHERE  ct.city LIKE 'S%o%a'
UNION ALL
SELECT c.country_id AS id
,      c.country AS name
FROM   country c
WHERE  c.country LIKE 'S%o%a'
ORDER BY name DESC;

-- --------------------------------------------------------------------------
-- 6. Write a compound query that finds the distinct last_name and title 
-- where the first_name starts with an 'M' and the film starts with 'LOVE' 
-- and the last_name and title where the last_name starts with an 'W' 
-- and the film title starts with 'LIFE' 
-- in ascending order by the actor's last_name.
-- +-------------+-----------+------------------+
-- | first_name  | last_name | title            |
-- +-------------+-----------+------------------+
-- | MENA        | HOPPER    | LOVER TRUMAN     |
-- | MARY        | KEITEL    | LOVELY JINGLE    |
-- | MILLA       | KEITEL    | LOVER TRUMAN     |
-- | MINNIE      | KILMER    | LOVELY JINGLE    |
-- | MORGAN      | MCDORMAND | LOVERBOY ATTACKS |
-- | DARYL       | WAHLBERG  | LIFE TWISTED     |
-- | CHRISTOPHER | WEST      | LIFE TWISTED     |
-- | REESE       | WEST      | LIFE TWISTED     |
-- | UMA         | WOOD      | LIFE TWISTED     |
-- +-------------+-----------+------------------+
-- --------------------------------------------------------------------------
SELECT a.last_name
,      f.title
FROM   actor a INNER JOIN film_actor fa
ON     a.actor_id = fa.actor_id INNER JOIN film f
ON     fa.film_id = f.film_id
WHERE  a.first_name LIKE 'M%'
AND    f.title LIKE 'LOVE%'
UNION
SELECT a.last_name
,      f.title
FROM   actor a INNER JOIN film_actor fa
ON     a.actor_id = fa.actor_id INNER JOIN film f
ON     fa.film_id = f.film_id
WHERE  a.last_name LIKE 'W%'
AND    f.title LIKE 'LIFE%'
ORDER BY last_name;

-- Chapter 10 questions

-- NOTE: This section uses subqueries. We will touch on these in week 12.

-- --------------------------------------------------------------------------
-- 7. Using the following table definitions and data, write a query 
-- that returns each customer name along with their total payments 
-- (these names differ from the textbook because 
-- they're the ones in the sakila database):

-- customer Table:

-- +-------------+---------------+
-- | customer_id | name          |
-- +-------------+---------------+
-- |           1 | MARY SMITH    |
-- |           4 | BARBARA JONES |
-- |         210 | ELLA OLIVER   |
-- +-------------+---------------+
-- 3 rows in set (0.30 sec)

-- payment Table:

-- +------------+-------------+--------+
-- | payment_id | customer_id | amount |
-- +------------+-------------+--------+
-- |          1 |          32 | 118.68 |
-- |          4 |          22 |  81.78 |
-- |        210 |          31 | 137.69 |
-- +------------+-------------+--------+
-- 3 rows in set (0.02 sec)

-- Before you delete the rows from the payment table 
-- for those related to Ella Oliver, you should backup the rows. 
-- That way you can recover the rows after the query 
-- without refreshing the sakila database.

-- You need to create a payment_backup table, 
-- which can be done with the following two commands:

-- Conditionally drop the payment table.
DROP TABLE IF EXISTS payment_backup;

-- Create the payment_backup table.
CREATE TABLE payment_backup AS
  SELECT payment_id
  ,      customer_id
  ,      staff_id
  ,      rental_id
  ,      amount
  ,      payment_date
  ,      last_update
  FROM   payment
  WHERE  customer_id = 
          (SELECT customer_id
           FROM   customer
           WHERE  first_name = 'ELLA'
           AND    last_name = 'OLIVER');
-- Delete all rows for Ella Oliver in the payment table 
-- with the following statement:

DELETE FROM payment
WHERE customer_id = (SELECT customer_id
                     FROM   customer 
                     WHERE  first_name = 'ELLA' 
                     AND    last_name = 'OLIVER');
-- Include all the three customers identified 
-- (Mary Smith, Barbara Jones, and Ella Oliver) 
-- by using a LEFT OUTER JOIN between the customer and payment tables. 
-- Display first_name, a white space, and last_name and 
-- the total of payments made by each customer 
-- while ordering the return set in ascending order. 
-- You should display the following:

-- +---------------+---------------+
-- | name          | Total Payment |
-- +---------------+---------------+
-- | BARBARA JONES |         81.78 |
-- | ELLA OLIVER   |          NULL |
-- | MARY SMITH    |        118.68 |
-- +---------------+---------------+
-- 3 rows in set (0.00 sec)

-- --------------------------------------------------------------------------
SELECT CONCAT(c.first_name, ' ', c.last_name) AS name
,      SUM(p.amount) AS 'Total Payment'
FROM   customer c LEFT JOIN payment p
ON     c.customer_id = p.customer_id
WHERE  c.customer_id IN (1,4,210)
GROUP BY name
ORDER BY name;

-- --------------------------------------------------------------------------
-- 8. Reformulate your query from Exercise 10-1 to exclude Ella Oliver

-- It should return the following data:
-- +---------------+---------------+
-- | name          | Total Payment |
-- +---------------+---------------+
-- | BARBARA JONES |         81.78 |
-- | MARY SMITH    |        118.68 |
-- +---------------+---------------+
-- --------------------------------------------------------------------------
SELECT CONCAT(c.first_name, ' ', c.last_name) AS name
,      SUM(p.amount) AS 'Total Payment'
FROM   payment p RIGHT JOIN customer c
ON     c.customer_id = p.customer_id
WHERE  c.customer_id IN (1,4,210)
GROUP BY name
HAVING   SUM(p.amount) IS NOT NULL
ORDER BY name;

-- --------------------------------------------------------------------------
-- After writing your script to generate the foregoing result sets (derived table), 
-- you can recover the rows from the payment_backup table by inserting them 
-- into the payment table with this script:

INSERT INTO payment
( payment_id
, customer_id
, staff_id
, rental_id
, amount
, payment_date
, last_update )
( SELECT *
  FROM   payment_backup
  WHERE  customer_id = (SELECT customer_id
                        FROM   customer 
                        WHERE  first_name = 'ELLA' 
                        AND    last_name = 'OLIVER'));
-- --------------------------------------------------------------------------
