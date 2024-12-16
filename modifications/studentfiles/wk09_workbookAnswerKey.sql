-- Chapter 11 questions
USE sakila;

-- ---------------------------------------------------------------------------
-- 1. Rewrite the following query, which uses a simple CASE expression, 
-- so that the same results are achieved using a searched CASE expression. 
-- Try to use as few WHEN clauses as possible.
SELECT  name
,       CASE name
            WHEN 'English'  THEN 'latin1'
            WHEN 'Italian'  THEN 'latin1'
            WHEN 'French'   THEN 'latin1'
            WHEN 'German'   THEN 'latin1'
            WHEN 'Japanese' THEN 'utf8'
            WHEN 'Mandarin' THEN 'utf8'
            ELSE 'UNKNOWN'
        END AS character_set
FROM    language;

-- It should return:

-- +----------+---------------+
-- | name     | character_set |
-- +----------+---------------+
-- | English  | latin1        |
-- | Italian  | latin1        |
-- | Japanese | utf8          |
-- | Mandarin | utf8          |
-- | French   | latin1        |
-- | German   | latin1        |
-- +----------+---------------+
-- 6 rows in set (0.38 sec)
-- ---------------------------------------------------------------------------
SELECT name,
	CASE
		WHEN name IN ('English','Italian','French','German')
        THEN 'latin1'
        WHEN name IN ('Japanese','Mandarin')
        THEN 'utf8'
        ELSE 'unknown'
	END AS character_set
FROM language;

-- ---------------------------------------------------------------------------
-- 2. Rewrite the following query so that the result set contains 
-- a single row with five columns (one for each rating). 
-- Name the five columns (G, PG, PG_13, R, and NC_17).
SELECT   rating
,        COUNT(*)
FROM     film
GROUP BY rating;

-- It retrieves:

-- +--------+----------+
-- | rating | COUNT(*) |
-- +--------+----------+
-- | PG     |      209 |
-- | G      |      178 |
-- | NC-17  |      210 |
-- | PG-13  |      232 |
-- | R      |      195 |
-- +--------+----------+
-- 5 rows in set (0.54 sec)

-- The modified query should return the following:

-- +------+------+-------+------+-------+
-- | G    | PG   | PG-13 | R    | NC-17 |
-- +------+------+-------+------+-------+
-- |  178 |  199 |   226 |  195 |   210 |
-- +------+------+-------+------+-------+
-- 1 row in set (0.00 sec)
-- ---------------------------------------------------------------------------
SELECT
	SUM(CASE WHEN rating = 'G' THEN 1 ELSE 0 END) AS 'G'
,   SUM(CASE WHEN rating = 'PG' THEN 1 ELSE 0 END) AS 'PG'
,   SUM(CASE WHEN rating = 'PG-13' THEN 1 ELSE 0 END) AS 'PG-13'
,   SUM(CASE WHEN rating = 'R' THEN 1 ELSE 0 END) AS 'R'
,   SUM(CASE WHEN rating = 'NC-17' THEN 1 ELSE 0 END) AS 'NC-17'
FROM film;

-- ---------------------------------------------------------------------------
-- 3. Write a query that returns the alphabetized first letter 
-- of the customer's last name and the count of active and inactive customers. 
-- Limit the results to only those first letters that occur in the 
-- last_name column of the customer table.

-- Label the columns as follows:

-- starts_with is the first column and the first letter of the customer's last_name.

-- active_count is the second column and the count of active customers 
--              (as defined in the textbook examples of Chapter 11).

-- inactive_count is the third column and the count of inactive customers 
--                (as defined in the textbook examples of Chapter 11).

-- The output should look like the following:

-- +-------------+--------------+----------------+
-- | starts_with | active_count | inactive_count |
-- +-------------+--------------+----------------+
-- | A           |           18 |              2 |
-- | B           |           55 |              0 |
-- | C           |           49 |              3 |
-- | D           |           17 |              0 |
-- | E           |           11 |              2 |
-- | F           |           25 |              0 |
-- | G           |           42 |              1 |
-- | H           |           49 |              0 |
-- | I           |            3 |              0 |
-- | J           |           13 |              1 |
-- | K           |           13 |              0 |
-- | L           |           21 |              1 |
-- | M           |           57 |              2 |
-- | N           |           10 |              1 |
-- | O           |           10 |              0 |
-- | P           |           28 |              0 |
-- | Q           |            3 |              0 |
-- | R           |           38 |              2 |
-- | S           |           54 |              0 |
-- | T           |           20 |              0 |
-- | V           |            7 |              0 |
-- | W           |           37 |              1 |
-- | Y           |            3 |              0 |
-- +-------------+--------------+----------------+
-- 23 rows in set (0.00 sec)
-- ---------------------------------------------------------------------------
SELECT SUBSTRING(last_name, 1,1) AS starts_with
,      SUM(CASE WHEN active = 1 THEN 1 ELSE 0 END) AS active_count
,      SUM(CASE WHEN active = 0 THEN 1 ELSE 0 END) AS inactive_count
FROM   customer
GROUP BY SUBSTRING(last_name, 1,1)
ORDER BY SUBSTRING(last_name, 1,1);

