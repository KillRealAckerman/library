-- MySQL dump 10.13  Distrib 8.0.34, for macos13 (arm64)
--
-- Host: localhost    Database: library
-- ------------------------------------------------------
-- Server version	8.0.31

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
-- Table structure for table `batch_books`
--

DROP TABLE IF EXISTS `batch_books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `batch_books` (
  `idbatch_books` int NOT NULL AUTO_INCREMENT,
  `total_coast` decimal(10,2) NOT NULL,
  `idsupply_list` int NOT NULL,
  `idpublishing_house` int NOT NULL,
  `date_delivery` date NOT NULL,
  PRIMARY KEY (`idbatch_books`),
  KEY `idsupply_list` (`idsupply_list`),
  KEY `idpublishing_house` (`idpublishing_house`),
  CONSTRAINT `batch_books_ibfk_1` FOREIGN KEY (`idsupply_list`) REFERENCES `supply_list` (`idsupply_list`),
  CONSTRAINT `batch_books_ibfk_2` FOREIGN KEY (`idpublishing_house`) REFERENCES `publishing_house` (`idpublishing_house`)
) ENGINE=InnoDB AUTO_INCREMENT=445 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `batch_books`
--

LOCK TABLES `batch_books` WRITE;
/*!40000 ALTER TABLE `batch_books` DISABLE KEYS */;
INSERT INTO `batch_books` VALUES (111,300000.00,1001,101,'2017-03-01'),(222,4000000.00,1002,102,'2018-02-02'),(333,20000.00,1003,101,'2017-01-02'),(444,900000.00,1002,102,'2018-04-03');
/*!40000 ALTER TABLE `batch_books` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book`
--

