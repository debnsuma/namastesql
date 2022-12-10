-- Referencing the same table (Self join)

-- Find the employee name and their manager

SELECT * FROM employee e1;

SELECT e1.emp_id, e1.emp_name, e1.manager_id as manager_id, e2.emp_name as manager_name
FROM employee e1
LEFT JOIN employee e2 ON e1.manager_id = e2.emp_id

-- Find the employees whose salary is more than their manager 

SELECT * FROM employee e1;

SELECT e1.emp_id, e1.emp_name, e1.manager_id as manager_id, e2.emp_name as manager_name, e1.salary as emp_salary, e2.salary as managers_salary
FROM employee e1
LEFT JOIN employee e2 ON e1.manager_id = e2.emp_id
WHERE e1.salary > e2.salary 

-- Functions 

-- String functions (STRING_AGR) 

-- Lets say we need to fine all employee names for each dept 
-- e.g. dept_id, lost_of_employee 

SELECT * 
FROM employee

SELECT dept_id, STRING_AGG(emp_name, ',') AS list_of_employee
FROM employee
GROUP BY dept_id;



