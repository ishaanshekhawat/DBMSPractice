-- https://datalemur.com/questions/sql-top-three-salaries

with t1 as (
  SELECT *, dense_rank() over (partition by department_id order by salary desc) as raank
  from employee
)

select d.department_name, t2.name, t2.salary
from department d join (
  select * 
  from t1 
  where raank <= 3
) t2
on d.department_id = t2.department_id
ORDER BY d.department_name, t2.salary DESC, t2.name;
