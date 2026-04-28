-- ============================================
-- PROCEDIMIENTO MEJORADO: REGISTRO DE CHECK-IN
-- ============================================

CREATE OR REPLACE PROCEDURE sp_register_check_in(
    p_ticket_segment_id uuid,
    p_check_in_status_id uuid,
    p_boarding_group_id uuid,
    p_user_id uuid
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_exists_check_in uuid;
BEGIN
    -- ========================================
    -- VALIDACIÓN 1: EXISTE EL TICKET SEGMENT
    -- ========================================
    IF NOT EXISTS (
        SELECT 1 FROM ticket_segment 
        WHERE ticket_segment_id = p_ticket_segment_id
    ) THEN
        RAISE EXCEPTION 'El ticket_segment no existe';
    END IF;

    -- ========================================
    -- VALIDACIÓN 2: EVITAR DUPLICADOS
    -- ========================================
    SELECT check_in_id
    INTO v_exists_check_in
    FROM check_in
    WHERE ticket_segment_id = p_ticket_segment_id;

    IF v_exists_check_in IS NOT NULL THEN
        RAISE EXCEPTION 'Ya existe un check-in para este ticket_segment';
    END IF;

    -- ========================================
    -- VALIDACIÓN 3: STATUS EXISTE
    -- ========================================
    IF NOT EXISTS (
        SELECT 1 FROM check_in_status 
        WHERE check_in_status_id = p_check_in_status_id
    ) THEN
        RAISE EXCEPTION 'Estado de check-in no válido';
    END IF;

    -- ========================================
    -- INSERT PRINCIPAL
    -- ========================================
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