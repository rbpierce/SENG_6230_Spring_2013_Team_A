-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.6.10-log - MySQL Community Server (GPL)
-- Server OS:                    Win32
-- HeidiSQL version:             7.0.0.4053
-- Date/time:                    2013-04-20 20:17:21
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET FOREIGN_KEY_CHECKS=0 */;

-- Dumping structure for table mediquik_team_a.permission
DROP TABLE IF EXISTS `permission`;
CREATE TABLE IF NOT EXISTS `permission` (
  `id` int(11) NOT NULL,
  `name` varchar(40) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_permission__name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table mediquik_team_a.permission: ~10 rows (approximately)
DELETE FROM `permission`;
/*!40000 ALTER TABLE `permission` DISABLE KEYS */;
INSERT INTO `permission` (`id`, `name`, `description`) VALUES
	(1, 'doctor_appointment.jsp', 'Make a doctor appointment here'),
	(3, 'admin_only.jsp', 'Admin\'s cofigs'),
	(5, '/MediQuick/ViewPatientsServlet', 'See the list of your patients'),
	(6, 'ViewTests.jsp', 'See the list of your tests'),
	(7, '/MediQuick/ViewLabRequests', 'See the list of requests sent to this lab'),
	(8, 'Nurse.jsp', 'Nurse Temporary'),
	(9, 'SEARCH_PATIENTS', 'Can search for patients by name'),
	(10, 'VIEW_SUMMARY_PATIENT_DEMOGRAPHICS', 'See abbreviated patient demographics'),
	(11, 'VIEW_COMPLETE_PATIENT_DEMOGRAPHICS', 'See complete patient demographics'),
	(12, 'EDIT_PATIENT_DEMOGRAPHICS', 'Edit patient demographics');
/*!40000 ALTER TABLE `permission` ENABLE KEYS */;


-- Dumping structure for table mediquik_team_a.person
DROP TABLE IF EXISTS `person`;
CREATE TABLE IF NOT EXISTS `person` (
  `id` int(11) NOT NULL,
  `member_type` enum('ADMIN','PATIENT','NURSE','PHYSICIAN','TECHNICIAN') NOT NULL,
  `first_name` varchar(60) NOT NULL,
  `middle_name` varchar(60) DEFAULT NULL,
  `last_name` varchar(60) NOT NULL,
  `maiden_name` varchar(60) NOT NULL DEFAULT '',
  `suffix` varchar(20) NOT NULL DEFAULT '',
  `gender` enum('UNKNOWN','MALE','FEMALE') NOT NULL DEFAULT 'UNKNOWN',
  `marital_status` enum('SINGLE','MARRIED','DOMESTICPARTNERSHIP','DIVORCED','SEPARATED','WIDOWED','UNREPORTED','UNMARRIED') NOT NULL DEFAULT 'UNREPORTED',
  `birth_date` date DEFAULT NULL,
  `is_test` tinyint(1) DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `username` varchar(60) DEFAULT NULL,
  `password_plaintext` varchar(255) DEFAULT NULL COMMENT 'Replace with hash for production, but fine for development purposes',
  `is_password_reset_required` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table mediquik_team_a.person: ~10 rows (approximately)
DELETE FROM `person`;
/*!40000 ALTER TABLE `person` DISABLE KEYS */;
INSERT INTO `person` (`id`, `member_type`, `first_name`, `middle_name`, `last_name`, `maiden_name`, `suffix`, `gender`, `marital_status`, `birth_date`, `is_test`, `is_active`, `username`, `password_plaintext`, `is_password_reset_required`) VALUES
	(1, 'PATIENT', 'John', NULL, 'Smith', '', '', 'MALE', 'SINGLE', NULL, 0, 1, 'john', 'smith', 0),
	(2, 'NURSE', 'Jane', NULL, 'Smitha', '', '', 'FEMALE', 'SINGLE', NULL, 0, 1, 'jane', 'smitha', 0),
	(3, 'ADMIN', 'Arman', NULL, 'Samavatian', '', '', 'MALE', 'SINGLE', NULL, 0, 1, 'arman', 'sam', 0),
	(4, 'PHYSICIAN', 'Junhua', '', 'Ding', '', '', 'MALE', 'MARRIED', NULL, 0, 1, 'junhua', 'ding', 0),
	(5, 'PHYSICIAN', 'Ozzy', NULL, 'Osbourne', '', '', 'MALE', 'MARRIED', NULL, 0, 1, 'ozzy', 'osbourne', 0),
	(7, 'PATIENT', 'Maynard', NULL, 'Keenan', '', '', 'MALE', 'MARRIED', NULL, 0, 1, 'maynard', 'keenan', 0),
	(8, 'PATIENT', 'John', NULL, 'Petrucci', '', '', 'MALE', 'MARRIED', NULL, 0, 1, 'john', 'petrucci', 0),
	(9, 'PHYSICIAN', 'John', NULL, 'Myung', '', '', 'MALE', 'MARRIED', NULL, 0, 1, 'john', 'myung', 0),
	(10, 'TECHNICIAN', 'Joe', '', 'Satriani', '', '', 'MALE', 'MARRIED', NULL, 0, 1, 'joe', 'satriani', 0),
	(11, 'PHYSICIAN', 'Doctor', NULL, 'Mom', '', '', 'FEMALE', 'MARRIED', NULL, 1, 1, 'physician', 'test', 0);
/*!40000 ALTER TABLE `person` ENABLE KEYS */;


-- Dumping structure for table mediquik_team_a.role_permission
DROP TABLE IF EXISTS `role_permission`;
CREATE TABLE IF NOT EXISTS `role_permission` (
  `id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_role_permission` (`role_id`,`permission_id`),
  KEY `fk_role_permission__permission` (`permission_id`),
  KEY `fk_role_permission__role` (`role_id`),
  CONSTRAINT `fk_role_permission__permission` FOREIGN KEY (`permission_id`) REFERENCES `permission` (`id`),
  CONSTRAINT `fk_role_permission__role` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table mediquik_team_a.role_permission: ~19 rows (approximately)
DELETE FROM `role_permission`;
/*!40000 ALTER TABLE `role_permission` DISABLE KEYS */;
INSERT INTO `role_permission` (`id`, `role_id`, `permission_id`) VALUES
	(1, 1, 1),
	(8, 1, 6),
	(11, 1, 11),
	(16, 1, 12),
	(10, 2, 8),
	(2, 2, 9),
	(12, 2, 11),
	(17, 2, 12),
	(9, 3, 7),
	(3, 3, 9),
	(13, 3, 10),
	(6, 4, 5),
	(4, 4, 9),
	(14, 4, 11),
	(18, 4, 12),
	(5, 5, 3),
	(7, 5, 9),
	(15, 5, 11),
	(19, 5, 12);
/*!40000 ALTER TABLE `role_permission` ENABLE KEYS */;
/*!40014 SET FOREIGN_KEY_CHECKS=1 */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
