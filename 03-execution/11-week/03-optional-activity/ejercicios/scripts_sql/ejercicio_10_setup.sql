-- ============================================
-- SETUP.SQL
-- Preparación del flujo completo de check-in
-- ============================================

-- 1. FUNCIÓN PARA GENERAR BOARDING PASS
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
        'BP-'  substring(NEW.check_in_id::text, 1, 8),
        'BAR-' 
 substring(NEW.check_in_id::text, 1, 12),
        now(),
        now(),
        now()
    );

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


-- 2. TRIGGER AFTER
DROP TRIGGER IF EXISTS trg_generate_boarding_pass ON check_in;

CREATE TRIGGER trg_generate_boarding_pass
AFTER INSERT ON check_in
FOR EACH ROW
EXECUTE FUNCTION fn_generate_boarding_pass();


-- 3. PROCEDIMIENTO DE CHECK-IN
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


-- 4. VALIDACIÓN DE DATOS BASE
SELECT * FROM ticket_segment LIMIT 1;
SELECT * FROM check_in_status LIMIT 1;
SELECT * FROM boarding_group LIMIT 1;
SELECT * FROM user_account LIMIT 1;