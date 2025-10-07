-- A) Most profitable genres
SELECT mg.genre_name, COUNT(*) films,
       ROUND(AVG(m.revenue - m.budget)) avg_profit
FROM movies m
JOIN movie_genres mg ON mg.tmdb_id = m.tmdb_id
WHERE m.budget > 0 AND m.revenue > 0
GROUP BY mg.genre_name
ORDER BY avg_profit DESC
LIMIT 10;

-- B) Bankable directors (>=3 films)
SELECT mc.name director, COUNT(*) films,
       ROUND(AVG(m.revenue)) avg_revenue
FROM movie_crew mc
JOIN movies m ON m.tmdb_id = mc.tmdb_id
WHERE mc.job = 'Director' AND m.revenue > 0
GROUP BY mc.name
HAVING COUNT(*) >= 3
ORDER BY avg_revenue DESC
LIMIT 15;

-- C) Ratings by decade
WITH by_year AS (
  SELECT EXTRACT(YEAR FROM release_date)::INT yr, vote_average
  FROM movies WHERE release_date IS NOT NULL
), by_decade AS (
  SELECT (yr/10)*10 decade, AVG(vote_average) avg_rating, COUNT(*) films
  FROM by_year GROUP BY (yr/10)*10
)
SELECT decade, ROUND(avg_rating,2) avg_rating, films
FROM by_decade ORDER BY decade;

-- D) Runtime vs rating correlation
SELECT ROUND(CORR(runtime, vote_average)::numeric, 3) corr_runtime_rating
FROM movies
WHERE runtime IS NOT NULL AND vote_average IS NOT NULL;

-- E) Top director–actor pairs (>=2 films)
SELECT d.name director, a.name actor, COUNT(*) films,
       ROUND(AVG(m.revenue)) avg_rev
FROM movie_crew d
JOIN movies m ON m.tmdb_id = d.tmdb_id
JOIN movie_cast a ON a.tmdb_id = m.tmdb_id
WHERE d.job = 'Director' AND m.revenue > 0
GROUP BY d.name, a.name
HAVING COUNT(*) >= 2
ORDER BY avg_rev DESC
LIMIT 20;
