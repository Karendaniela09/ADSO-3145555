-- ============================================
-- SETUP.SQL - EJERCICIO TRIGGER AFTER
-- ============================================

-- Extensión necesaria para UUID
CREATE EXTENSION IF NOT EXISTS pgcrypto;


-- ============================================
-- FUNCIÓN DEL TRIGGER
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


-- ============================================
-- TRIGGER AFTER
-- ============================================

DROP TRIGGER IF EXISTS trg_generate_boarding_pass ON check_in;

CREATE TRIGGER trg_generate_boarding_pass
AFTER INSERT ON check_in
FOR EACH ROW
EXECUTE FUNCTION fn_generate_boarding_pass();


-- ============================================
-- VALIDACIÓN INICIAL (OPCIONAL)
-- ============================================

SELECT COUNT() AS total_ticket_segment FROM ticket_segment;
SELECT COUNT() AS total_check_in_status FROM check_in_status;
SELECT COUNT() AS total_boarding_group FROM boarding_group;
SELECT COUNT() AS total_users FROM user_account;