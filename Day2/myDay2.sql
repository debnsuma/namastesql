-- Check the Oders table 

SELECT * FROM Orders;

-- Check the amazon_orders table 

SELECT * FROM amazon_orders;

-- If you need to save the time along with the data, we need to change the data type 
-- We need to use the ALTER TABLE (DDL) 

ALTER TABLE amazon_orders ALTER COLUMN order_date datetime;

SELECT * FROM amazon_orders;

-- Insert some data 

INSERT INTO amazon_orders VALUES(5, '2022-10-01 12:06:12', 'Shoes', 1130.5, 'UPI');
SELECT * FROM amazon_orders;

-- Lets say you forgot to add few columns, how can we add this later 

ALTER TABLE amazon_orders ADD user_id VARCHAR(20);
SELECT * FROM amazon_orders;

-- NULL is a special keyword, which means nothing. No one knows what is NULL (its not a NULL string) 

INSERT INTO amazon_orders VALUES(6, '2022-12-01 12:06:12', NULL , 1130.5, 'UPI', 'Suman');
SELECT * FROM amazon_orders;

-- How to drop a column 

ALTER TABLE amazon_orders ADD category VARCHAR(20); 
SELECT * FROM amazon_orders;

ALTER TABLE amazon_orders DROP COLUMN category;
SELECT * FROM amazon_orders;


-- Change data type of an existing column 
ALTER TABLE amazon_orders ALTER COLUMN order_id VARCHAR(10);  -- The data type should be compatible (doesnt matter data is present or not)
ALTER TABLE amazon_orders ALTER COLUMN order_id INTEGER;

SELECT * FROM amazon_orders;


-- Constrains 

-- a) NULL Constrain
CREATE TABLE a_orders
(
order_id integer NOT NULL,  -- You can not insert any NULL value for this column 
order_date date,
product_name varchar(100),
total decimal(10,2),
payment_method varchar(100)
);

SELECT * from a_orders;

-- Following statement would FAIL bcos of the NULL constrain 
INSERT INTO a_orders VALUES(NULL, '2022-12-01 12:06:12', NULL , 1130.5, 'UPI');

-- This will work 
INSERT INTO a_orders VALUES(1, '2022-12-01 12:06:12', NULL , 1130.5, 'UPI');
SELECT * from a_orders;

-- b) CHECK Constrain (Check for some condition)

DROP TABLE a_orders;
CREATE TABLE a_orders
(
order_id integer NOT NULL,   
order_date date,
product_name varchar(100),
total decimal(10,2),
payment_method varchar(100) CHECK (payment_method in ('UPI', 'CREDIT CARD'))
);

-- This will fail 
INSERT INTO a_orders VALUES(1, '2022-12-01 12:06:12', NULL , 1130.5, 'NetBanking');

-- This will work 
INSERT INTO a_orders VALUES(1, '2022-12-01 12:06:12', NULL , 1130.5, 'UPI');
SELECT * FROM a_orders;

-- Adding a column in the existing table with some CONSTRAIN 
ALTER TABLE a_orders ADD discount INTEGER CHECK (discount >= 20);

-- This will work
INSERT INTO a_orders VALUES(2, '2022-12-01 12:06:12', NULL , 1130.5, 'UPI', 100);
-- This will fail
INSERT INTO a_orders VALUES(3, '2022-12-01 12:06:12', NULL , 1130.5, 'UPI', 10);  

SELECT * FROM a_orders;

-- c) UNIQUE Constrain (we can not have duplicate value in that column) 

DROP TABLE a_orders;
CREATE TABLE a_orders
(
order_id integer NOT NULL UNIQUE,   
order_date date,
product_name varchar(100),
total decimal(10,2),
payment_method varchar(100) CHECK (payment_method in ('UPI', 'CREDIT CARD')),
);

INSERT INTO a_orders VALUES(1, '2022-12-01 12:06:12', NULL , 1130.5, 'UPI');
SELECT * FROM a_orders;
INSERT INTO a_orders VALUES(1, '2022-12-01 12:06:12', NULL , 1130.5, 'UPI', 100); -- This will fail 
INSERT INTO a_orders VALUES(NULL, '2022-12-01 12:06:12', NULL , 1130.5, 'UPI', 100); -- This will fail 

