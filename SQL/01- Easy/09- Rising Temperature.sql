
-- Question :

--+---------------+---------+
--| Column Name   | Type    |
--+---------------+---------+
--| id            | int     |
--| recordDate    | date    |
--| temperature   | int     |
--+---------------+---------+
--id is the column with unique values for this table.
--There are no different rows with the same recordDate.
--This table contains information about the temperature on a certain day.
 

--Write a solution to find all dates' id with higher temperatures compared to its previous dates (yesterday).

--Return the result table in any order.

--The result format is in the following example.

 

--Example 1:

--Input: 
--Weather table:
--+----+------------+-------------+
--| id | recordDate | temperature |
--+----+------------+-------------+
--| 1  | 2015-01-01 | 10          |
--| 2  | 2015-01-02 | 25          |
--| 3  | 2015-01-03 | 20          |
--| 4  | 2015-01-04 | 30          |
--+----+------------+-------------+
--Output: 
--+----+
--| id |
--+----+
--| 2  |
--| 4  |
--+----+
--Explanation: 
--In 2015-01-02, the temperature was higher than the previous day (10 -> 25).
--In 2015-01-04, the temperature was higher than the previous day (20 -> 30).


-- Create the table
CREATE TABLE Weather (
    id INT PRIMARY KEY,
    recordDate DATE,
    temperature INT
);

-- Insert the values
INSERT INTO Weather (id, recordDate, temperature) VALUES
(1, '2015-01-01', 10),
(2, '2015-01-02', 25),
(3, '2015-01-03', 20),
(4, '2015-01-04', 30);

select * from Weather;

-- Answer :

-- 01
select t1.id
from Weather t1
inner join Weather t2
on DATEADD(day,-1, t1.recordDate ) = t2.recordDate and t1.temperature > t2.temperature

-- 02
select t1.id
from Weather t1
inner join Weather t2
on t1.recordDate = DATEADD(day, 1, t2.recordDate ) and t1.temperature > t2.temperature

-- 03
SELECT t1.id
FROM Weather t1, Weather t2
WHERE datediff(day,t1.recordDate, t2.recordDate) = -1
AND t1.temperature > t2.temperature;


-- 04 Using Lag Function.
SELECT id
from
(
SELECT 
	id,
    recordDate,
    temperature,
	-- LAG(temperature) fetches the temperature from the previous row (based on recordDate order).
    LAG(temperature) OVER (ORDER BY recordDate) AS Prev
FROM Weather
) T
where T.temperature > T.Prev