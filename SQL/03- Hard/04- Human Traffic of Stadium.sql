
/*
Table: Stadium

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| visit_date    | date    |
| people        | int     |
+---------------+---------+
visit_date is the column with unique values for this table.
Each row of this table contains the visit date and visit id to the stadium with the number of people during the visit.
As the id increases, the date increases as well.
 

Write a solution to display the records with three or more rows with consecutive id's,
and the number of people is greater than or equal to 100 for each.

Return the result table ordered by visit_date in ascending order.

The result format is in the following example.

Stadium table:
+------+------------+-----------+
| id   | visit_date | people    |
+------+------------+-----------+
| 1    | 2017-01-01 | 10        |
| 2    | 2017-01-02 | 109       |
| 3    | 2017-01-03 | 150       |
| 4    | 2017-01-04 | 99        |
| 5    | 2017-01-05 | 145       |
| 6    | 2017-01-06 | 1455      |
| 7    | 2017-01-07 | 199       |
| 8    | 2017-01-09 | 188       |
+------+------------+-----------+
Output: 
+------+------------+-----------+
| id   | visit_date | people    |
+------+------------+-----------+
| 5    | 2017-01-05 | 145       |
| 6    | 2017-01-06 | 1455      |
| 7    | 2017-01-07 | 199       |
| 8    | 2017-01-09 | 188       |
+------+------------+-----------+
Explanation: 
The four rows with ids 5, 6, 7, and 8 have consecutive ids and each of them has >= 100 people attended. Note that row 8 was included even though the visit_date was not the next day after row 7.
The rows with ids 2 and 3 are not included because we need at least three consecutive ids.
*/

-- Solutions:

-- #01
WITH Cte AS
(
	Select *,
	Lead(id, 1) OVER (ORDER BY id) AS NEXT_ID,
	Lead(id, 2) OVER (ORDER BY id) AS NEXT_2ID 
	From Stadium
	WHERE people > 99
),
T2 AS
(
	SELECT id FROM Cte
	WhERE id + 1 = NEXT_ID AND id + 2 = NEXT_2ID
)
SELECT Distinct c.id,c.visit_date,c.people
FROM Cte c Inner Join T2 t
ON c.id = t.id OR c.id = t.id + 1
OR c.id = t.id + 2


-- #02 MoreFaster and more concise
WITH C1 AS 
(
    SELECT *, id - ROW_NUMBER() OVER(ORDER BY visit_date) AS Grp
    FROM Stadium
    WHERE people >= 100
)

SELECT id, visit_date, people
FROM C1
WHERE Grp IN 
(
    SELECT Grp
    FROM C1
    GROUP BY Grp
    HAVING COUNT(Grp) >= 3
)