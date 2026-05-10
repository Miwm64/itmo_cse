DELETE FROM prison_human;
DELETE FROM event_people;
DELETE FROM factor_punishment;
DELETE FROM factor_accusation;
DELETE FROM punishment;
DELETE FROM accusation;
DELETE FROM factor;
DELETE FROM wound;
DELETE FROM relationships;
DELETE FROM court_judge;
DELETE FROM event;
DELETE FROM prison;
DELETE FROM court;
DELETE FROM human;
DELETE FROM prison_human;
DELETE FROM event_people;
DELETE FROM factor_punishment;
DELETE FROM factor_accusation;
DELETE FROM punishment;
DELETE FROM accusation;
DELETE FROM factor;
DELETE FROM wound;
DELETE FROM relationships;
DELETE FROM court_judge;
DELETE FROM event;
DELETE FROM prison;
DELETE FROM court;
DELETE FROM human;
DELETE FROM location;


INSERT INTO location (id, name, climate) VALUES
(1, 'Moscow', 'rainy'),
(2, 'Saint Petersburg', 'rainy'),
(3, 'Siberia', 'rainy');

INSERT INTO prison (id, conditions, location_id) VALUES
(1, 'low', 1),
(2, 'medium', 1),
(3, 'maximum', 3),
(4, 'medium', 2);

INSERT INTO court (id, name, location_id) VALUES
(1, 'Moscow District Court', 1),
(2, 'Moscow City Court', 1),
(3, 'Petersburg District Court', 2),
(4, 'Siberian Court', 3);

INSERT INTO human (id, is_sane, courage, job, first, middle, last) VALUES
(1, TRUE, 8, 'judge', 'Ivan', 'Petrovich', 'Smirnov'),
(2, TRUE, 7, 'judge', 'Olga', 'Sergeevna', 'Ivanova'),
(3, TRUE, 9, 'judge', 'Dmitry', 'Alexeevich', 'Volkov'),
(4, FALSE, 3, 'judge', 'Anna', 'Ivanovna', 'Kozlova'),
(5, TRUE, 6, 'judge', 'Sergey', 'Mikhailovich', 'Popov');

INSERT INTO human (id, is_sane, courage, job, first, middle, last) VALUES
(6, TRUE, 5, 'thief', 'Vladimir', NULL, 'Petrov'),
(7, FALSE, 2, 'murderer', 'Alexey', 'Viktorovich', 'Sidorov');

INSERT INTO court_judge (court_id, human_id) VALUES
(1, 1),
(1, 2),
(2, 3),
(3, 4),
(4, 5);

INSERT INTO accusation (id, human_id, type, accused_time, court_id) VALUES
(1, 3, 'kill', '2024-01-15 10:00:00', 1),
(2, 5, 'kill', '2024-02-20 14:00:00', 3);

INSERT INTO accusation (id, human_id, type, accused_time, court_id) VALUES
(3, 6, 'robbery', '2024-03-10 09:00:00', 2),
(4, 7, 'kill', '2024-04-05 11:00:00', 4);

INSERT INTO relationships (human1_id, human2_id, type) VALUES
(1, 2, 'love'),
(1, 3, 'love'),
(4, 5, 'love');

SELECT * FROM court_judge;

-- Use trigger
DELETE FROM court WHERE id = 4;

-- Check results
SELECT * FROM court;

SELECT * FROM court_judge;


SELECT ph.*, p.location_id, h.first, h.last
FROM prison_human ph
JOIN human h ON ph.human_id = h.id
JOIN prison p ON ph.prison_id = p.id;


SELECT * FROM event;

SELECT * FROM event_people;
