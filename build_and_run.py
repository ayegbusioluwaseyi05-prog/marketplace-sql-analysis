"""Builds a SYNTHETIC marketplace database (not real Jaba Market data) and runs queries.sql."""
import sqlite3, random, datetime as dt, re
random.seed(42)
con = sqlite3.connect(":memory:")
cur = con.cursor()
cur.executescript("""
CREATE TABLE farmers(farmer_id INTEGER PRIMARY KEY, name TEXT, state TEXT, joined_date TEXT);
CREATE TABLE products(product_id INTEGER PRIMARY KEY, farmer_id INTEGER, category TEXT, unit_price REAL);
CREATE TABLE buyers(buyer_id INTEGER PRIMARY KEY, state TEXT, signup_date TEXT);
CREATE TABLE orders(order_id INTEGER PRIMARY KEY, buyer_id INTEGER, product_id INTEGER, quantity INTEGER, order_date TEXT, status TEXT);
""")
states = ["Lagos", "Ogun", "Oyo", "Kaduna", "Kano", "Benue", "Ondo"]
cats = {"Grains": (900, 2500), "Vegetables": (300, 1200), "Tubers": (500, 1800), "Fruits": (400, 1500), "Poultry": (3000, 6500)}
for i in range(1, 61):
    cur.execute("INSERT INTO farmers VALUES(?,?,?,?)", (i, f"Farmer {i:02d}", random.choice(states), "2025-%02d-01" % random.randint(1, 9)))
pid = 1
for f in range(1, 61):
    for c in random.sample(list(cats), random.randint(1, 3)):
        lo, hi = cats[c]
        cur.execute("INSERT INTO products VALUES(?,?,?,?)", (pid, f, c, round(random.uniform(lo, hi), -1)))
        pid += 1
n_products = pid - 1
start = dt.date(2025, 10, 1)
for b in range(1, 501):
    cur.execute("INSERT INTO buyers VALUES(?,?,?)", (b, random.choice(states), (start + dt.timedelta(days=random.randint(0, 330))).isoformat()))
high_cancel = set(random.sample(range(1, 61), 6))
oid = 1
for m in range(12):
    n = int(80 * (1.18 ** m))  # growing platform
    month_start = dt.date(2025 + (9 + m) // 12, (9 + m) % 12 + 1, 1)
    for _ in range(n):
        buyer = random.randint(1, min(500, 60 + m * 40))
        prod = random.randint(1, n_products)
        farmer = cur.execute("SELECT farmer_id FROM products WHERE product_id=?", (prod,)).fetchone()[0]
        p_cancel = 0.30 if farmer in high_cancel else 0.06
        status = "cancelled" if random.random() < p_cancel else "delivered"
        d = month_start + dt.timedelta(days=random.randint(0, 27))
        cur.execute("INSERT INTO orders VALUES(?,?,?,?,?,?)", (oid, buyer, prod, random.randint(1, 8), d.isoformat(), status))
        oid += 1
sql = open("queries.sql").read()
blocks = re.split(r"(?m)^-- (Q\d+: .*)$", sql)
out = ["# Query results (synthetic data)\n"]
for title, body in zip(blocks[1::2], blocks[2::2]):
    q = "\n".join(l for l in body.splitlines() if not l.startswith("-- Business")).strip()
    cur.execute(q.rstrip(";"))
    cols = [c[0] for c in cur.description]
    rows = cur.fetchall()
    out.append(f"\n## {title}\n\n| " + " | ".join(cols) + " |\n|" + "---|" * len(cols))
    for r in rows:
        out.append("| " + " | ".join(str(x) for x in r) + " |")
total = cur.execute("SELECT COUNT(*) FROM orders").fetchone()[0]
out.append(f"\n_Total synthetic orders: {total}_")
open("results.md", "w").write("\n".join(out) + "\n")
print("\n".join(out))
