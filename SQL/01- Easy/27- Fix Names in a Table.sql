

-- Question:


/*
+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| user_id        | int     |
| name           | varchar |
+----------------+---------+
user_id is the primary key (column with unique values) for this table.
This table contains the ID and the name of the user. The name consists of only lowercase and uppercase characters.
 

Write a solution to fix the names so that only the first character is uppercase and the rest are lowercase.

Return the result table ordered by user_id.

The result format is in the following example.

 

Example 1:

Input: 
Users table:
+---------+-------+
| user_id | name  |
+---------+-------+
| 1       | aLice |
| 2       | bOB   |
+---------+-------+
Output: 
+---------+-------+
| user_id | name  |
+---------+-------+
| 1       | Alice |
| 2       | Bob   |
+---------+-------+
*/


-- Solution:

Select user_id, 
UPPER(LEFT(name, 1)) +
LOWER(SUBSTRING(name, 2, LEN(name))) as name 
From Users Order By user_id;

--- Using Stuff Func :

Select
STUFF(name, 1, LEN(name), UPPER(LEFT(name, 1))
+ LOWER(RIGHT(name, LEN(name) - 1 ))) as name
from Users





