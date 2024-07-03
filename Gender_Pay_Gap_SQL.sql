SELECT *
FROM public.gender_pay_gap_21_22
--LIMIT 10
;

SELECT COUNT (employername) FILTER (WHERE diffmeanhourlypercent = 0)
, COUNT (employername) FILTER (WHERE diffmeanhourlypercent BETWEEN 1 AND 5)
FROM public.gender_pay_gap_21_22
;


SELECT 
--diffmeanhourlypercent
COUNT(employername)
, CASE
    WHEN (diffmeanhourlypercent BETWEEN 0.000000001 AND 5) THEN '5'
    WHEN (diffmeanhourlypercent BETWEEN 6 AND 10) THEN '10'
    WHEN (diffmeanhourlypercent BETWEEN 11 AND 15) THEN '15'
    WHEN (diffmeanhourlypercent BETWEEN 16 AND 20) THEN '20'
    WHEN (diffmeanhourlypercent BETWEEN 21 AND 25) THEN '25'
    WHEN (diffmeanhourlypercent BETWEEN 26 AND 30) THEN '30'
    WHEN (diffmeanhourlypercent BETWEEN 31 AND 35) THEN '35'
    WHEN (diffmeanhourlypercent BETWEEN 36 AND 40) THEN '40'
    WHEN (diffmeanhourlypercent BETWEEN 41 AND 45) THEN '45'
    WHEN (diffmeanhourlypercent BETWEEN 46 AND 50) THEN '50'
    WHEN (diffmeanhourlypercent BETWEEN 51 AND 55) THEN '55'   
    WHEN (diffmeanhourlypercent BETWEEN 56 AND 60) THEN '60'
    WHEN (diffmeanhourlypercent BETWEEN 61 AND 65) THEN '65'
    WHEN (diffmeanhourlypercent BETWEEN 66 AND 70) THEN '70'
    WHEN (diffmeanhourlypercent BETWEEN 71 AND 75) THEN '75'
    WHEN (diffmeanhourlypercent BETWEEN 76 AND 80) THEN '80'
    WHEN (diffmeanhourlypercent BETWEEN 81 AND 85) THEN '85'
    WHEN (diffmeanhourlypercent BETWEEN 86 AND 90) THEN '90'
    WHEN (diffmeanhourlypercent BETWEEN 91 AND 95) THEN '95'
    WHEN (diffmeanhourlypercent BETWEEN 96 AND 100) THEN '100'
    WHEN diffmeanhourlypercent = 0 THEN '0'
    WHEN (diffmeanhourlypercent BETWEEN -5 AND -0.00000001) THEN '-5'
    WHEN (diffmeanhourlypercent BETWEEN -10 AND -6) THEN '-10'
    WHEN (diffmeanhourlypercent BETWEEN -15 AND -11) THEN '-15'
    WHEN (diffmeanhourlypercent BETWEEN -20 AND -16) THEN '-20'
    WHEN (diffmeanhourlypercent BETWEEN -25 AND -21) THEN '-25'
    WHEN (diffmeanhourlypercent BETWEEN -30 AND -26) THEN '-30'
    WHEN (diffmeanhourlypercent BETWEEN -35 AND -31) THEN '-35'
    WHEN (diffmeanhourlypercent BETWEEN -40 AND -36) THEN '-40'
    WHEN (diffmeanhourlypercent BETWEEN -45 AND -41) THEN '-45'
    WHEN (diffmeanhourlypercent BETWEEN -50 AND -46) THEN '-50'
    WHEN (diffmeanhourlypercent BETWEEN -55 AND -51) THEN '-55'
    WHEN (diffmeanhourlypercent BETWEEN -69 AND -56) THEN '-60'
    WHEN (diffmeanhourlypercent BETWEEN -65 AND -61) THEN '-65'
    WHEN (diffmeanhourlypercent BETWEEN -70 AND -66) THEN '-70'
    WHEN (diffmeanhourlypercent BETWEEN -75 AND -71) THEN '-75'
    WHEN (diffmeanhourlypercent BETWEEN -80 AND -76) THEN '-80'
    WHEN (diffmeanhourlypercent BETWEEN -85 AND -81) THEN '-85'
    WHEN (diffmeanhourlypercent BETWEEN -90 AND -86) THEN '-90'
    WHEN (diffmeanhourlypercent BETWEEN -95 AND -91) THEN '-95'
    WHEN (diffmeanhourlypercent BETWEEN -100 AND -96) THEN '-100'
    ELSE 'Less than -100'
    END as diffmeanhourlypercent_grouping
