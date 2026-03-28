CREATE TYPE "prison_conditions" AS ENUM ('low', 'medium', 'high', 'maximum');

CREATE TYPE "factor_type" AS ENUM ('mutiny');

CREATE TYPE "accusation_type" AS ENUM ('kill', 'robbery', 'mutiny');

CREATE TYPE "punishment_type" AS ENUM ('imprisonment', 'hanging');

CREATE TYPE "event_role" AS ENUM (
    'leader',
    'opposition_leader',
    'supporter',
    'opponent'
);

CREATE TYPE "event_consequence" AS ENUM ('death');

CREATE TYPE "relationship_type" AS ENUM (
    'anger',
    'hate',
    'friendship',
    'love'
);

CREATE TYPE "location_climate" AS ENUM ('rainy', 'sunny', 'windy');


CREATE TABLE "location"
(
    "id" INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "name" VARCHAR(50) NOT NULL,
    "climate" "location_climate"
);

CREATE TABLE "human"
(
    "id" INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "is_sane" BOOLEAN,
    "courage" SMALLINT CHECK ( "courage" BETWEEN 0 AND 100),
    "job" VARCHAR(50)
);

CREATE TABLE "prison"
(
    "id" INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "conditions" "prison_conditions",
    "location_id" INTEGER NOT NULL REFERENCES "location"("id")
);

CREATE TABLE "event"
(
    "id" INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "is_successful" BOOLEAN,
    "location_id" INTEGER NOT NULL REFERENCES "location"("id")
);

CREATE TABLE "court"
(
    "id" INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "name" VARCHAR(50),
    "location_id" INTEGER NOT NULL REFERENCES "location"("id")
);

CREATE TABLE "factor"
(
    "id" INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "type" "factor_type" NOT NULL,
    "start_time" TIMESTAMP,
    "end_time" TIMESTAMP CHECK ("end_time" IS NULL OR "end_time" >= "start_time")
);

CREATE TABLE "name"
(
    "human_id" INTEGER PRIMARY KEY REFERENCES "human"("id") ON DELETE CASCADE,
    "first" VARCHAR(50),
    "middle" VARCHAR(50),
    "last" VARCHAR(50)
);

CREATE TABLE "accusation"
(
    "id" INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "human_id" INTEGER NOT NULL REFERENCES "human"("id"),
    "type" "accusation_type",
    "accused_time" TIMESTAMP,
    "court_id" INTEGER NOT NULL REFERENCES "court"("id")
);

CREATE TABLE "punishment"
(
    "id" INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "accusation_id" INTEGER REFERENCES "accusation"("id"),
    "type" "punishment_type",
    "execution_time" TIMESTAMP
);

CREATE TABLE "wound"
(
    "id" INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "human_id" INTEGER NOT NULL  REFERENCES "human"("id") ON DELETE CASCADE,
    "is_fatal" BOOLEAN,
    "dt" TIMESTAMP,
    "is_cured" BOOLEAN
);

CREATE TABLE "event_people"
(
    "event_id" INTEGER NOT NULL REFERENCES "event"("id") ON DELETE CASCADE,
    "human_id" INTEGER NOT NULL  REFERENCES "human"("id") ON DELETE CASCADE,
    "role" "event_role",
    "consequence" "event_consequence",
    PRIMARY KEY ("event_id", "human_id")
);

CREATE TABLE "relationships"
(
    "human1_id" INTEGER NOT NULL  REFERENCES "human"("id") ON DELETE CASCADE,
    "human2_id" INTEGER NOT NULL  REFERENCES "human"("id") ON DELETE CASCADE CHECK ("human1_id" <> "human2_id"),
    "type" "relationship_type",
    PRIMARY KEY ("human1_id", "human2_id")
);

CREATE TABLE "factor_accusation"
(
    "factor_id" INTEGER NOT NULL REFERENCES "factor"("id") ON DELETE CASCADE,
    "accusation_id" INTEGER NOT NULL REFERENCES "accusation"("id") ON DELETE CASCADE,
    PRIMARY KEY ("factor_id", "accusation_id")
);

CREATE TABLE "factor_punishment"
(
    "factor_id" INTEGER NOT NULL REFERENCES "factor"("id") ON DELETE CASCADE,
    "punishment_id" INTEGER NOT NULL REFERENCES "punishment"("id") ON DELETE CASCADE,
    PRIMARY KEY ("factor_id", "punishment_id")
);

CREATE TABLE "court_judge"
(
    "court_id" INTEGER NOT NULL REFERENCES "court"("id") ON DELETE CASCADE,
    "human_id" INTEGER NOT NULL  REFERENCES "human"("id") ON DELETE CASCADE,
    PRIMARY KEY ("court_id", "human_id")
);

CREATE TABLE "prison_human"
(
    "human_id" INTEGER NOT NULL REFERENCES "human"("id") ON DELETE CASCADE,
    "prison_id" INTEGER NOT NULL REFERENCES "prison"("id") ON DELETE CASCADE,
    "imprisoned_time" TIMESTAMP NOT NULL,
    "released_time" TIMESTAMP,
    PRIMARY KEY ("human_id", "prison_id", "imprisoned_time")
);
