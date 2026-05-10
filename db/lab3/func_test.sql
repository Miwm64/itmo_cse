/*
INSERT INTO factor (id, formula)
VALUES  (5, jsonb_build_object(
        'var_amount', 2,
        'vars', jsonb_build_array('x', 'y'),
         'formula', 'x+y;'
        ));

INSERT INTO accusation (id)
VALUES (5);

INSERT INTO punishment (id, accusation_id, type, execution_time)
VALUES (5, 5, 'hanging', now());


INSERT INTO factor_punishment (factor_id, punishment_id)
VALUES (5, 5);
*/
SELECT * FROM punishment
         INNER JOIN factor_punishment ON factor_punishment.punishment_id = punishment.id
         INNER JOIN factor ON factor_punishment.factor_id = factor.id
WHERE factor.formula::jsonb->'var_amount'='3' AND calc(factor.formula, jsonb_build_array(1, 2, 1000)) > 100;

SELECT * FROM punishment
         INNER JOIN factor_punishment ON factor_punishment.punishment_id = punishment.id
         INNER JOIN factor ON factor_punishment.factor_id = factor.id
WHERE factor.formula::jsonb->'var_amount'='2' AND calc(factor.formula, jsonb_build_array(1, 2)) < 100;

SELECT * FROM punishment
         INNER JOIN factor_punishment ON factor_punishment.punishment_id = punishment.id
         INNER JOIN factor ON factor_punishment.factor_id = factor.id
WHERE factor.formula::jsonb->'var_amount'='2' AND calc(factor.formula, jsonb_build_array(1, 2)) > 100;

