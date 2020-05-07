DROP PROCEDURE IF EXISTS get_user_role;
DELIMITER //
CREATE PROCEDURE get_user_role (IN ip VARCHAR(64))
BEGIN
--
DECLARE isClient BOOLEAN DEFAULT 0;
-- check if ip is client
SET isClient = (SELECT EXISTS(SELECT ip FROM clients WHERE clients.ip = ip));
IF(isClient = 1) THEN
SELECT clients.role AS role FROM clients WHERE clients.ip = ip;
ELSE
SELECT "anonymous" AS role;
END IF;

END //
DELIMITER ;