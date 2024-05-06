

-- This Analysis is about pizza store that we ennd to understand customre trends and patterns to improve the operations and increase sales
-- I will divide this analysis into two major parts:
-- Part 1 : will focus on sales patterns (Rush Hours, days and seasons).
-- Part 2 : will focus on Pizza Patterns (best pizza, Category and improve stocking).

-- Part 1 : Sales Analysis
-- 1 Total orders
select
		count(distinct(order_id)) as total_orders,
		sum(quantity) as total_pizza_quantity
from
		[Pizza Store]..order_details

-- 2 Biggest order
select 
		distinct(order_id) ,
		sum(quantity) as total_pizza_quantity,
		sum(price) as total_cost
from
		[Pizza Store]..order_details as a
		join
		[Pizza Store]..pizzas as b
		on a.pizza_id = b.pizza_id
group by
		order_id
order by
		2 desc

-- 3 Month sales
select
		Month,
		count(a.order_id) as total_orders,
		sum(quantity) as total_pizza_quantity
from
		(select
				order_id,
				case 
		when Month(date) = 1 then 'January' 
		when Month(date) = 2 then 'February' 
		when Month(date) = 3 then 'March' 
		when Month(date) = 4 then 'April' 
		when Month(date) = 5 then 'May' 
		when Month(date) = 6 then 'June' 
		when Month(date) = 7 then 'July' 
		when Month(date) = 8 then 'August' 
		when Month(date) = 9 then 'September' 
		when Month(date) = 10 then 'October' 
		when Month(date) = 11 then 'November' 
		when Month(date) = 12 then 'December' 
		else null
		end as Month
		from
				[Pizza Store]..orders
		) as a
		join 
		[Pizza Store]..order_details as b
		on a.order_id = b.order_id
group by
		Month
order by
		2 desc

-- 4 quarter sales
select
		quarters,
		count(a.order_id) as total_orders,
		sum(quantity) as total_pizza_quantity
from
		(select
				order_id,
				case 
		when Month(date) = 1 then '1st Quarter' 
		when Month(date) = 2 then '1st Quarter' 
		when Month(date) = 3 then '1st Quarter' 
		when Month(date) = 4 then '2nd Quarter' 
		when Month(date) = 5 then '2nd Quarter' 
		when Month(date) = 6 then '2nd Quarter' 
		when Month(date) = 7 then '3rd Quarter' 
		when Month(date) = 8 then '3rd Quarter' 
		when Month(date) = 9 then '3rd Quarter' 
		when Month(date) = 10 then '4th Quarter' 
		when Month(date) = 11 then '4th Quarter' 
		when Month(date) = 12 then '4th Quarter' 
		else null
		end as quarters
		from
				[Pizza Store]..orders
		) as a
		join 
		[Pizza Store]..order_details as b
		on a.order_id = b.order_id
group by
		quarters
order by
		2 desc

-- 5 Day of the month
select
		day_of_month,
		count(a.order_id) as total_orders,
		sum(quantity) as total_pizza_quantity
from
		(select
				order_id,
				DATENAME(day, date) as day_of_month
		from
				[Pizza Store]..orders
		) as a
		join 
		[Pizza Store]..order_details as b
		on a.order_id = b.order_id
group by
		day_of_month
order by
		2 desc

-- 6 Weekday sales
select
		Weekday,
		count(a.order_id) as total_orders,
		sum(quantity) as total_pizza_quantity
from
		(select
				order_id,
				DATENAME(WEEKDAY, date) as Weekday
		from
				[Pizza Store]..orders
		) as a
		join 
		[Pizza Store]..order_details as b
		on a.order_id = b.order_id
group by
		Weekday
order by
		2 desc

-- 7 Daytime
select
		case 
		when hour >= 20 then 'Night'
		when hour >= 18 then 'Evening'
		when hour >= 12 then 'Afternoon'
		else 'Morning'
		end as Day_period,
		count(a.order_id) as total_orders,
		sum(quantity) as total_pizza_quantity
from
		(select
				order_id,
				DATEPART(HOUR, time) as hour
		from
				[Pizza Store]..orders
		) as a
		join 
		[Pizza Store]..order_details as b
		on a.order_id = b.order_id
group by
		case 
		when hour >= 20 then 'Night'
		when hour >= 18 then 'Evening'
		when hour >= 12 then 'Afternoon'
		else 'Morning'
		end
order by
		2 desc

-- Part 2 : Pizza Analysis 
-- 1 Pizza Categories
select
		distinct category,
		count(category) as total_pizza
from
		[Pizza Store]..pizza_types 
group by
		category
order by
		2 desc

-- 2 the most popular pizza
select
		distinct(pizza_type_id),
		count(pizza_type_id) as total_orders,
		sum(quantity) as total_pizza_quantity,
		round(sum(price),2) as total_cost
from
		[Pizza Store]..pizzas as a
		join
		[Pizza Store]..order_details as b
		on a.pizza_id=b.pizza_id
group by
		pizza_type_id
order by
		2 desc

-- 3 the most popular pizza size
select
		distinct(size),
		count(b.order_details_id) as total_orders,
		sum(quantity) as total_pizza_quantity,
		round(sum(price),2) as total_cost
from
		[Pizza Store]..pizzas as a
		join
		[Pizza Store]..order_details as b
		on a.pizza_id=b.pizza_id
group by
		size
order by
		2 desc

-- 4 most used Ingredients
SELECT
		trim(value) as ingredients,
		COUNT(value) as number_used
from
		[Pizza Store]..pizza_types
		cross apply
		string_split(ingredients, ',')
group by
		value
order by
		2 desc





		
