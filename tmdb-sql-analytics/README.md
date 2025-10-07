# TMDB Movie SQL Analytics Project

### Overview
A PostgreSQL analytics project analyzing 5,000+ TMDB movie records.  
Designed a full data pipeline from raw CSV ingestion to cleaned, normalized relational tables, and performed business-style analytics using advanced SQL.

### Tech Stack
- PostgreSQL 17
- pgAdmin 4
- SQL (CTEs, Window Functions, JSON Parsing)

### Pipeline Steps
1. **Staging:** Loaded raw CSV data into PostgreSQL (`tmdb_movies_raw`, `tmdb_credits_raw`).
2. **Cleaning:** Deduplicated movie records using window functions and type-casted columns.
3. **Normalization:** Parsed JSON fields into separate relational tables (`movie_genres`, `movie_cast`, `movie_crew`).
4. **Analysis:** Wrote complex SQL queries to generate insights.

### Raw Data
The TMDB 5000 dataset (movies and credits CSVs) used for this analysis.
Original source: https://www.kaggle.com/datasets/tmdb/tmdb-movie-metadata
(Not uploaded due to file size limits.)


### Insights
| Question | Description |
| Most Profitable Genres | Action and Adventure lead with avg profit over \$150M |
| Bankable Directors | James Cameron & Peter Jackson top avg revenues |
| Rating Trends | Movie ratings peaked in the 1990s |
| Top Director–Actor Pairs | Spielberg + Tom Hanks are top earners |

### Outputs
- `outputs/top_genre_profit.csv`
- `outputs/bankable_directors.csv`
- `outputs/ratings_by_decade.csv`

### Skills Demonstrated
- Data cleaning & normalization
- SQL joins, aggregates, CTEs, correlations
- Business storytelling through data

