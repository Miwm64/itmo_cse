-- =========================
-- LOCATION
-- =========================
CREATE TABLE location (
    id INT PRIMARY KEY,
    name TEXT NOT NULL,
    climate TEXT
);

-- =========================
-- HUMAN
-- =========================
CREATE TABLE human (
    id INT PRIMARY KEY,
    is_sane BOOLEAN,
    courage INT,
    job TEXT,
    first TEXT,
    middle TEXT,
    last TEXT
);

-- =========================
-- COURT
-- =========================
CREATE TABLE court (
    id INT PRIMARY KEY,
    name TEXT NOT NULL,
    location_id INT,
    location_name TEXT,
    FOREIGN KEY (location_id) REFERENCES location(id)
);

-- =========================
-- PRISON
-- =========================
CREATE TABLE prison (
    id INT PRIMARY KEY,
    conditions TEXT,
    location_id INT,
    FOREIGN KEY (location_id) REFERENCES location(id)
);

-- =========================
-- EVENT
-- =========================
CREATE TABLE event (
    id INT PRIMARY KEY,
    is_successfull BOOLEAN,
    location_id INT,
    FOREIGN KEY (location_id) REFERENCES location(id)
);

-- =========================
-- FACTOR
-- =========================
CREATE TABLE factor (
    id INT PRIMARY KEY,
    type TEXT,
    start_time DATE,
    end_time DATE
);

-- =========================
-- ACCUSATION
-- =========================
CREATE TABLE accusation (
    id INT PRIMARY KEY,
    human_id INT,
    type TEXT,
    accused_time DATE,
    court_id INT,
    court_name TEXT,
    FOREIGN KEY (human_id) REFERENCES human(id),
    FOREIGN KEY (court_id) REFERENCES court(id)
);

-- =========================
-- PUNISHMENT
-- =========================
CREATE TABLE punishment (
    id INT PRIMARY KEY,
    accusation_id INT,
    type TEXT,
    execution_time DATE,
    FOREIGN KEY (accusation_id) REFERENCES accusation(id)
);

-- =========================
-- WOUND
-- =========================
CREATE TABLE wound (
    id INT PRIMARY KEY,
    human_id INT,
    is_fatal BOOLEAN,
    dt DATE,
    is_cured BOOLEAN,
    FOREIGN KEY (human_id) REFERENCES human(id)
);

-- =========================
-- EVENT_PEOPLE
-- =========================
CREATE TABLE event_people (
    event_id INT,
    human_id INT,
    role TEXT,
    consequence TEXT,
    PRIMARY KEY (event_id, human_id),
    FOREIGN KEY (event_id) REFERENCES event(id),
    FOREIGN KEY (human_id) REFERENCES human(id)
);

-- =========================
-- RELATIONSHIPS
-- =========================
CREATE TABLE relationships (
    human1_id INT,
    human2_id INT,
    type TEXT,
    PRIMARY KEY (human1_id, human2_id),
    FOREIGN KEY (human1_id) REFERENCES human(id),
    FOREIGN KEY (human2_id) REFERENCES human(id)
);

-- =========================
-- FACTOR_ACCUSATION
-- =========================
CREATE TABLE factor_accusation (
    factor_id INT,
    accusation_id INT,
    PRIMARY KEY (factor_id, accusation_id),
    FOREIGN KEY (factor_id) REFERENCES factor(id),
    FOREIGN KEY (accusation_id) REFERENCES accusation(id)
);

-- =========================
-- FACTOR_PUNISHMENT
-- =========================
CREATE TABLE factor_punishment (
    factor_id INT,
    punishment_id INT,
    PRIMARY KEY (factor_id, punishment_id),
    FOREIGN KEY (factor_id) REFERENCES factor(id),
    FOREIGN KEY (punishment_id) REFERENCES punishment(id)
);

-- =========================
-- COURT_JUDGE
-- =========================
CREATE TABLE court_judge (
    court_id INT,
    human_id INT,
    PRIMARY KEY (court_id, human_id),
    FOREIGN KEY (court_id) REFERENCES court(id),
    FOREIGN KEY (human_id) REFERENCES human(id)
);

-- =========================
-- PRISON_HUMAN
-- =========================
CREATE TABLE prison_human (
    human_id INT,
    prison_id INT,
    imprisoned_time DATE,
    released_time DATE,
    PRIMARY KEY (human_id, prison_id, imprisoned_time),
    FOREIGN KEY (human_id) REFERENCES human(id),
    FOREIGN KEY (prison_id) REFERENCES prison(id)
);
