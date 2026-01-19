-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: company
-- ------------------------------------------------------
-- Server version	8.0.41

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
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `department` (
  `Dname` varchar(30) DEFAULT NULL,
  `Dnumber` int NOT NULL,
  `Mgr_ssn` char(9) DEFAULT NULL,
  `Mgr_start_date` date DEFAULT NULL,
  PRIMARY KEY (`Dnumber`),
  KEY `fk_dept_mgr` (`Mgr_ssn`),
  KEY `idx_department_dnumber` (`Dnumber`),
  CONSTRAINT `fk_dept_mgr` FOREIGN KEY (`Mgr_ssn`) REFERENCES `employee` (`Ssn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES ('Research',1,'111111111','2020-01-01'),('Administration',2,'444444444','2021-03-15'),('IT',3,'222222222','2019-07-10');
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dependent`
--

DROP TABLE IF EXISTS `dependent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dependent` (
  `Essn` char(9) NOT NULL,
  `Dependent_name` varchar(30) NOT NULL,
  `Sex` char(1) DEFAULT NULL,
  `Bdate` date DEFAULT NULL,
  `Relationship` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`Essn`,`Dependent_name`),
  CONSTRAINT `dependent_ibfk_1` FOREIGN KEY (`Essn`) REFERENCES `employee` (`Ssn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dependent`
--

LOCK TABLES `dependent` WRITE;
/*!40000 ALTER TABLE `dependent` DISABLE KEYS */;
INSERT INTO `dependent` VALUES ('111111111','Karen Smith','F','1986-05-22','Spouse'),('111111111','Laura Smith','F','2010-09-12','Daughter'),('222222222','Pedro Silva','M','2015-11-03','Son'),('444444444','Mateus Oliveira','M','2018-02-14','Son'),('555555555','Sofia Costa','F','2012-08-09','Daughter');
/*!40000 ALTER TABLE `dependent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dept_locations`
--

DROP TABLE IF EXISTS `dept_locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dept_locations` (
  `Dnumber` int NOT NULL,
  `Dlocation` varchar(30) NOT NULL,
  PRIMARY KEY (`Dnumber`,`Dlocation`),
  KEY `idx_deptloc_location` (`Dlocation`),
  CONSTRAINT `dept_locations_ibfk_1` FOREIGN KEY (`Dnumber`) REFERENCES `department` (`Dnumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dept_locations`
--

LOCK TABLES `dept_locations` WRITE;
/*!40000 ALTER TABLE `dept_locations` DISABLE KEYS */;
INSERT INTO `dept_locations` VALUES (2,'Chicago'),(1,'Dallas'),(1,'New York'),(3,'San Francisco'),(3,'Seattle');
/*!40000 ALTER TABLE `dept_locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee` (
  `Fname` varchar(30) DEFAULT NULL,
  `Minit` char(1) DEFAULT NULL,
  `Lname` varchar(30) DEFAULT NULL,
  `Ssn` char(9) NOT NULL,
  `Bdate` date DEFAULT NULL,
  `Address` varchar(100) DEFAULT NULL,
  `Sex` char(1) DEFAULT NULL,
  `Salary` decimal(10,2) DEFAULT NULL,
  `Super_ssn` char(9) DEFAULT NULL,
  `Dno` int DEFAULT NULL,
  PRIMARY KEY (`Ssn`),
  KEY `Super_ssn` (`Super_ssn`),
  KEY `idx_employee_dno` (`Dno`),
  CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`Super_ssn`) REFERENCES `employee` (`Ssn`),
  CONSTRAINT `employee_ibfk_2` FOREIGN KEY (`Dno`) REFERENCES `department` (`Dnumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES ('John','A','Smith','111111111','1985-04-12','123 Maple St','M',56000.00,NULL,1),('Maria','B','Silva','222222222','1990-06-25','45 Oak Ave','F',62000.00,'111111111',3),('Carlos','C','Pereira','333333333','1988-11-03','78 Pine Rd','M',58000.00,'111111111',1),('Ana','D','Oliveira','444444444','1992-02-18','90 Elm Blvd','F',47000.00,'222222222',2),('Julia','E','Costa','555555555','1987-12-30','12 Cedar Ln','F',51000.00,'111111111',3);
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project`
--

DROP TABLE IF EXISTS `project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project` (
  `Pname` varchar(30) DEFAULT NULL,
  `Pnumber` int NOT NULL,
  `Plocation` varchar(30) DEFAULT NULL,
  `Dnum` int DEFAULT NULL,
  PRIMARY KEY (`Pnumber`),
  KEY `Dnum` (`Dnum`),
  CONSTRAINT `project_ibfk_1` FOREIGN KEY (`Dnum`) REFERENCES `department` (`Dnumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project`
--

LOCK TABLES `project` WRITE;
/*!40000 ALTER TABLE `project` DISABLE KEYS */;
INSERT INTO `project` VALUES ('ProductX',10,'New York',1),('Automation',20,'Chicago',2),('AI System',30,'San Francisco',3),('Website',40,'Seattle',3);
/*!40000 ALTER TABLE `project` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `works_on`
--

DROP TABLE IF EXISTS `works_on`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `works_on` (
  `Essn` char(9) NOT NULL,
  `Pno` int NOT NULL,
  `Hours` decimal(4,1) DEFAULT NULL,
  PRIMARY KEY (`Essn`,`Pno`),
  KEY `Pno` (`Pno`),
  CONSTRAINT `works_on_ibfk_1` FOREIGN KEY (`Essn`) REFERENCES `employee` (`Ssn`),
  CONSTRAINT `works_on_ibfk_2` FOREIGN KEY (`Pno`) REFERENCES `project` (`Pnumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `works_on`
--

LOCK TABLES `works_on` WRITE;
/*!40000 ALTER TABLE `works_on` DISABLE KEYS */;
INSERT INTO `works_on` VALUES ('111111111',10,20.5),('222222222',30,25.0),('222222222',40,10.0),('333333333',10,15.0),('444444444',20,30.0),('555555555',30,18.0);
/*!40000 ALTER TABLE `works_on` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'company'
--
/*!50003 DROP PROCEDURE IF EXISTS `AtualizarSalario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AtualizarSalario`(
    IN p_ssn CHAR(9),
    IN p_valor DECIMAL(10,2)
)
BEGIN
    DECLARE erro INT DEFAULT 0;

    -- Captura qualquer erro SQL
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
        SET erro = 1;

    START TRANSACTION;

    -- Atualização principal
    UPDATE employee
    SET Salary = Salary + p_valor
    WHERE Ssn = p_ssn;

    -- Se não atualizou ninguém → rollback total
    IF ROW_COUNT() = 0 OR erro = 1 THEN
        ROLLBACK;
    ELSE
        -- Ponto de salvamento
        SAVEPOINT sp1;

        -- Segunda operação (exemplo simples)
        UPDATE employee
        SET Salary = Salary
        WHERE Ssn = p_ssn;

        -- Se deu erro → rollback parcial
        IF erro = 1 THEN
            ROLLBACK TO sp1;
            COMMIT;
        ELSE
            COMMIT;
        END IF;
    END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_employee_manager` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_employee_manager`(
    IN acao INT,            -- 1 = SELECT, 2 = INSERT, 3 = UPDATE, 4 = DELETE
    IN p_Fname VARCHAR(30),
    IN p_Minit CHAR(1),
    IN p_Lname VARCHAR(30),
    IN p_Ssn CHAR(9),
    IN p_Bdate DATE,
    IN p_Address VARCHAR(100),
    IN p_Sex CHAR(1),
    IN p_Salary DECIMAL(10,2),
    IN p_Super_ssn CHAR(9),
    IN p_Dno INT
)
BEGIN
    -- Ação 1: SELECT
    IF acao = 1 THEN
        SELECT * FROM Employee;

    -- Ação 2: INSERT
    ELSEIF acao = 2 THEN
        INSERT INTO Employee (Fname, Minit, Lname, Ssn, Bdate, Address, Sex, Salary, Super_ssn, Dno)
        VALUES (p_Fname, p_Minit, p_Lname, p_Ssn, p_Bdate, p_Address, p_Sex, p_Salary, p_Super_ssn, p_Dno);

    -- Ação 3: UPDATE
    ELSEIF acao = 3 THEN
        UPDATE Employee
        SET 
            Fname = p_Fname,
            Minit = p_Minit,
            Lname = p_Lname,
            Bdate = p_Bdate,
            Address = p_Address,
            Sex = p_Sex,
            Salary = p_Salary,
            Super_ssn = p_Super_ssn,
            Dno = p_Dno
        WHERE Ssn = p_Ssn;

    -- Ação 4: DELETE
    ELSEIF acao = 4 THEN
        DELETE FROM Employee
        WHERE Ssn = p_Ssn;

    END IF;

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

-- Dump completed on 2026-01-19 16:04:48
