-- https://datalemur.com/questions/yoy-growth-rate

with t1 as (
  SELECT product_id, extract(year from transaction_date) as yr, sum(spend) as total_spend
  FROM user_transactions
  GROUP BY product_id, extract(year from transaction_date)
)

select *, round((curr_year_spend - prev_year_spend)*100/prev_year_spend, 2) as yoy_rate
from (
  select yr as year, product_id, total_spend as curr_year_spend, lag(total_spend) over (partition by product_id order by yr) as prev_year_spend
  from t1
) t;
