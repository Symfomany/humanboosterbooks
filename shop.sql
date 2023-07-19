-- phpMyAdmin SQL Dump

-- version 5.2.0

-- https://www.phpmyadmin.net/

--

-- Hôte : 127.0.0.1:3306

-- Généré le : jeu. 01 juin 2023 à 13:47

-- Version du serveur : 8.0.31

-- Version de PHP : 8.0.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";

START TRANSACTION;

SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */

;

/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */

;

/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */

;

/*!40101 SET NAMES utf8mb4 */

;

--

-- Base de données : `shop`

--

DELIMITER $$

--

-- Fonctions

--

DROP FUNCTION
    IF EXISTS `convertLBS` $$ CREATE DEFINER = `root` @`localhost` FUNCTION `convertLBS` (`poid` INT(255)) RETURNS FLOAT BEGIN
RETURN (poid * 2.2);

END $$
DROP FUNCTION
    IF EXISTS `levenshtein` $$ CREATE DEFINER = `root` @`localhost` FUNCTION `levenshtein` (
        `s1` VARCHAR(255),
        `s2` VARCHAR(255)
    ) RETURNS INT DETERMINISTIC BEGIN DECLARE s1_len,
    s2_len,
    i,
    j,
    c,
    c_temp,
    cost INT;

DECLARE s1_char CHAR;

-- max strlen=255

DECLARE cv0, cv1 VARBINARY(256);

SET
    s1_len = CHAR_LENGTH(s1),
    s2_len = CHAR_LENGTH(s2),
    cv1 = 0x00,
    j = 1,
    i = 1,
    c = 0;

IF s1 = s2 THEN RETURN 0;

ELSEIF s1_len = 0 THEN RETURN s2_len;

ELSEIF s2_len = 0 THEN RETURN s1_len;

ELSE
WHILE j <= s2_len
DO
SET
    cv1 = CONCAT(cv1, UNHEX(HEX(j))),
    j = j + 1;

END WHILE;

WHILE i <= s1_len
DO
SET
    s1_char = SUBSTRING(s1, i, 1),
    c = i,
    cv0 = UNHEX(HEX(i)),
    j = 1;

WHILE j <= s2_len DO SET c = c + 1;

IF s1_char = SUBSTRING(s2, j, 1) THEN SET cost = 0;

ELSE SET cost = 1;

END IF;

SET
    c_temp = CONV(
        HEX(SUBSTRING(cv1, j, 1)),
        16,
        10
    ) + cost;

IF c > c_temp THEN SET c = c_temp;

END IF;

SET
    c_temp = CONV(
        HEX(SUBSTRING(cv1, j + 1, 1)),
        16,
        10
    ) + 1;

IF c > c_temp THEN SET c = c_temp;

END IF;

SET cv0 = CONCAT(cv0, UNHEX(HEX(c))), j = j + 1;

END WHILE;

SET cv1 = cv0, i = i + 1;

END WHILE;

END IF;

RETURN c;

END$$ 

DELIMITER ;

-- --------------------------------------------------------

--

-- Structure de la table `commande`

--

DROP TABLE IF EXISTS `commande`;

CREATE TABLE
    IF NOT EXISTS `commande` (
        `id` int NOT NULL AUTO_INCREMENT,
        `user_id` int NOT NULL,
        `paiment_id` int NOT NULL,
        `tva` float NOT NULL,
        `created` date NOT NULL,
        `quantity` int NOT NULL,
        `status` enum('0', '1', '2') COLLATE utf8mb4_unicode_ci NOT NULL,
        PRIMARY KEY (`id`)
    ) ENGINE = InnoDB AUTO_INCREMENT = 3 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--

-- Déchargement des données de la table `commande`

--

INSERT INTO
    `commande` (
        `id`,
        `user_id`,
        `paiment_id`,
        `tva`,
        `created`,
        `quantity`,
        `status`
    )
VALUES (
        1,
        1,
        0,
        19.5,
        '2023-06-19',
        2,
        '1'
    ), (2, 1, 0, 20, '2023-06-21', 3, '2');

-- --------------------------------------------------------

--

-- Structure de la table `comment`

--

DROP TABLE IF EXISTS `comment`;

CREATE TABLE
    IF NOT EXISTS `comment` (
        `id` int NOT NULL AUTO_INCREMENT,
        `product_id` int NOT NULL,
        `user_id` int NOT NULL,
        `content` text COLLATE utf8mb4_unicode_ci NOT NULL,
        `readed` tinyint(1) NOT NULL,
        `created` date NOT NULL,
        PRIMARY KEY (`id`),
        KEY `product_id` (`product_id`),
        KEY `product_id_2` (`product_id`),
        KEY `user_id` (`user_id`)
    ) ENGINE = MyISAM AUTO_INCREMENT = 21 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--

