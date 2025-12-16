-- https://datalemur.com/questions/sql-third-transaction

with ranked_transactions as (
  select *, 
  row_number() over (partition by user_id order by transaction_date) as trans_no
  from transactions)
  
select user_id,	spend, transaction_date
from ranked_transactions
where trans_no = 3
