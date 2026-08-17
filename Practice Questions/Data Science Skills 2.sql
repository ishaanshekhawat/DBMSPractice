-- SELECT candidate_id
-- FROM candidates
-- WHERE candidate_id IN (
--   SELECT candidate_id
--   FROM candidates
--   WHERE candidate_id IN (
--     SELECT candidate_id 
--     FROM candidates
--     WHERE skill = 'Python') 
--     AND skill = 'Tableau'
-- ) AND skill = 'PostgreSQL'
-- ORDER BY candidate_id;


-- SELECT candidate_id
-- FROM candidates
-- WHERE skill in ('Python', 'Tableau', 'PostgreSQL')
-- GROUP BY candidate_id
-- HAVING  COUNT(DISTINCT skill) = 3
-- ORDER BY candidate_id;

SELECT candidate_id FROM candidates WHERE skill = 'Python'
INTERSECT
SELECT candidate_id FROM candidates WHERE skill = 'Tableau'
INTERSECT
SELECT candidate_id FROM candidates WHERE skill = 'PostgreSQL';