FROM public.gender_pay_gap_21_22
GROUP BY 2;


SELECT diffmeanhourlypercent
FROM public.gender_pay_gap_21_22
WHERE diffmeanhourlypercent < -100
;


SELECT 
AVG(diffmeanhourlypercent) FILTER (WHERE employersize = '250 to 499') as avg_within_250
FROM gender_pay_gap_21_22;


--What is the average pay gap for companies across the UK?

SELECT 
--employersize
ROUND(AVG(diffmeanhourlypercent),2) as avg_mean_hourly_perc
, ROUND(AVG(diffmedianhourlypercent),2) as avg_median_hourly_perc
, ROUND(AVG(diffmeanbonuspercent),2) as avg_mean_bonus_perc
, ROUND(AVG(diffmedianbonuspercent),2) as avg_median_bonus_perc
, ROUND(AVG(malelowerquartile),2) as avg_male_lower
, ROUND(AVG(femalelowerquartile),2) as avg_female_lower
, ROUND(AVG(malelowermiddlequartile),2) as avg_male_lower_mid
, ROUND(AVG(femalelowermiddlequartile),2) as avg_female_lower_mid
, ROUND(AVG(maleuppermiddlequartile),2) as avg_male_upper_mid
, ROUND(AVG(femaleuppermiddlequartile),2) as avg_female_upper_mid
, ROUND(AVG(maletopquartile),2) as avg_male_top
, ROUND(AVG(femaletopquartile),2) as avg_female_top
FROM public.gender_pay_gap_21_22
--GROUP BY 1
;


---largest companies over 20,000


SELECT employername
--employersize
, ROUND(AVG(diffmeanhourlypercent),2) AS avg_mean_difference
, PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY diffmeanhourlypercent) AS median_mean_difference
, ROUND(AVG(diffmedianhourlypercent), 2) AS mean_50p_difference
, PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY diffmedianhourlypercent) AS median_50p_difference
, ROUND(AVG(diffmeanbonuspercent),2) as avg_mean_bonus_perc
, PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY diffmeanbonuspercent) AS median_mean_bonus_difference
, ROUND(AVG(diffmedianbonuspercent),2) as avg_median_bonus_perc
, PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY diffmedianbonuspercent) AS median_50p_bonus_difference
, ROUND(AVG(malelowerquartile),2) AS avg_male_lower
, ROUND(AVG(femalelowerquartile),2) as avg_female_lower
, ROUND(AVG(malelowermiddlequartile),2) as avg_male_lower_mid
, ROUND(AVG(femalelowermiddlequartile),2) as avg_female_lower_mid
, ROUND(AVG(maleuppermiddlequartile),2) as avg_male_upper_mid
, ROUND(AVG(femaleuppermiddlequartile),2) as avg_female_upper_mid
, ROUND(AVG(maletopquartile),2) as avg_male_top
, ROUND(AVG(femaletopquartile),2) as avg_female_top
FROM public.gender_pay_gap_21_22
WHERE employersize = '20,000 or more'
GROUP BY 1
ORDER BY 2 DESC
;


---- count of companies per employersize

SELECT employersize
, COUNT(employername)
FROM public.gender_pay_gap_21_22
GROUP BY 1
;
--Are there differences between the average pay gaps across industries?

SELECT
--employersize
ROUND(AVG(diffmeanhourlypercent),2) AS avg_mean_difference
, PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY diffmeanhourlypercent) AS median_mean_difference
, ROUND(AVG(diffmedianhourlypercent), 2) AS mean_50p_difference
, PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY diffmedianhourlypercent) AS median_50p_difference
, ROUND(AVG(diffmeanbonuspercent),2) as avg_mean_bonus_perc
, PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY diffmeanbonuspercent) AS median_mean_bonus_difference
, ROUND(AVG(diffmedianbonuspercent),2) as avg_median_bonus_perc
, PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY diffmedianbonuspercent) AS median_50p_bonus_difference
, ROUND(AVG(malelowerquartile),2) AS avg_male_lower
, ROUND(AVG(femalelowerquartile),2) as avg_female_lower
, ROUND(AVG(malelowermiddlequartile),2) as avg_male_lower_mid
, ROUND(AVG(femalelowermiddlequartile),2) as avg_female_lower_mid
, ROUND(AVG(maleuppermiddlequartile),2) as avg_male_upper_mid
, ROUND(AVG(femaleuppermiddlequartile),2) as avg_female_upper_mid
, ROUND(AVG(maletopquartile),2) as avg_male_top
, ROUND(AVG(femaletopquartile),2) as avg_female_top
FROM public.gender_pay_gap_21_22
ORDER BY 2 DESC
;


