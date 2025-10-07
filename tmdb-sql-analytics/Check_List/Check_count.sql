SELECT
  (SELECT COUNT(*) FROM tmdb_movies_raw)  AS movies_raw_rows,
  (SELECT COUNT(*) FROM tmdb_credits_raw) AS credits_raw_rows;
