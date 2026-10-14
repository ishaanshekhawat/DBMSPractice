-- https://datalemur.com/questions/user-retention

with t1 as (
  SELECT *, lag(event_date, 1) over (partition by user_id order by event_date) as prev
  FROM user_actions
)

select 7 as month, count(*) as monthly_active_users
from t1
WHERE EXTRACT(MONTH FROM event_date) = 7 
  AND EXTRACT(MONTH FROM prev) = 6;
