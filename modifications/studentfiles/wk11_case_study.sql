-- Chapter 12 questions
USE sakila;

-- ---------------------------------------------------------------------------
-- 1. Create a transaction, known as a unit of work, 
-- to transfer $50 from account 123 to account 789. 
-- You will need to create two tables for this exercise. 
-- One will be the  account table and the other the transaction table. 
-- Use the following table definitions to create the tables:

-- account Table:

-- +--------------------+--------------+------+-----+---------+----------------+
-- | Field              | Type         | Null | Key | Default | Extra          |
-- +--------------------+--------------+------+-----+---------+----------------+
-- | account_id         | int unsigned | NO   | PRI | NULL    | auto_increment |
-- | avail_balance      | double       | NO   |     | NULL    |                |
-- | last_activity_date | datetime     | NO   |     | NULL    |                |
-- +--------------------+--------------+------+-----+---------+----------------+
-- 3 rows in set (0.42 sec)

-- transaction Table:

-- +----------------+--------------+------+-----+---------+----------------+
-- | Field          | Type         | Null | Key | Default | Extra          |
-- +----------------+--------------+------+-----+---------+----------------+
-- | txn_id         | int unsigned | NO   | PRI | NULL    | auto_increment |
-- | txn_date       | datetime     | YES  |     | NULL    |                |
-- | account_id     | int unsigned | YES  |     | NULL    |                |
-- | txn_type_cd    | varchar(1)   | NO   |     | NULL    |                |
-- | amount         | double       | YES  |     | NULL    |                |
-- +----------------+--------------+------+-----+---------+----------------+
-- 5 rows in set (0.64 sec)

-- Insert the an available balance of $500 for account 123 
-- and $75 for account 789 in the account table. 
-- Then, you need to insert rows into the transaction table with 
-- an initial deposit of $500 for account 123 and $75 for account 789 
-- because that's how the accounts got their available balances.

-- Deposits are credits to the bank because they hold the money for their customers, 
-- which makes the customer accounts liabilities. 
-- When you deposit money it's always a credit 
-- and when you withdraw money its always a debit. 
-- Use txn_type_cd = 'C' to indicate a credit (deposit), 
-- and use a txn_type_cd = 'D' to indicate a debit (withdrawal) 
-- in your INSERT statements to the transaction table.

-- Next, you want to transfer $50 from account 123 to account 789. 
-- To do that, you debit account 123 for $50 and credit account 789 for $50. 
-- If you've done these steps correctly, you should see the data below in the account table:

-- +------------+---------------+---------------------+
-- | account_id | avail_balance | last_activity_date  |
-- +------------+---------------+---------------------+
-- |        123 |           500 | 2019-07-10 20:53:27 |
-- |        789 |            75 | 2019-06-22 15:18:35 |
-- +------------+---------------+---------------------+
-- 2 rows in set (0.33 sec)

-- and the following in the transaction table:

-- +--------+---------------------+------------+-------------+--------+
-- | txn_id | txn_date            | account_id | txn_type_cd | amount |
-- +--------+---------------------+------------+-------------+--------+
-- |   1001 | 2019-05-15 00:00:00 |        123 | C           |    500 |
-- |   1002 | 2019-06-01 00:00:00 |        789 | C           |     75 |
-- |   1003 | 2020-11-29 15:02:35 |        123 | D           |     50 |
-- |   1004 | 2020-11-29 15:03:04 |        789 | C           |     50 |
-- +--------+---------------------+------------+-------------+--------+
-- 4 rows in set (0.42 sec)

-- When you debit the $50 from account 123 in the transaction table, 
-- you must update the avail_balance column in the account table
-- and likewise when you credit the $50 to account 789 in the transaction table, 
-- you must update the avail_balance column in the account table. 

-- After your completed the transfer of $50, 
-- re-query the account table and you should see:

-- +------------+---------------+---------------------+
-- | account_id | avail_balance | last_activity_date  |
-- +------------+---------------+---------------------+
-- |        123 |           450 | 2020-11-29 15:13:29 |
-- |        789 |           125 | 2020-11-29 15:16:13 |
-- +------------+---------------+---------------------+
-- 2 rows in set (0.04 sec)

-- Use the following query to verify the transaction table after your changes:

-- Validate the aggregated results in transaction table.
SELECT   account_id
,        SUM(
           CASE
             WHEN txn_typ_cd = 'C' THEN amount
             WHEN txn_typ_cd = 'D' THEN amount * -1
           END) AS account_balance
FROM     transaction
WHERE    account_id IN (123,789)
GROUP BY account_id;
-- ---------------------------------------------------------------------------

-- The rest are mutliple choice questions (2-5)