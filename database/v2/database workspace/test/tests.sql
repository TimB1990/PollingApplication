-- create dummy poll data
call createPoll("do you have glasses", "yes,no");
call createPoll("how good are you at math?", "not at all,a little,very good");
call createPoll("how good are you at biology?", "not at all,a little,very good");

call createPoll("What is your favorite color?","red,green,blue,pink");
call createPoll("What is your favorite pet?","dog,cat,parrot,bunny");
call createPoll("Which exercise do you prefer most?","athletics,footbal,hockey,gym");
call createPoll("What programming language for backend development do you prefer most?","PHP,java,Javascript");
call createPoll("what framework have you recently used in your front-end development?","JSTL,Vue,other");


-- reset logic
set foreign_key_checks = 0;
truncate table clients;
truncate table users;
truncate table votes;
update poll_answers_questions set votes = 0 where votes > 0;
