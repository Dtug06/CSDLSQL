create database online_sales_db;

use online_sales_db;


create table customers (
customer_id INT auto_increment primary key,
customer_name varchar(100) not null,
email varchar(100) not null unique,
phone varchar(10) not null unique
);


create table categories (
category_id INT auto_increment primary key,
category_name varchar(255) not null unique
);


create table products (
product_id INT auto_increment primary key,
product_name varchar(255) not null unique,
price decimal(10, 2) not null check (price > 0),
category_id INT not null,
foreign key (category_id) references categories(category_id)
 );


create table orders (
order_id INT auto_increment primary key,
customer_id INT not null,
order_date datetime default current_timestamp,
status enum('Pending', 'Completed', 'Cancel') default 'Pending',
foreign key (customer_id) references customers(customer_id)
);


create table order_items (
order_item_id INT auto_increment primary key,
order_id INT, product_id INT,
quantity INT not null check (quantity > 0),
foreign key (order_id) references orders(order_id),
foreign key (product_id) references products(product_id)
);


insert into customers (customer_name, email, phone)
values ('Nguyễn Văn A', 'a@gmail.com', '0900000001'),
       ('Trần Thị B', 'b@gmail.com', '0900000002'),
       ('Lê Văn C', 'c@gmail.com', '0900000003'),
       ('Phạm Thị D', 'd@gmail.com', '0900000004');


insert into categories (category_name)
values ('Điện thoại'),
       ('Laptop'),
       ('Phụ kiện');


insert into products (product_name, price, category_id)
values ('iPhone 15', 25000000, 1),
       ('Samsung S23', 22000000, 1),
       ('MacBook Air M2', 30000000, 2),
       ('Dell XPS 13', 28000000, 2),
       ('Tai nghe AirPods', 4500000, 3),
       ('Chuột Logitech', 1200000, 3),
       ('Bàn phím cơ', 2500000, 3);


insert into orders (customer_id, status)
values (1, 'Completed'),
       (1, 'Completed'),
       (2, 'Pending'),
       (3, 'Completed'),
       (3, 'Cancel');


insert into order_items (order_id, product_id, quantity)
values (1, 1, 1),
       (1, 5, 2),
       (2, 3, 1),
       (2, 6, 1),
       (3, 2, 1),
       (4, 4, 1),
       (4, 7, 2);


select *
from categories;


select *
from orders
where status = 'Completed';


select *
from products
order by price desc;


select *
from products
order by price desc
limit 5
offset 2;


select p.product_name,
       p.price,
       c.category_name
from products p
join categories c on p.category_id = c.category_id;


select o.order_id,
       o.order_date,
       c.customer_name,
       o.status
from orders o
join customers c on o.customer_id = c.customer_id;


select o.order_id,
       sum(oi.quantity) as total_quantity
from orders o
join order_items oi on o.order_id = oi.order_id
group by o.order_id;


select c.customer_name,
       count(o.order_id) as total_orders
from customers c
left join orders o on c.customer_id = o.customer_id
group by c.customer_name;


select c.customer_name,
       count(o.order_id) as total_orders
from customers c
join orders o on c.customer_id = o.customer_id
group by c.customer_name
having count(o.order_id) >= 2;


select c.category_name,
       avg(p.price) as avg_price,
       min(p.price) as min_price,
       max(p.price) as max_price
from categories c
join products p on c.category_id = p.category_id
group by c.category_name;