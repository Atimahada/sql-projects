-- 6, Identify the sport which was played in all summer olympics.
with total_summer_games as 
	(select count(*) as total from
    (select * from olympics_history
	where Season = 'Summer'
    group by Games) x),
    sport_by_games as
    (select Games, Sport 
    from olympics_history
    where Season = 'Summer'
    group by Games, Sport),
    total_sport_games as 
	(select Sport, count(1) as total_participated_games 
	from sport_by_games 
	group by Sport)
select Sport, 
tsp.total_participated_games as no_of_games, 
tsu.total as total_games from total_sport_games tsp
join total_summer_games tsu on tsp.total_participated_games = tsu.total;