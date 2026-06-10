import random
from datetime import datetime, timedelta
import os

# 🔧 Configuration
NUM_USERS = 12500
NUM_ORDERS = 13000  # 1 user can have many orders
NUM_ITEMS = 14000   # 1 order can have many items
OUTPUT_FILE = "seed_data.sql"

# 🌍 Realistic Data Pools (weighted for index selectivity testing)
DOMAINS = ["gmail.com", "yahoo.com", "outlook.com", "corp.net", "mail.org"]
FIRST_NAMES = ["alice", "bob", "charlie", "diana", "eve", "frank", "grace", "henry", "ivy", "jack"]
REGIONS = ["US-WEST", "US-EAST", "EU-CENTRAL", "ASIA-PAC", "LATAM"]
USER_STATUSES = ["active"] * 70 + ["inactive"] * 20 + ["suspended"] * 10  # 70% active
ORDER_STATUSES = ["pending", "completed", "completed", "shipped", "cancelled"]  # Skewed
COUNTRIES = ["US"] * 30 + ["CA", "UK", "DE", "JP", "BR", "AU", "FR", "IN", "MX"]  # US-heavy
PRODUCT_IDS = list(range(1, 51))  # 50 distinct products

def random_date(start, end):
    delta = end - start
    rand_sec = random.randint(0, int(delta.total_seconds()))
    return start + timedelta(seconds=rand_sec)

def generate_users():
    users = []
    for i in range(1, NUM_USERS + 1):
        email = f"{random.choice(FIRST_NAMES)}.user{i}@{random.choice(DOMAINS)}"
        status = random.choice(USER_STATUSES)
        region = random.choice(REGIONS)
        created = random_date(datetime(2020, 1, 1), datetime(2023, 12, 31))
        users.append((i, email, status, region, created))
    return users

def generate_orders(user_ids):
    orders = []
    for i in range(1, NUM_ORDERS + 1):
        uid = random.choice(user_ids)
        odate = random_date(datetime(2021, 1, 1), datetime(2024, 6, 1))
        amount = round(random.uniform(10.50, 999.99), 2)
        status = random.choice(ORDER_STATUSES)
        country = random.choice(COUNTRIES)
        orders.append((i, uid, odate, amount, status, country))
    return orders

def generate_items(order_ids):
    items = []
    for i in range(1, NUM_ITEMS + 1):
        oid = random.choice(order_ids)
        pid = random.choice(PRODUCT_IDS)
        qty = random.randint(1, 5)
        price = round(random.uniform(5.00, 150.00), 2)
        items.append((i, oid, pid, qty, price))
    return items

# 🛡️ Safe SQL Value Formatter
def fmt_val(v):
    if isinstance(v, str):
        return f"'{v.replace(chr(39), chr(39)*2)}'"  # Escape single quotes
    elif isinstance(v, datetime):
        return f"'{v.strftime('%Y-%m-%d %H:%M:%S')}'"
    else:
        return str(v)

# 📝 Batch INSERT Writer
def write_inserts(f, table, cols, rows, batch_size=200):
    for i in range(0, len(rows), batch_size):
        batch = rows[i:i+batch_size]
        values = ",\n".join(f"({', '.join(fmt_val(v) for v in r)})" for r in batch)
        f.write(f"INSERT INTO {table} ({', '.join(cols)}) VALUES\n{values};\n\n")

if __name__ == "__main__":
    print("🔄 Generating correlated data...")
    
    user_ids = list(range(1, NUM_USERS + 1))
    order_ids = list(range(1, NUM_ORDERS + 1))
    
    users_data = generate_users()
    orders_data = generate_orders(user_ids)
    items_data = generate_items(order_ids)

    with open(OUTPUT_FILE, "w", encoding="utf-8") as f:
        f.write("-- 🌱 Seed Data for users, orders, order_items\n")
        f.write("-- ⚠️ Run this AFTER creating tables & indexes\n\n")

        write_inserts(f, "users", 
                      ["user_id", "email", "status", "region_code", "created_at"], 
                      users_data)
        write_inserts(f, "orders", 
                      ["order_id", "user_id", "order_date", "total_amount", "status", "shipping_country"], 
                      orders_data)
        write_inserts(f, "order_items", 
                      ["item_id", "order_id", "product_id", "quantity", "price_at_purchase"], 
                      items_data)

        # 🔁 Reset sequences so future SERIAL inserts don't collide
        f.write("-- 🔄 Reset PostgreSQL sequences (adjust for MySQL/SQLite if needed)\n")
        f.write(f"SELECT setval('users_user_id_seq', {NUM_USERS});\n")
        f.write(f"SELECT setval('orders_order_id_seq', {NUM_ORDERS});\n")
        f.write(f"SELECT setval('order_items_item_id_seq', {NUM_ITEMS});\n")

    print(f"✅ Done! Generated:")
    print(f"   👤 {len(users_data)} Users")
    print(f"   📦 {len(orders_data)} Orders")
    print(f"   🧾 {len(items_data)} Order Items")
    print(f"📄 Saved to: {os.path.abspath(OUTPUT_FILE)}")
