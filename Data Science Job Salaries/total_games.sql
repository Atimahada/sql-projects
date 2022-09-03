-- 1, How many olympics games have been held
with total_games as
	(select *
	from olympics_history
	group by Year, Season)
select count(1) as num_of_games from total_games;