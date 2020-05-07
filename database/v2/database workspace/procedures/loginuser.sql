DROP PROCEDURE IF EXISTS loginUser;
DELIMITER //
CREATE PROCEDURE loginUser(IN uname VARCHAR(64), IN pass VARCHAR(255))
BEGIN
DECLARE success BOOLEAN DEFAULT 0;
SET success = (SELECT EXISTS(SELECT id FROM users WHERE users.uname = uname AND users.password = SHA2(pass,256)));
IF(success = 1) THEN
	UPDATE users SET generated_token = CONCAT(SUBSTRING(MD5(RAND()) FROM 1 FOR 16)) WHERE users.uname = uname;
	SELECT generated_token FROM users WHERE users.uname = uname;
END IF;
SELECT "invalid" AS generated_token;
END //
DELIMITER ;