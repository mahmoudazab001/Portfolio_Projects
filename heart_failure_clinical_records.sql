

-- Data Manipulation

-- I will add some range column to the table to make the result more general 

--1 creatinine_phosphokinase (According to https://www.mountsinai.org/health-library/tests/creatine-phosphokinase-test#:~:text=Total%20CPK%20normal%20values%3A,per%20liter%20(mcg%2FL))
alter table heart_failure_clinical_records..heart_failure_clinical_records
add creatinine_phosphokinase_Status varchar(255)

update heart_failure_clinical_records..heart_failure_clinical_records
set creatinine_phosphokinase_Status = case
			when [creatinine_phosphokinase_(mcg/L)] <= 123 then 'Normal'
			else 'High'
		end

--2 ejection fraction (According to https://www.pennmedicine.org/updates/blogs/heart-and-vascular-blog/2022/april/ejection-fraction-what-the-numbers-mean)
alter table heart_failure_clinical_records..heart_failure_clinical_records
add ejection_fraction_Status varchar(255)

update heart_failure_clinical_records..heart_failure_clinical_records
set ejection_fraction_Status = case
			when [ejection_fraction_%] > 75 then 'hypertrophic cardiomyopathy'
			when [ejection_fraction_%] >=55 then 'Normal heart function'
			when [ejection_fraction_%] >= 40 then 'Below Normal heart function'
			else 'High chance of heart failure'
		end

--3 platelets (According to https://www.oneblood.org/media/blog/platelets/what-is-a-normal-platelet-count.stml#:~:text=For%20women%2C%20the%20average%20platelet,are%20always%20in%20high%20demand.)
alter table heart_failure_clinical_records..heart_failure_clinical_records
add Platelets_Status varchar(255)

update heart_failure_clinical_records..heart_failure_clinical_records
set Platelets_Status = case
			when [platelets_(kiloplatelets/mL)] > 450000 then 'High level'
			when [platelets_(kiloplatelets/mL)] >=150000 then 'Normal level'
			else 'low level'
		end

--4 serum_creatinine (According to https://www.mayoclinic.org/tests-procedures/creatinine-test/about/pac-20384646#:~:text=The%20typical%20range%20for%20serum,52.2%20to%2091.9%20micromoles%2FL))
alter table heart_failure_clinical_records..heart_failure_clinical_records
add serum_creatinine_Status varchar(255)

update heart_failure_clinical_records..heart_failure_clinical_records
set serum_creatinine_Status = case
			when [serum_creatinine_(mg/dL)] > 1.35 and sex= 1  then 'High level'
			when [serum_creatinine_(mg/dL)] >=1.04 and sex = 0 then 'High level'
			when [serum_creatinine_(mg/dL)] >= 0.74 and sex= 1  then 'Normal level'
			when [serum_creatinine_(mg/dL)] >=0.59 and sex = 0 then 'Normal level'
			else 'low level'
		end

--5 serum_sodium (According to https://www.mayoclinic.org/diseases-conditions/hyponatremia/symptoms-causes/syc-20373711)
alter table heart_failure_clinical_records..heart_failure_clinical_records
add serum_sodium_Status varchar(255)

update heart_failure_clinical_records..heart_failure_clinical_records
set serum_sodium_Status = case
			when [serum_sodium_(mEq/L)] > 145 then 'High level'
			when [serum_sodium_(mEq/L)] >=135 then 'Normal level'
			else 'low level'
		end


-- Data Analysis
-- First, I'll explore the relation of each Factor with death event

--1 age
select
		age,
		case
			when DEATH_EVENT = 0 then 'Live'
			else 'Dead'
		end as Condition,
		count(age) as Total_Patient,
		count(*) * 100.0 / sum(count(*)) over() as Percentage_of_Total
from
(
select
		case 
			WHEN age >=90 then '90s'
			WHEN age >=80 then '80s'
			WHEN age >=70 then '70s'
			WHEN age >=60 then '60s'
			WHEN age >=50 then '50s'
			WHEN age >=40 then '40s'
			else '30s'
			end as age,
			DEATH_EVENT
from
		heart_failure_clinical_records..heart_failure_clinical_records
) as mo
group by
		age,DEATH_EVENT
order by
		1
--# 23.4% of people in their 40s died 
--# 24.3% of people in their 50s died 
--# 29.0% of people in their 60s died 
--# 38.4% of people in their 70s died 
--# 84.2% of people in their 80s died 
--# 83.3% of people in their 90s died 

--2 anaemia
select
		case
			when anaemia = 0 then 'No anaemia'
			else 'anaemia'
		end as anaemia,
		case
			when DEATH_EVENT = 0 then 'Live'
			else 'Dead'
		end as Condition,
		COUNT(anaemia) as Total_Patient,
		count(*) * 100.0 / sum(count(*)) over() as Percentage_of_Total
from
		heart_failure_clinical_records..heart_failure_clinical_records
group by
		anaemia,DEATH_EVENT
order by
		1
--# 35.6% of people with anaemia died 
--# 29.4% of people without anaemia died.

--2 creatinine phosphokinase
select
		creatinine_phosphokinase_Status,
		case
			when DEATH_EVENT = 0 then 'Live'
			else 'Dead'
		end as Condition,
		COUNT(creatinine_phosphokinase_Status) as Total_Patient,
		count(*) * 100.0 / sum(count(*)) over() as Percentage_of_Total
from
		heart_failure_clinical_records..heart_failure_clinical_records
group by
		creatinine_phosphokinase_Status,DEATH_EVENT
order by
		1
--# 34.4% of people with High range died 
--# 25.9% of people with Normal range died.

--3 diabetes
select
		case
			when diabetes = 0 then 'No diabetes'
			else 'diabetes'
		end as diabetes,
		case
			when DEATH_EVENT = 0 then 'Live'
			else 'Dead'
		end as Condition,
		COUNT(diabetes) as Total_Patient,
		count(*) * 100.0 / sum(count(*)) over() as Percentage_of_Total
from
		heart_failure_clinical_records..heart_failure_clinical_records
group by
		diabetes,DEATH_EVENT
order by
		1
--# 32.0% of people with diabetes died 
--# 32.1% of people without diabetes died.

--4 ejection fraction
select
		ejection_fraction_Status,
		case
			when DEATH_EVENT = 0 then 'Live'
			else 'Dead'
		end as Condition,
		COUNT(ejection_fraction_Status) as Total_Patient,
		count(*) * 100.0 / sum(count(*)) over() as Percentage_of_Total
from
		heart_failure_clinical_records..heart_failure_clinical_records
group by
		ejection_fraction_Status,DEATH_EVENT
order by
		1
--# 21%   of people with normal range ejection_fraction died,
--# 19.2% of people with low level range ejection_fraction died,
--# 40.1% of people with very low level ejection_fraction died.

--5 high blood pressure
select
		case
			when high_blood_pressure = 0 then 'Normal blood pressure'
			else 'high blood pressure'
		end as high_blood_pressure,
		case
			when DEATH_EVENT = 0 then 'Live'
			else 'Dead'
		end as Condition,
		COUNT(high_blood_pressure) as Total_Patient,
		count(*) * 100.0 / sum(count(*)) over() as Percentage_of_Total
from
		heart_failure_clinical_records..heart_failure_clinical_records
group by
		high_blood_pressure,DEATH_EVENT
order by
		1
--# 37.1% of people with high blood pressure died 
--# 29.3% of people with normal blood pressure died.

--6 platelets
select
		Platelets_Status,
		case
			when DEATH_EVENT = 0 then 'Live'
			else 'Dead'
		end as Condition,
		COUNT(Platelets_Status) as Total_Patient,
		count(*) * 100.0 / sum(count(*)) over() as Percentage_of_Total
from
		heart_failure_clinical_records..heart_failure_clinical_records
group by
		Platelets_Status,DEATH_EVENT
order by
		1
--# 38.4% of people with high platelets died,
--# 28.8% of people with normal platelets died,
--# 40.7% of people with low platelets died

--7 serum creatinine
select
		serum_creatinine_Status,
		case
			when DEATH_EVENT = 0 then 'Live'
			else 'Dead'
		end as Condition,
		COUNT(serum_creatinine_Status) as Total_Patient,
		count(*) * 100.0 / sum(count(*)) over() as Percentage_of_Total
from
		heart_failure_clinical_records..heart_failure_clinical_records
group by
		serum_creatinine_Status,DEATH_EVENT
order by
		1

--# 50.0% of people with high level serum creatinine died
--# 23.4% of people with normal level serum creatinine died
--# 11.1% of people with low level serum creatinine died

--8 serum sodium
select
		serum_sodium_Status,
		case
			when DEATH_EVENT = 0 then 'Live'
			else 'Dead'
		end as Condition,
		COUNT(serum_sodium_Status) as Total_Patient,
		count(*) * 100.0 / sum(count(*)) over() as Percentage_of_Total
from
		heart_failure_clinical_records..heart_failure_clinical_records
group by
		serum_sodium_Status,DEATH_EVENT
order by
		1
--# 50.0% of people with high level serum sodium died
--# 50.6% of people with normal level serum sodium died
--# 24.7% of people with low level serum sodium died

--9 sex
select
		case
			when sex = 0 then 'Female'
			else 'Male'
		end as diabetes,
		case
			when DEATH_EVENT = 0 then 'Live'
			else 'Dead'
		end as Condition,
		COUNT(sex) as Total_Patient,
		count(*) * 100.0 / sum(count(*)) over() as Percentage_of_Total
from
		heart_failure_clinical_records..heart_failure_clinical_records
group by
		sex,DEATH_EVENT
order by
		1
--# 32.2% of females died
--# 33.5% of males died

--10 smoking
select
		case
			when smoking = 0 then 'Non Smoker'
			else 'Smoker'
		end as diabetes,
		case
			when DEATH_EVENT = 0 then 'Live'
			else 'Dead'
		end as Condition,
		COUNT(smoking) as Total_Patient,
		count(*) * 100.0 / sum(count(*)) over() as Percentage_of_Total
from
		heart_failure_clinical_records..heart_failure_clinical_records
group by
		smoking,DEATH_EVENT
order by
		1
--# 32.5% of smoking people died
--# 31.2% of non smoking people died

--11 time
select
		month,
		case
			when DEATH_EVENT = 0 then 'Live'
			else 'Dead'
		end as Condition,
		count(month),
		count(*) * 100.0 / sum(count(*)) over() as Percentage_of_Total
from
(
select
		case 
			WHEN time >254 then 'Month 9'
			WHEN time >223 then 'Month 8'
			WHEN time >192 then 'Month 7'
			WHEN time >161 then 'Month 6'
			WHEN time >130 then 'Month 5'
			WHEN time >99 then 'Month 4'
			WHEN time >68 then 'Month 3'
			WHEN time >37 then 'Month 2'
			else 'Month 1'
			end as month,
			DEATH_EVENT
from
		heart_failure_clinical_records..heart_failure_clinical_records
) as mo
group by
		month,DEATH_EVENT
order by
		1
--# Highest month with death cases is month 1 (13.3% of total patient)
--# the most dangerous period is the first 2 month after the checkup(Far more death than live people)
--# the third month is the begining of a safe period with more people live than dead.