-- MySQL dump 10.13  Distrib 8.0.45, for Linux (x86_64)
--
-- Host: localhost    Database: advertising_db
-- ------------------------------------------------------
-- Server version	8.0.45-0ubuntu0.24.04.1

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
-- Table structure for table `Arendator`
--

DROP TABLE IF EXISTS `Arendator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Arendator` (
  `a_id` int NOT NULL AUTO_INCREMENT,
  `lastname` varchar(100) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `business_field` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`a_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Arendator`
--

LOCK TABLES `Arendator` WRITE;
/*!40000 ALTER TABLE `Arendator` DISABLE KEYS */;
INSERT INTO `Arendator` VALUES (1,'Иванов','г. Москва, ул. Ленина, 12','+79001112233','Ритейл'),(2,'Петров','г. Москва, пр-т Мира, 77','+79002223344','Обувь'),(3,'Сидоров','г. Москва, ул. Новая, 5','+79003334455','Кафе'),(4,'Кузнецов','г. Москва, ул. Южная, 41','+79004445566','Техника'),(5,'Орлова','г. Москва, аллея Центральная, 3','+79005556677','Мебель'),(6,'Васильев','г. Москва, наб. Речная, 18','+79006667788','Фитнес');
/*!40000 ALTER TABLE `Arendator` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Billboard`
--

DROP TABLE IF EXISTS `Billboard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Billboard` (
  `b_id` int NOT NULL AUTO_INCREMENT,
  `cost` decimal(12,2) DEFAULT NULL,
  `size` varchar(50) DEFAULT NULL,
  `install_address` varchar(255) DEFAULT NULL,
  `quality_score` int DEFAULT NULL,
  `owner_id` int NOT NULL,
  PRIMARY KEY (`b_id`),
  KEY `owner_id` (`owner_id`),
  CONSTRAINT `Billboard_ibfk_1` FOREIGN KEY (`owner_id`) REFERENCES `Owner` (`own_id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Billboard`
--

LOCK TABLES `Billboard` WRITE;
/*!40000 ALTER TABLE `Billboard` DISABLE KEYS */;
INSERT INTO `Billboard` VALUES (1,5000.00,'3x6','ул. Ленина, 12',8,1),(2,7500.00,'4x8','пр. Мира, 45',9,2),(3,3000.00,'2x4','ул. Пушкина, 7',6,1),(4,12000.00,'6x12','ул. Гагарина, 21',10,3),(5,4500.00,'3x5','пр. Октября, 18',7,2),(6,6000.00,'4x6','ул. Кирова, 33',8,1),(7,9000.00,'5x10','ул. Советская, 50',9,3),(8,3500.00,'2x5','ул. Чехова, 10',6,2),(9,4000.00,'3x4','ул. Лермонтова, 12',7,4),(10,7000.00,'4x7','пр. Победы, 5',8,5),(11,8000.00,'4x8','ул. Молодёжная, 14',9,6),(12,5500.00,'3x6','ул. Садовая, 22',7,7),(13,6500.00,'4x6','ул. Центральная, 3',8,8),(14,3000.00,'2x3','ул. Школьная, 7',6,9),(15,10000.00,'6x12','ул. Тверская, 9',10,10),(16,4500.00,'3x5','ул. Гагарина, 15',7,1),(17,3800.00,'2x4','ул. Советская, 2',6,2),(18,7200.00,'4x8','пр. Мира, 23',9,3),(19,5000.00,'3x6','ул. Ленина, 18',8,4),(20,8500.00,'5x10','ул. Молодёжная, 25',9,5),(21,6000.00,'4x6','ул. Победы, 33',8,6),(22,4000.00,'3x4','ул. Школьная, 12',7,7),(23,9500.00,'5x12','ул. Садовая, 19',9,8),(24,3000.00,'2x3','ул. Лермонтова, 7',6,9),(25,11000.00,'6x12','ул. Тверская, 11',10,10),(26,4800.00,'3x5','ул. Кирова, 20',7,1),(27,5300.00,'3x6','ул. Гагарина, 9',8,2),(28,7000.00,'4x7','пр. Октября, 17',8,3),(29,3500.00,'2x4','ул. Ленина, 5',6,4),(30,6000.00,'4x6','ул. Молодёжная, 8',8,5),(31,4000.00,'3x5','ул. Советская, 30',7,6);
/*!40000 ALTER TABLE `Billboard` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Internal_users`
--

DROP TABLE IF EXISTS `Internal_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Internal_users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(50) DEFAULT 'employee',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Internal_users`. Тут пароли:) Будьте аккуратны
--

LOCK TABLES `Internal_users` WRITE;
/*!40000 ALTER TABLE `Internal_users` DISABLE KEYS */;
INSERT INTO `Internal_users` VALUES (1,'admin','admin123','admin'),(2,'manager','12345','manager'),(3,'employee','pass123','employee');
/*!40000 ALTER TABLE `Internal_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Order`
--

DROP TABLE IF EXISTS `Order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Order` (
  `ord_id` int NOT NULL AUTO_INCREMENT,
  `order_date` date NOT NULL,
  `total_cost` decimal(12,2) DEFAULT NULL,
  `arendator_id` int NOT NULL,
  PRIMARY KEY (`ord_id`),
  KEY `arendator_id` (`arendator_id`),
  CONSTRAINT `Order_ibfk_1` FOREIGN KEY (`arendator_id`) REFERENCES `Arendator` (`a_id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Order`
--

LOCK TABLES `Order` WRITE;
/*!40000 ALTER TABLE `Order` DISABLE KEYS */;
INSERT INTO `Order` VALUES (1,'2024-01-15',22000.00,1),(2,'2024-02-01',21000.00,2),(3,'2024-02-20',15500.00,3),(4,'2024-03-05',12000.00,4),(5,'2024-03-12',34000.00,5),(6,'2025-12-21',159000.00,6),(7,'2025-12-21',9000.00,2),(8,'2025-12-21',11000.00,4),(9,'2025-12-21',44000.00,3),(10,'2025-12-22',64000.00,3),(11,'2025-12-22',63000.00,4),(12,'2025-12-22',67500.00,6),(13,'2026-01-23',9500.00,6),(14,'2026-02-28',12000.00,4),(15,'2026-02-28',52000.00,3),(16,'2026-02-28',5000.00,3),(17,'2026-02-28',7500.00,1),(18,'2026-02-28',7500.00,1),(19,'2026-03-09',48000.00,4),(20,'2026-03-10',42000.00,5),(21,'2026-03-10',21200.00,6),(22,'2026-03-10',13800.00,4);
/*!40000 ALTER TABLE `Order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Order_line`
--

DROP TABLE IF EXISTS `Order_line`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Order_line` (
  `ol_id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `billboard_id` int NOT NULL,
  `rent_start` date NOT NULL,
  `rent_end` date NOT NULL,
  PRIMARY KEY (`ol_id`),
  KEY `order_id` (`order_id`),
  KEY `billboard_id` (`billboard_id`),
  CONSTRAINT `Order_line_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `Order` (`ord_id`) ON DELETE CASCADE,
  CONSTRAINT `Order_line_ibfk_2` FOREIGN KEY (`billboard_id`) REFERENCES `Billboard` (`b_id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Order_line`
--

LOCK TABLES `Order_line` WRITE;
/*!40000 ALTER TABLE `Order_line` DISABLE KEYS */;
INSERT INTO `Order_line` VALUES (1,1,1,'2024-02-01','2024-04-01'),(2,1,6,'2024-02-01','2024-04-01'),(3,2,10,'2024-03-01','2024-06-01'),(4,3,5,'2024-03-05','2024-04-05'),(5,3,12,'2024-03-05','2024-05-05'),(6,4,4,'2024-04-01','2024-05-01'),(7,5,20,'2024-04-15','2024-08-15'),(8,6,1,'2026-01-01','2026-07-01'),(9,6,10,'2026-01-01','2026-07-01'),(10,6,20,'2026-01-01','2026-07-01'),(11,6,30,'2026-01-01','2026-07-01'),(12,7,7,'2025-04-01','2025-05-01'),(13,8,12,'2026-04-01','2026-06-01'),(14,9,28,'2028-08-01','2028-12-01'),(15,9,31,'2028-08-01','2028-12-01'),(16,10,7,'2024-04-01','2024-08-01'),(17,10,28,'2024-04-01','2024-08-01'),(18,11,15,'2024-02-01','2024-05-01'),(19,11,25,'2024-02-01','2024-05-01'),(20,12,2,'2024-01-01','2024-10-01'),(21,13,23,'2029-05-01','2029-06-01'),(22,14,4,'2029-01-01','2029-02-01'),(23,15,11,'2029-01-01','2029-05-01'),(24,15,1,'2029-01-01','2029-05-01'),(25,16,1,'2025-01-01','2025-02-01'),(26,17,2,'2026-01-01','2026-02-01'),(27,18,2,'2025-01-01','2025-02-01'),(28,19,3,'2024-01-01','2024-04-01'),(29,19,7,'2024-01-01','2024-04-01'),(30,19,9,'2024-01-01','2024-04-01'),(31,20,25,'2028-11-01','2029-02-01'),(32,20,24,'2028-11-01','2029-02-01'),(33,21,27,'2026-06-01','2026-10-01'),(34,22,7,'2028-05-01','2028-06-01'),(35,22,26,'2028-05-01','2028-06-01');
/*!40000 ALTER TABLE `Order_line` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Owner`
--

DROP TABLE IF EXISTS `Owner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Owner` (
  `own_id` int NOT NULL AUTO_INCREMENT,
  `lastname` varchar(100) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `birth_year` int DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`own_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Owner`
--

LOCK TABLES `Owner` WRITE;
/*!40000 ALTER TABLE `Owner` DISABLE KEYS */;
INSERT INTO `Owner` VALUES (1,'Иванов','ул. Ленина, 1',1980,'+79161234567'),(2,'Петров','пр. Мира, 45',1975,'+79161234568'),(3,'Сидоров','ул. Гагарина, 21',1990,'+79161234569'),(4,'Кузнецов','ул. Победы, 10',1985,'+79161234570'),(5,'Смирнов','ул. Советская, 7',1978,'+79161234571'),(6,'Попов','ул. Молодёжная, 3',1982,'+79161234572'),(7,'Лебедев','пр. Центральный, 12',1970,'+79161234573'),(8,'Козлов','ул. Школьная, 14',1995,'+79161234574'),(9,'Новиков','ул. Тверская, 5',1988,'+79161234575'),(10,'Морозов','ул. Садовая, 9',1983,'+79161234576'),(11,'Иванов','ул. Ленина, 1',1980,'+79161234567'),(12,'Петров','пр. Мира, 45',1975,'+79161234568'),(13,'Сидоров','ул. Гагарина, 21',1990,'+79161234569'),(14,'Кузнецов','ул. Победы, 10',1985,'+79161234570'),(15,'Смирнов','ул. Советская, 7',1978,'+79161234571'),(16,'Попов','ул. Молодёжная, 3',1982,'+79161234572'),(17,'Лебедев','пр. Центральный, 12',1970,'+79161234573'),(18,'Козлов','ул. Школьная, 14',1995,'+79161234574'),(19,'Новиков','ул. Тверская, 5',1988,'+79161234575'),(20,'Морозов','ул. Садовая, 9',1983,'+79161234576');
/*!40000 ALTER TABLE `Owner` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Rental_schedule`
--

DROP TABLE IF EXISTS `Rental_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Rental_schedule` (
  `r_id` int NOT NULL AUTO_INCREMENT,
  `billboard_id` int NOT NULL,
  `rent_start` date NOT NULL,
  `rent_end` date NOT NULL,
  PRIMARY KEY (`r_id`),
  KEY `billboard_id` (`billboard_id`),
  CONSTRAINT `Rental_schedule_ibfk_1` FOREIGN KEY (`billboard_id`) REFERENCES `Billboard` (`b_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Rental_schedule`
--

LOCK TABLES `Rental_schedule` WRITE;
/*!40000 ALTER TABLE `Rental_schedule` DISABLE KEYS */;
INSERT INTO `Rental_schedule` VALUES (1,1,'2024-02-01','2024-04-01'),(2,6,'2024-02-01','2024-04-01'),(3,10,'2024-03-01','2024-06-01'),(4,5,'2024-03-05','2024-04-05'),(5,12,'2024-03-05','2024-05-05'),(6,4,'2024-04-01','2024-05-01'),(7,20,'2024-04-15','2024-08-15'),(8,1,'2026-01-01','2026-07-01'),(9,10,'2026-01-01','2026-07-01'),(10,20,'2026-01-01','2026-07-01'),(11,30,'2026-01-01','2026-07-01'),(12,7,'2025-04-01','2025-05-01'),(13,12,'2026-04-01','2026-06-01'),(14,28,'2028-08-01','2028-12-01'),(15,31,'2028-08-01','2028-12-01'),(16,7,'2024-04-01','2024-08-01'),(17,28,'2024-04-01','2024-08-01'),(18,15,'2024-02-01','2024-05-01'),(19,25,'2024-02-01','2024-05-01'),(20,2,'2024-01-01','2024-10-01'),(21,23,'2029-05-01','2029-06-01'),(22,4,'2029-01-01','2029-02-01'),(23,11,'2029-01-01','2029-05-01'),(24,1,'2029-01-01','2029-05-01'),(25,1,'2025-01-01','2025-02-01'),(26,2,'2026-01-01','2026-02-01'),(27,2,'2025-01-01','2025-02-01'),(28,3,'2024-01-01','2024-04-01'),(29,7,'2024-01-01','2024-04-01'),(30,9,'2024-01-01','2024-04-01'),(31,25,'2028-11-01','2029-02-01'),(32,24,'2028-11-01','2029-02-01'),(33,27,'2026-06-01','2026-10-01'),(34,7,'2028-05-01','2028-06-01'),(35,26,'2028-05-01','2028-06-01');
/*!40000 ALTER TABLE `Rental_schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Report_Arendator_Activity`
--

DROP TABLE IF EXISTS `Report_Arendator_Activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Report_Arendator_Activity` (
  `report_id` int NOT NULL AUTO_INCREMENT,
  `report_year` int NOT NULL,
  `report_month` int NOT NULL,
  `date_from` date NOT NULL,
  `date_to` date NOT NULL,
  `created_at` date NOT NULL,
  PRIMARY KEY (`report_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Report_Arendator_Activity`
--

LOCK TABLES `Report_Arendator_Activity` WRITE;
/*!40000 ALTER TABLE `Report_Arendator_Activity` DISABLE KEYS */;
INSERT INTO `Report_Arendator_Activity` VALUES (1,2020,1,'2020-01-01','2020-02-01','2026-01-23'),(2,2025,12,'2025-12-01','2026-01-01','2026-01-23'),(3,2029,9,'2029-09-01','2029-10-01','2026-02-28'),(4,2029,2,'2029-02-01','2029-03-01','2026-02-28'),(5,2029,1,'2029-01-01','2029-02-01','2026-02-28'),(6,2024,1,'2024-01-01','2024-02-01','2026-03-08'),(7,2024,4,'2024-04-01','2024-05-01','2026-03-08'),(8,2025,6,'2025-06-01','2025-07-01','2026-03-11'),(9,2025,4,'2025-04-01','2025-05-01','2026-03-11');
/*!40000 ALTER TABLE `Report_Arendator_Activity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Report_Arendator_Activity_Line`
--

DROP TABLE IF EXISTS `Report_Arendator_Activity_Line`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Report_Arendator_Activity_Line` (
  `raal_id` int NOT NULL AUTO_INCREMENT,
  `report_id` int NOT NULL,
  `arendator_id` int NOT NULL,
  `business_field` varchar(100) NOT NULL,
  `total_orders` int NOT NULL,
  `total_amount` decimal(12,2) NOT NULL,
  PRIMARY KEY (`raal_id`),
  KEY `report_id` (`report_id`),
  KEY `arendator_id` (`arendator_id`),
  CONSTRAINT `Report_Arendator_Activity_Line_ibfk_1` FOREIGN KEY (`report_id`) REFERENCES `Report_Arendator_Activity` (`report_id`) ON DELETE CASCADE,
  CONSTRAINT `Report_Arendator_Activity_Line_ibfk_2` FOREIGN KEY (`arendator_id`) REFERENCES `Arendator` (`a_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Report_Arendator_Activity_Line`
--

LOCK TABLES `Report_Arendator_Activity_Line` WRITE;
/*!40000 ALTER TABLE `Report_Arendator_Activity_Line` DISABLE KEYS */;
INSERT INTO `Report_Arendator_Activity_Line` VALUES (1,2,6,'Фитнес',2,226500.00),(2,2,2,'Обувь',1,9000.00),(3,2,4,'Техника',2,74000.00),(4,2,3,'Кафе',2,108000.00),(5,6,1,'Ритейл',1,22000.00);
/*!40000 ALTER TABLE `Report_Arendator_Activity_Line` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Report_Revenue`
--

DROP TABLE IF EXISTS `Report_Revenue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Report_Revenue` (
  `rr_id` int NOT NULL AUTO_INCREMENT,
  `date_from` date NOT NULL,
  `date_to` date NOT NULL,
  `total_orders` int NOT NULL,
  `total_revenue` decimal(12,2) NOT NULL,
  `created_at` date NOT NULL,
  PRIMARY KEY (`rr_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Report_Revenue`
--

LOCK TABLES `Report_Revenue` WRITE;
/*!40000 ALTER TABLE `Report_Revenue` DISABLE KEYS */;
INSERT INTO `Report_Revenue` VALUES (1,'2022-01-01','2022-02-01',0,0.00,'2026-01-23'),(2,'2025-04-01','2025-05-01',0,0.00,'2026-01-23'),(3,'2024-01-01','2024-02-01',1,22000.00,'2026-01-23'),(4,'2025-12-01','2026-01-01',7,417500.00,'2026-01-23'),(5,'2020-01-01','2020-02-01',0,0.00,'2026-01-23'),(6,'2027-01-01','2027-02-01',0,0.00,'2026-02-26'),(7,'2029-10-01','2029-11-01',0,0.00,'2026-02-28'),(8,'2029-09-01','2029-10-01',0,0.00,'2026-02-28'),(9,'2029-02-01','2029-03-01',0,0.00,'2026-02-28'),(10,'2024-04-01','2024-05-01',0,0.00,'2026-02-28'),(11,'2026-04-01','2026-05-01',0,0.00,'2026-03-08'),(12,'2028-04-01','2028-05-01',0,0.00,'2026-03-10'),(13,'2025-03-01','2025-04-01',0,0.00,'2026-03-11'),(14,'2025-05-01','2025-06-01',0,0.00,'2026-03-11');
/*!40000 ALTER TABLE `Report_Revenue` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-09 12:48:12
