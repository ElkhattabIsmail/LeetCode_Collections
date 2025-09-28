

-- Question:


/*
Second Highest Salary

+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |
| salary      | int  |
+-------------+------+
id is the primary key (column with unique values) for this table.
Each row of this table contains information about the salary of an employee.
 

Write a solution to find the second highest distinct salary from the Employee table. If there is no second highest salary, return null (return None in Pandas).

The result format is in the following example.

 

Example 1:

Input: 
Employee table:
+----+--------+
| id | salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+
Output: 
+---------------------+
| SecondHighestSalary |
+---------------------+
| 200                 |
+---------------------+
Example 2:

Input: 
Employee table:
+----+--------+
| id | salary |
+----+--------+
| 1  | 100    |
+----+--------+
Output: 
+---------------------+
| SecondHighestSalary |
+---------------------+
| null                |
+---------------------+
*/


-- Solution:

-- 01
With TopTwoSalaries AS
( 
	select Distinct Top 2 salary
	from Employee99
	Order By salary Desc
)
select min( salary) As SecondHighestSalary From TopTwoSalaries
Where (Select Count(salary) As cnt from TopTwoSalaries ) > 1

-- 02
select
ISNULL(
(
SELECT DISTINCT Salary
FROM Employee99
ORDER BY Salary DESC
OFFSET 1 ROW FETCH NEXT 1 ROW ONLY), NULL        
)
AS SecondHighestSalary;