-- Write a solution to find the people who have the most friends and the most friends number.
-- The test cases are generated so that only one person has the most friends.
-- The result format is in the following example.

-- Example 1:
-- Input: 
-- RequestAccepted table:
-- +--------------+-------------+-------------+
-- | requester_id | accepter_id | accept_date |
-- +--------------+-------------+-------------+
-- | 1            | 2           | 2016/06/03  |
-- | 1            | 3           | 2016/06/08  |
-- | 2            | 3           | 2016/06/08  |
-- | 3            | 4           | 2016/06/09  |
-- +--------------+-------------+-------------+
-- Output: 
-- +----+-----+
-- | id | num |
-- +----+-----+
-- | 3  | 3   |
-- +----+-----+
-- Explanation: 
-- The person with id 3 is a friend of people 1, 2, and 4, so he has three friends in total, which is the most number than any others.

SELECT CASE
WHEN big.accepter_id IS NULL THEN big.requester_id
ELSE big.accepter_id
END AS id, 
IFNULL(big.num1,0) + IFNULL(big.num2,0) AS num
FROM (
    SELECT *
    FROM (
        SELECT requester_id, COUNT(accepter_id) as num1
        FROM RequestAccepted
        GROUP BY requester_id
    ) AS a LEFT JOIN (
        SELECT accepter_id, COUNT(requester_id) as num2
        FROM RequestAccepted
        GROUP BY accepter_id
    ) AS b ON a.requester_id = b.accepter_id
    UNION
    SELECT *
    FROM (
        SELECT requester_id, COUNT(accepter_id) as num1
        FROM RequestAccepted
        GROUP BY requester_id
    ) AS a RIGHT JOIN (
        SELECT accepter_id, COUNT(requester_id) as num2
        FROM RequestAccepted
        GROUP BY accepter_id
) AS b ON a.requester_id = b.accepter_id) AS big
ORDER BY num DESC
LIMIT 1;
