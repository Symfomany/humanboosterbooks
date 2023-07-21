-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : ven. 21 juil. 2023 à 09:52
-- Version du serveur : 8.0.31
-- Version de PHP : 8.0.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `books_shop_backup`
--

-- --------------------------------------------------------

--
-- Structure de la table `addresses`
--

DROP TABLE IF EXISTS `addresses`;
CREATE TABLE IF NOT EXISTS `addresses` (
  `id` int NOT NULL AUTO_INCREMENT,
  `zipcode` int DEFAULT NULL,
  `city` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `country` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `addresses`
--

INSERT INTO `addresses` (`id`, `zipcode`, `city`, `address`, `country`) VALUES
(1, 69008, 'lyon', '186 rue de la république', 'rhone'),
(2, 6800, 'cagnes sur mer', '35 rue jean feraud', 'alpes maritimes'),
(3, 69002, 'lyon', '56 avenue de sainte croix', 'rhone'),
(4, 75005, 'paris', '157 avenue montaigne', 'ile de france'),
(5, 13006, 'marseille', '158 rue auguste renoir', 'bouches du rhone');

-- --------------------------------------------------------

--
-- Structure de la table `addresses_has_orders`
--

DROP TABLE IF EXISTS `addresses_has_orders`;
CREATE TABLE IF NOT EXISTS `addresses_has_orders` (
  `addresses_id` int NOT NULL,
  `orders_id` int NOT NULL,
  PRIMARY KEY (`addresses_id`,`orders_id`),
  KEY `fk_addresses_has_orders_orders1_idx` (`orders_id`),
  KEY `fk_addresses_has_orders_addresses1_idx` (`addresses_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `authors`
--

DROP TABLE IF EXISTS `authors`;
CREATE TABLE IF NOT EXISTS `authors` (
  `id` int NOT NULL AUTO_INCREMENT,
  `firstname` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lastname` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `biography` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `prize` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `images_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_authors_images1_idx` (`images_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `authors`
--

INSERT INTO `authors` (`id`, `firstname`, `lastname`, `biography`, `prize`, `images_id`) VALUES
(1, 'J. K.', 'Rowling', 'Elle est une auteure de romans écrits en anglais, mais a fait des études de langue et de littérature françaises (elle a d\'ailleurs enseigné le français). Elle est surtout connue comme l\'auteur de la saga Harry Potter, dont les tomes traduits en au moins 65 langues ont été vendus à plus de 450 millions d\'exemplaires.', 'Ordre national de la Légion d\'honneur 2009', NULL),
(2, 'J. R. R.', 'Tolkien', 'John Ronald Reuel Tolkien, plus connu sous le nom J. R. R. Tolkien, est un écrivain, professeur d\'université et philologue britannique né le 3 janvier 1892 à Bloemfontein et mort le 2 septembre 1973 (à 81 ans) à Bournemouth. Il est principalement connu pour ses romans Le Hobbit et Le Seigneur des anneaux.', 'Gandalf Grand Master Award 1974', NULL),
(3, 'James', 'Dashner', 'James Dashner est né en 1972 en Georgie.', 'Independent Publisher Book Award for Young Ad', NULL),
(4, 'Miguel', 'de Cervantes Saavedra', 'Miguel de Cervantes Saavedra.', 'aucun', NULL),
(5, 'Suzanne', 'Collins', 'Suzanne Collins, née le 10 août 1962 à Hartford dans le Connecticut, est une écrivaine américaine. Elle a connu le succès grâce à la trilogie de science-fiction Hunger Games, bien qu\'ayant écrit plusieurs livres de fantasy auparavant.', 'Hal Clement Award 2009 · Hunger Games', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `books`
--

DROP TABLE IF EXISTS `books`;
CREATE TABLE IF NOT EXISTS `books` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price` decimal(2,0) DEFAULT NULL,
  `synopsis` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `isbn` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `publication_date` date DEFAULT NULL,
  `collection` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `longueur` decimal(45,0) DEFAULT NULL,
  `largeur` decimal(10,0) NOT NULL,
  `profondeur` decimal(10,0) NOT NULL,
  `disponibility` tinyint DEFAULT NULL,
  `lang` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` enum('papier','numerique') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nb_page` int DEFAULT NULL,
  `views` int DEFAULT NULL,
  `cover` tinyint DEFAULT NULL,
  `order` int DEFAULT NULL,
  `visible` tinyint DEFAULT NULL,
  `weight` float DEFAULT NULL,
  `collection_id` int DEFAULT NULL,
  `images_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_books_collection1_idx` (`collection_id`),
  KEY `fk_books_images1_idx` (`images_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `books`
--

INSERT INTO `books` (`id`, `title`, `price`, `synopsis`, `isbn`, `publication_date`, `collection`, `longueur`, `largeur`, `profondeur`, `disponibility`, `lang`, `type`, `nb_page`, `views`, `cover`, `order`, `visible`, `weight`, `collection_id`, `images_id`) VALUES
(1, 'Le Seigneur des Anneaux', '20', 'Dans les vertes prairies du Comté, les Hobbits, ou Demi-Hommes, vivaient en paix... jusqu\'au jour fatal où l\'un d\'entre eux, au cours de ses voyages, entra en possession de l\'Anneau Unique aux immenses pouvoirs. Pour le reconquérir, Sauron, le Seigneur Sombre, va déchaîner toutes les forces du Mal... Frodo, le Porteur de l\'Anneau, Gandalf, le magicien, et leurs intrépides compagnons réussiront-ils à écarter la menace qui pèse sur la Terre du Milieu ?', '978-2-07-513404-0 ', '2023-07-03', 'tolkien', '15', '24', '25', 1, 'fr', 'papier', 528, NULL, NULL, NULL, 1, 0.795, NULL, NULL),
(2, 'HARRY POTTER A L\'ECOLE DES SORCIERS', '9', 'Le jour de ses onze ans, Harry Potter, un orphelin élevé par un oncle et une tante qui le détestent, voit son existence bouleversée. Un géant vient le chercher pour l\'emmener à Poudlard, une école de sorcellerie ! Voler en balai, jeter des sorts, combattre les trolls : Harry se révèle un sorcier doué. Mais un mystère entoure sa naissance et l\'effroyable V., le mage dont personne n\'ose prononcer le nom.', '978-2070584628', '2023-07-05', 'Folio Junior', '13', '0', '0', 1, 'fr', 'numerique', 199, NULL, NULL, NULL, NULL, 181, NULL, NULL),
(3, 'Don Quichotte', '8', '« Dans un village de la Manche dont je ne veux pas me rappeler le nom, vivait, il n’y a pas si longtemps, un de ces hidalgos à lance au râtelier, bouclier antique, maigre rosse et lévrier courant. Un pot-au-feu plus vache que mouton, du ragoût tous les soirs ou presque, des lentilles le vendredi, quelque pigeonneau le dimanche en plus de l’ordinaire consommaient les trois quarts de son bien. Le reste filait avec une casaque de bon drap noir et des chausses de velours pour les fêtes avec leurs couvre-pieds assortis ; les jours de semaine il tenait son rang avec un drap fin, gris souris. »\r\n\r\nJean-Raymond Fanlo a tant dépoussiéré ce texte fabuleux qu’ il le fait sonner comme une nouveauté. Fabrice Gaignault, Lire.', '978-2253131427', '2010-08-25', 'Le Livre de Poche', '11', '0', '0', 1, 'fr', 'papier', 704, NULL, NULL, NULL, NULL, 322, NULL, NULL),
(4, 'Hunger Games - Tome 1', '18', 'Dans un futur sombre, sur les ruines des États-Unis, un jeu télévisé est créé pour contrôler le peuple par la terreur.\r\nDouze garçons et douze filles tirés au sort participent à cette sinistre téléréalité, que tout le monde est forcé de regarder en direct. Une seule règle dans l\'arène : survivre, à tout prix.\r\nQuand sa petite sœur est appelée pour participer aux Hunger Games, Katniss n\'hésite pas une seconde. Elle prend sa place, consciente du danger. À seize ans, Katniss a déjà été confrontée plusieurs fois à la mort....', '2266182692\r\n', '2009-10-01', 'Pocket Junior Grand Format', '14', '0', '0', 1, 'fr', 'numerique', 400, NULL, NULL, NULL, NULL, 0, NULL, NULL),
(5, 'L\'épreuve : Le labyrinthe', '18', 'Enfermés tels des rats de laboratoire, des ados doivent trouver l\'issue d\'un labyrinthe peuplé de monstres...\r\nQuand Thomas reprend connaissance, sa mémoire est vide, seul son nom lui est familier... Il se retrouve entouré d\'adolescents dans un lieu étrange, à l\'ombre de murs infranchissables. Quatre portes gigantesques, qui se referment le soir, ouvrent sur un labyrinthe peuplé de monstres d\'acier. Chaque nuit, le plan en est modifié.\r\nThomas comprend qu\'une terrible épreuve les attend tous. Comment s\'échapper par le labyrinthe maudit sans risquer sa vie ? Si seulement il parvenait à exhumer les sombres secrets\r\nenfouis au plus profond de sa mémoire...', '978-2266200127', '2012-10-04', 'Pocket Jeunesse', '14', '0', '0', 1, 'fr', 'papier', 416, NULL, NULL, NULL, NULL, 600, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `books_has_authors`
--

DROP TABLE IF EXISTS `books_has_authors`;
CREATE TABLE IF NOT EXISTS `books_has_authors` (
  `books_id` int NOT NULL,
  `author_id` int NOT NULL,
  `date_writed` date DEFAULT NULL,
  PRIMARY KEY (`books_id`,`author_id`),
  KEY `fk_books_has_author_author1_idx` (`author_id`),
  KEY `fk_books_has_author_books1_idx` (`books_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `books_has_extras`
--

DROP TABLE IF EXISTS `books_has_extras`;
CREATE TABLE IF NOT EXISTS `books_has_extras` (
  `books_id` int NOT NULL,
  `extras_id` int NOT NULL,
  PRIMARY KEY (`books_id`,`extras_id`),
  KEY `fk_books_has_extras_extras1_idx` (`extras_id`),
  KEY `fk_books_has_extras_books1_idx` (`books_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `books_has_newsletters`
--

DROP TABLE IF EXISTS `books_has_newsletters`;
CREATE TABLE IF NOT EXISTS `books_has_newsletters` (
  `books_id` int NOT NULL,
  `newsletters_id` int NOT NULL,
  `order` int DEFAULT NULL,
  PRIMARY KEY (`books_id`,`newsletters_id`),
  KEY `fk_books_has_newsletters_newsletters1_idx` (`newsletters_id`),
  KEY `fk_books_has_newsletters_books1_idx` (`books_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `carts`
--

DROP TABLE IF EXISTS `carts`;
CREATE TABLE IF NOT EXISTS `carts` (
  `id` int NOT NULL,
  `voucher_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `users_id` int NOT NULL,
  PRIMARY KEY (`id`,`users_id`),
  KEY `fk_carts_users1_idx` (`users_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `carts`
--

INSERT INTO `carts` (`id`, `voucher_code`, `users_id`) VALUES
(0, 'code-promo', 1),
(0, 'promo-123', 2);

-- --------------------------------------------------------

--
-- Structure de la table `carts_has_books`
--

DROP TABLE IF EXISTS `carts_has_books`;
CREATE TABLE IF NOT EXISTS `carts_has_books` (
  `carts_id` int NOT NULL,
  `books_id` int NOT NULL,
  `quantity` int DEFAULT NULL,
  `date_created` date DEFAULT NULL,
  PRIMARY KEY (`carts_id`,`books_id`),
  KEY `fk_carts_has_books_books1_idx` (`books_id`),
  KEY `fk_carts_has_books_carts1_idx` (`carts_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `collection`
--

DROP TABLE IF EXISTS `collection`;
CREATE TABLE IF NOT EXISTS `collection` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `enable` tinyint DEFAULT NULL,
  `price` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nb_items` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `comments`
--

DROP TABLE IF EXISTS `comments`;
CREATE TABLE IF NOT EXISTS `comments` (
  `id` int NOT NULL,
  `books_id` int NOT NULL,
  `users_id` int NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `views` int DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_day_time` datetime DEFAULT NULL,
  `comments_id` int DEFAULT NULL,
  PRIMARY KEY (`id`,`books_id`,`users_id`),
  KEY `fk_comments_users1_idx` (`users_id`),
  KEY `fk_comments_comments1_idx` (`comments_id`),
  KEY `id` (`books_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `comments`
--

INSERT INTO `comments` (`id`, `books_id`, `users_id`, `content`, `views`, `created_date`, `updated_day_time`, `comments_id`) VALUES
(1, 1, 4, 'Le lorem ipsum est, en imprimerie, une suite de mots sans signification utilisée à titre provisoire pour calibrer une mise en page, le texte définitif venant remplacer le faux-texte dès qu\'il est prêt ou que la mise en page est achevée. Généralement, on utilise un texte en faux latin, le Lorem ipsum ou Lipsum', 12368, '2023-07-17 14:20:57', '2023-07-17 14:20:57', NULL),
(2, 2, 3, 'Le lorem ipsum est, en imprimerie, une suite de mots sans signification utilisée à titre provisoire pour calibrer une mise en page, le texte définitif venant remplacer le faux-texte dès qu\'il est prêt ou que la mise en page est achevée. Généralement, on utilise un texte en faux latin, le Lorem ipsum ou Lipsum', 2354, '2023-07-17 14:19:38', '2023-07-17 14:19:38', NULL),
(3, 3, 2, 'Le lorem ipsum est, en imprimerie, une suite de mots sans signification utilisée à titre provisoire pour calibrer une mise en page, le texte définitif venant remplacer le faux-texte dès qu\'il est prêt ou que la mise en page est achevée. Généralement, on utilise un texte en faux latin, le Lorem ipsum ou Lipsum', 5364, '2023-07-17 14:17:29', '2023-07-17 14:17:29', NULL),
(4, 5, 1, 'Le lorem ipsum est, en imprimerie, une suite de mots sans signification utilisée à titre provisoire pour calibrer une mise en page, le texte définitif venant remplacer le faux-texte dès qu\'il est prêt ou que la mise en page est achevée. Généralement, on utilise un texte en faux latin, le Lorem ipsum ou Lipsum', 4056, '2023-07-17 14:20:18', '2023-07-17 14:20:18', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `editions`
--

DROP TABLE IF EXISTS `editions`;
CREATE TABLE IF NOT EXISTS `editions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `collection` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logo` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `addresses_id` int DEFAULT NULL,
  `images_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_editors_addresses1_idx` (`addresses_id`),
  KEY `fk_editors_images1_idx` (`images_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `editions`
--

INSERT INTO `editions` (`id`, `name`, `collection`, `logo`, `addresses_id`, `images_id`) VALUES
(1, 'Hachette Livre', NULL, NULL, NULL, NULL),
(2, 'Éditions Michel Lafon', NULL, 'https://upload.wikimedia.org/wikipedia/fr/7/7', 4, NULL),
(3, 'Bloomsbury Publishing', NULL, 'https://upload.wikimedia.org/wikipedia/common', NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `editions_has_books`
--

DROP TABLE IF EXISTS `editions_has_books`;
CREATE TABLE IF NOT EXISTS `editions_has_books` (
  `editions_id` int NOT NULL,
  `books_id` int NOT NULL,
  PRIMARY KEY (`editions_id`,`books_id`),
  KEY `fk_editions_has_books_books1_idx` (`books_id`),
  KEY `fk_editions_has_books_editions1_idx` (`editions_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `extracts`
--

DROP TABLE IF EXISTS `extracts`;
CREATE TABLE IF NOT EXISTS `extracts` (
  `id` int NOT NULL,
  `num_page` int DEFAULT NULL,
  `num_line` int DEFAULT NULL,
  `lenght` int DEFAULT NULL,
  `content` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `books_id` int NOT NULL,
  PRIMARY KEY (`id`,`books_id`),
  KEY `fk_extract_books1_idx` (`books_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `extras`
--

DROP TABLE IF EXISTS `extras`;
CREATE TABLE IF NOT EXISTS `extras` (
  `id` int NOT NULL AUTO_INCREMENT,
  `key` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` json DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `favorites`
--

DROP TABLE IF EXISTS `favorites`;
CREATE TABLE IF NOT EXISTS `favorites` (
  `id_books` int DEFAULT NULL,
  `id_author` int DEFAULT NULL,
  `id_users` int NOT NULL,
  KEY `id_author_idx` (`id_author`),
  KEY `id_users_idx` (`id_users`),
  KEY `id_books_idx` (`id_books`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `genres`
--

DROP TABLE IF EXISTS `genres`;
CREATE TABLE IF NOT EXISTS `genres` (
  `id` int NOT NULL,
  `name` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `genres`
--

INSERT INTO `genres` (`id`, `name`, `description`) VALUES
(0, 'thriller', NULL),
(1, 'roman', NULL),
(2, 'fantasy', NULL),
(3, 'fiction', NULL),
(4, 'biography', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `genres_has_books`
--

DROP TABLE IF EXISTS `genres_has_books`;
CREATE TABLE IF NOT EXISTS `genres_has_books` (
  `genres_id` int NOT NULL,
  `books_id` int NOT NULL,
  PRIMARY KEY (`genres_id`,`books_id`),
  KEY `fk_genres_has_books_books1_idx` (`books_id`),
  KEY `fk_genres_has_books_genres1_idx` (`genres_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `images`
--

DROP TABLE IF EXISTS `images`;
CREATE TABLE IF NOT EXISTS `images` (
  `id` int NOT NULL AUTO_INCREMENT,
  `image` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `size` int DEFAULT NULL,
  `mimetype` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `thumbnail` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `images`
--

INSERT INTO `images` (`id`, `image`, `size`, `mimetype`, `thumbnail`) VALUES
(1, 'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5d/J._K._Rowling_2010.jpg/330px-J._K._Rowling', 330, 'jpeg', NULL),
(2, 'https://media4.giphy.com/media/kaBVsrIcrGI0Ths1du/giphy.gif?cid=ecf05e47jr6yf920ww93v2lcwt63b09i10t1', 480, 'gif', NULL),
(3, 'https://upload.wikimedia.org/wikipedia/commons/thumb/5/55/James_Dashner_%2814595088277%29.jpg/330px-', 330, 'jpeg', NULL),
(4, 'https://media2.giphy.com/media/edLKLYMlNFPJC/giphy.gif?cid=ecf05e47ibs8bhb6jyaauvxl00xnkspypvxbz2s05', 255, 'gif', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `links`
--

DROP TABLE IF EXISTS `links`;
CREATE TABLE IF NOT EXISTS `links` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `url` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` enum('internal','external') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `books_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_links_books1_idx` (`books_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `newsletters`
--

DROP TABLE IF EXISTS `newsletters`;
CREATE TABLE IF NOT EXISTS `newsletters` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sender_email` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `object` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `date_created` datetime DEFAULT NULL,
  `date_planed` datetime DEFAULT NULL,
  `enable` tinyint DEFAULT NULL,
  `html` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `begin` datetime DEFAULT NULL,
  `nb_day` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `orders`
--

DROP TABLE IF EXISTS `orders`;
CREATE TABLE IF NOT EXISTS `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `price_total` float DEFAULT NULL,
  `order_date` datetime DEFAULT NULL,
  `delivery_date` date DEFAULT NULL,
  `carrier` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price_ht` decimal(2,0) DEFAULT NULL,
  `tva` enum('10','20') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('en cours','traité','livré','non livré') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `voucher` float DEFAULT NULL,
  `carts_id` int NOT NULL,
  `carts_users_id` int NOT NULL,
  `payments_id` int NOT NULL,
  `date_created` datetime DEFAULT NULL,
  PRIMARY KEY (`id`,`carts_id`,`carts_users_id`,`payments_id`),
  KEY `fk_orders_carts1_idx` (`carts_id`,`carts_users_id`),
  KEY `fk_orders_payments1_idx` (`payments_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `orders`
--

INSERT INTO `orders` (`id`, `price_total`, `order_date`, `delivery_date`, `carrier`, `price_ht`, `tva`, `status`, `voucher`, `carts_id`, `carts_users_id`, `payments_id`, `date_created`) VALUES
(1, 30, '2023-07-19 12:03:08', '2023-07-20', 'ups', '25', '20', 'en cours', NULL, 0, 2, 1, '2023-07-19 12:03:08'),
(11, 62, '2023-07-19 12:01:06', '2023-07-20', 'dhl', '52', '20', 'en cours', NULL, 0, 1, 2, '2023-07-19 12:01:06');

-- --------------------------------------------------------

--
-- Structure de la table `parrainages`
--

DROP TABLE IF EXISTS `parrainages`;
CREATE TABLE IF NOT EXISTS `parrainages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code` varchar(70) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `enable` tinyint DEFAULT NULL,
  `users_id` int NOT NULL,
  PRIMARY KEY (`id`,`users_id`),
  KEY `fk_parrainage_users1_idx` (`users_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `parrainages`
--

INSERT INTO `parrainages` (`id`, `email`, `code`, `enable`, `users_id`) VALUES
(1, 'jhon@gmail.com', 'reduc-1234', 1, 0),
(2, 'mathieu', 'code-parrainage', 1, 2),
(3, 'brandon@hotmail.com', 'parrainage-1234', 1, 1);

-- --------------------------------------------------------

--
-- Structure de la table `payments`
--

DROP TABLE IF EXISTS `payments`;
CREATE TABLE IF NOT EXISTS `payments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` enum('VISA','MASTERCARD','Paypal','Chèque','Stripe') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `payments`
--

INSERT INTO `payments` (`id`, `type`, `description`) VALUES
(1, 'VISA', '123654785201\n10/2026 697'),
(2, 'MASTERCARD', '452369785448\r\n05/2027 657');

-- --------------------------------------------------------

--
-- Structure de la table `profiles`
--

DROP TABLE IF EXISTS `profiles`;
CREATE TABLE IF NOT EXISTS `profiles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `dob` date DEFAULT NULL,
  `token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lang` enum('fr','en','es','de') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `geoloc` point DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `profiles`
--

INSERT INTO `profiles` (`id`, `dob`, `token`, `phone`, `lang`, `geoloc`) VALUES
(0, '2015-07-09', 'da39a3ee5e6b4b0d3255bfef95601890afd80709', '07.52.36.84.65', 'en', 0x00000000010100000000000000008046400000000000003e40),
(1, '2001-04-25', 'da39a3ee5e6b4b0d3255bfef95601890afd80709', '06.25.65.36.52', 'es', 0x00000000010100000000000000008046400000000000004a40),
(2, '1997-09-29', 'da39a3ee5e6b4b0d3255bfef95601890afd80709', '07.85.56.97.50', 'fr', 0x00000000010100000000000000008046400000000000001440),
(3, '2003-07-10', 'da39a3ee5e6b4b0d3255bfef95601890afd80709', '06.58.69.57.45', 'de', 0x00000000010100000000000000008046400000000000405840),
(4, '2005-07-14', 'da39a3ee5e6b4b0d3255bfef95601890afd80709', '06.58.78.94.23', 'fr', 0x00000000010100000000000000008046400000000000806340);

-- --------------------------------------------------------

--
-- Structure de la table `promotions`
--

DROP TABLE IF EXISTS `promotions`;
CREATE TABLE IF NOT EXISTS `promotions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `taux` float DEFAULT NULL,
  `visible` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `promotions`
--

INSERT INTO `promotions` (`id`, `taux`, `visible`) VALUES
(1, 10, 1);

-- --------------------------------------------------------

--
-- Structure de la table `relationships`
--

DROP TABLE IF EXISTS `relationships`;
CREATE TABLE IF NOT EXISTS `relationships` (
  `books_id` int NOT NULL,
  `books_id2` int NOT NULL,
  `depth` int DEFAULT NULL,
  `visible` tinyint DEFAULT NULL,
  PRIMARY KEY (`books_id`,`books_id2`),
  KEY `fk_books_has_books_books2_idx` (`books_id2`),
  KEY `fk_books_has_books_books1_idx` (`books_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `relationships`
--

INSERT INTO `relationships` (`books_id`, `books_id2`, `depth`, `visible`) VALUES
(1, 2, NULL, 1),
(2, 3, NULL, 1),
(4, 5, NULL, 1);

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `lastname` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `firstname` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `age` int DEFAULT NULL,
  `email` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `enable` tinyint DEFAULT NULL,
  `profile_id` int NOT NULL,
  `date_auth` datetime DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  KEY `fk_users_profile1_idx` (`profile_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `lastname`, `firstname`, `age`, `email`, `password`, `enable`, `profile_id`, `date_auth`, `date_created`) VALUES
(0, 'julien', 'alexandre', 25, 'alexandre.jln06@gmail.com', '1234abcd', 1, 0, '2022-07-07 00:00:00', '2023-07-17 09:29:23'),
(1, 'damon', 'matt', 52, 'matt-damon@hotmail.com', '1234abcd', 1, 1, '2023-07-17 09:31:10', '2023-07-17 09:31:10'),
(2, 'clooney', 'george', 62, 'george-clooney@protonmail.com', '1234abcd', 1, 2, '2023-07-17 09:33:36', '2023-07-17 09:33:36'),
(3, 'holland', 'tom', 27, 'tom-holland@live.com', '1234abcd', 1, 3, '2023-07-17 09:36:13', '2023-07-17 09:36:13'),
(4, 'samaras', 'ken', 33, 'nekfeu@gmail.com', '1234abcd', 1, 4, '2023-07-17 09:38:59', '2023-07-17 09:38:59');

-- --------------------------------------------------------

--
-- Structure de la table `users_has_newsletters`
--

DROP TABLE IF EXISTS `users_has_newsletters`;
CREATE TABLE IF NOT EXISTS `users_has_newsletters` (
  `users_id` int NOT NULL,
  `newsletters_id` int NOT NULL,
  `date_suscribed` datetime DEFAULT NULL,
  `readed` tinyint DEFAULT NULL,
  `deleated` datetime DEFAULT NULL,
  PRIMARY KEY (`users_id`,`newsletters_id`),
  KEY `fk_users_has_newsletters_newsletters1_idx` (`newsletters_id`),
  KEY `fk_users_has_newsletters_users1_idx` (`users_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `videos`
--

DROP TABLE IF EXISTS `videos`;
CREATE TABLE IF NOT EXISTS `videos` (
  `id` int NOT NULL,
  `video` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `author` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `thumbnail` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `publication_date` date DEFAULT NULL,
  `likes` int DEFAULT NULL,
  `views` int DEFAULT NULL,
  `authors_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_videos_authors1_idx` (`authors_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `videos`
--

INSERT INTO `videos` (`id`, `video`, `title`, `author`, `description`, `thumbnail`, `publication_date`, `likes`, `views`, `authors_id`) VALUES
(0, 'interview J.K rowling', 'interview J.K rowling', 'J.K Rowling', 'Joanne Rowling [ d͡ʒoʊˈæn ˈroʊlɪŋ]a, plus connue sous les noms de plume J. K. Rowlingb et Robert Galbraith, est une romancière et scénariste britannique née le 31 juillet 1965 dans l’agglomération de Yate (Gloucestershire du Sud). Elle doit sa notoriété mondiale à la série Harry Potter, dont les romans traduits en près de quatre-vingts langues ont été vendus à plus de 500 millions d\'exemplaires dans le monde.', NULL, '2023-07-18', 135654, 825644, 1),
(1, 'J.R.R Tolkien', 'Interview J.R.R Tolkien', 'J.R.R Tolkien', 'John Ronald Reuel Tolkien, plus connu sous la forme J. R. R. Tolkien est un écrivain, poète, philologue, essayiste et professeur d’université britannique né le 3 janvier 1892 à Bloemfontein (État libre d\'Orange) et mort le 2 septembre 1973 à Bournemouth (Royaume-Uni). ', NULL, '2023-07-18', 301254, 1025487, 2),
(2, 'James Dashner', 'Interview James Dashner', 'James Dashner', 'James Dashner, né le 26 novembre 1972 à Austell dans l\'État de Géorgie, est un romancier américain spécialisé en science-fiction et fantasy.', NULL, '2023-07-18', 105654, 675024, 3);

-- --------------------------------------------------------

--
-- Structure de la table `whishlist`
--

DROP TABLE IF EXISTS `whishlist`;
CREATE TABLE IF NOT EXISTS `whishlist` (
  `books_id` int NOT NULL,
  `users_id` int NOT NULL,
  `private` tinyint DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `date_updated` datetime DEFAULT NULL,
  PRIMARY KEY (`books_id`,`users_id`),
  KEY `fk_books_has_users_users1_idx` (`users_id`),
  KEY `fk_books_has_users_books1_idx` (`books_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `addresses_has_orders`
--
ALTER TABLE `addresses_has_orders`
  ADD CONSTRAINT `fk_addresses_has_orders_addresses1` FOREIGN KEY (`addresses_id`) REFERENCES `addresses` (`id`),
  ADD CONSTRAINT `fk_addresses_has_orders_orders1` FOREIGN KEY (`orders_id`) REFERENCES `orders` (`id`);

--
-- Contraintes pour la table `authors`
--
ALTER TABLE `authors`
  ADD CONSTRAINT `fk_authors_images1` FOREIGN KEY (`images_id`) REFERENCES `images` (`id`);

--
-- Contraintes pour la table `books`
--
ALTER TABLE `books`
  ADD CONSTRAINT `fk_books_collection1` FOREIGN KEY (`collection_id`) REFERENCES `collection` (`id`),
  ADD CONSTRAINT `fk_books_images1` FOREIGN KEY (`images_id`) REFERENCES `images` (`id`);

--
-- Contraintes pour la table `books_has_authors`
--
ALTER TABLE `books_has_authors`
  ADD CONSTRAINT `fk_books_has_author_author1` FOREIGN KEY (`author_id`) REFERENCES `authors` (`id`),
  ADD CONSTRAINT `fk_books_has_author_books1` FOREIGN KEY (`books_id`) REFERENCES `books` (`id`);

--
-- Contraintes pour la table `books_has_extras`
--
ALTER TABLE `books_has_extras`
  ADD CONSTRAINT `fk_books_has_extras_books1` FOREIGN KEY (`books_id`) REFERENCES `books` (`id`),
  ADD CONSTRAINT `fk_books_has_extras_extras1` FOREIGN KEY (`extras_id`) REFERENCES `extras` (`id`);

--
-- Contraintes pour la table `books_has_newsletters`
--
ALTER TABLE `books_has_newsletters`
  ADD CONSTRAINT `fk_books_has_newsletters_books1` FOREIGN KEY (`books_id`) REFERENCES `books` (`id`),
  ADD CONSTRAINT `fk_books_has_newsletters_newsletters1` FOREIGN KEY (`newsletters_id`) REFERENCES `newsletters` (`id`);

--
-- Contraintes pour la table `carts`
--
ALTER TABLE `carts`
  ADD CONSTRAINT `fk_carts_users1` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`);

--
-- Contraintes pour la table `carts_has_books`
--
ALTER TABLE `carts_has_books`
  ADD CONSTRAINT `fk_carts_has_books_books1` FOREIGN KEY (`books_id`) REFERENCES `books` (`id`),
  ADD CONSTRAINT `fk_carts_has_books_carts1` FOREIGN KEY (`carts_id`) REFERENCES `carts` (`id`);

--
-- Contraintes pour la table `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `fk_comments_comments1` FOREIGN KEY (`comments_id`) REFERENCES `comments` (`id`),
  ADD CONSTRAINT `fk_comments_users1` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `id` FOREIGN KEY (`books_id`) REFERENCES `books` (`id`);

--
-- Contraintes pour la table `editions`
--
ALTER TABLE `editions`
  ADD CONSTRAINT `fk_editors_addresses1` FOREIGN KEY (`addresses_id`) REFERENCES `addresses` (`id`),
  ADD CONSTRAINT `fk_editors_images1` FOREIGN KEY (`images_id`) REFERENCES `images` (`id`);

--
-- Contraintes pour la table `editions_has_books`
--
ALTER TABLE `editions_has_books`
  ADD CONSTRAINT `fk_editions_has_books_books1` FOREIGN KEY (`books_id`) REFERENCES `books` (`id`),
  ADD CONSTRAINT `fk_editions_has_books_editions1` FOREIGN KEY (`editions_id`) REFERENCES `editions` (`id`);

--
-- Contraintes pour la table `extracts`
--
ALTER TABLE `extracts`
  ADD CONSTRAINT `fk_extract_books1` FOREIGN KEY (`books_id`) REFERENCES `books` (`id`);

--
-- Contraintes pour la table `favorites`
--
ALTER TABLE `favorites`
  ADD CONSTRAINT `id_author` FOREIGN KEY (`id_author`) REFERENCES `authors` (`id`),
  ADD CONSTRAINT `id_books` FOREIGN KEY (`id_books`) REFERENCES `books` (`id`),
  ADD CONSTRAINT `id_users` FOREIGN KEY (`id_users`) REFERENCES `users` (`id`);

--
-- Contraintes pour la table `genres_has_books`
--
ALTER TABLE `genres_has_books`
  ADD CONSTRAINT `fk_genres_has_books_books1` FOREIGN KEY (`books_id`) REFERENCES `books` (`id`),
  ADD CONSTRAINT `fk_genres_has_books_genres1` FOREIGN KEY (`genres_id`) REFERENCES `genres` (`id`);

--
-- Contraintes pour la table `links`
--
ALTER TABLE `links`
  ADD CONSTRAINT `fk_links_books1` FOREIGN KEY (`books_id`) REFERENCES `books` (`id`);

--
-- Contraintes pour la table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `fk_orders_carts1` FOREIGN KEY (`carts_id`,`carts_users_id`) REFERENCES `carts` (`id`, `users_id`),
  ADD CONSTRAINT `fk_orders_payments1` FOREIGN KEY (`payments_id`) REFERENCES `payments` (`id`);

--
-- Contraintes pour la table `parrainages`
--
ALTER TABLE `parrainages`
  ADD CONSTRAINT `fk_parrainage_users1` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`);

--
-- Contraintes pour la table `relationships`
--
ALTER TABLE `relationships`
  ADD CONSTRAINT `fk_books_has_books_books1` FOREIGN KEY (`books_id`) REFERENCES `books` (`id`),
  ADD CONSTRAINT `fk_books_has_books_books2` FOREIGN KEY (`books_id2`) REFERENCES `books` (`id`);

--
-- Contraintes pour la table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `fk_users_profile1` FOREIGN KEY (`profile_id`) REFERENCES `profiles` (`id`);

--
-- Contraintes pour la table `users_has_newsletters`
--
ALTER TABLE `users_has_newsletters`
  ADD CONSTRAINT `fk_users_has_newsletters_newsletters1` FOREIGN KEY (`newsletters_id`) REFERENCES `newsletters` (`id`),
  ADD CONSTRAINT `fk_users_has_newsletters_users1` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`);

--
-- Contraintes pour la table `videos`
--
ALTER TABLE `videos`
  ADD CONSTRAINT `fk_videos_authors1` FOREIGN KEY (`authors_id`) REFERENCES `authors` (`id`);

--
-- Contraintes pour la table `whishlist`
--
ALTER TABLE `whishlist`
  ADD CONSTRAINT `fk_books_has_users_books1` FOREIGN KEY (`books_id`) REFERENCES `books` (`id`),
  ADD CONSTRAINT `fk_books_has_users_users1` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
