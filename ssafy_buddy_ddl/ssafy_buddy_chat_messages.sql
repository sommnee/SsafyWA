-- MySQL dump 10.13  Distrib 8.0.36, for macos14 (arm64)
--
-- Host: localhost    Database: ssafy_buddy
-- ------------------------------------------------------
-- Server version	8.3.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `chat_messages`
--

DROP TABLE IF EXISTS `chat_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chat_messages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sender_id` varchar(30) NOT NULL,
  `receiver_id` varchar(30) NOT NULL,
  `content` text NOT NULL,
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `read_check` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sender_id` (`sender_id`),
  KEY `receiver_id` (`receiver_id`),
  CONSTRAINT `chat_messages_ibfk_1` FOREIGN KEY (`sender_id`) REFERENCES `member` (`user_id`),
  CONSTRAINT `chat_messages_ibfk_2` FOREIGN KEY (`receiver_id`) REFERENCES `member` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chat_messages`
--

LOCK TABLES `chat_messages` WRITE;
/*!40000 ALTER TABLE `chat_messages` DISABLE KEYS */;
INSERT INTO `chat_messages` VALUES (1,'ssafy','boeun00','1234','2024-05-22 00:55:18',1),(2,'ssafy','boeun00','1234','2024-05-22 00:58:40',1),(3,'ssafy','boeun00','1234','2024-05-22 00:59:18',1),(4,'boeun00','ssafy','안녕?','2024-05-22 01:00:14',1),(5,'ssafy','boeun00','awsads','2024-05-22 01:06:42',1),(6,'boeun00','ssafy','asdasd','2024-05-22 01:06:50',1),(7,'boeun00','ssafy','zxckmlasd','2024-05-22 01:06:57',1),(8,'ssafy','boeun00','aaaa','2024-05-22 01:30:59',1),(9,'ssafy','boeun00','1234','2024-05-22 01:36:40',1),(10,'ssafy','boeun00','1234','2024-05-22 01:37:08',1),(11,'ssafy','boeun00','1234','2024-05-22 01:39:09',1),(13,'ssafy','boeun00','asdad','2024-05-22 01:46:24',1),(14,'ssafy','boeun00','sadasd','2024-05-22 01:59:10',1),(15,'ssafy','boeun00','123123','2024-05-22 01:59:28',1),(16,'ssafy','boeun00','asdasd','2024-05-22 02:00:02',1),(17,'ssafy','boeun00','asdasdas','2024-05-22 02:01:17',0),(19,'ssafy','boeun00','sadasdasd','2024-05-22 02:01:36',0),(20,'boeun00','ssafy','asdasd','2024-05-22 02:18:51',1),(21,'ssafy','boeun00','123123','2024-05-22 02:21:09',0),(22,'ssafy','boeun00','asdasdasdas','2024-05-22 02:21:43',0),(23,'ssafy','boeun00','asdasd','2024-05-22 02:25:03',0),(24,'ssafy','boeun00','asd','2024-05-22 02:25:11',0),(25,'boeun00','ssafy','sdfasdasdasf','2024-05-22 03:52:29',1),(26,'boeun00','ssafy','asdasd','2024-05-22 03:52:38',1),(27,'ssafy','boeun00','asdas','2024-05-22 03:53:19',0),(28,'ssafy','boeun00','asdasd','2024-05-22 04:10:58',0),(29,'boeun00','ssafy','asdasda','2024-05-22 04:11:16',1),(30,'boeun00','ssafy','asdasdasdasd','2024-05-22 04:11:31',0),(31,'boeun00','ssafy','sdfsdf','2024-05-22 04:13:27',1),(32,'boeun00','ssafy','123123','2024-05-22 04:13:53',0),(33,'ssafy','boeun00','sdasdasd','2024-05-22 04:34:10',0),(34,'boeun00','ssafy','asdasd','2024-05-22 04:34:28',1),(35,'boeun00','ssafy','asdasd','2024-05-22 04:34:36',0),(36,'ssafy','boeun00','안녕??','2024-05-22 05:08:44',0),(37,'ssafy','boeun00','안녕하세요 반가워요','2024-05-22 06:01:03',0),(38,'ssafy','boeun00','rrrr\n','2024-05-22 06:01:27',0),(39,'ssafy','boeun00','dsfasdasd','2024-05-22 06:01:43',0),(40,'ssafy','boeun00','asdasdas','2024-05-22 06:01:47',1),(41,'ssafy','boeun00','ssafy님이 조깅 모임에 가입신청을 했습니다.','2024-05-22 14:00:58',1),(42,'boeun00','ssafy','안녕하세요','2024-05-22 16:07:30',1),(43,'boeun00','ssafy','ㅎㅇ','2024-05-22 16:16:48',0),(44,'boeun00','ssafy','안녕','2024-05-23 03:44:47',1),(45,'ssafy','ssafy','ssafy님이 대전 맛집 탐방에 가입신청을 했습니다.','2024-05-23 05:53:31',0),(46,'ssafy','boeun00','하니','2024-05-23 06:02:32',0),(47,'boeun00','ssafy','하이','2024-05-23 06:02:37',1),(48,'ssafy','boeun00','안녕','2024-05-23 06:02:52',1),(49,'ssafy','boeun00','하이','2024-05-23 06:32:39',1),(50,'ssafy','boeun00','안녕','2024-05-23 06:32:48',1),(51,'ssafy','ssafy','ssafy님이 대전 맛집 탐방에 가입신청을 했습니다.','2024-05-23 06:42:51',1),(52,'boun00','myhee','boun00님이 1일 1알고리즘에 가입신청을 했습니다.','2024-05-23 13:29:47',0),(53,'boeun00','myhee','boeun00님이 1일 1알고리즘에 가입신청을 했습니다.','2024-05-23 13:34:30',1),(54,'boeun00','myhee','boeun00님이 1일 1알고에 가입신청을 했습니다.','2024-05-23 13:36:10',1),(55,'boeun00','myhee','안녕 희야\n나 은이야\n우리 알고리즘 열심히 하자!!','2024-05-23 13:37:15',1);
/*!40000 ALTER TABLE `chat_messages` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-24  0:46:08