-- Déchargement des données de la table `comment`

--

INSERT INTO
    `comment` (
        `id`,
        `product_id`,
        `user_id`,
        `content`,
        `readed`,
        `created`
    )
VALUES (
        3,
        1,
        1,
        'Blabla ...',
        0,
        '2023-05-08'
    ), (4, 1, 1, 'Test', 1, '2022-05-08'), (
        5,
        1,
        1,
        'Bla bla etc...',
        0,
        '2021-05-08'
    ), (6, 1, 1, 'OK', 1, '2023-06-08'), (7, 1, 1, 'Test', 1, '2021-05-09'), (
        8,
        0,
        0,
        'qsdqsd',
        0,
        '0000-00-00'
    );

-- --------------------------------------------------------

--

-- Structure de la table `extras`

--

DROP TABLE IF EXISTS `extras`;

CREATE TABLE
    IF NOT EXISTS `extras` (
        `id` int NOT NULL AUTO_INCREMENT,
        `poid` int NOT NULL,
        `longueur` int NOT NULL,
        `largeur` int NOT NULL,
        `product_id` int NOT NULL,
        PRIMARY KEY (`id`),
        UNIQUE KEY `product_id` (`product_id`)
    ) ENGINE = MyISAM AUTO_INCREMENT = 13 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--

-- Déchargement des données de la table `extras`

--

INSERT INTO
    `extras` (
        `id`,
        `poid`,
        `longueur`,
        `largeur`,
        `product_id`
    )
VALUES (1, 20, 30, 20, 1), (11, 20, 10, 20, 2), (12, 20, 10, 20, 0);

-- --------------------------------------------------------

--

-- Structure de la table `feature`

--

DROP TABLE IF EXISTS `feature`;

CREATE TABLE
    IF NOT EXISTS `feature` (
        `id` int NOT NULL AUTO_INCREMENT,
        `clef` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
        `valeur` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
        PRIMARY KEY (`id`)
    ) ENGINE = MyISAM AUTO_INCREMENT = 5 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--

-- Déchargement des données de la table `feature`

--

INSERT INTO
    `feature` (`id`, `clef`, `valeur`)
VALUES (1, 'couleur', 'sidéral'), (2, 'couleur', 'rose'), (3, 'RAM', '8'), (4, 'CPU', '8 cors');

-- --------------------------------------------------------

--

-- Structure de la table `history`

--

DROP TABLE IF EXISTS `history`;

CREATE TABLE
    IF NOT EXISTS `history` (
        `id` int NOT NULL AUTO_INCREMENT,
        `product_id` int NOT NULL,
        `version` int NOT NULL,
        `date_archive` datetime NOT NULL,
        `content` json NOT NULL,
        PRIMARY KEY (`id`)
    ) ENGINE = MyISAM AUTO_INCREMENT = 2 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--

-- Déchargement des données de la table `history`

--

INSERT INTO
    `history` (
        `id`,
        `product_id`,
        `version`,
        `date_archive`,
        `content`
    )
VALUES (
        1,
        1,
        1,
        '2023-05-25 09:03:09',
        '{\"title\": \"Apple Mackbook Air\"}'
    );

-- --------------------------------------------------------

--

-- Structure de la table `langue`

--

DROP TABLE IF EXISTS `langue`;

CREATE TABLE
    IF NOT EXISTS `langue` (
        `id` int NOT NULL AUTO_INCREMENT,
        `title` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
        `pays` varchar(2) COLLATE utf8mb4_unicode_ci NOT NULL,
        `product_id` int NOT NULL,
        PRIMARY KEY (`id`)
    ) ENGINE = MyISAM AUTO_INCREMENT = 2 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--

-- Déchargement des données de la table `langue`

--

INSERT INTO
    `langue` (
        `id`,
        `title`,
        `pays`,
        `product_id`
    )
VALUES (1, 'Producto Uno', 'es', 1);

-- --------------------------------------------------------

--

-- Structure de la table `paiment`

--

DROP TABLE IF EXISTS `paiment`;

CREATE TABLE
    IF NOT EXISTS `paiment` (
        `id` int NOT NULL AUTO_INCREMENT,
        `devise` varchar(3) COLLATE utf8mb4_unicode_ci NOT NULL,
        `title` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
        PRIMARY KEY (`id`)
    ) ENGINE = MyISAM DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- --------------------------------------------------------

