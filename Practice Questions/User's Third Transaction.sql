-- https://datalemur.com/questions/sql-third-transaction

with ranked as 
  (
  select *, row_number() over (partition by user_id order by transaction_date) as num
  from transactions)

select user_id, spend, transaction_date
from ranked
where num = 3;
