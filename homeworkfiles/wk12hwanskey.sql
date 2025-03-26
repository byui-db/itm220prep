-- Background:
-- You have been hired by BYU-I Air to help sort through the airportdb database. 
-- Each week you will receive a file from your manager with questions that 
-- need answered by writing queries against the database. 
-- This week your manager wants you to understand what views and CTE expressions are. 

-- week 12 questions
USE airportdb;

-- ---------------------------------------------------------------------------------
-- 1. Create a view from week 10 question 1 named passengerrewards_view. 
--    Make a table based on that view named `passengerrewards`. 
--    Provide a select statement that queries the table.
--    DO NOT use a select * statement.
--    The columns should look like the following:
--    | Status | Number of Flights | First Name | Last Name | Departure Month |
-- ---------------------------------------------------------------------------------
-- View:
DROP VIEW IF EXISTS passengerrewards_view;
CREATE OR REPLACE VIEW passengerrewards_view AS
SELECT
	CASE 
     WHEN COUNT(b.passenger_id) >= 30 THEN 'Platinum'
     WHEN COUNT(b.passenger_id) >= 20 THEN 'Gold'
     WHEN COUNT(b.passenger_id) >= 10 THEN 'Silver'
	ELSE 'No Status'
    END AS 'status'
,   COUNT(b.passenger_id) AS 'number_of_flights'
,   p.firstname AS 'first_name'
,   p.lastname AS 'last_name'
,   CASE
	 WHEN MONTH(fl.departure) = 6 THEN 'June'
	 WHEN MONTH(fl.departure) = 7 THEN 'July'
	 WHEN MONTH(fl.departure) = 8 THEN 'August'
	 WHEN MONTH(fl.departure) = 9 THEN 'September'
    ELSE 'N/A'
    END AS 'departure_month'
FROM passenger p
LEFT JOIN passengerdetails pd
ON   p.passenger_id = pd.passenger_id
LEFT JOIN booking b
ON   p.passenger_id = b.passenger_id
LEFT JOIN flight fl
ON   b.flight_id = fl.flight_id
LEFT JOIN airport ap
ON   fl.from = ap.airport_id
LEFT JOIN airport_geo apg
ON   ap.airport_id = apg.airport_id
WHERE (pd.country = 'United Kingdom' AND apg.country = 'United Kingdom')
OR    (b.passenger_id IS NULL AND pd.country = 'United Kingdom')
OR    (b.passenger_id IS NULL AND pd.country IS NULL)
GROUP BY p.firstname
,        p.lastname
,        5
ORDER BY COUNT(b.passenger_id) DESC;

-- Table Creation:
CREATE TABLE passengerrewards AS
SELECT * FROM passengerrewards_view;

-- Question Answer:
SELECT pr.status AS 'Status'
,      pr.number_of_flights AS 'Number of Flights'
,      pr.first_name AS 'First Name'
,      pr.last_name AS 'Last Name'
,      pr.departure_month AS 'Departure Month'
FROM   passengerrewards pr;

-- --------------------------------------------------------------------------------------------------------
-- 2. What are the top 10 airports that handled the highest number of outbound flights in August?
--    Write a CTE statement called `flight_counts` to find the answer.
--    Columns will look like the following:
--    | Airport | Flight Count |
-- --------------------------------------------------------------------------------------------------------
WITH flight_counts AS (
    SELECT a.name AS airport
	,      COUNT(f.flight_id) AS flight_count
    FROM   airport a
	INNER JOIN flight f
    ON     a.airport_id = f.from
    WHERE  f.departure BETWEEN '2015-07-01' AND '2015-07-31'
    GROUP BY a.name
)
SELECT fc.airport AS 'Airport'
,      fc.flight_count AS 'Flight Count'
FROM   flight_counts fc
ORDER BY fc.flight_count DESC
LIMIT 10;

-- --------------------------------------------------------------------------------------------------------
-- 3. What are the top 5 longest flights by duration for each airline?
--    Don't include any duplicates.
--    Sort the results by airline name and rank.
--    Write a CTE statement called `ranked_flights` to find the answer.
--    Columns will look like the following:
--    | Airline | Flight Number | Origin Airport | Destination Airport | Flight Duration (Minutes) |
-- --------------------------------------------------------------------------------------------------------
WITH ranked_flights AS (
    SELECT DISTINCT al.airlinename
	,      f.flightno
	,      a.name AS origin_airport
	,      a2.name AS destination_airport
	,      TIMESTAMPDIFF(MINUTE, f.departure, f.arrival) AS duration_minutes
	,      DENSE_RANK() OVER (PARTITION BY al.airlinename ORDER BY (SELECT duration_minutes) DESC) AS 'rank'
    FROM   airline al
    INNER JOIN flight f
    ON     al.airline_id = f.airline_id
    INNER JOIN airport a
    ON     f.from = a.airport_id
    INNER JOIN airport a2
    ON     f.to = a2.airport_id
)
SELECT rf.airlinename AS 'Airline'
,      rf.flightno AS 'Flight Number'
,      rf.origin_airport AS 'Origin Airport'
,      rf.destination_airport AS 'Destination Airport'
,      rf.duration_minutes AS 'Flight Duration (Minutes)'
FROM   ranked_flights rf
WHERE  rf.rank <= 5
ORDER BY rf.airlinename
,        rf.rank;
