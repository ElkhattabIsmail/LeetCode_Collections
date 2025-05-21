

-- Question:


/*
+-------------+------+
| Column Name | Type |
+-------------+------+
| account_id  | int  |
| income      | int  |
+-------------+------+
account_id is the primary key (column with unique values) for this table.
Each row contains information about the monthly income for one bank account.
 

Write a solution to calculate the number of bank accounts for each salary category. The salary categories are:

'Low Salary': All the salaries strictly less than $20000.
'Average Salary': All the salaries in the inclusive range [$20000, $50000].
'High Salary': All the salaries strictly greater than $50000.
The result table must contain all three categories. If there are no accounts in a category, return 0.

Return the result table in any order.

The result format is in the following example.

 

Example 1:

Input: 
Accounts table:
+------------+--------+
| account_id | income |
+------------+--------+
| 3          | 108939 |
| 2          | 12747  |
| 8          | 87709  |
| 6          | 91796  |
+------------+--------+
Output: 
+----------------+----------------+
| category       | accounts_count |
+----------------+----------------+
| Low Salary     | 1              |
| Average Salary | 0              |
| High Salary    | 3              |
+----------------+----------------+
Explanation: 
Low Salary: Account 2.
Average Salary: No accounts.
High Salary: Accounts 3, 6, and 8.
*/


-- Solution:

-- Step 2: Insert the sample data
INSERT INTO Accounts (account_id, income) VALUES
(5, 24000)
select * from Accounts;

delete from Accounts where account_id in (4,5);


Output: 
+----------------+----------------+
| category       | accounts_count |
+----------------+----------------+
| Low Salary     | 1              |
| Average Salary | 0              |
| High Salary    | 3              |
+----------------+----------------+
--	'Low Salary': All the salaries strictly less than $20000.
--	'Average Salary': All the salaries in the inclusive range [$20000, $50000].
--	'High Salary': All the salaries strictly greater than $50000.
--	The result table must contain all three categories. If there are no accounts in a category, return 0.
--	Explanation: 
--	Low Salary: Account 2.
--	Average Salary: No accounts.
--	High Salary: Accounts 3, 6, and 8.


-- Solution:


-- 01:

SELECT 'Low Salary' as category,
count(case when income < 20000 then 1  end) 
AS accounts_count 
FROM Accounts where income < 20000

union all

SELECT 'Average Salary' as category,  
count(case when income between 20000 and 50000 then 1  end)
as accounts_count
from Accounts

union all

SELECT 'High Salary' as category, 
count(case when income > 50000 then 1 end)
as accounts_count
from Accounts 






-- 02:

SELECT
  src.category,
  COUNT(a.account_id) AS accounts_count
FROM (
  VALUES
    ('Low Salary', 0, 19999),
    ('Average Salary', 20000, 50000),
    ('High Salary', 50001, 1000000000)
) AS src (category, min_income, max_income)
LEFT JOIN Accounts a
ON a.income BETWEEN src.min_income AND src.max_income
GROUP BY src.category;