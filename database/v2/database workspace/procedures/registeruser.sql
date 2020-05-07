DROP PROCEDURE IF EXISTS registerUser;
DELIMITER //
CREATE PROCEDURE registerUser (IN uname VARCHAR(64), IN password VARCHAR(255), IN email VARCHAR(200), IN birthdate DATE, IN gender VARCHAR(8), IN residence VARCHAR(64), IN country VARCHAR(64), IN ip CHAR(64), IN subscribe BOOLEAN)
BEGIN
DECLARE existingClient, existingUname, existingEmail, existingIp BOOLEAN;
-- check existing client
SET existingClient = (SELECT EXISTS(SELECT clients.ip FROM clients WHERE clients.ip = ip));

IF(existingClient = 1) THEN
   UPDATE clients SET role = "user" WHERE clients.ip = ip;
ELSE
   INSERT INTO clients (ip, role) values (ip, 'user');
END IF;

SET existingUname = (SELECT EXISTS(SELECT users.uname FROM users WHERE users.uname = uname));

SET existingEmail = (SELECT EXISTS(SELECT users.email FROM users WHERE users.email = email));

SET existingIp = (SELECT EXISTS(SELECT users.ip FROM users WHERE users.ip = ip));

IF(existingUname = 1 OR existingEmail = 1 OR existingIp = 1) THEN
   SELECT CONCAT("Cannot process registration, given username or email are allready taken, or this ip address has allready an account registred") AS msg;
ELSE
   INSERT INTO users (ip, generated_token, uname, password, email, birthdate, gender, residence, country, subscribed)
   VALUES (ip, "notoken", uname, SHA2(password,256), email, birthdate, gender, residence, country, subscribe);
   SELECT CONCAT("OK") AS msg;
END IF;

END //
DELIMITER ;

CALL registerUser('test','test','test@mail.com', '1990-12-25', 'male', 'Eindhoven', 'Netherlands','first.test.ip', 1);