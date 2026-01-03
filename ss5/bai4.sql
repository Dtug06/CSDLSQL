use ss5;
 
 alter table products
 add column sold_quantity int ;
 
 UPDATE products SET sold_quantity = 120 WHERE product_id = 1;
UPDATE products SET sold_quantity = 80  WHERE product_id = 2;
UPDATE products SET sold_quantity = 200 WHERE product_id = 3;
UPDATE products SET sold_quantity = 150 WHERE product_id = 4;
UPDATE products SET sold_quantity = 90  WHERE product_id = 5;
UPDATE products SET sold_quantity = 60  WHERE product_id = 6;
UPDATE products SET sold_quantity = 110 WHERE product_id = 7;
UPDATE products SET sold_quantity = 40  WHERE product_id = 8;
UPDATE products SET sold_quantity = 130 WHERE product_id = 9;
UPDATE products SET sold_quantity = 25  WHERE product_id = 10;

 select *from products;
 
 select *from products 
 order by sold_quantity desc
 limit 10 ;
 
  select *from products 
  where price <2000000
  order by price desc;