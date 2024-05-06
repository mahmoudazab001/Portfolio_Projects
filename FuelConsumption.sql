

-- this dataset is about fuel consumption and co-emission of a sample size of 639 cars from year 2000
-- using this dataset i will try to answer these questions:
-- Q1: what's the main factor causing a high co emission?
-- Q2: reasons for high fuel consumption?
-- Q3: what's the cleanest car (lowest fuel consumption / lowest fuel consumption) by model / for each company?


-- Q1: what's the main factor causing a high co emission?
-- there're 4 reasons (in this dataset) that maybe a causing factor of high co emission so i will analyize them to know the answer;

--1 engine size
select
		 [ENGINE SIZE],
		 count([ENGINE SIZE]) as sample_size,
		 round(avg([CO-EMISSIONS ]),2) as avg_co_emission

from
		[Fuel Consumption]..[FuelConsumption ]
group by
		[ENGINE SIZE]
order by
		3 asc
--# As a general rule of thumb the lower the engine size the lower co-emission (some engine sizes don't follow this rule may be due to their nature or other factors).

--2 no. of cylinders
select
		 CYLINDERS,
		 count(CYLINDERS) as sample_size,
		 round(avg([CO-EMISSIONS ]),2) as avg_co_emission

from
		[Fuel Consumption]..[FuelConsumption ]
group by
		CYLINDERS
order by
		3 asc
--# It's clear that no. of cylinders have a direct relationship with co-emission (high no. of cylinder = high co-emission).

--3 TRANSMISSION
select
		Transmission_types,
		count(Transmission_types) as sample_size,
		round(avg([CO-EMISSIONS ]),2) as avg_co_emission
from
		(select
				case 
			when TRANSMISSION like '%M%' then 'Manual'
			else 'Automatic'
			end as Transmission_types,
		 TRANSMISSION,
		 [CO-EMISSIONS ]
		 from
			[Fuel Consumption]..[FuelConsumption ]
		) as dd
group by
		Transmission_types
order by
		3 asc

select
		 TRANSMISSION,
		 count(TRANSMISSION) as sample_size,
		 round(avg([CO-EMISSIONS ]),2) as avg_co_emission

from
		[Fuel Consumption]..[FuelConsumption ]
group by
		TRANSMISSION
order by
		3 asc
--# Manual transmission has lower co-emission than Automatic transmission.
--# (M5) transmission is the best for low co-emission.

--4 FUEL CONSUMPTION
select
		 [FUEL CONSUMPTION],
		 count([FUEL CONSUMPTION]) as sample_size,
		 round(avg([CO-EMISSIONS ]),2) as avg_co_emission

from
		[Fuel Consumption]..[FuelConsumption ]
group by
		[FUEL CONSUMPTION]
order by
		3 asc
--# fuel consumption also have direct relationship with co-emission so (low fuel consumption = low co-emission).

-- before answering the question i will compare between the main 4 factors that affect co-emission at the same time.
--# this comparisson (after we analyize each factor on its own) can give us a strong answer to our question
select
		 [ENGINE SIZE],
		 CYLINDERS,
		 [FUEL CONSUMPTION],
		 TRANSMISSION,
		 count([FUEL CONSUMPTION]) as sample_size,
		 round(avg([CO-EMISSIONS ]),2) as avg_co_emission

from
		[Fuel Consumption]..[FuelConsumption ]
group by
		[FUEL CONSUMPTION],CYLINDERS,[ENGINE SIZE],TRANSMISSION
order by
		6 asc

--## The answer to Q1 is that: Fuel consumption is the main cause of high co-emission followed by both engine size and no. of cylinders,finally Transmission type


-- Q2: reasons for high fuel consumption?
-- there're 3 reasons (in this dataset) that maybe a causing factor of high fuel consumption so i will analyize them to know the answer;

--1 engine size
select
		 [ENGINE SIZE],
		 count([ENGINE SIZE]) as sample_size,
		 round(avg([FUEL CONSUMPTION]),2) as avg_fuel_consumption

