-- ****************************************************************************************************************************** 

-- FILENAME             ::::  obesity.sql
-- AUTHOR               ::::  Keerthana K H
-- CREATED ON           ::::  26/12/2024
-- *******************************************************************************************************************************/


-- MySQL dump 10.13  Distrib 8.0.37, for Win64 (x86_64)
--
-- Host: localhost    Database: Obesity
-- ------------------------------------------------------
-- Server version	8.0.37

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `audit_nutri_register`
--

DROP TABLE IF EXISTS `audit_nutri_register`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `audit_nutri_register` (
  `audit_nr_id` int NOT NULL AUTO_INCREMENT,
  `audit_nr_action` varchar(250) DEFAULT NULL,
  `nutri_id` varchar(100) NOT NULL,
  `password` varchar(500) DEFAULT NULL,
  `user_role` varchar(100) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `phone_num` varchar(50) DEFAULT NULL,
  `mail_id` varchar(200) DEFAULT NULL,
  `gender` varchar(50) DEFAULT NULL,
  `audit_nr_created_datetime` timestamp NULL DEFAULT NULL,
  `audit_nr_updated_datetime` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`audit_nr_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audit_nutri_register`
--

LOCK TABLES `audit_nutri_register` WRITE;
/*!40000 ALTER TABLE `audit_nutri_register` DISABLE KEYS */;
INSERT INTO `audit_nutri_register` VALUES (1,'Insert','1',NULL,NULL,NULL,NULL,NULL,NULL,'2024-12-26 07:40:04','2024-12-26 07:40:04');
/*!40000 ALTER TABLE `audit_nutri_register` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `audit_patientprofile`
--

DROP TABLE IF EXISTS `audit_patientprofile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `audit_patientprofile` (
  `audit_pp_id` int NOT NULL AUTO_INCREMENT,
  `audit_pp_action` varchar(250) DEFAULT NULL,
  `patient_id` varchar(250) DEFAULT NULL,
  `name` varchar(250) DEFAULT NULL,
  `age` int DEFAULT NULL,
  `sex` varchar(250) DEFAULT NULL,
  `date_of_admission` varchar(250) DEFAULT NULL,
  `date_of_discharge` varchar(250) DEFAULT NULL,
  `date_of_evaluation` varchar(250) DEFAULT NULL,
  `medical_diagnosis` varchar(250) DEFAULT NULL,
  `lifestyle` varchar(250) DEFAULT NULL,
  `audit_pp_created_datetime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `audit_pp_updated_datetime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`audit_pp_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audit_patientprofile`
--

LOCK TABLES `audit_patientprofile` WRITE;
/*!40000 ALTER TABLE `audit_patientprofile` DISABLE KEYS */;
INSERT INTO `audit_patientprofile` VALUES (1,'update','1','HK',NULL,'M',NULL,NULL,NULL,NULL,NULL,'2024-12-25 19:05:46','2024-12-25 19:05:46'),(2,'delete','1','HK',21,'M',NULL,NULL,NULL,NULL,NULL,'2024-12-25 19:05:58','2024-12-25 19:05:58'),(3,'insert','1','Hari',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2024-12-25 19:07:27','2024-12-25 19:07:27');
/*!40000 ALTER TABLE `audit_patientprofile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `audit_report`
--

DROP TABLE IF EXISTS `audit_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `audit_report` (
  `audit_re_id` int NOT NULL AUTO_INCREMENT,
  `audit_re_action` varchar(250) DEFAULT NULL,
  `re_id` int DEFAULT NULL,
  `patient_id` varchar(250) DEFAULT NULL,
  `nutri_id` varchar(100) DEFAULT NULL,
  `height` varchar(250) DEFAULT NULL,
  `weight` varchar(250) DEFAULT NULL,
  `bmi` varchar(250) DEFAULT NULL,
  `smoking` varchar(250) DEFAULT NULL,
  `alcohol` varchar(250) DEFAULT NULL,
  `physical_activity` varchar(250) DEFAULT NULL,
  `time_using_technology` varchar(250) DEFAULT NULL,
  `drinking_water_intake` int DEFAULT NULL,
  `assessment_plan` varchar(250) DEFAULT NULL,
  `dietitian_note` text,
  `intervention_plan` text,
  `date_of_evaluation` varchar(250) DEFAULT NULL,
  `audit_re_created_datetime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `audit_re_updated_datetime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`audit_re_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audit_report`
--

LOCK TABLES `audit_report` WRITE;
/*!40000 ALTER TABLE `audit_report` DISABLE KEYS */;
/*!40000 ALTER TABLE `audit_report` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nutri_register`
--

DROP TABLE IF EXISTS `nutri_register`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nutri_register` (
  `nutri_id` varchar(100) NOT NULL,
  `password` varchar(500) DEFAULT NULL,
  `user_role` varchar(100) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `phone_num` varchar(50) DEFAULT NULL,
  `mail_id` varchar(200) DEFAULT NULL,
  `gender` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`nutri_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nutri_register`
--

LOCK TABLES `nutri_register` WRITE;
/*!40000 ALTER TABLE `nutri_register` DISABLE KEYS */;
INSERT INTO `nutri_register` VALUES ('1',NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `nutri_register` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `nutri_register_audit_insert` AFTER INSERT ON `nutri_register` FOR EACH ROW BEGIN
  INSERT INTO audit_nutri_register
  SET
    audit_nr_action = 'Insert',
    nutri_id = NEW.nutri_id,
    password = NEW.password,
    user_role = NEW.user_role,
    name = NEW.name,
    phone_num = NEW.phone_num,
    mail_id = NEW.mail_id,
    gender = NEW.gender,
    audit_nr_created_datetime = NOW(),
    audit_nr_updated_datetime = NOW();
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `nutri_register_audit_update` BEFORE UPDATE ON `nutri_register` FOR EACH ROW BEGIN
  IF  
    (NOT (OLD.nutri_id<=>NEW.nutri_id)) OR (NOT (OLD.password<=>NEW.password)) OR 
    (NOT (OLD.user_role<=>NEW.user_role)) OR (NOT (OLD.name<=>NEW.name)) OR 
    (NOT (OLD.phone_num<=>NEW.phone_num)) OR (NOT (OLD.mail_id<=>NEW.mail_id)) OR 
    (NOT (OLD.gender<=>NEW.gender)) 
  THEN
    INSERT INTO audit_nutri_register
    SET
	  audit_nr_action = 'Update',
	  nutri_id = OLD.nutri_id,
      password = IF(OLD.password=NEW.password, NULL, NEW.password),
      user_role = IF(OLD.user_role=NEW.user_role, NULL, NEW.user_role),
      name = IF(OLD.name=NEW.name, NULL, NEW.name),
      phone_num = IF(OLD.phone_num=NEW.phone_num, NULL, NEW.phone_num),
      mail_id = IF(OLD.mail_id=NEW.mail_id, NULL, NEW.mail_id),
      gender = IF(OLD.gender=NEW.gender, NULL, NEW.gender),
        audit_nr_created_datetime = NOW(),
        audit_nr_updated_datetime = NOW();
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `nutri_register_audit_delete` BEFORE DELETE ON `nutri_register` FOR EACH ROW BEGIN
  INSERT INTO audit_nutri_register
  SET
	  audit_nr_action = 'Delete',
      nutri_id = OLD.nutri_id,
      password = OLD.password,
      user_role = OLD.user_role,
      name = OLD.name,
      phone_num = OLD.phone_num,
      mail_id = OLD.mail_id,
      gender = OLD.gender,
	  audit_nr_created_datetime = NOW(),
	  audit_nr_updated_datetime = NOW();
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `patientprofile`
--

DROP TABLE IF EXISTS `patientprofile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patientprofile` (
  `patient_id` varchar(250) NOT NULL,
  `name` varchar(250) DEFAULT NULL,
  `age` int DEFAULT NULL,
  `sex` varchar(250) DEFAULT NULL,
  `date_of_admission` varchar(250) DEFAULT NULL,
  `date_of_discharge` varchar(250) DEFAULT NULL,
  `date_of_evaluation` varchar(250) DEFAULT NULL,
  `medical_diagnosis` varchar(250) DEFAULT NULL,
  `lifestyle` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patientprofile`
--

LOCK TABLES `patientprofile` WRITE;
/*!40000 ALTER TABLE `patientprofile` DISABLE KEYS */;
INSERT INTO `patientprofile` VALUES ('1','Hari',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `patientprofile` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `patientprofile_audit_insert` AFTER INSERT ON `patientprofile` FOR EACH ROW BEGIN
  INSERT INTO audit_patientprofile 
  SET
    audit_pp_action = 'insert',
    patient_id = NEW.patient_id,
    name= NEW.name,
    age = NEW.age,
    sex = NEW.sex,
    date_of_admission = NEW.date_of_admission,
    date_of_discharge = NEW.date_of_discharge,
    date_of_evaluation = NEW.date_of_evaluation,
    medical_diagnosis = NEW.medical_diagnosis,
    lifestyle = NEW.lifestyle,
    audit_pp_created_datetime = NOW(),
    audit_pp_updated_datetime = NOW();
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `patientprofile_audit_update` BEFORE UPDATE ON `patientprofile` FOR EACH ROW BEGIN 
  IF (NOT (OLD.patient_id <=> NEW.patient_id)) OR 
     (NOT (OLD.age <=> NEW.age)) OR 
     (NOT (OLD.name <=> NEW.name)) OR 
     (NOT (OLD.sex <=> NEW.sex)) OR 
     (NOT (OLD.date_of_admission <=> NEW.date_of_admission)) OR
     (NOT (OLD.date_of_discharge <=> NEW.date_of_discharge)) OR 
     (NOT (OLD.date_of_evaluation <=> NEW.date_of_evaluation)) OR 
     (NOT (OLD.medical_diagnosis <=> NEW.medical_diagnosis)) OR 
     (NOT (OLD.lifestyle <=> NEW.lifestyle))
  THEN
    INSERT INTO audit_patientprofile
    SET 
       audit_pp_action = 'update',
       patient_id = OLD.patient_id,
       name = OLD.name,
       age = IF(OLD.age = NEW.age, NULL, NEW.age),
       sex = IF(OLD.sex = NEW.sex, NULL, NEW.sex),
       date_of_admission = IF(OLD.date_of_admission = NEW.date_of_admission, NULL, NEW.date_of_admission),
       date_of_discharge = IF(OLD.date_of_discharge = NEW.date_of_discharge, NULL, NEW.date_of_discharge),
       date_of_evaluation = IF(OLD.date_of_evaluation = NEW.date_of_evaluation, NULL, NEW.date_of_evaluation),
       medical_diagnosis = IF(OLD.medical_diagnosis = NEW.medical_diagnosis, NULL, NEW.medical_diagnosis),
       lifestyle = IF(OLD.lifestyle = NEW.lifestyle, NULL, NEW.lifestyle),
       audit_pp_created_datetime = NOW(),
       audit_pp_updated_datetime = NOW();
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `patientprofile_audit_delete` BEFORE DELETE ON `patientprofile` FOR EACH ROW BEGIN 
  INSERT INTO audit_patientprofile
  SET
    audit_pp_action = 'delete',
    patient_id = OLD.patient_id,
    name = OLD.name,
    age = OLD.age,
    sex = OLD.sex,
    date_of_admission = OLD.date_of_admission,
    date_of_discharge = OLD.date_of_discharge,
    date_of_evaluation = OLD.date_of_evaluation,
    medical_diagnosis = OLD.medical_diagnosis,
    lifestyle = OLD.lifestyle,
    audit_pp_created_datetime = NOW(),
    audit_pp_updated_datetime = NOW();
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `report`
--

DROP TABLE IF EXISTS `report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `report` (
  `re_id` int NOT NULL AUTO_INCREMENT,
  `patient_id` varchar(250) DEFAULT NULL,
  `nutri_id` varchar(100) DEFAULT NULL,
  `height` varchar(250) DEFAULT NULL,
  `weight` varchar(250) DEFAULT NULL,
  `bmi` varchar(250) DEFAULT NULL,
  `smoking` varchar(250) DEFAULT NULL,
  `alcohol` varchar(250) DEFAULT NULL,
  `physical_activity` varchar(250) DEFAULT NULL,
  `time_using_technology` varchar(250) DEFAULT NULL,
  `drinking_water_intake` int DEFAULT NULL,
  `assessment_plan` varchar(250) DEFAULT NULL,
  `dietitian_note` text,
  `intervention_plan` text,
  `date_of_evaluation` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`re_id`),
  KEY `patient_id` (`patient_id`),
  KEY `nutri_id` (`nutri_id`),
  CONSTRAINT `report_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patientprofile` (`patient_id`) ON DELETE CASCADE,
  CONSTRAINT `report_ibfk_2` FOREIGN KEY (`nutri_id`) REFERENCES `nutri_register` (`nutri_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `report`
--

LOCK TABLES `report` WRITE;
/*!40000 ALTER TABLE `report` DISABLE KEYS */;
/*!40000 ALTER TABLE `report` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `report_audit_insert` AFTER INSERT ON `report` FOR EACH ROW BEGIN
  INSERT INTO audit_report
  SET
    audit_re_action = 'Insert',
    re_id = NEW.re_id,
    patient_id = NEW.patient_id,
    nutri_id = NEW.nutri_id,
    height = NEW.height,
    weight = NEW.weight,
    bmi = NEW.bmi,
    smoking = NEW.smoking,
    alcohol = NEW.alcohol,
    physical_activity = NEW.physical_activity,
    time_using_technology = NEW.time_using_technology,
    drinking_water_intake = NEW.drinking_water_intake,
    assessment_plan = NEW.assessment_plan,
    dietitian_note = NEW.dietitian_note,
    intervention_plan = NEW.intervention_plan,
    date_of_evaluation = NEW.date_of_evaluation,
    audit_re_created_datetime = NOW(),
    audit_re_updated_datetime = NOW();
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `report_audit_update` BEFORE UPDATE ON `report` FOR EACH ROW BEGIN
  IF 
    (NOT (OLD.patient_id <=> NEW.patient_id)) OR 
    (NOT (OLD.nutri_id <=> NEW.nutri_id)) OR
    (NOT (OLD.height <=> NEW.height)) OR
    (NOT (OLD.weight <=> NEW.weight)) OR
    (NOT (OLD.bmi <=> NEW.bmi)) OR
    (NOT (OLD.smoking <=> NEW.smoking)) OR
    (NOT (OLD.alcohol <=> NEW.alcohol)) OR
    (NOT (OLD.physical_activity <=> NEW.physical_activity)) OR
    (NOT (OLD.time_using_technology <=> NEW.time_using_technology)) OR
    (NOT (OLD.drinking_water_intake <=> NEW.drinking_water_intake)) OR
    (NOT (OLD.assessment_plan <=> NEW.assessment_plan)) OR
    (NOT (OLD.dietitian_note <=> NEW.dietitian_note)) OR
    (NOT (OLD.intervention_plan <=> NEW.intervention_plan)) OR
    (NOT (OLD.date_of_evaluation <=> NEW.date_of_evaluation))
  THEN
    INSERT INTO audit_report
    SET
      audit_re_action = 'Update',
      re_id = OLD.re_id,
      patient_id = IF(OLD.patient_id = NEW.patient_id, NULL, NEW.patient_id),
      nutri_id = IF(OLD.nutri_id = NEW.nutri_id, NULL, NEW.nutri_id),
      height = IF(OLD.height = NEW.height, NULL, NEW.height),
      weight = IF(OLD.weight = NEW.weight, NULL, NEW.weight),
      bmi = IF(OLD.bmi = NEW.bmi, NULL, NEW.bmi),
      smoking = IF(OLD.smoking = NEW.smoking, NULL, NEW.smoking),
      alcohol = IF(OLD.alcohol = NEW.alcohol, NULL, NEW.alcohol),
      physical_activity = IF(OLD.physical_activity = NEW.physical_activity, NULL, NEW.physical_activity),
      time_using_technology = IF(OLD.time_using_technology = NEW.time_using_technology, NULL, NEW.time_using_technology),
      drinking_water_intake = IF(OLD.drinking_water_intake = NEW.drinking_water_intake, NULL, NEW.drinking_water_intake),
      assessment_plan = IF(OLD.assessment_plan = NEW.assessment_plan, NULL, NEW.assessment_plan),
      dietitian_note = IF(OLD.dietitian_note = NEW.dietitian_note, NULL, NEW.dietitian_note),
      intervention_plan = IF(OLD.intervention_plan = NEW.intervention_plan, NULL, NEW.intervention_plan),
      date_of_evaluation = IF(OLD.date_of_evaluation = NEW.date_of_evaluation, NULL, NEW.date_of_evaluation),
      audit_re_created_datetime = NOW(),
      audit_re_updated_datetime = NOW();
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `report_audit_delete` BEFORE DELETE ON `report` FOR EACH ROW BEGIN
  INSERT INTO audit_report
  SET
    audit_re_action = 'Delete',
    re_id = OLD.re_id,
    patient_id = OLD.patient_id,
    nutri_id = OLD.nutri_id,
    height = OLD.height,
    weight = OLD.weight,
    bmi = OLD.bmi,
    smoking = OLD.smoking,
    alcohol = OLD.alcohol,
    physical_activity = OLD.physical_activity,
    time_using_technology = OLD.time_using_technology,
    drinking_water_intake = OLD.drinking_water_intake,
    assessment_plan = OLD.assessment_plan,
    dietitian_note = OLD.dietitian_note,
    intervention_plan = OLD.intervention_plan,
    date_of_evaluation = OLD.date_of_evaluation,
    audit_re_created_datetime = NOW(),
    audit_re_updated_datetime = NOW();
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-26 13:25:04