-- d) DEFAULT Constrain 
DROP TABLE a_orders;
CREATE TABLE a_orders
(
order_id integer NOT NULL UNIQUE,   
order_date date,
product_name varchar(100),
total decimal(10,2),
payment_method varchar(100) CHECK (payment_method in ('UPI', 'CREDIT CARD')),
discount INTEGER CHECK (discount >= 20),
categoty varchar(10) DEFAULT 'mens_wear'
);

INSERT INTO a_orders VALUES(1, '2022-12-01 12:06:12', NULL , 1130.5, 'UPI', 100); -- This will fail (Column name or number of supplied values does not match table definition)
INSERT INTO a_orders (order_id, order_date, product_name, total, payment_method, discount) -- This will work (As we are mentioning the column names) 
	VALUES(2, '2022-12-01 12:06:12', NULL , 1130.5, 'UPI', 100);

SELECT * FROM a_orders;
INSERT INTO a_orders (order_id, order_date, product_name, total, payment_method, discount, categoty) 
	VALUES(1, '2022-12-01 12:06:12', NULL , 1130.5, 'UPI', 100, 'kids_wear');

SELECT * FROM a_orders;

-- d) PRIMARY KEY Constrain (We can not have NULL value and we can not have Duplicate value) ==> UNIQUE + NOT NULL 

DROP TABLE a_orders;
CREATE TABLE a_orders
(
order_id integer,   
order_date date,
product_name varchar(100),
total decimal(10,2),
payment_method varchar(100) CHECK (payment_method in ('UPI', 'CREDIT CARD')),
discount INTEGER CHECK (discount >= 20),
categoty varchar(10) DEFAULT 'mens_wear',
PRIMARY KEY (order_id)
);

-- This will fail (no NULL value) 
INSERT INTO a_orders (order_id, order_date, product_name, total, payment_method, discount, categoty) 
	VALUES(NULL, '2022-12-01 12:06:12', NULL , 1130.5, 'UPI', 100, 'kids_wear');

-- This will work
INSERT INTO a_orders (order_id, order_date, product_name, total, payment_method, discount, categoty) 
	VALUES(1, '2022-12-01 12:06:12', NULL , 1130.5, 'UPI', 100, 'kids_wear');

SELECT * FROM a_orders;

-- This will fail (no duplicates)
INSERT INTO a_orders (order_id, order_date, product_name, total, payment_method, discount, categoty) 
	VALUES(1, '2022-12-01 12:06:12', NULL , 1130.5, 'UPI', 100, 'kids_wear');

-- Primary Key can be combination of multiple columns 
DROP TABLE a_orders;
CREATE TABLE a_orders
(
order_id integer,   
order_date date,
product_name varchar(100),
total decimal(10,2),
payment_method varchar(100) CHECK (payment_method in ('UPI', 'CREDIT CARD')),
discount INTEGER CHECK (discount >= 20),
categoty varchar(10) DEFAULT 'mens_wear',
PRIMARY KEY (order_id, product_name)
);

INSERT INTO a_orders (order_id, order_date, product_name, total, payment_method, discount, categoty) 
	VALUES(1, '2022-12-01 12:06:12', 'powder' , 1130.5, 'UPI', 100, 'kids_wear');

INSERT INTO a_orders (order_id, order_date, product_name, total, payment_method, discount, categoty) 
	VALUES(1, '2022-12-01 12:06:12', 'powder' , 1130.5, 'UPI', 100, 'kids_wear');

SELECT * FROM a_orders;

INSERT INTO a_orders (order_id, order_date, product_name, total, payment_method, discount, categoty) 
	VALUES(1, '2022-12-01 12:06:12', 'tshirt' , 100.5, 'UPI', 100, 'kids_wear');

SELECT * FROM a_orders;

-- Delete statement 

-- Delete ALL data 

DELETE from a_orders;

-- Delete specific row 
SELECT * FROM a_orders;

DELETE FROM a_orders
WHERE product_name = 'tshirt';

SELECT * FROM a_orders;









