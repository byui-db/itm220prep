-- *********************************
-- W08 STUDENT SQL WORKBOOK
-- Chapter 7 questions
-- *********************************

/*
    SELECT     column_name AS 'Alias1'
    ,          Function(column_name_2) AS 'Alias2'
    FROM       table1 t1   -- t1 and t2 are table aliases
    INNER JOIN table2 t2   
    ON         t1.table1_id = t2.table1_id -- PK and FK might not always be the same name
    WHERE      column_name = condition
    ORDER BY   column_name (DESC)
    LIMIT      # of rows;
    To remember this: Stay Firm (JOINED) With Our Lord
*/

-- *******************************
-- Function Reference
-- https://www.w3schools.com/mysql/mysql_ref_functions.asp
-- *******************************

-- *******************************
-- String Manipulation Functions
-- *******************************
/*
    CONCAT()
    SUBSTRING()
    LEFT()
    LOCATE()
*/

-- *******************************
-- Number Manipulation Functions
-- *******************************

/*
    ROUND() - If you want the nearest whole number
    FLOOR() - Good for calculating Age
    FORMAT() - Good for prices
*/

-- *******************************
-- Date Manipulation Functions
-- *******************************

/*
    DATEDIFF()
    TIMESTAMPDIFF()
    DATE_ADD()
    DATE_FORMAT()
    NOW()
*/



-- -----------------------------------------------------------------------------
-- 1. Write a query that returns the 17th through 25th characters of the string 
-- 'Please find the substring in this string' by using a "Parsed" column alias
-- +-----------+
-- | parsed    |
-- +-----------+
-- | substring |
-- +-----------+
-- -----------------------------------------------------------------------------
SELECT SUBSTRING('Please find the substring in this string', 17, 9) AS Parsed;

-- -----------------------------------------------------------------------------
-- 2. Write a query that returns three columns. 
-- The first column should be the absolute value of 
-- -25.76823 with an alias of 'abs', 
-- the second column should be the sign (-1,0, or 1)
--  of the number -25.76823 with an alias of 'sign', 
-- and the third column should be the number -25.76823 rounded 
-- to the nearest hundredth with an alias of 'round'. 
-- It should return the following:
-- +----------+------+--------+
-- | abs      | sign | round  |
-- +----------+------+--------+
-- | 25.76823 |   -1 | -25.77 |
-- +----------+------+--------+
-- -----------------------------------------------------------------------------
SELECT ABS(-25.76823) AS 'abs'
,      SIGN(-25.76823) AS 'sign'
,      ROUND(-25.76823, 2) AS 'round';

-- -----------------------------------------------------------------------------
-- 3. Write a query that returns just the month portion of the current date 
-- with a column alias of 'month' 
-- (for example, the number displayed changes with the day you run the query).
-- +-------+
-- | month |
-- +-------+
-- |     9 |
-- +-------+
-- -----------------------------------------------------------------------------
SELECT MONTH(NOW());

-- -----------------------------------------------------------------------------------------
-- 4. Set a session level variable with the following command:
SET @string := 'Sorcer''s Stone';
-- You can query the value of a @string session level variable with the following syntax:
SELECT @string;
-- It returns:
-- +----------------+
-- | title          |
-- +----------------+
-- | Sorcer's Stone |
-- +----------------+
-- The word "Sorcer's" should be "Sorcerer's" in the @string variable. 
-- Write a query with the appropriate string manipulation built-in functions 
-- that queries the @string variable and returns the following 
-- (there are several ways to accomplish this task):
-- +------------------+
-- | title            |
-- +------------------+
-- | Sorcerer's Stone |
-- +------------------+
-- -----------------------------------------------------------------------------------------
SELECT REPLACE(@string, 'er', 'erer') AS 'title';

-- -----------------------------------------------------------------------------------------
-- 5. Set a session level variable with the following command:
SET @string := '2024-02-29';
-- You can query the value of a @string session level variable with the following syntax:
SELECT @string;
-- It returns:
-- +------------+
-- | date       |
-- +------------+
-- | 2024-02-29 |
-- +------------+
-- Use one or more temporal functions to write a query 
-- that converts the @string variable value into
-- a the following format. 
-- The result should display:
-- +-------------+
-- | date        |
-- +-------------+
-- | 29-Feb-2024 |
-- +-------------+
-- -----------------------------------------------------------------------------------------
SELECT DATE_FORMAT(@string, '%d-%b-%Y') AS 'date';


