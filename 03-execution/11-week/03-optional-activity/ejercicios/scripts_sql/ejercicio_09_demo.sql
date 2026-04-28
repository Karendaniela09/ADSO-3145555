-- ============================================
-- DEMO.SQL
-- Ejecución del flujo + trazabilidad completa
-- ============================================

DO $$
DECLARE
    v_ticket_segment_id uuid;
    v_check_in_status_id uuid;
    v_boarding_group_id uuid;
    v_user_id uuid;
BEGIN
    -- Obtener ticket_segment sin check-in
    SELECT ts.ticket_segment_id
    INTO v_ticket_segment_id
    FROM ticket_segment ts
    LEFT JOIN check_in ci
        ON ci.ticket_segment_id = ts.ticket_segment_id
    WHERE ci.check_in_id IS NULL
    ORDER BY ts.created_at
    LIMIT 1;

    -- Obtener estado de check-in
    SELECT check_in_status_id
    INTO v_check_in_status_id
    FROM check_in_status
    LIMIT 1;

    -- Obtener grupo de abordaje
    SELECT boarding_group_id
    INTO v_boarding_group_id
    FROM boarding_group
    LIMIT 1;

    -- Obtener usuario
    SELECT user_account_id
    INTO v_user_id
    FROM user_account
    LIMIT 1;

    -- Validaciones
    IF v_ticket_segment_id IS NULL THEN
        RAISE EXCEPTION 'No hay ticket_segment disponible.';
    END IF;

    IF v_check_in_status_id IS NULL THEN
        RAISE EXCEPTION 'No hay check_in_status disponible.';
    END IF;

    -- Ejecutar procedimiento (esto dispara el trigger)
    CALL sp_register_check_in(
        v_ticket_segment_id,
        v_check_in_status_id,
        v_boarding_group_id,
        v_user_id
    );

END;
$$;


-- ============================================
-- CONSULTA DE TRAZABILIDAD COMPLETA
-- ============================================

SELECT 
    r.reservation_code,
    f.flight_number,
    f.service_date,
    t.ticket_number,
    CONCAT(p.first_name, ' ', p.last_name) AS passenger,
    ci.checked_in_at,
    bp.boarding_pass_code
FROM reservation r
INNER JOIN reservation_passenger rp ON r.reservation_id = rp.reservation_id
INNER JOIN person p ON rp.person_id = p.person_id
INNER JOIN ticket t ON rp.reservation_passenger_id = t.reservation_passenger_id
INNER JOIN ticket_segment ts ON t.ticket_id = ts.ticket_id
INNER JOIN flight_segment fs ON ts.flight_segment_id = fs.flight_segment_id
INNER JOIN flight f ON fs.flight_id = f.flight_id
LEFT JOIN check_in ci ON ts.ticket_segment_id = ci.ticket_segment_id
LEFT JOIN boarding_pass bp ON ci.check_in_id = bp.check_in_id
ORDER BY ci.checked_in_at DESC NULLS LAST;