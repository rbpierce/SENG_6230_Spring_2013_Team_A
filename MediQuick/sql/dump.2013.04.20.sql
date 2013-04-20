CREATE DATABASE  IF NOT EXISTS `mediquik_team_a` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `mediquik_team_a`;

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
DROP TABLE IF EXISTS general_message;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE general_message (
  id int(11) NOT NULL,
  person_id int(11) NOT NULL,
  `text` varchar(200) DEFAULT NULL,
  `status` varchar(10) DEFAULT NULL,
  PRIMARY KEY (id)
);
/*!40101 SET character_set_client = @saved_cs_client */;

INSERT INTO general_message (id, person_id, text, status) VALUES (1,1,'Your appointment request with Dr. Junhua Ding was APPROVED by the nurse Jane Smitha, and is waiting for approval.','SEEN');
INSERT INTO general_message (id, person_id, text, status) VALUES (2,1,'Your Test request with Dr. Junhua Ding was APPROVED, and is waiting for the results.','SEEN');
INSERT INTO general_message (id, person_id, text, status) VALUES (3,1,'Your appointment request with Dr. Junhua Ding was APPROVED by the nurse Jane Smitha, and is waiting for approval.','SEEN');
INSERT INTO general_message (id, person_id, text, status) VALUES (4,1,'Your Test request with Dr. Junhua Ding was DENIED (REQUEST_ID=23). You have to make another appointment to have another test request.','SEEN');
INSERT INTO general_message (id, person_id, text, status) VALUES (5,1,'Your appointment request with Dr. Junhua Ding was DENIED by the nurse Jane Smitha. You can try again making an appointment later.','SEEN');
DROP TABLE IF EXISTS icd9_code;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE icd9_code (
  id int(11) NOT NULL,
  `code` char(5) NOT NULL,
  description text NOT NULL,
  PRIMARY KEY (id),
  KEY icd9_code__code (`code`)
);
/*!40101 SET character_set_client = @saved_cs_client */;

INSERT INTO icd9_code (id, code, description) VALUES (1,'CODE','This is a test data');
DROP TABLE IF EXISTS lab_request;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE lab_request (
  id int(11) NOT NULL,
  laboratory_id int(11) NOT NULL,
  patient_id int(11) NOT NULL,
  requesting_nurse_id int(11) DEFAULT NULL,
  nurse_request_time datetime DEFAULT NULL,
  ordering_physician_id int(11) NOT NULL,
  order_placed datetime NOT NULL,
  specimen_type enum('Serum','Plasma','Urine','CSF','Whole Blood','Stool','Amniotic','Other') NOT NULL,
  specimen_collection_time datetime DEFAULT NULL,
  specimen_number varchar(200) DEFAULT NULL,
  urine_collection_start datetime DEFAULT NULL,
  urine_collection_finish datetime DEFAULT NULL,
  urine_interval_in_minutes int(5) unsigned DEFAULT NULL,
  urine_volume_in_milliliters int(5) unsigned DEFAULT NULL,
  icd9_code_id int(11) NOT NULL,
  `status` varchar(20) DEFAULT NULL,
  PRIMARY KEY (id),
  KEY fk_lab_request__laboratory (laboratory_id),
  KEY fk_lab_request__patient (patient_id),
  KEY fk_lab_request__nurse (requesting_nurse_id),
  KEY fk_lab_request__physician (ordering_physician_id),
  KEY fk_lab_request__icd9_code (icd9_code_id),
  CONSTRAINT fk_lab_request__icd9_code FOREIGN KEY (icd9_code_id) REFERENCES icd9_code (id),
  CONSTRAINT fk_lab_request__laboratory FOREIGN KEY (laboratory_id) REFERENCES laboratory (id),
  CONSTRAINT fk_lab_request__nurse FOREIGN KEY (requesting_nurse_id) REFERENCES nurse (person_id),
  CONSTRAINT fk_lab_request__patient FOREIGN KEY (patient_id) REFERENCES patient (person_id),
  CONSTRAINT fk_lab_request__physician FOREIGN KEY (ordering_physician_id) REFERENCES physician (person_id)
);
/*!40101 SET character_set_client = @saved_cs_client */;

