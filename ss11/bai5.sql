use social_network_pro;

delimiter $$

create procedure user_activity_summary(
    in v_user_id int,
    out v_total_score int,
    out v_activity_rank varchar(50)
)
begin
    declare v_posts int;
    declare v_comments int;
    declare v_likes int;

    select count(*)
    into v_posts
    from posts
    where user_id = v_user_id;

    select count(*)
    into v_comments
    from comments
    where user_id = v_user_id;

    select count(*)
    into v_likes
    from likes l
    inner join posts p on p.post_id = l.post_id
    where p.user_id = v_user_id;

    set v_total_score = v_posts * 10
                      + v_comments * 5
                      + v_likes * 3;

    if v_total_score >= 500 then
        set v_activity_rank = 'Hoạt động rất cao';
    elseif v_total_score >= 200 then
        set v_activity_rank = 'Hoạt động ổn định';
    else
        set v_activity_rank = 'Hoạt động thấp';
    end if;
end$$

delimiter ;

call user_activity_summary(1, @total, @rank);

select @total as activity_score, @rank as activity_level;

drop procedure user_activity_summary;
