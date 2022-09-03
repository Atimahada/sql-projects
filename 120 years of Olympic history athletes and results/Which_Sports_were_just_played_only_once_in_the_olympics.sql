-- 7, Which Sports were just played only once in the olympics?
with sport_by_games as
    (select Games, Sport 
    from olympics_history
    group by Games, Sport),
    total_sport_games as 
	(select Sport, count(1) as total_participated_games 
	from sport_by_games 
	group by Sport)
select tsp.Sport, 
		total_participated_games,
        sbg.Games
from total_sport_games tsp 
join sport_by_games sbg on tsp.Sport = sbg.Sport
where tsp.total_participated_games = 1
order by 1;