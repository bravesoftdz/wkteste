CREATE DATABASE `wkteste` /*!40100 DEFAULT CHARACTER SET latin1 */;


CREATE TABLE `customer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `state` char(2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;

CREATE TABLE `product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(100) DEFAULT NULL,
  `price` decimal(13,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;


CREATE TABLE `order` (
  `ordernum` int(11) NOT NULL,
  `orderdate` datetime NOT NULL,
  `customerid` int(11) NOT NULL,
  `ordervalue` decimal(12,2) NOT NULL,
  PRIMARY KEY (`ordernum`),
  KEY `customer_idx` (`customerid`),
  CONSTRAINT `customer` FOREIGN KEY (`customerid`) REFERENCES `customer` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `orderline` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ordernum` int(11) NOT NULL,
  `productid` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `price` decimal(12,2) DEFAULT NULL,
  `total` decimal(12,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_idx` (`productid`),
  KEY `order_idx` (`ordernum`),
  CONSTRAINT `order` FOREIGN KEY (`ordernum`) REFERENCES `order` (`ordernum`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `product` FOREIGN KEY (`productid`) REFERENCES `product` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;
