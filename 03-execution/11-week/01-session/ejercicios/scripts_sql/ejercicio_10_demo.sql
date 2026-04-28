-- ============================================
-- DEMO.SQL
-- Ejecución del flujo completo
-- ============================================

DO $$
DECLARE
    v_ticket_segment_id uuid;
    v_check_in_status_id uuid;
    v_boarding_group_id uuid;
    v_user_id uuid;
BEGIN
    -- Buscar ticket_segment sin check-in
    SELECT ts.ticket_segment_id
    INTO v_ticket_segment_id
    FROM ticket_segment ts
    LEFT JOIN check_in ci 
        ON ci.ticket_segment_id = ts.ticket_segment_id
    WHERE ci.check_in_id IS NULL
    ORDER BY ts.created_at
    LIMIT 1;

    -- Obtener datos base
    SELECT check_in_status_id INTO v_check_in_status_id FROM check_in_status LIMIT 1;
    SELECT boarding_group_id INTO v_boarding_group_id FROM boarding_group LIMIT 1;
    SELECT user_account_id INTO v_user_id FROM user_account LIMIT 1;

    -- Validaciones
    IF v_ticket_segment_id IS NULL THEN
        RAISE EXCEPTION 'No hay ticket_segment disponible.';
    END IF;

    IF v_check_in_status_id IS NULL THEN
        RAISE EXCEPTION 'No hay check_in_status disponible.';
    END IF;

    -- Ejecutar procedimiento (dispara trigger)
    CALL sp_register_check_in(
        v_ticket_segment_id,
        v_check_in_status_id,
        v_boarding_group_id,
        v_user_id
    );

END;
$$;


-- ============================================
-- VALIDACIÓN FINAL DEL FLUJO COMPLETO
-- ============================================

SELECT 
    ts.ticket_segment_id,
    ci.check_in_id,
    bp.boarding_pass_id,
    bp.boarding_pass_code,
    bp.issued_at
FROM ticket_segment ts
LEFT JOIN check_in ci 
    ON ts.ticket_segment_id = ci.ticket_segment_id
LEFT JOIN boarding_pass bp 
    ON ci.check_in_id = bp.check_in_id
ORDER BY bp.issued_at DESC NULLS LAST; 