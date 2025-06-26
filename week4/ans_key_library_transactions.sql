SET AUTOCOMMIT=0;
USE library;
START TRANSACTION;

INSERT INTO location
(location_name)
VALUES
('Rexburg General Library');

INSERT INTO author
( author_fname
, author_lname )
VALUES
( 'A.'
, 'Carter' ),
( 'B.'
, 'Woods' ),
( 'C.'
, 'Baker' ),
( 'D.'
, 'Harper' ),
( 'E.'
, 'Lin' ),
( 'G.'
, 'Palmer' ),
( 'H.'
, 'Martinez' ),
( 'I.'
, 'King' ),
( 'J.'
, 'Reed' );

INSERT INTO genre
(genre_name)
VALUES
('Fiction'),
('Adventure'),
('Sci-Fi'),
('Historical'),
('Cookbook'),
('Mystery'),
('Non-Fiction'),
('Science'),
('Thriller'),
('Business'),
('Technology');

INSERT INTO person
( person_fname
, person_lname )
VALUES
( 'Hank'
, 'Green' ),
( 'Bob'
, 'Smith' ),
( 'Erin'
, 'Black' ),
( 'Frank'
, 'Clark' ),
( 'Alice'
, 'Brown' ),
( 'Dana'
, 'White' ),
( 'Ivy'
, 'Blue' ),
( 'Grace'
, 'Lane' ),
( 'Charlie'
, 'Gray' );

INSERT INTO book
( book_title
, book_isbn
, book_publish_year
, author_id )
VALUES
( 'The Great Escape'
, '978-3-16-148410-0'
, 2018
, (SELECT author_id FROM author WHERE CONCAT(author_fname, ' ', author_lname) = 'A. Carter')
),
( 'Journey Through Time'
, '978-0-262-13472-9'
, 2021
, (SELECT author_id FROM author WHERE CONCAT(author_fname, ' ', author_lname) = 'B. Woods')
),
( 'Mastering Cooking Basics'
, '978-1-86197-876-9'
, 2017
, (SELECT author_id FROM author WHERE CONCAT(author_fname, ' ', author_lname) = 'C. Baker')
),
( 'Mysteries of the Ocean'
, '978-0-14-312779-6'
, 2019
, (SELECT author_id FROM author WHERE CONCAT(author_fname, ' ', author_lname) = 'D. Harper')
),
( 'Advanced Robotics'
, '978-0-19-953556-9'
, 2023
, (SELECT author_id FROM author WHERE CONCAT(author_fname, ' ', author_lname) = 'E. Lin')
),
( 'Shadows of the Night'
, '978-1-59327-584-6'
, 2016
, (SELECT author_id FROM author WHERE CONCAT(author_fname, ' ', author_lname) = 'G. Palmer')
),
( 'Exploring Quantum Physics'
, '978-0-452-28834-1'
, 2022
, (SELECT author_id FROM author WHERE CONCAT(author_fname, ' ', author_lname) = 'H. Martinez')
),
( 'The Ancient Ruins'
, '978-1-4000-7545-7'
, 2015
, (SELECT author_id FROM author WHERE CONCAT(author_fname, ' ', author_lname) = 'I. King')
),
( 'Digital Marketing Essentials'
, '978-0-470-19136-6'
, 2019
, (SELECT author_id FROM author WHERE CONCAT(author_fname, ' ', author_lname) = 'J. Reed')
);

