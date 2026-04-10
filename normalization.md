
# Normalization (Up to Third Normal Form – 3NF)

## Overview

The SportRAG database schema was designed and normalized to eliminate redundancy, ensure data integrity, and support efficient querying. The schema satisfies the requirements of First Normal Form (1NF), Second Normal Form (2NF), and Third Normal Form (3NF). The functional dependencies of each relation are analyzed below.

---

## 1. First Normal Form (1NF)

A relation is in 1NF if:

* All attributes contain atomic (indivisible) values
* There are no repeating groups or multi-valued attributes

### Verification:

All tables in the schema (Teams, Players, Matches, PlayerStats, Documents, Embeddings) have:

* Atomic attributes (e.g., name, goals, assists)
* No repeating fields or arrays

✅ Therefore, all relations are in **First Normal Form (1NF)**

---

## 2. Second Normal Form (2NF)

A relation is in 2NF if:

* It is in 1NF
* All non-key attributes are fully functionally dependent on the entire primary key

### Verification:

All tables use a **single-attribute primary key**:

* team_id → Teams
* player_id → Players
* match_id → Matches
* stat_id → PlayerStats
* doc_id → Documents
* embedding_id → Embeddings

Since there are no composite primary keys:

* No partial dependencies exist

Example:

* player_id → name, position, team_id
* match_id → date, home_team_id, away_team_id, scores

✅ Therefore, all relations are in **Second Normal Form (2NF)**

---

## 3. Third Normal Form (3NF)

A relation is in 3NF if:

* It is in 2NF
* There are no transitive dependencies (non-key attributes depending on other non-key attributes)

### Functional Dependencies:

**Teams**

* team_id → name, league

**Players**

* player_id → name, position, team_id

**Matches**

* match_id → date, home_team_id, away_team_id, home_score, away_score

**PlayerStats**

* stat_id → player_id, match_id, goals, assists, minutes_played

**Documents**

* doc_id → match_id, content, source

**Embeddings**

* embedding_id → doc_id, embedding

### Verification:

* No non-key attribute determines another non-key attribute
* Example: In Players, team details are not stored redundantly; only team_id is stored
* Example: Match scores are stored only in Matches, not in PlayerStats

Thus:

* No transitive dependencies exist

✅ Therefore, all relations are in **Third Normal Form (3NF)**

---

## Conclusion

The SportRAG schema satisfies:

* 1NF (atomic attributes)
* 2NF (no partial dependencies)
* 3NF (no transitive dependencies)

This ensures:

* Minimal redundancy
* Improved data integrity
* Efficient querying and maintenance

The schema is therefore fully normalized up to **Third Normal Form (3NF)**.
