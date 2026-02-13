-- https://leetcode.com/problems/department-top-three-salaries/description/

with table1 as (select d.name as Department, e.name as Employee, e.salary as Salary, dense_rank() over (partition by e.departmentId order by e.salary desc) as ranking
from department d join Employee e on d.id = e.departmentId)

select Department, Employee, Salary
from table1
where ranking <= 3;
