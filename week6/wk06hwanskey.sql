-- week 6 questions
USE airportdb;

-- -------------------------------------------------------------------------
-- 1. Put the first and last names of the passengers together.
--    Only show passengers that have a single letter as their last name.
--    Your columns will look like the following:
--    | Passenger Name |
-- -------------------------------------------------------------------------
SELECT   CONCAT(p.firstname, ' ', p.lastname) AS 'Passenger Name'
FROM     passenger p
WHERE    LENGTH(p.lastname) = 1
ORDER BY p.lastname;

-- -------------------------------------------------------------------------
-- 2. Locate all passenger names with their last name ending in XX.
--    Can use LIKE or REGEXP.
--    Your columns will look like the following:
--    | Passenger Name |
-- -------------------------------------------------------------------------
SELECT CONCAT(p.firstname, ' ', p.lastname) AS 'Passenger Name'
FROM   passenger p
WHERE  lastname LIKE '%XX';

-- -------------------------------------------------------------------------
-- 3. Find the airplane type that contains '747' in the identifier.
--    Print the first 15 characters of the description.
--    Hint: (Use the substring and locate functions)
--    Your columns will look like the following:
--    | Airplane Identifier | Airplane Description |
-- -------------------------------------------------------------------------
SELECT at.identifier AS 'Airplane Identifier'
,      LEFT(at.description,15) AS 'Airplane Description'
FROM   airplane_type at
WHERE  SUBSTRING(at.identifier, LOCATE('747', at.identifier), 3);

-- -------------------------------------------------------------------------------------------------
-- 4. List what each passenger paid for their seat on flight number: AF1837
--    on June 1st, 2015. Show the original price, round the price to the nearest dollar, and floor it.
--    Add a $ sign to all prices.
--    Format the dates to look like: Feb 28, 2015 3:00:00 PM
--    Sort prices from lowest to highest.
--    Columns will look like the following:
--    | Flight Number | Departure Date | Passenger Name | Price | Rounded Price | Floored Price |
-- -------------------------------------------------------------------------------------------------
SELECT f.flightno AS 'Flight Number'
,      DATE_FORMAT(f.departure, '%b %d, %Y %r') AS 'Departure Date'
,      CONCAT(p.firstname, ' ', p.lastname) AS 'Passenger Name'
,      CONCAT('$', FORMAT(b.price, 2)) AS 'Price'
,      CONCAT('$', FORMAT(b.price,0)) AS 'Rounded Price'
,      CONCAT('$', FLOOR(b.price)) AS 'Floored Price'
FROM booking b
INNER JOIN flight f
ON   b.flight_id = f.flight_id
INNER JOIN passenger p
ON   b.passenger_id = p.passenger_id
WHERE f.flightno = 'AF1837'
AND   DATE(departure) = '2015-06-01'
ORDER BY b.price;

-- -------------------------------------------------------------------------------------------------
-- 5. Find all flights that have a duration greater than 20 hours. 
--    Show hours, how many days and how many years since the flight (Use FLOOR on the year column).
--    Sort them by longest flight first.
--    Format the dates to look like: Feb 28, 2015 3:00:00 PM
--    Limit to 10 results.
--    Columns will look like the following:
--    | Departure Date | Arrival Date | Duration in Hours | Duration in Days | Years Since Flight |
-- -------------------------------------------------------------------------------------------------
SELECT DATE_FORMAT(f.departure, '%b %d, %Y %r') AS 'Departure Date'
,      DATE_FORMAT(f.arrival, '%b %d, %Y %r')  AS 'Arrival Date'
,      TIMESTAMPDIFF(hour, f.departure, f.arrival) AS 'Duration in Hours'
,      DATEDIFF(f.arrival, f.departure) AS 'Duration in Days'
,      FLOOR(DATEDIFF(NOW(), f.arrival)/365) AS 'Years Since Flight'
FROM   flight f
WHERE  TIMESTAMPDIFF(hour, f.departure, f.arrival) > 20
ORDER BY TIMESTAMPDIFF(hour, f.departure, f.arrival) DESC
LIMIT 10;

-- -------------------------------------------------------------------------
-- 6. Assign a row number to each passenger for flight number: AL9073.
--    The flight_id is 93.
--    Your columns will look like the following:
--    | Flight Number | Passenger Name | Row Number |
-- -------------------------------------------------------------------------
SELECT f.flightno AS 'Flight Number'
,      CONCAT(p.firstname, ' ', p.lastname) AS 'Passenger Name' 
,      ROW_NUMBER() OVER (ORDER BY lastname) AS 'Row Number'
FROM   flight f
INNER JOIN booking b
ON     f.flight_id = b.flight_id
INNER JOIN passenger p
ON     b.passenger_id = p.passenger_id
WHERE  f.flightno = 'AL9073' AND f.flight_id = 93;