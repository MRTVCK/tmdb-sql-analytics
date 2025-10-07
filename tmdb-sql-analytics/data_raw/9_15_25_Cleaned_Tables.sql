-- 0) Optional: see which ids are duplicated (sanity check)
-- SELECT id, COUNT(*) 
-- FROM tmdb_movies_raw 
-- WHERE id ~ '^\d+$'
-- GROUP BY id 
-- HAVING COUNT(*) > 1
-- ORDER BY COUNT(*) DESC, id::INT
-- LIMIT 20;

-- 1) Recreate the clean table
DROP TABLE IF EXISTS movies CASCADE;
CREATE TABLE movies (
  tmdb_id        INT PRIMARY KEY,
  title          TEXT,
  original_title TEXT,
  release_date   DATE,
  budget         BIGINT,
  revenue        BIGINT,
  runtime        NUMERIC,
  popularity     NUMERIC,
  status         TEXT,
  vote_average   NUMERIC,
  vote_count     INT
);

-- 2) Insert de-duplicated rows
WITH ranked AS (
  SELECT
    id,
    title,
    original_title,
    release_date,
    budget,
    revenue,
    runtime,
    popularity,
    status,
    vote_average,
    vote_count,
    ROW_NUMBER() OVER (
      PARTITION BY id
      ORDER BY
        COALESCE(NULLIF(vote_count,'')::INT, 0) DESC,
        COALESCE(NULLIF(revenue,'')::BIGINT, 0) DESC
    ) AS rn
  FROM tmdb_movies_raw
  WHERE id ~ '^\d+$'
)
INSERT INTO movies (
  tmdb_id, title, original_title, release_date, budget, revenue,
  runtime, popularity, status, vote_average, vote_count
)
SELECT
  NULLIF(id, '')::INT,
  title,
  original_title,
  NULLIF(release_date,'')::DATE,
  NULLIF(budget,'')::BIGINT,
  NULLIF(revenue,'')::BIGINT,
  NULLIF(runtime,'')::NUMERIC,
  NULLIF(popularity,'')::NUMERIC,
  status,
  NULLIF(vote_average,'')::NUMERIC,
  NULLIF(vote_count,'')::INT
FROM ranked
WHERE rn = 1;
