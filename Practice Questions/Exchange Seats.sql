-- https://leetcode.com/problems/exchange-seats/description/

-- Outer query to select the final result
SELECT 
    -- Using CASE to check if 'num' is the last row, and adjust accordingly
    CASE 
        -- If 'num' is equal to the last row number (count of rows + 1)
        WHEN num = (SELECT count(*) + 1 FROM Seat) 
            THEN num - 1  -- Subtract 1 to get the correct row number
        ELSE 
            num  -- Otherwise, keep the original row number
    END AS id,  -- Final 'id' column after adjustment
    student  -- Student information

FROM 
    (
    -- First part of the UNION: select even 'id' rows and adjust the 'id' by subtracting 1
    (
        SELECT student, id - 1 AS num  -- Decrease 'id' by 1 for even 'id' values
        FROM Seat
        WHERE id % 2 = 0  -- Select rows where 'id' is even
        ORDER BY id  -- Order by original 'id' value
    )
    UNION  -- Combine with the second part of the UNION

    -- Second part of the UNION: select odd 'id' rows and adjust the 'id' by adding 1
    (
        SELECT student, id + 1 AS num  -- Increase 'id' by 1 for odd 'id' values
        FROM Seat
        WHERE id % 2 != 0  -- Select rows where 'id' is odd
    )
    )
AS table1  -- Give the combined result of the two queries an alias 'table1'

-- Final ordering by 'num' to ensure rows are sorted correctly
ORDER BY num;
