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
 