-- ---------------------------------------------------------------------------
-- 4. Write a query that returns the alphabetized first letter 
-- of the customer's last name and the count of active and inactive customers.
-- DO NOT limit the results to only those first letters that occur 
-- in the last_name column of the customer table but 
-- return results that include any missing letters from the data set. 
-- (HINT: You will need to fabricate a table composed of the 26 letters 
-- of the alphabet and use an outer join to resolve this problem.)

-- Label the columns as follows:

-- starts_with is the first column and the first letter of the customer's last_name.

-- active_count is the second column and the count of active customers 
--              (as defined in the textbook examples of Chapter 11).
-- inactive_count is the third column and the count of inactive customers 
--                (as defined in the textbook examples of Chapter 11).

-- The output should look like the following:

-- +-------------+--------------+----------------+
-- | starts_with | active_count | inactive_count |
-- +-------------+--------------+----------------+
-- | A           |           18 |              2 |
-- | B           |           55 |              0 |
-- | C           |           49 |              3 |
-- | D           |           17 |              0 |
-- | E           |           11 |              2 |
-- | F           |           25 |              0 |
-- | G           |           42 |              1 |
-- | H           |           49 |              0 |
-- | I           |            3 |              0 |
-- | J           |           13 |              1 |
-- | K           |           13 |              0 |
-- | L           |           21 |              1 |
-- | M           |           57 |              2 |
-- | N           |           10 |              1 |
-- | O           |           10 |              0 |
-- | P           |           28 |              0 |
-- | Q           |            3 |              0 |
-- | R           |           38 |              2 |
-- | S           |           54 |              0 |
-- | T           |           20 |              0 |
-- | U           |            0 |              0 |
-- | V           |            7 |              0 |
-- | W           |           37 |              1 |
-- | X           |            0 |              0 |
-- | Y           |            3 |              0 |
-- | Z           |            0 |              0 |
-- +-------------+--------------+----------------+
-- 26 rows in set (0.00 sec)
-- ---------------------------------------------------------------------------
WITH letters AS
(SELECT 'A' AS letter
 UNION ALL
 SELECT 'B' AS letter
 UNION ALL
 SELECT 'C' AS letter
 UNION ALL
 SELECT 'D' AS letter
 UNION ALL
 SELECT 'E' AS letter
 UNION ALL
 SELECT 'F' AS letter
 UNION ALL
 SELECT 'G' AS letter
 UNION ALL
 SELECT 'H' AS letter
 UNION ALL
 SELECT 'I' AS letter
 UNION ALL
 SELECT 'J' AS letter
 UNION ALL
 SELECT 'K' AS letter
 UNION ALL
 SELECT 'L' AS letter
 UNION ALL
 SELECT 'M' AS letter
 UNION ALL
 SELECT 'N' AS letter
 UNION ALL
 SELECT 'O' AS letter
 UNION ALL
 SELECT 'P' AS letter
 UNION ALL
 SELECT 'Q' AS letter
 UNION ALL
 SELECT 'R' AS letter
 UNION ALL
 SELECT 'S' AS letter
 UNION ALL
 SELECT 'T' AS letter
 UNION ALL
 SELECT 'U' AS letter
 UNION ALL
 SELECT 'V' AS letter
 UNION ALL
 SELECT 'W' AS letter
 UNION ALL
 SELECT 'X' AS letter
 UNION ALL
 SELECT 'Y' AS letter
 UNION ALL
 SELECT 'Z' AS letter)
SELECT l.letter AS starts_with
,	   SUM(CASE WHEN active = 1 THEN 1 ELSE 0 END) AS active_count
,      SUM(CASE WHEN active = 0 THEN 1 ELSE 0 END) AS inactive_count
FROM   customer c RIGHT JOIN letters l
ON     SUBSTR(c.last_name,1,1) = l.letter
GROUP BY l.letter
ORDER BY 1;

-- ---------------------------------------------------------------------------
-- 5. Write a query that returns the alphabetized first letter 
-- of the customer's last name and the count of active and inactive customers 
-- for only those letters where the count of active customers is greater than 30.

-- Label the columns as follows:

-- starts_with is the first column and the first letter of the customer's last_name.
-- active_count is the second column and the count of active customers 
--              (as defined in the textbook examples of Chapter 11).
-- inactive_count is the third column and the count of inactive customers 
--                (as defined in the textbook examples of Chapter 11).

-- The output should look like the following:

-- +-------------+--------------+----------------+
-- | starts_with | active_count | inactive_count |
-- +-------------+--------------+----------------+
-- | B           |           55 |              0 |
-- | C           |           49 |              3 |
-- | G           |           42 |              1 |
-- | H           |           49 |              0 |
-- | M           |           57 |              2 |
-- | R           |           38 |              2 |
-- | S           |           54 |              0 |
-- | W           |           37 |              1 |
-- +-------------+--------------+----------------+
-- 8 rows in set (0.00 sec)
-- ---------------------------------------------------------------------------
SELECT SUBSTR(last_name, 1,1) AS starts_with
,	   SUM(CASE WHEN active = 1 THEN 1 ELSE 0 END) AS active_count
,      SUM(CASE WHEN active = 0 THEN 1 ELSE 0 END) AS inactive_count
FROM   customer
GROUP BY SUBSTR(last_name,1,1)
HAVING SUM(CASE WHEN active = 1 THEN 1 ELSE 0 END) > 30
ORDER BY 1;