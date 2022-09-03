-- 4, Which year saw the highest and lowest no of countries participating in olympics?
with games_by_year as 
	(select oh.*, region, notes
	from olympics_history oh 
	join olympics_history_noc_regions ohr on oh.NOC = ohr.noc
	group by Year, oh.NOC
	order by Year),
	games_by_year2 as 
	(select Year, count(*) as nations
	from games_by_year
	group by Year),
    countries_max(max) as 
	(select 
	concat(Year,'-',nations)
    from games_by_year2
	where nations = (select max(nations)
					from games_by_year2)),
	countries_min(min) as 
	(select 
	concat(Year,'-',nations)
    from games_by_year2
	where nations = (select min(nations)
					from games_by_year2))
select c_max.max as highest_country,
c_min.min as lowest_country
from countries_max c_max
cross join countries_min c_min;