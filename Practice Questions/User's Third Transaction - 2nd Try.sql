-- https://datalemur.com/questions/sql-third-transaction

WITH t1 AS (
SELECT * , ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY transaction_date) AS num
FROM transactions
)

SELECT user_id, spend, transaction_date
FROM t1
WHERE num = 3;
