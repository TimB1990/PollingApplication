-- clients
CREATE TABLE `clients` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ip` char(64) DEFAULT NULL,
  `role` enum('guest','user') DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ip` (`ip`)
);

-- poll_answers
CREATE TABLE `poll_answers` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `description` (`description`)
);

-- poll_questions
CREATE TABLE `poll_questions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL,
  `votes` int(10) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `description` (`description`)
);

-- poll_answers_questions (pivot table)
CREATE TABLE `poll_answers_questions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `poll_questions_id` bigint(20) unsigned DEFAULT NULL,
  `poll_answers_id` bigint(20) unsigned DEFAULT NULL,
  `votes` int(10) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `poll_questions_id` (`poll_questions_id`),
  KEY `poll_answers_id` (`poll_answers_id`),
  CONSTRAINT `poll_answers_questions_ibfk_1` FOREIGN KEY (`poll_questions_id`) REFERENCES `poll_questions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `poll_answers_questions_ibfk_2` FOREIGN KEY (`poll_answers_id`) REFERENCES `poll_answers` (`id`) ON DELETE CASCADE
);

-- users
 CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ip` varchar(64) DEFAULT NULL,
  `generated_token` varchar(64) DEFAULT NULL,
  `uname` varchar(64) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `email` varbinary(32) DEFAULT NULL,
  `birthdate` date DEFAULT NULL,
  `gender` enum('male','female','neutral') DEFAULT NULL,
  `residence` varchar(64) DEFAULT NULL,
  `country` varchar(64) DEFAULT NULL,
  `subscribed` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `generated_token` (`generated_token`)
);

-- votes
CREATE TABLE `votes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `poll_answers_questions_id` bigint(20) unsigned DEFAULT NULL,
  `client_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `poll_answers_questions_id` (`poll_answers_questions_id`),
  KEY `client_id` (`client_id`),
  CONSTRAINT `votes_ibfk_1` FOREIGN KEY (`poll_answers_questions_id`) REFERENCES `poll_answers_questions` (`id`),
  CONSTRAINT `votes_ibfk_2` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`)
);