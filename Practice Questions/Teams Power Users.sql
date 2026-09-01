-- https://datalemur.com/questions/teams-power-users

SELECT sender_id, count(message_id) as message_count
FROM messages
WHERE DATE(sent_date) >= '2022-08-01'
  AND DATE(sent_date) <= '2022-08-31'
GROUP BY sender_id
ORDER BY message_count desc
LIMIT 2;
