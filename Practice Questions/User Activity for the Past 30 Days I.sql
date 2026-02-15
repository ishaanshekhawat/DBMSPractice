-- https://leetcode.com/problems/user-activity-for-the-past-30-days-i/description/

select activity_date as day, count(distinct user_id) as active_users
from Activity
where activity_date between '2019-06-28' AND '2019-07-27'
group by activity_date
having count(distinct user_id) > 0
