CREATE DATABASE IF NOT EXISTS codex;

USE codex;

select * from dim_cities;

select * from dim_repondents;

select * from fact_survey_responses;

# 1) Who prefers energy drink more?
SELECT     Gender, 
		   Count(*) AS Count
FROM       dim_repondents
GROUP BY   Gender
ORDER BY   Count DESC;


# 2) Which age group prefers energy drink more?
SELECT 		Age, 
			Count(*) AS Count 
FROM 		dim_repondents
GROUP BY 	Age
ORDER BY	Count DESC;


# 3) Which type of marketing reaches the most audience ?
SELECT		Marketing_Channels,
			count(*) AS count
FROM 		fact_survey_responses
GROUP BY    Marketing_Channels
ORDER BY    count Desc;

# 4) Which type of marketing reaches the most youth (15-30) ?
SELECT 		r.Age, 
			s.Marketing_Channels, 
			count(*) AS count
FROM 		dim_repondents AS r 
INNER JOIN 	fact_survey_responses AS s
ON 		   	r.Respondent_ID = s.Respondent_ID
GROUP BY  	r.Age, 
			s.Marketing_Channels
ORDER BY  	r.Age, 
			count DESC;
            
            
# 5) What are the preffered ingredients of energy drinks among respodents?
SELECT      Ingredients_expected, 
			count(*)  AS Count
FROM        fact_survey_responses
GROUP BY	Ingredients_expected
ORDER BY	Count DESC;

# 6) What packaging preferences do respondents have for energy drinks?
SELECT      Packaging_preference, 
			count(*)  AS Count
FROM        fact_survey_responses
GROUP BY	Packaging_preference
ORDER BY	Count DESC;

# 7) Who are the current market leaders?
SELECT 		Current_brands,
			count(*) as Count
FROM    	fact_survey_responses   
GROUP BY 	Current_brands
ORDER BY	Count DESC;

# 8) What are the primary reasons consumers prefer those brands over ours?
SELECT 		Reasons_for_choosing_brands,
			count(*) as Count
FROM    	fact_survey_responses  
GROUP BY 	Reasons_for_choosing_brands
ORDER BY	Count DESC;

# 9) What do people think about our brand? (overall rating)
select 		Tried_before, 
			count(*) 
from 		fact_survey_responses
GROUP BY 	Tried_before;

select 		CASE 
			WHEN Taste_experience = 1 THEN 'Poor'
            WHEN Taste_experience = 2 THEN 'Below Average'
            WHEN Taste_experience = 3 THEN 'Average'
            WHEN Taste_experience = 4 THEN 'Good'
            WHEN Taste_experience = 5 THEN 'Excellent'
            END AS Taste_experience, 
			count(*) AS COUNT
from 		fact_survey_responses
WHERE 		Tried_before = "Yes"
GROUP BY 	Taste_experience
ORDER BY 	COUNT DESC;



# Overall Average			
SELECT		AVG(Taste_experience) AS Average_Rating
FROM 		fact_survey_responses
WHERE 		Tried_before = "Yes";

# Which cities do we need to focus more on?
SELECT 		c.City, 
			COUNT(*) AS Count
FROM 		dim_repondents AS r
LEFT JOIN 	dim_cities AS c
ON          r.City_ID = c.City_ID
GROUP BY 	c.City
ORDER BY 	Count;

# Where do respondents prefer to purchase energy drinks?
SELECT 		Purchase_location,
			COUNT(*) AS Count
FROM 		fact_survey_responses
GROUP BY	Purchase_location
ORDER BY	Count DESC;

# What are the typical consumption situations for energy drinks among respondents?
SELECT 		Typical_consumption_situations,
			COUNT(*) AS Count
FROM 		fact_survey_responses
GROUP BY	Typical_consumption_situations
ORDER BY	Count DESC;


# What factors influence respondents' purchase decisions, such as price range and limited edition packaging?
SELECT 		Limited_edition_packaging, 
			COUNT(*) AS COUNT
FROM		fact_survey_responses
GROUP BY 	Limited_edition_packaging
ORDER BY	COUNT DESC;

SELECT 		Price_range, 
			COUNT(*) AS COUNT
FROM		fact_survey_responses
GROUP BY 	Price_range
ORDER BY	COUNT DESC;

# Which area of business should we focus more on our product development? (Branding/taste/availability)
SELECT      Heard_before, 
			COUNT(*) AS COUNT
FROM 		fact_survey_responses
GROUP BY 	Heard_before
ORDER BY	COUNT DESC;

SELECT Brand_perception, COUNT(*) AS COUNT
FROM 		fact_survey_responses
GROUP BY 	Brand_perception
ORDER BY	COUNT DESC;


# Reasons preventing from trying Codex
SELECT  	Reasons_preventing_trying, COUNT(*) AS COUNT
FROM 		fact_survey_responses
WHERE 		Tried_before = "No"
GROUP BY 	Reasons_preventing_trying
ORDER BY	COUNT DESC;


SELECT 		Tried_before, COUNT(*) AS COUNT
FROM		fact_survey_responses
GROUP BY	Tried_before
ORDER BY	COUNT DESC;

SELECT 		Improvements_desired, COUNT(*) AS COUNT
FROM		fact_survey_responses
GROUP BY	Improvements_desired
ORDER BY	COUNT DESC;

SELECT 		Interest_in_natural_or_organic, COUNT(*) AS COUNT
FROM		fact_survey_responses
GROUP BY	Interest_in_natural_or_organic
ORDER BY	COUNT DESC;