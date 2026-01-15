USE social_network_ss14;

CREATE TABLE comments(
	comment_id int primary key auto_increment,
    post_id int not null,
    user_id int not null,
    content text not null,
    created_at datetime default current_timestamp,
    foreign key(post_id) references posts(post_id),
    foreign key(user_id) references users(user_id)
);

alter table posts add column comments_count INT DEFAULT 0;

DELIMITER $$

CREATE PROCEDURE sp_post_comment (
    IN p_post_id INT,
    IN p_user_id INT,
    IN p_content TEXT
)
BEGIN
    DECLARE post_exists INT DEFAULT 0;
    DECLARE user_exists INT DEFAULT 0;

    START TRANSACTION;

    -- Kiểm tra post tồn tại
    SELECT COUNT(*) INTO post_exists
    FROM posts
    WHERE post_id = p_post_id;

    -- Kiểm tra user tồn tại
    SELECT COUNT(*) INTO user_exists
    FROM users
    WHERE user_id = p_user_id;

    IF post_exists = 0 OR user_exists = 0 THEN
        ROLLBACK;
    ELSE
        -- 1. Insert comment
        INSERT INTO comments(post_id, user_id, content)
        VALUES (p_post_id, p_user_id, p_content);

        -- 2. Tạo savepoint
        SAVEPOINT after_insert;

        -- 3. Update comments_count
        UPDATE posts
        SET comments_count = comments_count + 1
        WHERE post_id = p_post_id;

        -- Nếu update thất bại (không có dòng nào bị ảnh hưởng)
        IF ROW_COUNT() = 0 THEN
            -- Rollback partial (chỉ rollback phần update)
            ROLLBACK TO after_insert;
            COMMIT;
        ELSE
            -- Thành công toàn bộ
            COMMIT;
        END IF;
    END IF;

END$$

DELIMITER ;


CALL sp_post_comment(1, 1, 'Bình luận hợp lệ');

START TRANSACTION;
DELETE FROM posts WHERE post_id = 2;
COMMIT;
CALL sp_post_comment(2, 1, 'test điểm lưu');


SELECT * FROM comments;
SELECT post_id, comments_count FROM posts;