--Are there differences between the average pay gaps across different regions of the UK?
--What are some of the companies with the largest pay gaps?



--1. How many companies are in the data set?

SELECT 
--employername
COUNT (employername)
, COUNT (employerid)
, COUNT (DISTINCT(employername))
, COUNT (DISTINCT(employerid))
, COUNT (companynumber)
, COUNT (DISTINCT(companynumber))
FROM public.gender_pay_gap_21_22
--WHERE (SELECT COUNT (companynumber), employername FROM public.gender_pay_gap_21_22 GROUP BY 2) > '1'
--GROUP BY 1
--ORDER BY 6
;

--2. How many of them submitted their data after the reporting deadline?

SELECT submittedafterthedeadline
, COUNT (*)
FROM public.gender_pay_gap_21_22
GROUP BY 1;


--3. How many companies have not provided a URL?

SELECT companylinktogpginfo
, COUNT (*)
FROM public.gender_pay_gap_21_22
WHERE companylinktogpginfo = '0'
GROUP BY 1;

--4. Which measures of pay gap contain too much missing data, and should not be used in our analysis?

SELECT DISTINCT(employersize)
, COUNT(employersize)
FROM public.gender_pay_gap_21_22
GROUP BY 1;


--Let’s work out the average gender pay gap across the UK.

SELECT 
employersize
, ROUND(AVG(diffmeanhourlypercent),2) as avg_mean_hourly_perc
, ROUND(AVG(diffmedianhourlypercent),2) as avg_median_hourly_perc
, ROUND(AVG(diffmeanbonuspercent),2) as avg_mean_bonus_perc
, ROUND(AVG(diffmedianbonuspercent),2) as avg_median_bonus_perc
, ROUND(AVG(malelowerquartile),2) as avg_male_lower
, ROUND(AVG(femalelowerquartile),2) as avg_female_lower
, ROUND(AVG(malelowermiddlequartile),2) as avg_male_lower_mid
, ROUND(AVG(femalelowermiddlequartile),2) as avg_female_lower_mid
, ROUND(AVG(maleuppermiddlequartile),2) as avg_male_upper_mid
, ROUND(AVG(femaleuppermiddlequartile),2) as avg_female_upper_mid
, ROUND(AVG(maletopquartile),2) as avg_male_top
, ROUND(AVG(femaletopquartile),2) as avg_female_top
FROM public.gender_pay_gap_21_22
GROUP BY 1
;

--5. Choose which column you will use to calculate the pay gap. Will you use DiffMeanHourlyPercent or DiffMedianHourlyPercent? Can you justify your choice?

SELECT employername
, diffmeanhourlypercent
FROM public.gender_pay_gap_21_22
ORDER BY 2 desc;


--6. Use an appropriate metric to find the average gender pay gap across all the companies in the data set. 
--Did you use the mean or the median as your averaging metric? Can you justify your choice?

SELECT 
ROUND(AVG(diffmeanhourlypercent),2) as avg_mean_hourly_perc
FROM public.gender_pay_gap_21_22
;

--7. What are some caveats we need to be aware of when reporting the figure we’ve just calculated?

SELECT employername
, ROUND(MIN (diffmeanhourlypercent),2) as min_mean_hourly_perc
--, ROUND(MAX (diffmeanhourlypercent),2) as max_mean_hourly_perc
--, ROUND(MIN(diffmedianhourlypercent),2) as min_median_hourly_perc
--, ROUND(MAX(diffmedianhourlypercent),2) as max_median_hourly_perc
FROM public.gender_pay_gap_21_22
WHERE diffmeanhourlypercent = (SELECT MIN (diffmeanhourlypercent) FROM public.gender_pay_gap_21_22)
GROUP BY 1;

SELECT employername
--, ROUND(MIN (diffmeanhourlypercent),2) as min_mean_hourly_perc
, ROUND(MAX (diffmeanhourlypercent),2) as max_mean_hourly_perc
--, ROUND(MIN(diffmedianhourlypercent),2) as min_median_hourly_perc
--, ROUND(MAX(diffmedianhourlypercent),2) as max_median_hourly_perc
FROM public.gender_pay_gap_21_22
WHERE diffmeanhourlypercent = (SELECT MAX (diffmeanhourlypercent) FROM public.gender_pay_gap_21_22)
GROUP BY 1;


