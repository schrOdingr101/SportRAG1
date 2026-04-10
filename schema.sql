DROP TABLE IF EXISTS Embeddings CASCADE;
DROP TABLE IF EXISTS Documents CASCADE;
DROP TABLE IF EXISTS PlayerStats CASCADE;
DROP TABLE IF EXISTS Matches CASCADE;
DROP TABLE IF EXISTS Players CASCADE;
DROP TABLE IF EXISTS Teams CASCADE;
-- =========================================
-- SportRAG Database Schema
-- PostgreSQL + pgvector
-- =========================================

-- Enable pgvector extension
CREATE EXTENSION IF NOT EXISTS vector;

-- =========================================
-- TABLE: Teams
-- =========================================
CREATE TABLE Teams (
    team_id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    league VARCHAR(50) NOT NULL
);

-- =========================================
-- TABLE: Players
-- Each player belongs to one team
-- =========================================
CREATE TABLE Players (
    player_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    position VARCHAR(50) NOT NULL,
    team_id INT NOT NULL,
    FOREIGN KEY (team_id) REFERENCES Teams(team_id)
        ON DELETE CASCADE
);

-- =========================================
-- TABLE: Matches
-- Each match has a home and away team
-- =========================================
CREATE TABLE Matches (
    match_id SERIAL PRIMARY KEY,
    date DATE NOT NULL,
    home_team_id INT NOT NULL,
    away_team_id INT NOT NULL,
    home_score INT DEFAULT 0 CHECK (home_score >= 0),
    away_score INT DEFAULT 0 CHECK (away_score >= 0),

    FOREIGN KEY (home_team_id) REFERENCES Teams(team_id),
    FOREIGN KEY (away_team_id) REFERENCES Teams(team_id),

    CHECK (home_team_id <> away_team_id)
);

-- =========================================
-- TABLE: PlayerStats
-- Resolves many-to-many (Players ↔ Matches)
-- =========================================
CREATE TABLE PlayerStats (
    stat_id SERIAL PRIMARY KEY,
    player_id INT NOT NULL,
    match_id INT NOT NULL,
    goals INT DEFAULT 0 CHECK (goals >= 0),
    assists INT DEFAULT 0 CHECK (assists >= 0),
    minutes_played INT CHECK (minutes_played BETWEEN 0 AND 120),

    FOREIGN KEY (player_id) REFERENCES Players(player_id)
        ON DELETE CASCADE,
    FOREIGN KEY (match_id) REFERENCES Matches(match_id)
        ON DELETE CASCADE,

    UNIQUE (player_id, match_id) -- prevents duplicate stats
);

-- =========================================
-- TABLE: Documents
-- Stores match reports (for RAG)
-- =========================================
CREATE TABLE Documents (
    doc_id SERIAL PRIMARY KEY,
    match_id INT NOT NULL,
    content TEXT NOT NULL,
    source VARCHAR(255),

    FOREIGN KEY (match_id) REFERENCES Matches(match_id)
        ON DELETE CASCADE
);

-- =========================================
-- TABLE: Embeddings
-- Stores vector representations of documents
-- =========================================
CREATE TABLE Embeddings (
    embedding_id SERIAL PRIMARY KEY,
    doc_id INT UNIQUE NOT NULL,
    embedding VECTOR(384), -- dimension depends on model (MiniLM = 384)

    FOREIGN KEY (doc_id) REFERENCES Documents(doc_id)
        ON DELETE CASCADE
);

