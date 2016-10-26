-- MySQL dump 10.13  Distrib 5.5.52, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: hras_test
-- ------------------------------------------------------
-- Server version	5.5.52-0ubuntu0.14.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `branch`
--

DROP TABLE IF EXISTS `branch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `branch` (
  `department` varchar(100) NOT NULL,
  `course` varchar(10) NOT NULL,
  `year` int(10) unsigned NOT NULL,
  `strength` int(11) NOT NULL,
  PRIMARY KEY (`department`,`course`,`year`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `branch`
--

LOCK TABLES `branch` WRITE;
/*!40000 ALTER TABLE `branch` DISABLE KEYS */;
INSERT INTO `branch` VALUES ('Computer Science and Engineering','B.Tech',1,126),('Computer Science and Engineering','B.Tech',2,111),('Computer Science and Engineering','B.Tech',3,65),('Computer Science and Engineering','B.Tech',4,99),('Computer Science and Engineering','IDD',1,16),('Computer Science and Engineering','IDD',2,18),('Computer Science and Engineering','IDD',3,12),('Computer Science and Engineering','IDD',4,7),('Electrical Engineering','B.Tech',1,78),('Electrical Engineering','B.Tech',2,95),('Electrical Engineering','B.Tech',3,101),('Electrical Engineering','B.Tech',4,102),('Electrical Engineering','IDD',1,15),('Electrical Engineering','IDD',2,19),('Electrical Engineering','IDD',3,18),('Electrical Engineering','IDD',4,10),('Electronics Engineering','B.Tech',1,118),('Electronics Engineering','B.Tech',2,103),('Electronics Engineering','B.Tech',3,73),('Electronics Engineering','B.Tech',4,130),('Electronics Engineering','IDD',1,14),('Electronics Engineering','IDD',2,7),('Electronics Engineering','IDD',3,15),('Electronics Engineering','IDD',4,16),('Metallurgical Engineering','B.Tech',1,123),('Metallurgical Engineering','B.Tech',2,86),('Metallurgical Engineering','B.Tech',3,116),('Metallurgical Engineering','B.Tech',4,109),('Metallurgical Engineering','IDD',1,14),('Metallurgical Engineering','IDD',2,11),('Metallurgical Engineering','IDD',3,17),('Metallurgical Engineering','IDD',4,10);
/*!40000 ALTER TABLE `branch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hostel`
--

DROP TABLE IF EXISTS `hostel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hostel` (
  `name` varchar(100) NOT NULL,
  `capacity` int(10) unsigned NOT NULL,
  `head_warden` varchar(50) NOT NULL,
  `head_warden_email` varchar(50) NOT NULL,
  `head_warden_passwd` varchar(50) NOT NULL,
  `gender` enum('M','F') NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hostel`
--

