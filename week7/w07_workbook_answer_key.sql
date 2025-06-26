-- *********************************
-- W07 STUDENT SQL WORKBOOK - ANSWER KEY
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
-- 1. Customers with their city
-- +------------+-----------+---------------+
-- | first_name | last_name | city          |
-- +------------+-----------+---------------+
SELECT c.first_name, c.last_name, ci.city
FROM customer c
INNER JOIN address a ON c.address_id = a.address_id
INNER JOIN city ci ON a.city_id = ci.city_id;

-- ------------------------------------------------------------------------
-- 2. Film titles and actor names
-- +--------------------------+------------+-----------+
-- | title                    | first_name | last_name |
-- +--------------------------+------------+-----------+
SELECT f.title, a.first_name, a.last_name
FROM film f
INNER JOIN film_actor fa ON f.film_id = fa.film_id
INNER JOIN actor a ON fa.actor_id = a.actor_id;

-- ------------------------------------------------------------------------
-- 3. Film titles and category name
-- +--------------------------+-------------+
-- | title                    | category    |
-- +--------------------------+-------------+
SELECT f.title, cat.name AS category
FROM film f
INNER JOIN film_category fc ON f.film_id = fc.film_id
INNER JOIN category cat ON fc.category_id = cat.category_id;

-- ------------------------------------------------------------------------
-- 4. Rentals with customer and film title
-- +---------------------+------------+-----------+--------------------------+
-- | rental_date         | first_name | last_name | title                    |
-- +---------------------+------------+-----------+--------------------------+
SELECT Date(r.rental_date), c.first_name, c.last_name, f.title
FROM rental r
INNER JOIN customer c ON r.customer_id = c.customer_id
INNER JOIN inventory i ON r.inventory_id = i.inventory_id
INNER JOIN film f ON i.film_id = f.film_id;

-- ------------------------------------------------------------------------
-- 5. Canadian customers with email
-- +------------+-----------+-------------------------+---------+
-- | first_name | last_name | email                   | country |
-- +------------+-----------+-------------------------+---------+
SELECT c.first_name, c.last_name, c.email, co.country
FROM customer c
INNER JOIN address a ON c.address_id = a.address_id
INNER JOIN city ci ON a.city_id = ci.city_id
INNER JOIN country co ON ci.country_id = co.country_id
WHERE co.country = 'Canada';

-- ------------------------------------------------------------------------
-- 6. Staff names and store address
-- +------------+-----------+------------------------+
-- | first_name | last_name | address                |
-- +------------+-----------+------------------------+
SELECT s.first_name, s.last_name, a.address
FROM staff s
INNER JOIN store st ON s.store_id = st.store_id
INNER JOIN address a ON st.address_id = a.address_id;

-- ------------------------------------------------------------------------
-- 7. Payments with customer name and formatted amount
-- +------------+-----------+----------------+
-- | first_name | last_name | payment_amount |
-- +------------+-----------+----------------+
SELECT c.first_name, c.last_name, CONCAT('$',FORMAT(p.amount, 2)) AS payment_amount
FROM payment p
INNER JOIN customer c ON p.customer_id = c.customer_id;

-- ------------------------------------------------------------------------
-- 8. Films longer than 120 minutes
-- +--------------------------+--------+
-- | title                    | length |
-- +--------------------------+--------+
SELECT title, length
FROM film
WHERE length > 120;

-- ------------------------------------------------------------------------
-- 9. Actors with last names starting with 'B' and their films
-- +------------+-----------+--------------------------+
-- | first_name | last_name | title                    |
-- +------------+-----------+--------------------------+
SELECT a.first_name, a.last_name, f.title
FROM actor a
INNER JOIN film_actor fa ON a.actor_id = fa.actor_id
INNER JOIN film f ON fa.film_id = f.film_id
WHERE a.last_name LIKE 'B%';

-- ------------------------------------------------------------------------
-- 10. Rentals in July 2005
-- +------------+-----------+---------------------+--------------------------+
-- | first_name | last_name | rental_date         | title                    |
-- +------------+-----------+---------------------+--------------------------+
SELECT c.first_name, c.last_name, DATE(r.rental_date), f.title
FROM rental r
INNER JOIN customer c ON r.customer_id = c.customer_id
INNER JOIN inventory i ON r.inventory_id = i.inventory_id
INNER JOIN film f ON i.film_id = f.film_id
WHERE r.rental_date BETWEEN '2005-07-01' AND '2005-07-31';
