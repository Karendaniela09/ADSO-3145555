-- ============================================
-- CLEANUP (evitar conflictos)
-- ============================================

DROP TRIGGER IF EXISTS trg_generate_boarding_pass ON check_in;
DROP FUNCTION IF EXISTS fn_generate_boarding_pass();
DROP PROCEDURE IF EXISTS sp_register_check_in(uuid, uuid, uuid, uuid);

-- ============================================
-- FUNCTION: GENERAR BOARDING PASS
-- ============================================

CREATE OR REPLACE FUNCTION fn_generate_boarding_pass()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    v_boarding_pass_code varchar(40);
    v_barcode_value varchar(120);
BEGIN
    -- Evitar duplicados
    IF EXISTS (
        SELECT 1
        FROM boarding_pass bp
        WHERE bp.check_in_id = NEW.check_in_id
    ) THEN
        RETURN NEW;
    END IF;

    v_boarding_pass_code := 'BP-' || replace(NEW.check_in_id::text, '-', '');
    v_barcode_value := 'BAR-' || replace(NEW.check_in_id::text, '-', '') || '-' || to_char(NEW.checked_in_at, 'YYYYMMDDHH24MISS');

    INSERT INTO boarding_pass (
        check_in_id,
        boarding_pass_code,
        barcode_value,
        issued_at
    )
    VALUES (
        NEW.check_in_id,
        left(v_boarding_pass_code, 40),
        left(v_barcode_value, 120),
        NEW.checked_in_at
    );

    RETURN NEW;
END;
$$;

-- ============================================
-- TRIGGER
-- ============================================

CREATE TRIGGER trg_generate_boarding_pass
AFTER INSERT ON check_in
FOR EACH ROW
EXECUTE FUNCTION fn_generate_boarding_pass();

-- ============================================
-- PROCEDIMIENTO
-- ============================================

CREATE OR REPLACE PROCEDURE sp_register_check_in(
    p_ticket_segment_id uuid,
    p_check_in_status_id uuid,
    p_boarding_group_id uuid,
    p_checked_in_by_user_id uuid,
    p_checked_in_at timestamptz
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Validar duplicado
    IF EXISTS (
        SELECT 1
        FROM check_in ci
        WHERE ci.ticket_segment_id = p_ticket_segment_id
    ) THEN
        RAISE EXCEPTION 'Ya existe check-in para este ticket_segment';
    END IF;

    INSERT INTO check_in (
        ticket_segment_id,
        check_in_status_id,
        boarding_group_id,
        checked_in_by_user_id,
        checked_in_at
    )
    VALUES (
        p_ticket_segment_id,
        p_check_in_status_id,
        p_boarding_group_id,
        p_checked_in_by_user_id,
        p_checked_in_at
    );
END;
$$;

-- ============================================
-- CONSULTA PRINCIPAL (REQUERIMIENTO 1)
-- ============================================

SELECT 
    r.reservation_code,
    f.flight_number,
    f.service_date,
    t.ticket_number,
    rp.passenger_sequence_no,
    CONCAT(p.first_name, ' ', p.last_name) AS passenger_name,
    fs.segment_number,
    fs.scheduled_departure_at
FROM reservation r
INNER JOIN reservation_passenger rp 
    ON r.reservation_id = rp.reservation_id
INNER JOIN person p 
    ON rp.person_id = p.person_id
INNER JOIN ticket t 
    ON rp.reservation_passenger_id = t.reservation_passenger_id
INNER JOIN ticket_segment ts 
    ON t.ticket_id = ts.ticket_id
INNER JOIN flight_segment fs 
    ON ts.flight_segment_id = fs.flight_segment_id
INNER JOIN flight f 
    ON fs.flight_id = f.flight_id;
    