INSERT INTO stock
( book_id
, location_id
, stock_quantity )
VALUES
( (SELECT book_id FROM book WHERE book_title = 'The Great Escape')
, (SELECT location_id FROM location WHERE location_name = 'Rexburg General Library')
, 50
),
( (SELECT book_id FROM book WHERE book_title = 'Journey Through Time')
, (SELECT location_id FROM location WHERE location_name = 'Rexburg General Library')
, 50
),
( (SELECT book_id FROM book WHERE book_title = 'Mastering Cooking Basics')
, (SELECT location_id FROM location WHERE location_name = 'Rexburg General Library')
, 50
),
( (SELECT book_id FROM book WHERE book_title = 'Mysteries of the Ocean')
, (SELECT location_id FROM location WHERE location_name = 'Rexburg General Library')
, 50
),
( (SELECT book_id FROM book WHERE book_title = 'Advanced Robotics')
, (SELECT location_id FROM location WHERE location_name = 'Rexburg General Library')
, 50
),
( (SELECT book_id FROM book WHERE book_title = 'Shadows of the Night')
, (SELECT location_id FROM location WHERE location_name = 'Rexburg General Library')
, 50
),
( (SELECT book_id FROM book WHERE book_title = 'Exploring Quantum Physics')
, (SELECT location_id FROM location WHERE location_name = 'Rexburg General Library')
, 50
),
( (SELECT book_id FROM book WHERE book_title = 'The Ancient Ruins')
, (SELECT location_id FROM location WHERE location_name = 'Rexburg General Library')
, 50
),
( (SELECT book_id FROM book WHERE book_title = 'Digital Marketing Essentials')
, (SELECT location_id FROM location WHERE location_name = 'Rexburg General Library')
, 50
);

COMMIT;
-- -----------------------------------------------------------
-- These Transactions happened when the books were checked out
-- -----------------------------------------------------------
START TRANSACTION;

SAVEPOINT borrow1;

INSERT INTO borrow
( book_id
, person_id
, borrow_date
, due_date
, return_date )
VALUES
( (SELECT book_id FROM book WHERE book_title = 'The Great Escape')
, (SELECT person_id FROM person WHERE CONCAT(person_fname, ' ', person_lname) = 'Hank Green')
, '2024-10-01'
, '2024-10-15'
, NULL
);

UPDATE stock
SET stock_quantity = stock_quantity - 1
WHERE book_id = (SELECT book_id FROM book WHERE book_title = 'The Great Escape');

-- ROLLBACK TO SAVEPOINT borrow1;
COMMIT;

SELECT * FROM borrow;
SELECT * FROM stock;

START TRANSACTION;

SAVEPOINT borrow2;

INSERT INTO borrow
( book_id
, person_id
, borrow_date
, due_date
, return_date )
VALUES
( (SELECT book_id FROM book WHERE book_title = 'The Great Escape')
, (SELECT person_id FROM person WHERE CONCAT(person_fname, ' ', person_lname) = 'Alice Brown')
, '2024-10-10'
, '2024-10-24'
, NULL
);

UPDATE stock
SET stock_quantity = stock_quantity - 1
WHERE book_id = (SELECT book_id FROM book WHERE book_title = 'The Great Escape');

-- ROLLBACK TO SAVEPOINT borrow2;
COMMIT;

SELECT * FROM borrow;
SELECT * FROM stock;

START TRANSACTION;

SAVEPOINT borrow3;

INSERT INTO borrow
( book_id
, person_id
, borrow_date
, due_date
, return_date )
VALUES
( (SELECT book_id FROM book WHERE book_title = 'The Great Escape')
, (SELECT person_id FROM person WHERE CONCAT(person_fname, ' ', person_lname) = 'Charlie Gray')
, '2024-10-18'
, '2024-11-01'
, NULL
);

UPDATE stock
SET stock_quantity = stock_quantity - 1
WHERE book_id = (SELECT book_id FROM book WHERE book_title = 'The Great Escape');

-- ROLLBACK TO SAVEPOINT borrow3;
COMMIT;

SELECT * FROM borrow;
SELECT * FROM stock;

START TRANSACTION;

SAVEPOINT borrow4;

INSERT INTO borrow
( book_id
, person_id
, borrow_date
, due_date
, return_date )
VALUES
( (SELECT book_id FROM book WHERE book_title = 'Journey Through Time')
, (SELECT person_id FROM person WHERE CONCAT(person_fname, ' ', person_lname) = 'Bob Smith')
, '2024-10-04'
, '2024-10-18'
, NULL
);