-- ----------------------------------
-- PRACTICE
-- ----------------------------------

-- ------------------------------------------------------------------------------------------
-- 1. Write a query to concatenate the first and last name of the first 10 actors.
--    Example Output:
--    +---------------------+
--    | Actor Name          |
--    +---------------------+
--    | PENELOPE GUINESS    |
--    | NICK WAHLBERG       |
--    | ED CHASE            |
--    | JENNIFER DAVIS      |
--    | JOHNNY LOLLOBRIGIDA |
--    | BETTE NICHOLSON     |
--    | GRACE MOSTEL        |
--    | MATTHEW JOHANSSON   |
--    | JOE SWANK           |
--    | CHRISTIAN GABLE     |
--    +---------------------+
--    10 rows in set (0.00 sec)
-- ------------------------------------------------------------------------------------------
SELECT CONCAT(first_name, ' ', last_name) AS 'Actor Name'
FROM   actor
LIMIT 10;

-- ------------------------------------------------------------------------------------------
-- 2. Extract the first 3 characters from the title column in the film table.
--    Limit the output to 15 results
--    Example Output:
--    +--------------+
--    | Title Prefix |
--    +--------------+
--    | ACA          |
--    | ACE          |
--    | ADA          |
--    | AFF          |
--    | AFR          |
--    | AGE          |
--    | AIR          |
--    | AIR          |
--    | ALA          |
--    | ALA          |
--    | ALA          |
--    | ALA          |
--    | ALI          |
--    | ALI          |
--    | ALI          |
--    +--------------+
--    15 rows in set (0.00 sec)
-- ------------------------------------------------------------------------------------------
SELECT SUBSTRING(title, 1, 3) AS 'Title Prefix'
FROM   film;

-- ------------------------------------------------------------------------------------------
-- 3. Find the starting position of the work 'BALL' in the title column of the film table.
--    Only show the titles that have the word BALL in them.
--    (Numbers greater than zero should show up)
--    Example Output:
--    +---------------+
--    | Ball Position |
--    +---------------+
--    |             1 |
--    |             1 |
--    |             9 |
--    |            10 |
--    |             5 |
--    |             5 |
--    |            15 |
--    +---------------+
--    7 rows in set (0.00 sec)
-- ------------------------------------------------------------------------------------------
SELECT LOCATE('BALL', title) AS 'Ball Position'
FROM   film
WHERE  LOCATE('BALL', title);

-- ------------------------------------------------------------------------------------------
-- 4. Use the ball position found in the previous problem and return everything to the
--    left of it. Do not include the B in Ball.
--    Example Output:
--    +----------------+-----------------------+
--    | Before Ball    | Title                 |
--    +----------------+-----------------------+
--    |                | BALLOON HOMEWARD      |
--    |                | BALLROOM MOCKINGBIRD  |
--    | BED HIGH       | BED HIGHBALL          |
--    | BOONDOCK       | BOONDOCK BALLROOM     |
--    | FIRE           | FIREBALL PHILADELPHIA |
--    | HIGH           | HIGHBALL POTTER       |
--    | HOLOCAUST HIGH | HOLOCAUST HIGHBALL    |
--    +----------------+-----------------------+
--    7 rows in set (0.00 sec)
-- ------------------------------------------------------------------------------------------
SELECT LEFT(title, LOCATE('BALL', title) - 1) AS 'Before Ball'
,      title AS 'Title'
FROM   film
WHERE  LOCATE('BALL', title);

-- ------------------------------------------------------------------------------------------
-- 5. Round the amount column in the payment table to 2 decimal places, 
--    add a column to floor it as well. Add one final column to format the amount to the
--    nearest whole number. Add a $ to each price.
--    Limit the output to the last 10 results
--    Example Output:
--    +----------------+----------------+------------------+
--    | Rounded Amount | Floored Amount | Formatted Amount |
--    +----------------+----------------+------------------+
--    | $2.99          | $2             | $3               |
--    | $2.99          | $2             | $3               |
--    | $8.99          | $8             | $9               |
--    | $1.99          | $1             | $2               |
--    | $4.99          | $4             | $5               |
--    | $1.99          | $1             | $2               |
--    | $3.99          | $3             | $4               |
--    | $2.99          | $2             | $3               |
--    | $2.99          | $2             | $3               |
--    | $6.99          | $6             | $7               |
--    +----------------+----------------+------------------+
--    10 rows in set (0.00 sec)
-- ------------------------------------------------------------------------------------------
SELECT CONCAT('$',ROUND(amount, 2)) AS 'Rounded Amount'
,      CONCAT('$',FLOOR(amount)) AS 'Floored Amount'
,      CONCAT('$',FORMAT(amount, 0)) AS 'Formatted Amount'
FROM   payment;