DROP TABLE IF EXISTS `book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book` (
  `idbook` int NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `genre` varchar(50) NOT NULL,
  `author` varchar(50) NOT NULL,
  `price` int NOT NULL,
  PRIMARY KEY (`idbook`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book`
--

LOCK TABLES `book` WRITE;
/*!40000 ALTER TABLE `book` DISABLE KEYS */;
INSERT INTO `book` VALUES (1,'11/22/63','триллер','Кинг',50),(2,'Триумфальная Арка','роман','Ремарк',34),(3,'Мёртвая зона','триллер','Кинг',222),(4,'Гиперпространство','нон-фикшн','Каку',111),(5,'Головокружение','триллер','Тилье',5000);
/*!40000 ALTER TABLE `book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `books_copies`
--

DROP TABLE IF EXISTS `books_copies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `books_copies` (
  `idbooks_copies` int NOT NULL AUTO_INCREMENT,
  `idbook` int NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `amount` int NOT NULL,
  PRIMARY KEY (`idbooks_copies`),
  KEY `idbook` (`idbook`),
  CONSTRAINT `books_copies_ibfk_1` FOREIGN KEY (`idbook`) REFERENCES `book` (`idbook`)
) ENGINE=InnoDB AUTO_INCREMENT=33334 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `books_copies`
--

LOCK TABLES `books_copies` WRITE;
/*!40000 ALTER TABLE `books_copies` DISABLE KEYS */;
INSERT INTO `books_copies` VALUES (11111,1,200.00,1000),(22222,2,120.00,0),(33333,3,85.00,260);
/*!40000 ALTER TABLE `books_copies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `internal_users`
--

DROP TABLE IF EXISTS `internal_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `internal_users` (
  `id` int NOT NULL,
  `login` varchar(45) NOT NULL,
  `password` varchar(45) DEFAULT NULL,
  `user_group` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `internal_users`
--

LOCK TABLES `internal_users` WRITE;
/*!40000 ALTER TABLE `internal_users` DISABLE KEYS */;
INSERT INTO `internal_users` VALUES (123,'q','q','admin'),(124,'w','w','Librarian'),(125,'r','r','');
/*!40000 ALTER TABLE `internal_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Order`
--

DROP TABLE IF EXISTS `Order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Order` (
  `idOrder` int NOT NULL AUTO_INCREMENT,
  `id` int NOT NULL,
  `Date` date NOT NULL,
  `Sum` int DEFAULT NULL,
  PRIMARY KEY (`idOrder`),
  KEY `idid_idx` (`id`),
  CONSTRAINT `idid` FOREIGN KEY (`id`) REFERENCES `internal_users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Order`
--

LOCK TABLES `Order` WRITE;
/*!40000 ALTER TABLE `Order` DISABLE KEYS */;
INSERT INTO `Order` VALUES (12,123,'2023-12-27',50000),(13,123,'2023-12-27',10222),(14,123,'2023-12-27',5102),(15,123,'2023-12-28',261);
/*!40000 ALTER TABLE `Order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OrderList`
--

DROP TABLE IF EXISTS `OrderList`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `OrderList` (
  `idOrderList` int NOT NULL AUTO_INCREMENT,
  `idbook` int NOT NULL,
  `Quantity` int NOT NULL,
  `idOrder` int NOT NULL,
  PRIMARY KEY (`idOrderList`),
  KEY `book1_idx` (`idbook`),
  KEY `asda_idx` (`idOrder`),
  CONSTRAINT `asda` FOREIGN KEY (`idOrder`) REFERENCES `Order` (`idOrder`),
  CONSTRAINT `book112` FOREIGN KEY (`idbook`) REFERENCES `book` (`idbook`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OrderList`
--

LOCK TABLES `OrderList` WRITE;
/*!40000 ALTER TABLE `OrderList` DISABLE KEYS */;
INSERT INTO `OrderList` VALUES (17,2,3,14),(18,5,1,14),(19,1,3,15),(20,4,1,15);
/*!40000 ALTER TABLE `OrderList` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orderr`
--

DROP TABLE IF EXISTS `orderr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orderr` (
  `idorderr` int NOT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  `sum` int DEFAULT NULL,
  `Date` date NOT NULL,
  PRIMARY KEY (`idorderr`),
  KEY `sid_idx` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderr`
--

LOCK TABLES `orderr` WRITE;
/*!40000 ALTER TABLE `orderr` DISABLE KEYS */;
/*!40000 ALTER TABLE `orderr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `publishing_house`
--

DROP TABLE IF EXISTS `publishing_house`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `publishing_house` (
  `idpublishing_house` int NOT NULL AUTO_INCREMENT,
  `year_ground` date DEFAULT NULL,
  `surname` varchar(50) DEFAULT NULL,
  `number` varchar(20) DEFAULT NULL,
  `namee` varchar(50) DEFAULT NULL,
  `date_contract` date DEFAULT NULL,
  `addres` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`idpublishing_house`)
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publishing_house`
--

LOCK TABLES `publishing_house` WRITE;
/*!40000 ALTER TABLE `publishing_house` DISABLE KEYS */;
INSERT INTO `publishing_house` VALUES (101,'2001-03-02','Аккериман','7(977)505','Семерка','2016-09-03','Москва'),(102,'1998-10-10','Таболин','7(916)777','Восьмерка','2017-01-01','Фрязино'),(103,'2000-01-01','Егер','7(567)202','Девяточка','2002-02-12','Парадиз');
/*!40000 ALTER TABLE `publishing_house` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `report_1`
--

DROP TABLE IF EXISTS `report_1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `report_1` (
  `id_report_1` int NOT NULL AUTO_INCREMENT,
  `year` int DEFAULT NULL,
  `month` int DEFAULT NULL,
  `total_cost` int DEFAULT NULL,
  PRIMARY KEY (`id_report_1`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `report_1`
--

LOCK TABLES `report_1` WRITE;
/*!40000 ALTER TABLE `report_1` DISABLE KEYS */;
INSERT INTO `report_1` VALUES (4,2023,12,5363);
/*!40000 ALTER TABLE `report_1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `supply_list`
--

DROP TABLE IF EXISTS `supply_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `supply_list` (
  `idsupply_list` int NOT NULL AUTO_INCREMENT,
  `year_publ` date DEFAULT NULL,
  `idpublishing_house` int DEFAULT NULL,
  `idbook` int DEFAULT NULL,
  `amount_copy` int DEFAULT NULL,
  `price_1` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`idsupply_list`),
  KEY `supply_list_ibfk_2` (`idbook`),
  CONSTRAINT `supply_list_ibfk_2` FOREIGN KEY (`idbook`) REFERENCES `book` (`idbook`)
) ENGINE=InnoDB AUTO_INCREMENT=1006 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supply_list`
--

LOCK TABLES `supply_list` WRITE;
/*!40000 ALTER TABLE `supply_list` DISABLE KEYS */;
INSERT INTO `supply_list` VALUES (1001,'2009-08-30',101,1,333,60.00),(1002,'2008-08-04',102,2,1,45.00),(1003,'2017-04-03',101,3,130,78.00),(1004,'1000-01-01',101,4,50000,300.00),(1005,'1990-01-01',101,5,1000,170.00);
/*!40000 ALTER TABLE `supply_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'library'
--
/*!50003 DROP PROCEDURE IF EXISTS `report_1` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `report_1`(in year INT, in month INT)
BEGIN
 DECLARE done INT DEFAULT 0;
 DECLARE total_cost FLOAT;
 DECLARE cur CURSOR FOR
SELECT
  SUM(Orderlist.Quantity * book.price) AS TotalCost
 FROM library.Order
 JOIN Orderlist ON library.Order.idOrder = Orderlist.idOrder
 JOIN book ON Orderlist.idbook = book.idbook
 WHERE YEAR(library.Order.Date) = year AND MONTH(library.Order.Date) = month;
 DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
 
 OPEN cur;
 read_loop: LOOP
 FETCH cur INTO total_cost;
 IF done THEN
  LEAVE read_loop;
 END IF;
 INSERT INTO report_1 (year, month, total_cost)
 VALUES (year, month, total_cost)
 ON DUPLICATE KEY UPDATE
 total_cost = total_cost
;
 END LOOP;
 CLOSE cur;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_book_copies` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_book_copies`(IN p_date DATE)
BEGIN
    UPDATE books_copies
     JOIN supply_list ON books_copies.idbook = supply_list.idbook
     JOIN batch_books ON supply_list.idsupply_list = batch_books.idsupply_list
    SET books_copies.amount = books_copies.amount + supply_list.amount_copy
    WHERE DATE(batch_books.date_delivery) = p_date;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-28 19:19:41
