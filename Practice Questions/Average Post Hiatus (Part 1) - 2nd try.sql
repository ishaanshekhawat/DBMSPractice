select user_id, TIMESTAMPDIFF(day, min_date, max_date) as days_between
from (
  select user_id, min(date(post_date)) as min_date, max(date(post_date)) as max_date
  from posts
  where year(post_date) = 2021
  group by user_id
) as table1
where datediff(max_date, min_date) > 0
