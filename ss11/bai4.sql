use social_network_pro;

delimiter $$

create procedure addpost_safe(
    in v_user_id int,
    in v_post_content text,
    out v_result varchar(255)
)
begin
    if v_post_content is null 
       or char_length(trim(v_post_content)) <= 4 then
        set v_result = 'Nội dung bài viết không hợp lệ';
    else
        insert into posts(user_id, content, created_at)
        values (v_user_id, trim(v_post_content), now());

        set v_result = 'Đăng bài viết thành công';
    end if;
end$$

delimiter ;

call addpost_safe(1, 'abc', @res1);
select @res1;

call addpost_safe(1, 'Đây là một bài viết hợp lệ', @res2);
select @res2;

select post_id, user_id, content, created_at
from posts
where user_id = 1
order by p
