--first fulfill this request 
update orders
set postal_code = 991122 
where postal_code is null

--insert uniq values + generate id for shipments
insert into model.shipments 
select row_number() over(), ship_mode from (select distinct ship_mode from orders) a;

--insert uniq values + generate id from address
insert into model.addresses 
select row_number() over(), 
	country, 
	city, 
	state, 
	postal_code, 
	region 
from (select distinct country, city, state, postal_code, region from orders) a;

--insert uniq values + generate id from customers
insert into model.customers 
select row_number() over(), 
	customer_name, 
	customer_id,
	segment
from (select distinct customer_name, customer_id, segment from orders) a;

--insert uniq values + generate id from calendar
insert into model.calendar 
select order_date, ship_date
from (select distinct order_date, ship_date from orders) a;

--insert uniq values + generate id from products
insert into model.products
select row_number() over(), 
	product_name,
	category,
	sub_category,
	product_id_ext
from (select distinct product_name, 
		category, 
		subcategory as sub_category,
		product_id as product_id_ext 
	from orders) a;

--insert da + generate id from sales
insert into model.sales 
select	row_number() over(),
		reterned,
		sales,
		quantity,
		discount,
		profit,
		o.order_id,
		order_date,
		ship_date,
		mc.customer_id,
		ms.shipment_id,
		ad.address_id,
		p.product_id
from orders as o
inner join model.customers as mc
on o.customer_id = mc.code
inner join model.shipments as ms 
on o.ship_mode = ms.shipment_mode
inner join model.products as p 											--2 conditions because the product id has a duplicates
on o.product_id = p.product_id_ext and o.product_name = p.product_name 	
left join model.addresses as ad 										--2 conditions as the postal code can be null 
on o.postal_code = ad.postal_code AND o.city = ad.city 
left join (select distinct * from order_returns) as ort 				--there are duplicates in the order_reterns table
on ort.order_id = o.order_id

