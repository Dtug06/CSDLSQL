USE ss5;

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    total_amount DECIMAL(10,2),
    order_date DATE,
    status ENUM('pending', 'completed', 'cancelled'),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

INSERT INTO orders (order_id, customer_id, total_amount, order_date, status) VALUES
(1, 1, 15000000.00, '2025-12-01', 'completed'),
(2, 2, 25000000.00, '2025-12-02', 'pending'),
(3, 3, 2000000.00, '2025-12-03', 'completed'),
(4, 4, 500000.00, '2025-12-04', 'cancelled'),
(5, 5, 1800000.00, '2025-12-05', 'completed'),
(6, 6, 3500000.00, '2025-12-06', 'pending'),
(7, 7, 2200000.00, '2025-12-07', 'completed'),
(8, 8, 4500000.00, '2025-12-08', 'cancelled'),
(9, 9, 3200000.00, '2025-12-09', 'completed'),
(10, 10, 28000000.00, '2025-12-10', 'completed');

select * from orders 
where status='completed';

select *from orders 
where total_amount >5000000;
 
 select *from orders 
 order by order_date desc
 limit 5;
 
 select * from orders 
where status='completed'
order by total_amount desc;