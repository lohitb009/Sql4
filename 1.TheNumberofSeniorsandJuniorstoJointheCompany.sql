# Write your MySQL query statement below

# Create a CTE with running_sum

WITH CTE AS (
    
    SELECT *, SUM(salary) OVER (PARTITION BY experience
                                ORDER BY salary asc, employee_id asc
                               ) AS 'running_sum'
    
    FROM Candidates 
)

# SELECT * FROM CTE;

# {"headers": ["employee_id", "experience", "salary", "running_sum"], "values": [[2, "Senior", 20000, 20000], [11, "Senior", 20000, 40000], [13, "Senior", 50000, 90000], [1, "Junior", 10000, 10000], [9, "Junior", 10000, 20000], [4, "Junior", 40000, 60000]]}
# --------------------------------------------------

# get count of seniors where running_sum <= 70
SELECT 'Senior' as experience, 
        IFNULL(COUNT(employee_id),0) AS 'accepted_candidates' 
FROM CTE 
WHERE 
    experience = 'Senior' AND 
    running_sum <= 70000

# PERFORM UNION OF BOTH RESULTS
UNION

# get count of juniors where running_sum <= 70 - max_possible_running_sum
SELECT 'Junior' as experience, 
        IFNULL(COUNT(employee_id),0) AS 'accepted_candidates' 
FROM CTE 
WHERE 
    experience = 'Junior' AND 
    running_sum <= 70000 - (SELECT IFNULL(MAX(running_sum),0) 
                            FROM CTE 
                            WHERE 
                                experience = 'Senior' 
                                AND 
                                running_sum <= 70000)


  

