/* 

Note: please do not use any functions which are not taught in the class. you need to solve the questions only with the concepts that have been discussed so far.
Run below table script to create icc_world_cup table:

create table icc_world_cup
(
Team_1 Varchar(20),
Team_2 Varchar(20),
Winner Varchar(20)
);
INSERT INTO icc_world_cup values('India','SL','India');
INSERT INTO icc_world_cup values('SL','Aus','Aus');
INSERT INTO icc_world_cup values('SA','Eng','Eng');
INSERT INTO icc_world_cup values('Eng','NZ','NZ');
INSERT INTO icc_world_cup values('Aus','India','India');

*/ 

create table icc_world_cup
(
Team_1 Varchar(20),
Team_2 Varchar(20),
Winner Varchar(20)
);
INSERT INTO icc_world_cup values('India','SL','India');
INSERT INTO icc_world_cup values('SL','Aus','Aus');
INSERT INTO icc_world_cup values('SA','Eng','Eng');
INSERT INTO icc_world_cup values('Eng','NZ','NZ');
INSERT INTO icc_world_cup values('Aus','India','India');

SELECT * FROM icc_world_cup

-- 1- write a query to produce below output from icc_world_cup table.
-- team_name, no_of_matches_played , no_of_wins , no_of_losses


with all_teams as 
(select team_1 as team, case when team_1=winner then 1 else 0 end as win_flag from icc_world_cup
union all
select team_2 as team, case when team_2=winner then 1 else 0 end as win_flag from icc_world_cup)
select team,count(1) as total_matches_played , sum(win_flag) as matches_won,count(1)-sum(win_flag) as matches_lost
from all_teams
group by team

-- 2 -- write a query to print first name and last name of a customer using orders table(everything after first space can be considered as last name) customer_name, first_name,last_name

SELECT * FROM orders

SELECT Customer_name, LEFT(customer_name, CHARINDEX(' ', customer_name)) as first_name, RIGHT(customer_name, LEN(customer_name)-CHARINDEX(' ', customer_name)) as last_name
FROM Orders

select customer_name , trim(SUBSTRING(customer_name,1,CHARINDEX(' ',customer_name))) as first_name
, SUBSTRING(customer_name,CHARINDEX(' ',customer_name)+1,len(customer_name)-CHARINDEX(' ',customer_name)+1) as second_name
from orders

-- 3 
/*
write a query to print below output using drivers table. Profit rides are the no of rides where end location of a ride is same as start location of immediate next ride for a driver
id, total_rides , profit_rides
dri_1,5,1
dri_2,2,0

*/

create table drivers(id varchar(10), start_time time, end_time time, start_loc varchar(10), end_loc varchar(10));
insert into drivers values('dri_1', '09:00', '09:30', 'a','b'),('dri_1', '09:30', '10:30', 'b','c'),('dri_1','11:00','11:30', 'd','e');
insert into drivers values('dri_1', '12:00', '12:30', 'f','g'),('dri_1', '13:30', '14:30', 'c','h');
insert into drivers values('dri_2', '12:15', '12:30', 'f','g'),('dri_2', '13:30', '14:30', 'c','h');

SELECT * FROM drivers

-- With Lead Function window
select id, count(1) as total_rides ,sum(case when end_loc=next_start_location then 1 else 0 end ) as profit_rides
from (
select *
, lead(start_loc,1) over(partition by id order by start_time asc) as next_start_location
from drivers) A
group by id;

--self join
with rides as (
select *,row_number() over(partition by id order by start_time asc) as rn
from drivers)
select r1.id , count(1) total_rides, count(r2.id) as profit_rides
from rides r1
left join rides r2
on r1.id=r2.id and r1.end_loc=r2.start_loc and r1.rn+1=r2.rn
group by r1.id