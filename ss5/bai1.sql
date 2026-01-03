create database SS5;
use SS5;

 create table products (
 product_id int,
 product_name varchar(255),
 price decimal(10,2),
 stock int,
 status enum('active','inactive')
 );
 INSERT INTO products (product_id, product_name, price, stock, status) 
 VALUES 
 (1, 'Laptop Dell Inspiron', 15000000.00, 20, 'active'),
 (2, 'Điện thoại iPhone 14', 25000000.00, 15, 'active'), 
 (3, 'Tai nghe Bluetooth Sony', 2000000.00, 50, 'active'), 
 (4, 'Chuột Logitech', 500000.00, 100, 'active'), 
 (5, 'Bàn phím cơ Keychron', 1800000.00, 40, 'active'),
 (6, 'Màn hình Samsung 24 inch', 3500000.00, 25, 'inactive'),
 (7, 'Ổ cứng SSD 1TB', 2200000.00, 30, 'active'),
 (8, 'Máy in Canon', 4500000.00, 10, 'inactive'),
 (9, 'Loa Bluetooth JBL', 3200000.00, 35, 'active'),
 (10, 'Máy ảnh Sony Alpha', 28000000.00, 5, 'active');
  select * from products;
  select * from products 
  where status ='active';
  select * from products 
  where price > 1000000;
  
  select * from products
  where status ='active'
  order by price asc;
 