-- week 11 questions
USE airportdb;

-- ---------------------------------------------------------------------------
-- 1. What are the earliest and latest flights within the U.K.?
--    How many months of data do we have for those flights?
--    The columns should look like the following:
--    | Earliest Departure | Latest Departure | Number of Months | From | To |
-- ---------------------------------------------------------------------------
SELECT MIN(f.departure) AS 'Earliest Departure'
,      MAX(f.departure) AS 'Latest Departure'
,      ROUND(DATEDIFF(MAX(f.departure), MIN(f.departure))/30) AS 'Number of Months'
,      CONCAT(ag.city, ' ', ag.country) AS 'From'
,      CONCAT(ag2.city, ' ', ag2.country) AS 'To'
FROM   flight f
INNER JOIN airport a
ON     f.from = a.airport_id
INNER JOIN airport a2
ON     f.to = a2.airport_id
INNER JOIN airport_geo ag
ON     a.airport_id = ag.airport_id
INNER JOIN airport_geo ag2
ON     a2.airport_id = ag2.airport_id
WHERE  ag.country = 'United Kingdom'
AND    ag2.country = 'United Kingdom'
GROUP BY CONCAT(ag.city, ' ', ag.country)
,        CONCAT(ag2.city, ' ', ag2.country);

-- ---------------------------------------------------------------------------------
-- 2. What is the total number of passengers that are on a flight
--    that departs from the U.K.?
--    The columns should look like the following:
--    | Total Number of Passengers | From | To | Departure Date | Flight Number |
-- --------------------------------------------------------------------------------
SELECT COUNT(b.passenger_id) AS 'Total Number of Passengers'
,      CONCAT(ag.city, ' ', ag.country) AS 'From'
,      CONCAT(ag2.city, ' ', ag2.country) AS 'To'
,      f.departure AS 'Departure Date'
,      f.flightno AS 'Flight Number'
FROM   booking b
INNER JOIN flight f
ON     b.flight_id = f.flight_id
INNER JOIN airport a
ON     f.from = a.airport_id
INNER JOIN airport a2
ON     f.to = a2.airport_id
INNER JOIN airport_geo ag
ON     a.airport_id = ag.airport_id
INNER JOIN airport_geo ag2
ON     a2.airport_id = ag2.airport_id
WHERE  ag.country = 'United Kingdom'
AND    ag2.country = 'United Kingdom'
GROUP BY CONCAT(ag.city, ' ', ag.country)
,        CONCAT(ag2.city, ' ', ag2.country)
,        f.departure
,        f.flightno;

-- ---------------------------------------------------------------------------------
-- 3. What is the total revenue generated from flights that depart from the U.K.?
--    Format the revenue with a dollar sign, comma at the thousands place,
--    rounded to 2 decimal places, and sorted with highest amount first.
--    The columns should look like the following:
--    | Total Revenue | From | To | Flight Number |
-- ---------------------------------------------------------------------------------
SELECT CONCAT('$',FORMAT(SUM(b.price),2)) AS 'Total Revenue'
,      CONCAT(ag.city, ' ', ag.country) AS 'From'
,      CONCAT(ag2.city, ' ', ag2.country) AS 'To'
,      f.flightno AS 'Flight Number'
FROM   booking b
INNER JOIN flight f
ON     b.flight_id = f.flight_id
INNER JOIN airport a
ON     f.from = a.airport_id
INNER JOIN airport a2
ON     f.to = a2.airport_id
INNER JOIN airport_geo ag
ON     a.airport_id = ag.airport_id
INNER JOIN airport_geo ag2
ON     a2.airport_id = ag2.airport_id
WHERE  ag.country = 'United Kingdom'
AND    ag2.country = 'United Kingdom'
GROUP BY CONCAT(ag.city, ' ', ag.country)
,        CONCAT(ag2.city, ' ', ag2.country)
,        f.flightno
ORDER  BY SUM(b.price) DESC;

