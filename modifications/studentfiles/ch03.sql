-- Chapter 3 questions
USE sakila;
-- ------------------------------------------------------------------------
-- 1. Write the SQL statement that retrieves the 
-- actor ID, first name, and last name for all actors. 
-- Sort results by last name and then by first name.
-- ------------------------------------------------------------------------
SELECT   a.actor_id
,        a.first_name
,        a.last_name
FROM     actor a
ORDER BY a.last_name
,        a.first_name;

-- ------------------------------------------------------------------------
-- 2. Write the SQL statement that retrieves the 
-- actor ID, first name, and last name for all actors 
-- whose last name equals 'WILLIAMS' or 'DAVIS'.
-- ------------------------------------------------------------------------
SELECT   a.actor_id
,        a.first_name
,        a.last_name
FROM     actor a
WHERE    a.last_name IN ('DAVIS','WILLIAMS');

-- ------------------------------------------------------------------------
-- 3. Write a query against the rental table that returns
-- the IDs of the customers who rented a film on July 5, 2005 
-- (use the rental.rental_date column, and you can use the date() function 
-- to ignore the time component). 
-- Include a single row for each distinct customer ID.
-- ------------------------------------------------------------------------
SELECT   DISTINCT
         r.customer_id
FROM     rental r
WHERE    DATE(r.rental_date) = '2005-07-05';
Exercise 2-4: Fill in the blanks (denoted by <#>) for this multi table query:
mysql> SELECT   c.email, r.return_date
    -> FROM     customer c INNER JOIN rental <1>
    -> ON       c.customer_id = <2>
    -> WHERE    date(r.rental_date) = '2005-06-14'
    -> ORDER BY <3> <4>;

-- ------------------------------------------------------------------------
-- 4. Fill in the blanks in the following SQL statement
-- SELECT   c.email, r.return_date
-- FROM     customer c INNER JOIN rental <1>
-- ON       c.customer_id = <2>
-- WHERE    date(r.rental_date) = '2005-06-14'
-- ORDER BY <3> <4>;
-- ------------------------------------------------------------------------
SELECT   c.email, r.return_date
FROM     customer c INNER JOIN rental r
ON       c.customer_id = r.customer_id
WHERE    date(r.rental_date) = '2005-06-14'
ORDER BY r.return_date DESC;

-- ------------------------------------------------------------------------
-- 5. Write the SQL statement that retrieves the unique 
-- actor last name values for all actors. 
-- Sort results by last name.
-- ------------------------------------------------------------------------
SELECT   DISTINCT
         c.last_name
FROM     customer c;


