-- Background:
-- You have been hired by BYU-I Air to help sort through the airportdb database. 
-- Each week you will receive a file from your manager with questions that 
-- need answered by writing queries against the database. 
-- This week your manager wants you to get familiar with functions. 

-- week 8 questions
USE airportdb;

-- -------------------------------------------------------------------------
-- 1. Put the first and last names of the passengers together.
--    Only show passengers that have a single letter as their last name.
--    Your columns will look like the following:
--    | Passenger Name |
-- -------------------------------------------------------------------------


-- -------------------------------------------------------------------------
-- 2. Locate all passenger names with their last name ending in XX.
--    Can use LIKE or REGEXP.
--    Your columns will look like the following:
--    | Passenger Name |
-- -------------------------------------------------------------------------


-- -------------------------------------------------------------------------
-- 3. Find the airplane type that contains '747' in the identifier.
--    Print the first 15 characters of the description.
--    Hint: (Use the substring and locate functions)
--    Your columns will look like the following:
--    | Airplane Identifier | Airplane Description |
-- -------------------------------------------------------------------------


-- -------------------------------------------------------------------------------------------------
-- 4. List what each passenger paid for their seat on flight number: AF1837
--    on June 1st, 2015. Show the original price, round the price to the nearest dollar, and floor it.
--    Add a $ sign to all prices.
--    Sort prices from lowest to highest.
--    Format the dates to look like: Feb 28, 2015 3:00:00 PM
--    Columns will look like the following:
--    | Flight Number | Departure Date | Passenger Name | Price | Rounded Price | Floored Price |
-- -------------------------------------------------------------------------------------------------


-- -------------------------------------------------------------------------------------------------
-- 5. Find all flights that have a duration greater than 20 hours. 
--    Show hours, how many days and how many years since the flight (Use FLOOR on the year column).
--    Sort them by longest flight first.
--    Format the dates to look like: Feb 28, 2015 3:00:00 PM
--    Limit to 10 results.
--    Columns will look like the following:
--    | Departure Date | Arrival Date | Duration in Hours | Duration in Days | Years Since Flight |
-- -------------------------------------------------------------------------------------------------


-- -------------------------------------------------------------------------
-- 6. Assign a row number to each passenger for flight number: AL9073.
--    The flight_id is 93.
--    Your columns will look like the following:
--    | Flight Number | Passenger Name | Row Number |
-- -------------------------------------------------------------------------