-- ---------------------------------------------------------------------------------
-- 4. What is the average revenue above $250 generated from flights within the U.K.?
--    Format the revenue with a dollar sign, comma at the thousands place and
--    rounded to 2 decimal places.
--    The columns should look like the following:
--    | Average Revenue | From | To | Flight Number |
-- ---------------------------------------------------------------------------------
SELECT CONCAT('$',FORMAT(AVG(b.price),2)) AS 'Total Revenue'
,      CONCAT(ag.city, ' ', ag.country) AS 'From'
,      CONCAT(ag2.city, ' ', ag2.country) AS 'To'
,      f.flightno AS 'Flight Number'
FROM   booking b
INNER JOIN flight f
ON     b.flight_id = f.flight_id
INNER JOIN airport a
ON     f.from = a.airport_id
INNER JOIN airport a2
ON     f.to = a2.airport_id
INNER JOIN airport_geo ag
ON     a.airport_id = ag.airport_id
INNER JOIN airport_geo ag2
ON     a2.airport_id = ag2.airport_id
WHERE  ag.country = 'United Kingdom'
AND    ag2.country = 'United Kingdom'
GROUP BY CONCAT(ag.city, ' ', ag.country)
,        CONCAT(ag2.city, ' ', ag2.country)
,        f.flightno
HAVING AVG(b.price) > 250;

-- ---------------------------------------------------------------------------------------------------------
-- THIS QUERY MAY TAKE UP TO 1 MINUTE 30 SECONDS TO LOAD 
-- AND MAY REQUIRE YOU TO RESTART WORKBENCH
-- 5. List the number of passengers each flight serviced within the U.S.
--    Sort by total number of passengers from greatest to least
--    The activity column consists of a case statement with the
--    following conditions:
--    - If 10,000 or more, state "High Activity"
--    - If between 5,000 and 10,000, state "Moderate Activity"
--    - If between 1,000 and 5,000, state "Low Activity"
--    - If less than 1,000, state "Very Low Activity"
--    Add the total revenue generated from each flight and average cost per passenger
--    formatted with the following:
--    - Dollar sign
--    - Comma at the thousands place
--    - Rounded to 2 decimal places
--    The columns should look like the following:
--    | Flight Number | From | To | Activity | Number of Passengers | Total Revenue | Average Revenue |
-- ---------------------------------------------------------------------------------------------------------
SELECT  f.flightno AS 'Flight Number'
,       CONCAT(ag.city, ', ', ag.country) AS 'From'
,       CONCAT(ag2.city, ', ', ag2.country) AS 'To'
,       CASE 
			WHEN COUNT(b.passenger_id) > 10000 THEN 'High Activity' 
			WHEN COUNT(b.passenger_id) BETWEEN 5000 AND 10000 THEN 'Medium Activity'
			WHEN COUNT(b.passenger_id) BETWEEN 1000 AND 5000 THEN 'Low Activity'
			WHEN COUNT(b.passenger_id) < 1000 THEN 'Very Low Activity'
		END AS 'Activity'
,       COUNT(b.passenger_id) AS 'Number of Passengers'
,       CONCAT('$', FORMAT(SUM(b.price), 2)) AS 'Total Revenue'
,       CONCAT('$', FORMAT(SUM(b.price) / COUNT(b.passenger_id),2)) AS 'Average Revenue'
FROM    flight f
INNER JOIN airport a
ON      f.from = a.airport_id
INNER JOIN airport a1
ON      f.to = a1.airport_id
INNER JOIN airport_geo ag
ON      a.airport_id = ag.airport_id
INNER JOIN airport_geo ag2
ON      a1.airport_id = ag2.airport_id
INNER JOIN booking b
ON      f.flight_id = b.flight_id
WHERE   ag.country = 'United States'
AND     ag2.country = 'United States'
GROUP BY f.flightno, 2, 3
ORDER BY COUNT(b.passenger_id) DESC;