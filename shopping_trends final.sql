
-- We want to discover Shopping trends, so let's begin


--Customer Breackdown

--1  total customer and total purchases
select
		[Age Group],
		COUNT([Age Group]) as "Total Customer",
		sum([Purchase Amount (USD)]) as "Total Purchase Amount (USD)"
from
		[Shopping Trends]..shopping_trends
group by
		[Age Group]
--# Middle Age Group(31 - 54) have the highest number of customer by a big margine with the highest money spent.

--2 Gender
select
		Gender,
		COUNT(Gender) as "Total Customers"
from
		[Shopping Trends]..shopping_trends
group by
		Gender
order by
		1 desc
--# Male Customers are more than double the amount than Female Customers

--3 Location
select
		Location,
		COUNT(Location) as "Total Purchases",
		Avg([Purchase Amount (USD)]) as "Total Purchase Amount (USD)"
from
		[Shopping Trends]..shopping_trends
group by
		Location
order by
		2 desc
--# Kansas and Rhode Island are the lowest states with purchases.

--4 Subscription Status
select
		[Subscription Status],
		COUNT([Subscription Status]) as "Total Customer"
from
		[Shopping Trends]..shopping_trends
group by
		[Subscription Status]
--# 73% of total customers are not subscribed!!!

--5 payment methods
select
		[Payment Method],
		COUNT([Payment Method]) as "Total Customer" 
from
		[Shopping Trends]..shopping_trends
group by
		[Payment Method]
order by
		2 desc
--
select
		max([Customer ID]) as "Total Customer",
		COUNT([Customer ID]) as "Total Customer not followed the preferred payment method",
		MAX([Customer ID])-COUNT([Customer ID]) as "Total Customer followed the preferred payment method"
from
		[Shopping Trends]..shopping_trends
where
		[Payment Method] <> [Preferred Payment Method]
--# there's a healthy spread between all payment methods, but Credit card is the most payment method used.
--# 84.1% of customers didn't used their preferred payment methods!! (Insight only)

--6 Discount Applied and Promo Code Used
select
		[Discount Applied],
		count([Discount Applied]) as "Total Customer",
		[Promo Code Used],
		count([Promo Code Used]) as "Total Customer",
		sum([Purchase Amount (USD)]) as "Total item Purchase Amount (USD)"
from
		[Shopping Trends]..shopping_trends
group by
		[Discount Applied],[Promo Code Used]
--# 57% of customers didn't used promo codes (no discount applied)

--7 shipping type
select
		[Shipping Type],
		COUNT([Shipping Type]) as "Total Usage"
from
		[Shopping Trends]..shopping_trends
group by
		[Shipping Type]
order by 
		2 desc
--# everyone loves free shipping.

--8 Frequency of Purchases
select
		[Frequency of Purchases],
		COUNT([Frequency of Purchases]) as "Total Usage"
from
		[Shopping Trends]..shopping_trends
group by
		[Frequency of Purchases]
order by 
		2 desc
--# a serious problem to solve is that 58.25 of customer's Frequency of Purchases are more than 30 days.

-- Item Breackdown

--1 item purchased and total sales
select
		[Item Purchased],
		COUNT([Item Purchased]) as "Total item purchased",
		sum([Purchase Amount (USD)]) as "Total item Purchase Amount (USD)"
from
		[Shopping Trends]..shopping_trends
group by
		[Item Purchased]
order by
		3 desc
--# light (summer) clothes are the most purchased items with the highest money generated.

--2 category
select
		Category,
		COUNT(Category) as "Total item purchased",
		sum([Purchase Amount (USD)]) as "Total item Purchase Amount (USD)"
from
		[Shopping Trends]..shopping_trends
group by
		Category
order by
		2 desc
--# clothing is the highest money generated category with the highest items sold while footwear and outerwear are the lowest in both money and items
--# as they tends to last longer with fewer options than clothing and accessories.

--3 size
select
		Size,
		COUNT(Size) as "Total Number of item"
from
		[Shopping Trends]..shopping_trends
group by
		Size
order by
		2 desc
--# M size are the most common size amoung customers followed by L size
--# So, make sure to stock these sizes well as they are demanding.

--4 color
select
		Color,
		[Item Purchased],
		COUNT(Color) as "Total Number of item"
from
		[Shopping Trends]..shopping_trends
group by
		Color,[Item Purchased]
order by
		2,3 desc

--5 season
select
		Season,
		COUNT(Season) as "Total Number of purchases"
from
		[Shopping Trends]..shopping_trends
group by
		Season
order by
		2 desc
--# there's no seasonal trends in purchases but we can say that people tends to purchase items in good weather (light clothes) more than cold weather (heavy clothes)

--6 rating
select
		--[Item Purchased],
		COUNT([Review Rating]) as "Total Number of reviews",
		avg([Review Rating]) as "Avg. Rating"
from
		[Shopping Trends]..shopping_trends
--group by
--		[Item Purchased]
--order by
--		3 desc

--# 3.74 is the avg. rating of all purchases,So we may consider different manufacturer as high quality products = more frequent customers that lead to more sales.