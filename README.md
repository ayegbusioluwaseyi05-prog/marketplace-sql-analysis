# Marketplace Analytics (SQL)

Synthetic data (not real company data): 60 farmers, 500 buyers, 2,789 orders over 12 months.

**Questions:** How is the platform growing? How do buyers behave? Which farmers need attention?

**Tools:** SQL (SQLite), Python. Uses joins, CTEs, and window functions.

**Findings:**
- Monthly revenue grew from about 688,000 to 3.82 million.
- Poultry earned the most revenue.
- 6 farmers had cancellation rates above 15%.

**Files:**
- `queries.sql`: the six SQL queries
- `build_and_run.py`: builds the synthetic database and runs the queries
- `results.md`: the query results

**Run it:** `python build_and_run.py` (Python 3, no installs needed)
