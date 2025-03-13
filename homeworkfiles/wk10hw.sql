-- Background:
-- You have been hired by BYU-I Air to help sort through the airportdb database. 
-- Each week you will receive a file from your manager with questions that 
-- need answered by writing queries against the database. 
-- This week your manager wants you to understand left joins. 

-- week 10 questions
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


-- --------------------------------------------------------------
-- 2. Who in the 'no status' section from the previous query
--    have never flown?
--    Columns will look like the following:
--    | Status | Number of Flights | First Name | Last Name | Departure Month |
-- --------------------------------------------------------------


-- --------------------------------------------------------------------------------
-- 3. Who has never flown and doesn't have any records in our
--    passenger details table?
--    | Status | Number of Flights | First Name | Last Name | Departure Month | Passenger Country |
-- --------------------------------------------------------------------------------