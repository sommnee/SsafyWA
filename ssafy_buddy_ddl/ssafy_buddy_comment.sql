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
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `writer` varchar(30) NOT NULL,
  `board_id` int NOT NULL,
  `content` text NOT NULL,
  `write_date` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `comment_boardid_foreignkey_idx` (`board_id`),
  CONSTRAINT `comment_boardid_foreignkey` FOREIGN KEY (`board_id`) REFERENCES `board` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES (4,'ssafy',1,'반가워요!!!','2024-05-20 17:00:38'),(5,'ssafy',2,'닭갈비요!','2024-05-20 17:03:16'),(6,'ssafy',2,'설렁탕이요!!!','2024-05-20 17:03:27'),(7,'ssafy',9,'공 주라구요','2024-05-21 14:03:11'),(8,'ssafy',12,'이게 무슨냄새지?','2024-05-21 14:06:10'),(9,'ssafy',13,'헉 감사해요\n','2024-05-22 11:44:47'),(10,'ssafy',7,'저 살래요','2024-05-22 11:45:21'),(11,'ssafy',1,'안녕하세요 반가워용','2024-05-23 15:43:37'),(12,'aswe0409',1,'오이 하이\n','2024-05-23 16:12:30'),(13,'qqa108',19,'좋은 정보 감사합다~~','2024-05-23 17:10:13'),(14,'boun00',23,'헐 아까 지나갔어요','2024-05-23 17:11:18'),(15,'yjw963',21,'넵 알겠습니다!','2024-05-23 21:04:04'),(16,'aswe0409',24,'?','2024-05-23 21:10:39'),(17,'boun00',34,'오 나 3등이다','2024-05-23 21:47:40'),(18,'ggomjiu',34,'아 나 10등 뭐임?','2024-05-23 21:48:06'),(19,'qqa108',34,'반타작 했네 ㅋ','2024-05-23 21:48:30'),(20,'aswe0409',30,'얼마 정도 생각하세요?','2024-05-23 21:51:09'),(21,'aswe0409',27,'저도....','2024-05-23 21:51:28'),(22,'aswe0409',28,'아자아자!!!!!!!!!!!!!!!!!!!!! 힘내자!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!','2024-05-23 21:51:49'),(23,'aswe0409',21,'헉..','2024-05-23 21:52:05'),(24,'hoonie',29,'저요!','2024-05-23 21:52:38'),(25,'boun00',28,'힘내자 친구야','2024-05-23 21:53:10'),(26,'boun00',20,'오마이갓','2024-05-23 21:54:00'),(27,'qqa108',20,'안돼..................................................................................','2024-05-23 21:54:25'),(28,'myhee',35,'사랑사랑','2024-05-23 22:00:00'),(29,'fkdlsvlrtu',35,'고생하셨습니다','2024-05-23 22:00:12'),(30,'boun00',35,'형님뿐','2024-05-23 22:00:42'),(31,'boun00',35,'2학기때 봅시당!!','2024-05-23 22:25:06'),(32,'boun00',31,'저도 궁금합니다..!!','2024-05-23 22:26:19');
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
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
