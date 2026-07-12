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
    now = "2026-07-12T15:00:00.000Z"
    pin_hash = hashlib.sha256(
        b"evefit-tracker-local-pin-v1:1234"
    ).hexdigest()
    connection.execute(
        "INSERT INTO profiles("
        "name,pin_hash,created_at,updated_at,is_active,height_cm,"
        "training_location,initial_goals,notes) VALUES(?,?,?,?,?,?,?,?,?)",
        ("UpgradeLab", pin_hash, now, now, 1, 180.0, "", "", "upgrade-preserve-profile"),
    )
    profile_id = connection.execute("SELECT last_insert_rowid()").fetchone()[0]
    exercise_id, exercise_name = connection.execute(
        "SELECT id,name FROM exercises WHERE is_default=1 ORDER BY id LIMIT 1"
    ).fetchone()
    connection.execute(
        "INSERT INTO body_measurements(profile_id,date,weight_kg,notes) "
        "VALUES(?,?,?,?)",
        (profile_id, now, 80.0, "upgrade-preserve-measurement"),
    )
    connection.execute(
        "INSERT INTO goals(profile_id,title,description,phase,category,"
        "metric_key,is_active,created_at) VALUES(?,?,?,?,?,?,?,?)",
        (
            profile_id,
            "Upgrade preserve goal",
            "must survive",
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
        (profile_id, now, "Treino historico upgrade", 30, "upgrade-preserve-workout"),
    )
    workout_id = connection.execute("SELECT last_insert_rowid()").fetchone()[0]
    connection.execute(
        "INSERT INTO workout_exercises(profile_id,workout_id,exercise_id,notes) "
        "VALUES(?,?,?,?)",
        (profile_id, workout_id, exercise_id, "upgrade-preserve-exercise"),
    )
    connection.execute(
        "INSERT INTO workout_sets(profile_id,workout_id,exercise_id,set_number,reps,notes) "
        "VALUES(?,?,?,?,?,?)",
        (profile_id, workout_id, exercise_id, 1, 12, "upgrade-preserve-set"),
    )
    connection.commit()
    return {
        "counts": counts(connection),
        "exercise_id": exercise_id,
        "exercise_name": exercise_name,
    }


def verify(connection: sqlite3.Connection) -> dict[str, object]:
    historical = connection.execute(
        "SELECT workouts.notes, workout_exercises.notes, workout_sets.notes, "
        "exercises.name FROM workouts "
        "JOIN workout_exercises ON workout_exercises.workout_id = workouts.id "
        "JOIN workout_sets ON workout_sets.workout_id = workouts.id "
        "JOIN exercises ON exercises.id = workout_exercises.exercise_id "
        "WHERE workouts.notes = 'upgrade-preserve-workout'"
    ).fetchone()
    return {
        "counts": counts(connection),
        "foreign_keys": connection.execute("PRAGMA foreign_key_check").fetchall(),
        "historical": historical,
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
