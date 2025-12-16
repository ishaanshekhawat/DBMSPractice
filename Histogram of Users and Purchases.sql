-- https://datalemur.com/questions/histogram-users-purchases

-- Select the transaction date, user ID, and count of transactions
-- for each user on their most recent transaction date
SELECT transaction_date, user_id, COUNT(user_id) AS purchase_count
FROM user_transactions AS u1

-- Filter rows to only those that match the user's latest transaction date
WHERE transaction_date = (
    -- Subquery finds the maximum (most recent) transaction date
    -- for the current user
    SELECT MAX(transaction_date)
    FROM user_transactions AS u2
    WHERE u1.user_id = u2.user_id
    GROUP BY u2.user_id
)

-- Group results by user ID
GROUP BY user_id;
