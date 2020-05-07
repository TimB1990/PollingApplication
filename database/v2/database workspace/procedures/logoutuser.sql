-- logout user procedure --
DROP PROCEDURE IF EXISTS logoutUser;
DELIMITER //
CREATE PROCEDURE logoutUser(IN ip VARCHAR(64))
BEGIN
UPDATE users SET generated_token = "notoken" WHERE users.ip = ip;
END //
DELIMITER ;