use social_network_pro;

delimiter $$

create procedure publish_post_and_notify(
    in v_user_id int,
    in v_content text
)
begin
    declare v_new_post int;
    declare v_author_name varchar(255);
    declare v_target_user int;
    declare v_done int default 0;

    declare c_friends cursor for
        select
            if(user_id = v_user_id, friend_id, user_id)
        from friends
        where status = 'accepted'
          and (user_id = v_user_id or friend_id = v_user_id);

    declare continue handler for not found set v_done = 1;

    if not exists (
        select 1 from users where user_id = v_user_id
    ) then
        signal sqlstate '45000'
        set message_text = 'không tìm thấy người dùng';
    end if;

    select full_name
    into v_author_name
    from users
    where user_id = v_user_id;

    insert into posts(user_id, content, created_at)
    values (v_user_id, v_content, now());

    set v_new_post = last_insert_id();

    open c_friends;

    notify_loop: loop
        fetch c_friends into v_target_user;

        if v_done = 1 then
            leave notify_loop;
        end if;

        if v_target_user <> v_user_id then
            insert into notifications(user_id, type, content, created_at)
            values (
                v_target_user,
                'new_post',
                concat(v_author_name, ' vừa chia sẻ một bài viết mới'),
                now()
            );
        end if;
    end loop;

    close c_friends;

    select 
        v_new_post as post_id,
        'thao tác hoàn tất' as result;
end$$

delimiter ;

call publish_post_and_notify(
    1,
    'hoàn thành xong procedure cursor cho hệ thống mạng xã hội'
);

select notification_id,
       user_id,
       type,
       content,
       created_at
from notifications
where type = 'new_post'
order by notification_id desc;

drop procedure publish_post_and_notify;
