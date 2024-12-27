-- *********************************
-- W10 STUDENT SQL WORKBOOK
-- Chapter 5 questions
-- DO NOT RUN THIS FILE ALL AT ONCE
-- USE CTRL(OR CMD) + ENTER TO RUN ONE QUESTION AT A TIME
-- *********************************

/*
    SELECT     column_name AS 'Alias1'
    ,          Function(column_name_2) AS 'Alias2'
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


-- Chapter 10 questions

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
