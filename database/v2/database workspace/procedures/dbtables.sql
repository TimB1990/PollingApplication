create table users (

id bigint(20) unsigned, 
client_id bigint(20) unsigned,
uname varchar(64),
password varchar(255),
email varbinary(32),
age int(3),
gender enum('male','female','neutral'),
residence varchar(64),

country varchar(64),
subscribed boolean,
created_at timestamp default current_timestamp,
updated_at timestamp default current_timestamp on update current_timestamp,
primary key(id), foreign key (token_id) references tokens(id) on delete cascade
);

-- depricated, look up database for table clients
create table tokens (
id bigint(20) unsigned auto_increment,
token varbinary(32),
ip char(64),
role enum('guest','user'),
created_at timestamp default current_timestamp,
primary key(id)
);

create table poll_questions (
	id bigint(20) unsigned auto_increment,
	description varchar(255) unique,
	qvotes int(10),
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	primary key(id)
);

create table poll_answers (
	id bigint(20) unsigned auto_increment,
	description varchar(255) unique,
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	primary key(id)
);

create table poll_answers_questions (id bigint(20) unsigned auto_increment, poll_questions_id bigint(20) unsigned, poll_answers_id bigint(20) unsigned, votes int(10), created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp,
	primary key(id),
	foreign key (poll_questions_id) references poll_questions(id) on delete cascade,
	foreign key (poll_answers_id) references poll_answers(id) on delete cascade);
	
-- votes
create table votes (id bigint(20) unsigned, poll_answers_questions_id bigint(20) unsigned, tokens_id bigint(20) unsigned, created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp on update current_timestamp, primary key(id), foreign key (poll_answers_questions_id) references poll_answers_questions(id), foreign key (tokens_id) references tokens(id));


	-- user
	GRANT EXECUTE ON PROCEDURE polling_v2.cast_vote TO guest@localhost;
	GRANT EXECUTE ON PROCEDURE polling_v2.createPoll TO guest@localhost;
	GRANT EXECUTE ON PROCEDURE polling_v2.fetch_poll TO guest@localhost;
	GRANT EXECUTE ON PROCEDURE polling_v2.get_user_role TO guest@localhost;
	GRANT EXECUTE ON PROCEDURE polling_v2.loginUser TO guest@localhost;
	GRANT EXECUTE ON PROCEDURE polling_v2.logoutUser TO guest@localhost;
	GRANT EXECUTE ON PROCEDURE polling_v2.registerUser TO guest@localhost;