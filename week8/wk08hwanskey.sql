-- week 8 questions
USE airportdb;

-- ---------------------------------------------------------------------------
-- 1. What are the flight details for flight AL9073 (flight id #93)?
--    Format the dates to look like: Jun 01, 2015 07:56 AM
--    The From and To columns should display the city and country together.
--    The columns should look like the following:
--    | Flight Number | From | To | Departure Date | Arrival Date |
-- ---------------------------------------------------------------------------
SELECT f.flightno AS 'Flight Number'
,      CONCAT(ag.city, ', ', ag.country) AS 'From'
,      CONCAT(ag2.city, ', ', ag2.country) AS 'To'
,      DATE_FORMAT(f.departure, '%b %d, %Y %h:%i %p') AS 'Departure Date'
,      DATE_FORMAT(f.arrival, '%b %d, %Y %h:%i %p') AS 'Arrival Date'
FROM flight f
INNER JOIN airport a
ON   f.from = a.airport_id
INNER JOIN airport a2
ON   f.to = a2.airport_id
INNER JOIN airport_geo ag
ON   a.airport_id = ag.airport_id
INNER JOIN airport_geo ag2
ON   a2.airport_id = ag2.airport_id
WHERE f.flightno = 'AL9073'
AND f.flight_id = 93
ORDER BY f.flight_id;

-- ---------------------------------------------------------------------------
-- 2. How many passengers are on flight AL9073 (flight id #93)?
--    Tell me whether or not the flight is full.
--    Code an example with seats available and when it is full
--    This should be done in one query.
--    A `group by` clause shouldn't be used.
--    The columns should look like the following:
--    | Flight Number | From | To | Plane Capacity | Original # of Passengers | Seats Remaining | Full Flight # of Passengers | Seats Remaining |
-- ---------------------------------------------------------------------------
SELECT f.flightno AS 'Flight Number'
,      CONCAT(ag.city, ', ', ag.country) AS 'From'
,      CONCAT(ag2.city, ', ', ag2.country) AS 'To'
,      ap.capacity AS 'Plane Capacity'
,      COUNT(b.passenger_id) AS 'Original Number of Passengers'
,      CASE
		WHEN ap.capacity > (COUNT(b.passenger_id)) THEN CONCAT(ap.capacity - (COUNT(b.passenger_id)), ' seats left') 
        ELSE 'Flight Full'
        END AS 'Seats remaining'
,      COUNT(b.passenger_id) + 25 AS 'Full Flight Number of Passengers'
,      CASE
		WHEN ap.capacity > (COUNT(b.passenger_id)+ 25) THEN CONCAT(ap.capacity - (COUNT(b.passenger_id)), ' seats left') 
        ELSE 'Flight Full'
        END AS 'Seats remaining'
FROM flight f
INNER JOIN airport a
ON   f.from = a.airport_id
INNER JOIN airport a1
ON   f.to = a1.airport_id
INNER JOIN airport_geo ag
ON   a.airport_id = ag.airport_id
INNER JOIN airport_geo ag2
ON   a1.airport_id = ag2.airport_id
INNER JOIN airplane ap
ON    f.airplane_id = ap.airplane_id
INNER JOIN booking b
ON    f.flight_id = b.flight_id
WHERE f.flightno = 'AL9073'
AND f.flight_id = 93
ORDER BY f.flight_id;

-- --------------------------------------------------------------------------------------
-- 3. How many flights are on each day that are contained within the U.S.?
--    These flights depart from a city in the U.S. and arrives at a U.S. city
--    Also display the total amount of flights at the end
--    The columns should look like the following:
--    | Monday | Tuesday | Wednesday | Thursday | Friday | Saturday | Sunday | Total |
-- --------------------------------------------------------------------------------------
SELECT 
	SUM(CASE WHEN fs.monday = 1 THEN 1 ELSE 0 END) AS 'Monday'
,	SUM(CASE WHEN fs.tuesday = 1 THEN 1 ELSE 0 END) AS 'Tuesday'
,	SUM(CASE WHEN fs.wednesday = 1 THEN 1 ELSE 0 END) AS 'Wednesday'
,	SUM(CASE WHEN fs.thursday = 1 THEN 1 ELSE 0 END) AS 'Thursday'
,	SUM(CASE WHEN fs.friday = 1 THEN 1 ELSE 0 END) AS 'Friday'
,	SUM(CASE WHEN fs.saturday = 1 THEN 1 ELSE 0 END) AS 'Saturday'
,	SUM(CASE WHEN fs.sunday = 1 THEN 1 ELSE 0 END) AS 'Sunday'
,   SUM(sunday + monday + tuesday + wednesday + thursday + friday + saturday) AS 'Total'
FROM flightschedule fs
INNER JOIN airport a
ON   fs.from = a.airport_id
INNER JOIN airport a1
ON   fs.to = a1.airport_id
INNER JOIN airport_geo ag
ON   a.airport_id = ag.airport_id
INNER JOIN airport_geo ag2
ON   a1.airport_id = ag2.airport_id
WHERE ag.country = 'United States'
AND   ag2.country = 'United States';

-- ---------------------------------------------------------------------------
-- THIS QUERY MAY TAKE UP TO 2 MINUTES TO RUN
-- 4. List the number of passengers each flight serviced within the U.S.
--    Sort by total number of passengers from greatest to least
--    The activity column consists of a case statement with the
--    following conditions:
--    - If 10,000 or more, state "High Activity"
--    - If between 5,000 and 10,000, state "Moderate Activity"
--    - If between 1,000 and 5,000, state "Low Activity"
--    - If less than 1,000, state "Very Low Activity"
--    The columns should look like the following:
--    | Flight Number | From | To | Activity | Number of Passengers |
-- ---------------------------------------------------------------------------
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