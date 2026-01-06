use ss7;
INSERT INTO orders (id, customer_id, order_date, total_amount) VALUES
(108, 2, '2025-01-09', 600000),   
(109, 3, '2025-01-10', 350000), 
(110, 5, '2025-01-11', 800000),  
(111, 1, '2025-01-12', 400000),  
(112, 7, '2025-01-13', 900000);   
SELECT id, customer_id, order_date, total_amount
FROM orders
WHERE total_amount > (
    SELECT AVG(total_amount)
    FROM orders
);
