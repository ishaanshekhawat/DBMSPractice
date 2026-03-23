-- https://platform.stratascratch.com/coding/2024-unique-users-per-client-per-month

select client_id, month(time_id), count(distinct(user_id))
from fact_events
group by client_id, month(time_id);
