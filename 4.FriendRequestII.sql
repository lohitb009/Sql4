# Write your MySQL query statement below

# Build CTE
WITH CTE AS(

    SELECT requester_id AS 'ID'
    FROM RequestAccepted 
    
    UNION ALL
    
    SELECT accepter_id AS 'ID'
    FROM RequestAccepted
    
)

# Build Query Result

# SELECT ID, COUNT(ID) AS 'NUM'
# FROM CTE
# GROUP BY ID
# ORDER BY NUM DESC, ID ASC
# LIMIT 1;

SELECT DISTINCT ID, COUNT(ID) OVER (PARTITION BY ID) AS 'NUM'
FROM CTE
ORDER BY NUM DESC, ID ASC
LIMIT 1;
