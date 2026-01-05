create database ss6;
use ss6;
 create table customers (
 customer_id int primary key,
full_name varchar(255),
city varchar(255)
);

create table orders (
order_id int primary key,
customer_id int,
foreign key (customer_id) references customers(customer_id),
order_date date,
status ENUM('pending', 'completed', 'cancelled')
);


INSERT INTO customers (customer_id, full_name, city) VALUES
(1, 'Nguyen Van A', 'Hanoi'),
(2, 'Tran Thi B', 'Ho Chi Minh City'),
(3, 'Le Van C', 'Da Nang'),
(4, 'Pham Thi D', 'Hai Phong'),
(5, 'Hoang Van E', 'Can Tho');

INSERT INTO orders (order_id, customer_id, order_date, status) VALUES
(101, 1, '2024-08-01', 'completed'),
(102, 2, '2024-08-02', 'pending'),
(103, 3, '2024-08-03', 'cancelled'),
(104, 1, '2024-08-04', 'completed'),
(105, 4, '2024-08-05', 'pending');

SELECT o.order_id, c.full_name, o.order_date, o.status
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id;

SELECT c.full_name, COUNT(o.order_id) AS total_orders
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.full_name;

SELECT c.full_name, COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.full_name
HAVING COUNT(o.order_id) > 0;