SELECT employername
--, ROUND(MIN (diffmeanhourlypercent),2) as min_mean_hourly_perc
--, ROUND(MAX (diffmeanhourlypercent),2) as max_mean_hourly_perc
, ROUND(MIN(diffmedianhourlypercent),2) as min_median_hourly_perc
--, ROUND(MAX(diffmedianhourlypercent),2) as max_median_hourly_perc
FROM public.gender_pay_gap_21_22
WHERE diffmeanhourlypercent = (SELECT MIN(diffmedianhourlypercent) FROM public.gender_pay_gap_21_22)
GROUP BY 1;


--Now, let’s look at some of the companies with the largest pay gaps.
--8. What are the 10 companies with the largest pay gaps skewed towards men?

SELECT *
FROM public.gender_pay_gap_21_22
ORDER BY diffmeanhourlypercent;


SELECT employername
, employersize
, ROUND(AVG(diffmeanhourlypercent),2) AS avg_mean_difference
, PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY diffmeanhourlypercent) AS median_mean_difference
, ROUND(AVG(diffmedianhourlypercent), 2) AS mean_50p_difference
, PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY diffmedianhourlypercent) AS median_50p_difference
, AVG(maletopquartile) as male_top_quartile
, AVG(femaletopquartile) as female_top_quartile
FROM
gender_pay_gap_21_22
GROUP BY 1, 2
ORDER BY 3 DESC;

--9. What do you notice about the results? Are these well-known companies?

SELECT employersize
, AVG(diffmeanhourlypercent)
, MIN(diffmeanhourlypercent)
, MAX(diffmeanhourlypercent)
FROM public.gender_pay_gap_21_22
GROUP BY 1;

SELECT employersize
, ROUND(AVG(diffmeanhourlypercent),2) AS avg_mean_difference
, PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY diffmeanhourlypercent) AS median_mean_difference
, ROUND(AVG(diffmedianhourlypercent), 2) AS mean_50p_difference
, PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY diffmedianhourlypercent) AS median_50p_difference
FROM
gender_pay_gap_21_22
GROUP BY 1;

--10. Apply some additional filtering to pick out the most significant companies with large pay gaps.

SELECT employername
, ROUND(AVG(diffmeanhourlypercent),2) AS avg_mean_difference
, PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY diffmeanhourlypercent) AS median_mean_difference
, ROUND(AVG(diffmedianhourlypercent), 2) AS mean_50p_difference
, PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY diffmedianhourlypercent) AS median_50p_difference
, AVG(maletopquartile) as male_top_quartile
, AVG(femaletopquartile) as female_top_quartile
FROM
gender_pay_gap_21_22
WHERE employersize = '20,000 or more'
GROUP BY 1
ORDER BY 2 DESC;


--11. How would you report on the results? Can we say that these companies are engaging in unlawful pay discrimination?

SELECT employersize
, ROUND(AVG(diffmeanhourlypercent),2) AS avg_mean_difference
, PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY diffmeanhourlypercent) AS median_mean_difference
, ROUND(AVG(diffmedianhourlypercent), 2) AS mean_50p_difference
, PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY diffmedianhourlypercent) AS median_50p_difference
, ROUND(AVG(malelowerquartile),2) AS avg_male_lower
, ROUND(AVG(femalelowerquartile),2) as avg_female_lower
, ROUND(AVG(malelowermiddlequartile),2) as avg_male_lower_mid
, ROUND(AVG(femalelowermiddlequartile),2) as avg_female_lower_mid
, ROUND(AVG(maleuppermiddlequartile),2) as avg_male_upper_mid
, ROUND(AVG(femaleuppermiddlequartile),2) as avg_female_upper_mid
, ROUND(AVG(maletopquartile),2) as avg_male_top
, ROUND(AVG(femaletopquartile),2) as avg_female_top
FROM public.gender_pay_gap_21_22
GROUP BY 1
ORDER BY 2;




--Let’s see if there are differences in the average pay gaps in different parts of the country.
--Think about where you might be able to find this information, since there’s no ‘city’ column in our data set.
--12. What’s the average pay gap in London versus outside London?

SELECT CASE
    WHEN address ILIKE '%London%' THEN 'London'
    ELSE 'Outside London'
    END AS london
