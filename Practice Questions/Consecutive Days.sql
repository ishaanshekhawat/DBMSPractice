-- https://platform.stratascratch.com/coding/2054-consecutive-days

select user_id
from (
    select user_id, 
        lag(record_date, 1) over (partition by user_id order by record_date) as prev,
        record_date,
        lead(record_date, 1) over (partition by user_id order by record_date) as next
    from sf_events) as t1
where datediff(record_date, prev) = 1 and datediff(next, record_date) = 1
group by user_id;
