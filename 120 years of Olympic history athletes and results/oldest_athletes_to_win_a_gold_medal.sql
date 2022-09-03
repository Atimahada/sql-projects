-- 9, Fetch details of the oldest athletes to win a gold medal.
with gold_medalist as 
	(select * 
	from olympics_history where Medal = 'Gold'and not Age = 0),
    max_age_gold_medalist as
	(select max(Age) as Age from gold_medalist)
select Id, Name, Sex, gm.Age, Team, Sport, Event, Medal
from gold_medalist gm
join max_age_gold_medalist ma_gm on gm.Age = ma_gm.Age;