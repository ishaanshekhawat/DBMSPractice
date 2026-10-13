-- https://datalemur.com/questions/histogram-users-purchases

select t1.transaction_date, t1.user_id, count(product_id) as purchase_count
from user_transactions t1
where transaction_date = (
  SELECT max(transaction_date) as transaction_date
  FROM user_transactions t2
  WHERE t1.user_id = t2.user_id
  GROUP BY user_id
)
group by  t1.transaction_date, user_id;
