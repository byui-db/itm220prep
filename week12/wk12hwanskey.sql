-- Background:(WINDOWING FUNCTIONS with CTEs or Subqueries)
-- You have been hired by BYU-I Air to help sort through the airportdb database. 
-- Each week you will receive a file from your manager with questions that 
-- need answered by writing queries against the database. 
-- This week your manager wants you to understand what windowing functions are. 
-- One point for a CTE or Subquery version of the query, Two points for both. 
-- Cannot use AI to convert one to the other for points.
-- Cannot use AI for a complete solution.
-- Appropriate use of AI is having it teach you about the concepts and then you write the queries.
USE airportdb;

-- ---------------------------------------------------------------------------------
-- 1. What are the top 10 airlines by customer activity? (number of customers served)
-- ---------------------------------------------------------------------------------
SELECT
   airline_name
  ,customers_served
  ,airline_rank
FROM (
  SELECT
    a.airlinename AS airline_name
    ,COUNT(b.passenger_id) AS customers_served
    ,RANK() OVER (ORDER BY COUNT(b.passenger_id) DESC) AS 'airline_rank'
  FROM booking b
  JOIN flight f ON b.flight_id = f.flight_id
  JOIN airline a ON f.airline_id = a.airline_id
  GROUP BY a.airlinename
) ranked_airlines
WHERE airline_rank <= 10;
-- ---------------
-- CTE Version
-- ---------------
WITH ranked_airlines AS (
  SELECT
    a.airlinename AS airline_name
    ,COUNT(b.passenger_id) AS customers_served
    ,RANK() OVER (ORDER BY COUNT(b.passenger_id) DESC) AS airline_rank
  FROM booking b
  JOIN flight f ON b.flight_id = f.flight_id
  JOIN airline a ON f.airline_id = a.airline_id
  GROUP BY a.airlinename
)
SELECT
	 airline_name
	,customers_served
	,airline_rank
FROM ranked_airlines
WHERE airline_rank <= 10;

-- --------------------------------------------------------------------------------------------------------
-- 2. What are the top 10 airlines by revenue?
-- --------------------------------------------------------------------------------------------------------
SELECT
   airline_name
  ,revenue
  ,airline_rank
FROM (
  SELECT
    a.airlinename AS airline_name
    ,CONCAT('$', FORMAT(SUM(b.price),0)) AS revenue
    ,RANK() OVER (ORDER BY SUM(b.price) DESC) AS 'airline_rank'
  FROM booking b
  JOIN flight f ON b.flight_id = f.flight_id
  JOIN airline a ON f.airline_id = a.airline_id
  GROUP BY a.airlinename
) ranked_airlines
WHERE airline_rank <= 10;
-- ---------------
-- CTE Version
-- ---------------
WITH ranked_airlines AS (
  SELECT
    a.airlinename AS airline_name
    ,CONCAT('$', FORMAT(SUM(b.price),0)) AS revenue
    ,RANK() OVER (ORDER BY SUM(b.price) DESC) AS airline_rank
  FROM booking b
  JOIN flight f ON b.flight_id = f.flight_id
  JOIN airline a ON f.airline_id = a.airline_id
  GROUP BY a.airlinename
)
SELECT
	 airline_name
	,revenue
	,airline_rank
FROM ranked_airlines
WHERE airline_rank <= 10;

-- --------------------------------------------------------------------------------------------------------
-- 3. Which airlines are on both lists?
-- --------------------------------------------------------------------------------------------------------
SELECT
   ra1.airline_name
  ,ra1.customers_served
  ,ra2.revenue
  ,ra1.airline_rank AS customer_rank
  ,ra2.airline_rank AS revenue_rank
