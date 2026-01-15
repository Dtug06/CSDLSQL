USE social_network_ss14;

CREATE TABLE followers(
	follower_id int not null,
    followed_id int not null,
    primary key(follower_id,followed_id)
);
ALTER TABLE users ADD COLUMN  following_count INT DEFAULT 0, add column followers_count INT DEFAULT 0;

CREATE TABLE follow_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    follower_id int,
    followed_id int,
    error_message varchar(255),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$

CREATE PROCEDURE sp_follow_user (
    IN p_follower_id INT,
    IN p_followed_id INT
)
BEGIN
    DECLARE follower_exists INT DEFAULT 0;
    DECLARE followed_exists INT DEFAULT 0;
    DECLARE already_followed INT DEFAULT 0;

    START TRANSACTION;

    -- Kiểm tra user tồn tại
    SELECT COUNT(*) INTO follower_exists
    FROM users
    WHERE user_id = p_follower_id;

    SELECT COUNT(*) INTO followed_exists
    FROM users
    WHERE user_id = p_followed_id;

    IF follower_exists = 0 or followed_exists = 0 then
        INSERT INTO follow_log(follower_id, followed_id, error_message)
        VALUES (p_follower_id, p_followed_id, 'User không tồn tại');

        ROLLBACK;

    ELSEIF p_follower_id = p_followed_id then
        INSERT INTO follow_log(follower_id, followed_id, error_message)
        VALUES (p_follower_id, p_followed_id, 'Không thể tự follow chính mình');

        ROLLBACK;

    ELSE
        -- Kiểm tra đã follow chưa
        SELECT COUNT(*) INTO already_followed
        FROM followers
        WHERE follower_id = p_follower_id
          AND followed_id = p_followed_id;

        IF already_followed > 0 THEN

            INSERT INTO follow_log(follower_id, followed_id, error_message)
            VALUES (p_follower_id, p_followed_id, 'Đã follow trước đó');

            ROLLBACK;

        ELSE
            -- Thực hiện follow
            INSERT INTO followers(follower_id, followed_id)
            VALUES (p_follower_id, p_followed_id);

            UPDATE users
            SET following_count = following_count + 1
            WHERE user_id = p_follower_id;

            UPDATE users
            SET followers_count = followers_count + 1
            WHERE user_id = p_followed_id;

            COMMIT;
        END IF;
    END IF;

END$$

DELIMITER ;


CALL sp_follow_user(1, 2); 
CALL sp_follow_user(1, 1);
CALL sp_follow_user(1, 2);
CALL sp_follow_user(99, 3);