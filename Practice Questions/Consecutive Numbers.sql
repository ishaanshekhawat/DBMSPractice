-- https://leetcode.com/problems/consecutive-numbers/

select distinct(num) as ConsecutiveNums
from (
    select num, lead(num, 1) over () as next_1, lead(num, 2) over () as next_2
    from Logs) as t1
where num = next_1 and next_1 = next_2
