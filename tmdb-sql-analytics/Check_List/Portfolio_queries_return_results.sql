-- 1) Most profitable genres
SELECT mg.genre_name, COUNT(*) films,
       ROUND(AVG(m.revenue - m.budget)) AS avg_profit
FROM movies m JOIN movie_genres mg ON mg.tmdb_id = m.tmdb_id
WHERE m.budget > 0 AND m.revenue > 0
GROUP BY mg.genre_name
ORDER BY avg_profit DESC
LIMIT 10;

-- 2) Bankable directors (>=3 films)
SELECT mc.name AS director, COUNT(*) films,
       ROUND(AVG(m.revenue)) AS avg_revenue
FROM movie_crew mc JOIN movies m ON m.tmdb_id = mc.tmdb_id
WHERE mc.job = 'Director' AND m.revenue > 0
GROUP BY mc.name
HAVING COUNT(*) >= 3
ORDER BY avg_revenue DESC
LIMIT 15;

-- 3) Ratings by decade
WITH by_year AS (
  SELECT EXTRACT(YEAR FROM release_date)::INT AS yr, vote_average
  FROM movies WHERE release_date IS NOT NULL
)
SELECT (yr/10)*10 AS decade, ROUND(AVG(vote_average),2) AS avg_rating, COUNT(*) films
FROM by_year GROUP BY (yr/10)*10 ORDER BY decade;
