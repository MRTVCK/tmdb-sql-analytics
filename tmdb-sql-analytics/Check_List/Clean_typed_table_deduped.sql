SELECT COUNT(*)                         AS movies_rows   FROM movies;          -- ~4,803
SELECT COUNT(DISTINCT tmdb_id)          AS distinct_ids  FROM movies;          -- matches movies_rows
SELECT MIN(release_date), MAX(release_date) FROM movies;                      -- dates look sane
