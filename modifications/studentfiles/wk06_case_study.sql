-- Chapter 7 questions

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
SET @string := '29-FEB-2024';
-- You can query the value of a @string session level variable with the following syntax:
SELECT @string;
-- It returns:
-- +-------------+
-- | date        |
-- +-------------+
-- | 29-FEB-2024 |
-- +-------------+
-- Use one or more temporal function to write a query 
-- that converts the @string variable value into
-- a default MySQL date format. 
-- The result should display:
-- +------------+
-- | date       |
-- +------------+
-- | 2024-02-29 |
-- +------------+
-- -----------------------------------------------------------------------------------------