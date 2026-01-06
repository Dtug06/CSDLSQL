use ss5;
create table customer (
customer_id int,
full_name varchar(225),
email varchar(225),
city varchar(225),
status  enum('active','inactive')
);
alter table customer 
modify customer_id int primary key ;
INSERT INTO customer (customer_id, full_name, email, city, status)
 VALUES
 (1, 'Nguyễn Văn A', 'vana@example.com', 'TP.HCM', 'active'), 
 (2, 'Trần Thị B', 'thib@example.com', 'Hà Nội', 'inactive'), 
 (3, 'Lê Văn C', 'vanc@example.com', 'Đà Nẵng', 'active'),
 (4, 'Phạm Thị D', 'thid@example.com', 'TP.HCM', 'active'), 
 (5, 'Hoàng Văn E', 'vane@example.com', 'Hải Phòng', 'inactive'),
 (6, 'Đỗ Thị F', 'thif@example.com', 'TP.HCM', 'active'), 
 (7, 'Bùi Văn G', 'vang@example.com', 'Cần Thơ', 'active'), 
 (8, 'Vũ Thị H', 'thih@example.com', 'Hà Nội', 'inactive'), 
 (9, 'Ngô Văn I', 'vani@example.com', 'TP.HCM', 'active'),
 (10, 'Phan Thị K', 'thik@example.com', 'Huế', 'active');
select * from customer;
select *from customer
where city='TP.HCM';
 select * from customer 
 where status='active' and city='TP.HCM';
 select *from customer 
 order by full_name asc;