-- https://datalemur.com/questions/completed-trades

SELECT u.city, SUM(t.ct) as total_orders
FROM users u
LEFT JOIN (
  SELECT user_id, count(order_id) as ct
  FROM trades
  WHERE status = 'Completed'
  GROUP BY user_id
) t ON t.user_id = u.user_id
GROUP BY u.city 
ORDER BY total_orders DESC
LIMIT 3;
