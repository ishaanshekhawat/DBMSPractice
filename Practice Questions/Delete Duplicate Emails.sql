-- https://leetcode.com/problems/delete-duplicate-emails/

-- Delete duplicate records from the Person table
DELETE FROM Person
WHERE id NOT IN (
    -- Keep only the first record (lowest id) for each email
    SELECT id
    FROM (
        -- Assign a row number to each row within the same email group
        -- Rows are ordered by id so the smallest id gets num = 1
        SELECT *,
               ROW_NUMBER() OVER (PARTITION BY email ORDER BY id) AS num
        FROM Person
    ) AS table1
    -- Select only the first occurrence of each email
    WHERE num = 1
);
