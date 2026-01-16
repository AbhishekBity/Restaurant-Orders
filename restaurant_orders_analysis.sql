
/* Name : Abhishek Bity
   Project name : Restaurant Orders Analysis
   Tools : MySql | Power BI  
*/
CREATE DATABASE restaurant_orders;
USE  restaurant_orders;
CREATE TABLE orders (
    order_id INT,
    customer_name VARCHAR(100),
    food_item VARCHAR(50),
    category VARCHAR(20),
    quantity INT,
    price DECIMAL(10,2),
    payment_method VARCHAR(30),
    order_time DATETIME
);
select * from orders
limit 5;
-- ***************************************************************************************************
-- Checking Duplicates
SELECT order_id, COUNT(*)
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;

-- Checking Null
SELECT * FROM orders
WHERE customer_name IS NULL
   OR food_item IS NULL
   OR price IS NULL;
-- **************************************************
-- New column Total Amt
alter table orders add Total_Amount DECIMAL(10,2);
update orders
set Total_Amount = price * quantity ;
-- Time Extracting
SELECT Hour(order_time) AS order_hour,
dayname(order_time) AS order_day
FROM orders;
-- *******************
-- Q1 . Which food items are most popular?
SELECT food_item,SUM(quantity) AS total_quantity
FROM orders
GROUP BY food_item
ORDER BY total_quantity DESC; 

-- Q2 Revenue by Category
SELECT category,SUM(total_amount) AS revenue
FROM orders
GROUP BY category
ORDER BY revenue DESC;

-- Q3 Top Customers (Repeat Buyers)
select customer_name , count(*) as Top_Customer,SUM(total_amount) AS total_spent
from orders 
group by customer_name
having count(*) > 1 
order by SUM(total_amount) desc; 

-- Q4️ Preferred Payment Method
select payment_method,sum(Total_Amount) as Revenue,count(*) as Count_Of_Payment_Mode
from orders 
group by payment_method 
having count(*) > 1
order by Count_Of_Payment_Mode desc;

-- Q5 Sales Trend by Hour
select hour(order_time) as peak_hours,count(*) as order_count
from orders
group by hour(order_time)
order by count(*) desc;

-- Q6 REvenue by order
SELECT order_id, sum(Total_Amount) as Revenue
FROM orders
group by order_id
order by sum(Total_Amount) desc;


-- Q7 Food items with quantity > 10
SELECT food_item, SUM(quantity) AS total_quantity
FROM orders
GROUP BY food_item
HAVING total_quantity > 10
order by total_quantity desc;

/*
********** Key Business Insights ******************************
Main category generates highest revenue

Pizza dominate sales volume

Few customers( only 3 Jonathan Turner,Michael Smith,Christopher Rodriguez) contribute major revenue

cash payments are growing followed by  Credit Card then Online Payment then  Debit card

Peak orders occur during lunch
*/


