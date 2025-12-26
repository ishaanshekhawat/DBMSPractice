-- https://leetcode.com/problems/employees-with-missing-information/?envType=problem-list-v2&envId=nzyn58bm

WITH main AS (
    (select employee_id
    from Employees)
    UNION
    (select employee_id
    from Salaries)
)

select employee_id
from main
WHERE employee_id NOT IN (
    select e.employee_id
    from Employees e inner join Salaries s on e.employee_id = s.employee_id)
order by employee_id
