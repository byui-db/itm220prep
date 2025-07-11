-- *********************************
-- W08 STUDENT SQL WORKBOOK
-- Chapter 11 questions
-- CASE Statements or Conditional Logic
-- *********************************

/*
    SELECT     column_name AS 'Alias1'
    ,          Function(column_name_2) AS 'Alias2'
    ,          CASE column_name_3
                WHEN condition THEN # ELSE # (Condition is usually a number or string value. Can also contain calculations)
               END AS 'Alias 3' -- ALWAYS use an alias with CASE contitions
    FROM       table1 t1   -- t1 and t2 are table aliases
    INNER JOIN table2 t2   
    ON         t1.table1_id = t2.table1_id -- PK and FK might not always be the same name
    WHERE      column_name = condition
    ORDER BY   column_name (DESC)
    LIMIT      # of rows;
    To remember this: Stay Firm (JOINED) With Our Lord
*/

/*
    The CASE clause is the "IF" statement of SQL. 
    It allows us to match conditions and set results based on the condition met.
    This is useful for the following reasons:
        * In one column we can have a different result returned based on the condition
        * We can manipulate the output from the data to display relevant information

    Example: A boolean field in SQL is stored as a TINYINT. This causes it to be
    stored as a 1 or a 0. Using a case statement we can have the query state the
    words 'TRUE' or 'FALSE' based on if the result is 1 or 0.

    Example Query:
    --
    This query checks to see if the customer is active or not,
    then it orders by their active state, then last name
    --
    SELECT  c.customer_id
    ,       CONCAT(c.first_name, ' ', c.last_name) AS customer_name
    ,       CASE 
            WHEN c.active = 1 THEN 'Active'
            ELSE 'Inactive'
            END AS status
    FROM    customer c
    ORDER BY c.active DESC, c.last_name;

*/

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


-- ----------------------------------
-- PRACTICE
-- ----------------------------------

-- ------------------------------------------------------------------------------------------
-- 1. List the titles of all films and classify them according to the following rules:
--    * If the length is less than 60 minutes, label them as 'Short'
--    * If the length is between 60 and 120 minutes, label them as 'Medium'
--    * If the length is greater than 120 minutes, label them as 'Long'
--    Sort by shortest film first.
--    Example Output:
--    +-----------------------------+----------------------+
--    | title                       | film_length_category |
--    +-----------------------------+----------------------+
--    | ACE GOLDFINGER              | Short                |
--    | ADAPTATION HOLES            | Short                |
--    | AIRPORT POLLOCK             | Short                |
--    | ALIEN CENTER                | Short                |
--    | ALTER VICTORY               | Short                |
--    | ...                         | ...                  |
--    | VISION TORQUE               | Short                |
--    | WESTWARD SEABISCUIT         | Short                |
--    | WHISPERER GIANT             | Short                |
--    | WOLVES DESIRE               | Short                |
--    | ZORRO ARK                   | Short                |
--    | ACADEMY DINOSAUR            | Medium               |
--    | AFFAIR PREJUDICE            | Medium               |
--    | AIRPLANE SIERRA             | Medium               |
--    | ALABAMA DEVIL               | Medium               |
--    | ALADDIN CALENDAR            | Medium               |
--    | ...                         | ...                  |
--    | WORKING MICROCOSMOS         | Medium               |
--    | WYOMING STORM               | Medium               |
--    | YENTL IDAHO                 | Medium               |
--    | ZHIVAGO CORE                | Medium               |
--    | ZOOLANDER FICTION           | Medium               |
--    | AFRICAN EGG                 | Long                 |
--    | AGENT TRUMAN                | Long                 |
--    | ALAMO VIDEOTAPE             | Long                 |
--    | ALASKA PHANTOM              | Long                 |
--    | ALI FOREVER                 | Long                 |
--    | ...                         | ...                  |
--    | WORST BANGER                | Long                 |
--    | WRATH MILE                  | Long                 |
--    | WRONG BEHAVIOR              | Long                 |
--    | YOUNG LANGUAGE              | Long                 |
--    | YOUTH KICK                  | Long                 |
--    +-----------------------------+----------------------+
--    1000 rows in set (0.00 sec)
--    Columns should look like the following:
--    | Title | Film_Length_Category |
-- ------------------------------------------------------------------------------------------
SELECT title
,      CASE 
           WHEN length < 60 THEN 'Short' 
           WHEN length BETWEEN 60 AND 120 THEN 'Medium' 
           ELSE 'Long' 
       END AS film_length_category
