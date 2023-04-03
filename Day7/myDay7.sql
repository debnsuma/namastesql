--string functions
select order_id,customer_name
,trim(' ankit bansal ')
,reverse(customer_name) as rev
,REPLACE(order_id,'CA','PB') as replace_ca
,REPLACE(customer_name,' ','') as replace_space
,TRANSLATE(customer_name,'AC','B@') as translate_AG
,len(customer_name) as len_name
,left(customer_name,4) as name_4
,right(customer_name,5) as name_5
--,SUBSTRING(order_id,4,4) as order_year
,left(customer_name,CHARINDEX(' ',customer_name)) as first_name
,CHARINDEX(' ',customer_name) as space_position
,CHARINDEX('n',customer_name) as first_position
,concat(order_id,'-',customer_name)
,order_id+'-'+customer_name 
from orders;



--null handling function
select order_id,city,isnull(city,'unknown') as new_city,
isnull(sales,1) as new_sales,
state,coalesce(city,state,region,'unknown') as neww_city
from orders
where city is null
order by city;

select top 5 order_id,sales,cast(sales as int) as sales_int
,round(sales,1) as sales_int from orders;
--set queries 
--union all, union
create table orders_west
(
order_id int,
region varchar(10),
sales int
);


create table orders_east
(
order_id int,
region varchar(10),
sales int
);

insert into orders_west values(1,'west',100),(2,'west',200);
insert into orders_east values(3,'east',100),(4,'east',300);
insert into orders_west values(3,'east',100)
insert into orders_west values(1,'west',100)
insert into orders_west values(3,'east',100)

update orders_west
set region = 'west'
where region != 'west'


select * from orders_east
select * from orders_west

-- Union all 
select * from orders_west
union all
select * from orders_east;

-- Union (It will remove deplicates)
select * from orders_west
union 
select * from orders_east;

select * from orders_east;
select * from orders_west;

-- INTERSECT removes duplicates and shows the common 
select * from orders_east
intersect  
select * from orders_east


select sales,order_id as sale from orders_east
union all
select order_id,sales from orders_west;

-- Except (in some DB its minus) - Used in TESTING 

select * from orders_east
select * from orders_west

select * from orders_east
except 
select * from orders_west

-- Uncommon from both the tables 

(select * from orders_east
except 
select * from orders_west)
union all
(select * from orders_west
except 
select * from orders_east);


select * from orders_east
union  
select * from orders_east

