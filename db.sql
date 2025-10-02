
-- Script d'initialisation de la base de données QzLab

-- Créer la base de données si elle n'existe pas
-- CREATE DATABASE IF NOT EXISTS qzlab CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Utiliser la base de données
USE qzlab;

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

--
-- Base de données : `qzlab`
--

-- --------------------------------------------------------

--
-- Structure de la table `answer`
--

DROP TABLE IF EXISTS `answer`;
CREATE TABLE IF NOT EXISTS `answer` (
  `id` int NOT NULL AUTO_INCREMENT,
  `question_id` int DEFAULT NULL,
  `text` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `order_index` int DEFAULT NULL,
  `is_correct` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `question_id` (`question_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `answer`
--


-- --------------------------------------------------------

--
-- Structure de la table `answer_pair`
--

DROP TABLE IF EXISTS `answer_pair`;
CREATE TABLE IF NOT EXISTS `answer_pair` (
  `id` int NOT NULL AUTO_INCREMENT,
  `question_id` int NOT NULL,
  `left_element` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `right_element` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `question_id` (`question_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `badge`
--

DROP TABLE IF EXISTS `badge`;
CREATE TABLE IF NOT EXISTS `badge` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `icon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `organization_id` int NOT NULL,
  `created_by` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `organization_id` (`organization_id`),
  KEY `created_by` (`created_by`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `category`
--

DROP TABLE IF EXISTS `category`;
CREATE TABLE IF NOT EXISTS `category` (
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `category`
--

INSERT INTO `category` (`id`) VALUES
(1),
(2),
(3),
(4),
(5),
(6);

-- --------------------------------------------------------

--
-- Structure de la table `category_translation`
--

DROP TABLE IF EXISTS `category_translation`;
CREATE TABLE IF NOT EXISTS `category_translation` (
  `category_id` int NOT NULL,
  `language_code` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`category_id`,`language_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `category_translation`
--

INSERT INTO `category_translation` (`category_id`, `language_code`, `name`) VALUES
(1, 'en', 'Science'),
(1, 'fr', 'Science'),
(2, 'en', 'History'),
(2, 'fr', 'Histoire'),
(3, 'en', 'General Knowledge'),
(3, 'fr', 'Culture générale'),
(4, 'en', 'Sport'),
(4, 'fr', 'Sport'),
(5, 'en', 'Arts'),
(5, 'fr', 'Arts'),
(6, 'en', 'Custom quizzes'),
(6, 'fr', 'Quiz personnalisés');

-- --------------------------------------------------------

--
-- Structure de la table `organization`
--

DROP TABLE IF EXISTS `organization`;
CREATE TABLE IF NOT EXISTS `organization` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `logo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `organization_type` enum('Entreprise','Association','École/Université','Club','Autre') COLLATE utf8mb4_unicode_ci NOT NULL,
  `max_members` int DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `created_by` (`created_by`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `organization_message`
--

DROP TABLE IF EXISTS `organization_message`;
CREATE TABLE IF NOT EXISTS `organization_message` (
  `id` int NOT NULL AUTO_INCREMENT,
  `organization_id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `organization_id` (`organization_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `permission`
--

DROP TABLE IF EXISTS `permission`;
CREATE TABLE IF NOT EXISTS `permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `permission`
--

INSERT INTO `permission` (`id`, `name`) VALUES
(15, 'assign_remove_member_service_team'),
(13, 'create_delete_service_team'),
(7, 'create_edit_badge'),
(5, 'create_edit_quiz'),
(2, 'delete_organization'),
(6, 'delete_quiz'),
(1, 'edit_organization'),
(14, 'edit_service_team'),
(17, 'export_import_quiz'),
(3, 'invite_user'),
(16, 'manage_badges'),
(8, 'manage_roles'),
(10, 'open_close_quiz_room'),
(4, 'remove_user'),
(9, 'schedule_quiz'),
(11, 'start_stop_team_quiz'),
(18, 'write_org_message');

-- --------------------------------------------------------

--
-- Structure de la table `question`
--

DROP TABLE IF EXISTS `question`;
CREATE TABLE IF NOT EXISTS `question` (
  `id` int NOT NULL AUTO_INCREMENT,
  `quiz_id` int DEFAULT NULL,
  `type` enum('qcm','order','association','intruder','blind_test') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'qcm',
  `text` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `media_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `quiz_id` (`quiz_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `quiz`
--

DROP TABLE IF EXISTS `quiz`;
CREATE TABLE IF NOT EXISTS `quiz` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_id` int DEFAULT NULL,
  `difficulty` enum('Débutant','Intermédiaire','Avancé','Expert') COLLATE utf8mb4_unicode_ci DEFAULT 'Débutant',
  `description` text COLLATE utf8mb4_unicode_ci,
  `seconds_per_question` int DEFAULT NULL,
  `organization_id` int DEFAULT NULL,
  `is_scheduled` tinyint(1) DEFAULT '0',
  `scheduled_at` timestamp NULL DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_quiz_title` (`title`(191)),
  KEY `organization_id` (`organization_id`),
  KEY `created_by` (`created_by`),
  KEY `category_id` (`category_id`),
  KEY `fk_quiz_modified_by` (`modified_by`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;;

-- --------------------------------------------------------

--
-- Structure de la table `quiz_room`
--

DROP TABLE IF EXISTS `quiz_room`;
CREATE TABLE IF NOT EXISTS `quiz_room` (
  `id` int NOT NULL AUTO_INCREMENT,
  `organization_id` int NOT NULL,
  `quiz_id` int DEFAULT NULL,
  `status` enum('open','closed') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'open',
  `created_by` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `organization_id` (`organization_id`),
  KEY `quiz_id` (`quiz_id`),
  KEY `created_by` (`created_by`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `role`
--

DROP TABLE IF EXISTS `role`;
CREATE TABLE IF NOT EXISTS `role` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `role`
--

INSERT INTO `role` (`id`, `name`) VALUES
(6, 'Animateur'),
(3, 'Assistant RH'),
(9, 'Collaborateur'),
(7, 'Communication'),
(1, 'DRH'),
(5, 'Gestionnaire de projet'),
(4, 'Responsable de service'),
(2, 'Responsable RH'),
(8, 'Service client / Commercial');

-- --------------------------------------------------------

--
-- Structure de la table `role_permission`
--

DROP TABLE IF EXISTS `role_permission`;
CREATE TABLE IF NOT EXISTS `role_permission` (
  `role_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`role_id`,`permission_id`),
  KEY `permission_id` (`permission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `role_permission`
--

INSERT INTO `role_permission` (`role_id`, `permission_id`) VALUES
(1, 1),
(1, 2),
(1, 3),
(2, 3),
(3, 3),
(1, 4),
(2, 4),
(1, 5),
(2, 5),
(3, 5),
(1, 6),
(2, 6),
(3, 6),
(1, 7),
(2, 7),
(1, 8),
(2, 8),
(1, 9),
(2, 9),
(3, 9),
(6, 9),
(1, 10),
(2, 10),
(6, 10),
(1, 11),
(2, 11),
(6, 11),
(1, 13),
(2, 13),
(1, 14),
(2, 14),
(4, 14),
(1, 15),
(2, 15),
(3, 15),
(4, 15),
(1, 16),
(2, 16),
(1, 17),
(2, 17),
(3, 17),
(1, 18),
(2, 18),
(7, 18);

-- --------------------------------------------------------

--
-- Structure de la table `service`
--

DROP TABLE IF EXISTS `service`;
CREATE TABLE IF NOT EXISTS `service` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `organization_id` int NOT NULL,
  `created_by` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `organization_id` (`organization_id`),
  KEY `created_by` (`created_by`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `team`
--

DROP TABLE IF EXISTS `team`;
CREATE TABLE IF NOT EXISTS `team` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `organization_id` int NOT NULL,
  `service_id` int DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `organization_id` (`organization_id`),
  KEY `service_id` (`service_id`),
  KEY `created_by` (`created_by`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_admin` tinyint(1) DEFAULT '0',
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `last_login` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` ( `id`, `username`, `email`, `password`, `is_admin`, `avatar`, `is_active`) VALUES
(1, 'admin', 'admin@example.com', '$2a$10$loeWMJxNj5yYV6dUH1mgsu5R85BELYEv1ANvC1Zf00igC/UGMnvLK', 1, NULL, 1);




-- --------------------------------------------------------

--
-- Structure de la table `user_badge`
--

DROP TABLE IF EXISTS `user_badge`;
CREATE TABLE IF NOT EXISTS `user_badge` (
  `user_id` int NOT NULL,
  `badge_id` int NOT NULL,
  `assigned_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`,`badge_id`),
  KEY `badge_id` (`badge_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `user_organization_role`
--

DROP TABLE IF EXISTS `user_organization_role`;
CREATE TABLE IF NOT EXISTS `user_organization_role` (
  `user_id` int NOT NULL,
  `organization_id` int NOT NULL,
  `role_id` int NOT NULL,
  `joined_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`,`organization_id`,`role_id`),
  KEY `organization_id` (`organization_id`),
  KEY `role_id` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `user_team`
--

DROP TABLE IF EXISTS `user_team`;
CREATE TABLE IF NOT EXISTS `user_team` (
  `user_id` int NOT NULL,
  `team_id` int NOT NULL,
  `joined_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`,`team_id`),
  KEY `team_id` (`team_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

-- Créer la table user_quiz_score
CREATE TABLE user_quiz_score (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  quiz_id INT NOT NULL,
  quiz_room_id INT,
  organization_id INT,
  score INT NOT NULL,
  total_questions INT NOT NULL,
  time_taken INT,
  completed_at TIMESTAMP NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (quiz_id) REFERENCES quiz(id) ON DELETE CASCADE,
  FOREIGN KEY (quiz_room_id) REFERENCES quiz_room(id) ON DELETE SET NULL,
  FOREIGN KEY (organization_id) REFERENCES organization(id) ON DELETE SET NULL
) ENGINE=InnoDB;

-------------------------------------------------------------

ALTER TABLE `answer`
  ADD CONSTRAINT `answer_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `question` (`id`) ON DELETE CASCADE;

ALTER TABLE `answer_pair`
  ADD CONSTRAINT `answer_pair_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `question` (`id`) ON DELETE CASCADE;

ALTER TABLE `badge`
  ADD CONSTRAINT `badge_ibfk_1` FOREIGN KEY (`organization_id`) REFERENCES `organization` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `badge_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

ALTER TABLE `category_translation`
  ADD CONSTRAINT `category_translation_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE CASCADE;

ALTER TABLE `organization`
  ADD CONSTRAINT `organization_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

ALTER TABLE `organization_message`
  ADD CONSTRAINT `organization_message_ibfk_1` FOREIGN KEY (`organization_id`) REFERENCES `organization` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `organization_message_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

ALTER TABLE `question`
  ADD CONSTRAINT `question_ibfk_1` FOREIGN KEY (`quiz_id`) REFERENCES `quiz` (`id`) ON DELETE CASCADE;

ALTER TABLE `quiz`
  ADD CONSTRAINT `fk_quiz_modified_by` FOREIGN KEY (`modified_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `quiz_ibfk_1` FOREIGN KEY (`organization_id`) REFERENCES `organization` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `quiz_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `quiz_ibfk_3` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE SET NULL;

ALTER TABLE `quiz_room`
  ADD CONSTRAINT `quiz_room_ibfk_1` FOREIGN KEY (`organization_id`) REFERENCES `organization` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `quiz_room_ibfk_2` FOREIGN KEY (`quiz_id`) REFERENCES `quiz` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `quiz_room_ibfk_3` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

ALTER TABLE `role_permission`
  ADD CONSTRAINT `role_permission_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_permission_ibfk_2` FOREIGN KEY (`permission_id`) REFERENCES `permission` (`id`) ON DELETE CASCADE;

ALTER TABLE `service`
  ADD CONSTRAINT `service_ibfk_1` FOREIGN KEY (`organization_id`) REFERENCES `organization` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `service_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

ALTER TABLE `team`
  ADD CONSTRAINT `team_ibfk_1` FOREIGN KEY (`organization_id`) REFERENCES `organization` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `team_ibfk_2` FOREIGN KEY (`service_id`) REFERENCES `service` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `team_ibfk_3` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

ALTER TABLE `user_badge`
  ADD CONSTRAINT `user_badge_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_badge_ibfk_2` FOREIGN KEY (`badge_id`) REFERENCES `badge` (`id`) ON DELETE CASCADE;

ALTER TABLE `user_organization_role`
  ADD CONSTRAINT `user_organization_role_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_organization_role_ibfk_2` FOREIGN KEY (`organization_id`) REFERENCES `organization` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_organization_role_ibfk_3` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE RESTRICT;

ALTER TABLE `user_team`
  ADD CONSTRAINT `user_team_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_team_ibfk_2` FOREIGN KEY (`team_id`) REFERENCES `team` (`id`) ON DELETE CASCADE;
COMMIT;

