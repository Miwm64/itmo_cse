-- 1. Person with a surname alphabetically > 'Иванов'
INSERT INTO "Н_ЛЮДИ" ("ИД", "ФАМИЛИЯ")
VALUES (15000, 'Петров');

-- 2. Training record linked to the same person + required code
INSERT INTO "Н_ОБУЧЕНИЯ" ("ЧЛВК_ИД", "НЗК")
VALUES (15000, '001000');

-- 3. Student record linked to the same person
INSERT INTO "Н_УЧЕНИКИ" ("ЧЛВК_ИД", "ГРУППА")
VALUES (15000, 'P3106');
