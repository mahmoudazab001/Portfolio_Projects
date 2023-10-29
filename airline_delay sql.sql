
select
		*
from
		[US Airline Delays]..airline_delay



--In this analysis I will compare between airports status in december (12) in year 2019 and 2020

--Data cleanning
-- carriers

select
		year,
		carrier_name		
from
		[US Airline Delays]..airline_delay
group by
		year,carrier_name
order by
		2
--# the records of ExpressJet Airlines LLC for year 2020 is missing so i will exclude it from the analysis

delete from [US Airline Delays]..airline_delay
where carrier_name = 'ExpressJet Airlines LLC'

--# So, we now have 16 different Carrier records for both 2019 and 2020 years

--2 airports 
-- no. of airports
select
		year,
		airport_name
from
		[US Airline Delays]..airline_delay
group by
		airport_name,year
--# in this analysis we have 360 different airports but i've notice that there are airports that have missing data so i will exclude it from the analysis
delete from [US Airline Delays]..airline_delay
where  airport_name  in('Aguadilla, PR: Rafael Hernandez' , 'Alamosa, CO: San Luis Valley Regional/Bergman Field', 'Cold Bay, AK: Cold Bay Airport' ,'Decatur, IL: Decatur Airport' ,'Del Rio, TX: Del Rio International',
						'Dickinson, ND: Dickinson - Theodore Roosevelt Regional' , 'Dodge City, KS: Dodge City Regional', 'Dubuque, IA: Dubuque Regional' , 'Greenville, NC: Pitt Greenville', 'Johnstown, PA: John Murtha Johnstown-Cambria County',
						'Mammoth Lakes, CA: Mammoth Lakes Airport', 'Mobile, AL: Mobile Downtown', 'Nantucket, MA: Nantucket Memorial', 'New Haven, CT: Tweed New Haven', 'Pago Pago, TT: Pago Pago International',
						'Ponce, PR: Mercedita', 'Quincy, IL: Quincy Regional-Baldwin Field', 'Riverton/Lander, WY: Riverton Regional', 'Sheridan, WY: Sheridan County', 'Victoria, TX: Victoria Regional', 'Worcester, MA: Worcester Regional')
--# So, we now have 339 different airports records for both 2019 and 2020 years


-- Data analysis
-- carriers with the highest flight
select
		year,
		carrier_name,
		sum(arr_flights) as total_Flights,
		count(*) * 100.0 / sum(count(*)) over() as Percent_of_total
		
from
		[US Airline Delays]..airline_delay
group by
		year,carrier_name
order by 
		4 desc
--# we can clearly see that SkyWest Airlines Inc. is carrier with the most flights in both 2019 and 2020 with represent 14.32% of total flights

-- total flights per airports
select
		year,
		airport_name,
		sum(arr_flights) as total_Flights,
		count(*) * 100.0 / sum(count(*)) over() as Percent_of_total
from
		[US Airline Delays]..airline_delay
group by
		airport_name,year
order by
		3 desc
--# Atlanta, GA: Hartsfield-Jackson Atlanta International have the highest no. of flights in both 2019 and 2020

--total flights status
select
		year,
		total_Flights,
		total_ontime_flights,
		round((total_ontime_flights*100)/total_Flights,2) as ontime_flight_percentage,
		total_late_flights,
		round((total_late_flights*100)/total_Flights,2) as late_flight_percentage,
		total_cancelled_flights,
		round((total_cancelled_flights*100)/total_Flights,2) as cancelled_flight_percentage,
		total_diverted_flights,
		round((total_diverted_flights*100)/total_Flights,2) as diverted_flight_percentage
from
(
select
		YEAR,
		sum(arr_flights) as total_Flights,
		sum(arr_flights)-(sum(arr_del15)+sum(carrier_ct)+sum(weather_ct)+sum(nas_ct)+sum(security_ct)+sum(late_aircraft_ct)) as total_ontime_flights,
		sum(arr_del15)+sum(carrier_ct)+sum(weather_ct)+sum(nas_ct)+sum(security_ct)+sum(late_aircraft_ct) as total_late_flights,
		sum(arr_cancelled) as total_cancelled_flights,
		sum(arr_diverted) as total_diverted_flights
from
		[US Airline Delays]..airline_delay
group by
		year
) as flight
--# there's a big drop in total flights around (39.67%) in 2020 compared to 2019 which i think mainly due to covid-19. SO, we can't directly compare between the numbers that why i will use percentage as an overview of the status
--# also there is a big difference in total flight for each year but there's a noticable improvment in flight arrive ontime in 2020 compared to 2019
--# canclled flight still considered a problem in both year but become slightly worest in 2020 

--total delayed flight for each proplem
select
		year,
		total_late_flights,
		"15min_late_flights",
		round(("15min_late_flights"*100)/total_late_flights,2) as "15min_late_percentage",
		late_due_to_carrier,
		round((late_due_to_carrier*100)/total_late_flights,2) as carrier_late_persentage,
		late_due_to_weather,
		round((late_due_to_weather*100)/total_late_flights,2) as weather_late_persentage,
		late_due_to_nas,
		round((late_due_to_nas*100)/total_late_flights,2) as nas_late_persentage,
		late_due_to_security,
		round((late_due_to_security*100)/total_late_flights,2) as security_late_persentage,
		late_due_to_aircraft,
		round((late_due_to_aircraft*100)/total_late_flights,2) as aircraft_late_persentage
