-- 8, Fetch the total no of sports played in each olympic games.
with sport_by_games as
    (select Games, Sport 
    from olympics_history
    group by Games, Sport)
select Games, count(1) as total_sports
from sport_by_games
group by Games;