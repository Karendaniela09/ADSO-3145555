-- ============================================
-- SETUP.SQL - PROCEDIMIENTO CHECK-IN
-- ============================================

CREATE EXTENSION IF NOT EXISTS pgcrypto;


-- ============================================
-- PROCEDIMIENTO
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