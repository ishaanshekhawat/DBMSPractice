-- https://datalemur.com/questions/second-day-confirmation

SELECT user_id
FROM emails e
LEFT JOIN texts t 
ON e.email_id = t.email_id
WHERE TIMESTAMPDIFF(day, signup_date, action_date) = 1;
