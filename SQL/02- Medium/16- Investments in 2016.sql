
-- Question:


/*
+-------------+-------+
| Column Name | Type  |
+-------------+-------+
| pid         | int   |
| tiv_2015    | float |
| tiv_2016    | float |
| lat         | float |
| lon         | float |
+-------------+-------+
pid is the primary key (column with unique values) for this table.
Each row of this table contains information about one policy where:
pid is the policyholder's policy ID.
tiv_2015 is the total investment value in 2015 and tiv_2016 is the total investment value in 2016.
lat is the latitude of the policy holder's city. It's guaranteed that lat is not NULL.
lon is the longitude of the policy holder's city. It's guaranteed that lon is not NULL.
 

Write a solution to report the sum of all total investment values in 2016 tiv_2016, for all policyholders who:

have the same tiv_2015 value as one or more other policyholders, and
are not located in the same city as any other policyholder (i.e., the (lat, lon) attribute pairs must be unique).
Round tiv_2016 to two decimal places.

The result format is in the following example.

 

Example 1:

Input: 
Insurance table:
+-----+----------+----------+-----+-----+
| pid | tiv_2015 | tiv_2016 | lat | lon |
+-----+----------+----------+-----+-----+
| 1   | 10       | 5        | 10  | 10  |
| 2   | 20       | 20       | 20  | 20  |
| 3   | 10       | 30       | 20  | 20  |
| 4   | 10       | 40       | 40  | 40  |
+-----+----------+----------+-----+-----+
Output: 
+----------+
| tiv_2016 |
+----------+
| 45.00    |
+----------+
Explanation: 
The first record in the table, like the last record, meets both of the two criteria.
The tiv_2015 value 10 is the same as the third and fourth records, and its location is unique.

The second record does not meet any of the two criteria. Its tiv_2015 is not like any other policyholders and its location is the same as the third record, which makes the third record fail, too.
So, the result is the sum of tiv_2016 of the first and last record, which is 45.
*/


-- Solution:


-- 01 :

With InsuranceWithLocations As
(Select *, Concat(lat, lon)
As CityLocation  From Insurance)

Select Round(Sum(tiv_2016), 2) As tiv_2016
From InsuranceWithLocations
Where tiv_2015 In 
(
  Select tiv_2015 From InsuranceWithLocations 
  group by tiv_2015 having Count(tiv_2015) > 1
) 
And Concat(lat, lon) In 
(
   Select CityLocation From InsuranceWithLocations
   group by CityLocation having Count(CityLocation) = 1
)


-- 02 : Using W.F.

With CTE As
(
   Select pid, TIV_2015, TIV_2016, 
   count(concat(lat, lon)) 
   over (partition by concat(lat, lon))As CntLocations,
   count(TIV_2015) over(partition by tiv_2015) As Cnt_tiv_2015
   From insurance
)
Select Round(Sum(TIV_2016), 2) As TIV_2016 From CTE 
Where CntLocations = 1 and Cnt_tiv_2015 != 1




