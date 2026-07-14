import argparse
import hashlib
import json
import sqlite3


TABLES = [
    "profiles",
    "body_measurements",
    "goals",
    "workouts",
    "workout_sets",
    "workout_exercises",
    "exercises",
]


def counts(connection: sqlite3.Connection) -> dict[str, int]:
    return {
        table: connection.execute(f"SELECT COUNT(*) FROM {table}").fetchone()[0]
        for table in TABLES
    }


def prepare(connection: sqlite3.Connection) -> dict[str, object]:
    now = "2026-07-14T01:00:00.000Z"
    pin_hash = hashlib.sha256(b"evefit-tracker-local-pin-v1:1234").hexdigest()
    connection.execute(
        "INSERT INTO profiles("
        "name,pin_hash,created_at,updated_at,is_active,height_cm,"
        "training_location,initial_goals,notes) VALUES(?,?,?,?,?,?,?,?,?)",
        (
            "Upgrade official v1.1.0",
            pin_hash,
            now,
            now,
            1,
            180.0,
            "",
            "",
            "v111-official-upgrade-profile",
        ),
    )
    profile_id = connection.execute("SELECT last_insert_rowid()").fetchone()[0]
    connection.execute(
        "INSERT INTO body_measurements(profile_id,date,weight_kg,notes) "
        "VALUES(?,?,?,?)",
        (profile_id, now, 80.0, "v111-official-upgrade-measurement"),
    )
    connection.execute(
        "INSERT INTO goals(profile_id,title,description,phase,category,"
        "metric_key,is_active,created_at) VALUES(?,?,?,?,?,?,?,?)",
        (
            profile_id,
            "Upgrade official goal",
            "must survive v1.1.1",
            "Base",
            "Outro",
            "manual",
            1,
            now,
        ),
    )
    connection.execute(
        "INSERT INTO workouts(profile_id,date,workout_type,duration_minutes,notes) "
        "VALUES(?,?,?,?,?)",
        (
            profile_id,
            now,
            "Treino upgrade oficial",
            30,
            "v111-official-upgrade-workout",
        ),
    )
    connection.commit()
    return {"counts": counts(connection), "user_version": user_version(connection)}


def user_version(connection: sqlite3.Connection) -> int:
    return connection.execute("PRAGMA user_version").fetchone()[0]


def verify(connection: sqlite3.Connection) -> dict[str, object]:
    return {
        "counts": counts(connection),
        "user_version": user_version(connection),
        "foreign_keys": connection.execute("PRAGMA foreign_key_check").fetchall(),
        "profile": connection.execute(
            "SELECT name,notes FROM profiles "
            "WHERE notes='v111-official-upgrade-profile'"
        ).fetchone(),
        "measurement": connection.execute(
            "SELECT weight_kg,notes FROM body_measurements "
            "WHERE notes='v111-official-upgrade-measurement'"
        ).fetchone(),
        "goal": connection.execute(
            "SELECT title,description FROM goals WHERE title='Upgrade official goal'"
        ).fetchone(),
        "workout": connection.execute(
            "SELECT workout_type,notes FROM workouts "
            "WHERE notes='v111-official-upgrade-workout'"
        ).fetchone(),
    }


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--database", required=True)
    parser.add_argument("--mode", choices=("prepare", "verify"), required=True)
    args = parser.parse_args()
    connection = sqlite3.connect(args.database)
    try:
        result = prepare(connection) if args.mode == "prepare" else verify(connection)
        print(json.dumps(result, ensure_ascii=False))
    finally:
        connection.close()


if __name__ == "__main__":
    main()
