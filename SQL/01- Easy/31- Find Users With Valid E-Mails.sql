

/*
Table: Users

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| user_id       | int     |
| name          | varchar |
| mail          | varchar |
+---------------+---------+
user_id is the primary key (column with unique values) for this table.
This table contains information of the users signed up in a website. Some e-mails are invalid.
 

Write a solution to find the users who have valid emails.

A valid e-mail has a prefix name and a domain where:

The prefix name is a string that may contain letters (upper or lower case), digits, underscore '_', period '.', and/or dash '-'. The prefix name must start with a letter.
The domain is '@leetcode.com'.
Return the result table in any order.

The result format is in the following example.

 

Example 1:

Input: 
Users table:
+---------+-----------+-------------------------+
| user_id | name      | mail                    |
+---------+-----------+-------------------------+
| 1       | Winston   | winston@leetcode.com    |
| 2       | Jonathan  | jonathanisgreat         |
| 3       | Annabelle | bella-@leetcode.com     |
| 4       | Sally     | sally.come@leetcode.com |
| 5       | Marwan    | quarz#2020@leetcode.com |
| 6       | David     | david69@gmail.com       |
| 7       | Shapiro   | .shapo@leetcode.com     |
+---------+-----------+-------------------------+
Output: 
+---------+-----------+-------------------------+
| user_id | name      | mail                    |
+---------+-----------+-------------------------+
| 1       | Winston   | winston@leetcode.com    |
| 3       | Annabelle | bella-@leetcode.com     |
| 4       | Sally     | sally.come@leetcode.com |
+---------+-----------+-------------------------+
Explanation: 
The mail of user 2 does not have a domain.
The mail of user 5 has the # sign which is not allowed.
The mail of user 6 does not have the leetcode domain.
The mail of user 7 starts with a period.
*/


-- Solution :

With T1 as
(
	select *,CHARINDEX('@',mail) as indxOf@ ,LEN(mail) - LEN(REPLACE(mail, '@', '')) AS CountOf@
	from UserEmails
	where CHARINDEX('@leetcode.com', mail) != 0
	And mail LIKE '[A-Za-z]%'
),
T2 as
(
	SeleCt *,SUBSTRING(T1.mail,1, T1.indxOf@ - 1) as FirstPartOfEmail
	from T1 WhERE T1.CountOf@ < 2
	 And SUBSTRING(T1.mail, T1.indxOf@ + 1, LEN(T1.mail)) COLLATE Latin1_General_CS_AS = 'leetcode.com'
)
seleCt T2.user_id,T2.name, T2.mail from T2
Where PATINDEX('%[^A-Za-z0-9._-]%', T2.FirstPartOfEmail) = 0



SELECT user_id, name, mail
FROM UserEmails
WHERE mail LIKE '[a-zA-Z]%@leetcode.com' 
AND left(mail, len(mail)-13) NOT like '%[^A-Za-z0-9_.-]%' 