--

-- Structure de la table `panier`

--

DROP TABLE IF EXISTS `panier`;

CREATE TABLE
    IF NOT EXISTS `panier` (
        `id` int NOT NULL AUTO_INCREMENT,
        `user_id` int NOT NULL,
        `promotion_id` int DEFAULT NULL,
        `created` datetime NOT NULL,
        PRIMARY KEY (`id`)
    ) ENGINE = MyISAM AUTO_INCREMENT = 2 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--

-- Déchargement des données de la table `panier`

--

INSERT INTO
    `panier` (
        `id`,
        `user_id`,
        `promotion_id`,
        `created`
    )
VALUES (1, 1, 2, '2023-06-01 09:56:42');

-- --------------------------------------------------------

--

-- Structure de la table `product`

--

DROP TABLE IF EXISTS `product`;

CREATE TABLE
    IF NOT EXISTS `product` (
        `id` int NOT NULL AUTO_INCREMENT,
        `title` text COLLATE utf8mb4_unicode_ci,
        `description` text COLLATE utf8mb4_unicode_ci,
        `price` float DEFAULT NULL,
        `createdAt` datetime NOT NULL,
        `updatedAt` datetime NOT NULL,
        `enabled` tinyint(1) DEFAULT NULL,
        PRIMARY KEY (`id`)
    ) ENGINE = InnoDB AUTO_INCREMENT = 3 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--

-- Déchargement des données de la table `product`

--

INSERT INTO
    `product` (
        `id`,
        `title`,
        `description`,
        `price`,
        `createdAt`,
        `updatedAt`,
        `enabled`
    )
VALUES (
        1,
        'MacBook Apple Pro',
        NULL,
        2,
        '2023-05-25 12:04:57',
        '2023-05-25 12:04:57',
        1
    ), (
        2,
        'Apple Mini',
        NULL,
        4,
        '2023-05-25 12:04:57',
        '2023-05-25 12:04:57',
        1
    );

-- --------------------------------------------------------

--

-- Structure de la table `product_commande`

--

DROP TABLE IF EXISTS `product_commande`;

CREATE TABLE
    IF NOT EXISTS `product_commande` (
        `product_id` int NOT NULL,
        `commande_id` int NOT NULL
    ) ENGINE = MyISAM DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- --------------------------------------------------------

--

-- Structure de la table `product_feature`

--

DROP TABLE IF EXISTS `product_feature`;

CREATE TABLE
    IF NOT EXISTS `product_feature` (
        `product_id` int NOT NULL,
        `feature_id` int NOT NULL
    ) ENGINE = MyISAM DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--

-- Déchargement des données de la table `product_feature`

--

INSERT INTO
    `product_feature` (`product_id`, `feature_id`)
VALUES (1, 1), (1, 3), (2, 1), (2, 2);

-- --------------------------------------------------------

--

-- Structure de la table `product_panier`

--

DROP TABLE IF EXISTS `product_panier`;

CREATE TABLE
    IF NOT EXISTS `product_panier` (
        `panier_id` int NOT NULL,
        `product_id` int NOT NULL,
        `promotion_id` int DEFAULT NULL,
        `created` int NOT NULL,
        `quantity` int NOT NULL
    ) ENGINE = MyISAM DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- --------------------------------------------------------

--

-- Structure de la table `product_promotion`

--

DROP TABLE IF EXISTS `product_promotion`;

