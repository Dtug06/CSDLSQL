use ss7;

create table products (
id int primary key auto_increment,
name varchar(225),
price decimal
);

CREATE TABLE order_items (
    order_id INT,
    product_id INT,
    quantity INT,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);
INSERT INTO products (id, name, price) VALUES
(1, 'Laptop Dell XPS 13', 25000000),
(2, 'iPhone 15 Pro', 30000000),
(3, 'Samsung Galaxy S24', 28000000),
(4, 'Tai nghe AirPods Pro', 5500000),
(5, 'Chuột Logitech MX Master 3', 2500000),
(6, 'Bàn phím cơ Keychron K2', 2200000),
(7, 'Màn hình LG UltraWide 34"', 12000000);

INSERT INTO order_items (order_id, product_id, quantity) VALUES
(101, 1, 2), 
(101, 4, 1),   
(102, 2, 1),  
(103, 3, 3),   
(104, 5, 2),  
(105, 6, 1),  
(106, 7, 1);   

select * from products
where id in(
select product_id 
from order_items
);
