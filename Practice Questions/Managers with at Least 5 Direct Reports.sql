-- https://leetcode.com/problems/managers-with-at-least-5-direct-reports/description/

select name
from Employee
where id IN (
    select managerId
    from Employee
    group by managerId
    having count(managerId) >= 5)
