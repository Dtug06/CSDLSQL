create database ss7;
use ss7;
 
 create table customers(
 id int primary key auto_increment,
 name varchar(255),
 email varchar(225)
 );
 
 create table orders (
 id int primary key auto_increment,
 customer_id int,
 foreign key (customer_id) references customers(id),
 order_date date,
 total_amount decimal
 );
 
INSERT INTO customers (id, name, email) VALUES
(1, 'Nguyen Van A', 'a@example.com'),
(2, 'Tran Thi B', 'b@example.com'),
(3, 'Le Van C', 'c@example.com'),
(4, 'Pham Thi D', 'd@example.com'),
(5, 'Hoang Van E', 'e@example.com'),
(6, 'Do Thi F', 'f@example.com'),
(7, 'Vu Van G', 'g@example.com');

INSERT INTO orders (id, customer_id, order_date, total_amount) VALUES
(101, 1, '2025-01-01', 500000),
(102, 2, '2025-01-02', 300000),
(103, 3, '2025-01-03', 450000),
(104, 1, '2025-01-05', 200000),
(105, 4, '2025-01-06', 700000),
(106, 6, '2025-01-07', 150000),
(107, 7, '2025-01-08', 250000);

select * from customers 
where id in(
select customer_id 
from orders
);
