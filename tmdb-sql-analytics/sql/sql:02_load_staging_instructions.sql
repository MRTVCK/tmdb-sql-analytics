-- Reset staging tables before reloading
TRUNCATE tmdb_movies_raw;
TRUNCATE tmdb_credits_raw;

-- Load fresh data from CSVs
COPY tmdb_movies_raw
FROM '/tmp/tmdb_5000_movies.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',');

COPY tmdb_credits_raw (movie_id, title, cast_json, crew)
FROM '/tmp/tmdb_5000_credits.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',');
