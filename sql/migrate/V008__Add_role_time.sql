DROP TABLE IF EXISTS `role_time`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;

CREATE TABLE `role_time`
( `ckey` VARCHAR(32) NOT NULL ,
 `job` VARCHAR(64) NOT NULL ,
 `minutes` INT UNSIGNED NOT NULL,
 PRIMARY KEY (`ckey`, `job`)
 ) ENGINE = InnoDB;
/*!40101 SET character_set_client = @saved_cs_client */;
