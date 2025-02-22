-- Background:
-- You have been hired by BYU-I Air to help sort through the airportdb database. 
-- Each week you will receive a file from your manager with questions that 
-- need answered by writing queries against the database. 
-- This week your manager wants you to understand case statements. 

-- week 9 questions
USE airportdb;

-- ---------------------------------------------------------------------------
-- 1. What are the flight details for flight AL9073 (flight id #93)?
--    Format the dates to look like: Jun 01, 2015 07:56 AM
--    The From and To columns should display the city and country together.
--    The columns should look like the following:
--    | Flight Number | From | To | Departure Date | Arrival Date |
-- ---------------------------------------------------------------------------


-- ---------------------------------------------------------------------------
-- 2. How many passengers are on flight AL9073 (flight id #93)?
--    Tell me whether or not the flight is full.
--    Code an example with seats available and when it is full
--    This should be done in one query.
--    A `group by` clause shouldn't be used.
--    The columns should look like the following:
--    | Flight Number | From | To | Plane Capacity | Original # of Passengers | Seats Remaining | Full Flight # of Passengers | Seats Remaining |
-- ---------------------------------------------------------------------------


-- -------------------------------------------------------------------------------------
-- 3. How many flights are on each day that are contained within the U.S.?
--    These flights depart from a city in the U.S. and arrives at a U.S. city
--    Also display the total amount of flights at the end
--    The columns should look like the following:
--    | Monday | Tuesday | Wednesday | Thursday | Friday | Saturday | Sunday | Total |
-- -------------------------------------------------------------------------------------


-- ---------------------------------------------------------------------------
--    YOU MAY NEED TO RUN THIS QUERY FROM THE TERMINAL TO VERIFY THAT IT WORKS
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

