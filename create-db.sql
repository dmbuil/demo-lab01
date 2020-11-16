CREATE DATABASE acmedb;
USE acmedb;
CREATE TABLE posts (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `body` varchar(255) NOT NULL,
  `hostname` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB;
