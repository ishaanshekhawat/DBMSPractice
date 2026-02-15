-- https://leetcode.com/problems/human-traffic-of-stadium/

select id, visit_date, people
from (
    select id, visit_date, people, lead(people,1) over () as next_1, lead(people,2) over () as next_2, lag(people,1) over () as prev_1, lag(people,2) over () as prev_2
    from Stadium) as t
where people >= 100 and ((next_1 >= 100 and next_2 >= 100) or (prev_1 >= 100 and prev_2 >= 100) or (prev_1 >= 100 and next_1 >= 100))
