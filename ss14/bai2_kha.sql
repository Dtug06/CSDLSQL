use social_network_ss14;

create table likes (
like_id int primary key auto_increment,
post_id int not null,
foreign key (post_id) references posts(post_id),
user_id int not null,
foreign key (user_id) references users(user_id),
unique key unique_like(post_id,user_id)
);

alter table posts add column likes_count int default 0;

start transaction ;
select* from posts;
insert into likes(post_id,user_id)
values(