INSERT INTO lab_request (id, laboratory_id, patient_id, requesting_nurse_id, nurse_request_time, ordering_physician_id, order_placed, specimen_type, specimen_collection_time, specimen_number, urine_collection_start, urine_collection_finish, urine_interval_in_minutes, urine_volume_in_milliliters, icd9_code_id, status) VALUES (1,1,1,NULL,NULL,4,'2013-04-02 11:11:59','Whole Blood',NULL,NULL,NULL,NULL,0,0,1,'Processed');
INSERT INTO lab_request (id, laboratory_id, patient_id, requesting_nurse_id, nurse_request_time, ordering_physician_id, order_placed, specimen_type, specimen_collection_time, specimen_number, urine_collection_start, urine_collection_finish, urine_interval_in_minutes, urine_volume_in_milliliters, icd9_code_id, status) VALUES (2,1,1,NULL,NULL,4,'2013-04-03 01:11:04','Whole Blood',NULL,NULL,NULL,NULL,0,0,1,'Processed');
INSERT INTO lab_request (id, laboratory_id, patient_id, requesting_nurse_id, nurse_request_time, ordering_physician_id, order_placed, specimen_type, specimen_collection_time, specimen_number, urine_collection_start, urine_collection_finish, urine_interval_in_minutes, urine_volume_in_milliliters, icd9_code_id, status) VALUES (3,1,1,NULL,NULL,4,'2013-04-03 01:18:19','Whole Blood',NULL,NULL,NULL,NULL,0,0,1,'Processed');
INSERT INTO lab_request (id, laboratory_id, patient_id, requesting_nurse_id, nurse_request_time, ordering_physician_id, order_placed, specimen_type, specimen_collection_time, specimen_number, urine_collection_start, urine_collection_finish, urine_interval_in_minutes, urine_volume_in_milliliters, icd9_code_id, status) VALUES (4,1,1,NULL,NULL,9,'2013-04-03 17:09:40','Whole Blood',NULL,NULL,NULL,NULL,0,0,1,'Unseen');
INSERT INTO lab_request (id, laboratory_id, patient_id, requesting_nurse_id, nurse_request_time, ordering_physician_id, order_placed, specimen_type, specimen_collection_time, specimen_number, urine_collection_start, urine_collection_finish, urine_interval_in_minutes, urine_volume_in_milliliters, icd9_code_id, status) VALUES (5,1,8,NULL,NULL,9,'2013-04-03 17:09:51','Whole Blood',NULL,NULL,NULL,NULL,0,0,1,'Unseen');
INSERT INTO lab_request (id, laboratory_id, patient_id, requesting_nurse_id, nurse_request_time, ordering_physician_id, order_placed, specimen_type, specimen_collection_time, specimen_number, urine_collection_start, urine_collection_finish, urine_interval_in_minutes, urine_volume_in_milliliters, icd9_code_id, status) VALUES (6,1,7,NULL,NULL,9,'2013-04-03 17:10:02','Whole Blood',NULL,NULL,NULL,NULL,0,0,1,'Unseen');
INSERT INTO lab_request (id, laboratory_id, patient_id, requesting_nurse_id, nurse_request_time, ordering_physician_id, order_placed, specimen_type, specimen_collection_time, specimen_number, urine_collection_start, urine_collection_finish, urine_interval_in_minutes, urine_volume_in_milliliters, icd9_code_id, status) VALUES (7,1,1,NULL,NULL,4,'2013-04-03 17:10:32','Whole Blood',NULL,NULL,NULL,NULL,0,0,1,'Unseen');
INSERT INTO lab_request (id, laboratory_id, patient_id, requesting_nurse_id, nurse_request_time, ordering_physician_id, order_placed, specimen_type, specimen_collection_time, specimen_number, urine_collection_start, urine_collection_finish, urine_interval_in_minutes, urine_volume_in_milliliters, icd9_code_id, status) VALUES (8,1,7,NULL,NULL,4,'2013-04-03 17:10:37','Whole Blood',NULL,NULL,NULL,NULL,0,0,1,'Unseen');
INSERT INTO lab_request (id, laboratory_id, patient_id, requesting_nurse_id, nurse_request_time, ordering_physician_id, order_placed, specimen_type, specimen_collection_time, specimen_number, urine_collection_start, urine_collection_finish, urine_interval_in_minutes, urine_volume_in_milliliters, icd9_code_id, status) VALUES (9,1,8,NULL,NULL,4,'2013-04-03 17:10:44','Whole Blood',NULL,NULL,NULL,NULL,0,0,1,'Unseen');
INSERT INTO lab_request (id, laboratory_id, patient_id, requesting_nurse_id, nurse_request_time, ordering_physician_id, order_placed, specimen_type, specimen_collection_time, specimen_number, urine_collection_start, urine_collection_finish, urine_interval_in_minutes, urine_volume_in_milliliters, icd9_code_id, status) VALUES (10,1,1,NULL,NULL,5,'2013-04-03 17:11:27','Whole Blood',NULL,NULL,NULL,NULL,0,0,1,'Unseen');
INSERT INTO lab_request (id, laboratory_id, patient_id, requesting_nurse_id, nurse_request_time, ordering_physician_id, order_placed, specimen_type, specimen_collection_time, specimen_number, urine_collection_start, urine_collection_finish, urine_interval_in_minutes, urine_volume_in_milliliters, icd9_code_id, status) VALUES (11,1,7,NULL,NULL,5,'2013-04-03 17:11:35','Whole Blood',NULL,NULL,NULL,NULL,0,0,1,'Unseen');
INSERT INTO lab_request (id, laboratory_id, patient_id, requesting_nurse_id, nurse_request_time, ordering_physician_id, order_placed, specimen_type, specimen_collection_time, specimen_number, urine_collection_start, urine_collection_finish, urine_interval_in_minutes, urine_volume_in_milliliters, icd9_code_id, status) VALUES (12,1,8,NULL,NULL,5,'2013-04-03 17:11:42','Whole Blood',NULL,NULL,NULL,NULL,0,0,1,'Unseen');
INSERT INTO lab_request (id, laboratory_id, patient_id, requesting_nurse_id, nurse_request_time, ordering_physician_id, order_placed, specimen_type, specimen_collection_time, specimen_number, urine_collection_start, urine_collection_finish, urine_interval_in_minutes, urine_volume_in_milliliters, icd9_code_id, status) VALUES (13,1,1,NULL,NULL,4,'2013-04-03 17:40:08','Whole Blood',NULL,NULL,NULL,NULL,0,0,1,'Unseen');
INSERT INTO lab_request (id, laboratory_id, patient_id, requesting_nurse_id, nurse_request_time, ordering_physician_id, order_placed, specimen_type, specimen_collection_time, specimen_number, urine_collection_start, urine_collection_finish, urine_interval_in_minutes, urine_volume_in_milliliters, icd9_code_id, status) VALUES (14,1,1,NULL,NULL,4,'2013-04-04 23:15:44','Whole Blood',NULL,NULL,NULL,NULL,0,0,1,'Unseen');
INSERT INTO lab_request (id, laboratory_id, patient_id, requesting_nurse_id, nurse_request_time, ordering_physician_id, order_placed, specimen_type, specimen_collection_time, specimen_number, urine_collection_start, urine_collection_finish, urine_interval_in_minutes, urine_volume_in_milliliters, icd9_code_id, status) VALUES (15,1,1,NULL,NULL,4,'2013-04-14 20:54:30','Whole Blood',NULL,NULL,NULL,NULL,0,0,1,'Unseen');
INSERT INTO lab_request (id, laboratory_id, patient_id, requesting_nurse_id, nurse_request_time, ordering_physician_id, order_placed, specimen_type, specimen_collection_time, specimen_number, urine_collection_start, urine_collection_finish, urine_interval_in_minutes, urine_volume_in_milliliters, icd9_code_id, status) VALUES (16,1,1,NULL,NULL,4,'2013-04-14 21:00:05','Whole Blood',NULL,NULL,NULL,NULL,0,0,1,'Unseen');
INSERT INTO lab_request (id, laboratory_id, patient_id, requesting_nurse_id, nurse_request_time, ordering_physician_id, order_placed, specimen_type, specimen_collection_time, specimen_number, urine_collection_start, urine_collection_finish, urine_interval_in_minutes, urine_volume_in_milliliters, icd9_code_id, status) VALUES (17,1,1,NULL,NULL,4,'2013-04-14 21:26:13','Whole Blood',NULL,NULL,NULL,NULL,0,0,1,'Unseen');
INSERT INTO lab_request (id, laboratory_id, patient_id, requesting_nurse_id, nurse_request_time, ordering_physician_id, order_placed, specimen_type, specimen_collection_time, specimen_number, urine_collection_start, urine_collection_finish, urine_interval_in_minutes, urine_volume_in_milliliters, icd9_code_id, status) VALUES (18,1,1,NULL,NULL,4,'2013-04-14 21:47:23','Whole Blood',NULL,NULL,NULL,NULL,0,0,1,'Processed');
INSERT INTO lab_request (id, laboratory_id, patient_id, requesting_nurse_id, nurse_request_time, ordering_physician_id, order_placed, specimen_type, specimen_collection_time, specimen_number, urine_collection_start, urine_collection_finish, urine_interval_in_minutes, urine_volume_in_milliliters, icd9_code_id, status) VALUES (19,1,1,2,NULL,4,'2013-04-19 20:56:18','Whole Blood',NULL,NULL,NULL,NULL,0,0,1,'Unseen');
INSERT INTO lab_request (id, laboratory_id, patient_id, requesting_nurse_id, nurse_request_time, ordering_physician_id, order_placed, specimen_type, specimen_collection_time, specimen_number, urine_collection_start, urine_collection_finish, urine_interval_in_minutes, urine_volume_in_milliliters, icd9_code_id, status) VALUES (20,1,8,2,NULL,4,'2013-04-19 21:14:27','Whole Blood',NULL,NULL,NULL,NULL,0,0,1,'Denied');
INSERT INTO lab_request (id, laboratory_id, patient_id, requesting_nurse_id, nurse_request_time, ordering_physician_id, order_placed, specimen_type, specimen_collection_time, specimen_number, urine_collection_start, urine_collection_finish, urine_interval_in_minutes, urine_volume_in_milliliters, icd9_code_id, status) VALUES (21,1,7,2,NULL,4,'2013-04-19 21:14:45','Whole Blood',NULL,NULL,NULL,NULL,0,0,1,'Unseen');
INSERT INTO lab_request (id, laboratory_id, patient_id, requesting_nurse_id, nurse_request_time, ordering_physician_id, order_placed, specimen_type, specimen_collection_time, specimen_number, urine_collection_start, urine_collection_finish, urine_interval_in_minutes, urine_volume_in_milliliters, icd9_code_id, status) VALUES (22,1,1,2,NULL,4,'2013-04-19 23:58:56','Whole Blood',NULL,NULL,NULL,NULL,0,0,1,'Unseen');
INSERT INTO lab_request (id, laboratory_id, patient_id, requesting_nurse_id, nurse_request_time, ordering_physician_id, order_placed, specimen_type, specimen_collection_time, specimen_number, urine_collection_start, urine_collection_finish, urine_interval_in_minutes, urine_volume_in_milliliters, icd9_code_id, status) VALUES (23,1,1,2,NULL,4,'2013-04-20 00:08:28','Whole Blood',NULL,NULL,NULL,NULL,0,0,1,'Denied');
DROP TABLE IF EXISTS lab_request_details;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE lab_request_details (
  id int(11) NOT NULL,
  lab_request_id int(11) NOT NULL,
  lab_test_id int(11) NOT NULL,
  comments text,
  PRIMARY KEY (id),
  KEY fk_lab_request_details__lab_request (lab_request_id),
  KEY fk_lab_request_details__lab_test (lab_test_id),
  CONSTRAINT fk_lab_request_details__lab_request FOREIGN KEY (lab_request_id) REFERENCES lab_request (id),
  CONSTRAINT fk_lab_request_details__lab_test FOREIGN KEY (lab_test_id) REFERENCES lab_test (id)
);
/*!40101 SET character_set_client = @saved_cs_client */;

INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (1,1,3,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (2,1,7,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (3,1,11,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (4,1,5,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (5,1,8,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (6,2,4,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (7,2,7,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (8,2,11,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (9,2,6,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (10,2,3,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (11,3,2,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (12,3,7,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (13,3,10,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (14,4,4,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (15,4,7,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (16,4,10,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (17,4,12,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (18,5,2,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (19,5,7,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (20,5,12,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (21,5,11,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (22,5,13,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (23,5,15,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (24,5,14,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (25,6,4,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (26,6,9,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (27,6,5,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (28,6,12,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (29,6,8,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (30,6,2,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (31,7,5,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (32,7,9,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (33,7,6,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (34,7,2,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (35,9,2,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (36,9,7,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (37,9,10,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (38,10,5,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (39,10,9,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (40,11,5,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (41,11,7,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (42,11,9,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (43,12,5,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (44,12,10,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (45,12,6,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (46,12,2,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (47,13,8,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (48,13,4,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (49,13,2,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (50,14,7,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (51,14,10,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (52,14,3,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (53,14,2,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (54,14,9,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (55,14,15,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (56,14,14,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (57,16,3,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (58,16,6,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (59,16,11,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (60,16,12,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (61,17,5,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (62,17,2,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (63,17,12,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (64,17,7,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (65,17,10,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (66,18,3,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (67,18,6,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (68,18,9,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (69,18,12,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (70,18,11,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (71,18,13,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (72,18,14,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (73,18,15,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (74,18,16,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (75,18,17,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (76,18,18,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (77,18,19,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (78,18,8,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (79,18,10,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (80,18,7,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (81,18,5,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (82,18,4,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (83,18,20,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (84,18,21,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (85,18,24,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (86,18,25,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (87,18,29,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (88,18,30,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (89,18,27,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (90,18,22,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (91,18,2,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (92,18,1,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (93,18,23,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (94,18,31,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (96,18,26,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (97,18,28,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (98,19,1,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (99,19,2,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (100,19,5,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (101,19,12,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (102,19,11,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (103,20,1,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (104,20,2,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (105,20,3,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (106,20,4,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (107,20,5,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (108,20,6,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (109,20,7,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (110,20,8,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (111,20,9,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (112,20,10,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (113,20,11,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (114,20,12,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (115,20,13,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (116,20,14,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (117,20,15,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (118,20,16,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (119,20,17,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (120,20,18,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (121,20,19,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (122,20,20,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (123,21,1,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (124,21,2,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (125,21,3,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (126,21,4,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (127,21,5,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (128,21,6,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (129,21,7,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (130,21,8,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (131,21,9,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (132,21,10,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (133,22,2,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (134,22,4,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (135,22,7,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (136,23,3,'null');
INSERT INTO lab_request_details (id, lab_request_id, lab_test_id, comments) VALUES (137,23,5,'null');
DROP TABLE IF EXISTS lab_result;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE lab_result (
  id int(11) NOT NULL,
  lab_request_id int(11) NOT NULL,
  processed_by_technician_id int(11) NOT NULL,
  completion_status enum('PROCESSED','REJECTED','OTHER') NOT NULL,
  completion_status_details text,
  completion_date datetime NOT NULL,
  PRIMARY KEY (id),
  KEY fk_lab_result__lab_request (lab_request_id),
  KEY fk_lab_result__lab_technician (processed_by_technician_id),
  CONSTRAINT fk_lab_result__lab_request FOREIGN KEY (lab_request_id) REFERENCES lab_request (id),
  CONSTRAINT fk_lab_result__lab_technician FOREIGN KEY (processed_by_technician_id) REFERENCES lab_technician (person_id)
);
/*!40101 SET character_set_client = @saved_cs_client */;

INSERT INTO lab_result (id, lab_request_id, processed_by_technician_id, completion_status, completion_status_details, completion_date) VALUES (1,1,10,'PROCESSED',NULL,'2013-04-15 21:59:29');
INSERT INTO lab_result (id, lab_request_id, processed_by_technician_id, completion_status, completion_status_details, completion_date) VALUES (2,18,10,'PROCESSED',NULL,'2013-04-15 22:00:09');
INSERT INTO lab_result (id, lab_request_id, processed_by_technician_id, completion_status, completion_status_details, completion_date) VALUES (3,2,10,'PROCESSED',NULL,'2013-04-16 22:29:32');
INSERT INTO lab_result (id, lab_request_id, processed_by_technician_id, completion_status, completion_status_details, completion_date) VALUES (5,3,10,'PROCESSED',NULL,'2013-04-16 23:08:10');
DROP TABLE IF EXISTS lab_result_details;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE lab_result_details (
  id int(11) NOT NULL,
  lab_result_id int(11) NOT NULL,
  lab_test_id int(11) NOT NULL,
  result text NOT NULL,
  details text,
  PRIMARY KEY (id),
  KEY fk_lab_result_details__lab_result (lab_result_id),
  KEY fk_lab_result_details__lab_test (lab_test_id),
  CONSTRAINT fk_lab_result_details__lab_result FOREIGN KEY (lab_result_id) REFERENCES lab_result (id),
  CONSTRAINT fk_lab_result_details__lab_test FOREIGN KEY (lab_test_id) REFERENCES lab_test (id)
);
/*!40101 SET character_set_client = @saved_cs_client */;

INSERT INTO lab_result_details (id, lab_result_id, lab_test_id, result, details) VALUES (1,1,3,'OK',NULL);
INSERT INTO lab_result_details (id, lab_result_id, lab_test_id, result, details) VALUES (2,1,7,'False',NULL);
INSERT INTO lab_result_details (id, lab_result_id, lab_test_id, result, details) VALUES (3,1,11,'25',NULL);
INSERT INTO lab_result_details (id, lab_result_id, lab_test_id, result, details) VALUES (4,1,5,'31',NULL);
INSERT INTO lab_result_details (id, lab_result_id, lab_test_id, result, details) VALUES (5,1,8,'NotOK',NULL);
INSERT INTO lab_result_details (id, lab_result_id, lab_test_id, result, details) VALUES (6,2,3,'1',NULL);
INSERT INTO lab_result_details (id, lab_result_id, lab_test_id, result, details) VALUES (7,2,6,'2',NULL);
INSERT INTO lab_result_details (id, lab_result_id, lab_test_id, result, details) VALUES (8,2,9,'3',NULL);
INSERT INTO lab_result_details (id, lab_result_id, lab_test_id, result, details) VALUES (9,2,12,'4',NULL);
INSERT INTO lab_result_details (id, lab_result_id, lab_test_id, result, details) VALUES (10,2,11,'5',NULL);
INSERT INTO lab_result_details (id, lab_result_id, lab_test_id, result, details) VALUES (11,2,13,'6',NULL);
INSERT INTO lab_result_details (id, lab_result_id, lab_test_id, result, details) VALUES (12,2,14,'7',NULL);
INSERT INTO lab_result_details (id, lab_result_id, lab_test_id, result, details) VALUES (13,2,15,'8',NULL);
INSERT INTO lab_result_details (id, lab_result_id, lab_test_id, result, details) VALUES (14,2,16,'9',NULL);
INSERT INTO lab_result_details (id, lab_result_id, lab_test_id, result, details) VALUES (15,2,17,'10',NULL);
INSERT INTO lab_result_details (id, lab_result_id, lab_test_id, result, details) VALUES (16,2,18,'11',NULL);
INSERT INTO lab_result_details (id, lab_result_id, lab_test_id, result, details) VALUES (17,2,19,'12',NULL);
INSERT INTO lab_result_details (id, lab_result_id, lab_test_id, result, details) VALUES (18,2,8,'13',NULL);
INSERT INTO lab_result_details (id, lab_result_id, lab_test_id, result, details) VALUES (19,2,10,'14',NULL);
INSERT INTO lab_result_details (id, lab_result_id, lab_test_id, result, details) VALUES (20,2,7,'15',NULL);
INSERT INTO lab_result_details (id, lab_result_id, lab_test_id, result, details) VALUES (21,2,5,'16',NULL);
INSERT INTO lab_result_details (id, lab_result_id, lab_test_id, result, details) VALUES (22,2,4,'17',NULL);
INSERT INTO lab_result_details (id, lab_result_id, lab_test_id, result, details) VALUES (23,2,20,'18',NULL);
INSERT INTO lab_result_details (id, lab_result_id, lab_test_id, result, details) VALUES (24,2,21,'19',NULL);
INSERT INTO lab_result_details (id, lab_result_id, lab_test_id, result, details) VALUES (25,2,24,'20',NULL);
INSERT INTO lab_result_details (id, lab_result_id, lab_test_id, result, details) VALUES (26,2,25,'21',NULL);
INSERT INTO lab_result_details (id, lab_result_id, lab_test_id, result, details) VALUES (27,2,29,'22',NULL);
INSERT INTO lab_result_details (id, lab_result_id, lab_test_id, result, details) VALUES (28,2,30,'23',NULL);
INSERT INTO lab_result_details (id, lab_result_id, lab_test_id, result, details) VALUES (29,2,27,'24',NULL);
INSERT INTO lab_result_details (id, lab_result_id, lab_test_id, result, details) VALUES (30,2,22,'25',NULL);
INSERT INTO lab_result_details (id, lab_result_id, lab_test_id, result, details) VALUES (31,2,2,'26',NULL);
INSERT INTO lab_result_details (id, lab_result_id, lab_test_id, result, details) VALUES (32,2,1,'27',NULL);
INSERT INTO lab_result_details (id, lab_result_id, lab_test_id, result, details) VALUES (33,2,23,'28',NULL);
INSERT INTO lab_result_details (id, lab_result_id, lab_test_id, result, details) VALUES (34,2,31,'29',NULL);
INSERT INTO lab_result_details (id, lab_result_id, lab_test_id, result, details) VALUES (35,2,26,'30',NULL);
INSERT INTO lab_result_details (id, lab_result_id, lab_test_id, result, details) VALUES (36,2,28,'31',NULL);
INSERT INTO lab_result_details (id, lab_result_id, lab_test_id, result, details) VALUES (37,3,4,'Go',NULL);
INSERT INTO lab_result_details (id, lab_result_id, lab_test_id, result, details) VALUES (38,3,7,'45',NULL);
INSERT INTO lab_result_details (id, lab_result_id, lab_test_id, result, details) VALUES (39,3,11,'223',NULL);
INSERT INTO lab_result_details (id, lab_result_id, lab_test_id, result, details) VALUES (40,3,6,'100',NULL);
INSERT INTO lab_result_details (id, lab_result_id, lab_test_id, result, details) VALUES (41,3,3,'FullFilled',NULL);
INSERT INTO lab_result_details (id, lab_result_id, lab_test_id, result, details) VALUES (42,5,2,'12',NULL);
INSERT INTO lab_result_details (id, lab_result_id, lab_test_id, result, details) VALUES (43,5,7,'23',NULL);
INSERT INTO lab_result_details (id, lab_result_id, lab_test_id, result, details) VALUES (44,5,10,'34',NULL);
DROP TABLE IF EXISTS lab_technician;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE lab_technician (
  person_id int(11) NOT NULL,
  hourly_rate decimal(5,2) unsigned DEFAULT NULL,
  PRIMARY KEY (person_id),
  CONSTRAINT fk_lab_technician__person FOREIGN KEY (person_id) REFERENCES person (id)
);
/*!40101 SET character_set_client = @saved_cs_client */;

INSERT INTO lab_technician (person_id, hourly_rate) VALUES (10,43.00);
DROP TABLE IF EXISTS lab_technician_laboratory;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE lab_technician_laboratory (
  id int(11) NOT NULL,
  person_id int(11) NOT NULL,
  laboratory_id int(11) NOT NULL,
  hire_date date DEFAULT NULL,
  termination_date date DEFAULT NULL,
  PRIMARY KEY (id),
  KEY fk_lab_technician_laboratory__person (person_id),
  KEY fk_lab_technician_laboratory__laboratory (laboratory_id),
  CONSTRAINT fk_lab_technician_laboratory__laboratory FOREIGN KEY (laboratory_id) REFERENCES laboratory (id),
  CONSTRAINT fk_lab_technician_laboratory__person FOREIGN KEY (person_id) REFERENCES person (id)
);
/*!40101 SET character_set_client = @saved_cs_client */;

INSERT INTO lab_technician_laboratory (id, person_id, laboratory_id, hire_date, termination_date) VALUES (1,10,1,NULL,NULL);
DROP TABLE IF EXISTS lab_test;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE lab_test (
  id int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  abbreviation varchar(50) NOT NULL,
  reflexive_testing_description text,
  panels_description text,
  special_collection_requirements text,
  PRIMARY KEY (id),
  UNIQUE KEY uq_lab_test__name (`name`),
  UNIQUE KEY uq_lab_test__abbreviation (abbreviation)
);
/*!40101 SET character_set_client = @saved_cs_client */;

INSERT INTO lab_test (id, name, abbreviation, reflexive_testing_description, panels_description, special_collection_requirements) VALUES (1,'ACID PHOSPHATASE','ACID',NULL,NULL,NULL);
INSERT INTO lab_test (id, name, abbreviation, reflexive_testing_description, panels_description, special_collection_requirements) VALUES (2,'ACTH','ACTH',NULL,NULL,NULL);
INSERT INTO lab_test (id, name, abbreviation, reflexive_testing_description, panels_description, special_collection_requirements) VALUES (3,'ACTIVATED PROTEIN C RESISTANCE','APCR',NULL,NULL,NULL);
INSERT INTO lab_test (id, name, abbreviation, reflexive_testing_description, panels_description, special_collection_requirements) VALUES (4,'ALBUMIN (MICRO), URINE','UMALB',NULL,NULL,NULL);
INSERT INTO lab_test (id, name, abbreviation, reflexive_testing_description, panels_description, special_collection_requirements) VALUES (5,'ALDOLASE','ALASE',NULL,NULL,NULL);
INSERT INTO lab_test (id, name, abbreviation, reflexive_testing_description, panels_description, special_collection_requirements) VALUES (6,'ALPHA-1-ANTITRYPSIN','A1AT',NULL,NULL,NULL);
INSERT INTO lab_test (id, name, abbreviation, reflexive_testing_description, panels_description, special_collection_requirements) VALUES (7,'ALHPA FETOPROTEIN TUMOR','AFPNOT',NULL,NULL,NULL);
INSERT INTO lab_test (id, name, abbreviation, reflexive_testing_description, panels_description, special_collection_requirements) VALUES (8,'ALPHA FETOPROTEIN AMNIOTIC','AAFPX',NULL,NULL,NULL);
INSERT INTO lab_test (id, name, abbreviation, reflexive_testing_description, panels_description, special_collection_requirements) VALUES (9,'BETA-2-MICROGLOBULIN','BETA2, CBETA2',NULL,NULL,NULL);
INSERT INTO lab_test (id, name, abbreviation, reflexive_testing_description, panels_description, special_collection_requirements) VALUES (10,'FOLATE','FOLAT',NULL,NULL,NULL);
INSERT INTO lab_test (id, name, abbreviation, reflexive_testing_description, panels_description, special_collection_requirements) VALUES (11,'PROLACTIN','PRL',NULL,NULL,NULL);
INSERT INTO lab_test (id, name, abbreviation, reflexive_testing_description, panels_description, special_collection_requirements) VALUES (12,'ZINC','ZN, UZN',NULL,NULL,NULL);
INSERT INTO lab_test (id, name, abbreviation, reflexive_testing_description, panels_description, special_collection_requirements) VALUES (13,'THYROID TESTING - T3','T3',NULL,NULL,NULL);
INSERT INTO lab_test (id, name, abbreviation, reflexive_testing_description, panels_description, special_collection_requirements) VALUES (14,'THYROID TESTING - T4','T4',NULL,NULL,NULL);
INSERT INTO lab_test (id, name, abbreviation, reflexive_testing_description, panels_description, special_collection_requirements) VALUES (15,'THYROID TESTING - TSH','TSH',NULL,NULL,NULL);
INSERT INTO lab_test (id, name, abbreviation, reflexive_testing_description, panels_description, special_collection_requirements) VALUES (16,'CALCIUM, IONIZED','SRICG, PLIC',NULL,NULL,NULL);
INSERT INTO lab_test (id, name, abbreviation, reflexive_testing_description, panels_description, special_collection_requirements) VALUES (17,'CALCIUM, URIN','UCA',NULL,NULL,NULL);
INSERT INTO lab_test (id, name, abbreviation, reflexive_testing_description, panels_description, special_collection_requirements) VALUES (18,'CAROTENE','CAR',NULL,NULL,NULL);
INSERT INTO lab_test (id, name, abbreviation, reflexive_testing_description, panels_description, special_collection_requirements) VALUES (19,'IMMUNE COMPLEXES','IMCG',NULL,NULL,NULL);
INSERT INTO lab_test (id, name, abbreviation, reflexive_testing_description, panels_description, special_collection_requirements) VALUES (20,'LEAD','PB',NULL,NULL,NULL);
INSERT INTO lab_test (id, name, abbreviation, reflexive_testing_description, panels_description, special_collection_requirements) VALUES (21,'ASPARATE AMINOTRANSFERASE','AST',NULL,NULL,NULL);
INSERT INTO lab_test (id, name, abbreviation, reflexive_testing_description, panels_description, special_collection_requirements) VALUES (22,'MEAN CORPUSCULAR HEMOGLOBIN','MCH',NULL,NULL,NULL);
INSERT INTO lab_test (id, name, abbreviation, reflexive_testing_description, panels_description, special_collection_requirements) VALUES (23,'PROSTATE SPECIFIC ANTIGEN (PROSTATE CANCER TEST)','PSA',NULL,NULL,NULL);
INSERT INTO lab_test (id, name, abbreviation, reflexive_testing_description, panels_description, special_collection_requirements) VALUES (24,'BLOOD UREA NITROGEN','BUN',NULL,NULL,NULL);
INSERT INTO lab_test (id, name, abbreviation, reflexive_testing_description, panels_description, special_collection_requirements) VALUES (25,'BLOOD ALCOHOL CONCENTRATION','BAC',NULL,NULL,NULL);
INSERT INTO lab_test (id, name, abbreviation, reflexive_testing_description, panels_description, special_collection_requirements) VALUES (26,'COMPLETE BLOOD COUNT','CBC',NULL,NULL,NULL);
INSERT INTO lab_test (id, name, abbreviation, reflexive_testing_description, panels_description, special_collection_requirements) VALUES (27,'BASIC METABOLIC PANEL','BMP',NULL,NULL,NULL);
INSERT INTO lab_test (id, name, abbreviation, reflexive_testing_description, panels_description, special_collection_requirements) VALUES (28,'CREATINE KINASE','CK',NULL,NULL,NULL);
INSERT INTO lab_test (id, name, abbreviation, reflexive_testing_description, panels_description, special_collection_requirements) VALUES (29,'LIPOPROTEIN PANEL - GOOD CHOLESTEROL','HDL',NULL,NULL,NULL);
INSERT INTO lab_test (id, name, abbreviation, reflexive_testing_description, panels_description, special_collection_requirements) VALUES (30,'LIPOPROTEIN PANEL - BAD CHOLESTEROL','LDL',NULL,NULL,NULL);
INSERT INTO lab_test (id, name, abbreviation, reflexive_testing_description, panels_description, special_collection_requirements) VALUES (31,'C-REACTIVE PROTEIN TEST','CRP',NULL,NULL,NULL);
DROP TABLE IF EXISTS laboratory;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE laboratory (
  id int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  phone_number char(10) NOT NULL,
  street1 varchar(200) NOT NULL,
  street2 varchar(200) DEFAULT NULL,
  city varchar(200) NOT NULL,
  state_code char(2) NOT NULL COMMENT 'USPS 2 letter state abbreviatiin- could change to ENUM',
  zipcode int(5) unsigned NOT NULL,
  zipcode_plus4 int(4) unsigned DEFAULT NULL,
  PRIMARY KEY (id)
);
/*!40101 SET character_set_client = @saved_cs_client */;

INSERT INTO laboratory (id, name, phone_number, street1, street2, city, state_code, zipcode, zipcode_plus4) VALUES (1,'BestLAB','2528641621','E 10th st',NULL,'Greenville','NC',27858,NULL);
DROP TABLE IF EXISTS medical_license;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE medical_license (
  id int(11) NOT NULL,
  person_id int(11) NOT NULL,
  state_code char(2) NOT NULL COMMENT 'USPS 2 letter state abbreviatiin- could change to ENUM',
  `type` enum('MD','PA') NOT NULL COMMENT 'MD:=Permanent Medical License, PA:=Physicians Assistant',
  issue_date date NOT NULL,
  expiration_date date NOT NULL,
  PRIMARY KEY (id),
  KEY fk_medical_license__physician (person_id),
  CONSTRAINT fk_medical_license__physician FOREIGN KEY (person_id) REFERENCES physician (person_id)
);
/*!40101 SET character_set_client = @saved_cs_client */;

DROP TABLE IF EXISTS medical_practice;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE medical_practice (
  id int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  phone_number char(10) NOT NULL,
  street1 varchar(200) NOT NULL,
  street2 varchar(200) DEFAULT NULL,
  city varchar(200) NOT NULL,
  state_code char(2) NOT NULL COMMENT 'USPS 2 letter state abbreviatiin- could change to ENUM',
  zipcode int(5) unsigned NOT NULL,
  zipcodeperson_plus4 int(4) unsigned DEFAULT NULL,
  PRIMARY KEY (id)
);
/*!40101 SET character_set_client = @saved_cs_client */;

INSERT INTO medical_practice (id, name, phone_number, street1, street2, city, state_code, zipcode, zipcodeperson_plus4) VALUES (1,'Dr Ding\'s Office','2528641621','E 5th St','Ash St','Greenville','NC',27858,NULL);
DROP TABLE IF EXISTS nurse;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE nurse (
  person_id int(11) NOT NULL,
  hourly_rate decimal(10,2) unsigned DEFAULT NULL,
  PRIMARY KEY (person_id),
  CONSTRAINT fk_nurse__person FOREIGN KEY (person_id) REFERENCES person (id)
);
/*!40101 SET character_set_client = @saved_cs_client */;

INSERT INTO nurse (person_id, hourly_rate) VALUES (2,500.00);
DROP TABLE IF EXISTS nursing_license;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE nursing_license (
  id int(11) NOT NULL,
  person_id int(11) NOT NULL,
  state_code char(2) NOT NULL COMMENT 'USPS 2 letter state abbreviatiin- could change to ENUM',
  `type` enum('LPN','RN','NP') NOT NULL COMMENT 'LPN:=Licensed Practical Nurse, RN:=Registered Nurse, NP:=Nurse Practitioner',
  issue_date date NOT NULL,
  expiration_date date NOT NULL,
  PRIMARY KEY (id),
  KEY fk_nursing_license__nurse (person_id),
  CONSTRAINT fk_nursing_license__nurse FOREIGN KEY (person_id) REFERENCES nurse (person_id)
);
/*!40101 SET character_set_client = @saved_cs_client */;

DROP TABLE IF EXISTS patient;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE patient (
  person_id int(11) NOT NULL,
  last_visit date DEFAULT NULL,
  next_scheduled_visit date DEFAULT NULL,
  height_in_inches decimal(5,2) unsigned DEFAULT NULL,
  weight_in_pounds smallint(4) unsigned DEFAULT NULL,
  tobacco_status enum('SMOKER','NONSMOKER','UNKNOWN') NOT NULL DEFAULT 'UNKNOWN',
  PRIMARY KEY (person_id),
  CONSTRAINT fk_patient__person FOREIGN KEY (person_id) REFERENCES person (id)
);
/*!40101 SET character_set_client = @saved_cs_client */;

INSERT INTO patient (person_id, last_visit, next_scheduled_visit, height_in_inches, weight_in_pounds, tobacco_status) VALUES (1,NULL,NULL,NULL,NULL,'UNKNOWN');
INSERT INTO patient (person_id, last_visit, next_scheduled_visit, height_in_inches, weight_in_pounds, tobacco_status) VALUES (7,NULL,NULL,NULL,NULL,'UNKNOWN');
INSERT INTO patient (person_id, last_visit, next_scheduled_visit, height_in_inches, weight_in_pounds, tobacco_status) VALUES (8,NULL,NULL,NULL,NULL,'UNKNOWN');
DROP TABLE IF EXISTS patient_physician_appointment;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE patient_physician_appointment (
  id int(11) NOT NULL,
  patient_id int(11) NOT NULL,
  physician_id int(11) NOT NULL,
  `date` date DEFAULT NULL,
  PRIMARY KEY (id),
  KEY fk_person (patient_id),
  KEY fk_physician (physician_id),
  CONSTRAINT fk_person FOREIGN KEY (patient_id) REFERENCES patient (person_id),
  CONSTRAINT fk_physician FOREIGN KEY (physician_id) REFERENCES physician (person_id)
);
/*!40101 SET character_set_client = @saved_cs_client */;

INSERT INTO patient_physician_appointment (id, patient_id, physician_id, date) VALUES (27,1,5,NULL);
INSERT INTO patient_physician_appointment (id, patient_id, physician_id, date) VALUES (29,1,5,NULL);
INSERT INTO patient_physician_appointment (id, patient_id, physician_id, date) VALUES (30,1,9,NULL);
INSERT INTO patient_physician_appointment (id, patient_id, physician_id, date) VALUES (40,1,5,NULL);
INSERT INTO patient_physician_appointment (id, patient_id, physician_id, date) VALUES (42,7,5,NULL);
INSERT INTO patient_physician_appointment (id, patient_id, physician_id, date) VALUES (43,7,9,NULL);
INSERT INTO patient_physician_appointment (id, patient_id, physician_id, date) VALUES (45,8,5,NULL);
INSERT INTO patient_physician_appointment (id, patient_id, physician_id, date) VALUES (46,8,9,NULL);
DROP TABLE IF EXISTS permission;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE permission (
  id int(11) NOT NULL,
  `name` varchar(40) NOT NULL,
  description varchar(100) DEFAULT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY uq_permission__name (`name`)
);
/*!40101 SET character_set_client = @saved_cs_client */;

INSERT INTO permission (id, name, description) VALUES (1,'doctor_appointment.jsp','Make a doctor appointment here');
INSERT INTO permission (id, name, description) VALUES (3,'admin_only.jsp','Admin\'s cofigs');
INSERT INTO permission (id, name, description) VALUES (5,'/MediQuick/ViewPatientsServlet','See the list of your patients');
INSERT INTO permission (id, name, description) VALUES (6,'ViewTests.jsp','See the list of your tests');
INSERT INTO permission (id, name, description) VALUES (7,'/MediQuick/ViewLabRequests','See the list of requests sent to this lab');
INSERT INTO permission (id, name, description) VALUES (8,'Nurse.jsp','Nurse Temporary');
DROP TABLE IF EXISTS person;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE person (
  id int(11) NOT NULL,
  member_type enum('ADMIN','PATIENT','NURSE','physician','TECHNICIAN') NOT NULL,
  first_name varchar(60) NOT NULL,
  middle_name varchar(60) DEFAULT NULL,
  last_name varchar(60) NOT NULL,
  maiden_name varchar(60) NOT NULL DEFAULT '',
  suffix varchar(20) NOT NULL DEFAULT '',
  gender enum('UNKNOWN','MALE','FEMALE') NOT NULL DEFAULT 'UNKNOWN',
  marital_status enum('SINGLE','MARRIED','DOMESTICPARTNERSHIP','DIVORCED','SEPARATED','WIDOWED','UNREPORTED','UNMARRIED') NOT NULL DEFAULT 'UNREPORTED',
  birth_date date DEFAULT NULL,
  is_test tinyint(1) DEFAULT '0',
  is_active tinyint(1) NOT NULL DEFAULT '1',
  username varchar(60) DEFAULT NULL,
  password_plaintext varchar(255) DEFAULT NULL COMMENT 'Replace with hash for production, but fine for development purposes',
  is_password_reset_required tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (id)
);
/*!40101 SET character_set_client = @saved_cs_client */;

INSERT INTO person (id, member_type, first_name, middle_name, last_name, maiden_name, suffix, gender, marital_status, birth_date, is_test, is_active, username, password_plaintext, is_password_reset_required) VALUES (1,'PATIENT','John',NULL,'Smith','','','MALE','SINGLE',NULL,0,1,'john','smith',0);
INSERT INTO person (id, member_type, first_name, middle_name, last_name, maiden_name, suffix, gender, marital_status, birth_date, is_test, is_active, username, password_plaintext, is_password_reset_required) VALUES (2,'NURSE','Jane',NULL,'Smitha','','','FEMALE','SINGLE',NULL,0,1,'jane','smitha',0);
INSERT INTO person (id, member_type, first_name, middle_name, last_name, maiden_name, suffix, gender, marital_status, birth_date, is_test, is_active, username, password_plaintext, is_password_reset_required) VALUES (3,'ADMIN','Arman',NULL,'Samavatian','','','MALE','SINGLE',NULL,0,1,'arman','sam',0);
INSERT INTO person (id, member_type, first_name, middle_name, last_name, maiden_name, suffix, gender, marital_status, birth_date, is_test, is_active, username, password_plaintext, is_password_reset_required) VALUES (4,'physician','Junhua','','Ding','','','MALE','MARRIED',NULL,0,1,'junhua','ding',0);
INSERT INTO person (id, member_type, first_name, middle_name, last_name, maiden_name, suffix, gender, marital_status, birth_date, is_test, is_active, username, password_plaintext, is_password_reset_required) VALUES (5,'physician','Ozzy',NULL,'Osbourne','','','MALE','MARRIED',NULL,0,1,'ozzy','osbourne',0);
INSERT INTO person (id, member_type, first_name, middle_name, last_name, maiden_name, suffix, gender, marital_status, birth_date, is_test, is_active, username, password_plaintext, is_password_reset_required) VALUES (7,'PATIENT','Maynard',NULL,'Keenan','','','MALE','MARRIED',NULL,0,1,'maynard','keenan',0);
INSERT INTO person (id, member_type, first_name, middle_name, last_name, maiden_name, suffix, gender, marital_status, birth_date, is_test, is_active, username, password_plaintext, is_password_reset_required) VALUES (8,'PATIENT','John',NULL,'Petrucci','','','MALE','MARRIED',NULL,0,1,'john','petrucci',0);
INSERT INTO person (id, member_type, first_name, middle_name, last_name, maiden_name, suffix, gender, marital_status, birth_date, is_test, is_active, username, password_plaintext, is_password_reset_required) VALUES (9,'physician','John',NULL,'Myung','','','MALE','MARRIED',NULL,0,1,'john','myung',0);
INSERT INTO person (id, member_type, first_name, middle_name, last_name, maiden_name, suffix, gender, marital_status, birth_date, is_test, is_active, username, password_plaintext, is_password_reset_required) VALUES (10,'TECHNICIAN','Joe','','Satriani','','','MALE','MARRIED',NULL,0,1,'joe','satriani',0);
DROP TABLE IF EXISTS person_role;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE person_role (
  id int(11) NOT NULL,
  person_id int(11) NOT NULL,
  role_id int(11) NOT NULL,
  PRIMARY KEY (id),
  KEY fk_person_role__person (person_id),
  KEY fk_person_role__role (role_id),
  CONSTRAINT fk_person_role__person FOREIGN KEY (person_id) REFERENCES person (id),
  CONSTRAINT fk_person_role__role FOREIGN KEY (role_id) REFERENCES role (id)
);
/*!40101 SET character_set_client = @saved_cs_client */;

INSERT INTO person_role (id, person_id, role_id) VALUES (1,1,1);
INSERT INTO person_role (id, person_id, role_id) VALUES (2,4,4);
INSERT INTO person_role (id, person_id, role_id) VALUES (3,10,3);
INSERT INTO person_role (id, person_id, role_id) VALUES (4,2,2);
INSERT INTO person_role (id, person_id, role_id) VALUES (9,7,1);
INSERT INTO person_role (id, person_id, role_id) VALUES (10,8,1);
INSERT INTO person_role (id, person_id, role_id) VALUES (11,9,4);
INSERT INTO person_role (id, person_id, role_id) VALUES (12,5,4);
INSERT INTO person_role (id, person_id, role_id) VALUES (13,3,5);
DROP TABLE IF EXISTS physician;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE physician (
  person_id int(11) NOT NULL,
  yearly_salary decimal(10,2) unsigned DEFAULT NULL,
  PRIMARY KEY (person_id),
  CONSTRAINT fk_physician__person FOREIGN KEY (person_id) REFERENCES person (id)
);
/*!40101 SET character_set_client = @saved_cs_client */;

INSERT INTO physician (person_id, yearly_salary) VALUES (4,500.00);
INSERT INTO physician (person_id, yearly_salary) VALUES (5,1000.00);
INSERT INTO physician (person_id, yearly_salary) VALUES (9,1500.00);
DROP TABLE IF EXISTS physician_nurse_medical_practice;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE physician_nurse_medical_practice (
  id int(11) NOT NULL,
  person_id int(11) NOT NULL,
  medical_practice_id int(11) NOT NULL,
  hire_date date DEFAULT NULL,
  termination_date date DEFAULT NULL,
  PRIMARY KEY (id),
  KEY fk_physician_nurse_practice__person (person_id),
  KEY fk_physician_nurse_medical_practice__medical_practice (medical_practice_id),
  CONSTRAINT fk_physician_nurse_medical_practice__medical_practice FOREIGN KEY (medical_practice_id) REFERENCES medical_practice (id),
  CONSTRAINT fk_physician_nurse_practice__person FOREIGN KEY (person_id) REFERENCES person (id)
);
/*!40101 SET character_set_client = @saved_cs_client */;

INSERT INTO physician_nurse_medical_practice (id, person_id, medical_practice_id, hire_date, termination_date) VALUES (1,4,1,NULL,NULL);
INSERT INTO physician_nurse_medical_practice (id, person_id, medical_practice_id, hire_date, termination_date) VALUES (2,2,1,NULL,NULL);
DROP TABLE IF EXISTS role;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE role (
  id int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (id)
);
/*!40101 SET character_set_client = @saved_cs_client */;

INSERT INTO role (id, name) VALUES (1,'PATIENT');
INSERT INTO role (id, name) VALUES (2,'NURSE');
INSERT INTO role (id, name) VALUES (3,'TECHNICIAN');
INSERT INTO role (id, name) VALUES (4,'PHYSICIAN');
INSERT INTO role (id, name) VALUES (5,'ADMIN');
DROP TABLE IF EXISTS role_permission;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE role_permission (
  id int(11) NOT NULL,
  role_id int(11) NOT NULL,
  permission_id int(11) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY uq_role_permission (role_id,permission_id),
  KEY fk_role_permission__permission (permission_id),
  KEY fk_role_permission__role (role_id),
  CONSTRAINT fk_role_permission__permission FOREIGN KEY (permission_id) REFERENCES permission (id),
  CONSTRAINT fk_role_permission__role FOREIGN KEY (role_id) REFERENCES role (id)
);
/*!40101 SET character_set_client = @saved_cs_client */;

INSERT INTO role_permission (id, role_id, permission_id) VALUES (1,1,1);
INSERT INTO role_permission (id, role_id, permission_id) VALUES (8,1,6);
INSERT INTO role_permission (id, role_id, permission_id) VALUES (10,2,8);
INSERT INTO role_permission (id, role_id, permission_id) VALUES (9,3,7);
INSERT INTO role_permission (id, role_id, permission_id) VALUES (6,4,5);
INSERT INTO role_permission (id, role_id, permission_id) VALUES (5,5,3);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