-- ------------------------------------------------------------------------------------------
-- 6. Calculate the number of days between the rental_date and return_date.
--    Exclude any NULL values and sort them from highest to lowest.
--    Limit the output to the first 5 results
--    Example Output:
--    +-------------+--------------+
--    | Days Rented | Inventory ID |
--    +-------------+--------------+
--    |          10 |         4154 |
--    |          10 |          249 |
--    |          10 |         3627 |
--    |          10 |         2452 |
--    |          10 |         4264 |
--    +-------------+--------------+
--    5 rows in set (0.01 sec)
-- ------------------------------------------------------------------------------------------
SELECT DATEDIFF(return_date, rental_date) AS 'Days Rented'
FROM   rental
WHERE  DATEDIFF(return_date, rental_date) IS NOT NULL
ORDER BY DATEDIFF(return_date, rental_date) DESC;

-- ------------------------------------------------------------------------------------------
-- 7. Calculate your age based on your birthdate.
--    Use the TIMESTAMPDIFF function.
--    Dates are formatted like this: 'yyyy-mm-dd'
--    The column should look like the following:
--    | My Age |
-- ------------------------------------------------------------------------------------------
SELECT TIMESTAMPDIFF(YEAR, [ENTER BIRTHDATE HERE], NOW()) AS 'My Age';

-- ------------------------------------------------------------------------------------------
-- 8. Calcualte the expected return date of rentals by adding 7 days to the rental_date.
--    Format all dates to look like: January 15th, 2025 2:00:00 PM
--    Limit the output to the first 20
--    Example Output:
--    +----------------------------+----------------------------+
--    | Rental Date                | Expected Return Date       |
--    +----------------------------+----------------------------+
--    | May 24th, 2005 10:53:30 PM | May 31st, 2005 10:53:30 PM |
--    | May 24th, 2005 10:54:33 PM | May 31st, 2005 10:54:33 PM |
--    | May 24th, 2005 11:03:39 PM | May 31st, 2005 11:03:39 PM |
--    | May 24th, 2005 11:04:41 PM | May 31st, 2005 11:04:41 PM |
--    | May 24th, 2005 11:05:21 PM | May 31st, 2005 11:05:21 PM |
--    | May 24th, 2005 11:08:07 PM | May 31st, 2005 11:08:07 PM |
--    | May 24th, 2005 11:11:53 PM | May 31st, 2005 11:11:53 PM |
--    | May 24th, 2005 11:31:46 PM | May 31st, 2005 11:31:46 PM |
--    | May 25th, 2005 12:00:40 AM | June 1st, 2005 12:00:40 AM |
--    | May 25th, 2005 12:02:21 AM | June 1st, 2005 12:02:21 AM |
--    | May 25th, 2005 12:09:02 AM | June 1st, 2005 12:09:02 AM |
--    | May 25th, 2005 12:19:27 AM | June 1st, 2005 12:19:27 AM |
--    | May 25th, 2005 12:22:55 AM | June 1st, 2005 12:22:55 AM |
--    | May 25th, 2005 12:31:15 AM | June 1st, 2005 12:31:15 AM |
--    | May 25th, 2005 12:39:22 AM | June 1st, 2005 12:39:22 AM |
--    | May 25th, 2005 12:43:11 AM | June 1st, 2005 12:43:11 AM |
--    | May 25th, 2005 01:06:36 AM | June 1st, 2005 01:06:36 AM |
--    | May 25th, 2005 01:10:47 AM | June 1st, 2005 01:10:47 AM |
--    | May 25th, 2005 01:17:24 AM | June 1st, 2005 01:17:24 AM |
--    | May 25th, 2005 01:48:41 AM | June 1st, 2005 01:48:41 AM |
--    +----------------------------+----------------------------+
--    20 rows in set (0.00 sec)
-- ------------------------------------------------------------------------------------------
SELECT DATE_FORMAT(rental_date, '%M %D, %Y %r') AS 'Rental Date'
,      DATE_FORMAT(DATE_ADD(rental_date, INTERVAL 7 DAY), '%M %D, %Y %r') AS 'Expected Return Date'
FROM   rental;