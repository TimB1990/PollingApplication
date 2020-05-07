DROP PROCEDURE IF EXISTS fetch_poll;
DELIMITER // 
CREATE PROCEDURE fetch_poll (IN ip CHAR(64))
BEGIN
-- declare variables
DECLARE poll_id, client_id bigint(20) unsigned;
DECLARE isExistingClient BOOLEAN default false;
DECLARE client_role enum('user','guest');
DECLARE poll_questions_count INT(10);

-- check is user has token, set client_id and set client_role
SET isExistingClient = (select exists(select id from clients where clients.ip = ip ));
IF(isExistingClient = 1) THEN
	SET client_id = (SELECT clients.id FROM clients WHERE clients.ip = ip);
	SET client_role = (SELECT clients.role FROM clients WHERE clients.id = client_id);

	IF (client_role = "user") THEN

	-- select random from unanswered
	SET poll_id = (SELECT pq.id FROM poll_questions pq WHERE pq.id NOT IN (
		SELECT paq.poll_questions_id 
		FROM poll_answers_questions paq, votes v
		WHERE paq.id = v.poll_answers_questions_id AND v.client_id = client_id
	) ORDER BY RAND() LIMIT 1);

	-- output selection with poll_questions_id, poll_answers_id's
	SELECT q.id AS id, q.description AS poll, a.id AS answerid, a.description AS answers, aq.votes AS votes 
	FROM poll_questions q, poll_answers a, poll_answers_questions aq
	WHERE aq.poll_answers_id = a.id 
	AND aq.poll_questions_id = q.id
	AND aq.poll_questions_id = poll_id;
	END IF;
	-- 
	IF (client_role = "guest") THEN
	-- set poll_id to single random question_id of not unanswered questions
	SET poll_id = (SELECT pq.id FROM poll_questions pq WHERE pq.id IN (
		SELECT paq.poll_questions_id 
		FROM poll_answers_questions paq, votes v
		WHERE paq.id = v.poll_answers_questions_id AND v.client_id = client_id
	) LIMIT 1);
	-- output selection with poll_questions_id, poll_answers_id's
	SELECT q.id AS id, q.description AS poll, a.id AS answerid, a.description AS answers, aq.votes AS votes
	FROM poll_questions q, poll_answers a, poll_answers_questions aq
	WHERE aq.poll_answers_id = a.id 
	AND aq.poll_questions_id = q.id
	AND aq.poll_questions_id = poll_id;
	END IF;
ELSE
	-- set poll_id to single random question_id
	SET poll_id = (SELECT id FROM poll_questions ORDER BY RAND() LIMIT 1);
	-- output selection with poll_questions_id, poll_answers_id's
	SELECT q.id AS id, q.description AS poll, a.id AS answerid, a.description AS answers, aq.votes AS votes
	FROM poll_questions q, poll_answers a, poll_answers_questions aq
	WHERE aq.poll_answers_id = a.id 
	AND aq.poll_questions_id = q.id
	AND aq.poll_questions_id = poll_id;

END IF;

END //
DELIMITER ;

GRANT EXECUTE ON PROCEDURE `polling_v2`.`cast_vote` TO `guest`@`localhost`;
GRANT EXECUTE ON PROCEDURE `polling_v2`.`fetch_poll` TO `guest`@`localhost`;
GRANT EXECUTE ON PROCEDURE `polling_v2`.`get_user_role` TO `guest`@`localhost`;
GRANT EXECUTE ON PROCEDURE `polling_v2`.`loginuser` TO `guest`@`localhost`;
GRANT EXECUTE ON PROCEDURE `polling_v2`.`logoutuser` TO `guest`@`localhost`;
GRANT EXECUTE ON PROCEDURE `polling_v2`.`registeruser` TO `guest`@`localhost`;

-- unit tests

SELECT paq.poll_questions_id 
		FROM poll_answers_questions paq, votes v
		WHERE paq.id = v.poll_answers_questions_id AND v.client_id = 1

SELECT count(*)
		FROM poll_answers_questions paq, votes v
		WHERE paq.id = v.poll_answers_questions_id AND v.client_id = 1