-- https://leetcode.com/problems/department-highest-salary/

select Department, Employee, Salary
from (
    select d.name as Department, e.name as Employee, e.salary as Salary, dense_rank() over (partition by d.id order by salary desc) as ranking
    from Employee e join Department d on e.departmentId = d.id) as table1
where ranking = 1;