, ROUND(AVG(diffmeanhourlypercent),2) AS avg_mean_difference
, PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY diffmeanhourlypercent) AS median_mean_difference
, ROUND(AVG(diffmedianhourlypercent), 2) AS mean_50p_difference
, PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY diffmedianhourlypercent) AS median_50p_difference
, ROUND(AVG(malelowerquartile),2) AS avg_male_lower
, ROUND(AVG(femalelowerquartile),2) as avg_female_lower
, ROUND(AVG(malelowermiddlequartile),2) as avg_male_lower_mid
, ROUND(AVG(femalelowermiddlequartile),2) as avg_female_lower_mid
, ROUND(AVG(maleuppermiddlequartile),2) as avg_male_upper_mid
, ROUND(AVG(femaleuppermiddlequartile),2) as avg_female_upper_mid
, ROUND(AVG(maletopquartile),2) as avg_male_top
, ROUND(AVG(femaletopquartile),2) as avg_female_top
FROM public.gender_pay_gap_21_22
GROUP BY 1
;



--13. What’s the average pay gap in London versus Birmingham?

SELECT CASE
    WHEN address ILIKE '%London%' THEN 'London'
    WHEN address ILIKE '%Birmingham%' THEN 'Birmingham'
    ELSE 'Outside London'
    END AS london
, ROUND(AVG(diffmeanhourlypercent),2) AS avg_mean_difference
, PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY diffmeanhourlypercent) AS median_mean_difference
, ROUND(AVG(diffmedianhourlypercent), 2) AS mean_50p_difference
, PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY diffmedianhourlypercent) AS median_50p_difference
, ROUND(AVG(malelowerquartile),2) AS avg_male_lower
, ROUND(AVG(femalelowerquartile),2) as avg_female_lower
, ROUND(AVG(malelowermiddlequartile),2) as avg_male_lower_mid
, ROUND(AVG(femalelowermiddlequartile),2) as avg_female_lower_mid
, ROUND(AVG(maleuppermiddlequartile),2) as avg_male_upper_mid
, ROUND(AVG(femaleuppermiddlequartile),2) as avg_female_upper_mid
, ROUND(AVG(maletopquartile),2) as avg_male_top
, ROUND(AVG(femaletopquartile),2) as avg_female_top
FROM public.gender_pay_gap_21_22
GROUP BY 1
;

---


SELECT 
TRIM(CASE 
        WHEN RIGHT(left(postcode, 2),1) IN ('1', '2', '3', '4', '5', '6', '7', '8' , '9') THEN left(left(postcode, 2),1)
        ELSE left(postcode, 2)
        end) as postcode_region
, ROUND(AVG(diffmeanhourlypercent),2) AS avg_mean_difference
, PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY diffmeanhourlypercent) AS median_mean_difference
, ROUND(AVG(diffmedianhourlypercent), 2) AS mean_50p_difference
, PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY diffmedianhourlypercent) AS median_50p_difference
, ROUND(AVG(malelowerquartile),2) AS avg_male_lower
, ROUND(AVG(femalelowerquartile),2) as avg_female_lower
, ROUND(AVG(malelowermiddlequartile),2) as avg_male_lower_mid
, ROUND(AVG(femalelowermiddlequartile),2) as avg_female_lower_mid
, ROUND(AVG(maleuppermiddlequartile),2) as avg_male_upper_mid
, ROUND(AVG(femaleuppermiddlequartile),2) as avg_female_upper_mid
, ROUND(AVG(maletopquartile),2) as avg_male_top
, ROUND(AVG(femaletopquartile),2) as avg_female_top
FROM public.gender_pay_gap_21_22
WHERE LEFT(postcode,2) <> '0' AND LEFT(postcode,2) <> '80'
GROUP BY 1
;



--Let’s see if there are differences in the average pay gaps across different industries.

