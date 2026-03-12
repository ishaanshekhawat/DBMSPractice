-- https://platform.stratascratch.com/coding/10547-actor-rating-difference-analysis

with t1 as (
    select distinct actor_name,
        first_value(film_rating) over (partition by actor_name order by release_date desc) as latest_rating
    from actor_rating_shift),
t2 as (
    select actor_name, avg(film_rating) as average
    from (
        select actor_name, 
            film_rating,
            row_number() over (partition by actor_name order by release_date desc) as num
        from actor_rating_shift) as t3
    where num != 1
    group by actor_name)

select t1.actor_name, 
    ifnull(average, latest_rating), 
    latest_rating,
    round(latest_rating - ifnull(average, latest_rating), 2) as rating_diff
from t1 left join t2 on t1.actor_name = t2.actor_name;
