	use ss6;
    alter table orders add total_amount decimal(10,2);
     
     UPDATE orders
SET total_amount = 1500000
WHERE order_id = 101;

UPDATE orders
SET total_amount = 2500000
WHERE order_id = 102;

UPDATE orders
SET total_amount = 3200000
WHERE order_id = 103;

UPDATE orders
SET total_amount = 1800000
WHERE order_id = 104;

UPDATE orders
SET total_amount = 2750000
WHERE order_id = 105;
 
 SELECT c.full_name, SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.full_name;

