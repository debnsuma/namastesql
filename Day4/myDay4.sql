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


