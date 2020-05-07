DROP PROCEDURE IF EXISTS createPoll;
DELIMITER //
CREATE PROCEDURE createPoll(IN question_description VARCHAR(255), IN commaSeperatedAnswers VARCHAR(255))
BEGIN
-- declare variables
DECLARE answeramount INT;
DECLARE questions_id, answers_id BIGINT(20);
DECLARE c INT DEFAULT 0;
DECLARE modified VARCHAR(200);
DECLARE answer varchar(20);
DECLARE answerExists, pollExists BOOLEAN;

-- calculate amount of answers (length with commas included - length with commas excluded + 1)
set answeramount = LENGTH(commaSeperatedAnswers) - LENGTH(REPLACE(commaSeperatedAnswers, ",", "")) + 1;
-- insert new question (description)
insert into poll_questions(description, votes) values (question_description, 0);
-- get current question_id
set questions_id = (SELECT id FROM poll_questions p WHERE p.description = question_description);

-- extract and insert answers into poll_answers
WHILE c < answeramount DO
	IF (c = 0) THEN
		SET modified = TRIM(commaSeperatedAnswers);
	END IF;
	-- extract first answer
	SET answer = (SELECT TRIM(SUBSTRING_INDEX(modified, ",", 1)));
	
	-- check if answer exists
	SET answerExists = (SELECT EXISTS(SELECT description FROM poll_answers WHERE description = answer));
	IF(answerExists = 1) THEN
		SET answers_id = (SELECT id FROM poll_answers WHERE description = answer);
		-- insert poll_answers_questions record
		INSERT INTO poll_answers_questions (poll_questions_id, poll_answers_id, votes) VALUES (questions_id, answers_id, 0);
	ELSE
		-- insert answer into poll_answers
		INSERT INTO poll_answers(description) values (answer);
		-- retrieve created answer id
		SET answers_id = (SELECT id FROM poll_answers WHERE description = answer);
		-- insert poll_answers_questions record
		INSERT INTO poll_answers_questions (poll_questions_id, poll_answers_id, votes) VALUES (questions_id, answers_id, 0);

	END IF;

	-- adjust modified
	set modified = (select trim(leading substring(modified,1,length(answer) + 1) from modified));
	-- increase the counter
	SET c = c + 1;

END WHILE;

END //
DELIMITER ;