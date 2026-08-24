-- https://datalemur.com/questions/sql-page-with-no-likes

SELECT p.page_id 
FROM pages p
LEFT JOIN page_likes l on p.page_id = l.page_id
WHERE l.user_id is NULL
ORDER BY p.page_id;
