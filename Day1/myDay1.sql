--Create a database and use the database 

CREATE DATABASE namestesql;
USE namestesql;

--Create a table 

CREATE TABLE amazon_orders
(
order_id integer,
order_date date,
product_name varchar(100),
total decimal(10,2),
payment_method varchar(100)
);

/*
Data Types 
integer -> 1, 2, 3, ... any whole number
decimal -> we need to provide total length and no. of decimal point within the total length, e.g. decimal(6,2) -> 1234.56
date -> YYY-MM-DD
string -> varchar, we need to provide the length of the string within ()

Schema 
Schema is like folder (here DBO is the schema) 
Tables exist within the schema (dbo.amazon_order)
*/

-- Delete a table;
DROP TABLE amazon_orders;

-- Import the data from XLS 

SELECT * from amazon_orders;

-- Insert data in the table 

INSERT INTO amazon_orders VALUES(1, '2022-10-01', 'Baby Milk', 30.5, 'UPI');
INSERT INTO amazon_orders VALUES(2, '2022-10-02', 'Baby Powder', 130.5, 'Credit Card');

INSERT INTO amazon_orders VALUES(3, '2022-10-03', 'Baby Cream', 521.0, 'Credit Card');
INSERT INTO amazon_orders VALUES(4, '2022-10-04', 'Baby Soap', 130.5, 'UPI');

-- Check the data 

SELECT * FROM amazon_orders;

SELECT order_date, product_name FROM amazon_orders;

/* 
Order of execution 
FROM 
SELECT Columns 
*/

-- Select the top 3 orders (limiting columns)

SELECT TOP 3 * from amazon_orders;

-- Data sorting 

SELECT * from amazon_orders
ORDER BY order_date;

SELECT * from amazon_orders
ORDER BY order_date DESC;

SELECT * from amazon_orders
ORDER BY product_name DESC;

-- First preference will be given to order_date and then product_name (or order mentioned in the statement is important (LEFT to RIGHT)) 
SELECT * from amazon_orders
ORDER BY order_date DESC, product_name ASC;


-- Types of commands 
-- 1. DDL -> Data definition language (e.g. CREATE TABLE, DROP TABLE) 
-- 2. DML -> Data manupulation language (e.g. INSERT, UPDATE, etc.) 
-- 3. DQL -> Data query language (e.g. SELECT) 

-- DELETE ALL data from the table (table remains) 
DELETE FROM amazon_orders; 

SELECT * FROM amazon_orders;





