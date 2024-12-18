# Write your MySQL query statement below

# 1. PERFORM A UNION OF HOME TEAM TABLE AND AWAY TEAM TABLE
WITH CTE AS (
    
    # HOME TEAM
    SELECT 
        home_team_id AS r1, home_team_goals as g1, away_team_goals as g2,
        (CASE 
            WHEN home_team_goals > away_team_goals THEN 3
            WHEN home_team_goals = away_team_goals THEN 1
            ELSE 0
        END) AS points
    FROM 
        MATCHES
    
    UNION ALL # need to take union all so that we can have duplicate entries
    
    # AWAY TEAM
    SELECT 
        away_team_id AS r1, away_team_goals as g1, home_team_goals as g2,
        (CASE
            WHEN away_team_goals > home_team_goals THEN 3
            WHEN away_team_goals = home_team_goals THEN 1
            ELSE 0
        END) as points
        
    FROM 
        MATCHES

)

# Select * from CTE;

# 2. GET COUNT OF MATCHES PLAYED BY EACH TEAM

# SELECT 
#     DISTINCT R1 AS team_id,
#     COUNT(R1) OVER (PARTITION BY R1) AS matches_played 
#     FROM CTE; 
    
# SELECT 
#     R1 AS team_id,
#     COUNT(R1) AS matches_played 
#     FROM CTE
#     GROUP BY R1; 

# 3. Build up table before performing join

SELECT 
    
    Teams.team_name as team_name, 
    COUNT(CTE.r1) AS matches_played,
    SUM(CTE.points) AS points,
    SUM(CTE.g1) AS goal_for,
    SUM(CTE.g2) AS goal_against,
    (SUM(CTE.g1) - SUM(CTE.g2)) AS goal_diff 
FROM
    CTE INNER JOIN Teams
    ON Teams.team_id = CTE.r1
GROUP BY r1
ORDER BY points desc, goal_diff DESC, team_name asc;
