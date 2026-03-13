-- https://platform.stratascratch.com/coding/10352-users-by-avg-session-time

with t1 as (
    select user_id, 
        date(timestamp) as date,
        first_value(timestamp) over (partition by user_id, date(timestamp) order by timestamp desc) as tpl
    from facebook_web_log
    where action = 'page_load'
    ),
t2 as (
    select user_id,
        date(timestamp) as date,
        first_value(timestamp) over (partition by user_id, date(timestamp) order by timestamp) as tpe
    from facebook_web_log
    where action = 'page_exit'
    )
    
select user_id, avg(res)
from (
    select distinct t1.user_id, timestampdiff(second, tpl, tpe) as res
    from t1 join t2 on t1.user_id = t2.user_id and t1.date = t2.date) as t3
group by user_id;
