-- *********************************
-- W08 STUDENT SQL WORKBOOK
-- Chapter 7 questions
-- Note: Some queries require the use of variables.
--       These should not be used in any homework.
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
--    The column should look like the following:
--    | Actor Name |
-- ------------------------------------------------------------------------------------------


-- ------------------------------------------------------------------------------------------
-- 2. Extract the first 3 characters from the title column in the film table.
--    The column should look like the following:
--    | Title Prefix |
-- ------------------------------------------------------------------------------------------


-- ------------------------------------------------------------------------------------------
-- 3. Find the starting position of the work 'BALL' in the title column of the film table.
--    The column should look like the following:
--    | Ball Position |
-- ------------------------------------------------------------------------------------------


-- ------------------------------------------------------------------------------------------
-- 4. Use the ball position found in the previous problem and return everything to the
--    left of it. Do not include the B in Ball.
--    The column should look like the following:
--    | Before Ball | Title |
-- ------------------------------------------------------------------------------------------


-- ------------------------------------------------------------------------------------------
-- 5. Round the amount column in the payment table to 2 decimal places, 
--    add a column to floor it as well. Add one final column to format the amount to the
--    nearest whole number. Add a $ to each price.
--    Columns should look like the following:
--    | Rounded Amount | Floored Amount | Formatted Amount |
-- ------------------------------------------------------------------------------------------


-- ------------------------------------------------------------------------------------------
-- 6. Calculate the number of days between the rental_date and return_date.
--    Exclude any NULL values and sort them from highest to lowest.
--    The column should look like the following:
--    | Days Rented |
-- ------------------------------------------------------------------------------------------


-- ------------------------------------------------------------------------------------------
-- 7. Calculate your age based on your birthdate.
--    Use the TIMESTAMPDIFF function.
--    Dates are formatted like this: 'yyyy-mm-dd'
--    The column should look like the following:
--    | My Age |
-- ------------------------------------------------------------------------------------------


-- ------------------------------------------------------------------------------------------
-- 8. Calcualte the expected return date of rentals by adding 7 days to the rental_date.
--    Format all dates to look like: January 15th, 2025 2:00:00 PM
--    The column should look like the following:
--    | Rental Date| Expected Return Date |
-- ------------------------------------------------------------------------------------------
