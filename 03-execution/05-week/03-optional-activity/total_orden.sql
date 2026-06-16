CREATE VIEW view_order_detail AS
SELECT 
    co.id AS order_id,
    p.first_name || ' ' || p.last_name AS customer_name,
    pr.name AS product,
    oi.quantity,
    oi.price,
    (oi.quantity * oi.price) AS subtotal
FROM customer_order co
JOIN customer c ON co.customer_id = c.id
JOIN person p ON c.person_id = p.id
JOIN order_item oi ON co.id = oi.order_id
JOIN product pr ON oi.product_id = pr.id;

SELECT * FROM view_order_detail;