CREATE TYPE "prison_conditions" AS ENUM (
  'low',
  'medium',
  'high',
  'maximum'
);

CREATE TYPE "location_climate" AS ENUM (
  'rainy',
  'sunny',
  'windy'
);

CREATE TYPE "factor_type" AS ENUM (
  'mutiny'
);

CREATE TYPE "accusation_type" AS ENUM (
  'kill',
  'robbery',
  'mutiny'
);

CREATE TYPE "punishment_type" AS ENUM (
  'imprisonment',
  'hanging'
);

CREATE TYPE "event_role" AS ENUM (
  'leader',
  'opposition_leader',
  'supporter',
  'opponent'
);

CREATE TYPE "event_consequence" AS ENUM (
  'death'
);

CREATE TYPE "relationship_type" AS ENUM (
  'anger',
  'hate',
  'friendship',
  'love'
);

CREATE TABLE "location" (
  "id" integer PRIMARY KEY,
  "name" varchar,
  "climate" location_climate
);

CREATE TABLE "human" (
  "id" integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  "is_sane" boolean,
  "courage" smallint,
  "job" varchar(50)
);

CREATE TABLE "prison" (
  "id" integer PRIMARY KEY,
  "conditions" prison_conditions,
  "location_id" integer NOT NULL,
  FOREIGN KEY ("location_id")
    REFERENCES "location" ("id")
);

CREATE TABLE "event" (
  "id" integer PRIMARY KEY,
  "is_successfull" boolean,
  "location_id" integer NOT NULL,
  FOREIGN KEY ("location_id")
    REFERENCES "location" ("id")
);

CREATE TABLE "court" (
  "id" integer PRIMARY KEY,
  "name" varchar(50),
  "location_id" integer NOT NULL,
  FOREIGN KEY ("location_id")
    REFERENCES "location" ("id")
);

CREATE TABLE "factor" (
  "id" integer PRIMARY KEY,
  "type" factor_type,
  "start_time" timestamp,
  "end_time" timestamp
);

CREATE TABLE "name" (
  "human_id" integer PRIMARY KEY,
  "first" varchar(50),
  "middle" varchar(50),
  "last" varchar(50),
  FOREIGN KEY ("human_id")
    REFERENCES "human" ("id")
);

CREATE TABLE "accusation" (
  "id" integer PRIMARY KEY,
  "human_id" integer NOT NULL,
  "type" accusation_type,
  "accused_time" timestamp,
  "court_id" integer NOT NULL,
  FOREIGN KEY ("human_id")
    REFERENCES "human" ("id"),
  FOREIGN KEY ("court_id")
    REFERENCES "court" ("id")
);

CREATE TABLE "punishment" (
  "id" integer PRIMARY KEY,
  "accusation_id" integer NOT NULL,
  "type" punishment_type,
  "execution_time" timestamp,
  FOREIGN KEY ("accusation_id")
    REFERENCES "accusation" ("id")
);

CREATE TABLE "wound" (
  "id" integer PRIMARY KEY,
  "human_id" integer NOT NULL,
  "is_fatal" boolean,
  "dt" timestamp,
  "is_cured" boolean,
  FOREIGN KEY ("human_id")
    REFERENCES "human" ("id")
);

CREATE TABLE "event_people" (
  "event_id" integer NOT NULL,
  "human_id" integer NOT NULL,
  "role" event_role,
  "consequence" event_consequence,
  PRIMARY KEY ("event_id","human_id"),
  FOREIGN KEY ("event_id")
    REFERENCES "event" ("id"),
  FOREIGN KEY ("human_id")
    REFERENCES "human" ("id")
);

CREATE TABLE "relationships" (
  "human1_id" integer NOT NULL,
  "human2_id" integer NOT NULL,
  "type" relationship_type,
  PRIMARY KEY ("human1_id","human2_id"),
  FOREIGN KEY ("human1_id")
    REFERENCES "human" ("id"),
  FOREIGN KEY ("human2_id")
    REFERENCES "human" ("id")
);

CREATE TABLE "factor_accusation" (
  "factor_id" integer NOT NULL,
  "accusation_id" integer NOT NULL,
  PRIMARY KEY ("factor_id","accusation_id"),
  FOREIGN KEY ("factor_id")
    REFERENCES "factor" ("id"),
  FOREIGN KEY ("accusation_id")
    REFERENCES "accusation" ("id")
);

CREATE TABLE "factor_punishment" (
  "factor_id" integer NOT NULL,
  "punishment_id" integer NOT NULL,
  PRIMARY KEY ("factor_id","punishment_id"),
  FOREIGN KEY ("factor_id")
    REFERENCES "factor" ("id"),
  FOREIGN KEY ("punishment_id")
    REFERENCES "punishment" ("id")
);

CREATE TABLE "court_judge" (
  "court_id" integer NOT NULL,
  "human_id" integer NOT NULL,
  PRIMARY KEY ("court_id","human_id"),
  FOREIGN KEY ("court_id")
    REFERENCES "court" ("id"),
  FOREIGN KEY ("human_id")
    REFERENCES "human" ("id")
);

CREATE TABLE "prison_human" (
  "human_id" integer NOT NULL,
  "prison_id" integer NOT NULL,
  "imprisoned_time" timestamp,
  "released_time" timestamp,
  PRIMARY KEY ("human_id","prison_id","imprisoned_time"),
  FOREIGN KEY ("human_id")
    REFERENCES "human" ("id"),
  FOREIGN KEY ("prison_id")
    REFERENCES "prison" ("id")
);
