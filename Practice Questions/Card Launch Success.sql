# https://datalemur.com/questions/card-launch-success

WITH t1 AS (
  SELECT *, ROW_NUMBER() OVER (PARTITION BY card_name ORDER BY issue_year, issue_month) AS row_num
  FROM monthly_cards_issued)

SELECT card_name, issued_amount
FROM t1
WHERE row_num = 1
ORDER BY issued_amount DESC;