SELECT employername
, LEFT(TRIM(REPLACE(siccodes,',','')),5) as SIC_code
, ROUND(AVG(diffmeanhourlypercent),2) AS avg_mean_difference
, PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY diffmeanhourlypercent) AS median_mean_difference
, ROUND(AVG(diffmedianhourlypercent), 2) AS mean_50p_difference
, PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY diffmedianhourlypercent) AS median_50p_difference
, ROUND(AVG(malelowerquartile),2) AS avg_male_lower
, ROUND(AVG(femalelowerquartile),2) as avg_female_lower
, ROUND(AVG(malelowermiddlequartile),2) as avg_male_lower_mid
, ROUND(AVG(femalelowermiddlequartile),2) as avg_female_lower_mid
, ROUND(AVG(maleuppermiddlequartile),2) as avg_male_upper_mid
, ROUND(AVG(femaleuppermiddlequartile),2) as avg_female_upper_mid
, ROUND(AVG(maletopquartile),2) as avg_male_top
, ROUND(AVG(femaletopquartile),2) as avg_female_top
FROM public.gender_pay_gap_21_22
WHERE LENGTH(LEFT(TRIM(REPLACE(siccodes,',','')),5)) > 4
AND employersize = '20,000 or more'
GROUP BY 1, 2
;



--Think carefully about where you might be able to find this information in your data set — there are a couple of different approaches to this task.
--14. What is the average pay gap within schools?

SELECT siccodes
, ROUND(AVG(diffmeanhourlypercent),2) AS avg_mean_difference
, PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY diffmeanhourlypercent) AS median_mean_difference
, ROUND(AVG(diffmedianhourlypercent), 2) AS mean_50p_difference
, PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY diffmedianhourlypercent) AS median_50p_difference
, ROUND(AVG(malelowerquartile),2) AS avg_male_lower
, ROUND(AVG(femalelowerquartile),2) as avg_female_lower
, ROUND(AVG(malelowermiddlequartile),2) as avg_male_lower_mid
, ROUND(AVG(femalelowermiddlequartile),2) as avg_female_lower_mid
, ROUND(AVG(maleuppermiddlequartile),2) as avg_male_upper_mid
, ROUND(AVG(femaleuppermiddlequartile),2) as avg_female_upper_mid
, ROUND(AVG(maletopquartile),2) as avg_male_top
, ROUND(AVG(femaletopquartile),2) as avg_female_top
FROM public.gender_pay_gap_21_22
WHERE siccodes IN ('85530', '85100', '85200','85310', '85320', '85410', '85421', '85422', '85510', '85520', '85590', '85600' )
GROUP BY 1
;


---


SELECT
ROUND(AVG(diffmeanhourlypercent),2) AS avg_mean_difference
, PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY diffmeanhourlypercent) AS median_mean_difference
, ROUND(AVG(diffmedianhourlypercent), 2) AS mean_50p_difference
, PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY diffmedianhourlypercent) AS median_50p_difference
, ROUND(AVG(malelowerquartile),2) AS avg_male_lower
, ROUND(AVG(femalelowerquartile),2) as avg_female_lower
, ROUND(AVG(malelowermiddlequartile),2) as avg_male_lower_mid
, ROUND(AVG(femalelowermiddlequartile),2) as avg_female_lower_mid
, ROUND(AVG(maleuppermiddlequartile),2) as avg_male_upper_mid
, ROUND(AVG(femaleuppermiddlequartile),2) as avg_female_upper_mid
, ROUND(AVG(maletopquartile),2) as avg_male_top
, ROUND(AVG(femaletopquartile),2) as avg_female_top
FROM public.gender_pay_gap_21_22
WHERE siccodes IN ('85530', '85100', '85200','85310', '85320', '85410', '85421', '85422', '85510', '85520', '85590', '85600' )
;


--15. What is the average pay gap within banks?

SELECT siccodes
, ROUND(AVG(diffmeanhourlypercent),2) AS avg_mean_difference
, PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY diffmeanhourlypercent) AS median_mean_difference
, ROUND(AVG(diffmedianhourlypercent), 2) AS mean_50p_difference
, PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY diffmedianhourlypercent) AS median_50p_difference
, ROUND(AVG(malelowerquartile),2) AS avg_male_lower
, ROUND(AVG(femalelowerquartile),2) as avg_female_lower
, ROUND(AVG(malelowermiddlequartile),2) as avg_male_lower_mid
, ROUND(AVG(femalelowermiddlequartile),2) as avg_female_lower_mid
, ROUND(AVG(maleuppermiddlequartile),2) as avg_male_upper_mid
, ROUND(AVG(femaleuppermiddlequartile),2) as avg_female_upper_mid
, ROUND(AVG(maletopquartile),2) as avg_male_top
, ROUND(AVG(femaletopquartile),2) as avg_female_top
FROM public.gender_pay_gap_21_22
WHERE siccodes IN ('64110', '64191')
GROUP BY 1
;


--16. Is there a relationship between the number of employees at a company and the average pay gap?