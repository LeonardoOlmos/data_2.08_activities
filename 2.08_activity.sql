-- Leonardo Olmos Saucedo / Activity 2.08
USE bank;

/*In this activity, we will be using the table district from the bank database and according to the description for the different columns:
A4: no. of inhabitants
A9: no. of cities
A10: the ratio of urban inhabitants
A11: average salary
A12: the unemployment rate
*/

-- 1. Rank districts by different variables.
SELECT *,
       RANK() OVER (ORDER BY d.A2) AS my_rank
  FROM district d
  ORDER BY d.A2;

-- 2. Do the same but group by region.
SELECT d.A3,
       RANK() OVER (ORDER BY d.A3) AS my_rank
  FROM district d
  GROUP BY d.A3;
  
-- 3. Use the transactions table in the bank database to find the Top 20 account_ids based on the amount.
SELECT DISTINCT(t.account_id), amount
FROM trans t
ORDER BY amount DESC
LIMIT 20;

-- 4. Illustrate the difference between rank() and dense_rank().
SELECT *,
       RANK() OVER (ORDER BY d.A3) AS my_rank
  FROM district d
  ORDER BY my_rank;
  
SELECT *,
       DENSE_RANK() OVER (ORDER BY d.A3) AS my_rank
  FROM district d
  ORDER BY my_rank;
  
-- 5. Get a rank of districts ordered by the number of customers.
SELECT d.A2, COUNT(*) AS total_customers, RANK() OVER (ORDER BY A2) AS `rank`
FROM client c
JOIN district d 
ON d.A1 = c.district_id
GROUP BY d.A2
ORDER BY 1;

-- 6. Get a rank of regions ordered by the number of customers.
SELECT d.A3, COUNT(*) AS total_customers, RANK() OVER (ORDER BY A3) AS `rank`
FROM client c
JOIN district d 
ON d.A1 = c.district_id
GROUP BY d.A3
ORDER BY 1;

-- 7. Get the total amount borrowed by the district together with the average loan in that district.
SELECT a.district_id, SUM(l.amount) AS total_borrowed, ROUND(AVG(l.amount),2) AS avg_loan
FROM loan l
JOIN account a
ON a.account_id = l.account_id
GROUP BY a.district_id
ORDER BY 1;

-- 8. Get the number of accounts opened by district and year.
SELECT a.district_id, LEFT(a.date, 2) AS `year`, COUNT(*) AS total_accounts
FROM account a 
GROUP BY district_id, LEFT(a.date, 2)
ORDER BY 1, 2;

  