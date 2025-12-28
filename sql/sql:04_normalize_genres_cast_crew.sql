-- GENRES
DROP TABLE IF EXISTS movie_genres;
CREATE TABLE movie_genres (
  tmdb_id INT REFERENCES movies(tmdb_id),
  genre_id INT,
  genre_name TEXT
);
INSERT INTO movie_genres (tmdb_id, genre_id, genre_name)
SELECT r.id::INT, (g->>'id')::INT, g->>'name'
FROM tmdb_movies_raw r
CROSS JOIN LATERAL jsonb_array_elements(r.genres::jsonb) g
WHERE r.id ~ '^\d+$';

-- CAST
DROP TABLE IF EXISTS movie_cast;
CREATE TABLE movie_cast (
  tmdb_id INT REFERENCES movies(tmdb_id),
  person_id INT,
  name TEXT,
  character TEXT,
  cast_order INT
);
INSERT INTO movie_cast (tmdb_id, person_id, name, character, cast_order)
SELECT c.movie_id::INT, (m->>'id')::INT, m->>'name', m->>'character',
       NULLIF(m->>'order','')::INT
FROM tmdb_credits_raw c
CROSS JOIN LATERAL jsonb_array_elements(c.cast_json::jsonb) m
WHERE c.movie_id ~ '^\d+$';

-- CREW
DROP TABLE IF EXISTS movie_crew;
CREATE TABLE movie_crew (
  tmdb_id INT REFERENCES movies(tmdb_id),
  person_id INT,
  name TEXT,
  job TEXT,
  department TEXT
);
INSERT INTO movie_crew (tmdb_id, person_id, name, job, department)
SELECT c.movie_id::INT, (m->>'id')::INT, m->>'name', m->>'job', m->>'department'
FROM tmdb_credits_raw c
CROSS JOIN LATERAL jsonb_array_elements(c.crew::jsonb) m
WHERE c.movie_id ~ '^\d+$';

-- helpful indexes
CREATE INDEX IF NOT EXISTS idx_genre_name ON movie_genres(genre_name);
CREATE INDEX IF NOT EXISTS idx_cast_name  ON movie_cast(name);
CREATE INDEX IF NOT EXISTS idx_crew_job_name ON movie_crew(job, name);
