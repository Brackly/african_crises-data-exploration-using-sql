select DISTINCT country from african_crises

SELECT * FROM african_crises where country='South Africa'

SELECT DISTINCT country,year,exch_usd from african_crises

SELECT country, ((max(exch_usd))-(min(exch_usd))) diff_in_Exchange_rate from african_crises
group by country
order by max(exch_usd) desc

SELECT country,count(country) Years_in_crisis from african_crises
where systemic_crisis='1'
group by country
order by count(country)

with ct_e as (
    select ac.country,ac.year,ac.exch_usd,
    (CASE 
        WHEN ac.exch_usd>(lag(ac.exch_usd) over(order by ac.exch_usd)) 
        AND ac.country=(lag(ac.country) over(order by ac.country))
        THEN 'true'
        WHEN ac.exch_usd>(lag(ac.exch_usd) over(order by ac.exch_usd)) 
        AND ac.country !=(lag(ac.country) over(order by ac.country))
        THEN ' '
        ELSE 'false'
        END 
     ) as exch_usd_greater_than_previous_year
    from african_crises ac)

SELECT country,COUNT(*) count from ct_e
where exch_usd_greater_than_previous_year='false'
group by country
order by COUNT(*)

