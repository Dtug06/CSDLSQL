USE social_network_pro;

DELIMITER $$

CREATE PROCEDURE pro_post_page(IN p_user_id INT)
BEGIN
    SELECT 
        post_id,
        content,
        created_at
    FROM posts
    WHERE user_id = p_user_id;
END$$

DELIMITER ;

CALL pro_post_page(1);

DROP PROCEDURE pro_post_page;
