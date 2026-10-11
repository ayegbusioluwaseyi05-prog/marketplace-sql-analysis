# Query results (synthetic data)


## Q1: Platform growth by month (orders, revenue, active buyers, month-on-month revenue growth)

| month | orders | active_buyers | revenue | revenue_growth_pct |
|---|---|---|---|---|
| 2025-10 | 76 | 42 | 687530.0 | None |
| 2025-11 | 89 | 55 | 693770.0 | 0.9 |
| 2025-12 | 104 | 69 | 816700.0 | 17.7 |
| 2026-01 | 125 | 88 | 994420.0 | 21.8 |
| 2026-02 | 144 | 105 | 1257230.0 | 26.4 |
| 2026-03 | 165 | 122 | 1401270.0 | 11.5 |
| 2026-04 | 192 | 148 | 1507380.0 | 7.6 |
| 2026-05 | 227 | 160 | 1742380.0 | 15.6 |
| 2026-06 | 277 | 208 | 2487570.0 | 42.8 |
| 2026-07 | 323 | 220 | 2735720.0 | 10.0 |
| 2026-08 | 380 | 257 | 3048390.0 | 11.4 |
| 2026-09 | 453 | 298 | 3823450.0 | 25.4 |

## Q2: Buyer behavior - one-time vs repeat buyers

| buyer_type | buyers | pct_of_buyers |
|---|---|---|
| One-time | 56 | 11.8 |
| Repeat (2+) | 418 | 88.2 |

## Q3: Buyer behavior - what categories sell and at what average order value

| category | orders | revenue | avg_order_value |
|---|---|---|---|
| Poultry | 395 | 9152840.0 | 23172.0 |
| Grains | 638 | 4903580.0 | 7686.0 |
| Tubers | 523 | 3142920.0 | 6009.0 |
| Fruits | 475 | 2146960.0 | 4520.0 |
| Vegetables | 524 | 1849510.0 | 3530.0 |

## Q4: Farmer performance - revenue, orders, cancellation rate, and revenue rank

| farmer | state | total_orders | revenue | cancel_rate_pct | revenue_rank |
|---|---|---|---|---|---|
| Farmer 04 | Ogun | 63 | 1107390.0 | 4.8 | 1 |
| Farmer 29 | Kano | 73 | 1000050.0 | 4.1 | 2 |
| Farmer 11 | Kano | 29 | 897440.0 | 3.4 | 3 |
| Farmer 35 | Lagos | 73 | 884460.0 | 4.1 | 4 |
| Farmer 45 | Ogun | 69 | 877460.0 | 2.9 | 5 |
| Farmer 07 | Lagos | 79 | 810670.0 | 3.8 | 6 |
| Farmer 01 | Benue | 85 | 768520.0 | 4.7 | 7 |
| Farmer 42 | Benue | 75 | 749090.0 | 4.0 | 8 |
| Farmer 60 | Kano | 47 | 718730.0 | 19.1 | 9 |
| Farmer 06 | Lagos | 82 | 700930.0 | 6.1 | 10 |

## Q5: Farmers needing attention - high cancellation rate

| farmer | state | total_orders | cancel_rate_pct |
|---|---|---|---|
| Farmer 36 | Ondo | 63 | 38.1 |
| Farmer 14 | Kaduna | 58 | 32.8 |
| Farmer 05 | Benue | 54 | 25.9 |
| Farmer 49 | Ondo | 83 | 25.3 |
| Farmer 54 | Kano | 34 | 23.5 |
| Farmer 60 | Kano | 47 | 19.1 |

## Q6: Data quality check - orders with missing or impossible values

| non_positive_quantity | missing_date | orphan_buyers |
|---|---|---|
| 0 | 0 | 0 |

_Total synthetic orders: 2789_
