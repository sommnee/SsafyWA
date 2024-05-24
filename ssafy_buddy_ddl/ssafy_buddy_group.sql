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
-- Table structure for table `group`
--

DROP TABLE IF EXISTS `group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `group_name` varchar(45) NOT NULL,
  `type` varchar(45) NOT NULL,
  `group_owner` varchar(30) NOT NULL,
  `recruit_max_number` int NOT NULL,
  `region` varchar(45) NOT NULL,
  `is_online` varchar(50) NOT NULL,
  `is_recruiting` tinyint(1) NOT NULL,
  `content` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `group_to_owner_foreignKey_idx` (`group_owner`),
  CONSTRAINT `group_to_owner_foreignKey` FOREIGN KEY (`group_owner`) REFERENCES `member` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=935 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group`
--

LOCK TABLES `group` WRITE;
/*!40000 ALTER TABLE `group` DISABLE KEYS */;
INSERT INTO `group` VALUES (1,'유성온천 알고리즘 스터디','스터디','ssafy',5,'대전','오프라인',0,'다양한 알고리즘 개념에 대해 공부하고 여러 알고리즘 문제들을 다같이 풀어보아요'),(2,'조깅 모임','운동','boeun00',3,'서울','오프라인',0,'같이 주말에 조깅 하실분들 구합니다!!'),(3,'대전 맛집 탐방','맛집','ssafy',4,'대전','오프라인',0,'대전에 있는 여러 맛집들을 같이 다니면서 맛있는 음식들 같이 즐겨요!!'),(4,'한밭 알고 가즈아','스터디','boun00',4,'대전','오프라인',0,'알고리즘 문제 같이 풀면서 알고리즘 실력을 늘려보아요!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'),(232,'감시자들','etc','ggomjiu',6,'부울경','온라인',0,'서로 공부하는 것을 관리하며 열심히 지내실 분들 구합니다!!'),(308,'양말 같이 사용','공동구매','wxogud3377',5,'대전','온라인',0,'양말 20개 5천원 공동구매 찾아서 올립니다!! 배송비는 3천원입니당~~'),(379,'너나친?','친목','yjw963',6,'대전','오프라인',1,'대전에 친구가 없어서 같이 우정을 다지며 지내실 분들 구합니다.. 이상한 사람 아닙니다..... 한밭대에서 자취 중!!'),(439,'일본 곤약 젤리 공동구매','공동구매','dw8870',9,'서울','온라인',0,'반에 곤약 젤리 간식으로 놓을 예정입니다!! 반장/CA분들 중에서 같이 구매하실 분들 저렴하게 같이 해용!!'),(517,'국밥 뿌시자','맛집','anijam12',3,'광주','온라인',1,'국밥러버들과 함께 광주의 국밥들을 찾아 먹고 싶습니다. 렛츠고'),(697,'필라테스가보자고','운동','fkdlsvlrtu',4,'광주','오프라인',1,'같이 그룹 필라테스를 하며 돈 아껴요!! 자세 안 좋은 공대생들에겐 딱 좋을겁니다!!'),(698,'비전공자 CS 스터디','스터디','yjw963',10,'구미','오프라인',0,'면접 대비 CS 공부하며 겸사겸사 면접 준비도 같이 해요. 평일 싸피 끝나고 오프라인 예상합니다.'),(716,'체력 기르기','운동','qsc7539',8,'대전','오프라인',0,'기초 체력부터 같이 기르며 오래 건강하게 공부 같이 하실 분 구합니다.'),(776,'대전 맛집 소개','맛집','ukal5006',7,'대전','온라인',1,'맛있는 거 먹으며 같이 힘내실 분들 모여보죠!!!!'),(838,'1일 1알고리즘','스터디','myhee',10,'대전','온라인',0,'지역에 상관없이 1일 1알고리즘을 푸는 스터디 모집합니다!! 같이 문제 선정하고 검사를 받는 방식으로 열심히 해보아용(:'),(932,'정보 공유해용','친목','aswe0409',5,'서울','온라인',0,'다른 지역 친구들과 친해지고 싶어요. 서로 캠퍼스에 대해 이야기하며 오래 우정 다져요~!'),(933,'유온 알고리즘 스터디','스터디','boun00',4,'대전','오프라인',0,'매주 모여서 알고리즘 풀어요!\n문제 정해서 일주일에 6문제 목표로 합시다!!'),(934,'1일 1알고','스터디','myhee',4,'대전','오프라인',0,'알고리즘 실력 향상을 위해 같이 1일 1알고 푸실 분 구합니다!!');
/*!40000 ALTER TABLE `group` ENABLE KEYS */;
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
