-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.6.10-log - MySQL Community Server (GPL)
-- Server OS:                    Win32
-- HeidiSQL version:             7.0.0.4053
-- Date/time:                    2013-04-20 18:40:22
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET FOREIGN_KEY_CHECKS=0 */;

-- Dumping structure for table mediquik_team_a.permission
CREATE TABLE IF NOT EXISTS `permission` (
  `id` int(11) NOT NULL,
  `name` varchar(40) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_permission__name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table mediquik_team_a.permission: ~7 rows (approximately)
DELETE FROM `permission`;
/*!40000 ALTER TABLE `permission` DISABLE KEYS */;
INSERT INTO `permission` (`id`, `name`, `description`) VALUES
	(1, 'doctor_appointment.jsp', 'Make a doctor appointment here'),
	(3, 'admin_only.jsp', 'Admin\'s cofigs'),
	(5, '/MediQuick/ViewPatientsServlet', 'See the list of your patients'),
	(6, 'ViewTests.jsp', 'See the list of your tests'),
	(7, '/MediQuick/ViewLabRequests', 'See the list of requests sent to this lab'),
	(8, 'Nurse.jsp', 'Nurse Temporary'),
	(9, 'SEARCH_PATIENTS', 'Can search for patients by name');
/*!40000 ALTER TABLE `permission` ENABLE KEYS */;


-- Dumping structure for table mediquik_team_a.role_permission
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

-- Dumping data for table mediquik_team_a.role_permission: ~10 rows (approximately)
DELETE FROM `role_permission`;
/*!40000 ALTER TABLE `role_permission` DISABLE KEYS */;
INSERT INTO `role_permission` (`id`, `role_id`, `permission_id`) VALUES
	(1, 1, 1),
	(8, 1, 6),
	(10, 2, 8),
	(2, 2, 9),
	(9, 3, 7),
	(3, 3, 9),
	(6, 4, 5),
	(4, 4, 9),
	(5, 5, 3),
	(7, 5, 9);
/*!40000 ALTER TABLE `role_permission` ENABLE KEYS */;
/*!40014 SET FOREIGN_KEY_CHECKS=1 */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
