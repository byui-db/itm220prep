-- Chapter 13 Questions
USE sakila;

-- ---------------------------------------------------------------------------
-- 1. Generate an alter table statement for the rental table 
-- so that an error will be raised if a row having a value found 
-- in the rental.customer_id column is deleted from the customer table. 
-- You should label the constraint as fk_rental_customer_id.

-- You can use the following ALTER statement 
-- to retest the addition of the necessary constraint:

ALTER TABLE rental
DROP FOREIGN KEY fk_rental_customer_id;

-- You can use the following query to validate the fk_rental_customer_id constraint:

SELECT   CONCAT(tc.table_schema,'.',tc.table_name,'.',tc.constraint_name) AS "Constraint"
,        CONCAT(kcu.table_schema,'.',kcu.table_name,'.',kcu.column_name) AS "Foreign Key"
,        CONCAT(kcu.referenced_table_schema,'.',kcu.referenced_table_name,'.',kcu.referenced_column_name) AS "Primary Key"
FROM     information_schema.table_constraints tc JOIN information_schema.key_column_usage kcu
ON       tc.constraint_name = kcu.constraint_name
AND      tc.constraint_schema = kcu.constraint_schema
WHERE    tc.constraint_type = 'FOREIGN KEY'
AND      tc.constraint_schema = database()
AND      tc.table_name = 'rental'
AND      kcu.column_name = 'customer_id'
ORDER BY tc.table_name
,        kcu.column_name;

-- It should return the following:

-- +-------------------------------------+---------------------------+-----------------------------+
-- | Constraint                          | Foreign Key               | Primary Key                 |
-- +-------------------------------------+---------------------------+-----------------------------+
-- | sakila.rental.fk_rental_customer_id | sakila.rental.customer_id | sakila.customer.customer_id |
-- +-------------------------------------+---------------------------+-----------------------------+
-- 1 row in set (2.37 sec)
-- ---------------------------------------------------------------------------


-- ---------------------------------------------------------------------------
-- 2. Generate a multicolumn index on the payment table 
-- that could be used by both of the following queries:

SELECT customer_id
,      payment_date
,      amount
FROM   payment
WHERE  payment_date > CAST('2006-02-14 03:59:59' AS DATETIME);


SELECT customer_id
,      payment_date
,      amount
FROM   payment
WHERE  payment_date > CAST('2006-02-14 03:59:59' AS DATETIME)
AND   amount < 5;

-- You can use the following query to validate the idx_payment01 constraint:

SELECT   s.table_name
,        s.index_name
,        s.seq_in_index
,        s.column_name
FROM     information_schema.statistics s
WHERE    s.table_name = 'payment'
AND      s.index_name = 'idx_payment01'
AND      s.non_unique = TRUE
AND      NOT EXISTS
        (SELECT   null
        FROM     information_schema.table_constraints tc
        WHERE    s.table_name = tc.table_name
        AND      s.index_name = tc.constraint_name)
ORDER BY s.table_name
,        s.seq_in_index;

-- It should return the following:

-- +------------+---------------+--------------+--------------+
-- | TABLE_NAME | INDEX_NAME    | SEQ_IN_INDEX | COLUMN_NAME  |
-- +------------+---------------+--------------+--------------+
-- | payment    | idx_payment01 |            1 | payment_date |
-- | payment    | idx_payment01 |            2 | amount       |
-- +------------+---------------+--------------+--------------+
-- 2 rows in set (0.20 sec)
-- ---------------------------------------------------------------------------

-- ---------------------------------------------------------------------------
-- 4. Assume you have a vehicle table with the following table definition:

-- +--------------+--------------+------+-----+---------+----------------+
-- | Field        | Type         | Null | Key | Default | Extra          |
-- +--------------+--------------+------+-----+---------+----------------+
-- | vehicle_id   | int unsigned | NO   | PRI | NULL    | auto_increment |
-- | vin          | varchar(17)  | YES  | UNI | NULL    |                |
-- | vehicle_name | varchar(64)  | YES  |     | NULL    |                |
-- +--------------+--------------+------+-----+---------+----------------+

-- The vehicle_id column is the surrogate key column, 
-- and the vin (Vehicle Identification Number) column is the natural key column, 
-- and the vehicle_name column is a non-key column.

-- 4.1 Write an idx_vehicle_vin unique index on the vin column.

-- You can use the following query to validate the idx_vehicle_vin index on the vehicle table:

SELECT   s.table_name
,        s.index_name
,        s.seq_in_index
,        s.column_name
FROM     information_schema.statistics s
WHERE    s.table_name = 'vehicle'
AND      s.index_name = 'idx_vehicle_vin'
AND      s.non_unique = FALSE
AND      EXISTS
        (SELECT   null
        FROM     information_schema.table_constraints tc
        WHERE    s.table_name = tc.table_name
        AND      s.index_name = tc.constraint_name)
ORDER BY s.table_name
,        s.seq_in_index;

-- It should return the following:

-- +------------+-----------------+--------------+-------------+
-- | TABLE_NAME | INDEX_NAME      | SEQ_IN_INDEX | COLUMN_NAME |
-- +------------+-----------------+--------------+-------------+
-- | vehicle    | idx_vehicle_vin |            1 | vin         |
-- +------------+-----------------+--------------+-------------+
-- 1 row in set (0.00 sec)
-- ---------------------------------------------------------------------------


-- ---------------------------------------------------------------------------
-- 5. Assume you have a vehicle table with the following table definition:

-- +--------------+--------------+------+-----+---------+----------------+
-- | Field        | Type         | Null | Key | Default | Extra          |
-- +--------------+--------------+------+-----+---------+----------------+
-- | vehicle_id   | int unsigned | NO   | PRI | NULL    | auto_increment |
-- | vin          | varchar(17)  | YES  | UNI | NULL    |                |
-- | vehicle_name | varchar(64)  | YES  |     | NULL    |                |
-- +--------------+--------------+------+-----+---------+----------------+

-- The vehicle_id column is the surrogate key column, 
-- and the vin (Vehicle Identification Number) column is the natural key column, 
-- and the vehicle_name column is a non-key column.

-- 5.1. Write a idx_vehicle_combo unique index on the vehicle_id and vin columns?

-- You can use the following query to validate the idx_vehicle_vin index on the vehicle table:

-- Query the index definition.
SELECT   s.table_name
,        s.index_name
,        s.seq_in_index
,        s.column_name
FROM     information_schema.statistics s
WHERE    s.table_name = 'vehicle'
AND      s.index_name = 'idx_vehicle_combo'
AND      s.non_unique = FALSE
AND      EXISTS
        (SELECT   null
        FROM     information_schema.table_constraints tc
        WHERE    s.table_name = tc.table_name
        AND      s.index_name = tc.constraint_name)
ORDER BY s.table_name
,        s.seq_in_index;

-- It should return the following:

-- +------------+-------------------+--------------+--------------+
-- | TABLE_NAME | INDEX_NAME        | SEQ_IN_INDEX | COLUMN_NAME  |
-- +------------+-------------------+--------------+--------------+
-- | vehicle    | idx_vehicle_combo |            1 | vin          |
-- | vehicle    | idx_vehicle_combo |            2 | vehicle_name |
-- +------------+-------------------+--------------+--------------+
-- 2 rows in set (0.04 sec)
-- ---------------------------------------------------------------------------

