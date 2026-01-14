use ss13;

create table likes (
like_id int primary key auto_increment,
user_id int ,
foreign key (user_id) references users(user_id),
post_id int,
foreign key (post_id) references posts(post_id),
liked_at datetime
);
INSERT INTO likes (user_id, post_id, liked_at) VALUES

(2, 1, '2025-01-10 11:00:00'),

(3, 1, '2025-01-10 13:00:00'),

(1, 3, '2025-01-11 10:00:00'),

(3, 4, '2025-01-12 16:00:00');

-- Tạo trigger AFTER INSERT và AFTER DELETE trên likes để tự động cập nhật like_count trong bảng posts.
delimiter $$
create trigger insert_like after insert on likes
for each row
 begin 
 update posts
 set like_count =like_count +1
 where post_id =new.post_id;
 end $$
delimiter ;
-- drop trigger delete_like;
delimiter $$
create trigger delete_like after delete on likes
for each row
 begin 
 update posts
 set like_count =like_count -1
 where post_id =old.post_id;
 end $$
delimiter ;

create view user_statistics as 
select u.user_id, u.username, u.post_count, sum(p.like_count) as total_likes
from users u
left join posts p on u.user_id =p.user_id 
group by u.username;
-- drop view user_statistics;

select * from  user_statistics;
INSERT INTO likes (user_id, post_id, liked_at) VALUES (2, 4, NOW());

SELECT * FROM posts WHERE post_id = 4;

SELECT * FROM user_statistics;
