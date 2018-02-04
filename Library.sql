-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Client :  127.0.0.1
-- Généré le :  Mar 12 Décembre 2017 à 20:09
-- Version du serveur :  5.6.17
-- Version de PHP :  5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données :  `nf16`
--

DELIMITER $$
--
-- Procédures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `accept_sug`(IN `id` INT)
BEGIN

declare a varchar(20);

declare c varchar(20);

declare b varchar(20);

SELECT S_titre into a FROM suggestion WHERE ID_S=id;

SELECT auditeur into b FROM suggestion WHERE ID_S=id;

SELECT ISBN_S into c FROM suggestion WHERE ID_S=id;



INSERT INTO livre(ISBN,titre,auditeur) VALUES(c,a,b);

DELETE FROM suggestion WHERE ID_S=id;



END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `afficher`(IN `ns` INT)
    NO SQL
begin
declare a int;
SELECT categorie into a FROM lecteur WHERE Nss=ns;
if (1=1) then
 if(a=2)then
 select 4;
 end if;
 end if;



end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `deadline`(IN `X` INT)
BEGIN

  SELECT P.prenom,P.nom, A.*

  FROM appartien_a A, lecteur P

  WHERE A.Nss = P.Nss

  AND datediff(A.Dt_fin,curdate())< X;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Initializer`()
BEGIN

     DELETE FROM appartien_a;

     DELETE FROM suggestion;

     UPDATE livre SET etat='disponible',lecteur_nss=NULL;

     UPDATE lecteur SET nb_liv = 0,retard = 0;
     DELETE FROM livre WHERE ISBN = '30000000000';
     DELETE FROM livre WHERE ISBN = '30000000001';



END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `preter`(IN `nss` INT, IN `isbn_liv` VARCHAR(20))
BEGIN
declare cate int;
select categorie into cate from lecteur  where lecteur.Nss =nss;
IF (verifier(nss)=0) then   
	
     
if(cate=2)then 
    UPDATE livre SET etat='prete',lecteur_nss=nss WHERE ISBN=isbn_liv;
	UPDATE lecteur SET nb_liv=nb_liv+1 WHERE lecteur.nss=nss; 
	INSERT INTO appartien_a(Nss,ISBN) VALUES(nss,isbn_liv);
    
    UPDATE appartien_a SET Dt_debut=curdate(),Dt_fin=date_add(curdate(),interval 15 day)

     WHERE Nss=nss AND ISBN=isbn_liv;

elseif (cate =1)THEN
    UPDATE livre SET etat='prete',lecteur_nss=nss WHERE ISBN=isbn_liv;
	UPDATE lecteur SET nb_liv=nb_liv+1 WHERE lecteur.nss=nss; 
	INSERT INTO appartien_a(Nss,ISBN) VALUES(nss,isbn_liv);

	UPDATE appartien_a SET Dt_debut=curdate(),Dt_fin=date_add(curdate(),interval 10  day)

     WHERE Nss=nss AND ISBN=isbn_liv;

elseif (cate=3) then 
    UPDATE livre SET etat='prete',lecteur_nss=nss WHERE ISBN=isbn_liv;
	UPDATE lecteur SET nb_liv=nb_liv+1 WHERE lecteur.nss=nss; 
	INSERT INTO appartien_a(Nss,ISBN) VALUES(nss,isbn_liv);
    
    UPDATE appartien_a SET Dt_debut=curdate(),Dt_fin=date_add(curdate(),interval 20 day )

     WHERE Nss=nss AND ISBN=isbn_liv;

end if;


ELSE

     select * FROM lecteur WHERE lecteur.nss=nss;

END IF;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `situation_visuel`()
BEGIN

     Insert into appartien_a

     values(1,'2017-11-21','2017-12-05',3100000053697,40236),

     (2,'2017-11-25','2017-12-14',3100000296908,10000),
     
     (3,'2017-11-27','2017-12-11',3100000084924,40236),

     (4,'2017-11-28','2017-12-12',3100000099773,40236),

     (5,'2017-11-29','2017-12-13',3100000122518,40236),

     (6,'2017-11-30','2017-12-14',3100000252836,40236),

     (7,'2017-12-01','2017-12-15',3100000287055,43149),
     
     (8,'2017-12-03','2017-12-13',3100000297377,40242);

     UPDATE livre SET etat='prete',lecteur_nss=40236 where ISBN=3100000053697 ;

     UPDATE livre SET etat='prete',lecteur_nss=40236 where ISBN=3100000084924 ;

     UPDATE livre SET etat='prete',lecteur_nss=40236 where ISBN=3100000099773 ;

     UPDATE livre SET etat='prete',lecteur_nss=40236 where ISBN=3100000122518 ;

     UPDATE livre SET etat='prete',lecteur_nss=40236 where ISBN=3100000252836 ;

     UPDATE livre SET etat='prete',lecteur_nss=43149 where ISBN=3100000287055 ;
     
     UPDATE livre SET etat='prete',lecteur_nss=40242 where ISBN=3100000297377 ;
     
     UPDATE livre SET etat='prete',lecteur_nss=10000 where ISBN=3100000296908 ;

     UPDATE lecteur SET nb_liv = 5,retard = 0 where nss = 40236;

     UPDATE lecteur SET nb_liv = 1,retard = 0 where nss = 43149;

     UPDATE lecteur SET nb_liv = 0,retard = 1 where nss = 43119;
     
     UPDATE lecteur SET nb_liv = 1,retard = 0 where nss = 40242;
     
     UPDATE lecteur SET nb_liv = 1,retard = 0 where nss = 10000;

     INSERT INTO suggestion

     (Nss,S_titre,Raison,auditeur,ISBN_S)

     VALUES

     (43149,'NF16 est difficile','Important','JoyCJay','30000000000'),

     (43119,'NF16 est difficile','SCD n a pas','Tony','30000000001');

END$$

--
-- Fonctions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `verifier`(`ns` INT) RETURNS int(11)
BEGIN

declare nb int;

declare ret int;

declare cate int;

SELECT nb_liv into nb FROM lecteur WHERE Nss=ns;

SELECT retard into ret FROM lecteur WHERE Nss=ns;

SELECT categorie into cate FROM lecteur WHERE Nss=ns;

  IF ((cate =2 and nb<5 and ret=0)or(cate =1 and nb<3 and ret=0)or(cate =1 and nb<7 and ret=0)) THEN

    RETURN 0;
    elseif (cate =1 and nb<3 and ret=0) THEN

       RETURN 0;
       elseif (cate =3 and nb<6 and ret=0) THEN

          RETURN 0;

  ELSE

    RETURN 1;

  END IF;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `appartien_a`
--

CREATE TABLE IF NOT EXISTS `appartien_a` (
  `ID_A` int(11) NOT NULL AUTO_INCREMENT,
  `Dt_debut` date DEFAULT NULL,
  `Dt_fin` date DEFAULT NULL,
  `ISBN` varchar(20) DEFAULT NULL,
  `Nss` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_A`),
  KEY `FK_APT-LIVRE` (`ISBN`),
  KEY `FK_APT-LECTEUR` (`Nss`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=30 ;

--
-- Contenu de la table `appartien_a`
--

INSERT INTO `appartien_a` (`ID_A`, `Dt_debut`, `Dt_fin`, `ISBN`, `Nss`) VALUES
(28, '2017-12-12', '2018-01-01', '3100000459977', 42225),
(29, '2017-12-12', '2018-01-01', '3100000459977', 10000);

-- --------------------------------------------------------

--
-- Structure de la table `lecteur`
--

CREATE TABLE IF NOT EXISTS `lecteur` (
  `Nss` int(11) NOT NULL,
  `prenom` varchar(20) DEFAULT NULL,
  `nom` varchar(20) DEFAULT NULL,
  `Categorie` int(11) DEFAULT NULL,
  `nb_liv` int(11) DEFAULT '0',
  `retard` int(11) DEFAULT '0',
  PRIMARY KEY (`Nss`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `lecteur`
--

INSERT INTO `lecteur` (`Nss`, `prenom`, `nom`, `Categorie`, `nb_liv`, `retard`) VALUES
(10000, 'Sophie', 'Loriette', 3, 1, 0),
(40236, 'XUAN', 'ZeHui', 2, 0, 0),
(40239, 'KANG', 'ZhiQi', 2, 0, 0),
(40240, 'MA', 'JingYi', 2, 0, 0),
(40241, 'MA', 'QingXiao', 2, 0, 0),
(40242, 'Wang', 'Zhengyi', 1, 0, 0),
(40246, 'FANG', 'Ran', 2, 0, 0),
(42225, 'HU', 'JunHao', 2, 1, 0),
(43119, 'ZHU', 'JingYuan', 2, 0, 0),
(43149, 'ZHANG', 'ChengJie', 2, 0, 0),
(43178, 'YE', 'XingYu', 2, 0, 0);

-- --------------------------------------------------------

--
-- Structure de la table `livre`
--

CREATE TABLE IF NOT EXISTS `livre` (
  `ISBN` varchar(20) NOT NULL,
  `Titre` varchar(40) DEFAULT NULL,
  `Auditeur` varchar(40) DEFAULT NULL,
  `Etat` varchar(20) DEFAULT NULL,
  `Lecteur_Nss` int(11) DEFAULT NULL,
  PRIMARY KEY (`ISBN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `livre`
--

INSERT INTO `livre` (`ISBN`, `Titre`, `Auditeur`, `Etat`, `Lecteur_Nss`) VALUES
('11111', NULL, NULL, 'disponible', NULL),
('3100000053697', 'Cerveau et mothicite', 'Jean Massion', 'disponible', NULL),
('3100000084924', 'La medecine a la sante', 'Jean-François Mattei', 'disponible', NULL),
('3100000099773', 'Les musées des arts et metiers', 'Clement Ader', 'disponible', NULL),
('3100000122518', 'Traiter des matériaux 7', 'Rainer Schmid', 'disponible', NULL),
('3100000252836', 'Material Science', 'James F.shcakelford', 'disponible', NULL),
('3100000287055', 'Je me lance avec PHP et SQL', 'Sylvain Baudoin', 'disponible', NULL),
('3100000296908', 'PHP/MYSQL avec Flash8', 'Jean-Marie Defrance', 'disponible', NULL),
('3100000297377', 'Energie', 'Michel Feidt', 'disponible', NULL),
('3100000383201', 'Java7', 'Robert Chevalier', 'disponible', NULL),
('3100000394018', 'Element finis', 'Youde XIONG', 'disponible', NULL),
('3100000397946', 'Language C', 'Yves Mettier', 'disponible', NULL),
('3100000403850', 'JQuery tete la premiere', 'Ryan Benedetti', 'disponible', NULL),
('3100000408063', 'Ressitance des materiaux', 'Youde XIONG', 'disponible', NULL),
('3100000432396', 'Integrer les energie renouvelable', 'Alain Filloux', 'disponible', NULL),
('3100000434673', 'Du C au C++', 'Frédéric DROUILLON', 'disponible', NULL),
('3100000459977', 'Manuel de PHP', 'Jean-Michel Lery', 'prete', 10000);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `ouvrage`
--
CREATE TABLE IF NOT EXISTS `ouvrage` (
`ID_A` int(11)
,`Dt_debut` date
,`Dt_fin` date
,`ISBN` varchar(20)
,`Nss` int(11)
,`nom` varchar(20)
,`prenom` varchar(20)
);
-- --------------------------------------------------------

--
-- Structure de la table `suggestion`
--

CREATE TABLE IF NOT EXISTS `suggestion` (
  `ID_S` int(11) NOT NULL AUTO_INCREMENT,
  `Nss` int(11) DEFAULT NULL,
  `S_titre` varchar(40) DEFAULT NULL,
  `Raison` mediumtext,
  `auditeur` varchar(20) DEFAULT NULL,
  `ISBN_S` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`ID_S`),
  KEY `FK_SUG` (`Nss`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=19 ;

-- --------------------------------------------------------

--
-- Structure de la vue `ouvrage`
--
DROP TABLE IF EXISTS `ouvrage`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `ouvrage` AS select `a`.`ID_A` AS `ID_A`,`a`.`Dt_debut` AS `Dt_debut`,`a`.`Dt_fin` AS `Dt_fin`,`a`.`ISBN` AS `ISBN`,`a`.`Nss` AS `Nss`,`l`.`nom` AS `nom`,`l`.`prenom` AS `prenom` from (`appartien_a` `a` join `lecteur` `l`) where (`a`.`Nss` = `l`.`Nss`);

--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `appartien_a`
--
ALTER TABLE `appartien_a`
  ADD CONSTRAINT `FK_APT-LECTEUR` FOREIGN KEY (`Nss`) REFERENCES `lecteur` (`Nss`),
  ADD CONSTRAINT `FK_APT-LIVRE` FOREIGN KEY (`ISBN`) REFERENCES `livre` (`ISBN`);

--
-- Contraintes pour la table `suggestion`
--
ALTER TABLE `suggestion`
  ADD CONSTRAINT `FK_SUG` FOREIGN KEY (`Nss`) REFERENCES `lecteur` (`Nss`);

DELIMITER $$
--
-- Événements
--
CREATE DEFINER=`root`@`localhost` EVENT `event1` ON SCHEDULE EVERY 1 DAY STARTS '2017-12-10 20:27:55' ON COMPLETION PRESERVE ENABLE DO update lecteur set retard = 1
where Nss in 
(select Nss from appartien_a where CURRENT_DATE > Dt_fin)$$

DELIMITER ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
