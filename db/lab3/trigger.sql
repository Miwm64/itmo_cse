CREATE OR REPLACE FUNCTION delete_court()
RETURNS TRIGGER AS $$
DECLARE
    v_event_id INTEGER;
    v_judge RECORD;
    v_new_court_id INTEGER;
    v_has_criminal_record BOOLEAN;
    v_prison_id INTEGER;
    v_max_event_id INTEGER;
BEGIN
    SELECT COALESCE(MAX(id), 0) + 1 INTO v_max_event_id FROM event;

    INSERT INTO event (id, is_successfull, location_id)
    VALUES (v_max_event_id, TRUE, OLD.location_id)
    RETURNING id INTO v_event_id;

    FOR v_judge IN (
        SELECT h.id as human_id, h.first, h.middle, h.last
        FROM court_judge cj
        JOIN human h ON cj.human_id = h.id
        WHERE cj.court_id = OLD.id
    ) LOOP
        INSERT INTO event_people (event_id, human_id, role, consequence)
        VALUES (v_event_id, v_judge.human_id, null, null);

        SELECT c.id INTO v_new_court_id
        FROM court c
        LEFT JOIN court_judge cj ON c.id = cj.court_id
        WHERE c.location_id = OLD.location_id
          AND c.id != OLD.id
        GROUP BY c.id
        ORDER BY COUNT(cj.human_id) ASC
        LIMIT 1;

        IF v_new_court_id IS NULL THEN
            SELECT c.id INTO v_new_court_id
            FROM court c
            LEFT JOIN court_judge cj ON c.id = cj.court_id
            WHERE c.id != OLD.id
            GROUP BY c.id
            ORDER BY RANDOM()
            LIMIT 1;
        END IF;

        IF v_new_court_id IS NOT NULL THEN
            INSERT INTO court_judge (court_id, human_id)
            VALUES (v_new_court_id, v_judge.human_id);
        END IF;

        SELECT EXISTS(
            SELECT 1
            FROM accusation a
            WHERE a.human_id = v_judge.human_id
        ) INTO v_has_criminal_record;

        IF v_has_criminal_record THEN
            SELECT p.id INTO v_prison_id
            FROM prison p
            WHERE p.location_id = OLD.location_id
            LIMIT 1;

            IF v_prison_id IS NULL THEN
                SELECT p.id INTO v_prison_id
                FROM prison p
                LIMIT 1;
            END IF;

            IF v_prison_id IS NOT NULL THEN
                INSERT INTO prison_human (human_id, prison_id, imprisoned_time)
                VALUES (v_judge.human_id, v_prison_id, NOW());
            END IF;
        END IF;
    END LOOP;

    DELETE FROM court_judge WHERE court_id = OLD.id;

    DELETE FROM punishment
    WHERE accusation_id IN (
        SELECT id FROM accusation WHERE court_id = OLD.id
    );

    DELETE FROM factor_accusation
    WHERE accusation_id IN (
        SELECT id FROM accusation WHERE court_id = OLD.id
    );

    DELETE FROM factor_punishment
    WHERE punishment_id IN (
        SELECT id FROM punishment WHERE accusation_id IN (
            SELECT id FROM accusation WHERE court_id = OLD.id
        )
    );

    UPDATE accusation
    SET court_id = NULL
    WHERE court_id = OLD.id;

    RETURN OLD;
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Error when court removed: %', SQLERRM;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE TRIGGER before_delete_court
    BEFORE DELETE ON court
    FOR EACH ROW
    EXECUTE FUNCTION delete_court();