FROM   film
ORDER BY film_length_category;


-- ------------------------------------------------------------------------------------------
-- 2. Create a list of customers and note indicating an 'Active' or 'Inactive' status.
--    Example Output:
--    +-----------------------+----------+
--    | Customer Name         | Status   |
--    +-----------------------+----------+
--    | MARY SMITH            | Active   |
--    | PATRICIA JOHNSON      | Active   |
--    | LINDA WILLIAMS        | Active   |
--    | BARBARA JONES         | Active   |
--    | ELIZABETH BROWN       | Active   |
--    | JENNIFER DAVIS        | Active   |
--    | MARIA MILLER          | Active   |
--    | SUSAN WILSON          | Active   |
--    | MARGARET MOORE        | Active   |
--    | DOROTHY TAYLOR        | Active   |
--    | LISA ANDERSON         | Active   |
--    | NANCY THOMAS          | Active   |
--    | KAREN JACKSON         | Active   |
--    | BETTY WHITE           | Active   |
--    | HELEN HARRIS          | Active   |
--    | SANDRA MARTIN         | Inactive |
--    | ...                   | ...      |
--    | TERRANCE ROUSH        | Inactive |
--    | RENE MCALISTER        | Active   |
--    | EDUARDO HIATT         | Active   |
--    | TERRENCE GUNDERSON    | Active   |
--    | ENRIQUE FORSYTHE      | Active   |
--    | FREDDIE DUGGAN        | Active   |
--    | WADE DELVALLE         | Active   |
--    | AUSTIN CINTRON        | Active   |
--    +-----------------------+----------+
--    599 rows in set (0.00 sec)
--    Columns should look like the following:
--    | Customer Name | Status |
-- ------------------------------------------------------------------------------------------
SELECT CONCAT(first_name, ' ', last_name) AS 'Customer Name'
,      CASE 
           WHEN active = 1 THEN 'Active' 
           ELSE 'Inactive' 
       END AS Status
FROM   customer;


-- ------------------------------------------------------------------------------------------
-- 3. Show the titles of all films. Include the rental_duration column too.
--    Add an additional column to classify the rental duration 
--    according to the following rules:
--    * If the rental_duration is less than 4 days, label it as 'Short Term'
--    * If the rental_duration is beween 4 and 7 days, label it as 'Standard Term'
--    * If the rental_duration is greater than 7 days, label it as 'Long Term'
--    Sort by longest duration first.
--    Example Output:
--    +-----------------------------+-----------------+--------------------------+
--    | Title                       | Rental Duration | Rental_Duration_Category |
--    +-----------------------------+-----------------+--------------------------+
--    | ACADEMY DINOSAUR            |               6 | Standard Term            |
--    | ADAPTATION HOLES            |               7 | Standard Term            |
--    | AFFAIR PREJUDICE            |               5 | Standard Term            |
--    | AFRICAN EGG                 |               6 | Standard Term            |
--    | ...                         |             ... | ...                      |
--    | YOUTH KICK                  |               4 | Standard Term            |
--    | ZHIVAGO CORE                |               6 | Standard Term            |
--    | ZOOLANDER FICTION           |               5 | Standard Term            |
--    | ACE GOLDFINGER              |               3 | Short Term               |
--    | AGENT TRUMAN                |               3 | Short Term               |
--    | ALABAMA DEVIL               |               3 | Short Term               |
--    | ...                         |            ...  | ...                      |
--    | WORDS HUNTER                |               3 | Short Term               |
--    | WORLD LEATHERNECKS          |               3 | Short Term               |
--    | ZORRO ARK                   |               3 | Short Term               |
--    +-----------------------------+-----------------+--------------------------+
--    1000 rows in set (0.00 sec)
--    Columns should look like the following:
--    | Title | Rental Duration | Rental_Duration_Category |
-- ------------------------------------------------------------------------------------------
SELECT title AS 'Title'
,      rental_duration AS 'Rental Duration'
,      CASE 
           WHEN rental_duration < 4 THEN 'Short Term' 
           WHEN rental_duration BETWEEN 4 AND 7 THEN 'Standard Term' 
           ELSE 'Long Term' 
       END AS Rental_Duration_Category
