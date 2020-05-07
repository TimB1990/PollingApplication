DROP PROCEDURE IF EXISTS cast_vote;
DELIMITER //
CREATE PROCEDURE cast_vote(ip varchar(64), poll_id bigint(20) unsigned, answer_id bigint(20) unsigned, generated_token varchar(64))
BEGIN

DECLARE existingClient, validToken BOOLEAN DEFAULT FALSE;
DECLARE role enum('user','guest');
DECLARE client_id, answers_questions_id BIGINT(20) unsigned;
-- DECLARE token VARCHAR(64);

SET existingClient = (SELECT EXISTS (SELECT clients.ip FROM clients WHERE clients.ip = ip));

IF (existingClient = 1) THEN
	SET role = (SELECT clients.role FROM clients WHERE clients.ip = ip);

	IF (role = 'guest') THEN
		SELECT 0 AS success, 0 AS requiresLogin;
	END IF;

	IF (role = 'user') THEN
		-- check valid token
		SET validToken = (SELECT EXISTS(SELECT users.generated_token FROM users WHERE users.ip = ip AND users.generated_token = generated_token AND users.generated_token != 'notoken'));

		IF(validToken = 1) THEN
			SET client_id = (SELECT clients.id FROM clients WHERE clients.ip = ip);
			SET answers_questions_id = (SELECT paq.id FROM poll_answers_questions paq WHERE paq.poll_questions_id = poll_id AND paq.poll_answers_id = answer_id);
			INSERT INTO votes (poll_answers_questions_id, client_id) VALUES (answers_questions_id, client_id);
			UPDATE poll_answers_questions SET votes = votes + 1 WHERE poll_answers_questions.id = answers_questions_id;
			UPDATE poll_questions SET votes = votes + 1 WHERE id = poll_id;	
			SELECT 1 AS success, 0 AS requiresLogin;
		ELSE
			SELECT 0 AS success, 1 AS requiresLogin;
		END IF;
	END IF;

ELSE
	-- anonymous voter
	INSERT INTO clients (ip, role) VALUES (ip, "guest");
	SET client_id = (SELECT clients.id FROM clients WHERE clients.ip = ip);
	SET answers_questions_id = (SELECT paq.id FROM poll_answers_questions paq WHERE paq.poll_questions_id = poll_id AND paq.poll_answers_id = answer_id);
	INSERT INTO votes (poll_answers_questions_id, client_id) VALUES (answers_questions_id, client_id);
	UPDATE poll_answers_questions SET votes = votes + 1 WHERE poll_answers_questions.id = answers_questions_id;
	UPDATE poll_questions SET votes = votes + 1 WHERE id = poll_id;	
	SELECT 1 AS success, 0 AS requiresLogin;

END IF;

END //
DELIMITER ;