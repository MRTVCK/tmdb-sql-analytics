SELECT
  (SELECT COUNT(*) FROM tmdb_movies_raw)   AS movies_raw,
  (SELECT COUNT(*) FROM tmdb_credits_raw)  AS credits_raw,
  (SELECT COUNT(*) FROM movies)            AS movies_clean,
  (SELECT COUNT(DISTINCT tmdb_id) FROM movies) AS movies_distinct,
  (SELECT COUNT(*) FROM movie_genres)      AS genres_rows,
  (SELECT COUNT(*) FROM movie_cast)        AS cast_rows,
  (SELECT COUNT(*) FROM movie_crew)        AS crew_rows;
