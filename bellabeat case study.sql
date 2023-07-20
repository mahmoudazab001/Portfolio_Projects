--# first we will check each table to know how many distinct id in them

--1
select
		COUNT(distinct id)
from
		Bellabeat..dailyActivity_merged
--2
select
		COUNT(distinct id)
from
	Bellabeat..hourlyCalories_merged
--3
select
		COUNT(distinct id)
from
		Bellabeat..hourlyIntensities_merged
--4
select
		COUNT(distinct id)
from
		Bellabeat..hourlySteps_merged
--5
select
		COUNT(distinct id)
from
		Bellabeat..minuteCaloriesWide_merged
--6
select
		COUNT(distinct id)
from
		Bellabeat..minuteIntensitiesWide_merged
--7
select
		COUNT(distinct id)
from
		Bellabeat..minuteStepsWide_merged


--# From the last 7 queries I confirmed that all tables are consistant as it all contain data of 33 users. 


--1 I will explore dailyactivity table

--1.1 I will catagorize our users into demographic categories by the averege daily amount of steps according to https://www.10000steps.org.au/articles/healthy-lifestyles/counting-steps/

--# upon further inspection of the data in excel i have noticed that the sleeping records are not accurately entered as some days the user have entered the sleeping time as SedentaryMinutes,
-- so to make all the data consistent i will combine (very active minutes ,fairly active minutes and lightly active minutes) as total active minutes and if we subtract it from 1440(24hr contain 1440 minutes)
-- it will give us total sedentary minutes (sedentary minutes + sleeping minutes)

-- avg daily (steps,calories,active minutes,sedentary minutes)
select
		Id,
		averege_daily_steps,
		averege_daily_calories,
		averege_daily_total_active_minutes,
		1440-averege_daily_total_active_minutes as averege_daily_total_sedentary_minutes,
		case
			when averege_daily_steps <5000 then 'Sedentary user'
			when averege_daily_steps >=5000 and averege_daily_steps <7499 then 'lightly active user'
			when averege_daily_steps >=7500 and averege_daily_steps <9999 then 'fairly active user'
			when averege_daily_steps >=10000 and averege_daily_steps <12499 then 'active user'
			when averege_daily_steps >12500 then 'very active user'
		    else null
		end as demograpghic_user
from
(
	select
		Id,
		cast(AVG(TotalSteps)as int) as averege_daily_steps,
		cast(AVG(Calories)as int) as averege_daily_calories,
		cast(AVG(VeryActiveMinutes+FairlyActiveMinutes+LightlyActiveMinutes)as int) as averege_daily_total_active_minutes
	from
		Bellabeat..dailyActivity_merged
	group by 
		Id
) as avd_daily_steps
order by 
		3 desc

-- number of each demographic user
select
		demograpghic_user,
		count(demograpghic_user) as total_user
from
(
	select
		Id,
		averege_daily_steps,
		averege_daily_calories,
		averege_daily_total_active_minutes,
		1440-averege_daily_total_active_minutes as averege_daily_total_sedentary_minutes,
		case
			when averege_daily_steps <5000 then 'Sedentary user'
			when averege_daily_steps >=5000 and averege_daily_steps <7499 then 'lightly active user'
			when averege_daily_steps >=7500 and averege_daily_steps <9999 then 'fairly active user'
			when averege_daily_steps >=10000 and averege_daily_steps <12499 then 'active user'
			when averege_daily_steps >12500 then 'very active user'
		    else null
		end as demograpghic_user
	from
	(
	select
		Id,
		cast(AVG(TotalSteps)as int) as averege_daily_steps,
		cast(AVG(Calories)as int) as averege_daily_calories,
		cast(AVG(VeryActiveMinutes+FairlyActiveMinutes+LightlyActiveMinutes)as int) as averege_daily_total_active_minutes
	from
		Bellabeat..dailyActivity_merged
	group by 
		Id
	) as avd_daily_steps
)as count
group by demograpghic_user

