-- https://datalemur.com/questions/top-profitable-drugs

SELECT drug, sum(total_sales - cogs) as profit
FROM pharmacy_sales
GROUP BY drug
ORDER BY profit DESC
LIMIT 3;
