-- MySQL dump 10.13  Distrib 5.7.19, for Win64 (x86_64)
--
-- Host: localhost    Database: nf16_projet
-- ------------------------------------------------------
-- Server version	5.7.19-log

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
-- Table structure for table `appartien_a`
--

DROP TABLE IF EXISTS `appartien_a`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `appartien_a` (
  `ID_A` int(11) NOT NULL AUTO_INCREMENT,
  `Dt_debut` date DEFAULT NULL,
  `Dt_fin` date DEFAULT NULL,
  `ISBN` varchar(20) DEFAULT NULL,
  `Nss` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_A`),
  KEY `FK_APT-LIVRE` (`ISBN`),
  KEY `FK_APT-LECTEUR` (`Nss`),
  CONSTRAINT `FK_APT-LECTEUR` FOREIGN KEY (`Nss`) REFERENCES `lecteur` (`Nss`),
  CONSTRAINT `FK_APT-LIVRE` FOREIGN KEY (`ISBN`) REFERENCES `livre` (`ISBN`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appartien_a`
--

LOCK TABLES `appartien_a` WRITE;
/*!40000 ALTER TABLE `appartien_a` DISABLE KEYS */;
INSERT INTO `appartien_a` VALUES (1,'2017-11-21','2017-12-05','3100000053697',40236),(2,'2017-11-22','2017-12-06','3100000084924',40236),(3,'2017-11-23','2017-12-07','3100000099773',40236),(4,'2017-11-24','2017-12-08','3100000122518',40236),(5,'2017-11-25','2017-12-09','3100000252836',40236),(6,'2017-11-26','2017-12-10','3100000287055',43149);
/*!40000 ALTER TABLE `appartien_a` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lecteur`
--

DROP TABLE IF EXISTS `lecteur`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lecteur` (
  `Nss` int(11) NOT NULL,
  `prenom` varchar(20) DEFAULT NULL,
  `nom` varchar(20) DEFAULT NULL,
  `Categorie` int(11) DEFAULT NULL,
  `nb_liv` int(11) DEFAULT '0',
  `retard` int(11) DEFAULT '0',
  PRIMARY KEY (`Nss`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lecteur`
--

LOCK TABLES `lecteur` WRITE;
/*!40000 ALTER TABLE `lecteur` DISABLE KEYS */;
INSERT INTO `lecteur` VALUES (40236,'XUAN','ZeHui',2,5,0),(40239,'KANG','ZhiQi',2,0,0),(40240,'MA','JingYi',2,0,0),(40241,'MA','QingXiao',2,0,0),(40246,'FANG','Ran',2,0,0),(42225,'HU','JunHao',2,0,0),(43119,'ZHU','JingYuan',2,0,1),(43149,'ZHANG','ChengJie',2,1,0),(43178,'YE','XingYu',2,0,0);
/*!40000 ALTER TABLE `lecteur` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `livre`
--

DROP TABLE IF EXISTS `livre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `livre` (
  `ISBN` varchar(20) NOT NULL,
  `Titre` varchar(40) DEFAULT NULL,
  `Auditeur` varchar(40) DEFAULT NULL,
  `Etat` varchar(20) DEFAULT NULL,
  `Lecteur_Nss` int(11) DEFAULT NULL,
  PRIMARY KEY (`ISBN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `livre`
--

LOCK TABLES `livre` WRITE;
/*!40000 ALTER TABLE `livre` DISABLE KEYS */;
INSERT INTO `livre` VALUES ('11111',NULL,NULL,'disponible',NULL),('30000000000','NF16 est difficile','JoyCJay',NULL,NULL),('3100000053697','Cerveau et mothicite','Jean Massion','prete',40236),('3100000084924','La medecine a la sante','Jean-François Mattei','prete',40236),('3100000099773','Les musées des arts et metiers','Clement Ader','prete',40236),('3100000122518','Traiter des matériaux 7','Rainer Schmid','prete',40236),('3100000252836','Material Science','James F.shcakelford','prete',40236),('3100000287055','Je me lance avec PHP et SQL','Sylvain Baudoin','prete',43149),('3100000296908','PHP/MYSQL avec Flash8','Jean-Marie Defrance','disponible',NULL),('3100000297377','Energie','Michel Feidt','disponible',NULL),('3100000383201','Java7','Robert Chevalier','disponible',NULL),('3100000394018','Element finis','Youde XIONG','disponible',NULL),('3100000397946','Language C','Yves Mettier','disponible',NULL),('3100000403850','JQuery tete la premiere','Ryan Benedetti','disponible',NULL),('3100000408063','Ressitance des materiaux','Youde XIONG','disponible',NULL),('3100000432396','Integrer les energie renouvelable','Alain Filloux','disponible',NULL),('3100000434673','Du C au C++','Frédéric DROUILLON','disponible',NULL),('3100000459977','Manuel de PHP','Jean-Michel Lery','disponible',NULL);
/*!40000 ALTER TABLE `livre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `suggestion`
--

DROP TABLE IF EXISTS `suggestion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `suggestion` (
  `ID_S` int(11) NOT NULL AUTO_INCREMENT,
  `Nss` int(11) DEFAULT NULL,
  `S_titre` varchar(40) DEFAULT NULL,
  `Raison` mediumtext,
  `auditeur` varchar(20) DEFAULT NULL,
  `ISBN_S` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`ID_S`),
  KEY `FK_SUG` (`Nss`),
  CONSTRAINT `FK_SUG` FOREIGN KEY (`Nss`) REFERENCES `lecteur` (`Nss`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `suggestion`
--

LOCK TABLES `suggestion` WRITE;
/*!40000 ALTER TABLE `suggestion` DISABLE KEYS */;
INSERT INTO `suggestion` VALUES (4,43119,'NF16 est difficile','SCD n a pas','Tony','30000000001');
/*!40000 ALTER TABLE `suggestion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `view1`
--

DROP TABLE IF EXISTS `view1`;
/*!50001 DROP VIEW IF EXISTS `view1`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `view1` AS SELECT 
 1 AS `ID_A`,
 1 AS `Dt_debut`,
 1 AS `Dt_fin`,
 1 AS `ISBN`,
 1 AS `Nss`,
 1 AS `nom`,
 1 AS `prenom`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `view1`
--

/*!50001 DROP VIEW IF EXISTS `view1`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view1` AS select `a`.`ID_A` AS `ID_A`,`a`.`Dt_debut` AS `Dt_debut`,`a`.`Dt_fin` AS `Dt_fin`,`a`.`ISBN` AS `ISBN`,`a`.`Nss` AS `Nss`,`l`.`nom` AS `nom`,`l`.`prenom` AS `prenom` from (`appartien_a` `a` join `lecteur` `l`) where (`a`.`Nss` = `l`.`Nss`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-12-02 20:16:50
