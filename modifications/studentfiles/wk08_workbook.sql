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