FROM (
  SELECT
    a.airline_id
    ,a.airlinename AS airline_name
    ,CONCAT('$', FORMAT(SUM(b.price),0)) AS revenue
    ,RANK() OVER (ORDER BY SUM(b.price) DESC) AS 'airline_rank'
  FROM booking b
  JOIN flight f ON b.flight_id = f.flight_id
  JOIN airline a ON f.airline_id = a.airline_id
  GROUP BY a.airlinename, a.airline_id
) ra1
JOIN (
  SELECT
     a.airline_id
    ,a.airlinename AS airline_name
    ,COUNT(b.passenger_id) AS customers_served
    ,RANK() OVER (ORDER BY COUNT(b.passenger_id) DESC) AS 'airline_rank'
  FROM booking b
  JOIN flight f ON b.flight_id = f.flight_id
  JOIN airline a ON f.airline_id = a.airline_id
  GROUP BY a.airlinename, a.airline_id
) ra2
ON ra1.airline_id = ra2.airline_id
WHERE ra1.airline_rank <= 10
AND ra2.airline_rank <=10;
-- ---------------
-- CTE Version
-- ---------------
WITH ra1 AS (
  SELECT
    a.airline_id
    ,a.airlinename AS airline_name
    ,COUNT(b.passenger_id) AS customers_served
    ,RANK() OVER (ORDER BY COUNT(b.passenger_id) DESC) AS airline_rank
  FROM booking b
  JOIN flight f ON b.flight_id = f.flight_id
  JOIN airline a ON f.airline_id = a.airline_id
  GROUP BY a.airline_id, a.airlinename
),
ra2 AS (
  SELECT
     a.airline_id
    ,a.airlinename AS airline_name
    ,CONCAT('$', FORMAT(SUM(b.price),0)) AS revenue
    ,RANK() OVER (ORDER BY SUM(b.price) DESC) AS airline_rank
  FROM booking b
  JOIN flight f ON b.flight_id = f.flight_id
  JOIN airline a ON f.airline_id = a.airline_id
  GROUP BY a.airline_id, a.airlinename
)
SELECT
   ra1.airline_name
  ,ra1.customers_served
  ,ra2.revenue
  ,ra1.airline_rank AS customer_rank
  ,ra2.airline_rank AS revenue_rank
FROM ra1
JOIN ra2 ON ra1.airline_id = ra2.airline_id
WHERE ra1.airline_rank <= 10
  AND ra2.airline_rank <= 10;

-- --------------------------------------------------------------------------------------------------------
-- 4. Compare the top 10 airlines by revenue vs the 11 – 20 airlines by revenue. 
-- How big of a gap is there?
-- --------------------------------------------------------------------------------------------------------
SELECT
  CONCAT('$', FORMAT(SUM(CASE WHEN revenue_group = 'Top 10' THEN group_revenue END), 0)) AS top_10_revenue,
  CONCAT('$', FORMAT(SUM(CASE WHEN revenue_group = 'Next 10' THEN group_revenue END), 0)) AS next_10_revenue,
  CONCAT('$', FORMAT(
    SUM(CASE WHEN revenue_group = 'Top 10' THEN group_revenue END) -
    SUM(CASE WHEN revenue_group = 'Next 10' THEN group_revenue END), 0)) AS revenue_gap
