/*
Note: please do not use any functions which are not taught in the class. you need to solve the questions only with the concepts that have been discussed so far.

1- write a query to get region wise count of return orders
2- write a query to get category wise sales of orders that were not returned
3- write a query to print dep name and average salary of employees in that dep .
4- write a query to print dep names where none of the emplyees have same salary.
5- write a query to print sub categories where we have all 3 kinds of returns (others,bad quality,wrong items)
6- write a query to find cities where not even a single order was returned.
7- write a query to find top 3 subcategories by sales of returned orders in east region
8- write a query to print dep name for which there is no employee
9- write a query to print employees name for dep id is not avaiable in dept table

*/

-- Q1. write a query to get region wise count of return orders

SELECT TOP 2 * FROM orders;

SELECT TOP 2 * FROM returns;

SELECT o.Region, COUNT(*) as count 
FROM orders o 
INNER JOIN returns r ON o.Order_ID = r.[Order Id]
GROUP BY o.region;

-- Q2. write a query to get category wise sales of orders that were not returned

SELECT TOP 2 * FROM returns;

SELECT o.Category, COUNT(1)  
FROM orders o
GROUP BY o.Category;


SELECT o.Category, COUNT(*)
FROM orders o
LEFT JOIN returns r ON o.Order_ID = r.[Order Id]
GROUP BY r.[Return Reason], o.Category
HAVING r.[Return Reason] IS NULL

SELECT o.Category, COUNT(*)
FROM orders o
LEFT JOIN returns r ON o.Order_ID = r.[Order Id]
GROUP BY r.[Return Reason], o.Category
HAVING r.[Return Reason] IS NOT NULL

-- Q3. write a query to print dep name and average salary of employees in that dep

SELECT * FROM employee;

SELECT * FROM dept;

SELECT d.dep_name, COUNT(*) AS num_employee, AVG(e.salary) AS avg_salary
FROM employee e 
INNER JOIN dept d ON e.dept_id = d.dep_id
GROUP BY d.dep_name

-- Q4. write a query to print dep names where none of the emplyees have same salary.

SELECT * FROM employee;

SELECT * FROM dept;

SELECT COUNT(DISTINCT e.salary) as distinct_salary, COUNT(*) as no_employee
FROM employee e 
INNER JOIN dept d ON e.dept_id = d.dep_id
GROUP BY d.dep_id
HAVING COUNT(DISTINCT e.salary) = COUNT(*)