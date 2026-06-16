-- ============================================
-- DEMO.SQL - PRUEBA DEL TRIGGER
-- ============================================

DO $$
DECLARE
    v_ticket_segment_id uuid;
    v_check_in_status_id uuid;
    v_boarding_group_id uuid;
    v_user_id uuid;
    v_new_check_in_id uuid;
BEGIN
    -- ========================================
    -- OBTENER DATOS VÁLIDOS
    -- ========================================

    SELECT ts.ticket_segment_id
    INTO v_ticket_segment_id
    FROM ticket_segment ts
    LEFT JOIN check_in ci 
        ON ci.ticket_segment_id = ts.ticket_segment_id
    WHERE ci.check_in_id IS NULL
    LIMIT 1;

    SELECT check_in_status_id
    INTO v_check_in_status_id
    FROM check_in_status
    LIMIT 1;

    SELECT boarding_group_id
    INTO v_boarding_group_id
    FROM boarding_group
    ORDER BY sequence_no
    LIMIT 1;

    SELECT user_account_id
    INTO v_user_id
    FROM user_account
    LIMIT 1;

    -- ========================================
    -- VALIDACIONES
    -- ========================================

    IF v_ticket_segment_id IS NULL THEN
        RAISE EXCEPTION 'No existe ticket_segment disponible.';
    END IF;

    -- ========================================
    -- INSERT QUE DISPARA EL TRIGGER
    -- ========================================

    v_new_check_in_id := gen_random_uuid();

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
        v_new_check_in_id,
        v_ticket_segment_id,
        v_check_in_status_id,
        v_boarding_group_id,
        v_user_id,
        now(),
        now(),
        now()
    );

    RAISE NOTICE 'Check-in generado: %', v_new_check_in_id;

END $$;


-- ============================================
-- VALIDACIÓN DEL TRIGGER
-- ============================================

-- Últimos check-in
SELECT *
FROM check_in
ORDER BY created_at DESC
LIMIT 5;


-- Boarding pass generado automáticamente
SELECT *
FROM boarding_pass
ORDER BY issued_at DESC
LIMIT 5;


-- Validación relacional
SELECT 
    ci.check_in_id,
    ci.checked_in_at,
    bp.boarding_pass_code,
    bp.barcode_value
FROM check_in ci
INNER JOIN boarding_pass bp
    ON ci.check_in_id = bp.check_in_id
ORDER BY ci.created_at DESC
LIMIT 5;


-- Trazabilidad completa
SELECT 
    ts.ticket_segment_id,
    ci.check_in_id,
    bp.boarding_pass_code,
    bp.issued_at
FROM ticket_segment ts
LEFT JOIN check_in ci 
    ON ts.ticket_segment_id = ci.ticket_segment_id
LEFT JOIN boarding_pass bp 
    ON ci.check_in_id = bp.check_in_id
ORDER BY bp.issued_at DESC;