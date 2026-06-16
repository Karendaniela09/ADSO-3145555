-- ============================================
-- DEMO.SQL
-- Demostración del flujo completo
-- ============================================

DO $$
DECLARE
    v_ticket_segment_id uuid;
    v_check_in_status_id uuid;
    v_boarding_group_id uuid;
    v_user_id uuid;
BEGIN
    -- Obtener ticket disponible sin check-in
    SELECT ts.ticket_segment_id
    INTO v_ticket_segment_id
    FROM ticket_segment ts
    LEFT JOIN check_in ci
        ON ci.ticket_segment_id = ts.ticket_segment_id
    WHERE ci.check_in_id IS NULL
    ORDER BY ts.created_at
    LIMIT 1;

    -- Obtener estado
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

    -- Ejecutar procedimiento
    CALL sp_register_check_in(
        v_ticket_segment_id,
        v_check_in_status_id,
        v_boarding_group_id,
        v_user_id
    );

END;
$$;


-- ============================================
-- CONSULTA DE VALIDACIÓN FINAL
-- ============================================

SELECT 
    ci.check_in_id,
    ci.checked_in_at,
    bp.boarding_pass_code,
    bp.barcode_value
FROM check_in ci
INNER JOIN boarding_pass bp 
    ON ci.check_in_id = bp.check_in_id
ORDER BY ci.created_at DESC;