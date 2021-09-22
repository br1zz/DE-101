--generate calendar
insert into dw.calendar 
select
to_char(date, 'yyyymmdd')::int as date_id,
		extract('year' from date)::int as year,
		extract('quarter' from date)::int as quarter,
		extract('month' from date)::int as month,
		extract('week' from date)::int as week,
		date::date,
		to_char(date, 'dy') as week_day,
		extract('day' from
				(date + interval '2 month - 1 day')
				) = 29
		as leap
from generate_series(date '2000-01-01',
					date '2030-01-01',
					interval ' 1 day')
	as t(date);



--insert uniq values + generate id for shipments
insert into dw.shipments 
select row_number() over(), ship_mode from (select distinct ship_mode from stg.orders) a;

--insert uniq values + generate id from address
insert into dw.addresses 
select row_number() over(), 
	country, 
	city, 
	state, 
	postal_code, 
	region 
from (select distinct country, city, state, postal_code, region from stg.orders) a;

--insert uniq values + generate id from customers
insert into dw.customers 
select row_number() over(), 
	customer_name, 
	customer_id,
	segment
from (select distinct customer_name, customer_id, segment from stg.orders) a;

--insert uniq values + generate id from products
insert into dw.products
select row_number() over(), 
	product_name,
	category,
	sub_category,
	product_id_ext
from (select distinct product_name, 
		category, 
		subcategory as sub_category,
		product_id as product_id_ext 
	from stg.orders) a;

--insert da + generate id from sales
insert into dw.sales 
select	row_number() over(),
		reterned,
		sales,
		quantity,
		discount,
		profit,
		o.order_id,
		to_char(order_date, 'yyyymmdd')::int as order_date_id,
		to_char(order_date, 'yyyymmdd')::int as ship_date_id,
		mc.customer_id,
		ms.shipment_id,
		ad.address_id,
		p.product_id
from stg.orders as o
inner join dw.customers as mc
on o.customer_id = mc.code
inner join dw.shipments as ms 
on o.ship_mode = ms.shipment_mode
inner join dw.products as p 											--2 conditions because the product id has a duplicates
on o.product_id = p.product_id_ext and o.product_name = p.product_name 	
left join dw.addresses as ad 										--2 conditions as the postal code can be null 
on o.postal_code = ad.postal_code AND o.city = ad.city 
left join (select distinct * from stg.returns) as ort 				--there are duplicates in the order_reterns table
on ort.order_id = o.order_id