CREATE TABLE
    IF NOT EXISTS `product_promotion` (
        `product_id` int NOT NULL,
        `promotion_id` int NOT NULL,
        `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
        KEY `product_id` (`product_id`),
        KEY `promotion_id` (`promotion_id`)
    ) ENGINE = MyISAM DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--

-- Déchargement des données de la table `product_promotion`

--

INSERT INTO
    `product_promotion` (
        `product_id`,
        `promotion_id`,
        `created`
    )
VALUES (1, 1, '2023-05-16 10:15:19'), (1, 2, '2023-05-16 10:15:30'), (1, 3, '2023-05-16 10:15:34'), (1, 4, '2023-05-16 10:15:39');

-- --------------------------------------------------------

--

-- Structure de la table `product_tag`

--

DROP TABLE IF EXISTS `product_tag`;

CREATE TABLE
    IF NOT EXISTS `product_tag` (
        `product_id` int NOT NULL,
        `tag_id` int NOT NULL,
        `createdAt` datetime NOT NULL,
        `updatedAt` datetime NOT NULL,
        PRIMARY KEY (`product_id`, `tag_id`),
        KEY `tag_id` (`tag_id`)
    ) ENGINE = MyISAM DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--

-- Déchargement des données de la table `product_tag`

--

INSERT INTO
    `product_tag` (
        `product_id`,
        `tag_id`,
        `createdAt`,
        `updatedAt`
    )
VALUES (
        2,
        1,
        '0000-00-00 00:00:00',
        '0000-00-00 00:00:00'
    ), (
        2,
        2,
        '0000-00-00 00:00:00',
        '0000-00-00 00:00:00'
    ), (
        2,
        3,
        '0000-00-00 00:00:00',
        '0000-00-00 00:00:00'
    ), (
        1,
        1,
        '2023-06-01 12:32:51',
        '2023-06-01 12:32:51'
    );

-- --------------------------------------------------------

--

-- Structure de la table `promotion`

--

DROP TABLE IF EXISTS `promotion`;

CREATE TABLE
    IF NOT EXISTS `promotion` (
        `id` int NOT NULL AUTO_INCREMENT,
        `taux` float NOT NULL,
        `title` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
        `enabled` tinyint(1) NOT NULL DEFAULT '1',
        PRIMARY KEY (`id`)
    ) ENGINE = MyISAM AUTO_INCREMENT = 4 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--

-- Déchargement des données de la table `promotion`

--

INSERT INTO
    `promotion` (
        `id`,
        `taux`,
        `title`,
        `enabled`
    )
VALUES (1, 20, 'Promotion été', 1), (2, 10, 'Promotion hiver', 1), (3, 15, 'Promotion printemps', 1);

-- --------------------------------------------------------

--

-- Structure de la table `tag`

--

DROP TABLE IF EXISTS `tag`;

CREATE TABLE
    IF NOT EXISTS `tag` (
        `id` int NOT NULL AUTO_INCREMENT,
        `title` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
        PRIMARY KEY (`id`)
    ) ENGINE = MyISAM AUTO_INCREMENT = 5 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--

-- Déchargement des données de la table `tag`

--

INSERT INTO
    `tag` (`id`, `title`)
VALUES (1, 'Sport'), (2, 'Randonnée'), (3, 'Foot'), (4, 'Qwidditch');

-- --------------------------------------------------------

--

-- Structure de la table `user`

--

DROP TABLE IF EXISTS `user`;

CREATE TABLE
    IF NOT EXISTS `user` (
        `id` int NOT NULL AUTO_INCREMENT,
        `nom` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
        `prenom` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
        `age` int NOT NULL,
        `email` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
        `longitude` float NOT NULL,
        `latitude` float NOT NULL,
        `date_updated` datetime NOT NULL,
        PRIMARY KEY (`id`)
    ) ENGINE = MyISAM AUTO_INCREMENT = 8 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--

-- Déchargement des données de la table `user`

--

INSERT INTO
    `user` (
        `id`,
        `nom`,
        `prenom`,
        `age`,
        `email`,
        `longitude`,
        `latitude`,
        `date_updated`
    )
VALUES (
        1,
        'Boyer',
        'François',
        35,
        'julien@taiwa.fr',
        4.79807,
        45.7311,
        '2023-05-25 13:36:02'
    ), (
        3,
        'Test',
        'Rémi',
        21,
        '',
        4.91285,
        45.7047,
        '2023-05-25 13:37:15'
    ), (
        4,
        'Adnane',
        '',
        0,
        '',
        5.36995,
        43.2962,
        '2023-05-25 13:37:56'
    ), (
        5,
        'Boyer',
        'Florent',
        0,
        '',
        0,
        0,
        '0000-00-00 00:00:00'
    ), (
        6,
        'Boyer',
        'Nicolas',
        0,
        '',
        0,
        0,
        '0000-00-00 00:00:00'
    ), (
        7,
        'Boyer',
        'Nicolas',
        0,
        '',
        0,
        0,
        '0000-00-00 00:00:00'
    );

--

-- Déclencheurs `user`

--

DROP TRIGGER IF EXISTS `update_date`;

DELIMITER $$

CREATE TRIGGER `UPDATE_DATE` 
	BEFORE
	UPDATE ON `user` FOR EACH ROW
	SET NEW.`date_updated` = NOW() $$


DELIMITER ;

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */

;

/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */

;

/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */

;

const Notification = require('./models/notification');

const Extras = require('./models/extras');

const Product = require('./models/product');

const Tag = require('./models/tag');

const Cart = require('./models/cart');

const Comment = require('./models/comment');

const User = require('./models/user');

const Commande = require('./models/commande');

const mongoose = require('mongoose');