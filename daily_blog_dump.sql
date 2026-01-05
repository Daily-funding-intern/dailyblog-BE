CREATE DATABASE  IF NOT EXISTS `daily_blog` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `daily_blog`;
-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: daily_blog
-- ------------------------------------------------------
-- Server version	8.0.44

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
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add category',7,'add_category'),(26,'Can change category',7,'change_category'),(27,'Can delete category',7,'delete_category'),(28,'Can view category',7,'view_category'),(29,'Can add post',8,'add_post'),(30,'Can change post',8,'change_post'),(31,'Can delete post',8,'delete_post'),(32,'Can view post',8,'view_post');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$260000$dteWiwErcZrjLYuzQ7WjWr$P4u1qucVWBsJ2MFmp0CpBqwaLRxItEs8fIJkcuffjjE=','2026-01-05 00:15:58.992032',1,'wonbin','','','wonbin@example.com',1,1,'2025-12-30 23:56:51.719513');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_category`
--

DROP TABLE IF EXISTS `blog_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blog_category` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_category`
--

LOCK TABLES `blog_category` WRITE;
/*!40000 ALTER TABLE `blog_category` DISABLE KEYS */;
INSERT INTO `blog_category` VALUES (1,'데일리 ON AIR'),(2,'데일리언의 수다'),(3,'USER TALK'),(4,'데일리 랩스'),(5,'데일리 컬쳐'),(6,'데일리 칼럼'),(7,'데일리 가이드');
/*!40000 ALTER TABLE `blog_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_post`
--

DROP TABLE IF EXISTS `blog_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blog_post` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `subtitle` varchar(100) NOT NULL,
  `content` longtext NOT NULL,
  `description` longtext NOT NULL,
  `thumbnail` varchar(255) NOT NULL,
  `is_featured` tinyint(1) NOT NULL,
  `category_id` bigint NOT NULL,
  `created_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `blog_post_category_id_c326dbf8_fk_blog_category_id` (`category_id`),
  CONSTRAINT `blog_post_category_id_c326dbf8_fk_blog_category_id` FOREIGN KEY (`category_id`) REFERENCES `blog_category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_post`
--

LOCK TABLES `blog_post` WRITE;
/*!40000 ALTER TABLE `blog_post` DISABLE KEYS */;
INSERT INTO `blog_post` VALUES (3,'테스트１','부제목','<p>테스트</p>','요약2','https://static1.squarespace.com/static/66ec3b49803ab81bf84f89e4/66ec3b69bf61a73d71744826/66eca14ee7ad767297ce31d4/1734296092801/?format=1500w',0,1,'2025-12-29 05:45:52.972649'),(4,'테스트２','부제목','<p>테스트</p>','요약2','https://static1.squarespace.com/static/66ec3b49803ab81bf84f89e4/66ec3b69bf61a73d71744826/66eca14ee7ad767297ce31d4/1734296092801/?format=1500w',1,1,'2025-12-29 05:45:52.972649'),(6,'테스트３','부제목','<p>테스트</p>','요약2','https://static1.squarespace.com/static/66ec3b49803ab81bf84f89e4/66ec3b69bf61a73d71744826/66eca14ee7ad767297ce31d4/1734296092801/?format=1500w',1,1,'2025-12-29 05:45:52.972649'),(7,'테스트４','부제목','<p>테스트</p>','테스트','https://daily-intern.s3.ap-northeast-2.amazonaws.com/thumbnails/4d5ecb0b5e444e6e9e7d50a82d293b31.png',1,1,'2025-12-29 05:45:52.972649'),(8,'테스트５','부제목','<p>테스트</p>','테스트','https://daily-intern.s3.ap-northeast-2.amazonaws.com/thumbnails/9f14b33d2cbb4096ab70291cb6e540dd.png',1,1,'2025-12-29 05:45:52.972649'),(9,'테스트６','부제목','<p>테스트</p>','요약2','https://static1.squarespace.com/static/66ec3b49803ab81bf84f89e4/66ec3b69bf61a73d71744826/66eca14ee7ad767297ce31d4/1734296092801/?format=1500w',0,1,'2025-12-29 05:45:52.972649'),(10,'테스트７','부제목','<p>테스트</p>','테스트','https://daily-intern.s3.ap-northeast-2.amazonaws.com/thumbnails/5abfacdfab68462b92a576584089063e.png',1,1,'2025-12-29 05:45:52.972649'),(11,'테스트８','부제목','<p>테스트</p>','테스트','https://daily-intern.s3.ap-northeast-2.amazonaws.com/thumbnails/78b38409ff434f1ba1b9a9da094feb6e.png',1,4,'2025-12-29 05:45:52.972649'),(18,'고객과 서비스를 연결하는 프런트엔드의 역할, 잊지 않을게요','[데일리펀딩 체험기] 인턴 개발자 안다빈님','<p><em>새로운 세상에 처음 발 내디딜 때, 누군가와 함께하느냐가 한 사람의 시선과 가치관에 큰 영향을 미치곤 합니다. IT실의 인턴 개발자 안다빈님은 고객에게 어떤 서비스 가치를 전달할지 고민하는 데일리언과 그 시작을 함께했는데요. 긍정적인 고객 경험을 전달하기 위해 상호 소통하며 플랫폼의 미래를 그리는 데일리언의 모습은 다빈님에게 강렬한 흔적을 남겼다고 합니다.</em></p><img src=\"https://daily-intern.s3.ap-northeast-2.amazonaws.com/posts/28309f59820d416399803e5192fffaa6_tmp/uploads/01aeb8967bb047f1b8b1f3d9fda1b4b2.png\"><p><strong>고객과 직접 맞닿는 프런트엔드에 매력 느껴</strong></p><p><strong>실무 익히며 브랜드 이미지에도 기여하리라 기대해</strong></p><p>삶을 편안함과 즐거움으로 채워 주고, 누군가의 상상력을 응원하는 것. 이는 IT 산업의 존재 가치이자 본질입니다. 인턴 개발자 안다빈님은 사람들에게 행복을 전하는 IT 분야를 업으로 삼고 싶어 프로그래밍 언어에 관심을 가지게 됐습니다. 특히 고객과 직접 맞닿는 프런트엔드를 경험하며 꿈을 두텁게 다지고 싶다고 해요.</p><img src=\"https://daily-intern.s3.ap-northeast-2.amazonaws.com/posts/1a1f5b92adc043c88e66d4146d46b509_tmp/uploads/c194c3bd647c4c40a6be1ed7b79995f6.png\"><p></p>','새로운 세상에 처음 발 내디딜 때, 누군가와 함께하느냐가 한 사람의 시선과 가치관에 큰 영향을 미치곤 합니다. IT실의 인턴 개발자 안다빈님은 고객에게 어떤 서비스 가치를 전달할지','https://daily-intern.s3.ap-northeast-2.amazonaws.com/thumbnails/1c1ed8bfec8b483a8c1c3c19e893f544.png',1,2,'2025-12-31 06:17:48.330664'),(20,'뱅킹 앱 없는 투자 생활, \'간편 충전\'이면 가능해요','번거로움 없는 데일리 투자의 시작','<p>56원, 152원, 313원… 소액 분산 투자자님의 ‘내 지갑’에는 매회 1,000원이 안되는 이자가 들어옵니다. 데일리펀딩의 최소 투자 단위는 만 원인지라 조금씩 쌓인 이자를 모아 재투자하기에는 꽤 많은 시간이 소요되고, 그렇다고 가만히 두자니 금융 소득을 얻지 못해 아쉽기만 합니다.</p><p>데일리펀딩의 \'투자금 간편 충전\' 기능은 온투업 가상계좌에 가만히 잠자는 소액 이자를 매일매일 굴리자는 의도에서 출발한 서비스입니다. 계좌에 남은 자투리 이자, 1만원까지 간편하게 채우는 새로운 기능을 소개합니다.</p><img src=\"https://daily-intern.s3.ap-northeast-2.amazonaws.com/posts/cd1189cb472246f187b84067f8285b6f_tmp/uploads/14a8b49f5ec8445b89fd90da63ad92be.png\"><p><strong>하루하루 이자 지급하는 세상인데,</strong></p><p><strong>온투업 가상계좌에 그대로 두면 손해니까요</strong></p><p>온라인투자연계금융업(온투업) 회사에 회원가입할 때 개설하는 가상계좌는 보통의 은행 계좌와 다르다는 것 알고 계신가요? 온투업에는 예∙적금 상품이 없고 오로지 대출∙투자 상품만 존재하는데요. 때문에 가상계좌는 일반 예금계좌와 달리 목돈을 오랫동안 보관하더라도 이자가 발생하지 않습니다. 투자자님이 이자 수익을 얻는 건 오직 투자 수익뿐이에요.</p><img src=\"https://daily-intern.s3.ap-northeast-2.amazonaws.com/posts/6eac25c7927742298e5b6af2e8bd14ed_tmp/uploads/c044f1ccec374043a0d3ed303d9ffe6e.png\"><p></p>','56원, 152원, 313원… 소액 분산 투자자님의 ‘내 지갑’에는 매회 1,000원이 안되는 이자가 들어옵니다. 데일리펀딩의 최소 투자 단위는 만 원인지라 조금씩 쌓인 이자를 모','https://daily-intern.s3.ap-northeast-2.amazonaws.com/thumbnails/c52ce333c06a463bb528ac94c229caea.png',1,1,'2025-12-31 06:25:27.546993'),(21,'신뢰 지키는 테스트와 분석, 금융 개발자의 책임감이에요','[데일리펀딩 체험기] 대학생 인턴 개발자 권세빈님','<p><em>플랫폼 성능과 안정성, 정확한 정보는 금융사가 고객과 맺은 첫 번째 약속이자 서비스 운영의 기초입니다. ‘고객 신뢰’를 브랜드 가치로 삼은 데일리펀딩은 고객이 믿을 만한 서비스와 플랫폼 환경을 제공하기 위해 꾸준히 노력해 왔는데요. 2026년에는 설립 10년차를 맞아 플랫폼을 새단장해 공개할 예정입니다. IT실의 인턴 개발자 권세빈님은 플랫폼 마이그레이션 프로젝트에 적극 참여하며 ‘고객 경험’의 중요성을 깨달았습니다.</em></p><img src=\"https://daily-intern.s3.ap-northeast-2.amazonaws.com/posts/16513eedffa94378aaf2f7b3ef91e286_tmp/uploads/dcb1bbb9ce824b60947d4ae31b81a440.png\"><p><strong>데일리펀딩 핵심 가치 \'신뢰\' 체감한 실무 중심 인턴십</strong></p><p><strong>파편화된 이론 체화하고 올바른 개발 습관 형성해</strong><br>어떤 플랫폼을 이용할 때 서비스 구조를 상상하며 뜯어보는 것은 개발자의 직업병 아닐까 싶습니다. 대학생 개발자 권세빈님도 학부에서 배운 내용을 여러 프로젝트에 적용하며 시시때때로 발동하는 호기심을 채웠습니다. 데일리펀딩 IT실에서 인턴십 활동을 한 세빈님은 4개월간 신생 금융업의 서비스 로직을 경험하고, 현업 중심의 개발이 무엇인지 체감했습니다.</p>','플랫폼 성능과 안정성, 정확한 정보는 금융사가 고객과 맺은 첫 번째 약속이자 서비스 운영의 기초입니다. ‘고객 신뢰’를 브랜드 가치로 삼은 데일리펀딩은 고객이 믿을 만한 서비스와 ','https://daily-intern.s3.ap-northeast-2.amazonaws.com/thumbnails/992880a381494dd5a95c8762b10278b5.png',1,2,'2025-12-31 06:32:03.038581');
/*!40000 ALTER TABLE `blog_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2025-12-30 23:58:22.770828','13','테스트',2,'[{\"changed\": {\"fields\": [\"Content\"]}}]',8,1),(2,'2025-12-30 23:59:56.822769','14','admin 테스트',1,'[{\"added\": {}}]',8,1),(3,'2025-12-31 00:03:54.728950','14','admin 테스트',3,'',8,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(7,'blog','category'),(8,'blog','post'),(5,'contenttypes','contenttype'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2025-12-29 01:32:32.739125'),(2,'auth','0001_initial','2025-12-29 01:32:33.422720'),(3,'admin','0001_initial','2025-12-29 01:32:33.610144'),(4,'admin','0002_logentry_remove_auto_add','2025-12-29 01:32:33.617797'),(5,'admin','0003_logentry_add_action_flag_choices','2025-12-29 01:32:33.625906'),(6,'contenttypes','0002_remove_content_type_name','2025-12-29 01:32:33.705732'),(7,'auth','0002_alter_permission_name_max_length','2025-12-29 01:32:33.790681'),(8,'auth','0003_alter_user_email_max_length','2025-12-29 01:32:33.811958'),(9,'auth','0004_alter_user_username_opts','2025-12-29 01:32:33.821435'),(10,'auth','0005_alter_user_last_login_null','2025-12-29 01:32:33.889531'),(11,'auth','0006_require_contenttypes_0002','2025-12-29 01:32:33.894533'),(12,'auth','0007_alter_validators_add_error_messages','2025-12-29 01:32:33.903235'),(13,'auth','0008_alter_user_username_max_length','2025-12-29 01:32:33.981554'),(14,'auth','0009_alter_user_last_name_max_length','2025-12-29 01:32:34.060915'),(15,'auth','0010_alter_group_name_max_length','2025-12-29 01:32:34.080327'),(16,'auth','0011_update_proxy_permissions','2025-12-29 01:32:34.091232'),(17,'auth','0012_alter_user_first_name_max_length','2025-12-29 01:32:34.173791'),(18,'blog','0001_initial','2025-12-29 01:32:34.295538'),(19,'sessions','0001_initial','2025-12-29 01:32:34.334054'),(20,'blog','0002_rename_summary_post_description','2025-12-29 05:02:30.445893'),(21,'blog','0003_post_created_at','2025-12-29 05:45:52.993885');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('0v7favmhzehytjerttbuibhyny9e5j51','.eJxVjEEOwiAQRe_C2hBGKAMu3fcMZIBBqoYmpV0Z765NutDtf-_9lwi0rTVsnZcwZXERIE6_W6T04LaDfKd2m2Wa27pMUe6KPGiX45z5eT3cv4NKvX5rggGK9tpwNorZxFQ0IhJCUqpY9rZ4p7MFJCpgczo7Yx1F1OSVdYN4fwDlCjew:1vbUko:dWOkBJ8kbz8VP8qNcqxwyA43U6Eplr1eJuA_b4BrJUY','2026-01-16 02:19:02.929111'),('1hwydd76d2e5kx46trw88pbmtqvv32cv','.eJxVjEEOwiAQRe_C2hBGKAMu3fcMZIBBqoYmpV0Z765NutDtf-_9lwi0rTVsnZcwZXERIE6_W6T04LaDfKd2m2Wa27pMUe6KPGiX45z5eT3cv4NKvX5rggGK9tpwNorZxFQ0IhJCUqpY9rZ4p7MFJCpgczo7Yx1F1OSVdYN4fwDlCjew:1vbSfj:M11y-P4Qslk5JhYjKTr9xQsbe_ULIJzd5D6QOHbk460','2026-01-16 00:05:39.412950'),('4tz5nz0wijmpv0f0vs6gk7vm2p77l3zb','.eJxVjEEOwiAQRe_C2hBGKAMu3fcMZIBBqoYmpV0Z765NutDtf-_9lwi0rTVsnZcwZXERIE6_W6T04LaDfKd2m2Wa27pMUe6KPGiX45z5eT3cv4NKvX5rggGK9tpwNorZxFQ0IhJCUqpY9rZ4p7MFJCpgczo7Yx1F1OSVdYN4fwDlCjew:1vbaiX:Fy_VbIwu5xGTEXwQwMfjigdNxpRD6LEQN5Z37mj0h38','2026-01-16 08:41:05.167650'),('4z2zgy22dtaomfyu5sfti4osouxqyyik','.eJxVjEEOwiAQRe_C2hBGKAMu3fcMZIBBqoYmpV0Z765NutDtf-_9lwi0rTVsnZcwZXERIE6_W6T04LaDfKd2m2Wa27pMUe6KPGiX45z5eT3cv4NKvX5rggGK9tpwNorZxFQ0IhJCUqpY9rZ4p7MFJCpgczo7Yx1F1OSVdYN4fwDlCjew:1vbX57:iss1ZGPZjrSp8omcXHNhjCAY9DBG3A0zZHvAS69HnOs','2026-01-16 04:48:09.458647'),('5n08omx7ocews7lo6acqjozx248foxmd','.eJxVjEEOwiAQRe_C2hBGKAMu3fcMZIBBqoYmpV0Z765NutDtf-_9lwi0rTVsnZcwZXERIE6_W6T04LaDfKd2m2Wa27pMUe6KPGiX45z5eT3cv4NKvX5rggGK9tpwNorZxFQ0IhJCUqpY9rZ4p7MFJCpgczo7Yx1F1OSVdYN4fwDlCjew:1vc1eO:bHYQAYOkpX9XbrVKnTP7con2wi48hjg-2f14d-Ha-ko','2026-01-17 13:26:36.697252'),('5o2i3c7q673lbc5owvsiq6zb3mxcz10l','.eJxVjEEOwiAQRe_C2hBGKAMu3fcMZIBBqoYmpV0Z765NutDtf-_9lwi0rTVsnZcwZXERIE6_W6T04LaDfKd2m2Wa27pMUe6KPGiX45z5eT3cv4NKvX5rggGK9tpwNorZxFQ0IhJCUqpY9rZ4p7MFJCpgczo7Yx1F1OSVdYN4fwDlCjew:1vbXjr:9z7LwCW8F0mhqnCftsI67noKhFA9YUHy9wO27NAkwVI','2026-01-16 05:30:15.522220'),('aq5ca0tfmr8k066f4cymu66aj4ixhh6w','.eJxVjEEOwiAQRe_C2hBGKAMu3fcMZIBBqoYmpV0Z765NutDtf-_9lwi0rTVsnZcwZXERIE6_W6T04LaDfKd2m2Wa27pMUe6KPGiX45z5eT3cv4NKvX5rggGK9tpwNorZxFQ0IhJCUqpY9rZ4p7MFJCpgczo7Yx1F1OSVdYN4fwDlCjew:1var3f:oHu_nKSdNKAeyWjID6zFkZjUme6OPoZEqiOWa3d2YSI','2026-01-14 07:55:51.739306'),('aws6vtbyacgs371yolvb7dgzxirkhb6b','.eJxVjEEOwiAQRe_C2hBGKAMu3fcMZIBBqoYmpV0Z765NutDtf-_9lwi0rTVsnZcwZXERIE6_W6T04LaDfKd2m2Wa27pMUe6KPGiX45z5eT3cv4NKvX5rggGK9tpwNorZxFQ0IhJCUqpY9rZ4p7MFJCpgczo7Yx1F1OSVdYN4fwDlCjew:1vba8v:fspObwQgTppzrw7sGlEYfnjFbq16pb_KqKnqCcoemPQ','2026-01-16 08:04:17.993769'),('cpzekqwuqmyegd3xhnx74307xgr0pyx6','.eJxVjEEOwiAQRe_C2hBGKAMu3fcMZIBBqoYmpV0Z765NutDtf-_9lwi0rTVsnZcwZXERIE6_W6T04LaDfKd2m2Wa27pMUe6KPGiX45z5eT3cv4NKvX5rggGK9tpwNorZxFQ0IhJCUqpY9rZ4p7MFJCpgczo7Yx1F1OSVdYN4fwDlCjew:1vbaPO:CNjTdP1pSWRmPeQUFuZN15HmaHszz4jxTnukR3H2TGI','2026-01-16 08:21:18.195300'),('dcc32s8owp09eitchl5dqpxd64mflsio','.eJxVjEEOwiAQRe_C2hBGKAMu3fcMZIBBqoYmpV0Z765NutDtf-_9lwi0rTVsnZcwZXERIE6_W6T04LaDfKd2m2Wa27pMUe6KPGiX45z5eT3cv4NKvX5rggGK9tpwNorZxFQ0IhJCUqpY9rZ4p7MFJCpgczo7Yx1F1OSVdYN4fwDlCjew:1vbVB3:f_7hIWN0fNTxpUZ8SEQ7yNk7YIVdStxWWiw5u90SuTQ','2026-01-16 02:46:09.307829'),('dp244tdqgrwddme5y3kaqed05gkeu2dw','.eJxVjEEOwiAQRe_C2hBGKAMu3fcMZIBBqoYmpV0Z765NutDtf-_9lwi0rTVsnZcwZXERIE6_W6T04LaDfKd2m2Wa27pMUe6KPGiX45z5eT3cv4NKvX5rggGK9tpwNorZxFQ0IhJCUqpY9rZ4p7MFJCpgczo7Yx1F1OSVdYN4fwDlCjew:1vbacZ:290NugHh-l0qW6OxDA1FLlWv8iiVvr577Ufuv56nVQ4','2026-01-16 08:34:55.405542'),('eizliyydkvh990a6i0xn1v9iwhxabkb0','.eJxVjEEOwiAQRe_C2hBGKAMu3fcMZIBBqoYmpV0Z765NutDtf-_9lwi0rTVsnZcwZXERIE6_W6T04LaDfKd2m2Wa27pMUe6KPGiX45z5eT3cv4NKvX5rggGK9tpwNorZxFQ0IhJCUqpY9rZ4p7MFJCpgczo7Yx1F1OSVdYN4fwDlCjew:1vbV9D:elUnNrGom0tBoauTJ2Pqag500D1JA06__6_h7Hh2yZg','2026-01-16 02:44:15.914424'),('fxixtmmkml4kvvrmmbjx62care8khmmt','.eJxVjEEOwiAQRe_C2hBGKAMu3fcMZIBBqoYmpV0Z765NutDtf-_9lwi0rTVsnZcwZXERIE6_W6T04LaDfKd2m2Wa27pMUe6KPGiX45z5eT3cv4NKvX5rggGK9tpwNorZxFQ0IhJCUqpY9rZ4p7MFJCpgczo7Yx1F1OSVdYN4fwDlCjew:1vbaVm:ULC8yefn--KUmfzBwoseNwJTVV8nvd1JMVkFn4cbCdA','2026-01-16 08:27:54.749060'),('h7maugkv3rzjzucohm6ze4dz7bw82z7l','.eJxVjEEOwiAQRe_C2hBGKAMu3fcMZIBBqoYmpV0Z765NutDtf-_9lwi0rTVsnZcwZXERIE6_W6T04LaDfKd2m2Wa27pMUe6KPGiX45z5eT3cv4NKvX5rggGK9tpwNorZxFQ0IhJCUqpY9rZ4p7MFJCpgczo7Yx1F1OSVdYN4fwDlCjew:1vbVGb:64fpZRilzeX6iIUFyPJaLwXLtyrwtCvnsvr1mKKM9sg','2026-01-16 02:51:53.412574'),('iktlxk6n7aeg1e46iyhwekatv89gmkla','.eJxVjEEOwiAQRe_C2hBGKAMu3fcMZIBBqoYmpV0Z765NutDtf-_9lwi0rTVsnZcwZXERIE6_W6T04LaDfKd2m2Wa27pMUe6KPGiX45z5eT3cv4NKvX5rggGK9tpwNorZxFQ0IhJCUqpY9rZ4p7MFJCpgczo7Yx1F1OSVdYN4fwDlCjew:1var7o:7xFXc5hbMu8Kb065gqBQg4Uai1A31jM0VNqyIVw3_FE','2026-01-14 08:00:08.890004'),('jx4ex1gx5shunrvre6vv5anjv4zxoghq','.eJxVjEEOwiAQRe_C2hBGKAMu3fcMZIBBqoYmpV0Z765NutDtf-_9lwi0rTVsnZcwZXERIE6_W6T04LaDfKd2m2Wa27pMUe6KPGiX45z5eT3cv4NKvX5rggGK9tpwNorZxFQ0IhJCUqpY9rZ4p7MFJCpgczo7Yx1F1OSVdYN4fwDlCjew:1vbZVW:_IG_rl9hymEiV6T70T7uOURECNXGxtFOdW7EjKQT9L8','2026-01-16 07:23:34.292294'),('la04hs2b5vokpoq46ncu7iws5qk0slmb','.eJxVjEEOwiAQRe_C2hBGKAMu3fcMZIBBqoYmpV0Z765NutDtf-_9lwi0rTVsnZcwZXERIE6_W6T04LaDfKd2m2Wa27pMUe6KPGiX45z5eT3cv4NKvX5rggGK9tpwNorZxFQ0IhJCUqpY9rZ4p7MFJCpgczo7Yx1F1OSVdYN4fwDlCjew:1vbXwE:64iuq0c3mMqYAPqijCbX8AZD7i_fH6E9_TA9Ct9OaDo','2026-01-16 05:43:02.720235'),('olvezpnycuet38e7p1yx1xkjvr35tnhh','.eJxVjEEOwiAQRe_C2hBGKAMu3fcMZIBBqoYmpV0Z765NutDtf-_9lwi0rTVsnZcwZXERIE6_W6T04LaDfKd2m2Wa27pMUe6KPGiX45z5eT3cv4NKvX5rggGK9tpwNorZxFQ0IhJCUqpY9rZ4p7MFJCpgczo7Yx1F1OSVdYN4fwDlCjew:1vba1V:YeEn9g9do9N-WZXV705qAr5n-QARJXy7KvPuzcKZxXs','2026-01-16 07:56:37.879330'),('qgtvp7jmem41u4wch51wkjz0tq12mdwh','.eJxVjEEOwiAQRe_C2hBGKAMu3fcMZIBBqoYmpV0Z765NutDtf-_9lwi0rTVsnZcwZXERIE6_W6T04LaDfKd2m2Wa27pMUe6KPGiX45z5eT3cv4NKvX5rggGK9tpwNorZxFQ0IhJCUqpY9rZ4p7MFJCpgczo7Yx1F1OSVdYN4fwDlCjew:1vbYuv:vFyG7pvezqhLLSfnktCoE-7va6eAf2ANW7nCDqgbOnM','2026-01-16 06:45:45.702402'),('qzw20sdxpsf0ifhnkpr6ob83v8nhy6u0','.eJxVjEEOwiAQRe_C2hBGKAMu3fcMZIBBqoYmpV0Z765NutDtf-_9lwi0rTVsnZcwZXERIE6_W6T04LaDfKd2m2Wa27pMUe6KPGiX45z5eT3cv4NKvX5rggGK9tpwNorZxFQ0IhJCUqpY9rZ4p7MFJCpgczo7Yx1F1OSVdYN4fwDlCjew:1vbZVF:W1Zx7FgyTD8cS-re5KSq2PuYRsin3bcMx7AosNrCK_k','2026-01-16 07:23:17.778646'),('rl3iq7b94kk9wwobgqvdyprgk6rrfebx','.eJxVjEEOwiAQRe_C2hBGKAMu3fcMZIBBqoYmpV0Z765NutDtf-_9lwi0rTVsnZcwZXERIE6_W6T04LaDfKd2m2Wa27pMUe6KPGiX45z5eT3cv4NKvX5rggGK9tpwNorZxFQ0IhJCUqpY9rZ4p7MFJCpgczo7Yx1F1OSVdYN4fwDlCjew:1vbXX7:o9YJsgRq834gz3ELrnwNeP93izA8ZHPL65RO65Txo2M','2026-01-16 05:17:05.330082'),('ruik4vuesv7n2sclvs0bbgwpbo8lhcx2','.eJxVjEEOwiAQRe_C2hBGKAMu3fcMZIBBqoYmpV0Z765NutDtf-_9lwi0rTVsnZcwZXERIE6_W6T04LaDfKd2m2Wa27pMUe6KPGiX45z5eT3cv4NKvX5rggGK9tpwNorZxFQ0IhJCUqpY9rZ4p7MFJCpgczo7Yx1F1OSVdYN4fwDlCjew:1vbYN0:dpXaXQ8Z7Q3Hs0Fnrec1OkKzUZqA2AdEvE8VHeN6v3Q','2026-01-16 06:10:42.873921'),('s8hbrbelbm0coipm9wly6ussu1bamf00','.eJxVjEEOwiAQRe_C2hBGKAMu3fcMZIBBqoYmpV0Z765NutDtf-_9lwi0rTVsnZcwZXERIE6_W6T04LaDfKd2m2Wa27pMUe6KPGiX45z5eT3cv4NKvX5rggGK9tpwNorZxFQ0IhJCUqpY9rZ4p7MFJCpgczo7Yx1F1OSVdYN4fwDlCjew:1varDL:M0clp0sFeQOS1nHlm2znageYTktbKXef7VB9AbC0StA','2026-01-14 08:05:51.838470'),('tdld7qix90usjgo3u2anjoogh90czwo5','.eJxVjEEOwiAQRe_C2hBGKAMu3fcMZIBBqoYmpV0Z765NutDtf-_9lwi0rTVsnZcwZXERIE6_W6T04LaDfKd2m2Wa27pMUe6KPGiX45z5eT3cv4NKvX5rggGK9tpwNorZxFQ0IhJCUqpY9rZ4p7MFJCpgczo7Yx1F1OSVdYN4fwDlCjew:1vbV8R:jJydoH91-mzUeW2054x-DP7uFhZa4Zw_krbwOPOsbYI','2026-01-16 02:43:27.491725'),('uyydhaft4xkr3oyj6f8l6uuzze2cixa3','.eJxVjEEOwiAQRe_C2hBGKAMu3fcMZIBBqoYmpV0Z765NutDtf-_9lwi0rTVsnZcwZXERIE6_W6T04LaDfKd2m2Wa27pMUe6KPGiX45z5eT3cv4NKvX5rggGK9tpwNorZxFQ0IhJCUqpY9rZ4p7MFJCpgczo7Yx1F1OSVdYN4fwDlCjew:1vbZyT:dQKqIHOZz0vc_HTceoo_kyJlrJHfDa1ub4zF7ySpiP4','2026-01-16 07:53:29.337170'),('v7xwzq4iqk79qbufu3mfsr88lowtss6r','.eJxVjEEOwiAQRe_C2hBGKAMu3fcMZIBBqoYmpV0Z765NutDtf-_9lwi0rTVsnZcwZXERIE6_W6T04LaDfKd2m2Wa27pMUe6KPGiX45z5eT3cv4NKvX5rggGK9tpwNorZxFQ0IhJCUqpY9rZ4p7MFJCpgczo7Yx1F1OSVdYN4fwDlCjew:1vbZq8:uQI2h6swX__0OcMUSqlwxuti7-5LStTKY5Ue5YcIyOQ','2026-01-16 07:44:52.062370'),('wuec4ueqyde4dtmkvrmpebpls1aua7mk','.eJxVjEEOwiAQRe_C2hBGKAMu3fcMZIBBqoYmpV0Z765NutDtf-_9lwi0rTVsnZcwZXERIE6_W6T04LaDfKd2m2Wa27pMUe6KPGiX45z5eT3cv4NKvX5rggGK9tpwNorZxFQ0IhJCUqpY9rZ4p7MFJCpgczo7Yx1F1OSVdYN4fwDlCjew:1vbzTo:CR8LP9Dmg_s_MTNHPRfqHGuHB3UpB_KRpMiRp2LfY_M','2026-01-17 11:07:32.989500'),('xz18x3p7nxx9qlpr3w7cd88ksliztsg6','.eJxVjEEOwiAQRe_C2hBGKAMu3fcMZIBBqoYmpV0Z765NutDtf-_9lwi0rTVsnZcwZXERIE6_W6T04LaDfKd2m2Wa27pMUe6KPGiX45z5eT3cv4NKvX5rggGK9tpwNorZxFQ0IhJCUqpY9rZ4p7MFJCpgczo7Yx1F1OSVdYN4fwDlCjew:1varDV:HcphHDdQYtajVVRX61rUqjtz_Q_AqypwfaawuzcAums','2026-01-14 08:06:01.657685'),('zdz3o75l9w32tgrbikjate1ipq8pjb6i','.eJxVjEEOwiAQRe_C2hBGKAMu3fcMZIBBqoYmpV0Z765NutDtf-_9lwi0rTVsnZcwZXERIE6_W6T04LaDfKd2m2Wa27pMUe6KPGiX45z5eT3cv4NKvX5rggGK9tpwNorZxFQ0IhJCUqpY9rZ4p7MFJCpgczo7Yx1F1OSVdYN4fwDlCjew:1varPJ:9aBJUjpuNFzbIugS4EkmjTx3nPD1VKQMgMkHNgFJWQo','2026-01-14 08:18:13.117613');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-01-05 11:01:39