from
		[Fuel Consumption]..[FuelConsumption ]
group by
		[ENGINE SIZE]
order by
		3 asc
--# engine size don't have a direct relationship with fuel consumption (unless there's a big difference in engine sizes(1L or more)).

--2 no. of cylinders
select
		 CYLINDERS,
		 count(CYLINDERS) as sample_size,
		 round(avg([FUEL CONSUMPTION]),2) as avg_fuel_consumption

from
		[Fuel Consumption]..[FuelConsumption ]
group by
		CYLINDERS
order by
		3 asc
--# there's an obvious direct relationship between no. of cylinders and fuel consumpttion.

--3 TRANSMISSION
select
		Transmission_types,
		count(Transmission_types) as sample_size,
		round(avg([FUEL CONSUMPTION]),2) as avg_fuel_consumption
from
		(select
				case 
			when TRANSMISSION like '%M%' then 'Manual'
			else 'Automatic'
			end as Transmission_types,
		 TRANSMISSION,
		 [FUEL CONSUMPTION]
		 from
			[Fuel Consumption]..[FuelConsumption ]
		) as dd
group by
		Transmission_types
order by
		3 asc


select
		 TRANSMISSION,
		 count(TRANSMISSION) as sample_size,
		 round(avg([FUEL CONSUMPTION]),2) as avg_fuel_consumption

from
		[Fuel Consumption]..[FuelConsumption ]
group by
		TRANSMISSION
order by
		3 asc
--# Manual transmussion has lower fuel consumption than Automatic transmission.
--# (A3 and M5) are the best transmission for better fuel consumption.

--before answering the question i will compare between the main 3 factors that affect co-emission at the same time
--# this comparisson (after we analyize each factor on its own) can give us a strong answer to our question
select
		 [ENGINE SIZE],
		 CYLINDERS,
		 TRANSMISSION,
		 count([FUEL CONSUMPTION]) as sample_size,
		 round(avg([FUEL CONSUMPTION]),2) as avg_fuel_consumption

from
		[Fuel Consumption]..[FuelConsumption ]
group by
		CYLINDERS,[ENGINE SIZE],TRANSMISSION
order by
		5 asc

--## The answer to Q2 is that: engine size and no. of cylinders are the main cause of high fuel consumption followed by Transmission type.


-- Q3: what's the cleanest (lowest fuel consumption / lowest fuel consumption) and dirtiest by car model/ byclass / by company?

-- 1 by model
--the cleanest
SELECT 
		*
FROM 
		[Fuel Consumption]..[FuelConsumption ]
WHERE 
		[CO-EMISSIONS ] = (SELECT MIN([CO-EMISSIONS ]) FROM [Fuel Consumption]..[FuelConsumption ])
-- the dirtiest

SELECT 
		*
FROM 
		[Fuel Consumption]..[FuelConsumption ]
WHERE 
		[CO-EMISSIONS ] = (SELECT max([CO-EMISSIONS ]) FROM [Fuel Consumption]..[FuelConsumption ])


-- 2 by class
SELECT 
		[VEHICLE CLASS],
		round(avg([FUEL CONSUMPTION]),2) as avg_fuel_consumption,
		round(avg([CO-EMISSIONS ]),2) as avg_co_emission
FROM 
		[Fuel Consumption]..[FuelConsumption ]
group by
		[VEHICLE CLASS]
order by
		3 asc
--# STATION WAGON - SMALL class is the cleanest while VAN - PASSENGER class is the dirtiest


--3 by company
SELECT 
		MAKE,
		round(avg([FUEL CONSUMPTION]),2) as avg_fuel_consumption,
		round(avg([CO-EMISSIONS ]),2) as avg_co_emission
FROM 
		[Fuel Consumption]..[FuelConsumption ]
group by
		MAKE
order by
		3 asc
--# SATURN company is the cleanest while FERRARI company is the dirtiest
