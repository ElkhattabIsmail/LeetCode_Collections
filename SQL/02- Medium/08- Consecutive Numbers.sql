
-- Question:


/*
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| num         | varchar |
+-------------+---------+
In SQL, id is the primary key for this table.
id is an autoincrement column starting from 1.
 

Find all numbers that appear at least three times consecutively.

Return the result table in any order.

The result format is in the following example.

 

Example 1:

Input: 
Logs table:
+----+-----+
| id | num |
+----+-----+
| 1  | 1   |
| 2  | 1   |
| 3  | 1   |
| 4  | 2   |
| 5  | 1   |
| 6  | 2   |
| 7  | 2   |
+----+-----+
Output: 
+-----------------+
| ConsecutiveNums |
+-----------------+
| 1               |
+-----------------+
Explanation: 1 is the only number that appears consecutively for at least three times.
*/


-- Solution:


-- Approach 01
select DISTINCT l1.num as ConsecutiveNums  from Logs l1
inner join Logs l2 on l1.id = l2.id + 1 and l1.num = l2.num
inner join Logs l3 on l1.id = l3.id + 2 and l1.num = l3.num


-- Approach 02
SELECT DISTINCT num AS ConsecutiveNums
FROM (
SELECT 
num,
LAG(num, 1) OVER (ORDER BY id) AS prev1,
LAG(num, 2) OVER (ORDER BY id) AS prev2
FROM Logs
) t1
WHERE num = prev1 AND num = prev2;
