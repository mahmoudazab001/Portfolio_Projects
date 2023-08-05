

select
 *
from
 [Cause of death - World map]..cause_of_deaths

-- After we checked the integrity of the data set (dublicats, Typos and null values) we start the analysis in SQL
-- we will start by analysing the causes and it's number first before digging into the countries 

-- 1 Causes Breakdown

-- 1.1 Total death / Total death per cause

select
		sum([Meningitis]+[Alzheimer's Disease and Other Dementias]  +[Parkinson's Disease]
		  +[Nutritional Deficiencies] +[Malaria] +[Drowning] +[Interpersonal Violence]
		  +[Maternal Disorders] +[HIV/AIDS] +[Drug Use Disorders] +[Tuberculosis]
	      +[Cardiovascular Diseases] +[Lower Respiratory Infections] +[Neonatal Disorders]
		  +[Alcohol Use Disorders] +[Self-harm] +[Exposure to Forces of Nature]
		  +[Diarrheal Diseases] +[Environmental Heat and Cold Exposure] +[Neoplasms]
		  +[Conflict and Terrorism] +[Diabetes Mellitus] +[Chronic Kidney Disease]
		  +[Poisonings] +[Protein-Energy Malnutrition]+[Road Injuries]
		  +[Chronic Respiratory Diseases]+[Cirrhosis and Other Chronic Liver Diseases]
	      +[Digestive Diseases] +[Fire, Heat, and Hot Substances] +[Acute Hepatitis]) as total_death,
		sum(Meningitis) as total_Meningitis, 
		sum([Alzheimer's Disease and Other Dementias]) as total_Alzheimer_Disease_and_Other_Dementias,
		sum([Parkinson's Disease]) as total_Parkinson_Disease ,
		sum([Nutritional Deficiencies]) as total_Nutritional_Deficiencies,
		sum(Malaria) as total_Malaria,
		sum(Drowning) as total_Drowning,
		sum([Interpersonal Violence]) as total_Interpersonal_Violence,
		sum([Maternal Disorders]) as total_Maternal_Disorders,
		sum([HIV/AIDS]) as total_HIV_AIDS,
		sum([Drug Use Disorders]) as total_Drug_Use_Disorders,
		sum(Tuberculosis) as total_Tuberculosis,
		sum([Cardiovascular Diseases]) as total_Cardiovascular_Diseases,
		sum([Lower Respiratory Infections]) as total_Lower_Respiratory_Infections,
		sum([Neonatal Disorders]) as total_Neonatal_Disorders,
		sum([Alcohol Use Disorders]) as total_Alcohol_Use_Disorders,
		sum([Self-harm]) as total_Self_harm,
		sum([Exposure to Forces of Nature]) as total_Exposure_to_Forces_of_Nature,
		sum([Diarrheal Diseases]) as total_Diarrheal_Diseases,
		sum([Environmental Heat and Cold Exposure]) as total_Environmental_Heat_and_Cold_Exposure,
		sum(Neoplasms) as total_Neoplasms,
		sum([Conflict and Terrorism]) as total_Conflict_and_Terrorism,
		sum([Diabetes Mellitus]) as total_Diabetes_Mellitus,
		sum([Chronic Kidney Disease]) as total_Chronic_Kidney_Disease,
		sum(Poisonings) as total_Poisonings,
		sum([Protein-Energy Malnutrition]) as total_Protein_Energy_Malnutrition,
		sum([Road Injuries]) as total_Road_Injuries,
		sum([Chronic Respiratory Diseases]) as total_Chronic_Respiratory_Diseases,
		sum([Cirrhosis and Other Chronic Liver Diseases]) as total_Cirrhosis_and_Other_Chronic_Liver_Diseases,
		sum([Digestive Diseases]) as total_Digestive_Diseases,
		sum([Fire, Heat, and Hot Substances]) as total_Fire_Heat_and_Hot_Substances,
		sum([Acute Hepatitis]) as total_Acute_Hepatitis
from
		[Cause of death - World map]..cause_of_deaths


-- 1.2 death cause percentage from total death

select
		(total_Meningitis / total_death )*100 as total_Meningitis_percentage,
		(total_Alzheimer_Disease_and_Other_Dementias / total_death )*100 as total_Alzheimer_Disease_and_Other_Dementias_percentage,
		(total_Parkinson_Disease / total_death )*100 as total_Parkinson_Disease_percentage,
		(total_Nutritional_Deficiencies / total_death )*100 as total_Nutritional_Deficiencies_percentage,
		(total_Malaria / total_death )*100 as total_Malaria_percentage,
		(total_Drowning / total_death )*100 as total_Drowning_percentage,
		(total_Interpersonal_Violence / total_death )*100 as total_Interpersonal_Violence_percentage,
		(total_Maternal_Disorders / total_death )*100 as total_Maternal_Disorders_percentage,
		(total_HIV_AIDS / total_death )*100 as total_HIV_AIDS_percentage,
		(total_Drug_Use_Disorders / total_death )*100 as total_Drug_Use_Disorders_percentage,
		(total_Tuberculosis / total_death )*100 as total_Tuberculosis_percentage,
		(total_Cardiovascular_Diseases / total_death )*100 as total_Cardiovascular_Diseases_percentage,
		(total_Lower_Respiratory_Infections / total_death )*100 as total_Lower_Respiratory_Infections_percentage,
		(total_Neonatal_Disorders / total_death )*100 as total_Neonatal_Disorders_percentage,
		(total_Alcohol_Use_Disorders / total_death )*100 as total_Alcohol_Use_Disorders_percentage,
		(total_Self_harm / total_death )*100 as total_Self_harm_percentage,
		(total_Exposure_to_Forces_of_Nature / total_death )*100 as total_Exposure_to_Forces_of_Nature_percentage,
		(total_Diarrheal_Diseases / total_death )*100 as total_Diarrheal_Diseases_percentage,
		(total_Environmental_Heat_and_Cold_Exposure / total_death )*100 as total_Environmental_Heat_and_Cold_Exposure_percentage,
		(total_Neoplasms / total_death )*100 as total_Neoplasms_percentage,
		(total_Conflict_and_Terrorism / total_death )*100 as total_Conflict_and_Terrorism_percentage,
		(total_Diabetes_Mellitus / total_death )*100 as total_Diabetes_Mellitus_percentage,
		(total_Chronic_Kidney_Disease / total_death )*100 as total_Chronic_Kidney_Disease_percentage,
		(total_Poisonings / total_death )*100 as total_Poisonings_percentage,
		(total_Protein_Energy_Malnutrition / total_death )*100 as total_Protein_Energy_Malnutrition,
		(total_Road_Injuries / total_death )*100 as total_Road_Injuries_percentage,
		(total_Chronic_Respiratory_Diseases / total_death )*100 as total_Chronic_Respiratory_Diseases_percentage,
		(total_Cirrhosis_and_Other_Chronic_Liver_Diseases / total_death )*100 as total_Cirrhosis_and_Other_Chronic_Liver_Diseases_percentage,
		(total_Digestive_Diseases / total_death )*100 as total_Digestive_Diseases_percentage,
		(total_Fire_Heat_and_Hot_Substances / total_death )*100 as total_Fire_Heat_and_Hot_Substances_percentage,
		(total_Acute_Hepatitis / total_death )*100 as total_Acute_Hepatitis_percentage
from
(
select
		sum([Meningitis]+[Alzheimer's Disease and Other Dementias]  +[Parkinson's Disease]
		  +[Nutritional Deficiencies] +[Malaria] +[Drowning] +[Interpersonal Violence]
		  +[Maternal Disorders] +[HIV/AIDS] +[Drug Use Disorders] +[Tuberculosis]
	      +[Cardiovascular Diseases] +[Lower Respiratory Infections] +[Neonatal Disorders]
		  +[Alcohol Use Disorders] +[Self-harm] +[Exposure to Forces of Nature]
		  +[Diarrheal Diseases] +[Environmental Heat and Cold Exposure] +[Neoplasms]
		  +[Conflict and Terrorism] +[Diabetes Mellitus] +[Chronic Kidney Disease]
		  +[Poisonings] +[Protein-Energy Malnutrition]+[Road Injuries]
		  +[Chronic Respiratory Diseases]+[Cirrhosis and Other Chronic Liver Diseases]
	      +[Digestive Diseases] +[Fire, Heat, and Hot Substances] +[Acute Hepatitis]) as total_death,
		sum(Meningitis) as total_Meningitis, 
		sum([Alzheimer's Disease and Other Dementias]) as total_Alzheimer_Disease_and_Other_Dementias,
		sum([Parkinson's Disease]) as total_Parkinson_Disease ,
		sum([Nutritional Deficiencies]) as total_Nutritional_Deficiencies,
		sum(Malaria) as total_Malaria,
		sum(Drowning) as total_Drowning,
		sum([Interpersonal Violence]) as total_Interpersonal_Violence,
		sum([Maternal Disorders]) as total_Maternal_Disorders,
		sum([HIV/AIDS]) as total_HIV_AIDS,
		sum([Drug Use Disorders]) as total_Drug_Use_Disorders,
		sum(Tuberculosis) as total_Tuberculosis,
		sum([Cardiovascular Diseases]) as total_Cardiovascular_Diseases,
		sum([Lower Respiratory Infections]) as total_Lower_Respiratory_Infections,
		sum([Neonatal Disorders]) as total_Neonatal_Disorders,
		sum([Alcohol Use Disorders]) as total_Alcohol_Use_Disorders,
		sum([Self-harm]) as total_Self_harm,
		sum([Exposure to Forces of Nature]) as total_Exposure_to_Forces_of_Nature,
		sum([Diarrheal Diseases]) as total_Diarrheal_Diseases,
		sum([Environmental Heat and Cold Exposure]) as total_Environmental_Heat_and_Cold_Exposure,
		sum(Neoplasms) as total_Neoplasms,
		sum([Conflict and Terrorism]) as total_Conflict_and_Terrorism,
		sum([Diabetes Mellitus]) as total_Diabetes_Mellitus,
		sum([Chronic Kidney Disease]) as total_Chronic_Kidney_Disease,
		sum(Poisonings) as total_Poisonings,
		sum([Protein-Energy Malnutrition]) as total_Protein_Energy_Malnutrition,
		sum([Road Injuries]) as total_Road_Injuries,
		sum([Chronic Respiratory Diseases]) as total_Chronic_Respiratory_Diseases,
		sum([Cirrhosis and Other Chronic Liver Diseases]) as total_Cirrhosis_and_Other_Chronic_Liver_Diseases,
		sum([Digestive Diseases]) as total_Digestive_Diseases,
		sum([Fire, Heat, and Hot Substances]) as total_Fire_Heat_and_Hot_Substances,
		sum([Acute Hepatitis]) as total_Acute_Hepatitis
from
		[Cause of death - World map]..cause_of_deaths
) as total_death

--# we conclude from this quary that 30.49% of total death from 1990 to 2019 are due to cardiovascular diseases 

-- 1.3 now we will explore each year

select
	    [Year],
        sum([Meningitis]+[Alzheimer's Disease and Other Dementias]  +[Parkinson's Disease]
		  +[Nutritional Deficiencies] +[Malaria] +[Drowning] +[Interpersonal Violence]
		  +[Maternal Disorders] +[HIV/AIDS] +[Drug Use Disorders] +[Tuberculosis]
	      +[Cardiovascular Diseases] +[Lower Respiratory Infections] +[Neonatal Disorders]
		  +[Alcohol Use Disorders] +[Self-harm] +[Exposure to Forces of Nature]
		  +[Diarrheal Diseases] +[Environmental Heat and Cold Exposure] +[Neoplasms]
		  +[Conflict and Terrorism] +[Diabetes Mellitus] +[Chronic Kidney Disease]
		  +[Poisonings] +[Protein-Energy Malnutrition]+[Road Injuries]
		  +[Chronic Respiratory Diseases]+[Cirrhosis and Other Chronic Liver Diseases]
	      +[Digestive Diseases] +[Fire, Heat, and Hot Substances] +[Acute Hepatitis]) as total_death
from
		[Cause of death - World map]..cause_of_deaths
group by 
		Year
order by
		2 desc

--# INTERESTING!!! That the number of deathes are gradually increase throughout the years 

-- 1.4 death count difference thoughout the years
select
		year,
		total_death,
		total_death-LAG(total_death-1) over (order by year) as death_count_differences
from
(
select
	    [Year],
        sum([Meningitis]+[Alzheimer's Disease and Other Dementias]  +[Parkinson's Disease]
		  +[Nutritional Deficiencies] +[Malaria] +[Drowning] +[Interpersonal Violence]
		  +[Maternal Disorders] +[HIV/AIDS] +[Drug Use Disorders] +[Tuberculosis]
	      +[Cardiovascular Diseases] +[Lower Respiratory Infections] +[Neonatal Disorders]
		  +[Alcohol Use Disorders] +[Self-harm] +[Exposure to Forces of Nature]
		  +[Diarrheal Diseases] +[Environmental Heat and Cold Exposure] +[Neoplasms]
		  +[Conflict and Terrorism] +[Diabetes Mellitus] +[Chronic Kidney Disease]
		  +[Poisonings] +[Protein-Energy Malnutrition]+[Road Injuries]
		  +[Chronic Respiratory Diseases]+[Cirrhosis and Other Chronic Liver Diseases]
	      +[Digestive Diseases] +[Fire, Heat, and Hot Substances] +[Acute Hepatitis]) as total_death
from
		[Cause of death - World map]..cause_of_deaths
group by 
		Year

) as death_count

--# there is some fluctuation in the total number with an overall positive increase in number 


-- 1.5 difference in death count for each cause per year

select
		year,
		sum(Meningitis) as total_Meningitis,
		sum(Meningitis) - LAG(sum(Meningitis)-1) over (order by year) as death_count_differences,
		sum([Alzheimer's Disease and Other Dementias]) as total_Alzheimer_Disease_and_Other_Dementias,
		sum([Alzheimer's Disease and Other Dementias]) - LAG(sum([Alzheimer's Disease and Other Dementias])-1) over (order by year) as death_count_differences,
		sum([Parkinson's Disease]) as total_Parkinson_Disease ,
		sum([Parkinson's Disease]) - LAG(sum([Parkinson's Disease])-1) over (order by year) as death_count_differences,
		sum([Nutritional Deficiencies]) as total_Nutritional_Deficiencies,
		sum([Nutritional Deficiencies]) - LAG(sum([Nutritional Deficiencies])-1) over (order by year) as death_count_differences,
		sum(Malaria) as total_Malaria,
		sum(Malaria) - LAG(sum(Malaria)-1) over (order by year) as death_count_differences,
		sum(Drowning) as total_Drowning,
		sum(Drowning) - LAG(sum(Drowning)-1) over (order by year) as death_count_differences,
		sum([Interpersonal Violence]) as total_Interpersonal_Violence,
		sum([Interpersonal Violence]) - LAG(sum([Interpersonal Violence])-1) over (order by year) as death_count_differences,
		sum([Maternal Disorders]) as total_Maternal_Disorders,
		sum([Maternal Disorders]) - LAG(sum([Maternal Disorders])-1) over (order by year) as death_count_differences,
		sum([HIV/AIDS]) as total_HIV_AIDS,
		sum([HIV/AIDS]) - LAG(sum([HIV/AIDS])-1) over (order by year) as death_count_differences,
		sum([Drug Use Disorders]) as total_Drug_Use_Disorders,
		sum([Drug Use Disorders]) - LAG(sum([Drug Use Disorders])-1) over (order by year) as death_count_differences,
		sum(Tuberculosis) as total_Tuberculosis,
		sum(Tuberculosis) - LAG(sum(Tuberculosis)-1) over (order by year) as death_count_differences,
		sum([Cardiovascular Diseases]) as total_Cardiovascular_Diseases,
		sum([Cardiovascular Diseases]) - LAG(sum([Cardiovascular Diseases])-1) over (order by year) as death_count_differences,
		sum([Lower Respiratory Infections]) as total_Lower_Respiratory_Infections,
		sum([Lower Respiratory Infections]) - LAG(sum([Lower Respiratory Infections])-1) over (order by year) as death_count_differences,
		sum([Neonatal Disorders]) as total_Neonatal_Disorders,
		sum([Neonatal Disorders]) - LAG(sum([Neonatal Disorders])-1) over (order by year) as death_count_differences,
		sum([Alcohol Use Disorders]) as total_Alcohol_Use_Disorders,
		sum([Alcohol Use Disorders]) - LAG(sum([Alcohol Use Disorders])-1) over (order by year) as death_count_differences,
		sum([Self-harm]) as total_Self_harm,
		sum([Self-harm]) - LAG(sum([Self-harm])-1) over (order by year) as death_count_differences,
		sum([Exposure to Forces of Nature]) as total_Exposure_to_Forces_of_Nature,
		sum([Exposure to Forces of Nature]) - LAG(sum([Exposure to Forces of Nature])-1) over (order by year) as death_count_differences,
		sum([Diarrheal Diseases]) as total_Diarrheal_Diseases,
		sum([Diarrheal Diseases]) - LAG(sum([Diarrheal Diseases])-1) over (order by year) as death_count_differences,
		sum([Environmental Heat and Cold Exposure]) as total_Environmental_Heat_and_Cold_Exposure,
		sum([Environmental Heat and Cold Exposure]) - LAG(sum([Environmental Heat and Cold Exposure])-1) over (order by year) as death_count_differences,
		sum(Neoplasms) as total_Neoplasms,
		sum(Neoplasms) - LAG(sum(Neoplasms)-1) over (order by year) as death_count_differences,
		sum([Conflict and Terrorism]) as total_Conflict_and_Terrorism,
		sum([Conflict and Terrorism]) - LAG(sum([Conflict and Terrorism])-1) over (order by year) as death_count_differences,
		sum([Diabetes Mellitus]) as total_Diabetes_Mellitus,
		sum([Diabetes Mellitus]) - LAG(sum([Diabetes Mellitus])-1) over (order by year) as death_count_differences,
		sum([Chronic Kidney Disease]) as total_Chronic_Kidney_Disease,
		sum([Chronic Kidney Disease]) - LAG(sum([Chronic Kidney Disease])-1) over (order by year) as death_count_differences,
		sum(Poisonings) as total_Poisonings,
		sum(Poisonings) - LAG(sum(Poisonings)-1) over (order by year) as death_count_differences,
		sum([Protein-Energy Malnutrition]) as total_Protein_Energy_Malnutrition,
		sum([Protein-Energy Malnutrition]) - LAG(sum([Protein-Energy Malnutrition])-1) over (order by year) as death_count_differences,
		sum([Road Injuries]) as total_Road_Injuries,
		sum([Road Injuries]) - LAG(sum([Road Injuries])-1) over (order by year) as death_count_differences,
		sum([Chronic Respiratory Diseases]) as total_Chronic_Respiratory_Diseases,
		sum([Chronic Respiratory Diseases]) - LAG(sum([Chronic Respiratory Diseases])-1) over (order by year) as death_count_differences,
		sum([Cirrhosis and Other Chronic Liver Diseases]) as total_Cirrhosis_and_Other_Chronic_Liver_Diseases,
		sum([Cirrhosis and Other Chronic Liver Diseases]) - LAG(sum([Cirrhosis and Other Chronic Liver Diseases])-1) over (order by year) as death_count_differences,
		sum([Digestive Diseases]) as total_Digestive_Diseases,
		sum([Digestive Diseases]) - LAG(sum([Digestive Diseases])-1) over (order by year) as death_count_differences,
		sum([Fire, Heat, and Hot Substances]) as total_Fire_Heat_and_Hot_Substances,
		sum([Fire, Heat, and Hot Substances]) - LAG(sum([Fire, Heat, and Hot Substances])-1) over (order by year) as death_count_differences,
		sum([Acute Hepatitis]) as total_Acute_Hepatitis,
		sum([Acute Hepatitis]) - LAG(sum([Acute Hepatitis])-1) over (order by year) as death_count_differences
from
		[Cause of death - World map]..cause_of_deaths
group by 
		Year

-- 1.6 most common death cause for each year

SELECT
year,
  (
      SELECT Max(v) 
       FROM (VALUES (total_Meningitis)
      ,(total_Alzheimer_Disease_and_Other_Dementias)
      ,(total_Parkinson_Disease)
      ,(total_Nutritional_Deficiencies)
      ,(total_Malaria)
      ,(total_Drowning)
      ,(total_Interpersonal_Violence)
      ,(total_Maternal_Disorders)
      ,(total_HIV_AIDS)
      ,(total_Drug_Use_Disorders)
      ,(total_Tuberculosis)
      ,(total_Cardiovascular_Diseases)
      ,(total_Lower_Respiratory_Infections)
      ,(total_Neonatal_Disorders)
      ,(total_Alcohol_Use_Disorders)
      ,(total_Self_harm)
      ,(total_Exposure_to_Forces_of_Nature)
      ,(total_Diarrheal_Diseases)
      ,(total_Environmental_Heat_and_Cold_Exposure)
      ,(total_Neoplasms)
      ,(total_Conflict_and_Terrorism)
      ,(total_Diabetes_Mellitus)
      ,(total_Chronic_Kidney_Disease)
      ,(total_Poisonings)
      ,(total_Protein_Energy_Malnutrition)
      ,(total_Road_Injuries)
      ,(total_Chronic_Respiratory_Diseases)
      ,(total_Chronic_Respiratory_Diseases)
      ,(total_Digestive_Diseases)
      ,(total_Fire_Heat_and_Hot_Substances)
      ,(total_Acute_Hepatitis)) AS value(v) 
   ) as [MaxDeathCount]
FROM 
(
select
		YEAR,
		sum(Meningitis) as total_Meningitis, 
		sum([Alzheimer's Disease and Other Dementias]) as total_Alzheimer_Disease_and_Other_Dementias,
		sum([Parkinson's Disease]) as total_Parkinson_Disease ,
		sum([Nutritional Deficiencies]) as total_Nutritional_Deficiencies,
		sum(Malaria) as total_Malaria,
		sum(Drowning) as total_Drowning,
		sum([Interpersonal Violence]) as total_Interpersonal_Violence,
		sum([Maternal Disorders]) as total_Maternal_Disorders,
		sum([HIV/AIDS]) as total_HIV_AIDS,
		sum([Drug Use Disorders]) as total_Drug_Use_Disorders,
		sum(Tuberculosis) as total_Tuberculosis,
		sum([Cardiovascular Diseases]) as total_Cardiovascular_Diseases,
		sum([Lower Respiratory Infections]) as total_Lower_Respiratory_Infections,
		sum([Neonatal Disorders]) as total_Neonatal_Disorders,
		sum([Alcohol Use Disorders]) as total_Alcohol_Use_Disorders,
		sum([Self-harm]) as total_Self_harm,
		sum([Exposure to Forces of Nature]) as total_Exposure_to_Forces_of_Nature,
		sum([Diarrheal Diseases]) as total_Diarrheal_Diseases,
		sum([Environmental Heat and Cold Exposure]) as total_Environmental_Heat_and_Cold_Exposure,
		sum(Neoplasms) as total_Neoplasms,
		sum([Conflict and Terrorism]) as total_Conflict_and_Terrorism,
		sum([Diabetes Mellitus]) as total_Diabetes_Mellitus,
		sum([Chronic Kidney Disease]) as total_Chronic_Kidney_Disease,
		sum(Poisonings) as total_Poisonings,
		sum([Protein-Energy Malnutrition]) as total_Protein_Energy_Malnutrition,
		sum([Road Injuries]) as total_Road_Injuries,
		sum([Chronic Respiratory Diseases]) as total_Chronic_Respiratory_Diseases,
		sum([Cirrhosis and Other Chronic Liver Diseases]) as total_Cirrhosis_and_Other_Chronic_Liver_Diseases,
		sum([Digestive Diseases]) as total_Digestive_Diseases,
		sum([Fire, Heat, and Hot Substances]) as total_Fire_Heat_and_Hot_Substances,
		sum([Acute Hepatitis]) as total_Acute_Hepatitis
from
		[Cause of death - World map]..cause_of_deaths
group by 
		Year
) as total_death_count
order by 1

--# From this query we can clearly see by comparing it with total death count query that Cardiocascular Diseases is the most common cause of death all over the years (1990 - 2019)

-- 2 Country Breakdown

--2.1 rolling count of all death causes for each country 

SELECT 
	    [Country/Territory]
	   ,year
	   ,Meningitis
	   ,sum(Meningitis) over( partition by [Country/Territory] order by [Country/Territory],year) as Rolling_death_count
       ,[Alzheimer's Disease and Other Dementias]
	   ,sum([Alzheimer's Disease and Other Dementias]) over( partition by [Country/Territory] order by [Country/Territory],year) as Rolling_death_count
       ,[Parkinson's Disease]
	   ,sum([Parkinson's Disease]) over( partition by [Country/Territory] order by [Country/Territory],year) as Rolling_death_count
       ,[Nutritional Deficiencies]
	   ,sum([Nutritional Deficiencies]) over( partition by [Country/Territory] order by [Country/Territory],year) as Rolling_death_count
       ,[Malaria]
	   ,sum([Malaria]) over( partition by [Country/Territory] order by [Country/Territory],year) as Rolling_death_count
       ,[Drowning]
	   ,sum([Drowning]) over( partition by [Country/Territory] order by [Country/Territory],year) as Rolling_death_count
       ,[Interpersonal Violence]
	   ,sum([Interpersonal Violence]) over( partition by [Country/Territory] order by [Country/Territory],year) as Rolling_death_count
       ,[Maternal Disorders]
	   ,sum([Maternal Disorders]) over( partition by [Country/Territory] order by [Country/Territory],year) as Rolling_death_count
       ,[HIV/AIDS]
	   ,sum([HIV/AIDS]) over( partition by [Country/Territory] order by [Country/Territory],year) as Rolling_death_count
       ,[Drug Use Disorders]
	   ,sum([Drug Use Disorders]) over( partition by [Country/Territory] order by [Country/Territory],year) as Rolling_death_count
       ,[Tuberculosis]
	   ,sum([Tuberculosis]) over( partition by [Country/Territory] order by [Country/Territory],year) as Rolling_death_count
       ,[Cardiovascular Diseases]
	   ,sum([Cardiovascular Diseases]) over( partition by [Country/Territory] order by [Country/Territory],year) as Rolling_death_count
       ,[Lower Respiratory Infections]
	   ,sum([Lower Respiratory Infections]) over( partition by [Country/Territory] order by [Country/Territory],year) as Rolling_death_count
       ,[Neonatal Disorders]
	   ,sum([Neonatal Disorders]) over( partition by [Country/Territory] order by [Country/Territory],year) as Rolling_death_count
       ,[Alcohol Use Disorders]
	   ,sum([Alcohol Use Disorders]) over( partition by [Country/Territory] order by [Country/Territory],year) as Rolling_death_count
       ,[Self-harm]
	   ,sum([Self-harm]) over( partition by [Country/Territory] order by [Country/Territory],year) as Rolling_death_count
       ,[Exposure to Forces of Nature]
	   ,sum([Exposure to Forces of Nature]) over( partition by [Country/Territory] order by [Country/Territory],year) as Rolling_death_count
       ,[Diarrheal Diseases]
	   ,sum([Diarrheal Diseases]) over( partition by [Country/Territory] order by [Country/Territory],year) as Rolling_death_count
       ,[Environmental Heat and Cold Exposure]
	   ,sum([Environmental Heat and Cold Exposure]) over( partition by [Country/Territory] order by [Country/Territory],year) as Rolling_death_count
       ,[Neoplasms]
	   ,sum([Neoplasms]) over( partition by [Country/Territory] order by [Country/Territory],year) as Rolling_death_count
       ,[Conflict and Terrorism]
	   ,sum([Conflict and Terrorism]) over( partition by [Country/Territory] order by [Country/Territory],year) as Rolling_death_count
       ,[Diabetes Mellitus]
	   ,sum([Diabetes Mellitus]) over( partition by [Country/Territory] order by [Country/Territory],year) as Rolling_death_count
       ,[Chronic Kidney Disease]
	   ,sum([Chronic Kidney Disease]) over( partition by [Country/Territory] order by [Country/Territory],year) as Rolling_death_count
       ,[Poisonings]
	   ,sum([Poisonings]) over( partition by [Country/Territory] order by [Country/Territory],year) as Rolling_death_count
       ,[Protein-Energy Malnutrition]
	   ,sum([Protein-Energy Malnutrition]) over( partition by [Country/Territory] order by [Country/Territory],year) as Rolling_death_count
       ,[Road Injuries] 
	   ,sum([Road Injuries]) over( partition by [Country/Territory] order by [Country/Territory],year) as Rolling_death_count
       ,[Chronic Respiratory Diseases]
	   ,sum([Chronic Respiratory Diseases]) over( partition by [Country/Territory] order by [Country/Territory],year) as Rolling_death_count
       ,[Cirrhosis and Other Chronic Liver Diseases]
	   ,sum([Cirrhosis and Other Chronic Liver Diseases]) over( partition by [Country/Territory] order by [Country/Territory],year) as Rolling_death_count
       ,[Digestive Diseases]
	   ,sum([Digestive Diseases]) over( partition by [Country/Territory] order by [Country/Territory],year) as Rolling_death_count
       ,[Fire, Heat, and Hot Substances]
	   ,sum([Fire, Heat, and Hot Substances]) over( partition by [Country/Territory] order by [Country/Territory],year) as Rolling_death_count
       ,[Acute Hepatitis]
	   ,sum([Acute Hepatitis]) over( partition by [Country/Territory] order by [Country/Territory],year) as Rolling_death_count
FROM [Cause of death - World map]..cause_of_deaths
order by 1


-- max death count per cause per country

select
		[Country/Territory],
		MAX(Meningitis_death_count) as total_Meningitis_death_count,
		max(Alzheimer_Disease_and_Other_Dementias_death_count) as total_Alzheimer_Disease_and_Other_Dementias_death_count,
		max(Parkinson_Disease_death_count) as total_Parkinson_Disease_death_count ,
		max(Nutritional_Deficiencies_death_count) as total_Nutritional_Deficiencies_death_count ,
		max(Malaria_death_count) as total_Malaria_death_count ,
		max(Drowning_death_count) as total_Drowning_death_count ,
		max(Interpersonal_Violence_death_count) as total_Interpersonal_Violence_death_count ,
		max(Maternal_Disorders_death_count) as total_Maternal_Disorders_death_count ,
		max(HIV_AIDS_death_count) as total_HIV_AIDS_death_count ,
		max(Drug_Use_Disorders_death_count) as total_Drug_Use_Disorders_death_count ,
		max(Tuberculosis_death_count) as total_Tuberculosis_death_count ,
		max(Cardiovascular_Diseases_death_count) as total_Cardiovascular_Diseases_death_count ,
		max(Lower_Respiratory_Infections_death_count) as total_Lower_Respiratory_Infections_death_count ,
		max(Neonatal_Disorders_death_count) as total_Neonatal_Disorders_death_count ,
		max(Alcohol_Use_Disorders_death_count) as total_Alcohol_Use_Disorders_death_count ,
		max(Self_harm_death_count) as total_Self_harm_death_count ,
		max(Exposure_to_Forces_of_Nature_death_count) as total_Exposure_to_Forces_of_Nature_death_count ,
		max(Diarrheal_Diseases_death_count) as total_Diarrheal_Diseases_death_count ,
		max(Environmental_Heat_and_Cold_Exposure_death_count) as total_Environmental_Heat_and_Cold_Exposure_death_count ,
		max(Neoplasms_death_count) as total_Neoplasms_death_count ,
		max(Conflict_and_Terrorism_death_count) as total_Conflict_and_Terrorism_death_count ,
		max(Diabetes_Mellitus_death_count) as total_Diabetes_Mellitus_death_count ,
		max(Chronic_Kidney_Disease_death_count) as total_Chronic_Kidney_Disease_death_count ,
		max(Poisonings_death_count) as total_Poisonings_death_count ,
		max(Protein_Energy_Malnutrition_death_count) as total_Protein_Energy_Malnutrition_death_count ,
		max(Road_Injuries_death_count) as total_Road_Injuries_death_count ,
		max(Chronic_Respiratory_Diseases_death_count) as total_Chronic_Respiratory_Diseases_death_count ,
		max(Cirrhosis_and_Other_Chronic_Liver_Diseases_death_count) as total_Cirrhosis_and_Other_Chronic_Liver_Diseases_death_count ,
		max(Digestive_Diseases_death_count) as total_Digestive_Diseases_death_count ,
		max(Fire_Heat_and_Hot_Substances_death_count) as total_Fire_Heat_and_Hot_Substances_death_count ,
		max(Acute_Hepatitis_death_count) as total_Acute_Hepatitis_death_count 
from
(
SELECT 
	    [Country/Territory]
	   ,year
	   ,Meningitis
	   ,sum(Meningitis) over( partition by [Country/Territory] order by [Country/Territory],year) as Meningitis_death_count
       ,[Alzheimer's Disease and Other Dementias]
	   ,sum([Alzheimer's Disease and Other Dementias]) over( partition by [Country/Territory] order by [Country/Territory],year) as Alzheimer_Disease_and_Other_Dementias_death_count
       ,[Parkinson's Disease]
	   ,sum([Parkinson's Disease]) over( partition by [Country/Territory] order by [Country/Territory],year) as Parkinson_Disease_death_count
       ,[Nutritional Deficiencies]
	   ,sum([Nutritional Deficiencies]) over( partition by [Country/Territory] order by [Country/Territory],year) as Nutritional_Deficiencies_death_count
       ,[Malaria]
	   ,sum([Malaria]) over( partition by [Country/Territory] order by [Country/Territory],year) as Malaria_death_count
       ,[Drowning]
	   ,sum([Drowning]) over( partition by [Country/Territory] order by [Country/Territory],year) as Drowning_death_count
       ,[Interpersonal Violence]
	   ,sum([Interpersonal Violence]) over( partition by [Country/Territory] order by [Country/Territory],year) as Interpersonal_Violence_death_count
       ,[Maternal Disorders]
	   ,sum([Maternal Disorders]) over( partition by [Country/Territory] order by [Country/Territory],year) as Maternal_Disorders_death_count
       ,[HIV/AIDS]
	   ,sum([HIV/AIDS]) over( partition by [Country/Territory] order by [Country/Territory],year) as HIV_AIDS_death_count
       ,[Drug Use Disorders]
	   ,sum([Drug Use Disorders]) over( partition by [Country/Territory] order by [Country/Territory],year) as Drug_Use_Disorders_death_count
       ,[Tuberculosis]
	   ,sum([Tuberculosis]) over( partition by [Country/Territory] order by [Country/Territory],year) as Tuberculosis_death_count
       ,[Cardiovascular Diseases]
	   ,sum([Cardiovascular Diseases]) over( partition by [Country/Territory] order by [Country/Territory],year) as Cardiovascular_Diseases_death_count
       ,[Lower Respiratory Infections]
	   ,sum([Lower Respiratory Infections]) over( partition by [Country/Territory] order by [Country/Territory],year) as Lower_Respiratory_Infections_death_count
       ,[Neonatal Disorders]
	   ,sum([Neonatal Disorders]) over( partition by [Country/Territory] order by [Country/Territory],year) as Neonatal_Disorders_death_count
       ,[Alcohol Use Disorders]
	   ,sum([Alcohol Use Disorders]) over( partition by [Country/Territory] order by [Country/Territory],year) as Alcohol_Use_Disorders_death_count
       ,[Self-harm]
	   ,sum([Self-harm]) over( partition by [Country/Territory] order by [Country/Territory],year) as Self_harm_death_count
       ,[Exposure to Forces of Nature]
	   ,sum([Exposure to Forces of Nature]) over( partition by [Country/Territory] order by [Country/Territory],year) as Exposure_to_Forces_of_Nature_death_count
       ,[Diarrheal Diseases]
	   ,sum([Diarrheal Diseases]) over( partition by [Country/Territory] order by [Country/Territory],year) as Diarrheal_Diseases_death_count
       ,[Environmental Heat and Cold Exposure]
	   ,sum([Environmental Heat and Cold Exposure]) over( partition by [Country/Territory] order by [Country/Territory],year) as Environmental_Heat_and_Cold_Exposure_death_count
       ,[Neoplasms]
	   ,sum([Neoplasms]) over( partition by [Country/Territory] order by [Country/Territory],year) as Neoplasms_death_count
       ,[Conflict and Terrorism]
	   ,sum([Conflict and Terrorism]) over( partition by [Country/Territory] order by [Country/Territory],year) as Conflict_and_Terrorism_death_count
       ,[Diabetes Mellitus]
	   ,sum([Diabetes Mellitus]) over( partition by [Country/Territory] order by [Country/Territory],year) as Diabetes_Mellitus_death_count
       ,[Chronic Kidney Disease]
	   ,sum([Chronic Kidney Disease]) over( partition by [Country/Territory] order by [Country/Territory],year) as Chronic_Kidney_Disease_death_count
       ,[Poisonings]
	   ,sum([Poisonings]) over( partition by [Country/Territory] order by [Country/Territory],year) as Poisonings_death_count
       ,[Protein-Energy Malnutrition]
	   ,sum([Protein-Energy Malnutrition]) over( partition by [Country/Territory] order by [Country/Territory],year) as Protein_Energy_Malnutrition_death_count
       ,[Road Injuries] 
	   ,sum([Road Injuries]) over( partition by [Country/Territory] order by [Country/Territory],year) as Road_Injuries_death_count
       ,[Chronic Respiratory Diseases]
	   ,sum([Chronic Respiratory Diseases]) over( partition by [Country/Territory] order by [Country/Territory],year) as Chronic_Respiratory_Diseases_death_count
       ,[Cirrhosis and Other Chronic Liver Diseases]
	   ,sum([Cirrhosis and Other Chronic Liver Diseases]) over( partition by [Country/Territory] order by [Country/Territory],year) as Cirrhosis_and_Other_Chronic_Liver_Diseases_death_count
       ,[Digestive Diseases]
	   ,sum([Digestive Diseases]) over( partition by [Country/Territory] order by [Country/Territory],year) as Digestive_Diseases_death_count
       ,[Fire, Heat, and Hot Substances]
	   ,sum([Fire, Heat, and Hot Substances]) over( partition by [Country/Territory] order by [Country/Territory],year) as Fire_Heat_and_Hot_Substances_death_count
       ,[Acute Hepatitis]
	   ,sum([Acute Hepatitis]) over( partition by [Country/Territory] order by [Country/Territory],year) as Acute_Hepatitis_death_count
FROM [Cause of death - World map]..cause_of_deaths
) as death
group by 
		[Country/Territory]
order by 
		1
