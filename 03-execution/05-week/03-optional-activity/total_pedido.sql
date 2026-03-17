CREATE OR REPLACE FUNCTION get_total_order(order_uuid UUID)
RETURNS NUMERIC
LANGUAGE plpgsql
AS $$
DECLARE
    total NUMERIC;
BEGIN

    SELECT SUM(subtotal)
    INTO total
    FROM view_order_detail
    WHERE order_id = order_uuid;

    RETURN total;

END;
$$; 

SELECT 
    id,
    get_total_order(id) AS total_order
FROM customer_order;

SELECT get_total_order('85ee02f4-0df8-4168-be24-d853f8c2280a');