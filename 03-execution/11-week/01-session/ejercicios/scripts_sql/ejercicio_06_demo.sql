-- ============================================
-- DEMO.SQL - PRUEBA DEL PROCEDIMIENTO
-- ============================================


-- ============================================
-- EJECUCIÓN DEL PROCEDIMIENTO (CALL)
-- ============================================

CALL sp_register_check_in(
    (
        SELECT ts.ticket_segment_id
        FROM ticket_segment ts
        LEFT JOIN check_in ci 
            ON ci.ticket_segment_id = ts.ticket_segment_id
        WHERE ci.check_in_id IS NULL
        LIMIT 1
    ),
    (SELECT check_in_status_id FROM check_in_status LIMIT 1),
    NULL,
    NULL
);


-- ============================================
-- VALIDACIONES
-- ============================================

-- Ver check-in creado
SELECT *
FROM check_in
ORDER BY created_at DESC
LIMIT 5;


-- Validación simple
SELECT 
    check_in_id,
    ticket_segment_id,
    check_in_status_id,
    checked_in_at
FROM check_in
ORDER BY created_at DESC
LIMIT 5;


-- ============================================
-- SI TIENES EL TRIGGER ACTIVO
-- ============================================

SELECT *
FROM boarding_pass
ORDER BY issued_at DESC
LIMIT 5;


-- Validación con join
SELECT 
    ci.check_in_id,
    ci.checked_in_at,
    bp.boarding_pass_code
FROM check_in ci
LEFT JOIN boarding_pass bp 
    ON ci.check_in_id = bp.check_in_id
ORDER BY ci.created_at DESC;