-- first we will create table which include all of the tables which give us a full year data table
-- to make all the adjustment we want without affecting the originals tables


create table full_year_data 
(
ride_id nvarchar(255),
rideable_type nvarchar(255),
started_at datetime,
ended_at datetime,
start_station_name nvarchar(255),
start_station_id nvarchar(255),
end_station_name nvarchar(255),
end_station_id nvarchar(255),
start_lat float,
start_lng float,
end_lat float,
end_lng float,
member_casual nvarchar(255),
ride_length time,
day_of_week varchar(255)
)

-- we needed to adjust the data type for some columns so all tables were the same

insert into Cyclistic..full_year_data
select 
 *
from
 Cyclistic..[divvy-tripdata-202206]
union all
select 
*
from
 Cyclistic..[divvy-tripdata-202207]
union all
select 
*
from
 Cyclistic..[divvy-tripdata-202208]
union all
select 
*
from
 Cyclistic..[divvy-tripdata-202209]
union all
select 
*
from
 Cyclistic..[divvy-tripdata-202210]
union all
select 
*
from
 Cyclistic..[divvy-tripdata-202211]
union all
select 
*
from
 Cyclistic..[divvy-tripdata-202212]
union all
select 
*
from
 Cyclistic..[divvy-tripdata-202301]
union all
select 
*
from
 Cyclistic..[divvy-tripdata-202302]
union all
select 
*
from
 Cyclistic..[divvy-tripdata-202303]
union all
select 
*
from
 Cyclistic..[divvy-tripdata-202304]
union all
select 
*
from
 Cyclistic..[divvy-tripdata-202305]

--we added month column for easy categorization by months

alter table Cyclistic..full_year_data
add month float

update Cyclistic..full_year_data
set month = MONTH(started_at)

--we added season column for easy categorization by seasons

alter table Cyclistic..full_year_data
add season varchar(255)

update Cyclistic..full_year_data
set season =
			case
			  when month = 6 then 'summer'
			  when month = 7 then 'summer'
			  when month = 8 then 'summer'
			  when month = 9 then 'autumn'
			  when month = 10 then 'autumn'
			  when month = 11 then 'autumn'
			  when month = 12 then 'winter'
			  when month = 1 then 'winter'
			  when month = 2 then 'winter'
			  when month = 3 then 'spring'
			  when month = 4 then 'spring'
			  when month = 5 then 'spring'
			  else null
			end 

--we update day of week column to display day names instead of numbers to be easier to read



UPDATE 
	Cyclistic..full_year_data
SET  
        day_of_week = 
            CASE
                WHEN day_of_week = '1' THEN 'Sunday'
                WHEN day_of_week = '2' THEN 'Monday'
                WHEN day_of_week = '3' THEN 'Tuesday'
                WHEN day_of_week = '4' THEN 'Wednesday'
                WHEN day_of_week = '5' THEN 'Thursday'
                WHEN day_of_week = '6' THEN 'Friday'
                WHEN day_of_week = '7' THEN 'Saturday' 
            END
WHERE
        day_of_week IN ('1', '2', '3', '4', '5', '6', '7')

--here we compare between the seasons

-- total rides
select
		 season, 
		 count(ride_id) as total_rides
from
		 Cyclistic..full_year_data
group by 
		 season
order by 
		 2 desc

-- avg ride length
select
		 season,
		 cast(cast(avg(cast(CAST(ride_length as datetime) as float)) as datetime) as time(0))  as avg_ride_length
from
		 Cyclistic..full_year_data 
group by 
		 season
order by 
		 2 desc

--# from the last 2 queries we can clearly see that summer is the busiest season



--here we start to compare between casual and member users

-- avg ride length 
select
		 member_casual,
		 cast(cast(avg(cast(CAST(ride_length as datetime) as float)) as datetime) as time(0))  as avg_ride_length
from
		 Cyclistic..full_year_data
group by 
		 member_casual
order by 
		 2 desc
--# casual riders have higher avg ride length than member riders by nearly double which is huge number 
--# so we needed to check each individual month to explane this number
select
		 member_casual,
		 month,
		 season,
		 cast(cast(avg(cast(CAST(ride_length as datetime) as float)) as datetime) as time(0))  as avg_ride_length
from
		 Cyclistic..full_year_data
where
		 member_casual ='casual'