FROM (
  SELECT
    CASE
      WHEN revenue_rank BETWEEN 1 AND 10 THEN 'Top 10'
      WHEN revenue_rank BETWEEN 11 AND 20 THEN 'Next 10'
    END AS revenue_group,
    SUM(total_revenue) AS group_revenue
  FROM (
    SELECT
      a.airline_id,
      a.airlinename AS airline_name,
      SUM(b.price) AS total_revenue,
      RANK() OVER (ORDER BY SUM(b.price) DESC) AS revenue_rank
    FROM booking b
    JOIN flight f ON b.flight_id = f.flight_id
    JOIN airline a ON f.airline_id = a.airline_id
    GROUP BY a.airline_id, a.airlinename
  ) AS revenue_ranked
  WHERE revenue_rank BETWEEN 1 AND 20
  GROUP BY revenue_group
) AS grouped_revenue;
-- ---------------
-- CTE Version
-- ---------------
WITH revenue_ranked AS (
  SELECT
    a.airline_id,
    a.airlinename AS airline_name,
    SUM(b.price) AS total_revenue,
    RANK() OVER (ORDER BY SUM(b.price) DESC) AS revenue_rank
  FROM booking b
  JOIN flight f ON b.flight_id = f.flight_id
  JOIN airline a ON f.airline_id = a.airline_id
  GROUP BY a.airline_id, a.airlinename
),
grouped_revenue AS (
  SELECT
    CASE
      WHEN revenue_rank BETWEEN 1 AND 10 THEN 'Top 10'
      WHEN revenue_rank BETWEEN 11 AND 20 THEN 'Next 10'
    END AS revenue_group,
    SUM(total_revenue) AS group_revenue
  FROM revenue_ranked
  WHERE revenue_rank BETWEEN 1 AND 20
  GROUP BY revenue_group
)
SELECT
  CONCAT('$',FORMAT(SUM(CASE WHEN revenue_group = 'Top 10' THEN group_revenue END),0)) AS top_10_revenue,
  CONCAT('$',FORMAT(SUM(CASE WHEN revenue_group = 'Next 10' THEN group_revenue END),0)) AS next_10_revenue,
  CONCAT('$',FORMAT(SUM(CASE WHEN revenue_group = 'Top 10' THEN group_revenue END) - 
  SUM(CASE WHEN revenue_group = 'Next 10' THEN group_revenue END),0)) AS revenue_gap
FROM grouped_revenue;

-- --------------------------------------------------------------------------------------------------------
-- 5. Compare the top 20 airlines by revenue. Compare the 1st to the  2nd, the 2nd to the 3rd, and so on.
-- How big of a gap is there?
-- --------------------------------------------------------------------------------------------------------
SELECT
  revenue_rank,
  airline_name,
  CONCAT('$', FORMAT(total_revenue, 0)) AS total_revenue,
  next_airline_name,
  CONCAT('$', FORMAT(next_revenue, 0)) AS next_revenue,
  CONCAT('$', FORMAT(total_revenue - next_revenue, 0)) AS revenue_gap
FROM (
  SELECT
    a.airline_id,
    a.airlinename AS airline_name,
    SUM(b.price) AS total_revenue,
    RANK() OVER (ORDER BY SUM(b.price) DESC) AS revenue_rank,
    LEAD(a.airlinename) OVER (ORDER BY SUM(b.price) DESC) AS next_airline_name,
    LEAD(SUM(b.price)) OVER (ORDER BY SUM(b.price) DESC) AS next_revenue
  FROM booking b
  JOIN flight f ON b.flight_id = f.flight_id
  JOIN airline a ON f.airline_id = a.airline_id
  GROUP BY a.airline_id, a.airlinename
) ranked
WHERE revenue_rank <= 20;
-- ---------------
-- CTE Version
-- ---------------
WITH revenue_ranked AS (
  SELECT
    a.airline_id,
    a.airlinename AS airline_name,
    SUM(b.price) AS total_revenue,
    RANK() OVER (ORDER BY SUM(b.price) DESC) AS revenue_rank,
    LEAD(a.airlinename) OVER (ORDER BY SUM(b.price) DESC) AS next_airline_name,
    LEAD(SUM(b.price)) OVER (ORDER BY SUM(b.price) DESC) AS next_revenue
  FROM booking b
  JOIN flight f ON b.flight_id = f.flight_id
  JOIN airline a ON f.airline_id = a.airline_id
  GROUP BY a.airline_id, a.airlinename
)
SELECT
  revenue_rank,
  airline_name,
  CONCAT('$', FORMAT(total_revenue, 0)) AS total_revenue,
  next_airline_name,
  CONCAT('$', FORMAT(next_revenue, 0)) AS next_revenue,
  CONCAT('$', FORMAT(total_revenue - next_revenue, 0)) AS revenue_gap
FROM revenue_ranked
WHERE revenue_rank <= 20;
