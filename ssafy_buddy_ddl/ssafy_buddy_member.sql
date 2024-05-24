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
-- Table structure for table `member`
--

DROP TABLE IF EXISTS `member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member` (
  `user_id` varchar(30) NOT NULL,
  `user_name` varchar(45) NOT NULL,
  `user_password` varchar(45) NOT NULL,
  `user_email` varchar(45) NOT NULL,
  `nick_name` varchar(45) NOT NULL,
  `campus` varchar(45) NOT NULL,
  `refresh_token` text,
  `access_token` text,
  `image_url` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_id_UNIQUE` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member`
--

LOCK TABLES `member` WRITE;
/*!40000 ALTER TABLE `member` DISABLE KEYS */;
INSERT INTO `member` VALUES ('1hyunjin','유현진','1234','1hyunjin@gmail.com','jinnie','대전',NULL,NULL,NULL),('anijam12','조영서','1234','anijam12@gmail.com','babySeo','대전',NULL,NULL,NULL),('aswe0409','정석영','1234','aswe0409@gmail.com','youngrock','구미',NULL,NULL,NULL),('boeun00','boeun','1234','boeun@naver.com','boeun','대전',NULL,NULL,NULL),('boun00','윤보은','1234','boun00@gmail.com','booboo','대전',NULL,NULL,'3797eaec-ef63-4b39-8383-dc0035ea909a'),('dkssudgkgl','방은정','1234','dkssudgkgl@gmail.com','jungie','서울',NULL,NULL,NULL),('dw8870','김도원','1234','dw8870@gmail.com','dodododo','서울',NULL,NULL,NULL),('fkdlsvlrtu','정경원','1234','fkdlsvlrtu@gmail.com','wonnie','대전','eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJyZWZyZXNoLXRva2VuIiwiaWF0IjoxNzE2NDY2MTc2LCJleHAiOjE3MTY0NzMzNzYsInVzZXJJZCI6ImZrZGxzdmxydHUifQ.HjR3PGuMt4DLd3tw9grmrmeOh0YIbwE2T16aeBSu2Qc',NULL,NULL),('ggomjiu','라송연','1234','ggomjiu@gmail.com','orangerRAS','대전','eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJyZWZyZXNoLXRva2VuIiwiaWF0IjoxNzE2NDY4MTAxLCJleHAiOjE3MTY0NzUzMDEsInVzZXJJZCI6Imdnb21qaXUifQ.kIJQ7LIKtLuzf-p1B8fS7Ta9klRIHW6NzPYBRRHKxIM',NULL,NULL),('hoonie','한지훈','1234','hoon1231@gmail.com','hoonhoon','대전',NULL,NULL,NULL),('minjibb99','박민지','1234','minjibb99@gmail.com','mingming','구미',NULL,NULL,NULL),('myhee','이주희','1234','zzzzuu@naver.com','zzzzuu','대전','eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJyZWZyZXNoLXRva2VuIiwiaWF0IjoxNzE2NDcxMjUyLCJleHAiOjE3MTY0Nzg0NTIsInVzZXJJZCI6Im15aGVlIn0.f_v-kzX852uDo4r0jL-kXT8i_vnUPjamibj7DKgqNW0',NULL,'0af1c989-a3fc-4824-8668-73af20ee4bdd'),('pcs1265','박찬수','1234','pcs1265@gmail.com','coldWater','구미',NULL,NULL,NULL),('qqa108','최용훈','1234','qqa108@gmail.com','realHoon','대전','eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJyZWZyZXNoLXRva2VuIiwiaWF0IjoxNzE2NDY2MTU0LCJleHAiOjE3MTY0NzMzNTQsInVzZXJJZCI6InFxYTEwOCJ9.C9eIBM6O0KRyEJRl0h4NdFoQOdoyAAB3I1BK6p-vM0U',NULL,NULL),('qsc7539','김용원','1234','qsc7539@gmail.com','kimyongwon','광주',NULL,NULL,NULL),('realHoon','치옹훈','1234','princeHoon@example.com','princeHoon','대전','eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJyZWZyZXNoLXRva2VuIiwiaWF0IjoxNzE2NDY1NjA5LCJleHAiOjE3MTY0NzI4MDksInVzZXJJZCI6InJlYWxIb29uIn0.y3ZckZBviOihLLcYih-GTHXERG4TUZoit2zdWogZlP4',NULL,NULL),('roista57','김종원','1234','roista57@gmail.com','kimjong','서울','eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJyZWZyZXNoLXRva2VuIiwiaWF0IjoxNzE2NDY1NjcxLCJleHAiOjE3MTY0NzI4NzEsInVzZXJJZCI6InJvaXN0YTU3In0.0A1Ra-_BO26eqpzqk5nS3HNx5Ol00eThCiIEd0oUvP0',NULL,NULL),('seoul','seoul','Dbsqhdms00!!','seoul@naver.com','seoul','서울',NULL,NULL,NULL),('sommni','sommni','Dbsqhdms00!!','sommni@gmail.com','sommni','대전',NULL,NULL,NULL),('ssafy','ssafy','1234','ssafy@naver.com','ssafy','대전','eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJyZWZyZXNoLXRva2VuIiwiaWF0IjoxNzE2NDYzMTM3LCJleHAiOjE3MTY0NzAzMzcsInVzZXJJZCI6InNzYWZ5In0.eU2wSFBAZs33a_4TLz7iJbg0X0LtiEu_t_rI6cwoyAo',NULL,'fdc7886e-252e-4a91-9c78-06d5c3d142e4'),('ukal5006','이용성','1234','ukal5006@gmail.com','dragon_castle','대전',NULL,NULL,NULL),('wlsdud6221','오진영','1234','wlsdud6221@gmail.com','ohgeegee','광주',NULL,NULL,NULL),('wxogud3377','최태민','1234','wxogud3377@gmail.com','minnie','대전',NULL,NULL,NULL),('yjw963','양종원','1234','yjw963@gmail.com','yangjong','서울','eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJyZWZyZXNoLXRva2VuIiwiaWF0IjoxNzE2NDY2MTMzLCJleHAiOjE3MTY0NzMzMzMsInVzZXJJZCI6Inlqdzk2MyJ9.HTqfWQuMAwD4EqLr-QmmwLR4jytzQy0ZUc_uv4ybAGM',NULL,NULL);
/*!40000 ALTER TABLE `member` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-24  0:46:09
