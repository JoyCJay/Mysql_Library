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
-- Dumping routines for database 'nf16_projet'
--
/*!50003 DROP FUNCTION IF EXISTS `verifier` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `verifier`(ns int) RETURNS int(11)
BEGIN
declare nb int;
declare ret int;
SELECT nb_liv into nb FROM lecteur WHERE Nss=ns;
SELECT retard into ret FROM lecteur WHERE Nss=ns;
  IF (nb<5 and ret=0) THEN
    RETURN 0;
  ELSE
    RETURN 1;
  END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `accept_sug` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `accept_sug`(IN id int)
BEGIN
declare a varchar(20);
declare c varchar(20);
declare b varchar(20);
SELECT S_titre into a FROM suggestion WHERE ID_S=id;
SELECT auditeur into b FROM suggestion WHERE ID_S=id;
SELECT ISBN_S into c FROM suggestion WHERE ID_S=id;

INSERT INTO livre(ISBN,titre,auditeur) VALUES(c,a,b);
DELETE FROM suggestion WHERE ID_S=id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Initializer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Initializer`()
BEGIN
     DELETE FROM appartien_a;
     DELETE FROM suggestion;
     UPDATE livre SET etat='disponible',lecteur_nss=NULL;
     UPDATE lecteur SET nb_liv = 0,retard = 0;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `P1` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `P1`(IN X int)
BEGIN
  SELECT P.prenom,P.nom, A.*
  FROM appartien_a A, lecteur P
  WHERE A.Nss = P.Nss
  AND datediff(A.Dt_fin,curdate())< X;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `preter` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `preter`(IN nss int, IN isbn_liv varchar(20))
BEGIN
IF (verifier(nss)=0) then
       /*1.modifier l'etat de livre*/
     UPDATE livre SET etat='prete',lecteur_nss=nss WHERE ISBN=isbn_liv;
     UPDATE lecteur SET nb_liv=nb_liv+1 WHERE lecteur.nss=nss;
     /*2.insert this record into TABLE appartien_a*/
     INSERT INTO appartien_a(Nss,ISBN) VALUES(nss,isbn_liv);
     UPDATE appartien_a SET Dt_debut=curdate(),Dt_fin=date_add(curdate(),interval 15 day)
     WHERE Nss=nss AND ISBN=isbn_liv;
ELSE
     select * FROM lecteur WHERE lecteur.nss=nss;
END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `situation_visuel` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `situation_visuel`()
BEGIN
     Insert into appartien_a
     values(1,'2017-11-21','2017-12-05',3100000053697,40236),
     (2,'2017-11-22','2017-12-06',3100000084924,40236),
     (3,'2017-11-23','2017-12-07',3100000099773,40236),
     (4,'2017-11-24','2017-12-08',3100000122518,40236),
     (5,'2017-11-25','2017-12-09',3100000252836,40236),
     (6,'2017-11-26','2017-12-10',3100000287055,43149);
     UPDATE livre SET etat='prete',lecteur_nss=40236 where ISBN=3100000053697 ;
     UPDATE livre SET etat='prete',lecteur_nss=40236 where ISBN=3100000084924 ;
     UPDATE livre SET etat='prete',lecteur_nss=40236 where ISBN=3100000099773 ;
     UPDATE livre SET etat='prete',lecteur_nss=40236 where ISBN=3100000122518 ;
     UPDATE livre SET etat='prete',lecteur_nss=40236 where ISBN=3100000252836 ;
     UPDATE livre SET etat='prete',lecteur_nss=43149 where ISBN=3100000287055 ;
     UPDATE lecteur SET nb_liv = 5,retard = 0 where nss = 40236;
     UPDATE lecteur SET nb_liv = 1,retard = 0 where nss = 43149;
     UPDATE lecteur SET nb_liv = 0,retard = 1 where nss = 43119;
     INSERT INTO suggestion
     (Nss,S_titre,Raison,auditeur,ISBN_S)
     VALUES
     (43149,'NF16 est difficile','Important','JoyCJay','30000000000'),
     (43119,'NF16 est difficile','SCD n a pas','Tony','30000000001');
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

-- Dump completed on 2017-12-02 20:07:00
