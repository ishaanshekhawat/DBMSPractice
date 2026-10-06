-- https://datalemur.com/questions/uncategorized-calls-percentage

with t1 as (
  SELECT 1 as a, COUNT(*) as total FROM callers
), t2 as (
  SELECT 1 as a, COUNT(*) as uncat FROM callers WHERE call_category = 'n/a' OR call_category IS NULL 
)

SELECT ROUND((uncat*100.0/total), 1) AS uncategorised_call_pct
FROM t1 join t2 on t1.a = t2.a;
