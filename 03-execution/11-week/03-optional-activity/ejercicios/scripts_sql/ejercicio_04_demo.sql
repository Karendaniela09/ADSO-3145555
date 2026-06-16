-- ============================================
-- DEMO PROCEDIMIENTO
-- ============================================

DO $$
DECLARE
    v_ticket_segment_id uuid;
    v_check_in_status_id uuid;
    v_boarding_group_id uuid;
    v_user_id uuid;
BEGIN
    -- Buscar ticket disponible
    SELECT ts.ticket_segment_id
    INTO v_ticket_segment_id
    FROM ticket_segment ts
    LEFT JOIN check_in ci 
        ON ci.ticket_segment_id = ts.ticket_segment_id
    WHERE ci.check_in_id IS NULL
    LIMIT 1;

    -- Obtener datos base
    SELECT check_in_status_id INTO v_check_in_status_id FROM check_in_status LIMIT 1;
    SELECT boarding_group_id INTO v_boarding_group_id FROM boarding_group LIMIT 1;
    SELECT user_account_id INTO v_user_id FROM user_account LIMIT 1;

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

-- Ver check-in
SELECT *
FROM check_in
ORDER BY created_at DESC
LIMIT 5;

-- Ver boarding pass (si tienes trigger)
SELECT *
FROM boarding_pass
ORDER BY issued_at DESC
LIMIT 5;

-- Validación completa
SELECT 
    ci.check_in_id,
    ci.checked_in_at,
    bp.boarding_pass_code
FROM check_in ci
LEFT JOIN boarding_pass bp 
    ON ci.check_in_id = bp.check_in_id
ORDER BY ci.checked_in_at DESC;