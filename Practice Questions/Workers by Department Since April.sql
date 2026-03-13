-- https://platform.stratascratch.com/coding/9847-find-the-number-of-workers-by-department

select department, count(worker_id) as ct 
from worker
where joining_date >= '2014-04-01'
group by department
order by ct desc;
