-- ============================================
-- DEMO AUTOMÁTICO
-- ============================================

DO $$
DECLARE
    v_ticket_segment_id uuid;
    v_check_in_status_id uuid;
    v_boarding_group_id uuid;
    v_user_id uuid;
BEGIN
    -- Obtener ticket sin check-in
    SELECT ts.ticket_segment_id
    INTO v_ticket_segment_id
    FROM ticket_segment ts
    LEFT JOIN check_in ci 
        ON ci.ticket_segment_id = ts.ticket_segment_id
    WHERE ci.check_in_id IS NULL
    LIMIT 1;

    -- Obtener estado check-in
    SELECT check_in_status_id
    INTO v_check_in_status_id
    FROM check_in_status
    LIMIT 1;

    -- Obtener grupo
    SELECT boarding_group_id
    INTO v_boarding_group_id
    FROM boarding_group
    ORDER BY sequence_no
    LIMIT 1;

    -- Obtener usuario
    SELECT user_account_id
    INTO v_user_id
    FROM user_account
    LIMIT 1;

    IF v_ticket_segment_id IS NULL THEN
        RAISE EXCEPTION 'No hay ticket disponible';
    END IF;

    -- Ejecutar procedimiento
    CALL sp_register_check_in(
        v_ticket_segment_id,
        v_check_in_status_id,
        v_boarding_group_id,
        v_user_id
    );

END $$;


-- ============================================
-- VALIDACIONES
-- ============================================

-- Ver check-in creado
SELECT * 
FROM check_in
ORDER BY checked_in_at DESC
LIMIT 5;

-- Ver boarding pass generado por trigger
SELECT * 
FROM boarding_pass
ORDER BY issued_at DESC
LIMIT 5;

-- Validación JOIN
SELECT 
    ci.check_in_id,
    ci.checked_in_at,
    bp.boarding_pass_code,
    bp.barcode_value
FROM check_in ci
INNER JOIN boarding_pass bp 
    ON ci.check_in_id = bp.check_in_id
ORDER BY ci.checked_in_at DESC;


-- ============================================
-- VALIDACIÓN COMPLETA DEL FLUJO
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
LEFT JOIN boarding_pass bp ON ci.check_in_id = bp.check_in_id;


-- ============================================
-- CONSULTA BASE DEL EJERCICIO
-- ============================================

SELECT * FROM vw_passenger_flight_trace LIMIT 20;