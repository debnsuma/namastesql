
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

-- FILTERS --

SELECT * FROM orders 
WHERE Ship_Mode = 'First Class';

SELECT * FROM orders 
WHERE Order_Date = '2020-08-11';

SELECT * FROM orders 
WHERE Quantity > 10;
















-- String Comparision using LIKE 

/* Case 1
Starts with A 
Have something in the second place 
Third character has to be a 
Anything after that 
*/

SELECT * FROM orders 
WHERE Customer_Name LIKE 'A_a%';

