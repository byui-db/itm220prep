-- week 09 questions
USE airportdb;

-- ---------------------------------------------------------------------------
-- 1. Who are our frequent fliers that reside in the U.K. and have flown somewhere in the world from the U.K.?

--    a. Create a CASE statement with the following conditions:
--       Show passenger's status as 'Platinum', 'Gold', 'Silver', or 'No Status' based on the number of flights they have taken.
--       The conditions are as follows:
--       - Platinum: 30 or more flights
--       - Gold: 20 or more flights
--       - Silver: 10 or more flights
--       - No Status: Less than 10 flights
 
--    b. Next, Count how many flights a passenger has flown and add that to your query.
 
--    c. Show the first and last name of the passenger in separate columns
 
--    d. Create one final CASE statement to display the name of the Departure Month.
--       - The months that exist in this dataset are: June, July, August, and September
 
--    e. Filter your query to only show passengers that fall under these conditions:
--       - They are from the U.K. and their flight departs from the U.K.
--       - They have never flown but are from the U.K.
--       - They have never flown and their information is incomplete
 
--    f. Sort by the number of flights from greatest to least
 
--    g. Group by the last 3 columns in your select statement. 
--       The CASE statement can be referenced by its position in the select statement. 
--       In this case it would be 5.
--    The columns should look like the following:
--    | Status | Number of Flights | First Name | Last Name | Departure Month |
-- ---------------------------------------------------------------------------
SELECT
	CASE 
     WHEN COUNT(b.passenger_id) >= 30 THEN 'Platinum'
     WHEN COUNT(b.passenger_id) >= 20 THEN 'Gold'
     WHEN COUNT(b.passenger_id) >= 10 THEN 'Silver'
	ELSE 'No Status'
    END AS 'Status'
,   COUNT(b.passenger_id) AS 'Number of Flights'
,   p.firstname AS 'First Name'
,   p.lastname AS 'Last Name'
,   CASE
	 WHEN MONTH(fl.departure) = 6 THEN 'June'
	 WHEN MONTH(fl.departure) = 7 THEN 'July'
	 WHEN MONTH(fl.departure) = 8 THEN 'August'
	 WHEN MONTH(fl.departure) = 9 THEN 'September'
    ELSE 'N/A'
    END AS 'Departure Month'
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


-- --------------------------------------------------------------
-- 2. Who in the 'no status' section from the previous query
--    have never flown?
--    Columns will look like the following:
--    | Status | Number of Flights | First Name | Last Name | Departure Month | 
-- --------------------------------------------------------------
SELECT
	CASE 
     WHEN COUNT(b.passenger_id) >= 30 THEN 'Platinum'
     WHEN COUNT(b.passenger_id) >= 20 THEN 'Gold'
     WHEN COUNT(b.passenger_id) >= 10 THEN 'Silver'
	ELSE 'No Status'
    END AS 'Status'
,   COUNT(b.passenger_id) AS 'Number of Flights'
,   p.firstname AS 'First Name'
,   p.lastname AS 'Last Name'
,   CASE
	 WHEN MONTH(fl.departure) = 6 THEN 'June'
	 WHEN MONTH(fl.departure) = 7 THEN 'July'
	 WHEN MONTH(fl.departure) = 8 THEN 'August'
	 WHEN MONTH(fl.departure) = 9 THEN 'September'
    ELSE 'N/A'
    END AS 'Departure Month'
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
HAVING COUNT(b.passenger_id) = 0
ORDER BY COUNT(b.passenger_id) DESC;


-- --------------------------------------------------------------------------------
-- 3. Who has never flown and doesn't have any records in our
--    passenger details table?
--    | Status | Number of Flights | First Name | Last Name | Departure Month | Passenger Country |
-- --------------------------------------------------------------------------------
SELECT CASE 
		WHEN COUNT(b.passenger_id) >= 30 THEN 'Platinum'
		WHEN COUNT(b.passenger_id) >= 20 THEN 'Gold' 
        WHEN COUNT(b.passenger_id) >= 10 THEN 'Silver'
        ELSE 'No Status'
		END AS 'Status'
,      COUNT(b.passenger_id) AS 'Number of Flights'
,      p.firstname AS 'First Name'
,      p.lastname AS 'Last Name'
,   CASE
	 WHEN MONTH(fl.departure) = 6 THEN 'June'
	 WHEN MONTH(fl.departure) = 7 THEN 'July'
	 WHEN MONTH(fl.departure) = 8 THEN 'August'
	 WHEN MONTH(fl.departure) = 9 THEN 'September'
    ELSE 'N/A'
    END AS 'Departure Month'
,      pd.country AS 'Passenger Country'
FROM   passenger p
LEFT JOIN passengerdetails pd
ON     p.passenger_id = pd.passenger_id
LEFT JOIN booking b
ON     p.passenger_id =  b.passenger_id
LEFT JOIN flight fl
ON     b.flight_id = fl.flight_id
LEFT JOIN airport a
ON     fl.from = a.airport_id
LEFT JOIN airport_geo ag
ON     a.airport_id = ag.airport_id
WHERE  (b.passenger_id IS NULL AND pd.country IS NULL)
GROUP BY p.firstname
,        p.lastname
,        pd.country
,        5
HAVING   COUNT(b.passenger_id) = 0
ORDER BY COUNT(b.passenger_id) DESC;