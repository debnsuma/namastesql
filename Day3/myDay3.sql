
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

-- escape character 

SELECT Order_ID, Order_Date, Customer_Name FROM orders 
WHERE Customer_Name LIKE '%l' ESCAPE '%'
ORDER BY Customer_Name;

-- Name should start with C and then it should have enther a or l --> use [] 

SELECT Order_ID, Order_Date, Customer_Name FROM orders 
WHERE Customer_Name LIKE 'C[al]%' 
ORDER BY Customer_Name;

-- Name should start with C and then it should NOT have enther a or l --> use [] and ^

SELECT Order_ID, Order_Date, Customer_Name FROM orders 
WHERE Customer_Name LIKE 'C[^al]%' 
ORDER BY Customer_Name;

-- Name should start with C and then it should  have anything between a to 0 --> use [] and -
-- This Range works with INT and STRING 

SELECT Order_ID, Order_Date, Customer_Name FROM orders 
WHERE Customer_Name LIKE 'C[a-o]%' 
ORDER BY Customer_Name;

---------------------------
---> Assignment Day 3 <----
---------------------------
/*

1- write a sql to get all the orders where customers name has "a" as second character and "d" as fourth character (58 rows)
2- write a sql to get all the orders placed in the month of dec 2020 (352 rows) 
3- write a query to get all the orders where ship_mode is neither in 'Standard Class' nor in 'First Class' and ship_date is after nov 2020 (944 rows)
4- write a query to get all the orders where customer name neither start with "A" and nor ends with "n" (9815 rows)
5- write a query to get all the orders where profit is negative (1871 rows)
6- write a query to get all the orders where either quantity is less than 3 or profit is 0 (3348)
7- your manager handles the sales for South region and he wants you to create a report of all the orders in his region where some discount is provided to the customers (815 rows)
8- write a query to find top 5 orders with highest sales in furniture category 
9- write a query to find all the records in technology and furniture category for the orders placed in the year 2020 only (1021 rows)
10-write a query to find all the orders where order date is in year 2020 but ship date is in 2021 (33 rows)

*/

-- Q1. write a sql to get all the orders where customers name has "a" as second character and "d" as fourth character (58 rows)

SELECT * FROM orders;

SELECT * FROM orders
WHERE Customer_Name LIKE '_a_d%';

-- Q2. write a sql to get all the orders placed in the month of dec 2020 (352 rows) 

SELECT *, CAST(Order_Date AS date) AS date FROM orders;

SELECT * FROM orders
WHERE CAST(Order_Date AS date) LIKE '2020-12-%';

SELECT * FROM orders 
WHERE Order_Date >= '2020-12-01' AND Order_Date <= '2020-12-31'
ORDER BY Order_Date;

-- Q3. write a query to get all the orders where ship_mode is neither in 'Standard Class' nor in 'First Class' and ship_date is after nov 2020 (944 rows)

SELECT * FROM Orders
WHERE Ship_Mode NOT IN ('Standard Class', 'First Class')
 AND Ship_Date > '2020-11-30'
ORDER BY Ship_Date;

SELECT * FROM Orders
WHERE Ship_Mode NOT IN ('Standard Class', 'First Class')
 AND Ship_Date >= '2020-12-01'
ORDER BY Ship_Date;

-- Q4. write a query to get all the orders where customer name neither start with "A" and nor ends with "n" (9815 rows)

SELECT Order_ID, Order_Date, Customer_Name FROM orders 
WHERE Customer_Name NOT LIKE 'A%n';

-- Q5. write a query to get all the orders where profit is negative (1871 rows)

SELECT * FROM Orders
WHERE Profit < 0;

-- Q6. write a query to get all the orders where either quantity is less than 3 or profit is 0 (3348)

SELECT * FROM Orders
WHERE Profit = 0 OR Quantity < 3;

-- Q7. your manager handles the sales for South region and he wants you to create a report of all the orders in his region where some discount is provided to the customers (815 rows)

SELECT * FROM Orders 
WHERE Region = 'South' AND Discount > 0; 

-- Q8. write a query to find top 5 orders with highest sales in furniture category 

SELECT TOP 5 * FROM Orders
WHERE Category = 'Furniture'
Order By Sales DESC;

-- Q9. write a query to find all the records in technology and furniture category for the orders placed in the year 2020 only (1021 rows)

SELECT * FROM Orders
WHERE Category IN ('Technology', 'Furniture') 
	AND Order_Date >= '2020-01-01' 
	AND Order_Date <= '2020-12-31' ;

-- Q10. write a query to find all the orders where order date is in year 2020 but ship date is in 2021 (33 rows)

SELECT * FROM Orders
WHERE Order_Date >= '2020-01-01' 
	AND Order_Date <= '2020-12-31' 
	AND Ship_Date >= '2021-01-01' 
	AND Ship_Date <= '2021-12-31' ;