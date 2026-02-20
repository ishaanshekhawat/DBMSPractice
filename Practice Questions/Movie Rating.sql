# https://leetcode.com/problems/movie-rating/description/

with t1 as (
    select name, rank() over (order by num1 desc, name) as ranking1
    from (
        select name, count(movie_id) as num1
        from MovieRating mr join Users u on mr.user_id = u.user_id
        group by u.user_id) as t
        ),
t2 as (
    select title, rank() over (order by num2 desc, title) as ranking2
    from (
        select title, avg(rating) as num2
        from MovieRating mr join Movies m on mr.movie_id = m.movie_id
        where mr.created_at between '2020-02-01' and '2020-02-29'
        group by m.movie_id) as t
        )


select name as results from t1 where ranking1 = 1
union all
select title as results from t2 where ranking2 = 1
