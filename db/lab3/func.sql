CREATE OR REPLACE FUNCTION calc(meta jsonb, vals jsonb)
RETURNS float AS $$
DECLARE
    formula TEXT;

    vars TEXT[];
    values FLOAT[];

    i INT;
    ch TEXT;

    curr_number FLOAT := 0;
    last_term FLOAT := 0;
    res FLOAT := 0;
    op TEXT := '+';
BEGIN
    formula := meta->>'formula';

    SELECT array_agg(value)
    INTO vars
    FROM jsonb_array_elements_text(meta->'vars') AS value;

    SELECT array_agg(value::FLOAT)
    INTO values
    FROM jsonb_array_elements(vals) AS value;

    FOR i IN 1..array_length(vars,1) LOOP
        formula := replace(formula, vars[i], values[i]::TEXT);
    END LOOP;

    FOR i IN 1..length(formula) LOOP
        ch := substr(formula, i, 1);

        IF ch ~ '[0-9.]' THEN
            curr_number := curr_number * 10 + ch::FLOAT;

        ELSIF ch IN ('+', '-', '*', '/', ';') THEN
            IF op = '+' THEN
                res := res + last_term;
                last_term := curr_number;

            ELSIF op = '-' THEN
                res := res + last_term;
                last_term := -curr_number;

            ELSIF op = '*' THEN
                last_term := last_term * curr_number;

            ELSIF op = '/' THEN
                last_term := last_term / curr_number;
            END IF;

            curr_number := 0;
            op := ch;

            IF ch = ';' THEN
                EXIT;
            END IF;
        END IF;
    END LOOP;

    RETURN res + last_term;
END;
$$ LANGUAGE plpgsql;

