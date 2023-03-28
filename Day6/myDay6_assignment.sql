/*

Note: please do not use any functions which are not taught in the class. you need to solve the questions only with the concepts that have been discussed so far.

Run the following command to add and update dob column in employee table
alter table  employee add dob date;
update employee set dob = dateadd(year,-1*emp_age,getdate())

1- write a query to print emp name , their manager name and diffrence in their age (in days) 
for employees whose year of birth is before their managers year of birth
2- write a query to find subcategories who never had any return orders in the month of november (irrespective of years)
3- orders table can have multiple rows for a particular order_id when customers buys more than 1 product in an order.
write a query to find order ids where there is only 1 product bought by the customer.
4- write a query to print manager names along with the comma separated list(order by emp salary) of all employees directly reporting to him.
5- write a query to get number of business days between order_date and ship_date (exclude weekends). 
Assume that all order date and ship date are on weekdays only
6- write a query to print 3 columns : category, total_sales and (total sales of returned orders)
7- write a query to print below 3 columns
category, total_sales_2019(sales in year 2019), total_sales_2020(sales in year 2020)
8- write a query print top 5 cities in west region by average no of days between order date and ship date.
9- write a query to print emp name, manager name and senior manager name (senior manager is manager's manager)

*/

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


SELECT * FROM employee;

ALTER TABLE  employee ADD dob date;

update employee set dob = dateadd(year,-1*emp_age,getdate());

SELECT * FROM employee;

-- Q1. write a query to print emp name , their manager name and diffrence in their age (in days) 
--     for employees whose year of birth is before their managers year of birth

SELECT * FROM employee;

SELECT e1.emp_name, e2.emp_name, 
CASE 
WHEN e1.emp_age >= e2.emp_age THEN DATEDIFF(day, e1.dob, e2.dob)
ELSE DATEDIFF(day, e2.dob, e1.dob) 
END AS age_difference_in_days
FROM employee e1 
LEFT JOIN employee e2 ON e1.manager_id = e2.emp_id

select e1.emp_name,e2.emp_name as manager_name , DATEDIFF(day,e1.dob,e2.dob) as diff_in_age
from employee e1
inner join employee e2 on e1.manager_id=e2.emp_id
where DATEPART(year,e1.dob)< DATEPART(year,e2.dob)
;

-- 2- write a query to find subcategories who never had any return orders in the month of november (irrespective of years)

SELECT * FROM returns;

SELECT * FROM orders;

select sub_category
from orders o
left join returns r on o.order_id=r.[Order Id]
where DATEPART(month,order_date)=11
group by sub_category
having count(r.[Order Id])=0;


-- 3- orders table can have multiple rows for a particular order_id when customers buys more than 1 product in an order. write a query to find order ids where there is only 1 product bought by the customer.

SELECT * FROM returns;

SELECT * FROM orders; 

SELECT Orders.Order_ID, count(1) as count
FROM Orders
GROUP BY Order_ID
HAVING count(1) = 1

--4- write a query to print manager names along with the comma separated list(order by emp salary) of all employees directly reporting to him.

SELECT * FROM employee

SELECT e2.emp_name, STRING_AGG(e1.emp_name, ';') WITHIN GROUP (ORDER BY e1.salary DESC) AS team_member
FROM employee e1 
INNER JOIN employee e2 ON e1.manager_id = e2.emp_id
GROUP BY e2.emp_name
