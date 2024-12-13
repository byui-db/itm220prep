-- Chapter 10 questions
USE sakila;
-- DO NOT RUN THIS FILE ALL AT ONCE
-- USE CTRL(OR CMD) + ENTER TO RUN ONE QUESTION AT A TIME

-- --------------------------------------------------------------------------
-- 1. Using the following table definitions and data, write a query 
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
-- | name          | sum(p.amount) |
-- +---------------+---------------+
-- | BARBARA JONES |         81.78 |
-- | ELLA OLIVER   |          NULL |
-- | MARY SMITH    |        118.68 |
-- +---------------+---------------+
-- 3 rows in set (0.00 sec)

-- --------------------------------------------------------------------------

-- --------------------------------------------------------------------------
-- 2. Reformulate your query from Exercise 10-1 to use
-- the other outer join type 
-- (e.g., if you used a LEFT outer join in Exercise 10-1, 
-- use a RIGHT outer join this time) 
-- such that the results are identitcal to Exercise 10-1 
-- minus the row without a sum of amounts.

-- It should return the following data:
-- +---------------+---------------+
-- | name          | sum(p.amount) |
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

-- --------------------------------------------------------------------------
-- 3. Devise a query that will generate the set {1,2,3, ..., 99, 100}. 
-- (Hint: use a cross join with at least two FROM clause subqueries.)
-- It should return the following data:
-- +---------+
-- | counter |
-- +---------+
-- |       1 |
-- |       2 |
-- |       3 |
-- |       4 |
-- ...
-- |      97 |
-- |      98 |
-- |      99 |
-- |     100 |
-- +---------+
-- 100 rows in set (0.00 sec)
-- --------------------------------------------------------------------------


-- --------------------------------------------------------------------------
-- 4. Using the following query as your starting point. 
-- Rewrite the query to use a RIGHT JOIN and return the same result set.

SELECT   f.film_id, f.title, i.inventory_id
FROM     film f LEFT JOIN inventory i
ON       f.film_id = i.film_id
WHERE    f.title REGEXP '^RA(I|N).*$'
ORDER BY f.film_id, f.title, i.inventory_id;

-- It should return the following data:

-- +---------+-------------------+--------------+
-- | film_id | title             | inventory_id |
-- +---------+-------------------+--------------+
-- |     712 | RAIDERS ANTITRUST |         NULL |
-- |     713 | RAINBOW SHOCK     |         NULL |
-- |     714 | RANDOM GO         |         3243 |
-- |     714 | RANDOM GO         |         3244 |
-- |     714 | RANDOM GO         |         3245 |
-- |     715 | RANGE MOONWALKER  |         3246 |
-- |     715 | RANGE MOONWALKER  |         3247 |
-- |     715 | RANGE MOONWALKER  |         3248 |
-- |     715 | RANGE MOONWALKER  |         3249 |
-- |     715 | RANGE MOONWALKER  |         3250 |
-- |     715 | RANGE MOONWALKER  |         3251 |
-- |     715 | RANGE MOONWALKER  |         3252 |
-- +---------+-------------------+--------------+
-- 12 rows in set (0.10 sec)
-- --------------------------------------------------------------------------



-- --------------------------------------------------------------------------
-- 5. Using the following query as your starting point. 
-- Rewrite the query to use a RIGHT JOIN and return 
-- the same result set minus the result set of an INNER JOIN 
-- without using set operators or subqueries.

SELECT   f.film_id, f.title, i.inventory_id
FROM     film f LEFT JOIN inventory i
ON       f.film_id = i.film_id
WHERE    f.title REGEXP '^RA(I|N).*$'
ORDER BY f.film_id, f.title, i.inventory_id;

-- It should return the following data:

-- +---------+-------------------+--------------+
-- | film_id | title             | inventory_id |
-- +---------+-------------------+--------------+
-- |     712 | RAIDERS ANTITRUST |         NULL |
-- |     713 | RAINBOW SHOCK     |         NULL |
-- +---------+-------------------+--------------+
-- 2 rows in set (0.00 sec)
-- --------------------------------------------------------------------------

