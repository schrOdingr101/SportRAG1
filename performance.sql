-- Foreign key indexes

CREATE INDEX idx_playerstats_player
ON PlayerStats(player_id);

CREATE INDEX idx_players_team
ON Players(team_id);

CREATE INDEX idx_playerstats_goals
ON PlayerStats(goals);

CREATE INDEX idx_matches_home_team
ON Matches(home_team_id);

CREATE INDEX idx_matches_away_team
ON Matches(away_team_id);

-- ------------------------------------------
-- Refresh Query Planner Statistics
-- ------------------------------------------

ANALYZE PlayerStats;
ANALYZE Players;
ANALYZE Teams;

-- ------------------------------------------
-- Trigger Function
-- Automatically Calculate Player Rating
-- ------------------------------------------

CREATE OR REPLACE FUNCTION calculate_player_rating()
RETURNS TRIGGER AS $$
BEGIN
    NEW.rating :=
        (NEW.goals * 2)
        + (NEW.assists * 1.5)
        + (NEW.minutes_played / 90.0);

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- ------------------------------------------
-- Trigger
-- ------------------------------------------

CREATE TRIGGER trg_calculate_rating
BEFORE INSERT OR UPDATE
ON PlayerStats
FOR EACH ROW
EXECUTE FUNCTION calculate_player_rating();

-- ------------------------------------------
-- Trigger Test
-- ------------------------------------------

INSERT INTO PlayerStats
(player_id, match_id, goals, assists, minutes_played)
VALUES
(2, 1, 3, 2, 90);

SELECT *
FROM PlayerStats
WHERE player_id = 2
ORDER BY stat_id DESC
LIMIT 1;
