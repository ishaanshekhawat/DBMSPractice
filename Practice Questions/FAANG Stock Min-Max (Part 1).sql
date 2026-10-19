-- https://datalemur.com/questions/sql-bloomberg-stock-min-max-1

with t1 as (
SELECT distinct ticker, 
--  to_char(max(date) over (partition by ticker), 'Mon-YYYY') as highest_mth,
  max(open) over (PARTITION by ticker) as highest_open,
--  to_char(min(date) over (partition by ticker), 'Mon-YYYY') as lowest_mth,
  min(open) over (PARTITION by ticker) as lowest_open
FROM stock_prices
), t2 as(
SELECT t1.*, 
  to_char(date, 'Mon-YYYY') as highest_mth 
FROM stock_prices s join t1 on s.ticker = t1.ticker and s.open = t1.highest_open
)

select t2.ticker, 
  t2.highest_mth, 
  t2.highest_open, 
  to_char(date, 'Mon-YYYY') as lowest_mth,
  t2.lowest_open
FROM stock_prices s join t2 on s.ticker = t2.ticker and s.open = t2.lowest_open
order by ticker;
