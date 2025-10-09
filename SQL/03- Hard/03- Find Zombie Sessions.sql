
/*
Table: app_events

+------------------+----------+
| Column Name      | Type     | 
+------------------+----------+
| event_id         | int      |
| user_id          | int      |
| event_timestamp  | datetime |
| event_type       | varchar  |
| session_id       | varchar  |
| event_value      | int      |
+------------------+----------+
event_id is the unique identifier for this table.
event_type can be app_open, click, scroll, purchase, or app_close.
session_id groups events within the same user session.
event_value represents: for purchase - amount in dollars, for scroll - pixels scrolled, for others - NULL.
Write a solution to identify zombie sessions, sessions where users appear active but show abnormal behavior patterns. A session is considered a zombie session if it meets ALL the following criteria:

The session duration is more than 30 minutes.
Has at least 5 scroll events.
The click-to-scroll ratio is less than 0.20 .
No purchases were made during the session.
Return the result table ordered by scroll_count in descending order, then by session_id in ascending order.

The result format is in the following example.

Select * From  app_events ;
*/


-- Solution :


Select session_id ,user_id ,
DateDiff (Minute, Min(event_timestamp), Max(event_timestamp)) As session_duration_minutes ,
Sum (Case When event_type = 'scroll' Then 1 else 0 End) As scroll_count 
From app_events 
Group By session_id ,user_id
Having DateDiff (Minute, Min(event_timestamp), Max(event_timestamp)) > 30
And Sum(Case When event_type = 'scroll' Then 1 else 0 End) >= 5
And Sum(Case When event_type = 'purchase' Then 1 else 0 End) = 0
And Sum(Case When event_type = 'click' Then 1 else 0 End) * 1.00 
/  Sum(Case When event_type = 'scroll' Then 1 else 0 End) * 1.00 < 0.20
Order By scroll_count Desc, session_id Asc