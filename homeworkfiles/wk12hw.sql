-- Background:
-- You have been hired by BYU-I Air to help sort through the airportdb database. 
-- Each week you will receive a file from your manager with questions that 
-- need answered by writing queries against the database. 
-- This week your manager wants you to understand what views and CTE expressions are. 

-- week 12 questions
USE airportdb;

-- ---------------------------------------------------------------------------------
-- 1. Create a view from week 10 question 1. Make a table based on that view
--    named `passengerrewards`. Provide a select statement that queries the table.
--    DO NOT use a select * statement.
--    The columns should look like the following:
--    | Status | Number of Flights | First Name | Last Name |
-- ---------------------------------------------------------------------------------


-- --------------------------------------------------------------------------------------------------------
-- 2. What are the top 10 airports that handled the highest number of flights in August?
--    Write a CTE statement called `flight_counts` to find the answer.
--    Columns will look like the following:
--    | Airport | Flight Count |
-- --------------------------------------------------------------------------------------------------------


-- --------------------------------------------------------------------------------------------------------
-- 3. What are the top 5 longest flights by duration for each airline?
--    Don't include any duplicates.
--    Sort the results by airline name and rank.
--    Write a CTE statement called `ranked_flights` to find the answer.
--    Columns will look like the following:
--    | Airline | Flight Number | Origin Airport | Destination Airport | Flight Duration (Minutes) |
-- --------------------------------------------------------------------------------------------------------