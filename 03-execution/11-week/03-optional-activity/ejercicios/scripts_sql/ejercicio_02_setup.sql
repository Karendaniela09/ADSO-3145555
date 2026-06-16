- ============================================
-- CONSULTA PRINCIPAL (REQUERIMIENTO 1)
-- ============================================

CREATE OR REPLACE VIEW vw_passenger_flight_trace AS
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


-- ============================================
-- FUNCIÓN PARA TRIGGER (REQUERIMIENTO 2)
-- ============================================

CREATE OR REPLACE FUNCTION fn_generate_boarding_pass()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO boarding_pass (
        boarding_pass_id,
        check_in_id,
        boarding_pass_code,
        barcode_value,
        issued_at,
        created_at,
        updated_at
    )
    VALUES (
        gen_random_uuid(),
        NEW.check_in_id,
        'BP-' || substring(NEW.check_in_id::text, 1, 8),
        'BAR-' || substring(NEW.check_in_id::text, 1, 12),
        now(),
        now(),
        now()
    );

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


-- ============================================
-- TRIGGER
-- ============================================

DROP TRIGGER IF EXISTS trg_generate_boarding_pass ON check_in;

CREATE TRIGGER trg_generate_boarding_pass
AFTER INSERT ON check_in
FOR EACH ROW
EXECUTE FUNCTION fn_generate_boarding_pass();


-- ============================================
-- PROCEDIMIENTO ALMACENADO (REQUERIMIENTO 3)
-- ============================================

CREATE OR REPLACE PROCEDURE sp_register_check_in(
    p_ticket_segment_id uuid,
    p_check_in_status_id uuid,
    p_boarding_group_id uuid,
    p_user_id uuid
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO check_in (
        check_in_id,
        ticket_segment_id,
        check_in_status_id,
        boarding_group_id,
        checked_in_by_user_id,
        checked_in_at,
        created_at,
        updated_at
    )
    VALUES (
        gen_random_uuid(),
        p_ticket_segment_id,
        p_check_in_status_id,
        p_boarding_group_id,
        p_user_id,
        now(),
        now(),
        now()
    );
END;
$$;