LOCK TABLES `hostel` WRITE;
/*!40000 ALTER TABLE `hostel` DISABLE KEYS */;
INSERT INTO `hostel` VALUES ('C.V.Raman',210,'Debasheesh Khan','debasheesh.khan@iitbhu.ac.in','646cc3c142a63bd77d2166ca69684cbaba9dfbe7','M'),('Limbdi Hostel',200,'Arnab Sarkar','arnab.sarkar@iitbhu.ac.in','646cc3c142a63bd77d2166ca69684cbaba9dfbe7','M'),('Ramanujan Hostel',180,'J.S.Basu','j.s.basu@iitbhu.ac.in','646cc3c142a63bd77d2166ca69684cbaba9dfbe7','M'),('S.N.Bose Hostel',190,'J.N.Pandey','j.n.pandey@iitbhu.ac.in','646cc3c142a63bd77d2166ca69684cbaba9dfbe7','M'),('Vishveswarayya Hostel',305,'G.S.Mahobia','g.s.mahobia@iitbhu.ac.in','646cc3c142a63bd77d2166ca69684cbaba9dfbe7','M');
/*!40000 ALTER TABLE `hostel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resides_in`
--

DROP TABLE IF EXISTS `resides_in`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resides_in` (
  `hostel_name` varchar(100) NOT NULL,
  `department` varchar(100) NOT NULL,
  `course` varchar(10) NOT NULL,
  `year` int(10) unsigned NOT NULL,
  `strength` int(10) unsigned NOT NULL,
  `range_start` int(10) unsigned NOT NULL,
  `range_end` int(10) unsigned NOT NULL,
  `seater` int(10) unsigned DEFAULT '2',
  PRIMARY KEY (`hostel_name`,`department`,`course`,`year`),
  KEY `fk_resides_br` (`department`,`course`,`year`),
  CONSTRAINT `fk_resides_br` FOREIGN KEY (`department`, `course`, `year`) REFERENCES `branch` (`department`, `course`, `year`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_resides_host` FOREIGN KEY (`hostel_name`) REFERENCES `hostel` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resides_in`
--

LOCK TABLES `resides_in` WRITE;
/*!40000 ALTER TABLE `resides_in` DISABLE KEYS */;
INSERT INTO `resides_in` VALUES ('Ramanujan Hostel','Computer Science and Engineering','B.Tech',3,62,1,41,2),('Ramanujan Hostel','Computer Science and Engineering','IDD',3,11,1,41,2),('Ramanujan Hostel','Electrical Engineering','B.Tech',2,76,131,179,2),('Ramanujan Hostel','Electrical Engineering','IDD',2,9,131,179,2),('Ramanujan Hostel','Electronics Engineering','B.Tech',2,82,42,86,2),('Ramanujan Hostel','Electronics Engineering','IDD',2,62,42,86,2),('Ramanujan Hostel','Metallurgical Engineering','B.Tech',2,65,87,130,2),('Ramanujan Hostel','Metallurgical Engineering','IDD',2,13,87,130,2);
/*!40000 ALTER TABLE `resides_in` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room`
--

DROP TABLE IF EXISTS `room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `room` (
  `number` int(10) unsigned NOT NULL,
  `roll_num` varchar(15) NOT NULL,
  `hostel_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`roll_num`),
  UNIQUE KEY `roll_num` (`roll_num`),
  KEY `fk_room_hostel` (`hostel_name`),
  CONSTRAINT `fk_room_stud` FOREIGN KEY (`roll_num`) REFERENCES `student` (`roll_num`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_room_hostel` FOREIGN KEY (`hostel_name`) REFERENCES `hostel` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room`
--

LOCK TABLES `room` WRITE;
/*!40000 ALTER TABLE `room` DISABLE KEYS */;
INSERT INTO `room` VALUES (35,'14074011','Ramanujan Hostel'),(39,'14074012','Ramanujan Hostel'),(39,'14074013','Ramanujan Hostel'),(4,'14074014','Ramanujan Hostel'),(11,'14074015','Ramanujan Hostel'),(23,'14074016','Ramanujan Hostel'),(56,'15064002','Ramanujan Hostel'),(69,'15064015','Ramanujan Hostel'),(44,'15064065','Ramanujan Hostel');
/*!40000 ALTER TABLE `room` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student` (
  `name` varchar(50) NOT NULL,
  `roll_num` varchar(15) NOT NULL,
  `email` varchar(50) NOT NULL,
  `mess_fee_receipt_num` varchar(20) NOT NULL,
  `no_dues_certificate` char(1) NOT NULL,
  `contact_num` varchar(13) NOT NULL,
  `gender` enum('M','F') NOT NULL,
  `department` varchar(100) NOT NULL,
  `course` varchar(10) NOT NULL,
  `year` int(10) unsigned NOT NULL,
  `prev_hostel_name` varchar(100) NOT NULL,
  `prev_hostel_room` int(11) NOT NULL,
  `guardian_name` varchar(50) NOT NULL,
  `guardian_contact` varchar(13) NOT NULL,
  `guardian_address` varchar(300) NOT NULL,
  `local_guardian_name` varchar(50) NOT NULL,
  `local_guardian_contact` varchar(13) NOT NULL,
  `local_guardian_address` varchar(300) NOT NULL,
  `bank_account_number` varchar(100) DEFAULT NULL,
  `hostel_name` varchar(100) NOT NULL,
  PRIMARY KEY (`roll_num`),
  UNIQUE KEY `roll_num` (`roll_num`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `mess_fee_receipt_num` (`mess_fee_receipt_num`),
  KEY `fk_stud_br` (`department`,`course`,`year`),
  KEY `fk_stud_host` (`hostel_name`),
  CONSTRAINT `fk_stud_br` FOREIGN KEY (`department`, `course`, `year`) REFERENCES `branch` (`department`, `course`, `year`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_stud_host` FOREIGN KEY (`hostel_name`) REFERENCES `hostel` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` VALUES ('Deepak Yadav','14074011','Deepak.Yadav@iitbhu.ac.in','2355177','Y','9879841220','M','Computer Science and Engineering','IDD',3,'C.V.Raman',116,'Deepak Yadav Sr.','9544136611','Lanka Gate','Sachin','9544136616','Subhash C. Bose Nagar','8810223464155','Ramanujan Hostel'),('Divyansh Kumar','14074012','Divyansh.Kumar@iitbhu.ac.in','1607295','Y','8529604792','M','Computer Science and Engineering','B.Tech',3,'C.V.Raman',74,'Divyansh Kumar Sr.','9745392452','Kabir Colony','Rajendra','9745392489','Lanka Gate','3196262099548','Ramanujan Hostel'),('Devanshu Pratihar','14074013','Devanshu.Pratihar@iitbhu.ac.in','5862650','Y','9888702212','M','Computer Science and Engineering','IDD',3,'C.V.Raman',11,'Devanshu Pratihar Sr.','7902685167','Subhash C. Bose Nagar','Ramesh','7902685222','Malaviya Bhawan','5240510631818','Ramanujan Hostel'),('Ayush Shrivastava','14074014','Ayush.Shrivastava@iitbhu.ac.in','7581694','Y','9685674498','M','Computer Science and Engineering','B.Tech',3,'C.V.Raman',181,'Ayush Shrivastava Sr.','7048794626','Subhash C. Bose Nagar','Kush','7048794668','Lanka Gate','6492445484036','Ramanujan Hostel'),('Shivam Garg','14074015','Shivam.Garg@iitbhu.ac.in','3326576','Y','8165182287','M','Computer Science and Engineering','B.Tech',3,'C.V.Raman',133,'Shivam Garg Sr.','8303675574','Valmiki Shetra','Lajpath','8303675653','Indira Chowk','4365462909220','Ramanujan Hostel'),('Arjun Malik','14074016','Arjun.Malik@iitbhu.ac.in','6100954','Y','8135557115','M','Computer Science and Engineering','B.Tech',3,'C.V.Raman',112,'Arjun Malik Sr.','7822639910','Malaviya Bhawan','Raja Jain','7822639935','Subhash C. Bose Nagar','3934846602613','Ramanujan Hostel'),('Raja Jain','15064002','Raja.Jain@iitbhu.ac.in','9632114','Y','9599566167','M','Electronics Engineering','IDD',2,'Vishveswarayya Hostel',139,'Raja Jain Sr.','9448235601','Kabir Colony','Sindhu','9448235700','Rajgir Chowraha','5920825583627','Ramanujan Hostel'),('Avi Goyal','15064015','Avi.Goyal@iitbhu.ac.in','1960503','Y','9811594496','M','Electronics Engineering','B.Tech',2,'Vishveswarayya Hostel',53,'Avi Goyal Sr.','7309254707','Shurma Gate','Malik','7309254715','Shurma Gate','4335287181893','Ramanujan Hostel'),('Sameer Manchanda','15064065','Sameer.Manchanda@iitbhu.ac.in','6792031','Y','8816788259','M','Electronics Engineering','B.Tech',2,'Vishveswarayya Hostel',113,'Sameer Manchanda Sr.','9129143465','Indira Chowk','Rahgir','9129143543','Kabir Colony','9304919464513','Ramanujan Hostel');
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_id`
--

DROP TABLE IF EXISTS `student_id`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_id` (
  `roll_num` varchar(15) NOT NULL,
  `email` varchar(50) NOT NULL,
  `passwd` varchar(40) NOT NULL,
  PRIMARY KEY (`roll_num`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_id`
--

LOCK TABLES `student_id` WRITE;
/*!40000 ALTER TABLE `student_id` DISABLE KEYS */;
INSERT INTO `student_id` VALUES ('14074008','Faizan.Khan@iitbhu.ac.in','b773ef6acace212da411e33839a75e701eed169a'),('14074009','Devesh.Manjhi@iitbhu.ac.in','03f78afa40c84dcddf6a6b49a5f966fca89740b5'),('14074010','Babloo.Kumar@iitbhu.ac.in','fb01e72d226594d19b8ed0f9cfdb072b4efda2ff'),('14074011','Deepak.Yadav@iitbhu.ac.in','1e218c4e8d6e61b36c2a49df741a4984d285ac98'),('14074012','Divyansh.Kumar@iitbhu.ac.in','75c76d9cab5457f214766c2d0b8ba776dd4e745e'),('14074013','Devanshu.Pratihar@iitbhu.ac.in','fc50ac8a0db751fe0bbe1ff1b314f153678b56b7'),('14074014','Ayush.Shrivastava@iitbhu.ac.in','a69fdd1f9ce6e9e16f20755b15b49eb4dedafe23'),('14074015','Shivam.Garg@iitbhu.ac.in','759a1bd744eacdc3512b492a9f463f87eb4c2561'),('14074016','Arjun.Malik@iitbhu.ac.in','54e15dd1f9ec75f01c31cd892c415964575c41b1'),('15064002','Raja.Jain@iitbhu.ac.in','b9d7417ffa1db351d5f011aa055dd4045ceae54a'),('15064015','Avi.Goyal@iitbhu.ac.in','27b12a25cbc12e7b7063322e0bdbad71e8879192'),('15064065','Sameer.Manchanda@iitbhu.ac.in','7bb1b1d9b46b53c693d0700b20a5e90f63758590'),('15064072','DVS.Aditya@iitbhu.ac.in','92ed942ecaba88f008249b73113ca5d2742193cd'),('15064074','Moulik.Gupta@iitbhu.ac.in','600bdc2c2c147e232e6bd9d378d7cb028814d410'),('15064075','Paras.Ghai@iitbhu.ac.in','977126c4c20cf5528600a387f5f3e7cb958b4544');
/*!40000 ALTER TABLE `student_id` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-10-22 14:33:46
