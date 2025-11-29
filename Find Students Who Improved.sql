-- Write a solution to find the students who have shown improvement. A student is considered to have shown improvement if they meet both of these conditions:
-- Have taken exams in the same subject on at least two different dates
-- Their latest score in that subject is higher than their first score
-- Return the result table ordered by student_id, subject in ascending order.
-- The result format is in the following example.

-- Example:
-- Input:
-- Scores table:
-- +------------+----------+-------+------------+
-- | student_id | subject  | score | exam_date  |
-- +------------+----------+-------+------------+
-- | 101        | Math     | 70    | 2023-01-15 |
-- | 101        | Math     | 85    | 2023-02-15 |
-- | 101        | Physics  | 65    | 2023-01-15 |
-- | 101        | Physics  | 60    | 2023-02-15 |
-- | 102        | Math     | 80    | 2023-01-15 |
-- | 102        | Math     | 85    | 2023-02-15 |
-- | 103        | Math     | 90    | 2023-01-15 |
-- | 104        | Physics  | 75    | 2023-01-15 |
-- | 104        | Physics  | 85    | 2023-02-15 |
-- +------------+----------+-------+------------+
-- Output:
-- +------------+----------+-------------+--------------+
-- | student_id | subject  | first_score | latest_score |
-- +------------+----------+-------------+--------------+
-- | 101        | Math     | 70          | 85           |
-- | 102        | Math     | 80          | 85           |
-- | 104        | Physics  | 75          | 85           |
-- +------------+----------+-------------+--------------+
-- Explanation:
-- Student 101 in Math: Improved from 70 to 85
-- Student 101 in Physics: No improvement (dropped from 65 to 60)
-- Student 102 in Math: Improved from 80 to 85
-- Student 103 in Math: Only one exam, not eligible
-- Student 104 in Physics: Improved from 75 to 85
-- Result table is ordered by student_id, subject.

-- Select the student ID, subject, first exam score, and latest exam score for students
select table1.student_id, 
       table1.subject, 
       table1.first_score,   -- first exam score
       table2.score as latest_score  -- latest exam score (most recent)
from
    (
        -- Subquery to get the first exam score for each student in each subject
        select student_id, 
               subject, 
               score as first_score
        from (
            -- Assign row numbers to each exam by student and subject, ordered by exam date (ascending)
            select student_id, 
                   subject, 
                   score, 
                   row_number() over (partition by student_id, subject order by exam_date) as testno
            from Scores
        ) as main_table1
        -- Filter to select only the first exam (testno = 1)
        where testno = 1
    ) as table1

-- Join with the second subquery to get the latest exam score
inner join
    (
        -- Subquery to get the latest exam score for each student in each subject
        select student_id, 
               subject, 
               score
        from (
            -- Assign row numbers to each exam by student and subject, ordered by exam date (descending)
            select student_id, 
                   subject, 
                   score, 
                   row_number() over (partition by student_id, subject order by exam_date desc) as testno
            from Scores
        ) as main_table2
        -- Filter to select only the most recent exam (testno = 1)
        where testno = 1
    ) as table2

-- Match records where student_id and subject are the same in both subqueries
on table1.student_id = table2.student_id 
and table1.subject = table2.subject

-- Only include results where the first exam score is less than the latest exam score
where table1.first_score < table2.score;
