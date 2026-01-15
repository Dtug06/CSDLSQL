
use social_network_ss14;

 create table users (
 user_id int primary key auto_increment,
 username varchar(50) not null ,
 posts_count int default 0
 );
 
 create table posts (
 post_id int primary key auto_increment ,
 user_id int not null,
 foreign key (user_id ) references users (user_id),
 content text  not null,
 created_at datetime default current_timestamp
 );
 INSERT INTO users (username, posts_count) VALUES ('doanh', 0);
 
 start transaction ;
 insert into posts (user_id,content)
 values(
 1,'first post by doanh tuan');
 update users
 set posts_count =posts_count
 where user_id=1;
 commit;
 START TRANSACTION;

-- 1. Thêm một bài post với user_id không tồn tại
INSERT INTO posts (user_id, content)
VALUES (999, 'Bài viết lỗi vì user_id không tồn tại');
-- 2. Tăng posts_count cho user_id 999
UPDATE users
SET posts_count = posts_count + 1
WHERE user_id = 999;
-- 3. Nếu có lỗi, rollback
ROLLBACK;

 
 