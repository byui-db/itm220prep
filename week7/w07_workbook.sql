-- *********************************
-- W07 STUDENT SQL WORKBOOK
-- Chapter 8: INNER JOINS Focus (No Aggregation)
-- *********************************

/*
    SQL INNER JOIN Pattern:
    SELECT     t1.column_name AS 'Alias1'
    ,          t2.column_name AS 'Alias2'
    FROM       table1 t1
    INNER JOIN table2 t2
    ON         t1.pk_column = t2.fk_column
    WHERE      condition
    ORDER BY   column_name (DESC);
*/

USE sakila;

-- ------------------------------------------------------------------------
-- 1. List all customers with their first and last names and the name of 
-- the city they live in.
-- +------------+-----------+---------------+
-- | first_name | last_name | city          |
-- +------------+-----------+---------------+

-- ------------------------------------------------------------------------
-- 2. Show all film titles and the full names of the actors in each film.
-- +--------------------------+------------+-----------+
-- | title                    | first_name | last_name |
-- +--------------------------+------------+-----------+

-- ------------------------------------------------------------------------
-- 3. Display the title of the film and the name of the category it belongs to.
-- +--------------------------+-------------+
-- | title                    | category    |
-- +--------------------------+-------------+

-- ------------------------------------------------------------------------
-- 4. Show each rental's rental date, customer full name, and the title of the film rented.
-- +---------------------+------------+-----------+--------------------------+
-- | rental_date         | first_name | last_name | title                    |
-- +---------------------+------------+-----------+--------------------------+

-- ------------------------------------------------------------------------
-- 5. Show the customer first and last name, email address, and country they live in.
-- Only include those who live in 'Canada'.
-- +------------+-----------+-------------------------+---------+
-- | first_name | last_name | email                   | country |
-- +------------+-----------+-------------------------+---------+

-- ------------------------------------------------------------------------
-- 6. List staff member names and the address of the store where they work.
-- +------------+-----------+------------------------+
-- | first_name | last_name | address                |
-- +------------+-----------+------------------------+

-- ------------------------------------------------------------------------
-- 7. Display each payment with the customer’s name and the payment amount 
-- formatted to two decimal places and a '$' symbol.
-- +------------+-----------+----------------+
-- | first_name | last_name | payment_amount |
-- +------------+-----------+----------------+

-- ------------------------------------------------------------------------
-- 8. Show the title and length of all films longer than 120 minutes.
-- +--------------------------+--------+
-- | title                    | length |
-- +--------------------------+--------+

-- ------------------------------------------------------------------------
-- 9. Show the full names of actors and the titles of the films they appeared in,
-- but only for actors whose last name starts with 'B'.
-- +------------+-----------+--------------------------+
-- | first_name | last_name | title                    |
-- +------------+-----------+--------------------------+

-- ------------------------------------------------------------------------
-- 10. Challenge: Display the customer's name, rental date, and film title for
-- all rentals that occurred in July 2005.
-- +------------+-----------+---------------------+--------------------------+
-- | first_name | last_name | rental_date         | title                    |
-- +------------+-----------+---------------------+--------------------------+

