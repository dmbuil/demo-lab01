CREATE DATABASE acmedb;
USE acmedb;
CEATE TABLE `posts` (
   `id` int(11) NOT NULL AUTO_INCREMENT,
   `title` varchar(255) NOT NULL,
   `body` varchar(255) NOT NULL,
   `hostname` varchar(255) NOT NULL,
   PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=latin1;