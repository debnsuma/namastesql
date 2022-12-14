-- Check the data 

SELECT * FROM Orders;

-- Aggregation (work with multiple rows) 

SELECT COUNT(*) AS cnt
FROM Orders;

-- SUM() 

SELECT SUM(sales) as total_sales
FROM Orders;

-- MAX(), MIN(), AVG() 

SELECT MAX(sales) as max_sales, MIN(sales) as min_sales, AVG(sales) as avg_sales
FROM Orders;

-- Get the MAX sales 

SELECT TOP 1 sales
FROM Orders
ORDER BY sales DESC;

SELECT MAX(sales) as max_sales
FROM Orders;

-- Get the max, min, avg sales for each region 

SELECT * 
FROM Orders;

SELECT Region, MAX(sales) as max_sales, MIN(sales) as min_sales, AVG(sales) as avg_sales
FROM Orders
GROUP BY Region;

SELECT Region, category, MAX(sales) as max_sales, MIN(sales) as min_sales, AVG(sales) as avg_sales
FROM Orders
GROUP BY Region, category;

-- Following will work

SELECT Region, MAX(sales) as max_sales, MIN(sales) as min_sales, AVG(sales) as avg_sales
FROM Orders
GROUP BY Region, category;

-- Following will ERROR 
-- When using GROUP BY we need to make sure all column used in SELECT statement are also present in the GROUP BY statement 

SELECT Region, category, MAX(sales) as max_sales, MIN(sales) as min_sales, AVG(sales) as avg_sales
FROM Orders
GROUP BY Region;

-- With filter 

SELECT Region, MAX(sales) as max_sales, MIN(sales) as min_sales, SUM(sales) as total_sales
FROM Orders
WHERE Profit > 50
GROUP BY Region
ORDER BY total_sales DESC;

SELECT * 
FROM Orders;

-- HAVING Clause -> Checks ROW by ROW (WHERE clause can not be used)
-- HAVING is always used with GROUP BY and AFTER GROUP BY 
-- Lets say we want to do some analysis on the aggregated value 

SELECT * FROM Orders;

SELECT Sub_Category, SUM(sales) as total_sales 
FROM Orders
GROUP BY Sub_Category
HAVING SUM(sales) > 50000
ORDER BY total_sales DESC;

/*
Order of execution 

FROM 
WHERE 
GROUP BY
HAVING 
SELECT 
ORDER BY 

*/

SELECT *
FROM Orders;

-- 

SELECT Sub_Category, SUM(sales) AS total_sales, MAX(order_date) as date
FROM Orders 
GROUP BY Sub_Category
HAVING MAX(order_date) > '2020-11-11'
ORDER BY total_sales;

-- COUNT Function 

SELECT COUNT(*)
FROM Orders;

SELECT COUNT(DISTINCT Category)
FROM Orders;

-- Here the query will go to each row and counting 1 that many no. of times, it would be count(1), count(1235), etc. 
SELECT COUNT(1)
FROM Orders;


-- Lets update few items with NULL values
UPDATE Orders
SET City = null 
WHERE Order_ID IN ('US-2019-108966', 'CA-2019-106320');

-- Count doesnt count null values (In fact none of the aggregate functions consider null value, it simply ignores, e.g. SUM, AVG, MIN, MAX, etc.) 
SELECT COUNT(*) as Total_Count, COUNT(city) as Total_City_Count
FROM Orders;

SELECT * FROM Orders;


-- Assignment Day 4 

/*

1- write a update statement to update city as null for order ids :  CA-2020-161389 , US-2021-156909
2- write a query to find orders where city is null (2 rows)

3- write a query to get total profit, first order date and latest order date for each category

4- write a query to find sub-categories where average profit is more than the half of the max profit in that sub-category

5- create the exams table with below script;
create table exams (student_id int, subject varchar(20), marks int);

insert into exams values (1,'Chemistry',91),(1,'Physics',91),(1,'Maths',92)
,(2,'Chemistry',80),(2,'Physics',90)
,(3,'Chemistry',80),(3,'Maths',80)
,(4,'Chemistry',71),(4,'Physics',54)
,(5,'Chemistry',79);

write a query to find students who have got same marks in Physics and Chemistry.

6- write a query to find total number of products in each category.

7- write a query to find top 5 sub categories in west region by total quantity sold

8- write a query to find total sales for each region and ship mode combination for orders in year 2020

*/

