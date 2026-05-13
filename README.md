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

- Teams: 10 rows
- Players: 150 rows
- Matches: 100 rows
- PlayerStats: 972 rows
- Documents: 100 rows

Total rows exceed the 1000-row minimum requirement.

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

## Author
[Simeon Mudenda & Patrick Muchindu]