UPDATE stock
SET stock_quantity = stock_quantity - 1
WHERE book_id = (SELECT book_id FROM book WHERE book_title = 'Journey Through Time');

-- ROLLBACK TO SAVEPOINT borrow4;
COMMIT;

SELECT * FROM borrow;
SELECT * FROM stock;

START TRANSACTION;

SAVEPOINT borrow5;

INSERT INTO borrow
( book_id
, person_id
, borrow_date
, due_date
, return_date )
VALUES
( (SELECT book_id FROM book WHERE book_title = 'Journey Through Time')
, (SELECT person_id FROM person WHERE CONCAT(person_fname, ' ', person_lname) = 'Frank Clark')
, '2024-10-20'
, '2024-11-03'
, NULL
);

UPDATE stock
SET stock_quantity = stock_quantity - 1
WHERE book_id = (SELECT book_id FROM book WHERE book_title = 'Journey Through Time');

-- ROLLBACK TO SAVEPOINT borrow5;
COMMIT;

SELECT * FROM borrow;
SELECT * FROM stock;

START TRANSACTION;

SAVEPOINT borrow6;

INSERT INTO borrow
( book_id
, person_id
, borrow_date
, due_date
, return_date )
VALUES
( (SELECT book_id FROM book WHERE book_title = 'Mastering Cooking Basics')
, (SELECT person_id FROM person WHERE CONCAT(person_fname, ' ', person_lname) = 'Erin Black')
, '2024-10-05'
, '2024-10-19'
, NULL
);

UPDATE stock
SET stock_quantity = stock_quantity - 1
WHERE book_id = (SELECT book_id FROM book WHERE book_title = 'Mastering Cooking Basics');

-- ROLLBACK TO SAVEPOINT borrow6;
COMMIT;

SELECT * FROM borrow;
SELECT * FROM stock;

START TRANSACTION;

SAVEPOINT borrow7;

INSERT INTO borrow
( book_id
, person_id
, borrow_date
, due_date
, return_date )
VALUES
( (SELECT book_id FROM book WHERE book_title = 'Mysteries of the Ocean')
, (SELECT person_id FROM person WHERE CONCAT(person_fname, ' ', person_lname) = 'Frank Clark')
, '2024-10-07'
, '2024-10-21'
, NULL
);

UPDATE stock
SET stock_quantity = stock_quantity - 1
WHERE book_id = (SELECT book_id FROM book WHERE book_title = 'Mysteries of the Ocean');

-- ROLLBACK TO SAVEPOINT borrow7;
COMMIT;

SELECT * FROM borrow;
SELECT * FROM stock;

START TRANSACTION;

SAVEPOINT borrow8;

INSERT INTO borrow
( book_id
, person_id
, borrow_date
, due_date
, return_date )
VALUES
( (SELECT book_id FROM book WHERE book_title = 'Advanced Robotics')
, (SELECT person_id FROM person WHERE CONCAT(person_fname, ' ', person_lname) = 'Hank Green')
, '2024-10-08'
, '2024-10-22'
, NULL
);

UPDATE stock
SET stock_quantity = stock_quantity - 1
WHERE book_id = (SELECT book_id FROM book WHERE book_title = 'Advanced Robotics');

-- ROLLBACK TO SAVEPOINT borrow8;
COMMIT;

SELECT * FROM borrow;
SELECT * FROM stock;

START TRANSACTION;

SAVEPOINT borrow9;

INSERT INTO borrow
( book_id
, person_id
, borrow_date
, due_date
, return_date )
VALUES
( (SELECT book_id FROM book WHERE book_title = 'Shadows of the Night')
, (SELECT person_id FROM person WHERE CONCAT(person_fname, ' ', person_lname) = 'Bob Smith')
, '2024-10-12'
, '2024-10-26'
, NULL
);

UPDATE stock
SET stock_quantity = stock_quantity - 1
WHERE book_id = (SELECT book_id FROM book WHERE book_title = 'Shadows of the Night');

