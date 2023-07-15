CREATE TABLE IF NOT EXISTS `bccm_ip_cache` (
  `ip` varchar(50) NOT NULL DEFAULT '',
  `response` longtext NOT NULL,
  PRIMARY KEY (`ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE IF NOT EXISTS `bccm_whitelist` (
  `ckey` varchar(30) NOT NULL,
  `a_ckey` varchar(30) NOT NULL,
  `timestamp` datetime NOT NULL,
  PRIMARY KEY (`ckey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE IF NOT EXISTS `bccm_asn_ban` (
  `ip` varchar(21) NOT NULL,
  `asn` varchar(100) NOT NULL,
  `a_ckey` varchar(30) NOT NULL,
  `timestamp` datetime NOT NULL,
  PRIMARY KEY (`asn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
