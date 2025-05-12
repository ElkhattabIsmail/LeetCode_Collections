

-- Question:


+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| player_id    | int     |
| device_id    | int     |
| event_date   | date    |
| games_played | int     |
+--------------+---------+
(player_id, event_date) is the primary key (combination of columns with unique values) of this table.
This table shows the activity of players of some games.
Each row is a record of a player who logged in and played a number of games (possibly 0) before logging out on someday using some device.
 

Write a solution to report the fraction of players that logged in again on the day after the day they first logged in, rounded to 2 decimal places. In other words, you need to count the number of players that logged in for at least two consecutive days starting from their first login date, then divide that number by the total number of players.

The result format is in the following example.

 

Example 1:

Input: 
Activity table:
+-----------+-----------+------------+--------------+
| player_id | device_id | event_date | games_played |
+-----------+-----------+------------+--------------+
| 1         | 2         | 2016-03-01 | 5            |
| 1         | 2         | 2016-03-02 | 6            |
| 2         | 3         | 2017-06-25 | 1            |
| 3         | 1         | 2016-03-02 | 0            |
| 3         | 4         | 2018-07-03 | 5            |
+-----------+-----------+------------+--------------+
Output: 
+-----------+
| fraction  |
+-----------+
| 0.33      |
+-----------+
Explanation: 
Only the player with id 1 logged back in after the first day he had logged in so the answer is 1/3 = 0.33

-- Answer:
----------------------------------------------------------------------------------------------------------
 SELECT ROUND((select count(*) AS playerloggedcontinuously									   			 
 from (select Act2.player_id from activity2 Act1														 
 INNER join (select player_id, min(event_date) as min_date from activity2 group by player_id			 
 ) Act2 On Act1.player_id = Act2.player_id																 
 and DATEDIFF(DAY,Act2.min_date , Act1.event_date) = 1													 
  GROUP BY Act2.player_id ) s1) * 1.0																	 
  / COUNT(DISTINCT player_id), 2) AS fraction 															 
 FROM activity2																				  
-----------------------------------------------------------------------------------------------------------

-- Explanation :

-- Subquery to get players who have logged in for two consecutive days starting from the first login date
select count(*) AS playerloggedcontinuously									   			 
 from (select Act2.player_id from activity2 Act1														 
 INNER join ( select player_id, min(event_date) as min_date from activity2 group by player_id			 
 ) Act2 On Act1.player_id = Act2.player_id																 
 and DATEDIFF(DAY,Act2.min_date , Act1.event_date) = 1													 
  GROUP BY Act2.player_id ) s1


 -- Get all players without duplicates
  COUNT(DISTINCT player_id)


  -- Finally Divide playerloggedcontinuously by the total number of players.
  -- Result rounded to 2 decimal places.