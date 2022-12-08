-- Database JOIN 

-- Import the returns data 
USE namestesql;

SELECT * FROM Orders;

SELECT * FROM returns;

-- Inner JOIN
SELECT o.Order_ID, o.Sales, r.[Return Reason]
FROM Orders o
INNER JOIN returns r ON o.Order_ID = r.[Order Id];

-- Left JOIN
SELECT o.Order_ID, o.Sales, r.[Return Reason]
FROM Orders o
LEFT JOIN returns r ON o.Order_ID = r.[Order Id];

-- Return all orders which are not returned 
SELECT o.Order_ID, o.Sales, r.[Return Reason]
FROM Orders o
LEFT JOIN returns r ON o.Order_ID = r.[Order Id]
WHERE r.[Return Reason] IS null;

-- Loss by return items 

SELECT r.[Return Reason], SUM(o.sales)
FROM Orders o
LEFT JOIN returns r ON o.Order_ID = r.[Order Id]
GROUP BY r.[Return Reason];


SELECT r.[Return Reason], SUM(o.sales)
FROM Orders o
INNER JOIN returns r ON o.Order_ID = r.[Order Id]
GROUP BY r.[Return Reason];


-- Crete the employee/dept table 

create table employee(
    emp_id int,
    emp_name varchar(20),
    dept_id int,
    salary int,
    manager_id int,
    emp_age int
);


insert into employee values(1,'Ankit',100,10000,4,39);
insert into employee values(2,'Mohit',100,15000,5,48);
insert into employee values(3,'Vikas',100,10000,4,37);
insert into employee values(4,'Rohit',100,5000,2,16);
insert into employee values(5,'Mudit',200,12000,6,55);
insert into employee values(6,'Agam',200,12000,2,14);
insert into employee values(7,'Sanjay',200,9000,2,13);
insert into employee values(8,'Ashish',200,5000,2,12);
insert into employee values(9,'Mukesh',300,6000,6,51);
insert into employee values(10,'Rakesh',500,7000,6,50);
select * from employee;

create table dept(
    dep_id int,
    dep_name varchar(20)
);
insert into dept values(100,'Analytics');
insert into dept values(200,'IT');
insert into dept values(300,'HR');
insert into dept values(400,'Text Analytics');
select * from dept;

-- INNER JOIN 
SELECT *
FROM employee e
INNER JOIN dept d ON e.dept_id = d.dep_id;

-- LEFT JOIN 
SELECT * FROM employee;

SELECT *
FROM employee e
LEFT JOIN dept d ON e.dept_id = d.dep_id;

-- RIGHT JOIN 

SELECT * FROM dept;

SELECT *
FROM employee e
RIGHT JOIN dept d ON e.dept_id = d.dep_id;

-- FULL OUTTER JOIN 
SELECT *
FROM employee e
FULL OUTER JOIN dept d ON e.dept_id = d.dep_id;