import psycopg2
import random
from faker import Faker

fake = Faker()

# Database connection
conn = psycopg2.connect(
    "postgresql://postgres.ikccwgolfozswzbxwdjb:GhengisKhan111@aws-0-eu-west-1.pooler.supabase.com:5432/postgres"
)

conn.autocommit = True

cur = conn.cursor()

# -----------------------------------
# Generate Players
# -----------------------------------

positions = ['Forward', 'Midfielder', 'Defender', 'Goalkeeper']

for team_id in range(1, 11):  # 10 teams
    for _ in range(15):       # 15 players per team

        name = fake.name()
        position = random.choice(positions)

        try:
            cur.execute("""
                INSERT INTO Players (name, position, team_id)
                VALUES (%s, %s, %s)
            """, (name, position, team_id))

        except Exception as e:
            print("Player insert error:", e)

        # Fetch all valid player IDs
cur.execute("SELECT player_id FROM Players")
player_ids = [row[0] for row in cur.fetchall()]

# -----------------------------------
# Generate Matches
# -----------------------------------

for _ in range(100):

    home = random.randint(1, 10)
    away = random.randint(1, 10)

    while home == away:
        away = random.randint(1, 10)

    home_score = random.randint(0, 5)
    away_score = random.randint(0, 5)

    try:

        cur.execute("""
            INSERT INTO Matches (
                date,
                home_team_id,
                away_team_id,
                home_score,
                away_score
            )
            VALUES (%s, %s, %s, %s, %s)
            RETURNING match_id
        """, (
            fake.date_this_year(),
            home,
            away,
            home_score,
            away_score
        ))

        match_id = cur.fetchone()[0]

        # -----------------------------------
        # Generate Player Stats
        # -----------------------------------

        for _ in range(10):

            player_id = random.choice(player_ids)

            goals = random.randint(0, 2)
            assists = random.randint(0, 2)
            minutes = random.randint(60, 90)

            try:
                cur.execute("""
                    INSERT INTO PlayerStats (
                        player_id,
                        match_id,
                        goals,
                        assists,
                        minutes_played
                    )
                    VALUES (%s, %s, %s, %s, %s)
                """, (
                    player_id,
                    match_id,
                    goals,
                    assists,
                    minutes
                ))

            except Exception as e:
                print("PlayerStats error:", e)

        # -----------------------------------
        # Generate Documents
        # -----------------------------------

        report = fake.text(max_nb_chars=200)

        cur.execute("""
            INSERT INTO Documents (
                match_id,
                content,
                source
            )
            VALUES (%s, %s, %s)
        """, (
            match_id,
            report,
            "Generated Match Report"
        ))

    except Exception as e:
        print("Match insert error:", e)

cur.close()
conn.close()

print("✅ Data generation complete!")