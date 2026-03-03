
INSERT INTO "location" VALUES (1,'Capital','sunny');
INSERT INTO "location" VALUES (2,'North District','windy');
INSERT INTO "human" ("is_sane", "courage", "job") VALUES (true, 0, '1');
INSERT INTO "human" ("is_sane", "courage", "job") VALUES (true, 0, '2');
INSERT INTO "human" ("is_sane", "courage", "job") VALUES (true, 0, '3');
INSERT INTO "human" ("is_sane", "courage", "job") VALUES (true, 0, '4');
INSERT INTO "human" ("is_sane", "courage", "job") VALUES (true, 0, '5');
INSERT INTO "human" ("is_sane", "courage", "job") VALUES (true, 0, '6');
INSERT INTO "human" ("is_sane", "courage", "job") VALUES (true, 0, '7');
INSERT INTO "human" ("is_sane", "courage", "job") VALUES (true, 0, '8');
INSERT INTO "relationships" VALUES (1, 2, 'love');
INSERT INTO "relationships" VALUES (2, 1, 'hate');
INSERT INTO "relationships" VALUES (3, 4, 'hate');
INSERT INTO "relationships" VALUES (4, 3, 'hate');
INSERT INTO "relationships" VALUES (5, 6, 'love');
INSERT INTO "relationships" VALUES (6, 5, 'love');

INSERT INTO "court" VALUES (1, 'court1', 1);
INSERT INTO "court" VALUES (2, 'court2', 1);
INSERT INTO "court" VALUES (3, 'court4', 2);

INSERT INTO "court_judge" VALUES (1, 2);
INSERT INTO "court_judge" VALUES (1, 3);
INSERT INTO "court_judge" VALUES (3, 4);
INSERT INTO "court_judge" VALUES (2, 5);