from
(
select
		year,
		sum(arr_del15)+sum(carrier_ct)+sum(weather_ct)+sum(nas_ct)+sum(security_ct)+sum(late_aircraft_ct) as total_late_flights,
		sum(arr_del15) as "15min_late_flights",
		sum(carrier_ct) as late_due_to_carrier,
		sum(weather_ct) as late_due_to_weather,
		sum(nas_ct) as late_due_to_nas,
		sum(security_ct) as late_due_to_security,
		sum(late_aircraft_ct) as late_due_to_aircraft
from
		[US Airline Delays]..airline_delay
group by
		year
) as problems
--# 15min late is a major problem that present in both year which represents around (50%) of total delayed flights
--# there's no actual improvment between both years except in the delayed flights rlated to aircraft which seen a slight improvement in 2020 compared to 2019

-- carrier with the most flight delayed
select
		year,
		carrier_name,
		sum(arr_del15)+sum(carrier_ct)+sum(weather_ct)+sum(nas_ct)+sum(security_ct)+sum(late_aircraft_ct) as total_late_flights
from
		[US Airline Delays]..airline_delay
group by
		year,carrier_name
order by
		1,3 desc
--# Southwest Airlines Co. has the most delayed flight in 2019.
--# SkyWest Airlines Inc. has the most delayed flight in 2020.

-- airport with the most flight delayed
select
		year,
		airport_name,
		sum(arr_del15)+sum(carrier_ct)+sum(weather_ct)+sum(nas_ct)+sum(security_ct)+sum(late_aircraft_ct) as total_late_flights
from
		[US Airline Delays]..airline_delay
group by
		year,airport_name
order by
		1,3 desc
--# Chicago, IL: Chicago O'Hare International has the most delayed flight in 2019.
--# Dallas/Fort Worth, TX: Dallas/Fort Worth International has the most delayed flight in 2020.


-- wasted time from flight delays

select
		year,
		avg_min_wasted,
		avg_min_wasted_due_to_carrier,
		round((avg_min_wasted_due_to_carrier*100)/avg_min_wasted,2) as carrier_late_persentage,
		avg_min_wasted_due_to_weather,
		round((avg_min_wasted_due_to_weather*100)/avg_min_wasted,2) as weather_late_persentage,
		avg_min_wasted_due_to_nas,
		round((avg_min_wasted_due_to_nas*100)/avg_min_wasted,2) as nas_late_persentage,
		avg_min_wasted_due_to_security,
		round((avg_min_wasted_due_to_security*100)/avg_min_wasted,2) as security_late_persentage,
		avg_min_wasted_due_to_aircraft,
		round((avg_min_wasted_due_to_aircraft*100)/avg_min_wasted,2) as aircraft_late_persentage
from
(
select
		year,
		round(avg(arr_delay),2) as avg_min_wasted,
		round(avg(carrier_delay),2) as avg_min_wasted_due_to_carrier,
		round(avg(weather_delay),2) as avg_min_wasted_due_to_weather,
		round(avg(nas_delay),2) as avg_min_wasted_due_to_nas,
		round(avg(security_delay),2) as avg_min_wasted_due_to_security,
		round(avg(late_aircraft_delay),2) as avg_min_wasted_due_to_aircraft
from
		[US Airline Delays]..airline_delay
group by
		year
) as wasted
--# in 2019 hr wasted due to aircraft was the biggest causing problem to flight delays (41.99%) followed by carrier problems (31.25%)
--# in 2020 time wasted due to aircraft was improving by a good gap(24.36%) from 2019 (41.99%) but carrier problems became worse (44.58%) and was the leading problem responsible to wasted time 

-- carrier with the most time wasted from delayed flights
select
		year,
		carrier_name,
		round(avg(carrier_delay),2) as avg_min_wasted_due_to_carrier
from
		[US Airline Delays]..airline_delay
group by
		year,carrier_name
order by
		1,3 desc
--# SkyWest Airlines Inc. has the most time wasted from delayed flight in 2019.
--# SkyWest Airlines Inc. has the most time wasted from delayed flight in 2020.
--# SkyWest Airlines Inc. is bad!!! 

-- airport with the most time wasted from delayed flights
select  
		year,
		airport_name,
		round(avg(arr_delay),2) as avg_min_wasted
from
		[US Airline Delays]..airline_delay
group by
		year,airport_name
order by
		1,3 desc
--# San Francisco, CA: San Francisco International has the most time wasted from delayed flight in 2019.
--# Dallas/Fort Worth, TX: Dallas/Fort Worth International has the most time wasted from delayed flight in 2020.



-- I will create view of the updated table to import it into Tableau to use it 
create view updated_airline_delay as 
select
		*
from
		[US Airline Delays]..airline_delay

