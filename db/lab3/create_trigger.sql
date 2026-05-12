CREATE TYPE prison_conditions AS ENUM ('low', 'medium', 'high', 'maximum');

CREATE TYPE factor_type AS ENUM ('mutiny');

CREATE TYPE accusation_type AS ENUM ('kill', 'robbery', 'mutiny');

CREATE TYPE punishment_type AS ENUM ('imprisonment', 'hanging');

CREATE TYPE event_role AS ENUM (
    'leader',
    'opposition_leader',
    'supporter',
    'opponent'
);

CREATE TYPE event_consequence AS ENUM ('death');

CREATE TYPE relationship_type AS ENUM (
    'anger',
    'hate',
    'friendship',
    'love'
);

CREATE TYPE location_climate AS ENUM ('rainy', 'sunny', 'windy');


CREATE TABLE location (
    id INT PRIMARY KEY,
    name TEXT NOT NULL,
    climate location_climate
);

CREATE TABLE human (
    id INT PRIMARY KEY,
    is_sane BOOLEAN,
    courage INT,
    job TEXT,
    first TEXT,
    middle TEXT,
    last TEXT
);

CREATE TABLE court (
    id INT PRIMARY KEY,
    name TEXT NOT NULL,
    location_id INT,
    FOREIGN KEY (location_id) REFERENCES location(id)
);

CREATE TABLE prison (
    id INT PRIMARY KEY,
    conditions prison_conditions,
    location_id INT,
    FOREIGN KEY (location_id) REFERENCES location(id)
);

CREATE TABLE event (
    id INT PRIMARY KEY,
    is_successfull BOOLEAN,
    location_id INT,
    FOREIGN KEY (location_id) REFERENCES location(id)
);

CREATE TABLE IF NOT EXISTS factor (
    id INT PRIMARY KEY,
    formula JSONB
);

CREATE TABLE accusation (
    id INT PRIMARY KEY,
    human_id INT,
    type accusation_type,
    accused_time DATE,
    court_id INT,
    FOREIGN KEY (human_id) REFERENCES human(id),
    FOREIGN KEY (court_id) REFERENCES court(id) ON DELETE SET NULL
);

CREATE TABLE punishment (
    id INT PRIMARY KEY,
    accusation_id INT,
    type punishment_type,
    execution_time DATE,
    FOREIGN KEY (accusation_id) REFERENCES accusation(id)
);

CREATE TABLE wound (
    id INT PRIMARY KEY,
    human_id INT,
    is_fatal BOOLEAN,
    dt DATE,
    is_cured BOOLEAN,
    FOREIGN KEY (human_id) REFERENCES human(id)
);

CREATE TABLE event_people (
    event_id INT,
    human_id INT,
    role event_role,
    consequence event_consequence,
    PRIMARY KEY (event_id, human_id),
    FOREIGN KEY (event_id) REFERENCES event(id),
    FOREIGN KEY (human_id) REFERENCES human(id)
);

CREATE TABLE relationships (
    human1_id INT,
    human2_id INT,
    type relationship_type,
    PRIMARY KEY (human1_id, human2_id),
    FOREIGN KEY (human1_id) REFERENCES human(id),
    FOREIGN KEY (human2_id) REFERENCES human(id)
);

CREATE TABLE court_judge (
    court_id INT,
    human_id INT,
    PRIMARY KEY (court_id, human_id),
    FOREIGN KEY (court_id) REFERENCES court(id) ON DELETE CASCADE,
    FOREIGN KEY (human_id) REFERENCES human(id)
);

CREATE TABLE prison_human (
    human_id INT,
    prison_id INT,
    imprisoned_time DATE,
    released_time DATE,
    PRIMARY KEY (human_id, prison_id, imprisoned_time),
    FOREIGN KEY (human_id) REFERENCES human(id),
    FOREIGN KEY (prison_id) REFERENCES prison(id)
);


CREATE TABLE IF NOT EXISTS factor_accusation (
    factor_id INT,
    accusation_id INT,
    PRIMARY KEY (factor_id, accusation_id),
    FOREIGN KEY (factor_id) REFERENCES factor(id),
    FOREIGN KEY (accusation_id) REFERENCES accusation(id)
);

CREATE TABLE IF NOT EXISTS factor_punishment (
    factor_id INT,
    punishment_id INT,
    PRIMARY KEY (factor_id, punishment_id),
    FOREIGN KEY (factor_id) REFERENCES factor(id),
    FOREIGN KEY (punishment_id) REFERENCES punishment(id)
);

