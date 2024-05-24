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
-- Table structure for table `board`
--

DROP TABLE IF EXISTS `board`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `board` (
  `id` int NOT NULL AUTO_INCREMENT,
  `category` int NOT NULL,
  `content` text NOT NULL,
  `title` varchar(45) NOT NULL,
  `writer` varchar(30) NOT NULL,
  `write_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `read_count` int NOT NULL,
  `like_count` int NOT NULL,
  `comment_count` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `boardwriter_user_id_foreignkey_idx` (`writer`),
  CONSTRAINT `boardwriter_user_id_foreignkey` FOREIGN KEY (`writer`) REFERENCES `member` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `board`
--

LOCK TABLES `board` WRITE;
/*!40000 ALTER TABLE `board` DISABLE KEYS */;
INSERT INTO `board` VALUES (1,1,'<p>안녕하세요 처음 입과하게 되었습니다.</p>\n<blockquote>\n<p>반갑습니당 ㅎㅎ</p>\n</blockquote>\n<h1>잘부탁드려요</h1>\n','안녕하세요','ssafy','2024-05-20 16:45:23',30,0,3),(2,1,'<p>제발 알려주세요 ㅠㅠㅠ\n<img src=\"http://localhost:8080/image/print?filename=bc5dfa1431354cad8fb8b769bdeb26b0..jpeg\" alt=\"image alt attribute\"></p>\n','오늘 점심 아시는분??','ssafy','2024-05-20 16:54:10',18,0,2),(3,1,'<p>노트북이 필요합니다.\n노트북 추천해주실 분들 있으신가요\n<img src=\"http://localhost:8080/image/print?filename=19751d23ed724d1195a512f00a956603..JPG\" alt=\"image alt attribute\"></p>\n','노트북 추천해주세요','boeun00','2024-05-21 01:42:27',15,0,0),(5,1,'<p>대전 맛집있나요? \n있으면 추천해주세요 \n이런 맛집을 원해요</p>\n<ul>\n<li><input disabled=\"\" type=\"checkbox\"> 한식</li>\n<li><input disabled=\"\" type=\"checkbox\"> 가성비</li>\n<li><input disabled=\"\" type=\"checkbox\"> 굿굿</li>\n</ul>\n','대전 맛집 추천 좀','ssafy','2024-05-21 13:54:26',0,0,0),(6,3,'<p>이케아에서 새로 샀는데 제 방에는 너무 작아서 급처합니다!!\n직접 보러 오셔도 됩니다!!</p>\n<p><a href=\"https://sofsys.co.kr/product/detail.html?product_no=6291&gad_source=1&gclid=Cj0KCQjw6auyBhDzARIsALIo6v9PDAEu060slg0gA4I1KmOsugD3U3457b3Jg52kWnlYOTQm3Zve-DsaAqTwEALw_wcB\">https://sofsys.co.kr/product/detail.html?product_no=6291&amp;gad_source=1&amp;gclid=Cj0KCQjw6auyBhDzARIsALIo6v9PDAEu060slg0gA4I1KmOsugD3U3457b3Jg52kWnlYOTQm3Zve-DsaAqTwEALw_wcB</a></p>\n<p>여기서 구매하였는데 2만원에 거래합니다~!\n댓글 달아주세용!!</p>\n','새 책상 팝니다','ssafy','2024-05-21 13:57:05',4,0,0),(7,3,'<p>협의 가능</p>\n','윤보은 판매 중','ssafy','2024-05-21 13:57:31',3,0,1),(8,4,'<p>과락하기 싫습니당 ㅜㅜ</p>\n','관통 합격 점수 몇점인가요??','ssafy','2024-05-21 13:58:24',0,0,0),(9,1,'<p>아가라구용~</p>\n','아 가라고요 !!!!!!!!!!!!','ssafy','2024-05-21 14:00:05',5,0,1),(12,4,'<p>아 이제 괜찮아요</p>\n','긴급) 유온 근처 화장실좀요 빨리','ssafy','2024-05-21 14:03:57',5,0,1),(13,5,'<p>다들 강의장 밖으로 나오지 마세요</p>\n','긴급) wildboar 싸피에 출현','ssafy','2024-05-21 14:04:47',4,0,1),(17,2,'<p>우리 캠퍼스 근처에서 밥먹으려는데 맛집 어딘지 아시나요??</p>\n','우리 캠퍼스 주변 맛집 추천해주세요','ssafy','2024-05-23 14:32:16',1,0,0),(18,5,'<h1>:cat_clap: 【컴투스】 채용설명회 링크 안내</h1>\n<p>:kirby_dance: 안녕하세요! SSAFY취업지원센터입니다. 금일 진행하는 SSAFY 채용설명회를 안내드립니다 @all :kirby_bounce_rainbow:</p>\n<h4>:godstar: 【컴투스】 MLB 9이닝스, 컴투스프로야구, 낚시의 신, 타이니팜 등 대한민국 최초 모바일게임 개발 전문 기업(코스닥상장)</h4>\n<p>일정 : 5.21(화) 11:30~12:10</p>\n<p>채용분야 : 클라이언트 및 서버 (C++, C#, OS,DS, DB, 알고리즘,네트워크)</p>\n<p>&lt;클라이언트&gt; -게임 클라이언트 컨텐츠 개발 및 유지보수 -게임 제작 툴 개발</p>\n<p>&lt;서버&gt; -게임 서버 컨텐츠개발 -게임 서비스 운영 툴 개발 및 서버기술 R&amp;D</p>\n<h4>:godstar: [설명회 참여 방법]</h4>\n<ul>\n<li>모바일 접속 링크 : <a href=\"https://youtu.be/z1pGt5nsioA\">https://youtu.be/z1pGt5nsioA</a></li>\n</ul>\n<p>※ 익일 오전 9시까지 스트리밍 유지 *질의 응답은 유튜브 채팅창을 통해 진행됩니다. 말머리에 [기수, 지역, 반]을 달아서 채팅을 남겨주세요.</p>\n<p>잠시 후에 뵙겠습니다!</p>\n','【컴투스】 채용설명회 안내','ssafy','2024-05-23 16:37:45',2,0,0),(19,5,'<p>@all </p>\n<h1>[ SSAFY Job Fair 안내 ] :</h1>\n<hr>\n<p>다가오는 6월, SSAFY 人만의, SSAFY 人만을 위한, SSAFY 人에 의한 Job Fair가 진행될 예정입니다. \n모든 채용전형의 취업스킬을 업그레이드 시킬 수 있는 취업 특강부터 \n우수 IT기업을 직접 찾아가보는 기업탐방, 삼성 및 우리 권역 선배의 멘토링까지! \n맞춤형으로 제공되어지는 다양한 취업컨텐츠를 놓치지 말고 받아보세요!</p>\n<p>Job Fair 스케줄 확인</p>\n<ul>\n<li>Job Fair 기간 : 6.10(월) ~ 6.19(수)</li>\n<li>프로그램 : 온라인 취업특강, 삼성임직원멘토링, 수료생멘토링, 기업탐방, 채용박람회</li>\n<li>세부일정표 확인 : Job.SSAFY &gt; 공지사항 &gt; [공지] 24년 상반기 Job Fair 안내</li>\n</ul>\n<p>취업특강 - OPIc 분반을 위한 사전설문 안내</p>\n<ul>\n<li>링크 : [<a href=\"https://forms.gle/DcaeYD6XaAmbSVmGA\">https://forms.gle/DcaeYD6XaAmbSVmGA</a>]</li>\n<li>제출기한 : 5.26(일) 23:59 (미응답시 임의로 분반됩니다)</li>\n</ul>\n','SSAFY Job Fair 안내','ssafy','2024-05-23 16:38:49',7,3,1),(20,5,'<h1>5/24(금) 중식시간 안내</h1>\n<p>익일 관통프로젝트 경진대회로 인한 중식시간 변경 안내드립니다.</p>\n<p>1 ~ 4반 : 12:40 ~ 14:00\n5 ~ 8반 : 12:30 ~ 14:00</p>\n','5/24(금) 중식시간 안내 ','ssafy','2024-05-23 16:45:55',19,2,2),(21,5,'<h1>캠퍼스 내 배드민턴, 캐치볼 등 기타 스포츠 활동 금지입니다.</h1>\n<p>연수원은 교육을 위한 공간이며, 외부 교육 과정으로 인한 외부인 출입이 잦습니다.\n따라서 해당 내용 참고하여 준수해주시길 바랍니다.</p>\n','스포츠 활동 금지','ssafy','2024-05-23 16:46:33',4,0,2),(22,5,'<h3>[멘토링 간담회 신청 /★금일 마감★]</h3>\n<p>안녕하세요 여러분 :pinksmile: \n연휴 잘 보내셨나요?</p>\n<p>1학기가 마무리 되어감에 따라\n멘토링 간담회도 이번이 마지막 기회인데요</p>\n<p>2학기 프로젝트는 어떻게 방향을 잡으면 좋을지, \n방학 기간 동안 어떤 걸 보충하고 준비하면 좋을지,\n하반기 공채까지 포트폴리오를 어떻게 보충하고 준비하면 좋을지 등</p>\n<p>1시간의 간담회 동안 알찬 하반기를 보낼 수 있는 꿀팁을 많이 얻어가실 수 있을거라 생각합니다 =)\nSSAFY 교육생만을 위한 마지막 기회 놓치지 마세요!</p>\n','멘토링 간담회 신청 ★금일 마감★','ssafy','2024-05-23 16:47:37',9,1,0),(23,4,'<h1>아직 기다리는 중인데.....</h1>\n','대전 5호차 현충원역 지나갔나요?','qqa108','2024-05-23 16:58:19',6,1,1),(24,1,'<p>헉진짜요\n<img src=\"http://localhost:8080/image/print?filename=e9ab56dc7a754e69aac0f9b9aeaf3696..png\" alt=\"image alt attribute\"></p>\n<h2>정말알고싶던정보엿어요</h2>\n<p><img src=\"http://localhost:8080/image/print?filename=ed2b6215a2ea4988afe523c0ca419223..png\" alt=\"image alt attribute\"></p>\n','와정말요','yjw963','2024-05-23 17:03:51',9,0,1),(25,2,'<p>캠퍼스 근처에 가장 큰 카페가 어디인가??? 너무 궁금해요.\n큰 카페를 찾습니다. </p>\n','캠퍼스 근처 가장 큰 카페','myhee','2024-05-23 21:23:07',0,0,0),(26,2,'<p>걸어가다가 출구 근처에서 떨어진것 같아요 제발요</p>\n<h4>지갑 찾으신분 있으시면 쪽지 부탁드립니다!!!</h4>\n','오늘 역삼역 3번 출구에서 지갑 보신분 있나요?','yjw963','2024-05-23 21:26:05',1,0,0),(27,4,'<p>혹시 선배님들 중 자소서 첨삭 도와주실 분들 계신가요??</p>\n<h3>부탁드립니다. 있으시면 쪽지 부탁드려요</h3>\n<p><img src=\"http://localhost:8080/image/print?filename=f68cb2bfb67a47f0a6b4f76b187f6d95..jpeg\" alt=\"image alt attribute\"></p>\n','선배님들 자소서 첨삭 받고 싶습니다','fkdlsvlrtu','2024-05-23 21:29:08',1,0,1),(28,0,'<p>오늘 하루종일 뭐한지 모르겠음....</p>\n<blockquote>\n<p>다들 잘하는데 나만 뭐하는지 모르겠음.....</p>\n</blockquote>\n','오늘 집중이 너무 안된다....','fkdlsvlrtu','2024-05-23 21:30:33',3,2,2),(29,3,'<p>휴지가 너무 많아서 처리불가능이네요\n휴지 나눔합니다.\n댓글 선착순으로 드릴게요 </p>\n<h1>한밭대 근처에서 나눔할게요!!</h1>\n<p><img src=\"http://localhost:8080/image/print?filename=5fb32989edc94cf38b2846ac3bbaaeaf..jpeg\" alt=\"image alt attribute\"></p>\n','휴지를 잘못 시켜서 휴지 나눔합니다.','qqa108','2024-05-23 21:33:03',2,0,1),(30,3,'<p>혹시 필요없으신 분들 없나요??\n가격 맞춰드릴게요~~~</p>\n','노트북 거치대 구합니다.','boun00','2024-05-23 21:33:52',1,0,1),(31,4,'<p>면접 분위기좀 알려주세요~~</p>\n','SDS다니시는 선배님들 계신가요??','boun00','2024-05-23 21:35:09',4,3,1),(32,3,'<p>3달 정도 사용했습니다. 생각있으신 분들 댓글 달아주세요~~</p>\n','아이패드 에어4 거래합니다','boun00','2024-05-23 21:36:15',1,1,0),(33,1,'<p>오늘도 다같이 화이팅 합시다!!!\n<img src=\"http://localhost:8080/image/print?filename=99fc1b0bf1d34c7f9c60865ca81fb0da..jpg\" alt=\"image alt attribute\"></p>\n','오늘도 화이팅!!','ggomjiu','2024-05-23 21:43:25',4,2,0),(34,1,'<p>1위 물고기자리\n2위 게자리\n3위 전갈자리\n4위 황소자리\n5위 처녀자리\n6위 염소자리\n7위 양자리\n8위 사자자리\n9위 사수자리\n10위 쌍둥이자리\n11위 천칭자리\n12위 물병자리</p>\n','오늘의 별자리 순위','ggomjiu','2024-05-23 21:46:46',19,6,3),(35,1,'<p>시간이 참 빠르네요\n모두 고생하셨습니다!!\n다들 방학 잘 보내시고 2학기에 만나요</p>\n<h1>대전 8반 짱짱</h1>\n<p><img src=\"http://localhost:8080/image/print?filename=fb9844e27b8743bb89132c8780138760..jpg\" alt=\"image alt attribute\"></p>\n','모두들 한 학기 동안 고생 많았습니다','qqa108','2024-05-23 21:58:54',43,6,4),(36,1,'<h1>8반 앞으로도 우리 영원히 함께!!</h1>\n<blockquote>\n<p>수고했다 오늘도..</p>\n</blockquote>\n<p><img src=\"http://localhost:8080/image/print?filename=b51830496bea4bda8c23391a635a0f17..png\" alt=\"image alt attribute\"></p>\n','우리 8반 1학기 너무 고생했어요!!','boun00','2024-05-23 22:27:41',1,0,0);
/*!40000 ALTER TABLE `board` ENABLE KEYS */;
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
