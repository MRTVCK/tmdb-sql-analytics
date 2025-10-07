COPY tmdb_movies_raw
FROM '/tmp/tmdb_5000_movies.csv'
DELIMITER ',' CSV HEADER;

COPY tmdb_credits_raw(movie_id, title, cast_json, crew)
FROM '/tmp/tmdb_5000_credits.csv'
DELIMITER ',' CSV HEADER;

SELECT COUNT(*) FROM tmdb_movies_raw;
SELECT COUNT(*) FROM tmdb_credits_raw;
