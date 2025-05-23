

--  Customer Who Visited but Did Not Make Any Transactions

-- Question :

--Table: Visits

--+-------------+---------+
--| Column Name | Type    |
--+-------------+---------+
--| visit_id    | int     |
--| customer_id | int     |
--+-------------+---------+
--visit_id is the column with unique values for this table.
--This table contains information about the customers who visited the mall.
 

--Table: Transactions

--+----------------+---------+
--| Column Name    | Type    |
--+----------------+---------+
--| transaction_id | int     |
--| visit_id       | int     |
--| amount         | int     |
--+----------------+---------+
--transaction_id is column with unique values for this table.
--This table contains information about the transactions made during the visit_id.
 

--Write a solution to find the IDs of the users who visited without making any transactions and the number of times they made these types of visits.

--Return the result table sorted in any order.

--The result format is in the following example.

 

--Example 1:

--Input: 
--Visits

--Explanation: 
--Customer with id = 23 visited the mall once and made one transaction during the visit with id = 12.
--Customer with id = 9 visited the mall once and made one transaction during the visit with id = 13.
--Customer with id = 30 visited the mall once and did not make any transactions.
--Customer with id = 54 visited the mall three times. During 2 visits they did not make any transactions,
--and during one visit they made 3 transactions.
--Customer with id = 96 visited the mall once and did not make any transactions.
--As we can see, users with IDs 30 and 96 visited the mall one time without making any transactions. Also,
--user 54 visited the mall twice and did not make any transactions.


-- Solution :

-- Way 01
--+----------+-------------+
--| visit_id | customer_id |
--+----------+-------------+
--| 1        | 23          |  
--| 2        | 9           |
--| 4        | 30          | 30,96,54,54
--| 5        | 54          | 54,30,96
--| 6        | 96          | O2,01,01
--| 7        | 54          | 
--| 8        | 54          |
--+----------+-------------+
--Transactions
--+----------------+----------+--------+
--| transaction_id | visit_id | amount |
--+----------------+----------+--------+
--| 2              | 5        | 310    |
--| 3              | 5        | 300    |
--| 9              | 5        | 200    |
--| 12             | 1        | 910    |
--| 13             | 2        | 970    |
--+----------------+----------+--------+
--Output: 
--+-------------+----------------+
--| customer_id | count_no_trans |
--+-------------+----------------+
--| 54          | 2              |
--| 30          | 1              |
--| 96          | 1              |
--+-------------+----------------+

SELECT customer_id, COUNT(*) AS count_no_trans
FROM Visits
WHERE visit_id NOT IN (SELECT distinct visit_id FROM Transactions)
GROUP BY customer_id
order by count_no_trans desc,customer_id 




-- Way 02

select *
from
(
select distinct
V.customer_id,
( select count(visit_id) from ( select visit_id from Visits where customer_id = V.customer_id ) as TotalVisits )
  - ( select COUNT(visit_id) from ( select distinct visit_id from Transactions where visit_id in (select visit_id from Visits where customer_id = V.customer_id) )  NumberOfTrans ) 
  as count_no_trans
from
Visits V
) T1
where T1.count_no_trans > 0
order by T1.count_no_trans desc;



