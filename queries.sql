-- =====================================================
-- SportRAG Analytics Queries
-- Z2004 DBMS Milestone 2
-- =====================================================



-- =====================================================
-- QUERY 1
-- Top Goal Scorers
-- Type: Aggregation + Join
-- =====================================================

SELECT
    p.name AS player_name,
    t.name AS team_name,
    SUM(ps.goals) AS total_goals
FROM PlayerStats ps
JOIN Players p
    ON ps.player_id = p.player_id
JOIN Teams t
    ON p.team_id = t.team_id
GROUP BY p.name, t.name
ORDER BY total_goals DESC
LIMIT 10;



-- =====================================================
-- QUERY 2
-- Top Assist Providers
-- Type: Aggregation + Join
-- =====================================================

SELECT
    p.name AS player_name,
    SUM(ps.assists) AS total_assists
FROM PlayerStats ps
JOIN Players p
    ON ps.player_id = p.player_id
GROUP BY p.name
ORDER BY total_assists DESC
LIMIT 10;



-- =====================================================
-- QUERY 3
-- Matches With Highest Total Goals
-- Type: Aggregation
-- =====================================================

SELECT
    match_id,
    home_score,
    away_score,
    (home_score + away_score) AS total_goals
FROM Matches
ORDER BY total_goals DESC
LIMIT 10;



-- =====================================================
-- QUERY 4
-- Players With Above Average Goals
-- Type: Subquery
-- =====================================================

SELECT
    p.name,
    SUM(ps.goals) AS total_goals
FROM PlayerStats ps
JOIN Players p
    ON ps.player_id = p.player_id
GROUP BY p.name
HAVING SUM(ps.goals) >
(
    SELECT AVG(goals)
    FROM PlayerStats
)
ORDER BY total_goals DESC;



-- =====================================================
-- QUERY 5
-- Teams With More Than 10 Goals
-- Type: Subquery + Join
-- =====================================================

SELECT DISTINCT
    t.name AS team_name
FROM Teams t
JOIN Players p
    ON t.team_id = p.team_id
JOIN PlayerStats ps
    ON p.player_id = ps.player_id
WHERE t.team_id IN
(
    SELECT p.team_id
    FROM Players p
    JOIN PlayerStats ps
        ON p.player_id = ps.player_id
    GROUP BY p.team_id
    HAVING SUM(ps.goals) > 10
);



-- =====================================================
-- QUERY 6
-- Player Goal Rankings
-- Type: Window Function
-- =====================================================

SELECT
    p.name,
    SUM(ps.goals) AS total_goals,
    RANK() OVER (
        ORDER BY SUM(ps.goals) DESC
    ) AS goal_rank
FROM PlayerStats ps
JOIN Players p
    ON ps.player_id = p.player_id
GROUP BY p.name
ORDER BY goal_rank;



-- =====================================================
-- QUERY 7
-- Match Goal Running Totals
-- Type: Window Function
-- =====================================================

SELECT
    match_id,
    home_score + away_score AS match_goals,

    SUM(home_score + away_score)
    OVER (
        ORDER BY match_id
    ) AS running_total_goals

FROM Matches
ORDER BY match_id;



-- =====================================================
-- QUERY 8
-- Average Goals Per Team
-- Type: CTE
-- =====================================================

WITH TeamGoals AS
(
    SELECT
        t.name AS team_name,
        SUM(ps.goals) AS total_goals
    FROM Teams t
    JOIN Players p
        ON t.team_id = p.team_id
    JOIN PlayerStats ps
        ON p.player_id = ps.player_id
    GROUP BY t.name
)

SELECT
    team_name,
    total_goals,
    ROUND(total_goals::numeric / 100, 2)
        AS avg_goals_per_match
FROM TeamGoals
ORDER BY total_goals DESC;



-- =====================================================
-- QUERY 9
-- Most Active Players
-- Type: CTE + Aggregation
-- =====================================================

WITH PlayerMinutes AS
(
    SELECT
        p.name,
        SUM(ps.minutes_played) AS total_minutes
    FROM Players p
    JOIN PlayerStats ps
        ON p.player_id = ps.player_id
    GROUP BY p.name
)

SELECT *
FROM PlayerMinutes
ORDER BY total_minutes DESC
LIMIT 10;



-- =====================================================
-- QUERY 10
-- Match Reports Containing Specific Keywords
-- Type: Text Query
-- =====================================================

SELECT
    doc_id,
    content
FROM Documents
WHERE content ILIKE '%victory%'
   OR content ILIKE '%goal%'
LIMIT 10;