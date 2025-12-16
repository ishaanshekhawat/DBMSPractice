-- https://datalemur.com/questions/sql-highest-grossing

WITH table1 as (
  SELECT *, 
  SUM(spend) OVER (Partition by product) as total_spend
  FROM product_spend
  WHERE YEAR(transaction_date) = 2022
),
table2 as (
  SELECT *, 
  RANK() OVER (Partition by category order by total_spend desc) as ranking
  FROM table1
  GROUP BY category, product
)

select category, product, total_spend
from table2
where ranking <=2
