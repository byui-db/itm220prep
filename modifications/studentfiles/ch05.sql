-- Chapter 5 questions
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
SELECT   c.first_name, c.last_name, a.address, ct.city
FROM     customer c INNER JOIN address a
ON       c.address_id = a.address_id INNER JOIN city ct
ON       a.city_id = ct.city_id
WHERE    a.district = 'California';

-- --------------------------------------------------------------------------
-- 2. Write a query that returns the title of every film in which an actor 
-- with the first name JOHN appeared.
-- You will use the actor, film_actor and film tables 
-- to answer this question.
-- --------------------------------------------------------------------------
SELECT f.title
FROM   film f INNER JOIN film_actor fa
ON     f.film_id = fa.film_id INNER JOIN actor a
ON     fa.actor_id = a.actor_id
WHERE  a.first_name = 'JOHN';

-- --------------------------------------------------------------------------
-- 3. Construct a query that returns all addresses from the address table 
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
SELECT    a1.address AS addr1
,         a2.address AS addr2
,         c.city
FROM      address a1 INNER JOIN address a2
ON        a1.city_id = a2.city_id INNER JOIN city c
ON        a1.city_id = c.city_id
WHERE NOT a1.address = a2.address;

-- --------------------------------------------------------------------------
-- 4. Write a query that shows all the films starring Joe Swank 
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
SELECT title
,      length
FROM   film f INNER JOIN film_actor fa
ON     f.film_id = fa.film_id INNER JOIN actor a
ON     fa.actor_id = a.actor_id
WHERE  f.length BETWEEN 90 AND 120
AND    a.first_name = 'JOE'
AND    a.last_name = 'SWANK';

-- --------------------------------------------------------------------------
-- 5. Write a query that shows the staff members who rented items. 
-- You will use the staff and rental tables to answer this question.
-- +------------+-----------+
-- | first_name | last_name |
-- +------------+-----------+
-- | Jon        | Stephens  |
-- | Mike       | Hillyer   |
-- +------------+-----------+
-- --------------------------------------------------------------------------
SELECT   s.first_name
,        s.last_name
,        COUNT(r.rental_id)
FROM     staff s INNER JOIN rental r
ON       s.staff_id = r.staff_id
GROUP BY s.first_name
,        s.last_name;
