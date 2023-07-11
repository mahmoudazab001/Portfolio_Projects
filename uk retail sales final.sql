--## data cleanning
-- removing null column
alter table 
		 [uk sales]..ValNSATD
drop column 
		 [F51]
-- removing extra raws with null values
delete from 
		 [uk sales]..ValNSATD
where
		 [Time Period] is null
-- changing time period column data type from DateTime to Date
alter table 
		 [uk sales]..ValNSATD
alter column 
		 [Time Period] date


--## data analysis
-- first we will take a closer look into Textiles, Clothing, Footwear & Leather
select
         [Time Period]
        ,[All Retailing including automotive fuel - All Retailing]
        ,[All Retailing including automotive fuel - Large Businesses]
        ,[All Retailing including automotive fuel - Small Businesses]
	    ,[Textiles, Clothing, Footwear & Leather - All Businesses]
        ,[Textiles, Clothing, Footwear & Leather - Large Businesses]
        ,[Textiles, Clothing, Footwear & Leather - Small Businesses]
        ,[Retail Sale of Textiles]
        ,[Retail Sale of Clothing - All Businesses]
        ,[Retail Sale of Clothing - Large Businesses]
        ,[Retail Sale of Clothing - Small Businesses]
        ,[Footwear & Leather Goods]
from
		 [uk sales]..ValNSATD

-- I will creat a table to focus on the important imformations
create table Textiles_Clothing_Footwear_Leather 
(
         [Time Period] date
        ,[All Retailing including automotive fuel - All Retailing] float
        ,[All Retailing including automotive fuel - Large Businesses] float
        ,[All Retailing including automotive fuel - Small Businesses] float
	    ,[Textiles, Clothing, Footwear & Leather - All Businesses] float
        ,[Textiles, Clothing, Footwear & Leather - Large Businesses] float
        ,[Textiles, Clothing, Footwear & Leather - Small Businesses] float
        ,[Retail Sale of Textiles] float
        ,[Retail Sale of Clothing - All Businesses] float
        ,[Retail Sale of Clothing - Large Businesses] float
        ,[Retail Sale of Clothing - Small Businesses] float
        ,[Footwear & Leather Goods] float
)

insert into Textiles_Clothing_Footwear_Leather
select
         [Time Period]
        ,[All Retailing including automotive fuel - All Retailing]
        ,[All Retailing including automotive fuel - Large Businesses]
        ,[All Retailing including automotive fuel - Small Businesses]
	    ,[Textiles, Clothing, Footwear & Leather - All Businesses]
        ,[Textiles, Clothing, Footwear & Leather - Large Businesses]
        ,[Textiles, Clothing, Footwear & Leather - Small Businesses]
        ,[Retail Sale of Textiles]
        ,[Retail Sale of Clothing - All Businesses]
        ,[Retail Sale of Clothing - Large Businesses]
        ,[Retail Sale of Clothing - Small Businesses]
        ,[Footwear & Leather Goods]
from
		 [uk sales]..ValNSATD

-- now we will start our analysis 
--1 Textiles_Clothing_Footwear_Leather vs all retailling sales
--i've noticed that there is no total sales untill year 1996 so our calculation will be from 1/1/1996 to 1/4/2023
select
		 total_retail_sales,
		 total_Textiles_Clothing_Footwear_Leather,
		 (total_Textiles_Clothing_Footwear_Leather/total_retail_sales)*100 as retail_clothing_percentage
from
(
    select
		 SUM([All Retailing including automotive fuel - All Retailing]) as total_retail_sales,
		 SUM([Textiles, Clothing, Footwear & Leather - All Businesses])as total_Textiles_Clothing_Footwear_Leather	 
    from
		 [uk sales]..Textiles_Clothing_Footwear_Leather
    where 
		 [All Retailing including automotive fuel - All Retailing] <> 0
) as total
--# we can see that Textiles_Clothing_Footwear_Leather sales are 11.73% of total retail sales.

-- to put this number (11.7%) into prospective we will calculate the percentage of all majour sales fields
select
		  total_sales,
		  total_Predominantly_Food_Stores,
		  (total_Predominantly_Food_Stores/total_sales)*100 as total_Predominantly_Food_Stores_percentage,
		  total_Non_Specialised_Predominantly_Non_food_Stores,
		  (total_Non_Specialised_Predominantly_Non_food_Stores/total_sales)*100 as total_Non_Specialised_Predominantly_Non_food_Stores_percentage,
		  total_Textiles_Clothing_Footwear_Leather,
		  (total_Textiles_Clothing_Footwear_Leather/total_sales)*100 as total_Textiles_Clothing_Footwear_Leather_percentage,
		  total_Household_Goods_Stores,
		  (total_Household_Goods_Stores/total_sales)*100 as total_Household_Goods_Stores_percentage,
		  total_Other_Non_food_Stores,
		  (total_Other_Non_food_Stores/total_sales)*100 as total_Other_Non_food_Stores_percentage,
		  total_Non_store_Retailing,
		  (total_Non_store_Retailing/total_sales)*100 as total_Non_store_Retailing_percentage,
		  total_Automotive_fuel,
		  (total_Automotive_fuel/total_sales)*100 as total_Automotive_fuel_percentage
from
(
     select
		   sum([All Retailing including automotive fuel - All Retailing]) as total_sales
		  ,sum([Predominantly Food Stores Total - All Businesses]) as total_Predominantly_Food_Stores
		  ,sum([Non-Specialised Predominantly Non-food Stores - All Businesses]) as total_Non_Specialised_Predominantly_Non_food_Stores
		  ,sum([Textiles, Clothing, Footwear & Leather - All Businesses]) as total_Textiles_Clothing_Footwear_Leather
		  ,sum([Household Goods Stores - All Businesses]) as total_Household_Goods_Stores
		  ,sum([Other Non-food Stores - All Businesses]) as total_Other_Non_food_Stores
		  ,sum([Non-store Retailing - All Retailing]) as total_Non_store_Retailing
		  ,sum([Automotive fuel]) as total_Automotive_fuel
    from
		 [uk sales]..ValNSATD
    where 
		 [All Retailing including automotive fuel - All Retailing] <> 0
) as total

