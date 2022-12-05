
SELECT * FROM orders;

-- Check the DISTINCT values 
SELECT DISTINCT ship_mode
FROM orders;

-- Distinct combination of columns 
SELECT DISTINCT ship_mode, Segment
FROM orders;

-- If any two rows have exact same data, it will return one 
SELECT DISTINCT * 
FROM orders;

-- CAST (chage datetime to date) 

SELECT * FROM orders;

SELECT CAST(order_date AS date) AS date, *
FROM orders;

-- This wont work as mydate is not a column 
SELECT CAST(order_date AS date) AS mydate, *
FROM orders
WHERE mydate > '2020-11-09';

-- Create a new column (this is just for viewing) 

SELECT *, profit/sales AS ratio
FROM orders;

-- This wont work as mydate is not a column 
SELECT *, profit/sales AS ratio
FROM orders
WHERE ratio > .5;

-- Get the current date 

SELECT *, profit/sales AS ratio, GETDATE() as present_date
FROM orders;

-- FILTERS --

-- a) WHERE Clause 
SELECT * FROM orders 
WHERE Ship_Mode = 'First Class';

SELECT * FROM orders 
WHERE Order_Date = '2020-08-11';

SELECT * FROM orders 
WHERE Quantity > 10;

--- Order of execution 

SELECT TOP 5 Order_Date, Quantity FROM orders 
WHERE Quantity > 5
ORDER BY Quantity;

/* 
FROM 
WHERE
ORDER BY 
SELECT 
TOP 5 
*/

-- b) WHERE Clause and BETWEEN Operator 

SELECT * FROM Orders;

SELECT * FROM orders 
WHERE Quantity BETWEEN 2 AND 6
ORDER BY Quantity DESC;

SELECT * FROM orders 
WHERE Order_Date BETWEEN '2019-10-10' AND '2020-10-10' AND Quantity BETWEEN 1 AND 2
ORDER BY Quantity DESC;

-- c) WHERE Clause and IN Operator (works with INT, STRING, DATES)

SELECT * FROM Orders
WHERE Ship_Mode IN ('First Class', 'Standard Class');

SELECT DISTINCT Ship_Mode FROM Orders
WHERE Ship_Mode IN ('First Class', 'Standard Class');

-- d) WHERE Clause and NOT IN Operator (works with INT, STRING, DATES)

SELECT * FROM Orders
WHERE Ship_Mode NOT IN ('First Class', 'Standard Class');

-- e) WHERE Clause and AND Operator 

SELECT * FROM orders 
WHERE Order_Date BETWEEN '2019-10-10' AND '2020-10-10' AND Quantity BETWEEN 1 AND 2
ORDER BY Quantity DESC;

SELECT * FROM orders 
WHERE Ship_Mode = 'First Class' AND Segment = 'Corporate';

SELECT DISTINCT Ship_Mode, Segment FROM orders 
WHERE Ship_Mode = 'First Class' AND Segment = 'Corporate';

-- f) WHERE Clause and OR Operator 

SELECT * FROM orders 
WHERE Ship_Mode = 'First Class' OR Segment = 'Corporate';

SELECT DISTINCT Ship_Mode FROM orders 
WHERE Ship_Mode = 'First Class' OR Segment = 'Corporate';

SELECT DISTINCT Segment FROM orders 
WHERE Ship_Mode = 'First Class' OR Segment = 'Corporate';


-- String Comparision/Matching using LIKE Operator


-- % -> Any char, Any number of time 
-- Customer's name starting with C 

SELECT Order_ID, Order_Date, Customer_Name FROM orders 
WHERE Customer_Name LIKE 'C%';

-- Customer's name starting with Claire 

SELECT Order_ID, Order_Date, Customer_Name FROM orders 
WHERE Customer_Name LIKE 'Claire%';

-- Customer's name ends with te 

SELECT Order_ID, Order_Date, Customer_Name FROM orders 
WHERE Customer_Name LIKE '%te';

-- Customer's name contains 'ven' 

SELECT Order_ID, Order_Date, Customer_Name FROM orders 
WHERE Customer_Name LIKE '%ven%';

-- Run a case insensitive search 

SELECT Order_ID, Order_Date, Customer_Name, UPPER(Customer_Name) FROM orders 
WHERE UPPER(Customer_Name) LIKE 'A%A';


-- _ -> Only one character 

SELECT Order_ID, Order_Date, Customer_Name FROM orders 
WHERE Customer_Name LIKE '_l%';
 
-- Lets do this following case 
/* 
Starts with A 
Have something in the second place 
Third character has to be a 
Anything after that 
*/

SELECT Order_ID, Order_Date, Customer_Name FROM orders 
WHERE Customer_Name LIKE 'A_a%';

-- Starts with l (% -> Any charactor or No charactor) 

SELECT Order_ID, Order_Date, Customer_Name FROM orders 
WHERE Customer_Name LIKE '%l'
ORDER BY Customer_Name;


