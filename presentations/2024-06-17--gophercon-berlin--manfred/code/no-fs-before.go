import "database/sql"
db, err := sql.Open("driver", "source")
_, err := db.Exec("CREATE TABLE IF NOT EXISTS users ...")
_, err := db.Exec("INSERT INTO users ...")
rows, err := db.Query("SELECT fields FROM users ...")
defer rows.Close()
for rows.Next() { /* logic */}
err := rows.Err()
