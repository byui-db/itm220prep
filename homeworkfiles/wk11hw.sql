-- Background:
-- You have been hired by BYU-I Air to help sort through the airportdb database. 
-- Each week you will receive a file from your manager with questions that 
-- need answered by writing queries against the database. 
-- This week your manager wants you to understand the possibilities of using aggregate functions. 

-- week 11 questions
USE airportdb;

-- ---------------------------------------------------------------------------
-- 1. What is the earliest and latest flight that departs from the U.K.?
--    The columns should look like the following:
--    | Earliest Departure | Latest Departure | From | To |
-- ---------------------------------------------------------------------------


-- ---------------------------------------------------------------------------------
-- 2. What is the total number of passengers that are on a flight
--    within the U.K.?
--    The columns should look like the following:
--    | Total Number of Passengers | From | To | Departure Date | Flight Number |
-- --------------------------------------------------------------------------------


-- ---------------------------------------------------------------------------------
-- 3. What is the total revenue generated from flights within the U.K.?
--    Format the revenue with a dollar sign, comma at the thousands place and
--    rounded to 2 decimal places.
--    The columns should look like the following:
--    | Total Revenue | From | To | Flight Number |
-- ---------------------------------------------------------------------------------


-- ---------------------------------------------------------------------------------
-- 4. What is the average revenue above $250 generated from flights within the U.K.?
--    Format the revenue with a dollar sign, comma at the thousands place and
--    rounded to 2 decimal places.
--    The columns should look like the following:
--    | Average Revenue | From | To | Flight Number |
-- ---------------------------------------------------------------------------------


-- ---------------------------------------------------------------------------------------------------------
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