FROM   film
ORDER BY Rental_Duration_Category DESC;


-- ------------------------------------------------------------------------------------------
-- 4. For each customer, calculate their total rental payment and classify them
--    according to the following rules:
--    * If the total payment is less than $50, label them as a 'Low Spender'
--    * If the total payment is between $50 and $100, label them as a 'Medium Spender'
--    * If the total payment is any higher, label them as a 'High Spender'
--    Note: This query requires a GROUP BY clause. This clause will be covered more in depth
--          in week 11. Here is the basic rule: Any column NOT in the SUM function goes
--          in the GROUP BY clause. For this question, the GROUP BY clause is formatted
--          like this:
--    GROUP BY c.customer_id
--    ,        CONCAT(first_name, ' ', last_name)
--    Sort by low spenders first. Format the total payment with a $ in front.
--    Example Output:
--    +-----------------------+---------------+-------------------+
--    | Customer Name         | Total Payment | Spending_Category |
--    +-----------------------+---------------+-------------------+
--    | BARBARA JONES         | $81.78        | Medium Spender    |
--    | JENNIFER DAVIS        | $93.72        | Medium Spender    |
--    | SUSAN WILSON          | $92.76        | Medium Spender    |
--    | MARGARET MOORE        | $89.77        | Medium Spender    |
--    | DOROTHY TAYLOR        | $99.75        | Medium Spender    |
--    | DONNA THOMPSON        | $98.79        | Medium Spender    |
--    | ...                   | ...           | ...               |
--    | ENRIQUE FORSYTHE      | $96.72        | Medium Spender    |
--    | FREDDIE DUGGAN        | $99.75        | Medium Spender    |
--    | WADE DELVALLE         | $83.78        | Medium Spender    |
--    | AUSTIN CINTRON        | $83.81        | Medium Spender    |
--    | MARY SMITH            | $118.68       | High Spender      |
--    | PATRICIA JOHNSON      | $128.73       | High Spender      |
--    | LINDA WILLIAMS        | $135.74       | High Spender      |
--    | ELIZABETH BROWN       | $144.62       | High Spender      |
--    | JIMMIE EGGLESTON      | $135.72       | High Spender      |
--    | ...                   | ...           | ...               |
--    | KENT ARSENAULT        | $134.73       | High Spender      |
--    | TERRANCE ROUSH        | $111.71       | High Spender      |
--    | RENE MCALISTER        | $113.74       | High Spender      |
--    | EDUARDO HIATT         | $130.73       | High Spender      |
--    | TERRENCE GUNDERSON    | $117.70       | High Spender      |
--    +-----------------------+---------------+-------------------+
--    599 rows in set (0.03 sec)
--    Columns will look like the following:
--    | Customer Name | Total Payment | Spending_Category |
-- ------------------------------------------------------------------------------------------
SELECT CONCAT(c.first_name, ' ', c.last_name) AS 'Customer Name'
,      CONCAT('$', SUM(p.amount)) AS 'Total Payment'
,      CASE 
           WHEN SUM(p.amount) < 50 THEN 'Low Spender' 
           WHEN SUM(p.amount) BETWEEN 50 AND 100 THEN 'Medium Spender' 
           ELSE 'High Spender' 
       END AS Spending_Category
FROM   customer c
INNER JOIN payment p 
ON     c.customer_id = p.customer_id
GROUP BY c.customer_id
,        CONCAT(c.first_name, ' ', c.last_name)
ORDER BY Spending_Category DESC;