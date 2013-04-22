-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.6.10-log - MySQL Community Server (GPL)
-- Server OS:                    Win32
-- HeidiSQL version:             7.0.0.4053
-- Date/time:                    2013-04-21 23:42:21
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET FOREIGN_KEY_CHECKS=0 */;

-- Dumping structure for table mediquik_team_a.general_message
DROP TABLE IF EXISTS `general_message`;
CREATE TABLE IF NOT EXISTS `general_message` (
  `id` int(11) NOT NULL,
  `person_id` int(11) NOT NULL,
  `text` varchar(200) DEFAULT NULL,
  `status` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table mediquik_team_a.general_message: ~5 rows (approximately)
DELETE FROM `general_message`;
/*!40000 ALTER TABLE `general_message` DISABLE KEYS */;
INSERT INTO `general_message` (`id`, `person_id`, `text`, `status`) VALUES
	(1, 1, 'Your appointment request with Dr. Junhua Ding was APPROVED by the nurse Jane Smitha, and is waiting for approval.', 'SEEN'),
	(2, 1, 'Your Test request with Dr. Junhua Ding was APPROVED, and is waiting for the results.', 'SEEN'),
	(3, 1, 'Your appointment request with Dr. Junhua Ding was APPROVED by the nurse Jane Smitha, and is waiting for approval.', 'SEEN'),
	(4, 1, 'Your Test request with Dr. Junhua Ding was DENIED (REQUEST_ID=23). You have to make another appointment to have another test request.', 'SEEN'),
	(5, 1, 'Your appointment request with Dr. Junhua Ding was DENIED by the nurse Jane Smitha. You can try again making an appointment later.', 'SEEN');
/*!40000 ALTER TABLE `general_message` ENABLE KEYS */;


-- Dumping structure for table mediquik_team_a.icd9_code
DROP TABLE IF EXISTS `icd9_code`;
CREATE TABLE IF NOT EXISTS `icd9_code` (
  `id` int(11) NOT NULL,
  `code` char(5) NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `icd9_code__code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table mediquik_team_a.icd9_code: ~1 rows (approximately)
DELETE FROM `icd9_code`;
/*!40000 ALTER TABLE `icd9_code` DISABLE KEYS */;
INSERT INTO `icd9_code` (`id`, `code`, `description`) VALUES
	(1, 'CODE', 'This is a test data');
/*!40000 ALTER TABLE `icd9_code` ENABLE KEYS */;


-- Dumping structure for table mediquik_team_a.laboratory
DROP TABLE IF EXISTS `laboratory`;
CREATE TABLE IF NOT EXISTS `laboratory` (
  `id` int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  `phone_number` char(10) NOT NULL,
  `street1` varchar(200) NOT NULL,
  `street2` varchar(200) DEFAULT NULL,
  `city` varchar(200) NOT NULL,
  `state_code` char(2) NOT NULL COMMENT 'USPS 2 letter state abbreviatiin- could change to ENUM',
  `zipcode` int(5) unsigned NOT NULL,
  `zipcode_plus4` int(4) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table mediquik_team_a.laboratory: ~1 rows (approximately)
DELETE FROM `laboratory`;
/*!40000 ALTER TABLE `laboratory` DISABLE KEYS */;
INSERT INTO `laboratory` (`id`, `name`, `phone_number`, `street1`, `street2`, `city`, `state_code`, `zipcode`, `zipcode_plus4`) VALUES
	(1, 'BestLAB', '2528641621', 'E 10th st', NULL, 'Greenville', 'NC', 27858, NULL);
/*!40000 ALTER TABLE `laboratory` ENABLE KEYS */;


-- Dumping structure for table mediquik_team_a.lab_request
DROP TABLE IF EXISTS `lab_request`;
CREATE TABLE IF NOT EXISTS `lab_request` (
  `id` int(11) NOT NULL,
  `laboratory_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `requesting_nurse_id` int(11) DEFAULT NULL,
  `nurse_request_time` datetime DEFAULT NULL,
  `ordering_physician_id` int(11) NOT NULL,
  `order_placed` datetime NOT NULL,
  `specimen_type` enum('Serum','Plasma','Urine','CSF','Whole Blood','Stool','Amniotic','Other') NOT NULL,
  `specimen_collection_time` datetime DEFAULT NULL,
  `specimen_number` varchar(200) DEFAULT NULL,
  `urine_collection_start` datetime DEFAULT NULL,
  `urine_collection_finish` datetime DEFAULT NULL,
  `urine_interval_in_minutes` int(5) unsigned DEFAULT NULL,
  `urine_volume_in_milliliters` int(5) unsigned DEFAULT NULL,
  `icd9_code_id` int(11) NOT NULL,
  `status` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_lab_request__laboratory` (`laboratory_id`),
  KEY `fk_lab_request__patient` (`patient_id`),
  KEY `fk_lab_request__nurse` (`requesting_nurse_id`),
  KEY `fk_lab_request__physician` (`ordering_physician_id`),
  KEY `fk_lab_request__icd9_code` (`icd9_code_id`),
  CONSTRAINT `fk_lab_request__icd9_code` FOREIGN KEY (`icd9_code_id`) REFERENCES `icd9_code` (`id`),
  CONSTRAINT `fk_lab_request__laboratory` FOREIGN KEY (`laboratory_id`) REFERENCES `laboratory` (`id`),
  CONSTRAINT `fk_lab_request__nurse` FOREIGN KEY (`requesting_nurse_id`) REFERENCES `nurse` (`person_id`),
  CONSTRAINT `fk_lab_request__patient` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`person_id`),
  CONSTRAINT `fk_lab_request__physician` FOREIGN KEY (`ordering_physician_id`) REFERENCES `physician` (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table mediquik_team_a.lab_request: ~23 rows (approximately)
DELETE FROM `lab_request`;
/*!40000 ALTER TABLE `lab_request` DISABLE KEYS */;
INSERT INTO `lab_request` (`id`, `laboratory_id`, `patient_id`, `requesting_nurse_id`, `nurse_request_time`, `ordering_physician_id`, `order_placed`, `specimen_type`, `specimen_collection_time`, `specimen_number`, `urine_collection_start`, `urine_collection_finish`, `urine_interval_in_minutes`, `urine_volume_in_milliliters`, `icd9_code_id`, `status`) VALUES
	(1, 1, 1, NULL, NULL, 4, '2013-04-02 11:11:59', 'Whole Blood', NULL, NULL, NULL, NULL, 0, 0, 1, 'Processed'),
	(2, 1, 1, NULL, NULL, 4, '2013-04-03 01:11:04', 'Whole Blood', NULL, NULL, NULL, NULL, 0, 0, 1, 'Processed'),
	(3, 1, 1, NULL, NULL, 4, '2013-04-03 01:18:19', 'Whole Blood', NULL, NULL, NULL, NULL, 0, 0, 1, 'Processed'),
	(4, 1, 1, NULL, NULL, 9, '2013-04-03 17:09:40', 'Whole Blood', NULL, NULL, NULL, NULL, 0, 0, 1, 'Unseen'),
	(5, 1, 8, NULL, NULL, 9, '2013-04-03 17:09:51', 'Whole Blood', NULL, NULL, NULL, NULL, 0, 0, 1, 'Unseen'),
	(6, 1, 7, NULL, NULL, 9, '2013-04-03 17:10:02', 'Whole Blood', NULL, NULL, NULL, NULL, 0, 0, 1, 'Unseen'),
	(7, 1, 1, NULL, NULL, 4, '2013-04-03 17:10:32', 'Whole Blood', NULL, NULL, NULL, NULL, 0, 0, 1, 'Processed'),
	(8, 1, 7, NULL, NULL, 4, '2013-04-03 17:10:37', 'Whole Blood', NULL, NULL, NULL, NULL, 0, 0, 1, 'Unseen'),
	(9, 1, 8, NULL, NULL, 4, '2013-04-03 17:10:44', 'Whole Blood', NULL, NULL, NULL, NULL, 0, 0, 1, 'Unseen'),
	(10, 1, 1, NULL, NULL, 5, '2013-04-03 17:11:27', 'Whole Blood', NULL, NULL, NULL, NULL, 0, 0, 1, 'Unseen'),
	(11, 1, 7, NULL, NULL, 5, '2013-04-03 17:11:35', 'Whole Blood', NULL, NULL, NULL, NULL, 0, 0, 1, 'Unseen'),
	(12, 1, 8, NULL, NULL, 5, '2013-04-03 17:11:42', 'Whole Blood', NULL, NULL, NULL, NULL, 0, 0, 1, 'Unseen'),
	(13, 1, 1, NULL, NULL, 4, '2013-04-03 17:40:08', 'Whole Blood', NULL, NULL, NULL, NULL, 0, 0, 1, 'Unseen'),
	(14, 1, 1, NULL, NULL, 4, '2013-04-04 23:15:44', 'Whole Blood', NULL, NULL, NULL, NULL, 0, 0, 1, 'Unseen'),
	(15, 1, 1, NULL, NULL, 4, '2013-04-14 20:54:30', 'Whole Blood', NULL, NULL, NULL, NULL, 0, 0, 1, 'Unseen'),
	(16, 1, 1, NULL, NULL, 4, '2013-04-14 21:00:05', 'Whole Blood', NULL, NULL, NULL, NULL, 0, 0, 1, 'Unseen'),
	(17, 1, 1, NULL, NULL, 4, '2013-04-14 21:26:13', 'Whole Blood', NULL, NULL, NULL, NULL, 0, 0, 1, 'Unseen'),
	(18, 1, 1, NULL, NULL, 4, '2013-04-14 21:47:23', 'Whole Blood', NULL, NULL, NULL, NULL, 0, 0, 1, 'Processed'),
	(19, 1, 1, 2, NULL, 4, '2013-04-19 20:56:18', 'Whole Blood', NULL, NULL, NULL, NULL, 0, 0, 1, 'Unseen'),
	(20, 1, 8, 2, NULL, 4, '2013-04-19 21:14:27', 'Whole Blood', NULL, NULL, NULL, NULL, 0, 0, 1, 'Denied'),
	(21, 1, 7, 2, NULL, 4, '2013-04-19 21:14:45', 'Whole Blood', NULL, NULL, NULL, NULL, 0, 0, 1, 'Unseen'),
	(22, 1, 1, 2, NULL, 4, '2013-04-19 23:58:56', 'Whole Blood', NULL, NULL, NULL, NULL, 0, 0, 1, 'Unseen'),
	(23, 1, 1, 2, NULL, 4, '2013-04-20 00:08:28', 'Whole Blood', NULL, NULL, NULL, NULL, 0, 0, 1, 'Denied');
/*!40000 ALTER TABLE `lab_request` ENABLE KEYS */;


-- Dumping structure for table mediquik_team_a.lab_request_details
DROP TABLE IF EXISTS `lab_request_details`;
CREATE TABLE IF NOT EXISTS `lab_request_details` (
  `id` int(11) NOT NULL,
  `lab_request_id` int(11) NOT NULL,
  `lab_test_id` int(11) NOT NULL,
  `comments` text,
  PRIMARY KEY (`id`),
  KEY `fk_lab_request_details__lab_request` (`lab_request_id`),
  KEY `fk_lab_request_details__lab_test` (`lab_test_id`),
  CONSTRAINT `fk_lab_request_details__lab_request` FOREIGN KEY (`lab_request_id`) REFERENCES `lab_request` (`id`),
  CONSTRAINT `fk_lab_request_details__lab_test` FOREIGN KEY (`lab_test_id`) REFERENCES `lab_test` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table mediquik_team_a.lab_request_details: ~136 rows (approximately)
DELETE FROM `lab_request_details`;
/*!40000 ALTER TABLE `lab_request_details` DISABLE KEYS */;
INSERT INTO `lab_request_details` (`id`, `lab_request_id`, `lab_test_id`, `comments`) VALUES
	(1, 1, 3, 'null'),
	(2, 1, 7, 'null'),
	(3, 1, 11, 'null'),
	(4, 1, 5, 'null'),
	(5, 1, 8, 'null'),
	(6, 2, 4, 'null'),
	(7, 2, 7, 'null'),
	(8, 2, 11, 'null'),
	(9, 2, 6, 'null'),
	(10, 2, 3, 'null'),
	(11, 3, 2, 'null'),
	(12, 3, 7, 'null'),
	(13, 3, 10, 'null'),
	(14, 4, 4, 'null'),
	(15, 4, 7, 'null'),
	(16, 4, 10, 'null'),
	(17, 4, 12, 'null'),
	(18, 5, 2, 'null'),
	(19, 5, 7, 'null'),
	(20, 5, 12, 'null'),
	(21, 5, 11, 'null'),
	(22, 5, 13, 'null'),
	(23, 5, 15, 'null'),
	(24, 5, 14, 'null'),
	(25, 6, 4, 'null'),
	(26, 6, 9, 'null'),
	(27, 6, 5, 'null'),
	(28, 6, 12, 'null'),
	(29, 6, 8, 'null'),
	(30, 6, 2, 'null'),
	(31, 7, 5, 'null'),
	(32, 7, 9, 'null'),
	(33, 7, 6, 'null'),
	(34, 7, 2, 'null'),
	(35, 9, 2, 'null'),
	(36, 9, 7, 'null'),
	(37, 9, 10, 'null'),
	(38, 10, 5, 'null'),
	(39, 10, 9, 'null'),
	(40, 11, 5, 'null'),
	(41, 11, 7, 'null'),
	(42, 11, 9, 'null'),
	(43, 12, 5, 'null'),
	(44, 12, 10, 'null'),
	(45, 12, 6, 'null'),
	(46, 12, 2, 'null'),
	(47, 13, 8, 'null'),
	(48, 13, 4, 'null'),
	(49, 13, 2, 'null'),
	(50, 14, 7, 'null'),
	(51, 14, 10, 'null'),
	(52, 14, 3, 'null'),
	(53, 14, 2, 'null'),
	(54, 14, 9, 'null'),
	(55, 14, 15, 'null'),
	(56, 14, 14, 'null'),
	(57, 16, 3, 'null'),
	(58, 16, 6, 'null'),
	(59, 16, 11, 'null'),
	(60, 16, 12, 'null'),
	(61, 17, 5, 'null'),
	(62, 17, 2, 'null'),
	(63, 17, 12, 'null'),
	(64, 17, 7, 'null'),
	(65, 17, 10, 'null'),
	(66, 18, 3, 'null'),
	(67, 18, 6, 'null'),
	(68, 18, 9, 'null'),
	(69, 18, 12, 'null'),
	(70, 18, 11, 'null'),
	(71, 18, 13, 'null'),
	(72, 18, 14, 'null'),
	(73, 18, 15, 'null'),
	(74, 18, 16, 'null'),
	(75, 18, 17, 'null'),
	(76, 18, 18, 'null'),
	(77, 18, 19, 'null'),
	(78, 18, 8, 'null'),
	(79, 18, 10, 'null'),
	(80, 18, 7, 'null'),
	(81, 18, 5, 'null'),
	(82, 18, 4, 'null'),
	(83, 18, 20, 'null'),
	(84, 18, 21, 'null'),
	(85, 18, 24, 'null'),
	(86, 18, 25, 'null'),
	(87, 18, 29, 'null'),
	(88, 18, 30, 'null'),
	(89, 18, 27, 'null'),
	(90, 18, 22, 'null'),
	(91, 18, 2, 'null'),
	(92, 18, 1, 'null'),
	(93, 18, 23, 'null'),
	(94, 18, 31, 'null'),
	(96, 18, 26, 'null'),
	(97, 18, 28, 'null'),
	(98, 19, 1, 'null'),
	(99, 19, 2, 'null'),
	(100, 19, 5, 'null'),
	(101, 19, 12, 'null'),
	(102, 19, 11, 'null'),
	(103, 20, 1, 'null'),
	(104, 20, 2, 'null'),
	(105, 20, 3, 'null'),
	(106, 20, 4, 'null'),
	(107, 20, 5, 'null'),
	(108, 20, 6, 'null'),
	(109, 20, 7, 'null'),
	(110, 20, 8, 'null'),
	(111, 20, 9, 'null'),
	(112, 20, 10, 'null'),
	(113, 20, 11, 'null'),
	(114, 20, 12, 'null'),
	(115, 20, 13, 'null'),
	(116, 20, 14, 'null'),
	(117, 20, 15, 'null'),
	(118, 20, 16, 'null'),
	(119, 20, 17, 'null'),
	(120, 20, 18, 'null'),
	(121, 20, 19, 'null'),
	(122, 20, 20, 'null'),
	(123, 21, 1, 'null'),
	(124, 21, 2, 'null'),
	(125, 21, 3, 'null'),
	(126, 21, 4, 'null'),
	(127, 21, 5, 'null'),
	(128, 21, 6, 'null'),
	(129, 21, 7, 'null'),
	(130, 21, 8, 'null'),
	(131, 21, 9, 'null'),
	(132, 21, 10, 'null'),
	(133, 22, 2, 'null'),
	(134, 22, 4, 'null'),
	(135, 22, 7, 'null'),
	(136, 23, 3, 'null'),
	(137, 23, 5, 'null');
/*!40000 ALTER TABLE `lab_request_details` ENABLE KEYS */;


-- Dumping structure for table mediquik_team_a.lab_result
DROP TABLE IF EXISTS `lab_result`;
CREATE TABLE IF NOT EXISTS `lab_result` (
  `id` int(11) NOT NULL,
  `lab_request_id` int(11) NOT NULL,
  `processed_by_technician_id` int(11) NOT NULL,
  `completion_status` enum('PROCESSED','REJECTED','OTHER') NOT NULL,
  `completion_status_details` text,
  `completion_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_lab_result__lab_request` (`lab_request_id`),
  KEY `fk_lab_result__lab_technician` (`processed_by_technician_id`),
  CONSTRAINT `fk_lab_result__lab_request` FOREIGN KEY (`lab_request_id`) REFERENCES `lab_request` (`id`),
  CONSTRAINT `fk_lab_result__lab_technician` FOREIGN KEY (`processed_by_technician_id`) REFERENCES `lab_technician` (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table mediquik_team_a.lab_result: ~5 rows (approximately)
DELETE FROM `lab_result`;
/*!40000 ALTER TABLE `lab_result` DISABLE KEYS */;
INSERT INTO `lab_result` (`id`, `lab_request_id`, `processed_by_technician_id`, `completion_status`, `completion_status_details`, `completion_date`) VALUES
	(1, 1, 10, 'PROCESSED', NULL, '2013-04-15 21:59:29'),
	(2, 18, 10, 'PROCESSED', NULL, '2013-04-15 22:00:09'),
	(3, 2, 10, 'PROCESSED', NULL, '2013-04-16 22:29:32'),
	(5, 3, 10, 'PROCESSED', NULL, '2013-04-16 23:08:10'),
	(6, 7, 10, 'PROCESSED', NULL, '2013-04-20 16:00:09');
/*!40000 ALTER TABLE `lab_result` ENABLE KEYS */;


-- Dumping structure for table mediquik_team_a.lab_result_details
DROP TABLE IF EXISTS `lab_result_details`;
CREATE TABLE IF NOT EXISTS `lab_result_details` (
  `id` int(11) NOT NULL,
  `lab_result_id` int(11) NOT NULL,
  `lab_test_id` int(11) NOT NULL,
  `result` text NOT NULL,
  `details` text,
  PRIMARY KEY (`id`),
  KEY `fk_lab_result_details__lab_result` (`lab_result_id`),
  KEY `fk_lab_result_details__lab_test` (`lab_test_id`),
  CONSTRAINT `fk_lab_result_details__lab_result` FOREIGN KEY (`lab_result_id`) REFERENCES `lab_result` (`id`),
  CONSTRAINT `fk_lab_result_details__lab_test` FOREIGN KEY (`lab_test_id`) REFERENCES `lab_test` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table mediquik_team_a.lab_result_details: ~48 rows (approximately)
DELETE FROM `lab_result_details`;
/*!40000 ALTER TABLE `lab_result_details` DISABLE KEYS */;
INSERT INTO `lab_result_details` (`id`, `lab_result_id`, `lab_test_id`, `result`, `details`) VALUES
	(1, 1, 3, 'OK', NULL),
	(2, 1, 7, 'False', NULL),
	(3, 1, 11, '25', NULL),
	(4, 1, 5, '31', NULL),
	(5, 1, 8, 'NotOK', NULL),
	(6, 2, 3, '1', NULL),
	(7, 2, 6, '2', NULL),
	(8, 2, 9, '3', NULL),
	(9, 2, 12, '4', NULL),
	(10, 2, 11, '5', NULL),
	(11, 2, 13, '6', NULL),
	(12, 2, 14, '7', NULL),
	(13, 2, 15, '8', NULL),
	(14, 2, 16, '9', NULL),
	(15, 2, 17, '10', NULL),
	(16, 2, 18, '11', NULL),
	(17, 2, 19, '12', NULL),
	(18, 2, 8, '13', NULL),
	(19, 2, 10, '14', NULL),
	(20, 2, 7, '15', NULL),
	(21, 2, 5, '16', NULL),
	(22, 2, 4, '17', NULL),
	(23, 2, 20, '18', NULL),
	(24, 2, 21, '19', NULL),
	(25, 2, 24, '20', NULL),
	(26, 2, 25, '21', NULL),
	(27, 2, 29, '22', NULL),
	(28, 2, 30, '23', NULL),
	(29, 2, 27, '24', NULL),
	(30, 2, 22, '25', NULL),
	(31, 2, 2, '26', NULL),
	(32, 2, 1, '27', NULL),
	(33, 2, 23, '28', NULL),
	(34, 2, 31, '29', NULL),
	(35, 2, 26, '30', NULL),
	(36, 2, 28, '31', NULL),
	(37, 3, 4, 'Go', NULL),
	(38, 3, 7, '45', NULL),
	(39, 3, 11, '223', NULL),
	(40, 3, 6, '100', NULL),
	(41, 3, 3, 'FullFilled', NULL),
	(42, 5, 2, '12', NULL),
	(43, 5, 7, '23', NULL),
	(44, 5, 10, '34', NULL),
	(45, 6, 5, '0', NULL),
	(46, 6, 9, '0', NULL),
	(47, 6, 6, '0', NULL),
	(48, 6, 2, '0', NULL);
/*!40000 ALTER TABLE `lab_result_details` ENABLE KEYS */;


-- Dumping structure for table mediquik_team_a.lab_technician
DROP TABLE IF EXISTS `lab_technician`;
CREATE TABLE IF NOT EXISTS `lab_technician` (
  `person_id` int(11) NOT NULL,
  `hourly_rate` decimal(5,2) unsigned DEFAULT NULL,
  PRIMARY KEY (`person_id`),
  CONSTRAINT `fk_lab_technician__person` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table mediquik_team_a.lab_technician: ~1 rows (approximately)
DELETE FROM `lab_technician`;
/*!40000 ALTER TABLE `lab_technician` DISABLE KEYS */;
INSERT INTO `lab_technician` (`person_id`, `hourly_rate`) VALUES
	(10, 43.00);
/*!40000 ALTER TABLE `lab_technician` ENABLE KEYS */;


-- Dumping structure for table mediquik_team_a.lab_technician_laboratory
DROP TABLE IF EXISTS `lab_technician_laboratory`;
CREATE TABLE IF NOT EXISTS `lab_technician_laboratory` (
  `id` int(11) NOT NULL,
  `person_id` int(11) NOT NULL,
  `laboratory_id` int(11) NOT NULL,
  `hire_date` date DEFAULT NULL,
  `termination_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_lab_technician_laboratory__person` (`person_id`),
  KEY `fk_lab_technician_laboratory__laboratory` (`laboratory_id`),
  CONSTRAINT `fk_lab_technician_laboratory__laboratory` FOREIGN KEY (`laboratory_id`) REFERENCES `laboratory` (`id`),
  CONSTRAINT `fk_lab_technician_laboratory__person` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table mediquik_team_a.lab_technician_laboratory: ~1 rows (approximately)
DELETE FROM `lab_technician_laboratory`;
/*!40000 ALTER TABLE `lab_technician_laboratory` DISABLE KEYS */;
INSERT INTO `lab_technician_laboratory` (`id`, `person_id`, `laboratory_id`, `hire_date`, `termination_date`) VALUES
	(1, 10, 1, NULL, NULL);
/*!40000 ALTER TABLE `lab_technician_laboratory` ENABLE KEYS */;


-- Dumping structure for table mediquik_team_a.lab_test
DROP TABLE IF EXISTS `lab_test`;
CREATE TABLE IF NOT EXISTS `lab_test` (
  `id` int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  `abbreviation` varchar(50) NOT NULL,
  `reflexive_testing_description` text,
  `panels_description` text,
  `special_collection_requirements` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_lab_test__name` (`name`),
  UNIQUE KEY `uq_lab_test__abbreviation` (`abbreviation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table mediquik_team_a.lab_test: ~31 rows (approximately)
DELETE FROM `lab_test`;
/*!40000 ALTER TABLE `lab_test` DISABLE KEYS */;
INSERT INTO `lab_test` (`id`, `name`, `abbreviation`, `reflexive_testing_description`, `panels_description`, `special_collection_requirements`) VALUES
	(1, 'ACID PHOSPHATASE', 'ACID', NULL, NULL, NULL),
	(2, 'ACTH', 'ACTH', NULL, NULL, NULL),
	(3, 'ACTIVATED PROTEIN C RESISTANCE', 'APCR', NULL, NULL, NULL),
	(4, 'ALBUMIN (MICRO), URINE', 'UMALB', NULL, NULL, NULL),
	(5, 'ALDOLASE', 'ALASE', NULL, NULL, NULL),
	(6, 'ALPHA-1-ANTITRYPSIN', 'A1AT', NULL, NULL, NULL),
	(7, 'ALHPA FETOPROTEIN TUMOR', 'AFPNOT', NULL, NULL, NULL),
	(8, 'ALPHA FETOPROTEIN AMNIOTIC', 'AAFPX', NULL, NULL, NULL),
	(9, 'BETA-2-MICROGLOBULIN', 'BETA2, CBETA2', NULL, NULL, NULL),
	(10, 'FOLATE', 'FOLAT', NULL, NULL, NULL),
	(11, 'PROLACTIN', 'PRL', NULL, NULL, NULL),
	(12, 'ZINC', 'ZN, UZN', NULL, NULL, NULL),
	(13, 'THYROID TESTING - T3', 'T3', NULL, NULL, NULL),
	(14, 'THYROID TESTING - T4', 'T4', NULL, NULL, NULL),
	(15, 'THYROID TESTING - TSH', 'TSH', NULL, NULL, NULL),
	(16, 'CALCIUM, IONIZED', 'SRICG, PLIC', NULL, NULL, NULL),
	(17, 'CALCIUM, URIN', 'UCA', NULL, NULL, NULL),
	(18, 'CAROTENE', 'CAR', NULL, NULL, NULL),
	(19, 'IMMUNE COMPLEXES', 'IMCG', NULL, NULL, NULL),
	(20, 'LEAD', 'PB', NULL, NULL, NULL),
	(21, 'ASPARATE AMINOTRANSFERASE', 'AST', NULL, NULL, NULL),
	(22, 'MEAN CORPUSCULAR HEMOGLOBIN', 'MCH', NULL, NULL, NULL),
	(23, 'PROSTATE SPECIFIC ANTIGEN (PROSTATE CANCER TEST)', 'PSA', NULL, NULL, NULL),
	(24, 'BLOOD UREA NITROGEN', 'BUN', NULL, NULL, NULL),
	(25, 'BLOOD ALCOHOL CONCENTRATION', 'BAC', NULL, NULL, NULL),
	(26, 'COMPLETE BLOOD COUNT', 'CBC', NULL, NULL, NULL),
	(27, 'BASIC METABOLIC PANEL', 'BMP', NULL, NULL, NULL),
	(28, 'CREATINE KINASE', 'CK', NULL, NULL, NULL),
	(29, 'LIPOPROTEIN PANEL - GOOD CHOLESTEROL', 'HDL', NULL, NULL, NULL),
	(30, 'LIPOPROTEIN PANEL - BAD CHOLESTEROL', 'LDL', NULL, NULL, NULL),
	(31, 'C-REACTIVE PROTEIN TEST', 'CRP', NULL, NULL, NULL);
/*!40000 ALTER TABLE `lab_test` ENABLE KEYS */;


-- Dumping structure for table mediquik_team_a.medical_license
DROP TABLE IF EXISTS `medical_license`;
CREATE TABLE IF NOT EXISTS `medical_license` (
  `id` int(11) NOT NULL,
  `person_id` int(11) NOT NULL,
  `state_code` char(2) NOT NULL COMMENT 'USPS 2 letter state abbreviatiin- could change to ENUM',
  `type` enum('MD','PA') NOT NULL COMMENT 'MD:=Permanent Medical License, PA:=Physicians Assistant',
  `issue_date` date NOT NULL,
  `expiration_date` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_medical_license__physician` (`person_id`),
  CONSTRAINT `fk_medical_license__physician` FOREIGN KEY (`person_id`) REFERENCES `physician` (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table mediquik_team_a.medical_license: ~0 rows (approximately)
DELETE FROM `medical_license`;
/*!40000 ALTER TABLE `medical_license` DISABLE KEYS */;
/*!40000 ALTER TABLE `medical_license` ENABLE KEYS */;


-- Dumping structure for table mediquik_team_a.medical_practice
DROP TABLE IF EXISTS `medical_practice`;
CREATE TABLE IF NOT EXISTS `medical_practice` (
  `id` int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  `phone_number` char(10) NOT NULL,
  `street1` varchar(200) NOT NULL,
  `street2` varchar(200) DEFAULT NULL,
  `city` varchar(200) NOT NULL,
  `state_code` char(2) NOT NULL COMMENT 'USPS 2 letter state abbreviatiin- could change to ENUM',
  `zipcode` int(5) unsigned NOT NULL,
  `zipcodeperson_plus4` int(4) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table mediquik_team_a.medical_practice: ~1 rows (approximately)
DELETE FROM `medical_practice`;
/*!40000 ALTER TABLE `medical_practice` DISABLE KEYS */;
INSERT INTO `medical_practice` (`id`, `name`, `phone_number`, `street1`, `street2`, `city`, `state_code`, `zipcode`, `zipcodeperson_plus4`) VALUES
	(1, 'Dr Ding\'s Office', '2528641621', 'E 5th St', 'Ash St', 'Greenville', 'NC', 27858, NULL);
/*!40000 ALTER TABLE `medical_practice` ENABLE KEYS */;


-- Dumping structure for table mediquik_team_a.nurse
DROP TABLE IF EXISTS `nurse`;
CREATE TABLE IF NOT EXISTS `nurse` (
  `person_id` int(11) NOT NULL,
  `hourly_rate` decimal(10,2) unsigned DEFAULT NULL,
  PRIMARY KEY (`person_id`),
  CONSTRAINT `fk_nurse__person` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table mediquik_team_a.nurse: ~1 rows (approximately)
DELETE FROM `nurse`;
/*!40000 ALTER TABLE `nurse` DISABLE KEYS */;
INSERT INTO `nurse` (`person_id`, `hourly_rate`) VALUES
	(2, 500.00);
/*!40000 ALTER TABLE `nurse` ENABLE KEYS */;


-- Dumping structure for table mediquik_team_a.nursing_license
DROP TABLE IF EXISTS `nursing_license`;
CREATE TABLE IF NOT EXISTS `nursing_license` (
  `id` int(11) NOT NULL,
  `person_id` int(11) NOT NULL,
  `state_code` char(2) NOT NULL COMMENT 'USPS 2 letter state abbreviatiin- could change to ENUM',
  `type` enum('LPN','RN','NP') NOT NULL COMMENT 'LPN:=Licensed Practical Nurse, RN:=Registered Nurse, NP:=Nurse Practitioner',
  `issue_date` date NOT NULL,
  `expiration_date` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_nursing_license__nurse` (`person_id`),
  CONSTRAINT `fk_nursing_license__nurse` FOREIGN KEY (`person_id`) REFERENCES `nurse` (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table mediquik_team_a.nursing_license: ~0 rows (approximately)
DELETE FROM `nursing_license`;
/*!40000 ALTER TABLE `nursing_license` DISABLE KEYS */;
/*!40000 ALTER TABLE `nursing_license` ENABLE KEYS */;


-- Dumping structure for table mediquik_team_a.patient
DROP TABLE IF EXISTS `patient`;
CREATE TABLE IF NOT EXISTS `patient` (
  `person_id` int(11) NOT NULL,
  `last_visit` date DEFAULT NULL,
  `next_scheduled_visit` date DEFAULT NULL,
  `height_in_inches` decimal(5,2) unsigned DEFAULT NULL,
  `weight_in_pounds` smallint(4) unsigned DEFAULT NULL,
  `tobacco_status` enum('SMOKER','NONSMOKER','UNKNOWN') NOT NULL DEFAULT 'UNKNOWN',
  PRIMARY KEY (`person_id`),
  CONSTRAINT `fk_patient__person` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table mediquik_team_a.patient: ~3 rows (approximately)
DELETE FROM `patient`;
/*!40000 ALTER TABLE `patient` DISABLE KEYS */;
INSERT INTO `patient` (`person_id`, `last_visit`, `next_scheduled_visit`, `height_in_inches`, `weight_in_pounds`, `tobacco_status`) VALUES
	(1, NULL, NULL, NULL, NULL, 'UNKNOWN'),
	(7, NULL, NULL, NULL, NULL, 'UNKNOWN'),
	(8, NULL, NULL, NULL, NULL, 'UNKNOWN');
/*!40000 ALTER TABLE `patient` ENABLE KEYS */;


-- Dumping structure for table mediquik_team_a.patient_physician_appointment
DROP TABLE IF EXISTS `patient_physician_appointment`;
CREATE TABLE IF NOT EXISTS `patient_physician_appointment` (
  `id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `physician_id` int(11) NOT NULL,
  `date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_person` (`patient_id`),
  KEY `fk_physician` (`physician_id`),
  CONSTRAINT `fk_person` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`person_id`),
  CONSTRAINT `fk_physician` FOREIGN KEY (`physician_id`) REFERENCES `physician` (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table mediquik_team_a.patient_physician_appointment: ~8 rows (approximately)
DELETE FROM `patient_physician_appointment`;
/*!40000 ALTER TABLE `patient_physician_appointment` DISABLE KEYS */;
INSERT INTO `patient_physician_appointment` (`id`, `patient_id`, `physician_id`, `date`) VALUES
	(27, 1, 5, NULL),
	(29, 1, 5, NULL),
	(30, 1, 9, NULL),
	(40, 1, 5, NULL),
	(42, 7, 5, NULL),
	(43, 7, 9, NULL),
	(45, 8, 5, NULL),
	(46, 8, 9, NULL);
/*!40000 ALTER TABLE `patient_physician_appointment` ENABLE KEYS */;


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
	(12, 'EDIT_PATIENT_DEMOGRAPHICS', 'Edit patient demographics'),
	(13, 'ORDER_TESTS', 'Can order tests'),
	(14, 'REQUEST_TESTS', 'Can request a test which requires physician approval'),
	(15, 'APPROVE_TEST_REQUEST', 'Can approve/deny a test request');
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


-- Dumping structure for table mediquik_team_a.person_role
DROP TABLE IF EXISTS `person_role`;
CREATE TABLE IF NOT EXISTS `person_role` (
  `id` int(11) NOT NULL,
  `person_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_person_role__person` (`person_id`),
  KEY `fk_person_role__role` (`role_id`),
  CONSTRAINT `fk_person_role__person` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`),
  CONSTRAINT `fk_person_role__role` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table mediquik_team_a.person_role: ~10 rows (approximately)
DELETE FROM `person_role`;
/*!40000 ALTER TABLE `person_role` DISABLE KEYS */;
INSERT INTO `person_role` (`id`, `person_id`, `role_id`) VALUES
	(1, 1, 1),
	(2, 4, 4),
	(3, 10, 3),
	(4, 2, 2),
	(9, 7, 1),
	(10, 8, 1),
	(11, 9, 4),
	(12, 5, 4),
	(13, 3, 5),
	(14, 11, 4);
/*!40000 ALTER TABLE `person_role` ENABLE KEYS */;


-- Dumping structure for table mediquik_team_a.physician
DROP TABLE IF EXISTS `physician`;
CREATE TABLE IF NOT EXISTS `physician` (
  `person_id` int(11) NOT NULL,
  `yearly_salary` decimal(10,2) unsigned DEFAULT NULL,
  PRIMARY KEY (`person_id`),
  CONSTRAINT `fk_physician__person` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table mediquik_team_a.physician: ~4 rows (approximately)
DELETE FROM `physician`;
/*!40000 ALTER TABLE `physician` DISABLE KEYS */;
INSERT INTO `physician` (`person_id`, `yearly_salary`) VALUES
	(4, 500.00),
	(5, 1000.00),
	(9, 1500.00),
	(11, 100000.00);
/*!40000 ALTER TABLE `physician` ENABLE KEYS */;


-- Dumping structure for table mediquik_team_a.physician_nurse_medical_practice
DROP TABLE IF EXISTS `physician_nurse_medical_practice`;
CREATE TABLE IF NOT EXISTS `physician_nurse_medical_practice` (
  `id` int(11) NOT NULL,
  `person_id` int(11) NOT NULL,
  `medical_practice_id` int(11) NOT NULL,
  `hire_date` date DEFAULT NULL,
  `termination_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_physician_nurse_practice__person` (`person_id`),
  KEY `fk_physician_nurse_medical_practice__medical_practice` (`medical_practice_id`),
  CONSTRAINT `fk_physician_nurse_medical_practice__medical_practice` FOREIGN KEY (`medical_practice_id`) REFERENCES `medical_practice` (`id`),
  CONSTRAINT `fk_physician_nurse_practice__person` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table mediquik_team_a.physician_nurse_medical_practice: ~2 rows (approximately)
DELETE FROM `physician_nurse_medical_practice`;
/*!40000 ALTER TABLE `physician_nurse_medical_practice` DISABLE KEYS */;
INSERT INTO `physician_nurse_medical_practice` (`id`, `person_id`, `medical_practice_id`, `hire_date`, `termination_date`) VALUES
	(1, 4, 1, NULL, NULL),
	(2, 2, 1, NULL, NULL);
/*!40000 ALTER TABLE `physician_nurse_medical_practice` ENABLE KEYS */;


-- Dumping structure for table mediquik_team_a.role
DROP TABLE IF EXISTS `role`;
CREATE TABLE IF NOT EXISTS `role` (
  `id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table mediquik_team_a.role: ~5 rows (approximately)
DELETE FROM `role`;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` (`id`, `name`) VALUES
	(1, 'PATIENT'),
	(2, 'NURSE'),
	(3, 'TECHNICIAN'),
	(4, 'PHYSICIAN'),
	(5, 'ADMIN');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;


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
	(20, 2, 14),
	(9, 3, 7),
	(3, 3, 9),
	(13, 3, 10),
	(6, 4, 5),
	(4, 4, 9),
	(14, 4, 11),
	(18, 4, 12),
	(21, 4, 13),
	(22, 4, 15),
	(5, 5, 3),
	(7, 5, 9),
	(15, 5, 11),
	(19, 5, 12);
/*!40000 ALTER TABLE `role_permission` ENABLE KEYS */;
/*!40014 SET FOREIGN_KEY_CHECKS=1 */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
