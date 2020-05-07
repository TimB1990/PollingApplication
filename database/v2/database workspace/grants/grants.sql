-- add guest user 
CREATE USER 'guest' IDENTIFIED BY '';
-- grant execute privileges for stored procedures
GRANT EXECUTE ON PROCEDURE `polling_v2`.`cast_vote` TO `guest`@`localhost`;
GRANT EXECUTE ON PROCEDURE `polling_v2`.`fetch_poll` TO `guest`@`localhost`;
GRANT EXECUTE ON PROCEDURE `polling_v2`.`get_user_role` TO `guest`@`localhost`;
GRANT EXECUTE ON PROCEDURE `polling_v2`.`loginuser` TO `guest`@`localhost`;
GRANT EXECUTE ON PROCEDURE `polling_v2`.`logoutuser` TO `guest`@`localhost`;
GRANT EXECUTE ON PROCEDURE `polling_v2`.`registeruser` TO `guest`@`localhost`;
GRANT EXECUTE ON PROCEDURE `polling_v2`.`questionsleft` TO `guest`@`localhost`;
GRANT EXECUTE ON PROCEDURE `polling_v2`.`logoutuser` TO `guest`@`localhost`;

