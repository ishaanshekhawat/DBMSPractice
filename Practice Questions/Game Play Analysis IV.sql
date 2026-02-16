-- https://leetcode.com/problems/game-play-analysis-iv/

select round(count(distinct player_id)/(select count(distinct player_id) from Activity),2) as fraction
from (
    select player_id, event_date, first_value(event_date) over (partition by player_id order by event_date) as first
    from Activity) as t1
where datediff(event_date, first) = 1