--# from this long put important query we can see that main focus point( Textiles_Clothing_Footwear_Leather sales ) which resemble 11.73% is the third top sales
-- of all fields beaten onlt by (total_Predominantly_Food_Stores 39.59%) and (total_Other_Non_food_Stores_percentage 13.4%)


--2 breakdown of Textiles_Clothing_Footwear_Leather sales
select
         [Time Period]
		 ,[Textiles, Clothing, Footwear & Leather - All Businesses]
		 ,[Retail Sale of Textiles]
		 ,[Retail Sale of Clothing - All Businesses]
		 ,[Footwear & Leather Goods]
from
		 [uk sales]..Textiles_Clothing_Footwear_Leather
order by
		 2 desc

--#from this query we can see a clear trend in sales of Textiles_Clothing_Footwear_Leather sales with a maximum total sales in winter especially in the month of December (12) 
-- followed by summer months 


-- each of Textiles_Clothing_Footwear_Leather retails sales vs total Textiles_Clothing_Footwear_Leather sales
select
		 total_sales,
		 total_textiles_sales,
		 (total_textiles_sales/total_sales)*100 as total_textiles_sales_percentage,
		 total_clothing_sales,
		 (total_clothing_sales/total_sales)*100 as total_clothing_sales_percentage,
		 total_footwear_and_leather_sales,
		 (total_footwear_and_leather_sales/total_sales)*100 as total_footwear_and_leather_sales_percentage
from
(
	select
		  sum([Textiles, Clothing, Footwear & Leather - All Businesses]) as total_sales
		 ,sum([Retail Sale of Textiles]) as total_textiles_sales
		 ,sum([Retail Sale of Clothing - All Businesses]) as total_clothing_sales
		 ,sum([Footwear & Leather Goods]) as total_footwear_and_leather_sales 
    from
		 [uk sales]..Textiles_Clothing_Footwear_Leather
) as total

--# this query tells us that clothing sales is the highest portion of Textiles_Clothing_Footwear_Leather sales
--# from the last 2 queries we can conclude that clothes represent the vast majority of sales especially winter clothes

-- large vs small Textiles_Clothing_Footwear_Leather businessies
select
		 total_whole_sales,
		 total_large_business_whole_sales,
		 (total_large_business_whole_sales/total_whole_sales)*100 as total_large_business_whole_sales,
		 total_Small_business_whole_sales,
		 (total_Small_business_whole_sales/total_whole_sales)*100 as total_Small_business_whole_sales
from
(
	select
		  sum([Textiles, Clothing, Footwear & Leather - All Businesses]) as total_whole_sales
		 ,sum([Textiles, Clothing, Footwear & Leather - Large Businesses]) as total_large_business_whole_sales
		 ,sum([Textiles, Clothing, Footwear & Leather - Small Businesses]) as total_Small_business_whole_sales
    from
		 [uk sales]..Textiles_Clothing_Footwear_Leather
) as total


--3 Retails of clothing
-- large vs small clothing busieness
select
		 total_sales,
		 total_large_business_sales,
		 (total_large_business_sales/total_sales)*100 as total_large_business_sales,
		 total_Small_business_sales,
		 (total_Small_business_sales/total_sales)*100 as total_Small_business_sales
from
(
	select
		  sum([Retail Sale of Clothing - All Businesses]) as total_sales
		 ,sum([Retail Sale of Clothing - Large Businesses]) as total_large_business_sales
		 ,sum([Retail Sale of Clothing - Small Businesses]) as total_Small_business_sales
    from
		 [uk sales]..Textiles_Clothing_Footwear_Leather
) as total

--large vs small clothing busieness per month
select
		 [Time Period],
		 total_sales,
		 total_large_business_sales,
		 (total_large_business_sales/total_sales)*100 as total_large_business_sales,
		 total_Small_business_sales,
		 (total_Small_business_sales/total_sales)*100 as total_Small_business_sales
from
(
	select
		  [Time Period]
		 ,sum([Retail Sale of Clothing - All Businesses]) as total_sales
		 ,sum([Retail Sale of Clothing - Large Businesses]) as total_large_business_sales
		 ,sum([Retail Sale of Clothing - Small Businesses]) as total_Small_business_sales
    from
		 [uk sales]..Textiles_Clothing_Footwear_Leather
	group by 
	     [Time Period]
) as total
order by
	     2 desc




--## Conclusion
--1. about 11.73% (1,058,499,609 £‎) of total uk sales from 1/1/1986 till 1/4/2023 were spent on Textiles_Clothing_Footwear_Leather
--2. Textiles_Clothing_Footwear_Leather are the third highiest sales of uk sales.
--3. large Textiles_Clothing_Footwear_Leather businessies represents (82.03%) of total businessies
--4. the highest sales reached to its highest peak in December the drop to its lowest in February then it starts to rise again.
--5. Textiles_Clothing_Footwear_Leather sales are split into 3 catagories:
	 -- Textile sales        32,030,458 £‎     (2.53%)
	 -- Clothing sales       1,087,230,381 £‎  (86.08%)
	 -- Footwear & Leather   143,648,626 £‎    (11.37%)
--6. ssmall buienesses sales represent small portion (17.9%) of the total sales while large businesses reoresent(82.03%).