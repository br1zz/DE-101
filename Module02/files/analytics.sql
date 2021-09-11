/*Total Sales*/
SELECT SUM(sales) as total_sales
FROM orders

/*Total Profit*/
SELECT SUM(profit) as total_profit
FROM orders

/*Profit Ratio*/
SELECT 
SUM(profit)/SUM(sales) as total_ratio
FROM orders

/*Average discount*/
SELECT 
AVG(discount) as avg_discount
FROM orders

/*Sell per Customer*/
SELECT SUM(sales)/COUNT(distinct customer_id) as sell_per_customer
from orders

/*Profit per order*/
SELECT SUM(profit)/COUNT(distinct order_id) as sell_per_customer
from orders

/*Sales by Product Category over time*/
select 
	category, 
	sum(sales) as total_sales
from orders
group by category

/*Sales per region*/
select 
	region, 
	sum(sales) as total_sales
from orders
group by region

/*Customer ranking*/
select 
	customer_name, 
	sum(sales) as total_sales
from orders
group by customer_name
order by total_sales DESC

/*Monthly Sales by Segment*/
select 
	segment, 
	date_trunc('month', order_date) as month_year, 
	sum(sales) as total_sales
from orders
group by segment, month_year
order by month_year, total_sales desc

/*Monthly Sales by Product Category*/
select 
	category, 
	date_trunc('month', order_date) as month_year, 
	sum(sales) as total_sales
from orders
group by category, month_year
order by month_year, total_sales desc