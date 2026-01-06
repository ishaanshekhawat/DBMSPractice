-- https://datalemur.com/questions/laptop-mobile-viewership

select
(select COUNT(user_id) from viewership where device_type = 'laptop') as laptop_views,
(select COUNT(user_id) from viewership where device_type IN ('tablet', 'phone')) as mobile_views
