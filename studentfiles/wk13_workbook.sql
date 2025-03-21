-- *********************************
-- W13 STUDENT SQL WORKBOOK
-- Chapter 16 questions
-- *********************************

/*
    SELECT     column_name AS 'Alias1'
    ,          Function(column_name_2) AS 'Alias2'
    ,          CASE column_name_3
                WHEN condition THEN # ELSE # (Condition is usually a number or string value. Can also contain calculations)
               END AS 'Alias 3' -- ALWAYS use an alias with CASE contitions
    FROM       table1 t1   -- t1 and t2 are table aliases
    JOIN       table2 t2   -- join types: INNER, LEFT, RIGHT
    ON         t1.table1_id = t2.table1_id -- PK and FK might not always be the same name
    WHERE      column_name = (SELECT column_name
                                FROM table_name ...) -- Sub Query
    ORDER BY   column_name (DESC)
    LIMIT      # of rows;
    To remember this: Stay Firm (JOINED) With Our Lord
*/

-- For all exercises in this section, use the following data set from the Sales_Fact table:

-- Sales_Fact
-- +---------+----------+-----------+
-- | year_no | month_no | tot_sales |
-- +---------+----------+-----------+
-- |    2019 |        1 |     19228 |
-- |    2019 |        2 |     18554 |
-- |    2019 |        3 |     17325 |
-- |    2019 |        4 |     13221 |
-- |    2019 |        5 |      9964 |
-- |    2019 |        6 |     12658 |
-- |    2019 |        7 |     14233 |
-- |    2019 |        8 |     17342 |
-- |    2019 |        9 |     16853 |
-- |    2019 |       10 |     17121 |
-- |    2019 |       11 |     19095 |
-- |    2019 |       12 |     21436 |
-- |    2020 |        1 |     20347 |
-- |    2020 |        2 |     17434 |
-- |    2020 |        3 |     16225 |
-- |    2020 |        4 |     13853 |
-- |    2020 |        5 |     14589 |
-- |    2020 |        6 |     13248 |
-- |    2020 |        7 |      8728 |
-- |    2020 |        8 |      9378 |
-- |    2020 |        9 |     11467 |
-- |    2020 |       10 |     13842 |
-- |    2020 |       11 |     15742 |
-- |    2020 |       12 |     18636 |
-- +---------+----------+-----------+
-- 24 rows in set (0.00 sec)

USE sakila;

-- --------------------------------------------------------------------------
-- 1. Write a query that retrieves every row from sales_fact
--    and add a column to generate a ranking based on the 
--    tot_sales column values.
--    The highest value should receive a ranking of 1, 
--    and the lowest a ranking of 24.
--    (Use RANK())
--    Example Output:
--    +---------+----------+-----------+------------+
--    | year_no | month_no | tot_sales | sales_rank |
--    +---------+----------+-----------+------------+
--    |    2019 |       12 |     21436 |          1 |
--    |    2020 |        1 |     20347 |          2 |
--    |    2019 |        1 |     19228 |          3 |
--    |    2019 |       11 |     19095 |          4 |
--    |    2020 |       12 |     18636 |          5 |
--    |    2019 |        2 |     18554 |          6 |
--    |    2020 |        2 |     17434 |          7 |
--    |    2019 |        8 |     17342 |          8 |
--    |    2019 |        3 |     17325 |          9 |
--    |    2019 |       10 |     17121 |         10 |
--    |    2019 |        9 |     16853 |         11 |
--    |    2020 |        3 |     16225 |         12 |
--    |    2020 |       11 |     15742 |         13 |
--    |    2020 |        5 |     14589 |         14 |
--    |    2019 |        7 |     14233 |         15 |
--    |    2020 |        4 |     13853 |         16 |
--    |    2020 |       10 |     13842 |         17 |
--    |    2020 |        6 |     13248 |         18 |
--    |    2019 |        4 |     13221 |         19 |
--    |    2019 |        6 |     12658 |         20 |
--    |    2020 |        9 |     11467 |         21 |
--    |    2019 |        5 |      9964 |         22 |
--    |    2020 |        8 |      9378 |         23 |
--    |    2020 |        7 |      8728 |         24 |
--    +---------+----------+-----------+------------+
--    24 rows in set (0.02 sec)
-- -------------------------------------------------------------------------- 
SELECT year_no AS 'Year Number'
,      month_no AS 'Month Number'
,      tot_sales AS 'Total Sales'
,      RANK() OVER (ORDER BY tot_sales DESC) AS 'Sales Rank'
FROM   sales_fact;

