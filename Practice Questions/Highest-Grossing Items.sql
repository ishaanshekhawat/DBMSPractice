-- https://datalemur.com/questions/sql-highest-grossing

with table1 as
(select category, product, total_spend, 
  row_number() over (partition by category order by total_spend desc) as top2
from  
  (select category, product, sum(spend) as total_spend
  from product_spend
  where year(transaction_date) = 2022
  group by category, product) as temp
)

select category, product, total_spend
from table1
where top2 <= 2;
