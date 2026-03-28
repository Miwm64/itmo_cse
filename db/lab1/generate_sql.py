import random
from datetime import datetime, timedelta

def random_bool(): 
    return random.choice(['TRUE', 'FALSE'])

def random_enum(options): 
    return f"'{random.choice(options)}'"

def random_string(prefix): 
    return f"'{prefix}_{random.randint(1, 1000)}'"

def random_courage(): 
    return random.randint(0, 100)

def random_date(start_year=2000, end_year=2025):
    start = datetime(start_year,1,1)
    end = datetime(end_year,12,31)
    delta = end - start
    random_days = random.randint(0, delta.days)
    random_seconds = random.randint(0, 86400)
    return start + timedelta(days=random_days, seconds=random_seconds)

def format_date(dt):
    return f"'{dt.isoformat()}'"

# ENUM definitions
prison_conditions = ['low', 'medium', 'high', 'maximum']
factor_types = ['mutiny']
accusation_types = ['kill', 'robbery', 'mutiny']
punishment_types = ['imprisonment', 'hanging']
event_roles = ['leader', 'opposition_leader', 'supporter', 'opponent']
event_consequences = ['death']
relationship_types = ['anger', 'hate', 'friendship', 'love']
location_climates = ['rainy', 'sunny', 'windy']

# Pools for FK simulation
locations = list(range(1, 6))
humans = list(range(1, 11))
prisons = list(range(1, 4))
events = list(range(1, 6))
courts = list(range(1, 4))
factors = list(range(1, 4))
accusations = list(range(1, 11))
punishments = list(range(1, 11))

sql = []

# Locations
for _ in locations:
    sql.append(f"INSERT INTO location (name, climate) VALUES ({random_string('loc')}, {random_enum(location_climates)});")

# Humans + Names
for human_id in humans:
    sql.append(f"INSERT INTO human (is_sane, courage, job) VALUES ({random_bool()}, {random_courage()}, {random_string('job')});")
    sql.append(f"INSERT INTO name (human_id, first, middle, last) VALUES ({human_id}, {random_string('first')}, {random_string('middle')}, {random_string('last')});")

# Prisons
for _ in prisons:
    sql.append(f"INSERT INTO prison (conditions, location_id) VALUES ({random_enum(prison_conditions)}, {random.choice(locations)});")

# Events
for _ in events:
    sql.append(f"INSERT INTO event (is_successful, location_id) VALUES ({random_bool()}, {random.choice(locations)});")

# Courts
for _ in courts:
    sql.append(f"INSERT INTO court (name, location_id) VALUES ({random_string('court')}, {random.choice(locations)});")

# Factors with start < end
for _ in factors:
    start = random_date()
    end = random_date()
    if end < start:
        start, end = end, start
    sql.append(f"INSERT INTO factor (type, start_time, end_time) VALUES ({random_enum(factor_types)}, {format_date(start)}, {format_date(end)});")

# Accusations
for _ in accusations:
    sql.append(f"INSERT INTO accusation (human_id, type, accused_time, court_id) VALUES ({random.choice(humans)}, {random_enum(accusation_types)}, {format_date(random_date())}, {random.choice(courts)});")

# Punishments
for _ in punishments:
    sql.append(f"INSERT INTO punishment (accusation_id, type, execution_time) VALUES ({random.choice(accusations)}, {random_enum(punishment_types)}, {format_date(random_date())});")

# Wounds
for human_id in humans:
    sql.append(f"INSERT INTO wound (human_id, is_fatal, dt, is_cured) VALUES ({human_id}, {random_bool()}, {format_date(random_date())}, {random_bool()});")

# Event_people
for _ in range(15):
    sql.append(f"INSERT INTO event_people (event_id, human_id, role, consequence) VALUES ({random.choice(events)}, {random.choice(humans)}, {random_enum(event_roles)}, {random_enum(event_consequences)});")

# Relationships
for _ in range(15):
    h1, h2 = random.sample(humans, 2)
    sql.append(f"INSERT INTO relationships (human1_id, human2_id, type) VALUES ({h1}, {h2}, {random_enum(relationship_types)});")

# Factor_accusation
for _ in range(10):
    sql.append(f"INSERT INTO factor_accusation (factor_id, accusation_id) VALUES ({random.choice(factors)}, {random.choice(accusations)});")

# Factor_punishment
for _ in range(10):
    sql.append(f"INSERT INTO factor_punishment (factor_id, punishment_id) VALUES ({random.choice(factors)}, {random.choice(punishments)});")

# Court_judge
for _ in range(10):
    sql.append(f"INSERT INTO court_judge (court_id, human_id) VALUES ({random.choice(courts)}, {random.choice(humans)});")

# Prison_human
for _ in range(10):
    sql.append(f"INSERT INTO prison_human (human_id, prison_id, imprisoned_time, released_time) VALUES ({random.choice(humans)}, {random.choice(prisons)}, {format_date(random_date())}, {format_date(random_date())});")

# Output
for line in sql:
    print(line)