-- Q1. write a update statement to update city as null for order ids :  CA-2020-161389 , US-2021-156909

DROP TABLE Orders;

SELECT * 
FROM Orders;

SELECT COUNT(City) 
FROM Orders;

UPDATE Orders
SET City = NULL 
WHERE Order_ID IN ('CA-2020-161389', 'US-2021-156909') ;

SELECT COUNT(City) 
FROM Orders;

-- Q2. write a query to find orders where city is null (2 rows)

SELECT * FROM Orders 
WHERE city IS null;

-- Q3. write a query to get total profit, first order date and latest order date for each category

SELECT Category, sum(Profit) as total_profit, min(order_date) as first_order_date, max(order_date) as lastest_order_date
FROM Orders 
GROUP BY Category;

-- Q4. write a query to find sub-categories where average profit is more than the half of the max profit in that sub-category

SELECT Sub_category, AVG(profit) as average_profit, MAX(profit) as max_profit
FROM ORDERS 
GROUP BY Sub_Category;


SELECT Sub_category, AVG(profit) as average_profit, MAX(profit) as max_profit
FROM ORDERS 
GROUP BY Sub_Category
HAVING AVG(profit) > .5 * MAX(profit);

-- Q5. a) create the exams table with below script;

create table exams (student_id int, subject varchar(20), marks int);

insert into exams values (1,'Chemistry',91),(1,'Physics',91),(1,'Maths',92)
,(2,'Chemistry',80),(2,'Physics',90)
,(3,'Chemistry',80),(3,'Maths',80)
,(4,'Chemistry',71),(4,'Physics',54)
,(5,'Chemistry',79);

SELECT * FROM exams;

-- b) write a query to find students who have got same marks in Physics and Chemistry.

-- Approch 1 
SELECT student_id, COUNT(*) as total_subjects, COUNT(DISTINCT marks) as distinct_marks
FROM exams
WHERE subject IN ('Physics', 'Chemistry')
GROUP BY student_id
HAVING COUNT(DISTINCT marks) = 1 AND COUNT(*) = 2;

-- Approch 2
SELECT student_id, marks, COUNT(1) as total_rows
FROM exams
WHERE subject IN ('Physics', 'Chemistry')
GROUP BY student_id, marks 
HAVING COUNT(1) = 2 
ORDER BY student_id;

-- Q6. write a query to find total number of products in each category.

SELECT * FROM Orders;

SELECT Category, COUNT(DISTINCT PRODUCT_ID) as Product_Count
FROM Orders
GROUP BY Category 
ORDER BY Product_Count;

-- Q7. write a query to find top 5 sub categories in west region by total quantity sold

SELECT * FROM Orders;

-- Using HAVING
SELECT TOP 5 Region, Sub_category, SUM(Quantity) as total_quantity_sold
FROM Orders 
GROUP BY Region, Sub_category
HAVING Region = 'west'
ORDER BY total_quantity_sold DESC;

-- Using WHERE
SELECT TOP 5 Sub_category, SUM(Quantity) as total_quantity_sold
FROM Orders 
WHERE Region = 'west'
GROUP BY Sub_category
ORDER BY total_quantity_sold DESC;


-- Q8. write a query to find total sales for each region and ship mode combination for orders in year 2020

SELECT region, ship_mode, SUM(sales) AS total_sales
FROM Orders
--WHERE Order_Date >= '2020-01-01' AND Order_Date <= '2020-12-31'
GROUP BY region, ship_mode;

SELECT region, ship_mode, SUM(sales) AS total_sales
FROM Orders
WHERE Order_Date >= '2020-01-01' AND Order_Date <= '2020-12-31'
GROUP BY region, ship_mode;
 









