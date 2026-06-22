https://github.com/schrOdingr101/SportRAG1

# SportRAG: Retrieval-Augmented Sports Analytics System

## Description

SportRAG is a question-answering system that combines structured sports data with unstructured match reports using a Retrieval-Augmented Generation (RAG) pipeline.

## Dataset Information

The SportRAG dataset simulates football match analytics data across multiple leagues and teams.  
Data was generated programmatically using Python, Faker, and PostgreSQL.

### Dataset Tables

| Table | Description |
|---|---|
| Teams | Stores football teams and league information |
| Players | Stores player details and team affiliations |
| Matches | Stores football match results |
| PlayerStats | Stores player performance statistics per match |
| Documents | Stores generated match reports for RAG retrieval |
| Embeddings | Stores vector embeddings for semantic search |

### Total Dataset Size

- Teams: 20 rows
- Players: 1000 rows
- Matches: 1000 rows
- PlayerStats: 12000 rows
- Documents: 1000 rows

Total rows exceed the 14000-rows after milestone 2.

## Data Dictionary

### Teams

| Column | Type | Description |
|---|---|---|
| team_id | SERIAL | Primary key |
| name | VARCHAR | Team name |
| league | VARCHAR | League name |

### Players

| Column | Type | Description |
|---|---|---|
| player_id | SERIAL | Primary key |
| name | VARCHAR | Player name |
| position | VARCHAR | Playing position |
| team_id | INT | Foreign key referencing Teams |

### Matches

| Column | Type | Description |
|---|---|---|
| match_id | SERIAL | Primary key |
| date | DATE | Match date |
| home_team_id | INT | Home team |
| away_team_id | INT | Away team |
| home_score | INT | Goals scored by home team |
| away_score | INT | Goals scored by away team |

### PlayerStats

| Column | Type | Description |
|---|---|---|
| stat_id | SERIAL | Primary key |
| player_id | INT | Foreign key referencing Players |
| match_id | INT | Foreign key referencing Matches |
| goals | INT | Goals scored |
| assists | INT | Assists made |
| minutes_played | INT | Minutes played |

### Documents

| Column | Type | Description |
|---|---|---|
| doc_id | SERIAL | Primary key |
| match_id | INT | Foreign key referencing Matches |
| content | TEXT | Match report text |
| source | VARCHAR | Source of report |

## Import Instructions

### 1. Create Database Schema

Run:

```sql
schema.sql
```
## Query Suite

The `queries.sql` file contains analytical SQL queries demonstrating:

- Aggregations
- Joins
- Subqueries
- Common Table Expressions (CTEs)
- Window Functions

Example analyses include:
- Top goal scorers
- Assist rankings
- Team goal statistics
- Running goal totals
- Player activity analysis

## Tech Stack

* PostgreSQL (Supabase)
* pgvector (vector embeddings)
* Python (planned)

## Features

* Relational database for sports statistics
* Vector database for semantic search
* Natural language query support (planned)

## Project Structure

* `schema.sql` – database schema
* `ER_diagram.png` – entity relationship diagram
* `normalization.md` – normalization proof
* `data/` – datasets and generated data

* ## Setup Instructions
* 

1. Create a PostgreSQL database (e.g., using Supabase)
2. Run the `schema.sql` file
3. Ensure pgvector extension is enabled


## Status

Milestone 1 completed (Schema Design and DDL)
# SportRAG1

---

# Milestone 2: Data Generation and Advanced SQL

## Data Generation

A synthetic football analytics dataset was generated programmatically using Python and the Faker library.

### Final Dataset Size

| Table | Records |
|---------|---------:|
| Teams | 20 |
| Players | 500 |
| Matches | 1000 |
| PlayerStats | 12000 |
| Documents | 1000 |

Total dataset size exceeds 14,000 records.

### Data Generation Tools

- Python
- Faker
- PostgreSQL
- psycopg2

The dataset was generated automatically to simulate realistic football analytics data while maintaining referential integrity between tables.

---

## Advanced SQL Queries

The project implements advanced SQL functionality including:

### Joins and Aggregations

- Top Goal Scorers
- Top Assist Providers
- Team Goal Statistics

### Subqueries

- Players Above Average Goals
- Teams With More Than 10 Goals

### Common Table Expressions (CTEs)

- Average Goals Per Team
- Most Active Players

### Window Functions

- Player Goal Rankings
- Running Goal Totals

### Text Search

- Match Report Keyword Search

The complete implementations can be found in:

```text
queries.sql
```

---

# Milestone 3: Performance Optimization

## Query Analysis

Performance evaluation was conducted using PostgreSQL's EXPLAIN ANALYZE command.

Three representative analytical queries were selected and evaluated before and after indexing.

### Performance Results

| Query | Before Optimization | After Optimization |
|---------|---------:|---------:|
| Top Goal Scorers | 13.46 ms | 12.04 ms |
| Teams With More Than 10 Goals | 19.07 ms | 11.03 ms |
| Player Rankings | 7.78 ms | 7.71 ms |

### Indexes Implemented

```sql
CREATE INDEX idx_playerstats_player
ON PlayerStats(player_id);

CREATE INDEX idx_players_team
ON Players(team_id);

CREATE INDEX idx_playerstats_goals
ON PlayerStats(goals);
```

### Outcome

The indexing strategy improved query execution times by reducing sequential scans and improving join efficiency.

The largest improvement was observed in the team goal aggregation query, which improved by approximately 42%.

---

# Milestone 4: Trigger, Frontend and Retrieval System

## Trigger Implementation

A trigger was implemented to automatically calculate player ratings whenever a PlayerStats record is inserted or updated.

### Rating Formula

```text
rating =
(goals × 2)
+ (assists × 1.5)
+ (minutes_played / 90)
```

### Benefits

- Automatic calculation
- Improved consistency
- Reduced manual processing
- Business logic enforced within the database

---

## Frontend Dashboard

A frontend dashboard was developed to interact with the database.

### Features

- Team statistics
- Player statistics
- Match analytics
- Top scorer rankings
- Match report retrieval
- Natural language query interface

The dashboard allows users to explore football analytics without directly writing SQL queries.

---

## Retrieval-Augmented Generation (RAG)

SportRAG combines:

### Structured Data

- Teams
- Players
- Matches
- PlayerStats

### Unstructured Data

- Match Reports
- Documents

This architecture provides the foundation for future semantic search and AI-powered sports question answering.

---

## Future Work

Planned improvements include:

- Integration with real football APIs (SofaScore, FotMob, StatsBomb)
- pgvector-based semantic search
- Large Language Model integration
- Natural language to SQL conversion
- Real-time football analytics

---

## Authors
[Simeon Mudenda, Patrick Muchindu & Sarim Rouf]
