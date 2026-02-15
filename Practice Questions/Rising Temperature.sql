-- https://leetcode.com/problems/rising-temperature/description/

select id
from (
    select id, recordDate, lag(recordDate, 1) over (order by recordDate) as prev_d, temperature, lag(temperature, 1) over (order by recordDate) as prev_t
    from Weather) as t
where temperature > prev_t and datediff(recordDate, prev_d) = 1
