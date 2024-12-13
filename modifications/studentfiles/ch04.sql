-- Chapter 4 questions
USE sakila;

-- +------------+-------------+--------+--------------------+
-- | payment_id | customer_id | amount | date(payment_date) |
-- +------------+-------------+--------+--------------------+
-- |        101 |           4 |   8.99 | 2005-08-18         |
-- |        102 |           4 |   1.99 | 2005-08-19         |
-- |        103 |           4 |   2.99 | 2005-08-20         |
-- |        104 |           4 |   6.99 | 2005-08-20         |
-- |        105 |           4 |   4.99 | 2005-08-21         |
-- |        106 |           4 |   2.99 | 2005-08-22         |
-- |        107 |           4 |   1.99 | 2005-08-23         |
-- |        108 |           5 |   0.99 | 2005-05-29         |
-- |        109 |           5 |   6.99 | 2005-05-31         |
-- |        110 |           5 |   1.99 | 2005-05-31         |
-- |        111 |           5 |   3.99 | 2005-06-15         |
-- |        112 |           5 |   2.99 | 2005-06-16         |
-- |        113 |           5 |   4.99 | 2005-06-17         |
-- |        114 |           5 |   2.99 | 2005-06-19         |
-- |        115 |           5 |   4.99 | 2005-06-20         |
-- |        116 |           5 |   4.99 | 2005-07-06         |
-- |        117 |           5 |   2.99 | 2005-07-08         |
-- |        118 |           5 |   4.99 | 2005-07-09         |
-- |        119 |           5 |   5.99 | 2005-07-09         |
-- |        120 |           5 |   1.99 | 2005-07-09         |
-- +------------+-------------+--------+--------------------+

-- --------------------------------------------------------------------------
-- 1. Write the SQL statement that will retrieve the
-- payment ids with the following filter:
-- customer_id <> 5 AND (amount > 8 OR date(payment_date) = '2005-08-23')
-- --------------------------------------------------------------------------
SELECT   p.payment_id
,        c.customer_id
,        p.amount
,        DATE(payment_date)
FROM     customer c INNER JOIN payment p
ON       c.customer_id = p.customer_id
WHERE    p.payment_id BETWEEN 101 AND 120
AND      p.customer_id <> 5 AND (amount > 8 OR DATE(payment_date) = '2005-08-23');

-- --------------------------------------------------------------------------
-- 2. Write the SQL statement that will retrieve the
-- payment ids with the following filter:
-- customer_id = 5 AND NOT (amount > 6 OR date(payment_date) = '2005-06-19')
-- --------------------------------------------------------------------------
SELECT   p.payment_id
,        c.customer_id
,        p.amount
,        DATE(payment_date)
FROM     customer c INNER JOIN payment p
ON       c.customer_id = p.customer_id
WHERE    p.payment_id BETWEEN 101 AND 120
AND      p.customer_id = 5 AND NOT (amount = 8 OR DATE(payment_date) = '2005-06-19');

-- --------------------------------------------------------------------------
-- 3. Construct a query that retrieves all rows from the payments table 
-- where the amount is either 1.98, 7.98, or 9.98.
-- --------------------------------------------------------------------------
SELECT   p.payment_id
FROM     payment p
WHERE    p.amount IN (1.98,7.98,9.98);

-- --------------------------------------------------------------------------
-- 4. Construct a query that finds all customers whose last name contains 
-- an A in the second position and a W anywhere after the A.
-- --------------------------------------------------------------------------
SELECT   c.last_name
FROM     customer c
WHERE    c.last_name LIKE '_A%W%';

-- --------------------------------------------------------------------------
-- 5. Construct a query that finds all customers whose last name contains 
-- an E in the second position.
-- --------------------------------------------------------------------------
SELECT   c.last_name
FROM     customer c
WHERE    c.last_name LIKE '_E%';
