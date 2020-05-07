DROP PROCEDURE IF EXISTS questionsLeft;
DELIMITER //
CREATE PROCEDURE questionsLeft (IN ip VARCHAR(64))
BEGIN
DECLARE client_id bigint(20) unsigned;
DECLARE answered, totalPolls INT(10);

-- retrieve client_id
SET client_id = (SELECT clients.id FROM clients WHERE clients.ip = ip);

-- count answered
SET answered = (SELECT count(*) FROM poll_answers_questions paq, votes v WHERE paq.id = v.poll_answers_questions_id AND v.client_id = client_id);

-- count totalPolls
SET totalPolls = (SELECT count(*) FROM poll_questions);

-- if answerd < totalpolls
IF(answered < totalPolls) THEN
   SELECT 1 AS questionsleft;
ELSE
   SELECT 0 AS questionsleft;
END IF;

END //
DELIMITER ;
