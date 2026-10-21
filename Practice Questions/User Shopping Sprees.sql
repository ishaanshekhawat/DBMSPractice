-- https://datalemur.com/questions/amazon-shopping-spree

with t1 as (
  SELECT user_id, transaction_date, lag(transaction_date, 2) over (partition by user_id) as ck
  FROM transactions
)

select distinct user_id
from t1
where date(transaction_date) - 2 = date(ck);
