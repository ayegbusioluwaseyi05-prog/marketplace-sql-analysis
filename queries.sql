-- Marketplace Analytics (synthetic data) - SQL queries
-- Business questions: buyer behavior, farmer performance, platform growth

-- Q1: Platform growth by month (orders, revenue, active buyers, month-on-month revenue growth)
WITH monthly AS (
  SELECT strftime('%Y-%m', order_date) AS month,
         COUNT(*) AS orders,
         COUNT(DISTINCT buyer_id) AS active_buyers,
         ROUND(SUM(quantity * unit_price), 0) AS revenue
  FROM orders o
  JOIN products p ON p.product_id = o.product_id
  WHERE o.status = 'delivered'
  GROUP BY month
)
SELECT month, orders, active_buyers, revenue,
       ROUND(100.0 * (revenue - LAG(revenue) OVER (ORDER BY month)) / LAG(revenue) OVER (ORDER BY month), 1) AS revenue_growth_pct
FROM monthly
ORDER BY month;

-- Q2: Buyer behavior - one-time vs repeat buyers
WITH buyer_orders AS (
  SELECT buyer_id, COUNT(*) AS n_orders
  FROM orders WHERE status = 'delivered'
  GROUP BY buyer_id
)
SELECT CASE WHEN n_orders = 1 THEN 'One-time' ELSE 'Repeat (2+)' END AS buyer_type,
       COUNT(*) AS buyers,
       ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM buyer_orders), 1) AS pct_of_buyers
FROM buyer_orders
GROUP BY buyer_type;

-- Q3: Buyer behavior - what categories sell and at what average order value
SELECT p.category,
       COUNT(*) AS orders,
       ROUND(SUM(o.quantity * p.unit_price), 0) AS revenue,
       ROUND(AVG(o.quantity * p.unit_price), 0) AS avg_order_value
FROM orders o
JOIN products p ON p.product_id = o.product_id
WHERE o.status = 'delivered'
GROUP BY p.category
ORDER BY revenue DESC;

-- Q4: Farmer performance - revenue, orders, cancellation rate, and revenue rank
SELECT f.name AS farmer, f.state,
       COUNT(*) AS total_orders,
       ROUND(SUM(CASE WHEN o.status = 'delivered' THEN o.quantity * p.unit_price ELSE 0 END), 0) AS revenue,
       ROUND(100.0 * SUM(CASE WHEN o.status = 'cancelled' THEN 1 ELSE 0 END) / COUNT(*), 1) AS cancel_rate_pct,
       RANK() OVER (ORDER BY SUM(CASE WHEN o.status = 'delivered' THEN o.quantity * p.unit_price ELSE 0 END) DESC) AS revenue_rank
FROM orders o
JOIN products p ON p.product_id = o.product_id
JOIN farmers f ON f.farmer_id = p.farmer_id
GROUP BY f.farmer_id
HAVING total_orders >= 20
ORDER BY revenue_rank
LIMIT 10;

-- Q5: Farmers needing attention - high cancellation rate
SELECT f.name AS farmer, f.state,
       COUNT(*) AS total_orders,
       ROUND(100.0 * SUM(CASE WHEN o.status = 'cancelled' THEN 1 ELSE 0 END) / COUNT(*), 1) AS cancel_rate_pct
FROM orders o
JOIN products p ON p.product_id = o.product_id
JOIN farmers f ON f.farmer_id = p.farmer_id
GROUP BY f.farmer_id
HAVING total_orders >= 20 AND cancel_rate_pct > 15
ORDER BY cancel_rate_pct DESC;

-- Q6: Data quality check - orders with missing or impossible values
SELECT
  SUM(CASE WHEN quantity <= 0 THEN 1 ELSE 0 END) AS non_positive_quantity,
  SUM(CASE WHEN order_date IS NULL THEN 1 ELSE 0 END) AS missing_date,
  SUM(CASE WHEN buyer_id NOT IN (SELECT buyer_id FROM buyers) THEN 1 ELSE 0 END) AS orphan_buyers
FROM orders;
