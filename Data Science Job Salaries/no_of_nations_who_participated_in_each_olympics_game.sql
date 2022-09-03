-- 3, Mention the total no of nations who participated in each olympics game?
with games_by_nation as
	(select oh.*, region, notes
	from olympics_history oh 
	join olympics_history_noc_regions ohr on oh.NOC = ohr.noc
	group by Games, oh.NOC
	order by Games)
select Games, count(*) as total_nations
from games_by_nation
group by Games;