-- ROLLBACK TO SAVEPOINT borrow9;
COMMIT;

SELECT * FROM borrow;
SELECT * FROM stock;

START TRANSACTION;

SAVEPOINT borrow10;

INSERT INTO borrow
( book_id
, person_id
, borrow_date
, due_date
, return_date )
VALUES
( (SELECT book_id FROM book WHERE book_title = 'Exploring Quantum Physics')
, (SELECT person_id FROM person WHERE CONCAT(person_fname, ' ', person_lname) = 'Dana White')
, '2024-10-14'
, '2024-10-29'
, NULL
);

UPDATE stock
SET stock_quantity = stock_quantity - 1
WHERE book_id = (SELECT book_id FROM book WHERE book_title = 'Exploring Quantum Physics');

-- ROLLBACK TO SAVEPOINT borrow10;
COMMIT;

SELECT * FROM borrow;
SELECT * FROM stock;

START TRANSACTION;

SAVEPOINT borrow11;

INSERT INTO borrow
( book_id
, person_id
, borrow_date
, due_date
, return_date )
VALUES
( (SELECT book_id FROM book WHERE book_title = 'The Ancient Ruins')
, (SELECT person_id FROM person WHERE CONCAT(person_fname, ' ', person_lname) = 'Ivy Blue')
, '2024-10-15'
, '2024-10-29'
, NULL
);

UPDATE stock
SET stock_quantity = stock_quantity - 1
WHERE book_id = (SELECT book_id FROM book WHERE book_title = 'The Ancient Ruins');

-- ROLLBACK TO SAVEPOINT borrow11;
COMMIT;

SELECT * FROM borrow;
SELECT * FROM stock;

START TRANSACTION;

SAVEPOINT borrow12;

INSERT INTO borrow
( book_id
, person_id
, borrow_date
, due_date
, return_date )
VALUES
( (SELECT book_id FROM book WHERE book_title = 'Digital Marketing Essentials')
, (SELECT person_id FROM person WHERE CONCAT(person_fname, ' ', person_lname) = 'Grace Lane')
, '2024-10-17'
, '2024-10-31'
, NULL
);

UPDATE stock
SET stock_quantity = stock_quantity - 1
WHERE book_id = (SELECT book_id FROM book WHERE book_title = 'Digital Marketing Essentials');

-- ROLLBACK TO SAVEPOINT borrow12;
COMMIT;

SELECT * FROM borrow;
SELECT * FROM stock;

-- -----------------------------------------------------------
-- These Transactions happened when the books were returned
-- -----------------------------------------------------------
START TRANSACTION;

SAVEPOINT return1;

UPDATE borrow
SET return_date = '2024-10-12'
WHERE book_id = (SELECT book_id FROM book WHERE book_title = 'The Great Escape')
AND   person_id = (SELECT person_id FROM person WHERE CONCAT(person_fname, ' ', person_lname) = 'Hank Green');

UPDATE stock
SET stock_quantity = stock_quantity + 1
WHERE book_id = (SELECT book_id FROM book WHERE book_title = 'The Great Escape');

-- ROLLBACK TO SAVEPOINT return1;
COMMIT;

SELECT * FROM borrow;
SELECT * FROM stock;

START TRANSACTION;

SAVEPOINT return2;

UPDATE borrow
SET return_date = '2024-10-16'
WHERE book_id = (SELECT book_id FROM book WHERE book_title = 'Mastering Cooking Basics')
AND   person_id = (SELECT person_id FROM person WHERE CONCAT(person_fname, ' ', person_lname) = 'Erin Black');

UPDATE stock
SET stock_quantity = stock_quantity + 1
WHERE book_id = (SELECT book_id FROM book WHERE book_title = 'Mastering Cooking Basics');

-- ROLLBACK TO SAVEPOINT return2;
COMMIT;

SELECT * FROM borrow;
SELECT * FROM stock;