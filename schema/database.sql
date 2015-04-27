-- MySQL dump 10.13  Distrib 5.6.24, for osx10.8 (x86_64)
--
-- Host: localhost    Database: xiaoyuantong
-- ------------------------------------------------------
-- Server version	5.6.24

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
-- Table structure for table `college`
--

DROP TABLE IF EXISTS `college`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `college` (
  `college_id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `name` varchar(120) NOT NULL UNIQUE INDEX,
  `created_at` datetime NOT NULL INDEX,
  `update_at` datetime NOT NULL INDEX,
  `birthday` datetime NOT NULL INDEX, /* 建校时间 */
  `description` text DEFAULT NULL,
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `department` (
  `department_id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `name` varchar(120) NOT NULL UNIQUE INDEX,
  `college_id` int(11) NOT NULL INDEX,
  `birthday` datetime NOT NULL INDEX,
  `created_at` datetime NOT NULL INDEX,
  `update_at` datetime NOT NULL INDEX,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `major`
--

DROP TABLE IF EXISTS `major`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `major` (
  `major_id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `name` varchar(120) NOT NULL,
  `department_id` int(11) NOT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `news`
--

DROP TABLE IF EXISTS `news`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `news` (
  `news_id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `title` varchar(256) NOT NULL,
  `category` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL INDEX,
  `update_at` datetime NOT NULL INDEX,
  `creator_user_id` int(11) NOT NULL INDEX,
  `updator_user_id` int(11) NOT NULL INDEX,
  `content` TEXT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `news_category`
--

DROP TABLE IF EXISTS `news_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `news_category` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `parent_category_id` int(11) INDEX,
  `name` varchar(256) NOT NULL INDEX,
  `created_at` datetime NOT NULL INDEX,
  `update_at` datetime NOT NULL INDEX,
  `description` varchar(1024) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `news_comment`
--

DROP TABLE IF EXISTS `news_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `news_comment` (
  `news_comment_id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `news_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `content` varchar(1024) DEFAULT NULL, /* text is a mysql keyword, avoid it */
  `created_at` datetime NOT NULL INDEX,
  `updated_at` datetime NOT NULL INDEX
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `news_content_image`
--

DROP TABLE IF EXISTS `news_content_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `news_content_image` (
  `news_content_image_id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `image_path` varchar(256) NOT NULL,
  PRIMARY KEY (`news_content_image_id`),
  UNIQUE KEY `news_content_image_id_UNIQUE` (`news_content_image_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;


/* many to many relation */
CREATE TABLE `news_image_relation` (
  `news_id` int(11) NOT NULL,
  `image_id` int(11) NOT NULL,
  UNIQUE KEY (news_id, image_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `news_favorite`
--

DROP TABLE IF EXISTS `news_favorite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `news_favorite` (
  `user_id` int(11) NOT NULL,
  `news_id` int(11) NOT NULL,
  `favorite_type` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  UNIQUE KEY (`news_favorite_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `news_push_list`
--

DROP TABLE IF EXISTS `news_push_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `news_push_list` (
  `news_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `read_status` int(11) NOT NULL,
  `read_time` datetime NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  UNIQUE KEY (`news_id`, `user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student_major`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
/* a student is a user in student stage */
CREATE TABLE `student_major` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY ,
  `year` varchar(4) DEFAULT NULL,
  `level` int(11) DEFAULT NULL,
  `college_id` int(11) DEFAULT NULL, /* can be infered from marjor_id, keep for performance? */
  `department_id` int(11) DEFAULT NULL INDEX, /* can be infered from marjor_id, keep for performance? */
  `major_id` int(11) DEFAULT NULL INDEX,
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `teacher`
--

DROP TABLE IF EXISTS `teacher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `teacher` (
  `user_id` int(11) NOT NULL,
  `title_id` int(11) DEFAULT NULL INDEX,
  `start_time` datetime NOT NULL INDEX,
  `college_id` int(11) DEFAULT NULL INDEX,
  `department_id` int(11) DEFAULT NULL INDEX,
  `major_id` int(11) DEFAULT NULL INDEX,
  UNIQUE INDEX (user_id, title_id, major_id, start_time)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `title`
--

DROP TABLE IF EXISTS `title`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `title` (
  `title_id` int(11) NOT NULL,
  `name` varchar(120) NOT NULL,
  PRIMARY KEY (`title_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `name` varchar(60) NOT NULL,
  `user_id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `sex` int(11) NOT NULL,
  `birthday` datetime NOT NULL DEFAULT '1970-01-01 00:00:01',
  `description` varchar(1024) DEFAULT NULL,
  `type` int(11) NOT NULL,
  `password` varchar(1024) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `email` varchar(120) DEFAULT NULL,
  `phone` varchar(40) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `status` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT '1970-01-01 00:00:01',
  `updated_at` datetime NOT NULL DEFAULT '1970-01-01 00:00:01',
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-04-27  0:06:23
