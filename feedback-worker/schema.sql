CREATE TABLE IF NOT EXISTS submissions (
  id          INTEGER PRIMARY KEY AUTOINCREMENT,
  created_at  TEXT NOT NULL DEFAULT (datetime('now')),
  page        TEXT,
  title       TEXT,
  message     TEXT NOT NULL,
  email       TEXT,
  user_agent  TEXT
);
