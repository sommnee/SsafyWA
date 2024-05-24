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
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review` (
  `id` int NOT NULL AUTO_INCREMENT,
  `writer` varchar(30) DEFAULT NULL,
  `title` varchar(30) DEFAULT NULL,
  `content` text,
  `place_id` int DEFAULT NULL,
  `likes` int DEFAULT '0',
  `dateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `image_url` varchar(10000) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `place_id` (`place_id`),
  CONSTRAINT `review_ibfk_1` FOREIGN KEY (`place_id`) REFERENCES `place` (`place_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
INSERT INTO `review` VALUES (1,'ssafy','공부하기 좋은 카페','자리도 넓고 사람들도 별로 없어 조용한곳 좋아하면 좋을듯 싶습니다.',1352,1,NULL,'https://ssafywabucket.s3.ap-northeast-2.amazonaws.com/3e44f44d-c3cd-4664-913b-24f39bc759d7'),(2,'sommni','브런치 짱맛!!','칭구들이랑 브런치 먹으러 갔는데 기대 이상이었어요!!\n딱 제 취향,, 또 방문 예정!!',1352,0,NULL,'https://ssafywabucket.s3.ap-northeast-2.amazonaws.com/d4c482b9-b0cf-4cac-9ca5-9a47314207a6'),(3,'zzzzuu','사람 많은 곳은 이유가 있네요','너무 맛있고 분위기도 좋았습니다!!\n공부하시는 분들도 계셨는데 모두에게 좋은 카페일듯',1352,3,NULL,'https://ssafywabucket.s3.ap-northeast-2.amazonaws.com/1b5e1282-0cdc-46e6-b1a6-fb6fe882e380'),(4,'hoonhoon','밤에 가니 분위기가 또 다름','낮에 갔다가 반해서 다음에는 밤에 갔는데 분위기가 좋았습니다!!',1352,0,NULL,'https://ssafywabucket.s3.ap-northeast-2.amazonaws.com/5e0b8124-e47b-40c2-af74-96c7abd95621'),(5,'booboo','맛있었습니다!!','점심에 가기 딱 좋은 것 같아요!!\n굿굿!!',1352,0,NULL,'https://ssafywabucket.s3.ap-northeast-2.amazonaws.com/2f2fffdf-f443-497c-b1e4-c8a5781a5ead');
/*!40000 ALTER TABLE `review` ENABLE KEYS */;
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
