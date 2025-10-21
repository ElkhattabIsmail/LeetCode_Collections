
/*
Table: user_content

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| content_id  | int     |
| content_text| varchar |
+-------------+---------+
content_id is the unique key for this table.
Each row contains a unique ID and the corresponding text content.
Write a solution to transform the text in the content_text column by applying the following rules:

Convert the first letter of each word to uppercase and the remaining letters to lowercase
Special handling for words containing special characters:
For words connected with a hyphen -, both parts should be capitalized (e.g., top-rated → Top-Rated)
All other formatting and spacing should remain unchanged
Return the result table that includes both the original content_text and the modified text following the above rules.

The result format is in the following example.

 

Example:

Input:

user_content table:

+------------+---------------------------------+
| content_id | content_text                    |
+------------+---------------------------------+
| 1          | hello world of SQL              |
| 2          | the QUICK-brown fox             |
| 3          | modern-day DATA science         |
| 4          | web-based FRONT-end development |
+------------+---------------------------------+
Output:

+------------+---------------------------------+---------------------------------+
| content_id | original_text                   | converted_text                  |
+------------+---------------------------------+---------------------------------+
| 1          | hello world of SQL              | Hello World Of Sql              |
| 2          | the QUICK-brown fox             | The Quick-Brown Fox             |
| 3          | modern-day DATA science         | Modern-Day Data Science         |
| 4          | web-based FRONT-end development | Web-Based Front-End Development |
+------------+---------------------------------+---------------------------------+
Explanation:

For content_id = 1:
Each word's first letter is capitalized: "Hello World Of Sql"
For content_id = 2:
Contains the hyphenated word "QUICK-brown" which becomes "Quick-Brown"
Other words follow normal capitalization rules
For content_id = 3:
Hyphenated word "modern-day" becomes "Modern-Day"
"DATA" is converted to "Data"
For content_id = 4:
Contains two hyphenated words: "web-based" → "Web-Based"
And "FRONT-end" → "Front-End"
 

Constraints:

context_text contains only English letters, and the characters in the list ['\', ' ', '@', '-', '/', '^', ',']
*/

-- Solution :

WITH SPLIT_Words  AS
(
	SELECT content_id,content_text,
	CONCAT( UPPER(LEFT(SPLIT_TXT.value, 1)) , 
	CASE WHEN LEN(SPLIT_TXT.value) - LEN(REPLACE(SPLIT_TXT.value,'-','')) = 0
			     -- CONACT WITH THE REST OF STRING.
		THEN SUBSTRING(SPLIT_TXT.value, 2, LEN(SPLIT_TXT.value)) 
				 --	STRING FROM INDEX 2 TO THE LAST. EX (uick-brown)
		ELSE STUFF( SUBSTRING(SPLIT_TXT.value, 2, LEN(SPLIT_TXT.value)) ,
				 -- LETTER AFTER THE HYPHEN AS (START)*							  LENGHTH
	CHARINDEX('-', SUBSTRING(SPLIT_TXT.value, 2, LEN(SPLIT_TXT.value)) ) + 1	 ,   1   ,
			     -- UPPER THE LETTER AFTER THE HYPHEN.   
	UPPER(SUBSTRING(SPLIT_TXT.value, CHARINDEX('-',SPLIT_TXT.value) + 1  , 1)))
	END )   AS Word
	FROM user_content
	CROSS APPLY string_split(LOWER (content_text),' ') AS SPLIT_TXT
)
SELECT 
	content_id, content_text AS original_text ,
	STRING_AGG(Word, ' ') AS converted_text
FROM SPLIT_Words
GROUP BY content_id, content_text
ORDER BY content_id 