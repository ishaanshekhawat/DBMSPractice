# https://leetcode.com/problems/find-churn-risk-customers/

with table1 as 
(select user_id, plan_name, monthly_amount, row_number() over (partition by user_id order by event_date) as plan_no, max(monthly_amount) over (partition by user_id) as max_historical_amount
from subscription_events),
table2 as 
(select user_id, datediff(max(event_date), min(event_date)) as days_as_subscriber
from subscription_events
group by user_id)

select t1.user_id, plan_name as current_plan, monthly_amount as current_monthly_amount, max_historical_amount, days_as_subscriber
from table1 as t1 left join table2 on t1.user_id = table2.user_id
where plan_no = (
    select max(plan_no)
    from table1 as t2
    where t1.user_id = t2.user_id
    group by t2.user_id
) 
and plan_name is not null 
and monthly_amount < 0.5 * max_historical_amount
and days_as_subscriber >= 60
order by days_as_subscriber desc, user_id