-- -------------------------------------------------------------------------- 
-- 2. Modify the query from the previous exercise to generate two sets
--    of rankings from 1 to 12
--    One for 2019 data
--    One for 2020 data
--   (Use RANK() and PARTITION BY)
--    Example Output:
--    +---------+----------+-----------+------------+
--    | year_no | month_no | tot_sales | sales_rank |
--    +---------+----------+-----------+------------+
--    |    2019 |       12 |     21436 |          1 |
--    |    2019 |        1 |     19228 |          2 |
--    |    2019 |       11 |     19095 |          3 |
--    |    2019 |        2 |     18554 |          4 |
--    |    2019 |        8 |     17342 |          5 |
--    |    2019 |        3 |     17325 |          6 |
--    |    2019 |       10 |     17121 |          7 |
--    |    2019 |        9 |     16853 |          8 |
--    |    2019 |        7 |     14233 |          9 |
--    |    2019 |        4 |     13221 |         10 |
--    |    2019 |        6 |     12658 |         11 |
--    |    2019 |        5 |      9964 |         12 |
--    |    2020 |        1 |     20347 |          1 |
--    |    2020 |       12 |     18636 |          2 |
--    |    2020 |        2 |     17434 |          3 |
--    |    2020 |        3 |     16225 |          4 |
--    |    2020 |       11 |     15742 |          5 |
--    |    2020 |        5 |     14589 |          6 |
--    |    2020 |        4 |     13853 |          7 |
--    |    2020 |       10 |     13842 |          8 |
--    |    2020 |        6 |     13248 |          9 |
--    |    2020 |        9 |     11467 |         10 |
--    |    2020 |        8 |      9378 |         11 |
--    |    2020 |        7 |      8728 |         12 |
--    +---------+----------+-----------+------------+
--    24 rows in set (0.00 sec)
-- -------------------------------------------------------------------------- 
SELECT year_no AS 'Year Number'
,      month_no AS 'Month Number'
,      tot_sales AS 'Total Sales'
,      RANK() OVER (PARTITION BY year_no 
                    ORDER BY tot_sales DESC) AS 'Sales Rank'
FROM   sales_fact;

-- -------------------------------------------------------------------------- 
-- 3. Write a query that retrieves all 202 data and include a column 
--    that will contain the tot_sales value from the previous month.
--    (Use LAG())
--    Example Output:
--    +---------+----------+-----------+------------------+
--    | year_no | month_no | tot_sales | prev_month_sales |
--    +---------+----------+-----------+------------------+
--    |    2020 |        1 |     20347 |             NULL |
--    |    2020 |        2 |     17434 |            20347 |
--    |    2020 |        3 |     16225 |            17434 |
--    |    2020 |        4 |     13853 |            16225 |
--    |    2020 |        5 |     14589 |            13853 |
--    |    2020 |        6 |     13248 |            14589 |
--    |    2020 |        7 |      8728 |            13248 |
--    |    2020 |        8 |      9378 |             8728 |
--    |    2020 |        9 |     11467 |             9378 |
--    |    2020 |       10 |     13842 |            11467 |
--    |    2020 |       11 |     15742 |            13842 |
--    |    2020 |       12 |     18636 |            15742 |
--    +---------+----------+-----------+------------------+
--    12 rows in set (0.00 sec)
-- -------------------------------------------------------------------------- 
SELECT year_no AS 'Year Number'
,      month_no AS 'Month Number'
,      tot_sales AS 'Total Sales'
,      LAG(tot_sales) OVER (ORDER BY month_no) AS 'Previous Month Sales'
FROM   sales_fact
WHERE  year_no = 2020;