group by 
		 MONTH,member_casual,season
order by 
		 4 desc

 select
		 member_casual,
		 month,
		 season,
		 cast(cast(avg(cast(CAST(ride_length as datetime) as float)) as datetime) as time(0))  as avg_ride_length
from
		 Cyclistic..full_year_data
where
		 member_casual ='member'
group by 
		 MONTH,member_casual,season
order by 
		 4 desc

--# we can clearly see that averege ride length during summer made by (casual riders) is double the averege rides made by (member riders)
--# from this data we can make our initial hypothesis that casual & member riders may have diffierent usage of the bikes.


--total rides per month
select
 month,
 count(ride_id) as rides_per_month
from
 Cyclistic..full_year_data
 group by 
		month

 select
		 member_casual,
		 month,
		 season,
		 count(ride_id) as rides_per_month
from
		 Cyclistic..full_year_data
where 
		 member_casual='casual'
group by 
		 member_casual,month,season
order by 
		 4 desc

 select
		 member_casual,
		 month,
		 season,
		 count(ride_id) as rides_per_month
from
		 Cyclistic..full_year_data
where 
		 member_casual='member'
group by 
		 member_casual,month,season
order by 
		 4 desc
--# we can notice that (casual rider's rides) concentrate mainly during summer with nearly double the total number of rides of any other season,
--# while (member rider's rides) have a close numbers across the year except winter seasons (the lowest number) for obvious reasons of course.
--# my conclusion is that (casual riders) maybe consist of tourists either local or foreign or people ride to enjoy the summer "summer vacations" which support my initial hypothesis.


--bike's type
select
 rideable_type,
 count(ride_id) as rides_per_rideable_type
from
 Cyclistic..full_year_data
 group by 
		rideable_type

select
		 member_casual,
		 rideable_type,
		 count(ride_id) as number_of_rides
from
		 Cyclistic..full_year_data
where 
		 member_casual = 'casual'
group by 
		 member_casual,rideable_type
order by 
		 3 desc

select
		 member_casual,
		 rideable_type,
		 count(ride_id) as number_of_rides
from
		 Cyclistic..full_year_data
where 
		 member_casual = 'member'
group by 
		 member_casual,rideable_type
order by 
		 3 desc
--# we notice 2 things: first, all docked bike rides had been made by casual members (there is no one uses docked bike amoung member riders).
--#                      secound, casual riders have way more rides by electric bike than classic bikes ( 1.29 million trips vs 0.85 million trips last year alone).
--# my conclusion is that casual riders ride for fun and practability not for excersise and don't mind the extra cost which again further support my hypothesis.


--total rides per day
select
 day_of_week,
 count(ride_id) as rides_per_day
from
 Cyclistic..full_year_data
 group by 
		day_of_week

select
		 member_casual,
		 day_of_week,
		 count(ride_id) as rides_per_day
from
		 Cyclistic..full_year_data
where 
		 member_casual = 'casual'
group by 
		 member_casual,day_of_week
order by 
		 3 desc

select
		 member_casual,
		 day_of_week,
		 count(ride_id) as rides_per_day
from
		 Cyclistic..full_year_data
where 
		 member_casual = 'member'
group by 
		 member_casual,day_of_week
order by 
		 3 desc
--# we can see that casual riders prefer the weekends (saturday,sunday) while member riders ride throughout the week.
--# my conclusion is that (casual riders) ride for fun (during the weekends) while (members riders) ride for work and everyday life.


--total ride per station
select top (50)
		 member_casual,
		 start_station_id,
		 start_lat,
		 start_lng,
		 count(start_station_id) as total_ride_per_station
from
		 Cyclistic..full_year_data
where
		 member_casual = 'casual'
group by
		 member_casual,start_station_id,start_lat,start_lng
order by
		 5 desc

select  top (50)
		 member_casual,
		 start_station_id,
		 start_lat,
		 start_lng,
		 count(start_station_id) as total_ride_per_station
from
		 Cyclistic..full_year_data
where
		 member_casual = 'member'
group by
		 member_casual,start_station_id,start_lat,start_lng
order by
		 5 desc
--# we can see that the top 10 station used by casual riders are located around park and the coast of the city,
--# while the top 10 station used by member riders are located in the city area and downtown,
--# these information are strongly support my hypothesis about (casual riders) consists of tourists or people enjoying their free time'vacations'