--# from this query the is no clear relations between the numbers but I will further analysis it in tableau.

--1.2 daily status per weekday

select
	
		datename(weekday,ActivityDate) as weekday,
		cast(AVG(TotalSteps)as int) as averege_daily_steps,
		cast(AVG(Calories)as int) as averege_daily_calories,
		cast(AVG(VeryActiveMinutes+FairlyActiveMinutes+LightlyActiveMinutes)as int) as averege_daily_total_active_minutes,
		cast(AVG(1440 - VeryActiveMinutes+FairlyActiveMinutes+LightlyActiveMinutes)as int) as averege_daily_total_sedentary_minutes
from
		Bellabeat..dailyActivity_merged
group by 
		datename(weekday,ActivityDate) 
order by 
		2 desc

--# we can see from this query that saturday is the highest avg_daily steps with the highest avg_daily total active minutes

--#1.3 now we will see how many days did the users wear the smart band

select
		Id,
		total_days,
		case
			when total_days <=31 and total_days >21 then 'high use'
			when total_days <=20 and total_days >11 then 'moderate use'
			when total_days <=10 and total_days >0 then 'low use'
		    else null
		end as usage
from
(
	select
		Id,
		count(Id) as total_days
	from
		Bellabeat..dailyActivity_merged
	group by 
		Id
) as daily_usage

-- then I grouped them together to better read the numbers
select
		usage,
		count(total_days)
from
(
	select
		total_days,
		case
			when total_days <=31 and total_days >21 then 'high use'
			when total_days <=20 and total_days >11 then 'moderate use'
			when total_days <=10 and total_days >0 then 'low use'
		    else null
		end as usage
	from
	(
		select
		Id,
		count(Id) as total_days
		from
		Bellabeat..dailyActivity_merged
		group by 
		Id
	) as daily_usage
) as usage_table
group by 
		usage

--# from the last 2 queries we see that 87% of total users (33) user wear the band more than 21 days.





--2 I will explore all hourly data tables

--2.1 I will join all the hourly tables for easy categorization and exploration
select
		hc.Id,
		hc.ActivityHour,
		hc.Calories,
		hi.TotalIntensity,
		hi.AverageIntensity,
		hs.StepTotal

from
		Bellabeat..hourlyCalories_merged as hc
		 join
		Bellabeat..hourlyIntensities_merged as hi
		 on hc.Id = hi.Id
		 and hc.ActivityHour = hi.ActivityHour
		 join
		Bellabeat..hourlySteps_merged as hs
		 on hc.Id = hs.Id
		 and hc.ActivityHour = hs.ActivityHour


--2.2 I will calculate hourly stats throughout the day

select
		cast(ActivityHour as time) as time_of_day,
		cast(avg(calories)as decimal(5,2)) as avg_calories_per_hour,
		cast(avg(TotalIntensity)as decimal(5,2)) as avg_totalintensity_per_hour,
		cast(avg(AverageIntensity)as decimal(5,4)) as avg_averegeintensity_per_hour,
		cast(avg(StepTotal)as decimal(5,2)) as avg_steptotal_per_hour
from
(
	select
		hc.Id,
		hc.ActivityHour,
		hc.Calories,
		hi.TotalIntensity,
		hi.AverageIntensity,
		hs.StepTotal

	from
		Bellabeat..hourlyCalories_merged as hc
		 join
		Bellabeat..hourlyIntensities_merged as hi
		 on hc.Id = hi.Id
		 and hc.ActivityHour = hi.ActivityHour
		 join
		Bellabeat..hourlySteps_merged as hs
		 on hc.Id = hs.Id
		 and hc.ActivityHour = hs.ActivityHour
) as hourly_stats
group by		
		cast(ActivityHour as time)
order by
		2 desc

--# from this query we see that (6:00 pm,7:00 pm,8:00 pm) are the most busy hours while(2:00 am,3:00 am,4:00 am) are the least busy hours as people mainly are asleep in these hours.


