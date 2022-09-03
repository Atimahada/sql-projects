-- 2, List down all Olympics games held so far
with total_games as
	(select *
	from olympics_history
	group by Year, Season)
select Year, Season, City from total_games
order by Year;