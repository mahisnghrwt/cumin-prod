-- MySQL dump 10.13  Distrib 8.0.25, for Win64 (x86_64)
--
-- Host: localhost    Database: cumindb
-- ------------------------------------------------------
-- Server version	8.0.25

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
-- Current Database: `cumindb`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `cumindb` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `cumindb`;

--
-- Table structure for table `__efmigrationshistory`
--

DROP TABLE IF EXISTS `__efmigrationshistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `__efmigrationshistory` (
  `MigrationId` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `ProductVersion` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`MigrationId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `__efmigrationshistory`
--

LOCK TABLES `__efmigrationshistory` WRITE;
/*!40000 ALTER TABLE `__efmigrationshistory` DISABLE KEYS */;
INSERT INTO `__efmigrationshistory` VALUES ('20210929231433_sprint-duration-added','5.0.6');
/*!40000 ALTER TABLE `__efmigrationshistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `epics`
--

DROP TABLE IF EXISTS `epics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `epics` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Title` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `StartDate` datetime(6) NOT NULL,
  `EndDate` datetime(6) NOT NULL,
  `Color` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Row` int NOT NULL,
  `ProjectId` int NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `IX_Epics_ProjectId` (`ProjectId`),
  CONSTRAINT `FK_Epics_Projects_ProjectId` FOREIGN KEY (`ProjectId`) REFERENCES `projects` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `epics`
--

LOCK TABLES `epics` WRITE;
/*!40000 ALTER TABLE `epics` DISABLE KEYS */;
INSERT INTO `epics` VALUES (2,'Epic 2','2021-10-03 16:47:37.337000','2021-10-07 11:47:37.337000','#27ae60',0,1),(3,'Epic 3','2021-09-25 12:47:37.337000','2021-10-01 12:47:37.337000','#7ed6df',1,1),(4,'Epic 5','2021-10-07 14:47:37.337000','2021-10-12 01:47:37.337000','#7ed6df',2,1);
/*!40000 ALTER TABLE `epics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issues`
--

DROP TABLE IF EXISTS `issues`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `issues` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Title` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `CreatedAt` datetime(6) NOT NULL,
  `Type` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Status` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `ProjectId` int NOT NULL,
  `ReporterId` int NOT NULL,
  `AssignedToId` int DEFAULT NULL,
  `SprintId` int DEFAULT NULL,
  `EpicId` int DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `IX_Issues_AssignedToId` (`AssignedToId`),
  KEY `IX_Issues_EpicId` (`EpicId`),
  KEY `IX_Issues_ProjectId` (`ProjectId`),
  KEY `IX_Issues_ReporterId` (`ReporterId`),
  KEY `IX_Issues_SprintId` (`SprintId`),
  CONSTRAINT `FK_Issues_Epics_EpicId` FOREIGN KEY (`EpicId`) REFERENCES `epics` (`Id`) ON DELETE SET NULL,
  CONSTRAINT `FK_Issues_Projects_ProjectId` FOREIGN KEY (`ProjectId`) REFERENCES `projects` (`Id`) ON DELETE CASCADE,
  CONSTRAINT `FK_Issues_Sprints_SprintId` FOREIGN KEY (`SprintId`) REFERENCES `sprints` (`Id`) ON DELETE SET NULL,
  CONSTRAINT `FK_Issues_Users_AssignedToId` FOREIGN KEY (`AssignedToId`) REFERENCES `users` (`Id`) ON DELETE SET NULL,
  CONSTRAINT `FK_Issues_Users_ReporterId` FOREIGN KEY (`ReporterId`) REFERENCES `users` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issues`
--

LOCK TABLES `issues` WRITE;
/*!40000 ALTER TABLE `issues` DISABLE KEYS */;
INSERT INTO `issues` VALUES (1,'Issue 1',NULL,'2021-09-30 00:00:00.000000','Bug','Done',1,1,NULL,1,NULL),(2,'Issue 2','Hey! This is a short description.','2021-09-30 00:00:00.000000','Task','Done',1,1,1,NULL,NULL),(3,'Issue 3',NULL,'2021-09-30 00:00:00.000000','Bug','Todo',1,1,NULL,9,NULL),(4,'Issue 4','','2021-10-10 01:02:52.254211','TODO','In Progress',1,1,NULL,1,NULL),(5,'Bug 1','','2021-10-10 01:55:19.608816','Bug','In Progress',1,1,NULL,1,NULL),(6,'Bug 2','','2021-10-10 01:56:13.163766','Bug','Done',1,1,NULL,1,NULL),(7,'Todo 1','','2021-10-10 01:57:36.312783','Todo','Todo',1,1,1,NULL,NULL),(8,'Bug 4','','2021-10-10 01:59:33.423302','Bug','Done',1,1,NULL,9,NULL),(9,'Issue 100','','2021-10-10 02:10:25.129484','Todo','Todo',1,1,NULL,9,NULL),(10,'Issue 100','','2021-10-10 05:51:20.633592','Bug','Done',1,1,NULL,9,NULL);
/*!40000 ALTER TABLE `issues` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paths`
--

DROP TABLE IF EXISTS `paths`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `paths` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `FromEpicId` int NOT NULL,
  `ToEpicId` int NOT NULL,
  `ProjectId` int NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `IX_Paths_FromEpicId` (`FromEpicId`),
  KEY `IX_Paths_ProjectId` (`ProjectId`),
  KEY `IX_Paths_ToEpicId` (`ToEpicId`),
  CONSTRAINT `FK_Paths_Epics_FromEpicId` FOREIGN KEY (`FromEpicId`) REFERENCES `epics` (`Id`) ON DELETE CASCADE,
  CONSTRAINT `FK_Paths_Epics_ToEpicId` FOREIGN KEY (`ToEpicId`) REFERENCES `epics` (`Id`) ON DELETE CASCADE,
  CONSTRAINT `FK_Paths_Projects_ProjectId` FOREIGN KEY (`ProjectId`) REFERENCES `projects` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paths`
--

LOCK TABLES `paths` WRITE;
/*!40000 ALTER TABLE `paths` DISABLE KEYS */;
INSERT INTO `paths` VALUES (2,3,2,1),(3,3,4,1),(4,2,4,1);
/*!40000 ALTER TABLE `paths` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projectinvitations`
--

DROP TABLE IF EXISTS `projectinvitations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projectinvitations` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `InvitedAt` datetime(6) NOT NULL,
  `InviterId` int NOT NULL,
  `InviteeId` int NOT NULL,
  `ProjectId` int NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `IX_ProjectInvitations_InviteeId_InviterId_ProjectId` (`InviteeId`,`InviterId`,`ProjectId`),
  KEY `IX_ProjectInvitations_InviterId` (`InviterId`),
  KEY `IX_ProjectInvitations_ProjectId` (`ProjectId`),
  CONSTRAINT `FK_ProjectInvitations_Projects_ProjectId` FOREIGN KEY (`ProjectId`) REFERENCES `projects` (`Id`) ON DELETE CASCADE,
  CONSTRAINT `invitee-projectinvitation` FOREIGN KEY (`InviteeId`) REFERENCES `users` (`Id`) ON DELETE CASCADE,
  CONSTRAINT `inviter-projectinvitation` FOREIGN KEY (`InviterId`) REFERENCES `users` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projectinvitations`
--

LOCK TABLES `projectinvitations` WRITE;
/*!40000 ALTER TABLE `projectinvitations` DISABLE KEYS */;
INSERT INTO `projectinvitations` VALUES (2,'2021-10-14 01:52:54.357398',1,2,1);
/*!40000 ALTER TABLE `projectinvitations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projects`
--

DROP TABLE IF EXISTS `projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projects` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Name` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `StartDate` datetime(6) NOT NULL,
  `ActiveSprintId` int DEFAULT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `IX_Projects_ActiveSprintId` (`ActiveSprintId`),
  CONSTRAINT `FK_Projects_Sprints_ActiveSprintId` FOREIGN KEY (`ActiveSprintId`) REFERENCES `sprints` (`Id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projects`
--

LOCK TABLES `projects` WRITE;
/*!40000 ALTER TABLE `projects` DISABLE KEYS */;
INSERT INTO `projects` VALUES (1,'Jira Clone','2021-09-30 00:00:00.000000',9),(2,'Cumin','2021-10-11 01:18:47.926725',NULL);
/*!40000 ALTER TABLE `projects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sprints`
--

DROP TABLE IF EXISTS `sprints`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sprints` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Title` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `CreatedAt` datetime(6) NOT NULL,
  `StartDate` datetime(6) NOT NULL,
  `EndDate` datetime(6) NOT NULL,
  `Description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `ProjectId` int NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `IX_Sprints_ProjectId` (`ProjectId`),
  CONSTRAINT `FK_Sprints_Projects_ProjectId` FOREIGN KEY (`ProjectId`) REFERENCES `projects` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sprints`
--

LOCK TABLES `sprints` WRITE;
/*!40000 ALTER TABLE `sprints` DISABLE KEYS */;
INSERT INTO `sprints` VALUES (1,'Sprint 0','2021-09-30 00:00:00.000000','2021-10-01 00:00:00.000000','2021-10-10 00:00:00.000000',NULL,1),(9,'Sprint 1','2021-10-10 17:49:00.259275','2021-10-10 00:00:00.000000','2021-10-11 00:00:00.000000','',1);
/*!40000 ALTER TABLE `sprints` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userprojects`
--

DROP TABLE IF EXISTS `userprojects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `userprojects` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `UserRole` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `UserId` int NOT NULL,
  `ProjectId` int NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `IX_UserProjects_UserId_ProjectId` (`UserId`,`ProjectId`),
  KEY `IX_UserProjects_ProjectId` (`ProjectId`),
  CONSTRAINT `FK_UserProjects_Projects_ProjectId` FOREIGN KEY (`ProjectId`) REFERENCES `projects` (`Id`) ON DELETE CASCADE,
  CONSTRAINT `FK_UserProjects_Users_UserId` FOREIGN KEY (`UserId`) REFERENCES `users` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userprojects`
--

LOCK TABLES `userprojects` WRITE;
/*!40000 ALTER TABLE `userprojects` DISABLE KEYS */;
INSERT INTO `userprojects` VALUES (1,'Project Manager',1,1),(2,'Project Manager',1,2),(3,'Project Manager',2,2);
/*!40000 ALTER TABLE `userprojects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `Password` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `ActiveProjectId` int DEFAULT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `IX_Users_Username` (`Username`),
  KEY `IX_Users_ActiveProjectId` (`ActiveProjectId`),
  CONSTRAINT `FK_Users_Projects_ActiveProjectId` FOREIGN KEY (`ActiveProjectId`) REFERENCES `projects` (`Id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'mahi','password',1),(2,'mahul','password2',2);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-10-17  8:49:31
