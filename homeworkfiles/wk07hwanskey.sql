-- Week 7 questions
USE airportdb;

-- --------------------------------------------------------------------------
-- 1. What are the unique last names of our employees?
--    List them in alphabetical order.
--    Columns will look like the following:
--    | Last Name |
-- --------------------------------------------------------------------------
SELECT DISTINCT e.lastname AS 'Last Name'
FROM   employee e
ORDER BY e.lastname;

-- --------------------------------------------------------------------------
-- 2. What are the airlines and which airports are they based in?
--    List the airlines in alphabetical order.
--    Columns will look like the following:
--    | Airline | Airport |
-- --------------------------------------------------------------------------
SELECT al.airlinename AS 'Airline'
,      a.name AS 'Airport'
FROM   airline al
INNER JOIN airport a
ON     al.base_airport = a.airport_id
ORDER BY al.airlinename;

-- --------------------------------------------------------------------------
-- 3. What are the first 20 airports that are based in the United States?
--    Display the airport name and country.
--    Columns will look like the following:
--    | Airport | Country |
-- --------------------------------------------------------------------------
SELECT a.name AS 'Airport'
,      ag.country AS 'Country'
FROM   airport a
INNER JOIN airport_geo ag
ON      a.airport_id = ag.airport_id
WHERE  ag.country = 'United States'
LIMIT 20;

-- --------------------------------------------------------------------------
-- 4. What are the top 10 airports without an IATA code?
--    Display the airport name, IATA code, and ICAO code.
--    Columns will look like the following:
--    | Airport | IATA | ICAO |
-- --------------------------------------------------------------------------
SELECT a.name AS 'Airport'
,      a.iata AS 'IATA'
,      a.icao AS 'ICAO'
FROM   airport a
WHERE  a.iata IS NULL
LIMIT  10;


-- --------------------------------------------------------------------------
-- 5. What are the flights that depart between 10:00 and 10:15 on Monday?
--    Sort the results by departure time.
--    List the following columns:
--    | Flight Number | Departure Time | Arrival Time | Airline | Monday |
-- --------------------------------------------------------------------------
SELECT fs.flightno AS 'Flight Number'
,      fs.departure AS 'Departure Time'
,      fs.arrival AS 'Arrival Time'
,      al.airlinename AS 'Airline'
,      fs.monday AS 'Monday'
FROM flightschedule fs
INNER JOIN airline al
ON     fs.airline_id = al.airline_id
WHERE fs.departure BETWEEN '10:00:00' AND '10:15:00'
AND   fs.monday = 1
ORDER BY fs.departure;

-- --------------------------------------------------------------------------
-- 6. What are the flights that arrive between 20:00 and 20:15 and are not
--    flown on Monday?
--    Sort the results by departure time.
--    List the following columns:
--    | Flight Number | Departure Time | Arrival Time | Airline | Monday |
-- --------------------------------------------------------------------------
SELECT fs.flightno AS 'Flight Number'
,      fs.departure AS 'Departure Time'
,      fs.arrival AS 'Arrival Time'
,      al.airlinename AS 'Airline'
,      fs.monday AS 'Monday'
FROM flightschedule fs
INNER JOIN airline al
ON     fs.airline_id = al.airline_id
WHERE (fs.arrival BETWEEN '20:00:00' AND '20:15:00') 
AND NOT fs.monday = 1 
ORDER BY fs.departure;

-- ------------------------------------------------------------------------------------------
-- 7. Marilyn is trying to schedule a flight that departs sometime between
--    3PM and 4PM and arrives between 6PM and 7PM on Wednesday or Thursday.
--    She also wants to avoid flights that are operated by Cyprus Airlines. 
--    Can you help her?
--    Sort the results by departure time.
--    List the following columns:
--    | Flight Number | Departure Time | Arrival Time | Airline | Wednesday | Thursday |
-- ------------------------------------------------------------------------------------------
SELECT fs.flightno AS 'Flight Number'
,      fs.departure AS 'Departure Time'
,      fs.arrival AS 'Arrival Time'
,      al.airlinename AS 'Airline'
,      fs.wednesday AS 'Wednesday'
,      fs.thursday AS 'Thursday'
FROM   flightschedule fs
INNER JOIN airline al
ON     fs.airline_id = al.airline_id
WHERE (fs.arrival BETWEEN '18:00:00' AND '19:00:00') 
AND   (fs.departure BETWEEN '15:00:00' AND '16:00:00') 
AND NOT al.airlinename = 'Cyprus Airlines'
AND (fs.wednesday = 1 OR fs.thursday = 1)
ORDER BY fs.departure, al.airline_id;