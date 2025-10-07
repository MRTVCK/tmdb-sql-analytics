COPY tmdb_movies_raw
FROM '/tmp/tmdb_5000_movies.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',');

COPY tmdb_credits_raw (movie_id, title, cast_json, crew)
FROM '/tmp/tmdb_5000_credits.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',');
