DROP TABLE IF EXISTS tmdb_movies_raw;
CREATE TABLE tmdb_movies_raw (
  budget TEXT, genres TEXT, homepage TEXT, id TEXT, keywords TEXT,
  original_language TEXT, original_title TEXT, overview TEXT, popularity TEXT,
  production_companies TEXT, production_countries TEXT, release_date TEXT,
  revenue TEXT, runtime TEXT, spoken_languages TEXT, status TEXT, tagline TEXT,
  title TEXT, vote_average TEXT, vote_count TEXT
);

DROP TABLE IF EXISTS tmdb_credits_raw;
CREATE TABLE tmdb_credits_raw (
  movie_id TEXT,
  title TEXT,
  cast_json TEXT,  -- renamed from reserved word "cast"
  crew TEXT
);
