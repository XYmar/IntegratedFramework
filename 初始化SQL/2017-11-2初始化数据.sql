/*
MySQL Backup
Source Server Version: 5.7.17
Source Database: testdatabase
Date: 2017/11/2 11:10:37
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
--  Table structure for `rg_adjustdevice`
-- ----------------------------
DROP TABLE IF EXISTS `rg_adjustdevice`;
CREATE TABLE `rg_adjustdevice` (
  `id` varchar(255) NOT NULL,
  `orderId` varchar(255) DEFAULT NULL,
  `reportTime` datetime DEFAULT NULL,
  `resoureId` varchar(255) DEFAULT NULL,
  `origin` varchar(255) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `processTime` datetime DEFAULT NULL,
  `cancelTime` varchar(255) DEFAULT NULL,
  `latestCancelTime` varchar(255) DEFAULT NULL,
  `unavailableStartTime` varchar(255) DEFAULT NULL,
  `unavailableEndTime` varchar(255) DEFAULT NULL,
  `unavailableStartDate` varchar(255) DEFAULT NULL,
  `unavailableEndDate` varchar(255) DEFAULT NULL,
  `order_id` varchar(100) DEFAULT NULL,
  `resource_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_1sw1d8l90iovgivhiq4yc5k3a` (`order_id`),
  UNIQUE KEY `UK_f4kb3hxn80ne3g1mk9jlnedch` (`resource_id`),
  CONSTRAINT `FKfy5uylbtunc9rfqyixy8yi6bj` FOREIGN KEY (`order_id`) REFERENCES `rg_order` (`id`),
  CONSTRAINT `FKo7gwctlbp377mpgtb3ltb36kk` FOREIGN KEY (`resource_id`) REFERENCES `rg_resource` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `rg_adjustlayout`
-- ----------------------------
DROP TABLE IF EXISTS `rg_adjustlayout`;
CREATE TABLE `rg_adjustlayout` (
  `id` varchar(100) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `layoutDesc` varchar(100) DEFAULT NULL,
  `reportTime` datetime DEFAULT NULL,
  `origin` varchar(100) DEFAULT NULL,
  `type` varchar(100) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `processTime` datetime DEFAULT NULL,
  `refLayout` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK6o1ovnhe632vcqjpu5fwx449s` (`refLayout`),
  CONSTRAINT `FK6o1ovnhe632vcqjpu5fwx449s` FOREIGN KEY (`refLayout`) REFERENCES `rg_layout` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `rg_adjustorder`
-- ----------------------------
DROP TABLE IF EXISTS `rg_adjustorder`;
CREATE TABLE `rg_adjustorder` (
  `id` varchar(100) NOT NULL,
  `origin` varchar(100) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `reportTime` datetime DEFAULT NULL,
  `processTime` datetime DEFAULT NULL,
  `idOrder` varchar(100) DEFAULT NULL,
  `adjustOrderType` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_5jgvdblw35mehb3tes6rq9d5i` (`idOrder`),
  CONSTRAINT `FK5o6wtkl91cwtep73k1uydunqr` FOREIGN KEY (`idOrder`) REFERENCES `rg_order` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `rg_adjustprocess`
-- ----------------------------
DROP TABLE IF EXISTS `rg_adjustprocess`;
CREATE TABLE `rg_adjustprocess` (
  `id` varchar(100) NOT NULL,
  `reportTime` datetime DEFAULT NULL,
  `processTime` datetime DEFAULT NULL,
  `idTask` varchar(60) DEFAULT NULL,
  `idJob` varchar(60) DEFAULT NULL,
  `idOrder` varchar(50) DEFAULT NULL,
  `originalResource` varchar(100) DEFAULT NULL,
  `originalStartTime` datetime DEFAULT NULL,
  `appointResource` varchar(100) DEFAULT NULL,
  `appointStartTime` datetime DEFAULT NULL,
  `origin` varchar(50) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `rg_agvinfo`
-- ----------------------------
DROP TABLE IF EXISTS `rg_agvinfo`;
CREATE TABLE `rg_agvinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `agvId` varchar(255) DEFAULT NULL,
  `state` tinyint(1) DEFAULT NULL,
  `goodsDesc` varchar(255) DEFAULT NULL,
  `idOrder` varchar(255) DEFAULT NULL,
  `remainPower` float DEFAULT NULL,
  `reportTime` datetime DEFAULT NULL,
  `site` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `rg_assemblycarryinfo`
-- ----------------------------
DROP TABLE IF EXISTS `rg_assemblycarryinfo`;
CREATE TABLE `rg_assemblycarryinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `carryId` varchar(255) DEFAULT NULL,
  `state` tinyint(1) DEFAULT NULL,
  `jobDesc` varchar(255) DEFAULT NULL,
  `idOrder` varchar(255) DEFAULT NULL,
  `reportTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `rg_assemblycenterinfo`
-- ----------------------------
DROP TABLE IF EXISTS `rg_assemblycenterinfo`;
CREATE TABLE `rg_assemblycenterinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `carryId` varchar(255) DEFAULT NULL,
  `state` tinyint(1) DEFAULT NULL,
  `jobDesc` varchar(255) DEFAULT NULL,
  `idOrder` varchar(255) DEFAULT NULL,
  `reportTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `rg_assisantprocess`
-- ----------------------------
DROP TABLE IF EXISTS `rg_assisantprocess`;
CREATE TABLE `rg_assisantprocess` (
  `id` varchar(60) NOT NULL,
  `grp` smallint(6) DEFAULT NULL,
  `TypeSite` varchar(255) DEFAULT NULL,
  `IdSite` varchar(255) DEFAULT NULL,
  `minResource` smallint(6) DEFAULT NULL,
  `maxResource` smallint(6) DEFAULT NULL,
  `siteInGroupResource` varchar(5) DEFAULT NULL,
  `modResource` smallint(6) DEFAULT NULL,
  `rgPrimary` varchar(255) DEFAULT NULL,
  `weightParallel` smallint(6) DEFAULT NULL,
  `weightSequence` smallint(6) DEFAULT NULL,
  `idProcess` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKi8w7p5bxt8wwejxbilrqkfdjs` (`idProcess`),
  CONSTRAINT `FKi8w7p5bxt8wwejxbilrqkfdjs` FOREIGN KEY (`idProcess`) REFERENCES `rg_process` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `rg_carryinfo`
-- ----------------------------
DROP TABLE IF EXISTS `rg_carryinfo`;
CREATE TABLE `rg_carryinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `agvId` varchar(255) DEFAULT NULL,
  `state` tinyint(1) DEFAULT NULL,
  `jobDesc` varchar(255) DEFAULT NULL,
  `idOrder` varchar(255) DEFAULT NULL,
  `reportTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `rg_club`
-- ----------------------------
DROP TABLE IF EXISTS `rg_club`;
CREATE TABLE `rg_club` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `rg_config`
-- ----------------------------
DROP TABLE IF EXISTS `rg_config`;
CREATE TABLE `rg_config` (
  `id` varchar(20) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `value` varchar(100) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  `editable` varchar(10) DEFAULT NULL,
  `idUser` varchar(50) DEFAULT NULL,
  `idClub` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKf606l6ja1gdfq85b0jo7ynhi` (`idUser`),
  KEY `FKdndxxo22n634xspkv52mmpjxb` (`idClub`),
  CONSTRAINT `FKdndxxo22n634xspkv52mmpjxb` FOREIGN KEY (`idClub`) REFERENCES `rg_club` (`id`),
  CONSTRAINT `FKf606l6ja1gdfq85b0jo7ynhi` FOREIGN KEY (`idUser`) REFERENCES `rg_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `rg_degreeaccuracyinfo`
-- ----------------------------
DROP TABLE IF EXISTS `rg_degreeaccuracyinfo`;
CREATE TABLE `rg_degreeaccuracyinfo` (
  `id` varchar(255) NOT NULL,
  `carryId` varchar(255) DEFAULT NULL,
  `state` tinyint(1) DEFAULT NULL,
  `jobDesc` varchar(255) DEFAULT NULL,
  `idOrder` varchar(255) DEFAULT NULL,
  `reportTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `rg_deportinfo`
-- ----------------------------
DROP TABLE IF EXISTS `rg_deportinfo`;
CREATE TABLE `rg_deportinfo` (
  `id` varchar(255) NOT NULL,
  `deportId` varchar(255) DEFAULT NULL,
  `deportName` varchar(255) DEFAULT NULL,
  `stock` int(11) DEFAULT NULL,
  `freePlace` int(11) DEFAULT NULL,
  `reportTime` datetime DEFAULT NULL,
  `totalPlace` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `rg_distance`
-- ----------------------------
DROP TABLE IF EXISTS `rg_distance`;
CREATE TABLE `rg_distance` (
  `id` varchar(60) NOT NULL,
  `idSite1` varchar(255) DEFAULT NULL,
  `idSite2` varchar(255) DEFAULT NULL,
  `distance` int(11) DEFAULT NULL,
  `time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKj9vh93h6rsbp6k2wr39a7pxby` (`idSite1`),
  KEY `FKeqtbnd3pqy6jvmrln60wbfh6i` (`idSite2`),
  CONSTRAINT `FKeqtbnd3pqy6jvmrln60wbfh6i` FOREIGN KEY (`idSite2`) REFERENCES `rg_site` (`id`),
  CONSTRAINT `FKj9vh93h6rsbp6k2wr39a7pxby` FOREIGN KEY (`idSite1`) REFERENCES `rg_site` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `rg_electricityinfo`
-- ----------------------------
DROP TABLE IF EXISTS `rg_electricityinfo`;
CREATE TABLE `rg_electricityinfo` (
  `id` varchar(255) NOT NULL,
  `carryId` varchar(255) DEFAULT NULL,
  `state` tinyint(1) DEFAULT NULL,
  `jobDesc` varchar(255) DEFAULT NULL,
  `idOrder` varchar(255) DEFAULT NULL,
  `reportTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `rg_emulatedata`
-- ----------------------------
DROP TABLE IF EXISTS `rg_emulatedata`;
CREATE TABLE `rg_emulatedata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item` varchar(255) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `good` varchar(50) DEFAULT NULL,
  `startLocation` varchar(50) DEFAULT NULL,
  `endLocation` varchar(50) DEFAULT NULL,
  `startTime` varchar(50) DEFAULT NULL,
  `endTime` varchar(50) DEFAULT NULL,
  `idOrder` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKgl77jfnx16rsahxewdm2qqqrf` (`idOrder`),
  CONSTRAINT `FKgl77jfnx16rsahxewdm2qqqrf` FOREIGN KEY (`idOrder`) REFERENCES `rg_order` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `rg_emulateresult`
-- ----------------------------
DROP TABLE IF EXISTS `rg_emulateresult`;
CREATE TABLE `rg_emulateresult` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `task` varchar(50) DEFAULT NULL,
  `startTime` int(11) DEFAULT NULL,
  `endTime` int(11) DEFAULT NULL,
  `goods` varchar(50) DEFAULT NULL,
  `site` varchar(50) DEFAULT NULL,
  `idOrder` varchar(100) DEFAULT NULL,
  `idSnapshort` varchar(100) DEFAULT NULL,
  `idTask` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKibnlm3qe5qkk68joegpao1187` (`idOrder`),
  KEY `FKblb6qjieei2woi87lf12kuxay` (`idSnapshort`),
  CONSTRAINT `FKblb6qjieei2woi87lf12kuxay` FOREIGN KEY (`idSnapshort`) REFERENCES `rg_snapshot` (`id`),
  CONSTRAINT `FKibnlm3qe5qkk68joegpao1187` FOREIGN KEY (`idOrder`) REFERENCES `rg_order` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `rg_eventlog`
-- ----------------------------
DROP TABLE IF EXISTS `rg_eventlog`;
CREATE TABLE `rg_eventlog` (
  `id` varchar(255) NOT NULL,
  `eventType` smallint(6) DEFAULT NULL,
  `logItemtype` smallint(6) DEFAULT NULL,
  `creatTime` datetime DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  `describeText` varchar(255) DEFAULT NULL,
  `objectId` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `rg_groupresource`
-- ----------------------------
DROP TABLE IF EXISTS `rg_groupresource`;
CREATE TABLE `rg_groupresource` (
  `id` varchar(255) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `external` tinyint(4) DEFAULT NULL,
  `idSite0` varchar(20) DEFAULT NULL,
  `state` tinyint(4) DEFAULT NULL,
  `color` varchar(50) DEFAULT NULL,
  `IdSite` varchar(255) DEFAULT NULL,
  `idProvider` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK26apro5kbq9if03xhssflx0dk` (`idProvider`),
  CONSTRAINT `FK26apro5kbq9if03xhssflx0dk` FOREIGN KEY (`idProvider`) REFERENCES `rg_provider` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `rg_layout`
-- ----------------------------
DROP TABLE IF EXISTS `rg_layout`;
CREATE TABLE `rg_layout` (
  `id` varchar(60) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `imgPath` varchar(255) DEFAULT NULL,
  `layoutDesc` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `rg_layoutdetail`
-- ----------------------------
DROP TABLE IF EXISTS `rg_layoutdetail`;
CREATE TABLE `rg_layoutdetail` (
  `id` varchar(60) NOT NULL,
  `item` varchar(255) DEFAULT NULL,
  `pos` varchar(50) DEFAULT NULL,
  `state` varchar(20) DEFAULT NULL,
  `exist` varchar(20) DEFAULT NULL,
  `idLayout` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK68lda1prqt73u437ee0qn3n1g` (`idLayout`),
  CONSTRAINT `FK68lda1prqt73u437ee0qn3n1g` FOREIGN KEY (`idLayout`) REFERENCES `rg_layout` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `rg_layoutdistance`
-- ----------------------------
DROP TABLE IF EXISTS `rg_layoutdistance`;
CREATE TABLE `rg_layoutdistance` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site1` varchar(255) DEFAULT NULL,
  `site2` varchar(50) DEFAULT NULL,
  `distance` varchar(20) DEFAULT NULL,
  `time` varchar(20) DEFAULT NULL,
  `type` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=466 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `rg_manmachineinfo`
-- ----------------------------
DROP TABLE IF EXISTS `rg_manmachineinfo`;
CREATE TABLE `rg_manmachineinfo` (
  `id` varchar(255) NOT NULL,
  `carryId` varchar(255) DEFAULT NULL,
  `state` tinyint(1) DEFAULT NULL,
  `jobDesc` varchar(255) DEFAULT NULL,
  `idOrder` varchar(255) DEFAULT NULL,
  `reportTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `rg_mesmessagelog`
-- ----------------------------
DROP TABLE IF EXISTS `rg_mesmessagelog`;
CREATE TABLE `rg_mesmessagelog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `receiveTime` datetime DEFAULT NULL,
  `messageType` varchar(255) DEFAULT NULL,
  `message` varchar(10000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `rg_modeltestinfo`
-- ----------------------------
DROP TABLE IF EXISTS `rg_modeltestinfo`;
CREATE TABLE `rg_modeltestinfo` (
  `id` varchar(255) NOT NULL,
  `carryId` varchar(255) DEFAULT NULL,
  `state` tinyint(1) DEFAULT NULL,
  `jobDesc` varchar(255) DEFAULT NULL,
  `idOrder` varchar(255) DEFAULT NULL,
  `reportTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `rg_order`
-- ----------------------------
DROP TABLE IF EXISTS `rg_order`;
CREATE TABLE `rg_order` (
  `id` varchar(100) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `origin` varchar(50) DEFAULT NULL,
  `type` varchar(100) DEFAULT NULL,
  `idClient` varchar(20) DEFAULT NULL,
  `IdProvider` varchar(255) DEFAULT NULL,
  `IdGroupResource` varchar(255) DEFAULT NULL,
  `quantity` smallint(6) DEFAULT NULL,
  `finishQuantity` smallint(6) DEFAULT NULL,
  `priority` smallint(6) DEFAULT NULL,
  `t0` datetime DEFAULT NULL,
  `t1` datetime DEFAULT NULL,
  `t2` datetime DEFAULT NULL,
  `ord` smallint(6) DEFAULT NULL,
  `IdPree` varchar(255) DEFAULT NULL,
  `IdSucc` varchar(255) DEFAULT NULL,
  `IdExclusive` varchar(255) DEFAULT NULL,
  `t1Interaction` varchar(255) DEFAULT NULL,
  `t2Interaction` varchar(255) DEFAULT NULL,
  `t1Plan` datetime DEFAULT NULL,
  `t2Plan` datetime DEFAULT NULL,
  `estimate` smallint(6) DEFAULT NULL,
  `advance` smallint(6) DEFAULT NULL,
  `delay` smallint(6) DEFAULT NULL,
  `color` varchar(50) DEFAULT NULL,
  `state` tinyint(4) DEFAULT '1',
  `selected` tinyint(4) DEFAULT NULL,
  `nbTask` smallint(6) DEFAULT NULL,
  `finished` tinyint(1) DEFAULT NULL,
  `idProduct` varchar(100) DEFAULT NULL,
  `idClub` varchar(255) DEFAULT NULL,
  `sendToMES` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK2ykqmlsh1agymgpda8mm4p1xs` (`idProduct`),
  KEY `FKe221a7nbkcqql7l2jt5ieqak5` (`idClub`),
  CONSTRAINT `FK2ykqmlsh1agymgpda8mm4p1xs` FOREIGN KEY (`idProduct`) REFERENCES `rg_product` (`id`),
  CONSTRAINT `FKe221a7nbkcqql7l2jt5ieqak5` FOREIGN KEY (`idClub`) REFERENCES `rg_club` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `rg_orderstate`
-- ----------------------------
DROP TABLE IF EXISTS `rg_orderstate`;
CREATE TABLE `rg_orderstate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idTask` varchar(255) DEFAULT NULL,
  `nameTask` varchar(100) DEFAULT NULL,
  `planDevice` varchar(100) DEFAULT NULL,
  `planCount` tinyint(4) DEFAULT NULL,
  `planStartTime` datetime DEFAULT NULL,
  `planFinishTime` datetime DEFAULT NULL,
  `actualDispatchDevice` varchar(50) DEFAULT NULL,
  `actualFinishCount` tinyint(4) DEFAULT NULL,
  `currTime` datetime DEFAULT NULL,
  `finished` tinyint(1) DEFAULT NULL,
  `finishPercent` float DEFAULT NULL,
  `orderId` varchar(100) DEFAULT NULL,
  `actualDispatchTime` datetime DEFAULT NULL,
  `actualFinsihTime` datetime DEFAULT NULL,
  `unqualifiedCount` tinyint(4) DEFAULT NULL,
  `qualifiedCount` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKa8o29agwf9oaulsxl9e01purd` (`orderId`),
  CONSTRAINT `FKa8o29agwf9oaulsxl9e01purd` FOREIGN KEY (`orderId`) REFERENCES `rg_order` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `rg_plan`
-- ----------------------------
DROP TABLE IF EXISTS `rg_plan`;
CREATE TABLE `rg_plan` (
  `id` varchar(255) NOT NULL,
  `idTask` varchar(255) DEFAULT NULL,
  `idJob` varchar(60) DEFAULT NULL,
  `nameTask` varchar(100) DEFAULT NULL,
  `nameOrder` varchar(100) DEFAULT NULL,
  `nameJob` varchar(100) DEFAULT NULL,
  `nameResource` varchar(100) DEFAULT NULL,
  `nameGroupResource` varchar(100) DEFAULT NULL,
  `nameTypeResource` varchar(100) DEFAULT NULL,
  `nameSite` varchar(100) DEFAULT NULL,
  `nameProductOrder` varchar(100) DEFAULT NULL,
  `nameProvider` varchar(20) DEFAULT NULL,
  `ordToParentTask` smallint(6) DEFAULT NULL,
  `idTaskResourceSucc` varchar(100) DEFAULT NULL,
  `preemptiveTask` varchar(10) DEFAULT NULL,
  `divisibleTask` varchar(10) DEFAULT NULL,
  `continuousTask` varchar(10) DEFAULT NULL,
  `quantityTask` smallint(6) DEFAULT NULL,
  `quantityResourceTask` smallint(6) DEFAULT NULL,
  `quantityBatchTask` smallint(6) DEFAULT NULL,
  `qtySequence` smallint(6) DEFAULT NULL,
  `t1Task` varchar(50) DEFAULT NULL,
  `t2Task` varchar(50) DEFAULT NULL,
  `t2ExtendedTask` varchar(50) DEFAULT NULL,
  `advice` varchar(2000) DEFAULT NULL,
  `estimateTask` varchar(12) DEFAULT NULL,
  `timeTask` varchar(20) DEFAULT NULL,
  `initTimeTask` varchar(12) DEFAULT NULL,
  `unitTimeTask` varchar(12) DEFAULT NULL,
  `postTimeTask` varchar(12) DEFAULT NULL,
  `checkTimeTask` varchar(12) DEFAULT NULL,
  `idGroupResource0Task` varchar(20) DEFAULT NULL,
  `idResource0Task` varchar(20) DEFAULT NULL,
  `idSite0Task` varchar(20) DEFAULT NULL,
  `quantity0Task` smallint(6) DEFAULT NULL,
  `t10Task` varchar(20) DEFAULT NULL,
  `t20Task` varchar(20) DEFAULT NULL,
  `t20ExtendedTask` varchar(20) DEFAULT NULL,
  `t1Job` varchar(50) DEFAULT NULL,
  `t2Job` varchar(50) DEFAULT NULL,
  `quantityJob` smallint(6) DEFAULT NULL,
  `nbTaskJob` smallint(6) DEFAULT NULL,
  `refProductJob` varchar(100) DEFAULT NULL,
  `ordToRootJob` smallint(6) DEFAULT NULL,
  `OrdToRootChildJob` varchar(1000) DEFAULT NULL,
  `t1Order` varchar(20) DEFAULT NULL,
  `t2Order` varchar(20) DEFAULT NULL,
  `quantityOrder` smallint(6) DEFAULT NULL,
  `priorityOrder` smallint(6) DEFAULT NULL,
  `colorOrder` varchar(50) DEFAULT NULL,
  `state` tinyint(4) DEFAULT NULL,
  `idClub` varchar(255) DEFAULT NULL,
  `idProcess` varchar(100) DEFAULT NULL,
  `idOrder` varchar(100) DEFAULT NULL,
  `idResource` varchar(255) DEFAULT NULL,
  `idSite` varchar(255) DEFAULT NULL,
  `idGroupResource` varchar(255) DEFAULT NULL,
  `idTypeResource` varchar(100) DEFAULT NULL,
  `idProvider` varchar(20) DEFAULT NULL,
  `idProduct` varchar(100) DEFAULT NULL,
  `idSnapshort` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKj2b680ttv2p9uhr464jkuh95d` (`idClub`),
  KEY `FKr51o0jkupanwxp9x23mk7rgnp` (`idProcess`),
  KEY `FK8xfjq88w0mc3s7vrk47iv0w9s` (`idOrder`),
  KEY `FKrgqbi9dpmflij2hwbcyqd23lo` (`idResource`),
  KEY `FKnh0oqrnqfsaludqu8mw3jm58u` (`idSite`),
  KEY `FKmppcnp19mtapu7njnw7hxbi22` (`idGroupResource`),
  KEY `FK9rrmag4lv55y0ksowqygfcbbv` (`idTypeResource`),
  KEY `FKpaeuo6254jxwog4i1edt8kvpl` (`idProvider`),
  KEY `FK89brruc0f2dgljrp1j30ko2u5` (`idProduct`),
  KEY `FK99kwr4uyb80dwfpi1ym9f13w2` (`idSnapshort`),
  CONSTRAINT `FK89brruc0f2dgljrp1j30ko2u5` FOREIGN KEY (`idProduct`) REFERENCES `rg_product` (`id`),
  CONSTRAINT `FK8xfjq88w0mc3s7vrk47iv0w9s` FOREIGN KEY (`idOrder`) REFERENCES `rg_order` (`id`),
  CONSTRAINT `FK99kwr4uyb80dwfpi1ym9f13w2` FOREIGN KEY (`idSnapshort`) REFERENCES `rg_snapshot` (`id`),
  CONSTRAINT `FK9rrmag4lv55y0ksowqygfcbbv` FOREIGN KEY (`idTypeResource`) REFERENCES `rg_typerescource` (`id`),
  CONSTRAINT `FKj2b680ttv2p9uhr464jkuh95d` FOREIGN KEY (`idClub`) REFERENCES `rg_club` (`id`),
  CONSTRAINT `FKmppcnp19mtapu7njnw7hxbi22` FOREIGN KEY (`idGroupResource`) REFERENCES `rg_groupresource` (`id`),
  CONSTRAINT `FKnh0oqrnqfsaludqu8mw3jm58u` FOREIGN KEY (`idSite`) REFERENCES `rg_site` (`id`),
  CONSTRAINT `FKpaeuo6254jxwog4i1edt8kvpl` FOREIGN KEY (`idProvider`) REFERENCES `rg_provider` (`id`),
  CONSTRAINT `FKr51o0jkupanwxp9x23mk7rgnp` FOREIGN KEY (`idProcess`) REFERENCES `rg_process` (`id`),
  CONSTRAINT `FKrgqbi9dpmflij2hwbcyqd23lo` FOREIGN KEY (`idResource`) REFERENCES `rg_resource` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `rg_process`
-- ----------------------------
DROP TABLE IF EXISTS `rg_process`;
CREATE TABLE `rg_process` (
  `id` varchar(100) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `idRoot` varchar(255) DEFAULT NULL,
  `ordToRoot` smallint(6) DEFAULT NULL,
  `OrdToRootChild` varchar(100) DEFAULT NULL,
  `ordToParent` smallint(6) DEFAULT NULL,
  `typeShift` tinyint(4) DEFAULT NULL,
  `preemptive` varchar(1) DEFAULT NULL,
  `exclusiveJob` varchar(1) DEFAULT NULL,
  `exclusiveOrder` varchar(1) DEFAULT NULL,
  `coupledTypeOrder` varchar(1) DEFAULT NULL,
  `IdCoupled` varchar(200) DEFAULT NULL,
  `IdCoupledT1` varchar(200) DEFAULT NULL,
  `IdCoupledT2` varchar(200) DEFAULT NULL,
  `IdCoupledTypeShift` varchar(200) DEFAULT NULL,
  `IdCoupledShift` varchar(200) DEFAULT NULL,
  `IdCoupledGroupResource` varchar(200) DEFAULT NULL,
  `IdCoupledTypeResource` varchar(200) DEFAULT NULL,
  `IdCoupledResouce` varchar(200) DEFAULT NULL,
  `IdCoupledTypeSite` varchar(200) DEFAULT NULL,
  `IdCoupledSite` varchar(200) DEFAULT NULL,
  `Slot1` varchar(200) DEFAULT NULL,
  `Slot2` varchar(200) DEFAULT NULL,
  `initTime` smallint(6) DEFAULT NULL,
  `unitTime` smallint(6) DEFAULT NULL,
  `postTime` smallint(6) DEFAULT NULL,
  `checkTime` smallint(6) DEFAULT NULL,
  `delta` smallint(6) DEFAULT NULL,
  `estimate` smallint(6) DEFAULT NULL,
  `continuous` varchar(10) DEFAULT NULL,
  `IdExclusive` varchar(1000) DEFAULT NULL,
  `IdPrec` varchar(1000) DEFAULT NULL,
  `IdSucc` varchar(1000) DEFAULT NULL,
  `minTimeSucc` smallint(6) DEFAULT NULL,
  `maxTimeSucc` smallint(6) DEFAULT NULL,
  `quantity` smallint(6) DEFAULT NULL,
  `unitQuantity` smallint(6) DEFAULT NULL,
  `RG_switch` smallint(6) DEFAULT NULL,
  `minQtySwitch` smallint(6) DEFAULT NULL,
  `maxQtySwitch` smallint(6) DEFAULT NULL,
  `modQtySwitch` smallint(6) DEFAULT NULL,
  `IdSwitch` varchar(255) DEFAULT NULL,
  `maxResourceDivision` smallint(6) DEFAULT NULL,
  `minResourceDivision` smallint(6) DEFAULT NULL,
  `modResourceDivision` smallint(6) DEFAULT NULL,
  `minTimeDivision` smallint(6) DEFAULT NULL,
  `maxTimeDivision` smallint(6) DEFAULT NULL,
  `modTimeDivision` smallint(6) DEFAULT NULL,
  `minQtyDivision` smallint(6) DEFAULT NULL,
  `maxQtyDivision` smallint(6) DEFAULT NULL,
  `modQtyDivision` smallint(6) DEFAULT NULL,
  `minQtyBatch` smallint(6) DEFAULT NULL,
  `maxQtyBatch` smallint(6) DEFAULT NULL,
  `modQtyBatch` smallint(6) DEFAULT NULL,
  `minTimeBatch` smallint(6) DEFAULT NULL,
  `maxTimeBatch` smallint(6) DEFAULT NULL,
  `modTimeBatch` smallint(6) DEFAULT NULL,
  `batch` varchar(10) DEFAULT NULL,
  `idIcon` varchar(10) DEFAULT NULL,
  `nbTask` smallint(6) DEFAULT NULL,
  `rootProcess` tinyint(1) DEFAULT NULL,
  `transport` tinyint(1) DEFAULT NULL,
  `operation` varchar(20) DEFAULT NULL,
  `idProduct` varchar(100) DEFAULT NULL,
  `pId` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKnrnmmf156yqys8l0qv4bge4d4` (`idProduct`),
  KEY `FKoyklfymo8to0bjoxmi1ulpixm` (`pId`),
  CONSTRAINT `FKnrnmmf156yqys8l0qv4bge4d4` FOREIGN KEY (`idProduct`) REFERENCES `rg_product` (`id`),
  CONSTRAINT `FKoyklfymo8to0bjoxmi1ulpixm` FOREIGN KEY (`pId`) REFERENCES `rg_process` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `rg_processassisant`
-- ----------------------------
DROP TABLE IF EXISTS `rg_processassisant`;
CREATE TABLE `rg_processassisant` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `processId` varchar(255) DEFAULT NULL,
  `site` varchar(255) DEFAULT NULL,
  `task` varchar(255) DEFAULT NULL,
  `goods` varchar(255) DEFAULT NULL,
  `resource` varchar(255) DEFAULT NULL,
  `siteRource` varchar(255) DEFAULT NULL,
  `autoCreateNextProcess` varchar(255) DEFAULT NULL,
  `nextProcessTask` varchar(255) DEFAULT NULL,
  `nextProcessDistnces` varchar(255) DEFAULT NULL,
  `nextProcessSites` varchar(255) DEFAULT NULL,
  `nextProcessMobility` varchar(255) DEFAULT NULL,
  `nextProcessRefetTime` varchar(255) DEFAULT NULL,
  `autoCreatePreviouseProcess` varchar(255) DEFAULT NULL,
  `pDelayStartTime` varchar(255) DEFAULT NULL,
  `previousProcessTasks` varchar(255) DEFAULT NULL,
  `pAdvanceStartTime` varchar(255) DEFAULT NULL,
  `preProcessDistances` varchar(255) DEFAULT NULL,
  `preProcessSites` varchar(255) DEFAULT NULL,
  `preProcessMobility` varchar(255) DEFAULT NULL,
  `divisibleSite` varchar(255) DEFAULT NULL,
  `divisibleTask` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=497 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `rg_product`
-- ----------------------------
DROP TABLE IF EXISTS `rg_product`;
CREATE TABLE `rg_product` (
  `id` varchar(100) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `ref` varchar(255) DEFAULT NULL,
  `depth` varchar(255) DEFAULT NULL,
  `stock` smallint(6) DEFAULT NULL,
  `unit` varchar(20) DEFAULT NULL,
  `model` varchar(100) DEFAULT NULL,
  `state` varchar(20) DEFAULT NULL,
  `supplyMethod` varchar(20) DEFAULT NULL,
  `mesId` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `rg_provider`
-- ----------------------------
DROP TABLE IF EXISTS `rg_provider`;
CREATE TABLE `rg_provider` (
  `id` varchar(20) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `color` varchar(255) DEFAULT NULL,
  `idClub` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKsusxfo40gwa58q1ab9jpj8hje` (`idClub`),
  CONSTRAINT `FKsusxfo40gwa58q1ab9jpj8hje` FOREIGN KEY (`idClub`) REFERENCES `rg_club` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `rg_realdata`
-- ----------------------------
DROP TABLE IF EXISTS `rg_realdata`;
CREATE TABLE `rg_realdata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idResource` varchar(255) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `good` varchar(50) DEFAULT NULL,
  `startLocation` varchar(50) DEFAULT NULL,
  `endLocation` varchar(50) DEFAULT NULL,
  `valueType` varchar(50) DEFAULT NULL,
  `value` varchar(50) DEFAULT NULL,
  `idTask` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `rg_resource`
-- ----------------------------
DROP TABLE IF EXISTS `rg_resource`;
CREATE TABLE `rg_resource` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `idFeatureResource` varchar(100) DEFAULT NULL,
  `IdSiteGroupResource` varchar(100) DEFAULT NULL,
  `TypeSite` varchar(20) DEFAULT NULL,
  `mobility` smallint(6) DEFAULT NULL,
  `sameTypeSequence` varchar(20) DEFAULT NULL,
  `idSiteSequence` varchar(100) DEFAULT NULL,
  `quantity0` smallint(6) DEFAULT NULL,
  `critical` varchar(1) DEFAULT NULL,
  `NameShift` varchar(100) DEFAULT NULL,
  `Calendar` text,
  `Slot` varchar(200) DEFAULT NULL,
  `DateForbidden` varchar(100) DEFAULT NULL,
  `weekend` varchar(20) DEFAULT NULL,
  `color` varchar(50) DEFAULT NULL,
  `makespan` varchar(50) DEFAULT NULL,
  `rate` float DEFAULT NULL,
  `state` tinyint(4) DEFAULT NULL,
  `sizeIcon` tinyint(4) DEFAULT NULL,
  `idIcon` varchar(255) DEFAULT NULL,
  `idSite0` varchar(20) DEFAULT NULL,
  `unit` varchar(20) DEFAULT NULL,
  `assisantResource` varchar(255) DEFAULT NULL,
  `idGroupResource` varchar(255) DEFAULT NULL,
  `idUser` varchar(50) DEFAULT NULL,
  `idClub` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`idGroupResource`),
  KEY `FK5w027bft48w6o0q3ymlers6b7` (`idUser`),
  KEY `FKc3dh27mepwv8uars1c2n3pkat` (`idClub`),
  CONSTRAINT `FK5w027bft48w6o0q3ymlers6b7` FOREIGN KEY (`idUser`) REFERENCES `rg_user` (`id`),
  CONSTRAINT `FKc3dh27mepwv8uars1c2n3pkat` FOREIGN KEY (`idClub`) REFERENCES `rg_club` (`id`),
  CONSTRAINT `id` FOREIGN KEY (`idGroupResource`) REFERENCES `rg_groupresource` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `rg_resourcestate`
-- ----------------------------
DROP TABLE IF EXISTS `rg_resourcestate`;
CREATE TABLE `rg_resourcestate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idResource` varchar(255) DEFAULT NULL,
  `resourceName` varchar(100) DEFAULT NULL,
  `manufacturer` varchar(100) DEFAULT NULL,
  `idTask` varchar(50) DEFAULT NULL,
  `idProcess` varchar(60) DEFAULT NULL,
  `idClub` varchar(50) DEFAULT NULL,
  `idProduct` varchar(50) DEFAULT NULL,
  `productName` varchar(50) DEFAULT NULL,
  `t1Task` datetime DEFAULT NULL,
  `t2Task` datetime DEFAULT NULL,
  `currTime` datetime DEFAULT NULL,
  `t1RealTask` datetime DEFAULT NULL,
  `t2RealTask` datetime DEFAULT NULL,
  `state` tinyint(4) DEFAULT NULL,
  `bootstrapTime` float DEFAULT NULL,
  `awaitTime` float DEFAULT NULL,
  `processTime` float DEFAULT NULL,
  `resourceId` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKtltvd98rdu54bcbe3bykthqxi` (`resourceId`),
  CONSTRAINT `FKtltvd98rdu54bcbe3bykthqxi` FOREIGN KEY (`resourceId`) REFERENCES `rg_resource` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `rg_resourcetyperesource`
-- ----------------------------
DROP TABLE IF EXISTS `rg_resourcetyperesource`;
CREATE TABLE `rg_resourcetyperesource` (
  `id` varchar(60) NOT NULL,
  `maxCapacityParallel` int(11) DEFAULT NULL,
  `minCapacityParallel` int(11) DEFAULT NULL,
  `capacitySequence` int(11) DEFAULT NULL,
  `ratio` float DEFAULT NULL,
  `idResource` varchar(255) DEFAULT NULL,
  `idTypeResource` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKrmvbn2940pk167vv0xb6gk3bi` (`idResource`),
  KEY `FKh1j7vr9cm9yyb1jcf7ctuhyru` (`idTypeResource`),
  CONSTRAINT `FKh1j7vr9cm9yyb1jcf7ctuhyru` FOREIGN KEY (`idTypeResource`) REFERENCES `rg_typerescource` (`id`),
  CONSTRAINT `FKrmvbn2940pk167vv0xb6gk3bi` FOREIGN KEY (`idResource`) REFERENCES `rg_resource` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `rg_scheduleentity`
-- ----------------------------
DROP TABLE IF EXISTS `rg_scheduleentity`;
CREATE TABLE `rg_scheduleentity` (
  `id` varchar(60) NOT NULL,
  `name` varchar(60) DEFAULT NULL,
  `scheduleTime` datetime DEFAULT NULL,
  `startCalcTime` datetime DEFAULT NULL,
  `endCalcTime` datetime DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `progress` varchar(100) DEFAULT NULL,
  `scheduleWindow` int(11) DEFAULT NULL,
  `rollTime` int(11) DEFAULT NULL,
  `apsStartTime` datetime DEFAULT NULL,
  `apsEndTime` datetime DEFAULT NULL,
  `apsModel` varchar(50) DEFAULT NULL,
  `apsObj` varchar(50) DEFAULT NULL,
  `apsFlag` varchar(50) DEFAULT NULL,
  `layoutId` varchar(60) DEFAULT NULL,
  `scheduleOption` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK80b45574b4etkgl6qy8i8wphn` (`layoutId`),
  CONSTRAINT `FK80b45574b4etkgl6qy8i8wphn` FOREIGN KEY (`layoutId`) REFERENCES `rg_layout` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `rg_shift`
-- ----------------------------
DROP TABLE IF EXISTS `rg_shift`;
CREATE TABLE `rg_shift` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `type` tinyint(4) DEFAULT NULL,
  `Slot` varchar(255) DEFAULT NULL,
  `id0` varchar(20) DEFAULT NULL,
  `extra` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `rg_site`
-- ----------------------------
DROP TABLE IF EXISTS `rg_site`;
CREATE TABLE `rg_site` (
  `id` varchar(255) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `type` varchar(100) DEFAULT NULL,
  `x` smallint(6) DEFAULT NULL,
  `y` smallint(6) DEFAULT NULL,
  `color` varchar(50) DEFAULT NULL,
  `idIcon` varchar(50) DEFAULT NULL,
  `sizeIcon` smallint(6) DEFAULT NULL,
  `capacity` smallint(6) DEFAULT NULL,
  `groupresourceId` varchar(255) DEFAULT NULL,
  `mesId` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK3fg795kd2hsrsvs828mqsi365` (`groupresourceId`),
  CONSTRAINT `FK3fg795kd2hsrsvs828mqsi365` FOREIGN KEY (`groupresourceId`) REFERENCES `rg_groupresource` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `rg_sitetype`
-- ----------------------------
DROP TABLE IF EXISTS `rg_sitetype`;
CREATE TABLE `rg_sitetype` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `resource` varchar(255) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `x` int(11) DEFAULT NULL,
  `y` int(11) DEFAULT NULL,
  `color` varchar(50) DEFAULT NULL,
  `idIcon` varchar(50) DEFAULT NULL,
  `sizeIcon` int(11) DEFAULT NULL,
  `capacity` int(11) DEFAULT NULL,
  `layoutType` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `rg_snapshot`
-- ----------------------------
DROP TABLE IF EXISTS `rg_snapshot`;
CREATE TABLE `rg_snapshot` (
  `id` varchar(100) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `apply` tinyint(1) DEFAULT NULL,
  `level` varchar(255) DEFAULT NULL,
  `nodeCreateTime` datetime DEFAULT NULL,
  `errorNode` tinyint(1) DEFAULT NULL,
  `firstNode` tinyint(1) DEFAULT NULL,
  `apsBackupSnaoshot` tinyint(1) DEFAULT NULL,
  `apsDispatchOrder` tinyint(1) DEFAULT NULL,
  `apsRecoverSnapshot` tinyint(1) DEFAULT NULL,
  `apsInteractive` tinyint(1) DEFAULT NULL,
  `s_id` varchar(100) DEFAULT NULL,
  `rootParent` varchar(100) DEFAULT NULL,
  `schedule` varchar(60) DEFAULT NULL,
  `dispatchMesTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_2oe7sqvk1jds2l5nno1lyr8hr` (`schedule`),
  KEY `FKgtupvltxgu27olpxjoas46l32` (`s_id`),
  KEY `FKfx2ber43pviws27jiu3bn6xhd` (`rootParent`),
  CONSTRAINT `FK5pfua37ik2j2qgaow258df8df` FOREIGN KEY (`schedule`) REFERENCES `rg_scheduleentity` (`id`),
  CONSTRAINT `FKfx2ber43pviws27jiu3bn6xhd` FOREIGN KEY (`rootParent`) REFERENCES `rg_snapshot` (`id`),
  CONSTRAINT `FKgtupvltxgu27olpxjoas46l32` FOREIGN KEY (`s_id`) REFERENCES `rg_snapshot` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `rg_state3d`
-- ----------------------------
DROP TABLE IF EXISTS `rg_state3d`;
CREATE TABLE `rg_state3d` (
  `id` int(11) NOT NULL,
  `layoutState` int(11) DEFAULT NULL,
  `layoutId` varchar(50) DEFAULT NULL,
  `model` int(11) DEFAULT NULL,
  `snapshotId` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `rg_task`
-- ----------------------------
DROP TABLE IF EXISTS `rg_task`;
CREATE TABLE `rg_task` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `rg_typerescource`
-- ----------------------------
DROP TABLE IF EXISTS `rg_typerescource`;
CREATE TABLE `rg_typerescource` (
  `id` varchar(100) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `attribute` varchar(20) DEFAULT NULL,
  `ratio` float DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `rg_user`
-- ----------------------------
DROP TABLE IF EXISTS `rg_user`;
CREATE TABLE `rg_user` (
  `id` varchar(50) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `idClient` varchar(20) DEFAULT NULL,
  `idProvider` varchar(20) DEFAULT NULL,
  `authority` tinyint(2) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `idClub` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKklylhnka5t437roqj55n70vyl` (`idClub`),
  CONSTRAINT `FKklylhnka5t437roqj55n70vyl` FOREIGN KEY (`idClub`) REFERENCES `rg_club` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `rg_userconfig`
-- ----------------------------
DROP TABLE IF EXISTS `rg_userconfig`;
CREATE TABLE `rg_userconfig` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `latestScheduleId` varchar(100) DEFAULT NULL,
  `currScheduleId` varchar(100) DEFAULT NULL,
  `rootSnapshotId` varchar(100) DEFAULT NULL,
  `middleSnapshotId` varchar(100) DEFAULT NULL,
  `bottomSnapshotId` varchar(100) DEFAULT NULL,
  `errorSchedule` tinyint(1) DEFAULT NULL,
  `apsReplyCount` int(11) DEFAULT NULL,
  `resetApsTable` tinyint(1) DEFAULT NULL,
  `errorType` varchar(100) DEFAULT NULL,
  `errorId` varchar(100) DEFAULT NULL,
  `idUser` varchar(50) DEFAULT NULL,
  `dispatchMesSnapshotId` varchar(100) DEFAULT NULL,
  `factoryLayoutId` varchar(255) DEFAULT NULL,
  `apsCurrSnapshotId` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKloq3j4t4pl2sxhwdatouo5cg4` (`idUser`),
  CONSTRAINT `FKloq3j4t4pl2sxhwdatouo5cg4` FOREIGN KEY (`idUser`) REFERENCES `rg_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `rg_warn`
-- ----------------------------
DROP TABLE IF EXISTS `rg_warn`;
CREATE TABLE `rg_warn` (
  `id` varchar(255) NOT NULL,
  `warnDesc` varchar(255) DEFAULT NULL,
  `warnLevel` varchar(255) DEFAULT NULL,
  `finished` varchar(255) DEFAULT NULL,
  `warnType` varchar(255) DEFAULT NULL,
  `warnId` varchar(255) DEFAULT NULL,
  `warnDate` varchar(255) DEFAULT NULL,
  `procDate` varchar(255) DEFAULT NULL,
  `idWarn` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKiw92tmrtx78swwtffh97yr4k5` (`idWarn`),
  CONSTRAINT `FKiw92tmrtx78swwtffh97yr4k5` FOREIGN KEY (`idWarn`) REFERENCES `rg_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `schedule_groupresource`
-- ----------------------------
DROP TABLE IF EXISTS `schedule_groupresource`;
CREATE TABLE `schedule_groupresource` (
  `g_id` varchar(255) NOT NULL,
  `s_id` varchar(60) NOT NULL,
  PRIMARY KEY (`s_id`,`g_id`),
  KEY `FKfipamu5gr3vgxsb64l9lstx76` (`g_id`),
  CONSTRAINT `FKfipamu5gr3vgxsb64l9lstx76` FOREIGN KEY (`g_id`) REFERENCES `rg_groupresource` (`id`),
  CONSTRAINT `FKqvf2886cg6dktiehvanoubvxx` FOREIGN KEY (`s_id`) REFERENCES `rg_scheduleentity` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `schedule_order`
-- ----------------------------
DROP TABLE IF EXISTS `schedule_order`;
CREATE TABLE `schedule_order` (
  `o_id` varchar(100) NOT NULL,
  `s_id` varchar(60) NOT NULL,
  PRIMARY KEY (`s_id`,`o_id`),
  KEY `FKh3r7vbsm5rmhypbx20oj5pshy` (`o_id`),
  CONSTRAINT `FKh3r7vbsm5rmhypbx20oj5pshy` FOREIGN KEY (`o_id`) REFERENCES `rg_order` (`id`),
  CONSTRAINT `FKt0yh4u215thk7xidbino7vh7u` FOREIGN KEY (`s_id`) REFERENCES `rg_scheduleentity` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `schedule_resource`
-- ----------------------------
DROP TABLE IF EXISTS `schedule_resource`;
CREATE TABLE `schedule_resource` (
  `r_id` varchar(255) NOT NULL,
  `s_id` varchar(60) NOT NULL,
  PRIMARY KEY (`s_id`,`r_id`),
  KEY `FKnsspq5jetp407m4gvh8vwg1vn` (`r_id`),
  CONSTRAINT `FKhc1m1fjpvg5y2wokiy9rb19ub` FOREIGN KEY (`s_id`) REFERENCES `rg_scheduleentity` (`id`),
  CONSTRAINT `FKnsspq5jetp407m4gvh8vwg1vn` FOREIGN KEY (`r_id`) REFERENCES `rg_resource` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `schedule_site`
-- ----------------------------
DROP TABLE IF EXISTS `schedule_site`;
CREATE TABLE `schedule_site` (
  `site_id` varchar(255) NOT NULL,
  `s_id` varchar(60) NOT NULL,
  PRIMARY KEY (`s_id`,`site_id`),
  KEY `FKi72fn2asp3xwrffdihkqhbkvi` (`site_id`),
  CONSTRAINT `FKi72fn2asp3xwrffdihkqhbkvi` FOREIGN KEY (`site_id`) REFERENCES `rg_site` (`id`),
  CONSTRAINT `FKlw8ykn61cc9g1csakql6fqly6` FOREIGN KEY (`s_id`) REFERENCES `rg_scheduleentity` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `shift_resource`
-- ----------------------------
DROP TABLE IF EXISTS `shift_resource`;
CREATE TABLE `shift_resource` (
  `shift_id` varchar(255) NOT NULL,
  `resource_id` varchar(255) NOT NULL,
  PRIMARY KEY (`resource_id`,`shift_id`),
  KEY `FK1mvd31l0taq6ktrc80go7k497` (`shift_id`),
  CONSTRAINT `FK1mvd31l0taq6ktrc80go7k497` FOREIGN KEY (`shift_id`) REFERENCES `rg_shift` (`id`),
  CONSTRAINT `FKl7093n6otd4kogk9e8ldhk2bw` FOREIGN KEY (`resource_id`) REFERENCES `rg_resource` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `site_resource`
-- ----------------------------
DROP TABLE IF EXISTS `site_resource`;
CREATE TABLE `site_resource` (
  `site_id` varchar(255) NOT NULL,
  `resource_id` varchar(255) NOT NULL,
  PRIMARY KEY (`resource_id`,`site_id`),
  KEY `FK5g2bii5t0rl21klepgrhcgcbi` (`site_id`),
  CONSTRAINT `FK5g2bii5t0rl21klepgrhcgcbi` FOREIGN KEY (`site_id`) REFERENCES `rg_site` (`id`),
  CONSTRAINT `FK7q58pivokrorrd14a4sl1wvkv` FOREIGN KEY (`resource_id`) REFERENCES `rg_resource` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `test`
-- ----------------------------
DROP TABLE IF EXISTS `test`;
CREATE TABLE `test` (
  `a` char(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `typeresource_resource`
-- ----------------------------
DROP TABLE IF EXISTS `typeresource_resource`;
CREATE TABLE `typeresource_resource` (
  `resource_id` varchar(255) NOT NULL,
  `typeresource_id` varchar(100) NOT NULL,
  PRIMARY KEY (`resource_id`,`typeresource_id`),
  KEY `FK46jagkyreejf9rrbh9buux5es` (`typeresource_id`),
  CONSTRAINT `FK46jagkyreejf9rrbh9buux5es` FOREIGN KEY (`typeresource_id`) REFERENCES `rg_typerescource` (`id`),
  CONSTRAINT `FKo9r1bg9593coiqnmsmu48cfr5` FOREIGN KEY (`resource_id`) REFERENCES `rg_resource` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records 
-- ----------------------------
INSERT INTO `rg_club` VALUES ('001','Assembly System');
INSERT INTO `rg_distance` VALUES ('0275bf42-fd9e-494c-bfe8-0671f5cdfea7','XBC01','RJXZPT_02','20','10'), ('05233ce3-93e1-487c-9811-0caa95e93ed5','RJXZ','TKD-L','80','0'), ('06293ecd-9e18-45ab-95e6-d33570c8861b','MTJDJC','RJXZ','60','0'), ('065541f9-e713-48f4-ba3c-f3487a362b14','AssembleAccuracyTest','XZTP-R','60','30'), ('08b028de-4723-4b6e-8458-7a1ae0c21fd2','AssembleAccuracyTest','RJXZPT_01','20','10'), ('08b2e2c5-59ca-4fbf-a3e4-13aec02a532d','ZHDXNJC','XBC','40','0'), ('09647588-2a48-4238-a59e-a73b4fd4f2ca','CCJDJC','MTJDJC','20','0'), ('0aef0643-2b2f-482e-be25-921f0f5d534b','RJXZPT_01','OnlineTest','60','30'), ('0c6204b8-fb91-4615-afad-36afd87e25de','MTJDJC','XBC','80','0'), ('0df99cc1-d711-407e-a5da-25690fd6cd28','ZNZPPT_01','UR5','60','30'), ('104a7ab5-0525-4c29-9a8a-4ff1dbf61c6e','ZNZPPT_01','OnlineTest','80','40'), ('139c931e-ba28-4898-ad04-927758bed8d3','XBC01','UR5','60','30'), ('1733b69f-e8a2-4dd3-a6ff-0af7febb9a5b','CCJDJC','XBC','60','0'), ('1768541d-4dc8-4084-acc8-e96bf956c321','CK01','XZTP-R','120','60'), ('177a7a51-acfc-46aa-9648-7fb667e8af7b','RJXZPT_01','ZNZPPT_01','20','10'), ('1c02a249-a069-48b5-9300-fc53c6cfc1e6','XZTP-R','RJXZPT_02','40','20'), ('1c9accd4-d1f0-40f2-a2c0-a3d7a881ce53','MTJDJC','ZNZP','80','0'), ('1ed7153b-6f09-44a0-ad8b-8c328a422217','RJXZPT_02','AssembleAccuracyTest','20','10'), ('231e889b-af6e-4fe4-98a9-90d302e29488','RJXZ','ZHDXNJC','20','0'), ('244a47f8-3d96-4c5c-a735-55a2f449e7c0','ZNZPPT_01','RJXZPT_01','20','10'), ('25158838-bd6c-419e-99d1-c82feb0fb18b','RJXZPT_01','ZNZPPT_02','20','10'), ('28edcf87-73f6-4f17-8f5c-4ba58f6aaf96','RJXZPT_02','UR5','40','20'), ('290411e4-e597-43a4-96e5-4d56d0bf1f67','RJXZPT_02','RJXZPT_01','0','0'), ('29f57220-0a14-4cf2-9fa6-a32b19b45892','MTJDJC','TKD-R','100','0'), ('2b2a40a8-3a66-433f-bbd5-f408314636dd','TKD-L','XBC','100','0'), ('2b3e1f3a-dfe3-435d-ab3f-b731e977045c','RJXZ','MTJDJC','60','0'), ('2e45ab38-0a74-4e9c-bd6b-c7ef82dc9806','XBC','MTJDJC','80','0'), ('2e5af58d-3636-4e75-b99b-ab839d25e0af','TKD-L','ZNZP','100','0'), ('32121eab-6a15-43be-9332-f0248fcbb300','XBC01','XZTP-L','100','50'), ('35bbf963-5f21-4ad5-a5be-bb0b5043ea05','UR5','RJXZPT_01','40','20'), ('371258d9-df7b-4ebf-a0b5-1761bd66df29','MTJDJC','CCJDJC','20','0'), ('3abeb865-d858-45cb-8b7b-a57ac849952a','MTJDJC','TKD-L','20','0'), ('3b455134-163a-4dbe-984e-a41999b52659','ZHDXNJC','RJXZ','20','0'), ('3bf814db-591e-4760-bf33-8e3f437eaf8f','RJXZPT_02','ZNZPPT_02','20','10'), ('3ec4d9a4-ab8f-4452-8576-14ae2773ec3a','RJXZ','ZNZP','20','0'), ('3fb1cda7-1b5d-4574-b701-bc264ccc1557','ZNZP','ZHDXNJC','40','0'), ('42513f6c-922c-4b19-be2b-82eea0caebc0','AssembleAccuracyTest','RJXZPT_02','20','10'), ('42d3f35e-d670-4917-baeb-4664e60613f8','XZTP-R','XZTP-L','120','60'), ('445b1037-e16f-4a68-9035-5a6d41341235','ZHDXNJC','ZNZP','40','0'), ('44701a4e-3c42-4f93-af04-957086d6c1e8','TKD-R','MTJDJC','100','0'), ('449869f3-3931-493e-9f90-81b5c84254af','RJXZ','CCJDJC','40','0'), ('44f75ae6-db30-4f64-ac25-5478d6bd27a6','ZNZPPT_02','RJXZPT_01','20','10'), ('452b22d9-f505-418e-a2bf-6c33dd815d19','TKD-L','ZHDXNJC','60','0'), ('4901abd6-b769-4880-b24c-30e059aa1dbd','XBC01','AssembleAccuracyTest','40','20'), ('4bd20aa0-9be6-4c51-8298-a0ca37cf853e','XZTP-L','RJXZPT_01','80','40'), ('4e678fb6-8481-4393-b7cd-f7cecda54128','RJXZ','TKD-R','40','0'), ('4f0e63ee-a859-4909-ba35-b555d8877877','ZNZPPT_02','RJXZPT_02','20','10'), ('505ff49e-8068-4feb-bd09-faeae8c8dd7c','UR5','AssembleAccuracyTest','20','10'), ('50b060c0-ac84-47db-b8ea-0449358bad70','ZNZPPT_02','XZTP-L','100','50'), ('51073e82-1203-40f6-bd02-250a2f31e824','CCJDJC','TKD-L','40','0'), ('511b3029-c88d-460a-abf1-c03dd9297739','TKD-R','CK','120','0'), ('5170ed09-a83b-4a18-a64d-038b30ad6a80','XZTP-L','ZNZPPT_02','100','50'), ('5359682e-9781-40b8-bb61-a76073c89557','XBC01','OnlineTest','80','40'), ('550b99b2-19b9-4ca2-839f-0bd0b1a9ecb2','RJXZPT_02','XBC01','20','10'), ('55744701-e894-4e30-851c-13c22ff308df','RJXZPT_01','XZTP-R','40','20'), ('5715e52e-2d2a-489b-b5da-7f25d47fd624','AssembleAccuracyTest','ZNZPPT_01','40','20'), ('5e04ab0a-e2b3-42fb-b0d1-50b58bd0e740','XZTP-R','RJXZPT_01','40','20'), ('61e9ec65-990c-4393-9973-40fe7b25bc65','ZNZP','TKD-R','20','0'), ('627aadfd-365b-457b-aae9-57cb935e8e0a','OnlineTest','XZTP-L','20','10'), ('675f548f-2020-44d7-a149-0b01cc72d032','OnlineTest','RJXZPT_01','60','30'), ('680e147a-6439-4009-b576-ca183c511c9c','RJXZPT_02','OnlineTest','60','30'), ('68345340-ce54-488b-bafb-d0589d28cdf8','TKD-R','CCJDJC','80','0'), ('6930ea5a-459e-467e-860b-0c6e2080d42d','XZTP-R','OnlineTest','100','50'), ('6adcbcd2-9bc8-42d3-a111-823d30acd76d','UR5','ZNZPPT_01','60','30'), ('6b96c47e-ea7e-410b-8098-671022535863','XZTP-L','UR5','40','20'), ('6e5eacb4-8724-4759-80dc-0fd86517be4d','MTJDJC','ZHDXNJC','40','0'), ('71e088da-c042-4e97-8ff7-261ba97410d8','ZNZPPT_01','AssembleAccuracyTest','40','20'), ('72b69acc-97cd-40b3-97d8-e2b6c4dbed05','TKD-R','RJXZ','40','0'), ('73fec417-c40d-4002-b561-654a0e971f5d','ZNZPPT_02','ZNZPPT_01','0','0'), ('7433e7c1-2aec-4358-9821-b907817f5bd1','TKD-R','ZNZP','20','0'), ('76b61ca0-8c53-4fc5-a8f7-eaff4ad05b1d','XZTP-L','OnlineTest','20','10'), ('774f6a15-922b-43b9-9b39-24bde4a8cea1','TKD-L','TKD-R','120','0'), ('77522037-e0fd-457e-b304-94b5993e0f55','ZNZP','RJXZ','20','0'), ('7ac436c7-34e8-4fc3-9c37-76f26c738508','OnlineTest','ZNZPPT_01','80','40'), ('7b6e0f22-80c9-4d19-8ac2-5c1e4903198d','ZNZPPT_01','ZNZPPT_02','0','0'), ('7bf18b33-f3df-4354-9688-a6e891462fe7','UR5','RJXZPT_02','40','20'), ('7ded3d94-590b-41a8-b12f-5346d7e282c5','ZNZPPT_01','XZTP-R','20','10'), ('7e35b1c2-abfb-45c0-ab91-37d4b1f662a6','XBC01','ZNZPPT_02','0','0'), ('7f2686be-db1a-4d3d-ace4-7b74c4b61f6f','ZNZP','MTJDJC','80','0'), ('7f550f25-1f8d-440b-a2b9-1ddbb0f2910d','XZTP-L','XZTP-R','120','60'), ('80b5cb70-467c-4d4b-ac07-74600fd4e8f7','CK','TKD-L','120','0'), ('82c91b27-4933-4d52-afe4-88d9311eda1d','RJXZPT_02','ZNZPPT_01','20','10'), ('858f02c1-436a-4ed0-bd81-f540b775780b','UR5','XZTP-R','80','40'), ('85d82c2a-edb9-47b0-9e62-c8e70128c6e9','CCJDJC','TKD-R','80','0'), ('86464bdc-1247-47c6-85ef-75606ff552cc','RJXZ','XBC','20','0'), ('89bb63b2-8ae2-4d69-9e43-a98579a46723','TKD-L','RJXZ','80','0'), ('91816c67-aa9e-4e60-957a-6cd762898007','ZNZPPT_01','RJXZPT_02','20','10'), ('93caf5c9-3d6f-43d9-a982-4c28c7a50500','UR5','OnlineTest','20','10'), ('953e1123-e538-46f7-9873-b08007c7c92d','ZNZPPT_02','AssembleAccuracyTest','40','20'), ('967b5770-4504-40d8-b96f-a53d0bd5d35d','TKD-R','ZHDXNJC','60','0'), ('96fd2e69-318f-4e82-a5df-394e16cb430c','XZTP-L','XBC01','100','50'), ('975516a4-de7d-433f-bbc3-8f3a51bcf227','UR5','XZTP-L','40','20'), ('98c540e3-4d0f-4a54-91c6-c79b6fd9ff48','OnlineTest','XBC01','80','40'), ('9cb69569-4816-4967-996f-57420a426677','XBC','CCJDJC','60','0'), ('9cca4bc7-4634-4471-9a61-c6c3a3f51721','TKD-R','XBC','20','0'), ('a0f72854-32ec-45da-8c72-91a550a2073b','ZNZPPT_01','XBC01','0','0'), ('a21d3ddb-d143-441e-8f0e-2f3b042e1a11','RJXZPT_01','UR5','40','20'), ('a372d321-8a84-4c14-8cf7-4144998b569f','XBC','ZNZP','0','0'), ('a7e3fefe-de27-4496-a3db-6f7a669e34c7','UR5','XBC01','60','30'), ('a9755d9b-a306-4c70-b514-d453432f9973','OnlineTest','ZNZPPT_02','80','40');
INSERT INTO `rg_distance` VALUES ('aab4f178-7aa9-41e5-9513-bdd53997ec80','XBC','TKD-L','100','0'), ('ab138b37-c856-4179-a34e-aeb13cfa57df','ZNZPPT_02','UR5','60','30'), ('ad391417-9752-4ead-8eac-11216c187507','RJXZPT_02','XZTP-R','40','20'), ('adcb706c-5a5d-4909-85f8-2f509654d973','OnlineTest','RJXZPT_02','60','30'), ('b12d54f5-313b-4505-b8df-848474d292d4','TKD-R','TKD-L','120','0'), ('b389d2d6-020d-4f1c-adc2-9c57d192d452','UR5','ZNZPPT_02','60','30'), ('b4dec6b5-c80e-48ba-9ae9-80964662af7b','OnlineTest','AssembleAccuracyTest','40','20'), ('b4fb2a3b-0ccc-401d-8a40-e6a82a1b83f8','ZNZP','XBC','0','0'), ('b726f940-6d88-453a-92d5-1668a9d65f32','ZNZPPT_02','XBC01','0','0'), ('b7435957-959d-4883-b958-e7331c908080','RJXZPT_02','XZTP-L','80','40'), ('bb129031-062c-4a3b-8b3c-cab37eb2ff42','ZHDXNJC','CCJDJC','20','0'), ('bbcde753-510b-4776-b484-18315cc260cd','XZTP-R','ZNZPPT_02','20','10'), ('c127d360-6bf8-48ea-b536-9c338e3311ab','ZHDXNJC','TKD-R','60','0'), ('c1abc18c-1e30-42ad-9b58-98e083979a99','XZTP-L','CK01','120','60'), ('c46a8969-c37d-4216-994e-2b911d3d614d','CCJDJC','RJXZ','40','0'), ('c59929c9-48d7-4bae-baa4-c08dfa546952','OnlineTest','UR5','20','10'), ('c5a5dd00-45d8-4b2c-9d1a-4deae86de7aa','XBC','RJXZ','20','0'), ('c6d03d5d-2a4e-429d-9b57-9e88b5495a48','XZTP-L','AssembleAccuracyTest','60','30'), ('c7b768e5-8947-41fb-b79f-c4c151806ba0','CCJDJC','ZHDXNJC','20','0'), ('c96ba810-58f3-43aa-aeb8-f4b5d90db41e','CK01','XZTP-L','120','60'), ('c9dd06da-177f-4bd1-bb98-d957b70103fd','TKD-L','CK','120','0'), ('ca9c34d8-c32a-4412-91f3-b4112460ddaf','CK','TKD-R','120','0'), ('cccb712b-4187-4ce2-be18-3cf220ca84c8','RJXZPT_01','XBC01','20','10'), ('cfa4b977-885d-440f-b2e4-77abee448db7','XZTP-R','CK01','120','60'), ('d04a95f2-770f-4d2d-9ea0-410a16ed86ca','ZNZPPT_02','XZTP-R','20','10'), ('d0dc5ac5-6a82-4a1f-80ea-5549104030ca','ZNZP','TKD-L','100','0'), ('d8121faa-bd6d-45de-8857-d0070e4071f5','ZNZPPT_01','XZTP-L','100','50'), ('d994623a-01a1-4161-892a-7c04d255b67d','AssembleAccuracyTest','XBC01','40','20'), ('d9e75b98-cbe5-4cdc-9648-be5e87a1abbd','XBC','ZHDXNJC','40','0'), ('da9299e0-f903-45b9-be9a-372ea16a7102','XZTP-R','XBC01','20','10'), ('dbe3f59b-746e-470d-b5ab-f41812cc1d09','CCJDJC','ZNZP','60','0'), ('dc56f2b0-0155-45ac-9987-2e562c47f249','RJXZPT_01','XZTP-L','80','40'), ('de036a52-d027-4537-bc13-64e4cbce6660','XZTP-L','RJXZPT_02','80','40'), ('de7b5256-6e27-487e-81b5-97913aab2392','AssembleAccuracyTest','ZNZPPT_02','40','20'), ('df33bc6a-ef3b-4b1c-b498-b9dbeb4d97be','XZTP-R','ZNZPPT_01','20','10'), ('e1413411-b1d5-4a54-b494-dffa4eb02128','ZHDXNJC','TKD-L','60','0'), ('e1f61008-597a-478b-8e0a-e58069371dfb','AssembleAccuracyTest','XZTP-L','60','30'), ('e4a185df-0320-4709-9e1c-9bd07b9957db','OnlineTest','XZTP-R','100','50'), ('e5c90bef-3a19-4df0-975f-540ddcbf0f0c','TKD-L','CCJDJC','40','0'), ('e6693ce1-c9d6-4248-8b92-23b8e07fa6e1','XBC01','ZNZPPT_01','0','0'), ('e6b95a46-6a65-4a41-825e-e4f85e4b04ea','AssembleAccuracyTest','OnlineTest','40','20'), ('e8bb995c-ae3f-4977-b432-df6b9f8b7555','XZTP-L','ZNZPPT_01','100','50'), ('e8c54dd8-1d9d-4154-a42d-70fbbdb3a45e','RJXZPT_01','RJXZPT_02','0','0'), ('eadff843-b124-47a4-89bf-c081cbe66dea','ZNZP','CCJDJC','60','0'), ('eaf6f430-5f74-44b2-93f6-78084464dc21','XZTP-R','AssembleAccuracyTest','60','30'), ('ebb2a63c-4a22-4686-ade4-5369a4c61318','XBC01','XZTP-R','20','10'), ('eea9cb4a-5bfa-4ce2-a962-e18ce452f25d','XZTP-R','UR5','80','40'), ('f204c96b-67f3-427f-9049-7da4fdacbd5b','ZHDXNJC','MTJDJC','40','0'), ('f3521d1d-5a57-4437-a335-91508782ca86','TKD-L','MTJDJC','20','0'), ('f4131bf2-01fc-4fcf-9b36-5879844fc8c6','RJXZPT_01','AssembleAccuracyTest','20','10'), ('f70f8bc3-d77c-42af-a6fa-02a592306c39','XBC','TKD-R','20','0'), ('f821e2ce-0847-4da0-857c-6ee97d8911a6','AssembleAccuracyTest','UR5','20','10'), ('f9a5c0ab-b832-466c-816f-13d0ac02ffd7','ZNZPPT_02','OnlineTest','80','40'), ('ff6ddfcf-eacc-4d7a-bcd9-3a2b62c977dd','XBC01','RJXZPT_01','20','10');
INSERT INTO `rg_groupresource` VALUES ('G01','Group 01',NULL,NULL,'1',NULL,'{CK,CK01,TKD-L,TKD-R,RJXZ,RJXZpt-01,RJXZpt-02,XBC,XBC01,ZNZP,ZNZPpt-01,ZNZPpt-02,ZHDXNJC,ZHDXNJCsb-01,ZHDXNJCsb-02,CCJDJC,CCJDJCsb-01,CCJDJCsb-02,MTJDJC,MTJDJCsb-01,MTJDJCsb-02}',NULL);
INSERT INTO `rg_layout` VALUES ('1','Layout1','layout1.png','该布局属于基础设备布局，包含了智能装配平台、人机协作平台等设备。'), ('331543b2-8576-4788-839c-d54f29940326','layout3','layout3.png','该布局包含了2台只能装配中心、2台人机协作平台等设备。'), ('9f8ae5e1-debf-4d5e-bd06-2d8fef47858b','layout2','layout2.png','该布局包含了2台智能装配中心、1台人机协作平台等设备。'), ('eea88e68-3968-432a-b193-92318854b00b','layout4','layout4.png','该布局包含了1台智能装配中心、2台人机协作平台等设备。');
INSERT INTO `rg_layoutdetail` VALUES ('002f5f25-8cf4-4300-be1a-73f39728630c','vediojet_8510','3.981,0,-0.813','running','true','1'), ('00aasdf5-8sdf4-4300-be1a-73fsdfa8630c','AssembleAccuracyTest','1.43,0,1.89','running','true','1'), ('00af5f25-8cf4-4300-be1a-73f393s630c','ZNZPPT_02','0,0,0','running','false','1'), ('00af5f25-8cf4-4300-be1a-73fsdasf630c','UR5','-0.06,0,1.72','running','true','1'), ('00af5f25-8cf4-4300-be1a-73sdfa28630c','OnlineTest','3.51,0,1.82','running','true','1'), ('00af5f25-8cf4-4we0-beww-73f39728630c','RJXZPT_02','-2.37,0,-1.2','running','false','1'), ('00af5f25-8csd4-4300-be1a-73f39728630c','AGV_R','-2.947653,0,-5.149962','running','true','1'), ('00afef25-8cf4-4300-be1a-73f39728630c','AGV_L','5.14,0,0.32','running','true','1'), ('00as8cf4-4300-be1a-73f3-9728630sdc','ZNZPPT_01','-5.09,0,1.88','running','true','1'), ('00asdfikf4-4300-be1a-73f39wad30c','KR16_MG','-5.4,0,0.29','running','true','1'), ('04ebcf32-a15b-4377-b33b-6e959f809512','ZNZPPT_01','-5.09,0,1.88','running','true','9f8ae5e1-debf-4d5e-bd06-2d8fef47858b'), ('0afsga25-8cf4-4300-be1a-73f39728630c','KR16_CQ','0,0,-5.1','running','true','1'), ('0ef89923-4167-49c3-a17a-46e77006c58d','AssembleAccuracyTest','1.43,0,1.89','running','true','331543b2-8576-4788-839c-d54f29940326'), ('0wez5f25-8cf4-4300-be1a-73f39sda30c','RJXZPT_01','-2.37,0,1.75','running','true','1'), ('19e91921-f329-4d73-a27a-57afe59aebb9','RJXZPT_02','-2.37,0,-1.2','running','true','331543b2-8576-4788-839c-d54f29940326'), ('1ce8e96b-6459-4a3c-8e35-b748ca7f734a','AGV_L','5.14,0,0.32','running','true','eea88e68-3968-432a-b193-92318854b00b'), ('2191d53b-03d7-49db-b347-f31833210925','AGV_L','5.14,0,0.32','running','true','9f8ae5e1-debf-4d5e-bd06-2d8fef47858b'), ('2398530c-dd79-4ee4-a7fb-69f66a89154e','KR16_CQ','0,0,-5.1','running','true','9f8ae5e1-debf-4d5e-bd06-2d8fef47858b'), ('26b45cbc-6151-4306-a90d-1dee863a25cd','AGV_R','-2.947653,0,-5.149962','running','true','eea88e68-3968-432a-b193-92318854b00b'), ('307274b1-b948-4cf2-b1bd-72a8a4b86f02','vediojet_8510','3.981,0,-0.813','running','true','331543b2-8576-4788-839c-d54f29940326'), ('31793547-1cdf-4513-9e2e-938dc637654b','AGV_R','-2.947653,0,-5.149962','running','true','331543b2-8576-4788-839c-d54f29940326'), ('31aa06d7-32fc-4a25-8444-3bf1221b9257','ZNZPPT_01','-5.09,0,1.88','running','true','eea88e68-3968-432a-b193-92318854b00b'), ('3334c29c-82fb-49c4-bc46-6e2abdc26e34','XBC','-0.06,0,-0.99','running','true','331543b2-8576-4788-839c-d54f29940326'), ('519a1b4d-7b0a-48bb-8b03-cca3402065a0','KR16_MG','-5.4,0,0.29','running','true','331543b2-8576-4788-839c-d54f29940326'), ('5632904c-81bb-4d0a-990d-a74a4c4ef52a','ZNZPPT_02','-5.09,0,-1.2','running','true','331543b2-8576-4788-839c-d54f29940326'), ('648b63dc-afda-4dd9-906f-0e896c578ee6','OnlineTest','3.51,0,1.82','running','true','eea88e68-3968-432a-b193-92318854b00b'), ('6acd98ef-334a-4919-9acc-f79ecab5f6f9','XBC','-0.06,0,-0.99','running','true','eea88e68-3968-432a-b193-92318854b00b'), ('70c3a311-e997-4614-a969-06239a9aa40f','vediojet_8510','3.981,0,-0.813','running','true','eea88e68-3968-432a-b193-92318854b00b'), ('7484da1f-e3c3-4a16-85c1-71b6499c1965','OnlineTest','3.51,0,1.82','running','true','331543b2-8576-4788-839c-d54f29940326'), ('795ba406-ace1-4de2-b252-c511349dc2c2','AssembleAccuracyTest','1.43,0,1.89','running','true','eea88e68-3968-432a-b193-92318854b00b'), ('7be4c458-00f5-49a4-8f88-01a9b1a75e9c','RJXZPT_01','-2.37,0,1.75','running','true','eea88e68-3968-432a-b193-92318854b00b'), ('7d4d938e-b39f-4b5e-a9e1-28b8e3708c3a','UR5','-0.06,0,1.72','running','true','9f8ae5e1-debf-4d5e-bd06-2d8fef47858b'), ('7e3a7f9e-66bc-49a8-a50d-e9adb5e8c2c7','RJXZPT_02','-2.37,0,-1.2','running','true','eea88e68-3968-432a-b193-92318854b00b'), ('82385a3e-5095-4c2d-bae7-bb8e3d95896f','RJXZPT_01','-2.37,0,1.75','running','true','9f8ae5e1-debf-4d5e-bd06-2d8fef47858b'), ('864bbfb9-4334-43cc-88a4-7202e2e39231','XBC',' -2.37,0,-0.99','running','true','9f8ae5e1-debf-4d5e-bd06-2d8fef47858b'), ('86bc714f-9423-4d9d-aa0d-51b07c2abf30','KR16_CQ','0,0,-5.1','running','true','331543b2-8576-4788-839c-d54f29940326'), ('934f652a-a699-4e07-8213-1058bbc874f5','KR16_CQ','0,0,-5.1','running','true','eea88e68-3968-432a-b193-92318854b00b'), ('94b34bfb-d8ff-4be6-9023-f767b018f6a3','KR16_MG','-5.4,0,0.29','running','true','9f8ae5e1-debf-4d5e-bd06-2d8fef47858b'), ('9cec674d-f198-450d-8987-4700b0011bdf','AssembleAccuracyTest','1.43,0,1.89','running','true','9f8ae5e1-debf-4d5e-bd06-2d8fef47858b'), ('9f8b448e-e241-4785-943f-bdf1d5c0350f','UR5','-0.06,0,1.72','running','true','331543b2-8576-4788-839c-d54f29940326'), ('a8927f8b-ccc1-48ca-98b6-e1023cc82ecb','RJXZPT_01','-2.37,0,1.75','running','true','331543b2-8576-4788-839c-d54f29940326'), ('asd9rwefjsadf-asdfjqweoirnsdfajfiqwnw','XBC',' -5.09,0,-0.99','running','true','1'), ('c0c0bd64-5cc0-4b7a-a73a-6669036d10a9','KR16_MG','-5.4,0,0.29','running','true','eea88e68-3968-432a-b193-92318854b00b'), ('c4226624-24f3-4582-8d86-570cb448b0bd','AGV_L','5.14,0,0.32','running','true','331543b2-8576-4788-839c-d54f29940326'), ('c460e580-f494-4d81-ab4c-d7a2296b3a9e','ZNZPPT_01','-5.09,0,1.88','running','true','331543b2-8576-4788-839c-d54f29940326'), ('c828a82d-b741-4375-b4d9-f2954576d25b','AGV_R','-2.947653,0,-5.149962','running','true','9f8ae5e1-debf-4d5e-bd06-2d8fef47858b'), ('d07ccbf7-69dd-4433-98c3-90b78416bfe3','OnlineTest','3.51,0,1.82','running','true','9f8ae5e1-debf-4d5e-bd06-2d8fef47858b'), ('ecb910b6-9cb4-4ce5-ab85-4fee84c06166','vediojet_8510','3.981,0,-0.813','running','true','9f8ae5e1-debf-4d5e-bd06-2d8fef47858b'), ('f01195ca-ec67-42a7-88e6-8676c98e3931','ZNZPPT_02','-5.09,0,-1.2','running','true','9f8ae5e1-debf-4d5e-bd06-2d8fef47858b'), ('f109f95a-f6c7-46c0-8900-31f2577cc468','UR5','-0.06,0,1.72','running','true','eea88e68-3968-432a-b193-92318854b00b'), ('f9820518-3207-43fa-8282-0de415ce5f23','RJXZPT_02','-2.37,0,-1.2','running','false','9f8ae5e1-debf-4d5e-bd06-2d8fef47858b'), ('fd5f52c1-edfe-4c8c-bb88-f5a470225c1c','ZNZPPT_02','0,0,0','running','false','eea88e68-3968-432a-b193-92318854b00b');
INSERT INTO `rg_layoutdistance` VALUES ('2','AssembleAccuracyTest','XZTP-L','60','30','1'), ('3','AssembleAccuracyTest','OnlineTest','40','20','1'), ('4','AssembleAccuracyTest','UR5','20','10','1'), ('5','AssembleAccuracyTest','RJXZPT_02','20','10','1'), ('6','AssembleAccuracyTest','RJXZPT_01','20','10','1'), ('7','AssembleAccuracyTest','ZNZPPT_02','40','20','1'), ('8','AssembleAccuracyTest','ZNZPPT_01','40','20','1'), ('9','AssembleAccuracyTest','XBC01','40','20','1'), ('10','AssembleAccuracyTest','XZTP-R','60','30','1'), ('11','CCJDJC','TKD-L','40','','1'), ('12','CCJDJC','MTJDJC','20','','1'), ('13','CCJDJC','ZHDXNJC','20','','1'), ('14','CCJDJC','RJXZ','40','','1'), ('15','CCJDJC','ZNZP','60','','1'), ('16','CCJDJC','XBC','60','','1'), ('17','CCJDJC','TKD-R','80','','1'), ('18','CK','TKD-L','120','','1'), ('19','CK','TKD-R','120','','1'), ('20','CK01','XZTP-L','120','60','1'), ('21','CK01','XZTP-R','120','60','1'), ('22','MTJDJC','TKD-L','20','','1'), ('23','MTJDJC','CCJDJC','20','','1'), ('24','MTJDJC','ZHDXNJC','40','','1'), ('25','MTJDJC','RJXZ','60','','1'), ('26','MTJDJC','ZNZP','80','','1'), ('27','MTJDJC','XBC','80','','1'), ('28','MTJDJC','TKD-R','100','','1'), ('29','OnlineTest','XZTP-L','20','10','1'), ('30','OnlineTest','UR5','20','10','1'), ('31','OnlineTest','AssembleAccuracyTest','40','20','1'), ('32','OnlineTest','RJXZPT_02','60','30','1'), ('33','OnlineTest','RJXZPT_01','60','30','1'), ('34','OnlineTest','ZNZPPT_02','80','40','1'), ('35','OnlineTest','ZNZPPT_01','80','40','1'), ('36','OnlineTest','XBC01','80','40','1'), ('37','OnlineTest','XZTP-R','100','50','1'), ('38','RJXZ','TKD-L','80','','1'), ('39','RJXZ','MTJDJC','60','','1'), ('40','RJXZ','CCJDJC','40','','1'), ('41','RJXZ','ZHDXNJC','20','','1'), ('42','RJXZ','ZNZP','20','','1'), ('43','RJXZ','XBC','20','','1'), ('44','RJXZ','TKD-R','40','','1'), ('45','RJXZPT_01','XZTP-L','80','40','1'), ('46','RJXZPT_01','OnlineTest','60','30','1'), ('47','RJXZPT_01','UR5','40','20','1'), ('48','RJXZPT_01','AssembleAccuracyTest','20','10','1'), ('49','RJXZPT_01','RJXZPT_02','0','0','1'), ('50','RJXZPT_01','ZNZPPT_02','20','10','1'), ('51','RJXZPT_01','ZNZPPT_01','20','10','1'), ('52','RJXZPT_01','XBC01','20','10','1'), ('53','RJXZPT_01','XZTP-R','40','20','1'), ('54','RJXZPT_02','XZTP-L','80','40','1'), ('55','RJXZPT_02','OnlineTest','60','30','1'), ('56','RJXZPT_02','UR5','40','20','1'), ('57','RJXZPT_02','AssembleAccuracyTest','20','10','1'), ('58','RJXZPT_02','RJXZPT_01','0','0','1'), ('59','RJXZPT_02','ZNZPPT_02','20','10','1'), ('60','RJXZPT_02','ZNZPPT_01','20','10','1'), ('61','RJXZPT_02','XBC01','20','10','1'), ('62','RJXZPT_02','XZTP-R','40','20','1'), ('63','TKD-L','MTJDJC','20','','1'), ('64','TKD-L','CCJDJC','40','','1'), ('65','TKD-L','ZHDXNJC','60','','1'), ('66','TKD-L','RJXZ','80','','1'), ('67','TKD-L','ZNZP','100','','1'), ('68','TKD-L','XBC','100','','1'), ('69','TKD-L','TKD-R','120','','1'), ('70','TKD-L','CK','120','','1'), ('71','TKD-R','TKD-L','120','','1'), ('72','TKD-R','MTJDJC','100','','1'), ('73','TKD-R','CCJDJC','80','','1'), ('74','TKD-R','ZHDXNJC','60','','1'), ('75','TKD-R','RJXZ','40','','1'), ('76','TKD-R','ZNZP','20','','1'), ('77','TKD-R','XBC','20','','1'), ('78','TKD-R','CK','120','','1'), ('79','UR5','XZTP-L','40','20','1'), ('80','UR5','OnlineTest','20','10','1'), ('81','UR5','AssembleAccuracyTest','20','10','1'), ('82','UR5','RJXZPT_02','40','20','1'), ('83','UR5','RJXZPT_01','40','20','1'), ('84','UR5','ZNZPPT_02','60','30','1'), ('85','UR5','ZNZPPT_01','60','30','1'), ('86','UR5','XBC01','60','30','1'), ('87','UR5','XZTP-R','80','40','1'), ('88','XBC','TKD-L','100','','1'), ('89','XBC','MTJDJC','80','','1'), ('90','XBC','CCJDJC','60','','1'), ('91','XBC','ZHDXNJC','40','','1'), ('92','XBC','RJXZ','20','','1'), ('93','XBC','ZNZP','0','','1'), ('94','XBC','TKD-R','20','','1'), ('95','XBC01','XZTP-L','100','50','1'), ('96','XBC01','OnlineTest','80','40','1'), ('97','XBC01','UR5','60','30','1'), ('98','XBC01','AssembleAccuracyTest','40','20','1'), ('99','XBC01','RJXZPT_02','20','10','1'), ('100','XBC01','RJXZPT_01','20','10','1'), ('101','XBC01','ZNZPPT_02','0','0','1');
INSERT INTO `rg_layoutdistance` VALUES ('102','XBC01','ZNZPPT_01','0','0','1'), ('103','XBC01','XZTP-R','20','10','1'), ('104','XZTP-L','OnlineTest','20','10','1'), ('105','XZTP-L','UR5','40','20','1'), ('106','XZTP-L','AssembleAccuracyTest','60','30','1'), ('107','XZTP-L','RJXZPT_02','80','40','1'), ('108','XZTP-L','RJXZPT_01','80','40','1'), ('109','XZTP-L','ZNZPPT_02','100','50','1'), ('110','XZTP-L','ZNZPPT_01','100','50','1'), ('111','XZTP-L','XBC01','100','50','1'), ('112','XZTP-L','XZTP-R','120','60','1'), ('113','XZTP-L','CK01','120','60','1'), ('114','XZTP-R','XZTP-L','120','60','1'), ('115','XZTP-R','OnlineTest','100','50','1'), ('116','XZTP-R','UR5','80','40','1'), ('117','XZTP-R','AssembleAccuracyTest','60','30','1'), ('118','XZTP-R','RJXZPT_02','40','20','1'), ('119','XZTP-R','RJXZPT_01','40','20','1'), ('120','XZTP-R','ZNZPPT_02','20','10','1'), ('121','XZTP-R','ZNZPPT_01','20','10','1'), ('122','XZTP-R','XBC01','20','10','1'), ('123','XZTP-R','CK01','120','60','1'), ('124','ZHDXNJC','TKD-L','60','','1'), ('125','ZHDXNJC','MTJDJC','40','','1'), ('126','ZHDXNJC','CCJDJC','20','','1'), ('127','ZHDXNJC','RJXZ','20','','1'), ('128','ZHDXNJC','ZNZP','40','','1'), ('129','ZHDXNJC','XBC','40','','1'), ('130','ZHDXNJC','TKD-R','60','','1'), ('131','ZNZP','TKD-L','100','','1'), ('132','ZNZP','MTJDJC','80','','1'), ('133','ZNZP','CCJDJC','60','','1'), ('134','ZNZP','ZHDXNJC','40','','1'), ('135','ZNZP','RJXZ','20','','1'), ('136','ZNZP','XBC','0','','1'), ('137','ZNZP','TKD-R','20','','1'), ('138','ZNZPPT_01','XZTP-L','100','50','1'), ('139','ZNZPPT_01','OnlineTest','80','40','1'), ('140','ZNZPPT_01','UR5','60','30','1'), ('141','ZNZPPT_01','AssembleAccuracyTest','40','20','1'), ('142','ZNZPPT_01','RJXZPT_02','20','10','1'), ('143','ZNZPPT_01','RJXZPT_01','20','10','1'), ('144','ZNZPPT_01','ZNZPPT_02','0','0','1'), ('145','ZNZPPT_01','XBC01','0','0','1'), ('146','ZNZPPT_01','XZTP-R','20','10','1'), ('147','ZNZPPT_02','XZTP-L','100','50','1'), ('148','ZNZPPT_02','OnlineTest','80','40','1'), ('149','ZNZPPT_02','UR5','60','30','1'), ('150','ZNZPPT_02','AssembleAccuracyTest','40','20','1'), ('151','ZNZPPT_02','RJXZPT_02','20','10','1'), ('152','ZNZPPT_02','RJXZPT_01','20','10','1'), ('153','ZNZPPT_02','ZNZPPT_01','0','0','1'), ('154','ZNZPPT_02','XBC01','0','0','1'), ('155','ZNZPPT_02','XZTP-R','20','10','1'), ('157','XZTP-L','AssembleAccuracyTest','60','30','2'), ('158','OnlineTest','AssembleAccuracyTest','40','20','2'), ('159','UR5','AssembleAccuracyTest','20','10','2'), ('160','XBC01','AssembleAccuracyTest','20','10','2'), ('161','RJXZPT_02','AssembleAccuracyTest','20','10','2'), ('162','RJXZPT_01','AssembleAccuracyTest','20','10','2'), ('163','ZNZPPT_02','AssembleAccuracyTest','40','20','2'), ('164','ZNZPPT_01','AssembleAccuracyTest','40','20','2'), ('165','XZTP-R','AssembleAccuracyTest','60','30','2'), ('166','TKD-L','CCJDJC','40','','2'), ('167','MTJDJC','CCJDJC','20','','2'), ('168','ZHDXNJC','CCJDJC','20','','2'), ('169','XBC','CCJDJC','40','','2'), ('170','RJXZ','CCJDJC','40','','2'), ('171','ZNZP','CCJDJC','60','','2'), ('172','TKD-R','CCJDJC','80','','2'), ('173','TKD-L','CK','120','','2'), ('174','TKD-R','CK','120','','2'), ('175','XZTP-L','CK01','120','60','2'), ('176','XZTP-R','CK01','120','60','2'), ('177','TKD-L','MTJDJC','20','','2'), ('178','CCJDJC','MTJDJC','20','','2'), ('179','ZHDXNJC','MTJDJC','40','','2'), ('180','XBC','MTJDJC','60','','2'), ('181','RJXZ','MTJDJC','60','','2'), ('182','ZNZP','MTJDJC','80','','2'), ('183','TKD-R','MTJDJC','100','','2'), ('184','XZTP-L','OnlineTest','20','10','2'), ('185','UR5','OnlineTest','20','10','2'), ('186','AssembleAccuracyTest','OnlineTest','40','20','2'), ('187','XBC01','OnlineTest','60','30','2'), ('188','RJXZPT_02','OnlineTest','60','30','2'), ('189','RJXZPT_01','OnlineTest','60','30','2'), ('190','ZNZPPT_02','OnlineTest','80','40','2'), ('191','ZNZPPT_01','OnlineTest','80','40','2'), ('192','XZTP-R','OnlineTest','100','50','2'), ('193','TKD-L','RJXZ','80','','2'), ('194','MTJDJC','RJXZ','60','','2'), ('195','CCJDJC','RJXZ','40','','2'), ('196','ZHDXNJC','RJXZ','20','','2'), ('197','XBC','RJXZ','0','','2'), ('198','ZNZP','RJXZ','20','','2'), ('199','TKD-R','RJXZ','40','','2'), ('200','XZTP-L','RJXZPT_01','80','40','2'), ('201','OnlineTest','RJXZPT_01','60','30','2'), ('202','UR5','RJXZPT_01','40','20','2');
INSERT INTO `rg_layoutdistance` VALUES ('203','AssembleAccuracyTest','RJXZPT_01','20','10','2'), ('204','XBC01','RJXZPT_01','0','0','2'), ('205','RJXZPT_02','RJXZPT_01','0','0','2'), ('206','ZNZPPT_02','RJXZPT_01','20','10','2'), ('207','ZNZPPT_01','RJXZPT_01','20','10','2'), ('208','XZTP-R','RJXZPT_01','40','20','2'), ('209','XZTP-L','RJXZPT_02','80','40','2'), ('210','OnlineTest','RJXZPT_02','60','30','2'), ('211','UR5','RJXZPT_02','40','20','2'), ('212','AssembleAccuracyTest','RJXZPT_02','20','10','2'), ('213','XBC01','RJXZPT_02','0','0','2'), ('214','RJXZPT_01','RJXZPT_02','0','0','2'), ('215','ZNZPPT_02','RJXZPT_02','20','10','2'), ('216','ZNZPPT_01','RJXZPT_02','20','10','2'), ('217','XZTP-R','RJXZPT_02','40','20','2'), ('218','MTJDJC','TKD-L','20','','2'), ('219','CCJDJC','TKD-L','40','','2'), ('220','ZHDXNJC','TKD-L','60','','2'), ('221','XBC','TKD-L','80','','2'), ('222','RJXZ','TKD-L','80','','2'), ('223','ZNZP','TKD-L','100','','2'), ('224','TKD-R','TKD-L','120','','2'), ('225','CK','TKD-L','120','','2'), ('226','TKD-L','TKD-R','120','','2'), ('227','MTJDJC','TKD-R','100','','2'), ('228','CCJDJC','TKD-R','80','','2'), ('229','ZHDXNJC','TKD-R','60','','2'), ('230','XBC','TKD-R','40','','2'), ('231','RJXZ','TKD-R','40','','2'), ('232','ZNZP','TKD-R','20','','2'), ('233','CK','TKD-R','120','','2'), ('234','XZTP-L','UR5','40','20','2'), ('235','OnlineTest','UR5','20','10','2'), ('236','AssembleAccuracyTest','UR5','20','10','2'), ('237','XBC01','UR5','40','20','2'), ('238','RJXZPT_02','UR5','40','20','2'), ('239','RJXZPT_01','UR5','40','20','2'), ('240','ZNZPPT_02','UR5','60','30','2'), ('241','ZNZPPT_01','UR5','60','30','2'), ('242','XZTP-R','UR5','80','40','2'), ('243','TKD-L','XBC','80','','2'), ('244','MTJDJC','XBC','60','','2'), ('245','CCJDJC','XBC','40','','2'), ('246','ZHDXNJC','XBC','20','','2'), ('247','RJXZ','XBC','0','','2'), ('248','ZNZP','XBC','20','','2'), ('249','TKD-R','XBC','40','','2'), ('250','XZTP-L','XBC01','80','40','2'), ('251','OnlineTest','XBC01','60','30','2'), ('252','UR5','XBC01','40','20','2'), ('253','AssembleAccuracyTest','XBC01','20','10','2'), ('254','RJXZPT_02','XBC01','0','0','2'), ('255','RJXZPT_01','XBC01','0','0','2'), ('256','ZNZPPT_02','XBC01','20','10','2'), ('257','ZNZPPT_01','XBC01','20','10','2'), ('258','XZTP-R','XBC01','40','20','2'), ('259','OnlineTest','XZTP-L','20','10','2'), ('260','UR5','XZTP-L','40','20','2'), ('261','AssembleAccuracyTest','XZTP-L','60','30','2'), ('262','XBC01','XZTP-L','80','40','2'), ('263','RJXZPT_02','XZTP-L','80','40','2'), ('264','RJXZPT_01','XZTP-L','80','40','2'), ('265','ZNZPPT_02','XZTP-L','100','50','2'), ('266','ZNZPPT_01','XZTP-L','100','50','2'), ('267','XZTP-R','XZTP-L','120','60','2'), ('268','CK01','XZTP-L','120','60','2'), ('269','XZTP-L','XZTP-R','120','60','2'), ('270','OnlineTest','XZTP-R','100','50','2'), ('271','UR5','XZTP-R','80','40','2'), ('272','AssembleAccuracyTest','XZTP-R','60','30','2'), ('273','XBC01','XZTP-R','40','20','2'), ('274','RJXZPT_02','XZTP-R','40','20','2'), ('275','RJXZPT_01','XZTP-R','40','20','2'), ('276','ZNZPPT_02','XZTP-R','20','10','2'), ('277','ZNZPPT_01','XZTP-R','20','10','2'), ('278','CK01','XZTP-R','120','60','2'), ('279','TKD-L','ZHDXNJC','60','','2'), ('280','MTJDJC','ZHDXNJC','40','','2'), ('281','CCJDJC','ZHDXNJC','20','','2'), ('282','XBC','ZHDXNJC','20','','2'), ('283','RJXZ','ZHDXNJC','20','','2'), ('284','ZNZP','ZHDXNJC','40','','2'), ('285','TKD-R','ZHDXNJC','60','','2'), ('286','TKD-L','ZNZP','100','','2'), ('287','MTJDJC','ZNZP','80','','2'), ('288','CCJDJC','ZNZP','60','','2'), ('289','ZHDXNJC','ZNZP','40','','2'), ('290','XBC','ZNZP','20','','2'), ('291','RJXZ','ZNZP','20','','2'), ('292','TKD-R','ZNZP','20','','2'), ('293','XZTP-L','ZNZPPT_01','100','50','2'), ('294','OnlineTest','ZNZPPT_01','80','40','2'), ('295','UR5','ZNZPPT_01','60','30','2'), ('296','AssembleAccuracyTest','ZNZPPT_01','40','20','2'), ('297','XBC01','ZNZPPT_01','20','10','2'), ('298','RJXZPT_02','ZNZPPT_01','20','10','2'), ('299','RJXZPT_01','ZNZPPT_01','20','10','2'), ('300','ZNZPPT_02','ZNZPPT_01','0','0','2'), ('301','XZTP-R','ZNZPPT_01','20','10','2'), ('302','XZTP-L','ZNZPPT_02','100','50','2');
INSERT INTO `rg_layoutdistance` VALUES ('303','OnlineTest','ZNZPPT_02','80','40','2'), ('304','UR5','ZNZPPT_02','60','30','2'), ('305','AssembleAccuracyTest','ZNZPPT_02','40','20','2'), ('306','XBC01','ZNZPPT_02','20','10','2'), ('307','RJXZPT_02','ZNZPPT_02','20','10','2'), ('308','RJXZPT_01','ZNZPPT_02','20','10','2'), ('309','ZNZPPT_01','ZNZPPT_02','0','0','2'), ('310','XZTP-R','ZNZPPT_02','20','10','2'), ('312','XBC01','AssembleAccuracyTest','0','0','3'), ('313','RJXZPT_02','AssembleAccuracyTest','20','10','3'), ('314','RJXZPT_01','AssembleAccuracyTest','20','10','3'), ('315','ZNZPPT_02','AssembleAccuracyTest','40','20','3'), ('316','ZNZPPT_01','AssembleAccuracyTest','40','20','3'), ('317','XZTP-L','AssembleAccuracyTest','60','30','3'), ('318','OnlineTest','AssembleAccuracyTest','40','20','3'), ('319','UR5','AssembleAccuracyTest','20','10','3'), ('320','XZTP-R','AssembleAccuracyTest','60','30','3'), ('321','TKD-L','CCJDJC','40','','3'), ('322','MTJDJC','CCJDJC','20','','3'), ('323','ZHDXNJC','CCJDJC','20','','3'), ('324','XBC','CCJDJC','20','','3'), ('325','RJXZ','CCJDJC','40','','3'), ('326','ZNZP','CCJDJC','60','','3'), ('327','TKD-R','CCJDJC','80','','3'), ('328','TKD-L','CK','120','','3'), ('329','TKD-R','CK','120','','3'), ('330','XZTP-L','CK01','120','60','3'), ('331','XZTP-R','CK01','120','60','3'), ('332','TKD-L','MTJDJC','20','','3'), ('333','CCJDJC','MTJDJC','20','','3'), ('334','ZHDXNJC','MTJDJC','40','','3'), ('335','XBC','MTJDJC','40','','3'), ('336','RJXZ','MTJDJC','60','','3'), ('337','ZNZP','MTJDJC','80','','3'), ('338','TKD-R','MTJDJC','100','','3'), ('339','AssembleAccuracyTest','OnlineTest','40','20','3'), ('340','XBC01','OnlineTest','40','20','3'), ('341','RJXZPT_02','OnlineTest','60','30','3'), ('342','RJXZPT_01','OnlineTest','60','30','3'), ('343','ZNZPPT_02','OnlineTest','80','40','3'), ('344','ZNZPPT_01','OnlineTest','80','40','3'), ('345','XZTP-L','OnlineTest','20','10','3'), ('346','UR5','OnlineTest','20','10','3'), ('347','XZTP-R','OnlineTest','100','50','3'), ('348','TKD-L','RJXZ','80','','3'), ('349','MTJDJC','RJXZ','60','','3'), ('350','CCJDJC','RJXZ','40','','3'), ('351','ZHDXNJC','RJXZ','20','','3'), ('352','XBC','RJXZ','20','','3'), ('353','ZNZP','RJXZ','20','','3'), ('354','TKD-R','RJXZ','40','','3'), ('355','UR5','RJXZPT_01','40','20','3'), ('356','AssembleAccuracyTest','RJXZPT_01','20','10','3'), ('357','XBC01','RJXZPT_01','20','10','3'), ('358','RJXZPT_02','RJXZPT_01','0','0','3'), ('359','ZNZPPT_02','RJXZPT_01','20','10','3'), ('360','ZNZPPT_01','RJXZPT_01','20','10','3'), ('361','XZTP-L','RJXZPT_01','80','40','3'), ('362','OnlineTest','RJXZPT_01','60','30','3'), ('363','XZTP-R','RJXZPT_01','40','20','3'), ('364','AssembleAccuracyTest','RJXZPT_02','20','10','3'), ('365','XBC01','RJXZPT_02','20','10','3'), ('366','RJXZPT_01','RJXZPT_02','0','0','3'), ('367','ZNZPPT_02','RJXZPT_02','20','10','3'), ('368','ZNZPPT_01','RJXZPT_02','20','10','3'), ('369','XZTP-L','RJXZPT_02','80','40','3'), ('370','OnlineTest','RJXZPT_02','60','30','3'), ('371','UR5','RJXZPT_02','40','20','3'), ('372','XZTP-R','RJXZPT_02','40','20','3'), ('373','MTJDJC','TKD-L','20','','3'), ('374','CCJDJC','TKD-L','40','','3'), ('375','ZHDXNJC','TKD-L','60','','3'), ('376','XBC','TKD-L','60','','3'), ('377','RJXZ','TKD-L','80','','3'), ('378','ZNZP','TKD-L','100','','3'), ('379','TKD-R','TKD-L','120','','3'), ('380','CK','TKD-L','120','','3'), ('381','TKD-L','TKD-R','120','','3'), ('382','MTJDJC','TKD-R','100','','3'), ('383','CCJDJC','TKD-R','80','','3'), ('384','ZHDXNJC','TKD-R','60','','3'), ('385','XBC','TKD-R','60','','3'), ('386','RJXZ','TKD-R','40','','3'), ('387','ZNZP','TKD-R','20','','3'), ('388','CK','TKD-R','120','','3'), ('389','AssembleAccuracyTest','UR5','20','10','3'), ('390','XBC01','UR5','20','10','3'), ('391','RJXZPT_02','UR5','40','20','3'), ('392','RJXZPT_01','UR5','40','20','3'), ('393','ZNZPPT_02','UR5','60','30','3'), ('394','ZNZPPT_01','UR5','60','30','3'), ('395','XZTP-L','UR5','40','20','3'), ('396','OnlineTest','UR5','20','10','3'), ('397','XZTP-R','UR5','80','40','3'), ('398','TKD-L','XBC','60','','3'), ('399','MTJDJC','XBC','40','','3'), ('400','CCJDJC','XBC','20','','3'), ('401','ZHDXNJC','XBC','0','','3'), ('402','RJXZ','XBC','20','','3'), ('403','ZNZP','XBC','40','','3');
INSERT INTO `rg_layoutdistance` VALUES ('404','TKD-R','XBC','60','','3'), ('405','AssembleAccuracyTest','XBC01','0','0','3'), ('406','RJXZPT_02','XBC01','20','10','3'), ('407','RJXZPT_01','XBC01','20','10','3'), ('408','ZNZPPT_02','XBC01','40','20','3'), ('409','ZNZPPT_01','XBC01','40','20','3'), ('410','XZTP-L','XBC01','60','30','3'), ('411','OnlineTest','XBC01','40','20','3'), ('412','UR5','XBC01','20','10','3'), ('413','XZTP-R','XBC01','60','30','3'), ('414','AssembleAccuracyTest','XZTP-L','60','30','3'), ('415','XBC01','XZTP-L','60','30','3'), ('416','RJXZPT_02','XZTP-L','80','40','3'), ('417','RJXZPT_01','XZTP-L','80','40','3'), ('418','ZNZPPT_02','XZTP-L','100','50','3'), ('419','ZNZPPT_01','XZTP-L','100','50','3'), ('420','OnlineTest','XZTP-L','20','10','3'), ('421','UR5','XZTP-L','40','20','3'), ('422','XZTP-R','XZTP-L','120','60','3'), ('423','CK01','XZTP-L','120','60','3'), ('424','UR5','XZTP-R','80','40','3'), ('425','AssembleAccuracyTest','XZTP-R','60','30','3'), ('426','XBC01','XZTP-R','60','30','3'), ('427','RJXZPT_02','XZTP-R','40','20','3'), ('428','RJXZPT_01','XZTP-R','40','20','3'), ('429','ZNZPPT_02','XZTP-R','20','10','3'), ('430','XZTP-L','XZTP-R','120','60','3'), ('431','OnlineTest','XZTP-R','100','50','3'), ('432','ZNZPPT_01','XZTP-R','20','10','3'), ('433','CK01','XZTP-R','120','60','3'), ('434','TKD-L','ZHDXNJC','60','','3'), ('435','MTJDJC','ZHDXNJC','40','','3'), ('436','CCJDJC','ZHDXNJC','20','','3'), ('437','XBC','ZHDXNJC','0','','3'), ('438','RJXZ','ZHDXNJC','20','','3'), ('439','ZNZP','ZHDXNJC','40','','3'), ('440','TKD-R','ZHDXNJC','60','','3'), ('441','TKD-L','ZNZP','100','','3'), ('442','MTJDJC','ZNZP','80','','3'), ('443','CCJDJC','ZNZP','60','','3'), ('444','ZHDXNJC','ZNZP','40','','3'), ('445','XBC','ZNZP','40','','3'), ('446','RJXZ','ZNZP','20','','3'), ('447','TKD-R','ZNZP','20','','3'), ('448','UR5','ZNZPPT_01','60','30','3'), ('449','AssembleAccuracyTest','ZNZPPT_01','40','20','3'), ('450','XBC01','ZNZPPT_01','40','20','3'), ('451','RJXZPT_02','ZNZPPT_01','20','10','3'), ('452','RJXZPT_01','ZNZPPT_01','20','10','3'), ('453','ZNZPPT_02','ZNZPPT_01','0','0','3'), ('454','XZTP-L','ZNZPPT_01','100','50','3'), ('455','OnlineTest','ZNZPPT_01','80','40','3'), ('456','XZTP-R','ZNZPPT_01','20','10','3'), ('457','UR5','ZNZPPT_02','60','30','3'), ('458','AssembleAccuracyTest','ZNZPPT_02','40','20','3'), ('459','XBC01','ZNZPPT_02','40','20','3'), ('460','RJXZPT_02','ZNZPPT_02','20','10','3'), ('461','RJXZPT_01','ZNZPPT_02','20','10','3'), ('462','XZTP-L','ZNZPPT_02','100','50','3'), ('463','OnlineTest','ZNZPPT_02','80','40','3'), ('464','ZNZPPT_01','ZNZPPT_02','0','0','3'), ('465','XZTP-R','ZNZPPT_02','20','10','3');
INSERT INTO `rg_process` VALUES ('Gyc','工艺舱半成品装配','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'T',NULL,'{Kjt}','{KjtToGyc}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','0','0',NULL,'Gyc','Yqc'), ('Kjt','框架体半成品装配','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'T',NULL,'{}','{Gyc}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','0','0',NULL,'Kjt','Yqc'), ('KjtToGyc','框架体装入工艺舱','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'T',NULL,'{Gyc}','{ZjHdmk}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','0','0',NULL,'KjtToGyc','Yqc'), ('Kqd','空气舵产品装配','Kqd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','0','0','0','0','0','T',NULL,'{}','{}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','1','0',NULL,'Kqd',NULL), ('Kqd-Kqd-AGVQH-CK-01','AGV仓库取货[Kqd齐套1]','Kqd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'60','0',NULL,'0',NULL,'T',NULL,'{}','{Kqd-Kqd-AGVXH-TKD-01}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'Kqd'), ('Kqd-Kqd-AGVQH-CK-02','AGV仓库取货[Kqd齐套2]','Kqd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'60','0',NULL,'0',NULL,'T',NULL,'{Kqd-Kqd-AGVXH-TKD-01}','{Kqd-Kqd-AGVXH-TKD-02}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'Kqd'), ('Kqd-Kqd-AGVQH-CK-03','AGV仓库取货[Kqd齐套3]','Kqd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'60','0',NULL,'0',NULL,'T',NULL,'{Kqd-Kqd-AGVXH-TKD-02}','{Kqd-Kqd-AGVXH-TKD-03}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'Kqd'), ('Kqd-Kqd-AGVQH-TKD-01','AGV停靠点2取货[Kqd齐套1]','Kqd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10',NULL,NULL,NULL,NULL,'T',NULL,'{Kqd-Kqd-RobotXH-TKD-01,Kqd-Kqd-RobotXH-TKD-01-XBC}','{Kqd-Kqd-AGVXH-CK-01}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Kqd-Kqd-RobotXH-TKD-01,Kqd-Kqd-RobotXH-TKD-01-XBC}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','0','1',NULL,NULL,'Kqd'), ('Kqd-Kqd-AGVQH-TKD-02','AGV停靠点2取货[Kqd齐套2]','Kqd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10',NULL,NULL,NULL,NULL,'T',NULL,'{Kqd-Kqd-RobotXH-TKD-02,Kqd-Kqd-RobotXH-TKD-02-XBC}','{Kqd-Kqd-AGVXH-CK-02}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Kqd-Kqd-RobotXH-TKD-02,Kqd-Kqd-RobotXH-TKD-02-XBC}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','0','1',NULL,NULL,'Kqd'), ('Kqd-Kqd-AGVQH-TKD-03','AGV停靠点2取货[Kqd齐套3]','Kqd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10',NULL,NULL,NULL,NULL,'T',NULL,'{Kqd-Kqd-RobotXH-TKD-03}','{Kqd-Kqd-AGVXH-CK-03}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Kqd-Kqd-RobotXH-TKD-03,Kqd-Kqd-RobotXH-TKD-03-XBC}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','0','1',NULL,NULL,'Kqd'), ('Kqd-Kqd-AGVXH-CK-01','AGV仓库卸货[Kqd齐套1]','Kqd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10',NULL,NULL,NULL,NULL,'T',NULL,'{Kqd-Kqd-AGVQH-TKD-01}','{}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','0','1',NULL,NULL,'Kqd'), ('Kqd-Kqd-AGVXH-CK-02','AGV仓库卸货[Kqd齐套2]','Kqd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10',NULL,NULL,NULL,NULL,'T',NULL,'{Kqd-Kqd-AGVQH-TKD-02}','{}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','0','1',NULL,NULL,'Kqd'), ('Kqd-Kqd-AGVXH-CK-03','AGV仓库卸货[Kqd齐套3]','Kqd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'60',NULL,NULL,NULL,NULL,'T',NULL,'{Kqd-Kqd-AGVQH-TKD-03}','{}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','0','1',NULL,NULL,'Kqd'), ('Kqd-Kqd-AGVXH-TKD-01','AGV停靠点1卸货[Kqd齐套1]','Kqd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10','0',NULL,'0',NULL,'T',NULL,'{Kqd-Kqd-AGVQH-CK-01}','{Kqd-Kqd-RobotQH-TKD-01}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'Kqd'), ('Kqd-Kqd-AGVXH-TKD-02','AGV停靠点1卸货[Kqd齐套2]','Kqd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10','0',NULL,'0',NULL,'T',NULL,'{Kqd-Kqd-AGVQH-CK-02}','{Kqd-Kqd-RobotQH-TKD-02}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'Kqd'), ('Kqd-Kqd-AGVXH-TKD-03','AGV停靠点1卸货[Kqd齐套3]','Kqd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10','0',NULL,'0',NULL,'T',NULL,'{Kqd-Kqd-AGVQH-CK-03}','{Kqd-Kqd-RobotQH-TKD-03}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'Kqd'), ('Kqd-Kqd-CCJC-06','尺寸精度检测','Kqd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'200',NULL,NULL,NULL,NULL,'T','{Kqd-Kqd-RobotXH-MT-05,Kqd-Kqd-MTJC-06,Kqd-Kqd-RobotQH-MT-07}','{Kqd-Kqd-RobotXH-CC-05}','{Kqd-Kqd-RobotQH-CC-07}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','0','0',NULL,NULL,'Kqd'), ('Kqd-Kqd-MTJC-06','模态精度检测','Kqd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'300',NULL,NULL,NULL,NULL,'T','{Kqd-Kqd-RobotXH-CC-05,Kqd-Kqd-CCJC-06,Kqd-Kqd-RobotQH-CC-07}','{Kqd-Kqd-RobotXH-MT-05}','{Kqd-Kqd-RobotQH-MT-07}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','0','0',NULL,NULL,'Kqd'), ('Kqd-Kqd-RobotQH-CC-07','机器人尺寸检测设备取货[Kqd齐套3]','Kqd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10',NULL,NULL,NULL,NULL,'T','{Kqd-Kqd-RobotXH-MT-05,Kqd-Kqd-MTJC-06,Kqd-Kqd-RobotQH-MT-07}','{Kqd-Kqd-CCJC-06}','{Kqd-Kqd-RobotXH-TKD-03}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','0','1',NULL,NULL,'Kqd'), ('Kqd-Kqd-RobotQH-MT-07','机器人模态检测设备取货[Kqd齐套3]','Kqd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10',NULL,NULL,NULL,NULL,'T','{Kqd-Kqd-RobotXH-CC-05,Kqd-Kqd-CCJC-06,Kqd-Kqd-RobotQH-CC-07}','{Kqd-Kqd-MTJC-06}','{Kqd-Kqd-RobotXH-TKD-03}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','0','1',NULL,NULL,'Kqd'), ('Kqd-Kqd-RobotQH-PT-01','机器人智能装配平台取货[Kqd齐套1]','Kqd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10',NULL,NULL,NULL,NULL,'T',NULL,'{Kqd-Kqd-ZP01-01}','{Kqd-Kqd-RobotXH-TKD-01,Kqd-Kqd-RobotXH-XBC-01-TKD}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','0','1',NULL,NULL,'Kqd'), ('Kqd-Kqd-RobotQH-PT-02','机器人智能装配平台取货[Kqd齐套2]','Kqd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10',NULL,NULL,NULL,NULL,'T',NULL,'{Kqd-Kqd-ZP01-01}','{Kqd-Kqd-RobotXH-TKD-02,Kqd-Kqd-RobotXH-XBC-02-TKD}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','0','1',NULL,NULL,'Kqd'), ('Kqd-Kqd-RobotQH-PT-03','机器人智能装配平台取货[Kqd齐套3]','Kqd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10',NULL,NULL,NULL,NULL,'T',NULL,'{Kqd-Kqd-ZP01-01}','{Kqd-Kqd-RobotXH-CC-05,Kqd-Kqd-RobotXH-MT-05}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','0','1',NULL,NULL,'Kqd'), ('Kqd-Kqd-RobotQH-TKD-01','机器人停靠点1取货[Kqd齐套1]','Kqd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Kqd-Kqd-AGVXH-TKD-01}','{Kqd-Kqd-RobotXH-PT-01,Kqd-Kqd-RobotXH-XBC-01-PT}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'Kqd'), ('Kqd-Kqd-RobotQH-TKD-02','机器人停靠点1取货[Kqd齐套2]','Kqd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Kqd-Kqd-AGVXH-TKD-02}','{Kqd-Kqd-RobotXH-PT-02,Kqd-Kqd-RobotXH-XBC-02-PT}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'Kqd'), ('Kqd-Kqd-RobotQH-TKD-03','机器人停靠点1取货[Kqd齐套3]','Kqd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Kqd-Kqd-AGVXH-TKD-03}','{Kqd-Kqd-RobotXH-PT-03,Kqd-Kqd-RobotXH-XBC-03-PT}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'Kqd'), ('Kqd-Kqd-RobotQH-XBC-01-PT','机器人线边仓取货[Kqd齐套1]','Kqd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Kqd-Kqd-RobotXH-XBC-01-PT}','{Kqd-Kqd-RobotXH-PT-01-XBC}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Kqd-Kqd-RobotXH-XBC-01-PT}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'Kqd'), ('Kqd-Kqd-RobotQH-XBC-01-TKD','机器人线边仓取货[Kqd齐套1回]','Kqd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Kqd-Kqd-RobotXH-XBC-01-TKD}','{Kqd-Kqd-RobotXH-TKD-01-XBC}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Kqd-Kqd-RobotXH-XBC-01-TKD}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'Kqd'), ('Kqd-Kqd-RobotQH-XBC-02-PT','机器人线边仓取货[Kqd齐套2]','Kqd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Kqd-Kqd-RobotXH-XBC-02-PT}','{Kqd-Kqd-RobotXH-PT-02-XBC}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Kqd-Kqd-RobotXH-XBC-02-PT}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'Kqd'), ('Kqd-Kqd-RobotQH-XBC-02-TKD','机器人线边仓取货[Kqd齐套1回]','Kqd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Kqd-Kqd-RobotXH-XBC-02-TKD}','{Kqd-Kqd-RobotXH-TKD-02-XBC}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Kqd-Kqd-RobotXH-XBC-02-TKD}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'Kqd'), ('Kqd-Kqd-RobotQH-XBC-03-PT','机器人线边仓取货[Kqd齐套3]','Kqd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Kqd-Kqd-RobotXH-XBC-03-PT}','{Kqd-Kqd-RobotXH-PT-03-XBC}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Kqd-Kqd-RobotXH-XBC-03-PT}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'Kqd'), ('Kqd-Kqd-RobotXH-CC-05','机器人尺寸检测设备卸货[Kqd齐套3]','Kqd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10',NULL,NULL,NULL,NULL,'T','{Kqd-Kqd-RobotXH-MT-05,Kqd-Kqd-MTJC-06,Kqd-Kqd-RobotQH-MT-07}','{Kqd-Kqd-RobotQH-PT-03}','{Kqd-Kqd-CCJC-06}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','0','1',NULL,NULL,'Kqd'), ('Kqd-Kqd-RobotXH-MT-05','机器人模态检测设备卸货[Kqd齐套3]','Kqd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10',NULL,NULL,NULL,NULL,'T','{Kqd-Kqd-RobotXH-CC-05,Kqd-Kqd-CCJC-06,Kqd-Kqd-RobotQH-CC-07}','{Kqd-Kqd-RobotQH-PT-04-CP}','{Kqd-Kqd-MTJC-06}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','0','1',NULL,NULL,'Kqd'), ('Kqd-Kqd-RobotXH-PT-01','机器人智能装配平台卸货[Kqd齐套1]','Kqd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10','0',NULL,'0',NULL,'T',NULL,'{Kqd-Kqd-RobotQH-TKD-01}','{Kqd-Kqd-RobotXH-PT-02,Kqd-Kqd-RobotQH-XBC-02-PT}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Kqd-Kqd-RobotQH-TKD-01}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'Kqd'), ('Kqd-Kqd-RobotXH-PT-01-XBC','机器人线边仓至智能装配平台卸货[Kqd齐套1]','Kqd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Kqd-Kqd-RobotQH-XBC-01-PT}','{Kqd-Kqd-RobotXH-PT-02,Kqd-Kqd-RobotQH-XBC-02-PT}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Kqd-Kqd-RobotQH-XBC-01-PT}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'Kqd'), ('Kqd-Kqd-RobotXH-PT-02','机器人智能装配平台卸货[Kqd齐套2]','Kqd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10','0',NULL,'0',NULL,'T',NULL,'{Kqd-Kqd-AGVXH-TKD-02}','{Kqd-Kqd-RobotXH-PT-03,Kqd-Kqd-RobotQH-XBC-03-PT}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Kqd-Kqd-RobotQH-TKD-02}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'Kqd'), ('Kqd-Kqd-RobotXH-PT-02-XBC','机器人线边仓至智能装配平台卸货[Kqd齐套2]','Kqd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Kqd-Kqd-RobotQH-XBC-02-PT}','{Kqd-Kqd-RobotXH-PT-03,Kqd-Kqd-RobotQH-XBC-03-PT}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Kqd-Kqd-RobotQH-XBC-02-PT}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'Kqd'), ('Kqd-Kqd-RobotXH-PT-03','机器人智能装配平台卸货[Kqd齐套3]','Kqd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10','0',NULL,'0',NULL,'T',NULL,'{Kqd-Kqd-RobotQH-TKD-03}','{Kqd-Kqd-ZP01-01}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Kqd-Kqd-RobotQH-TKD-03}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'Kqd'), ('Kqd-Kqd-RobotXH-PT-03-XBC','机器人线边仓至智能装配平台卸货[Kqd齐套3]','Kqd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Kqd-Kqd-RobotQH-XBC-03-PT}','{Kqd-Kqd-ZP01-01}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Kqd-Kqd-RobotQH-XBC-03-PT}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'Kqd'), ('Kqd-Kqd-RobotXH-TKD-01','机器人停靠点2卸货[Kqd齐套1]','Kqd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10',NULL,NULL,NULL,NULL,'T',NULL,'{Kqd-Kqd-RobotQH-PT-01}','{Kqd-Kqd-AGVQH-TKD-01}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Kqd-Kqd-RobotQH-PT-01}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','0','1',NULL,NULL,'Kqd'), ('Kqd-Kqd-RobotXH-TKD-01-XBC','机器人线边仓至停靠点2卸货[Kqd齐套1回]','Kqd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Kqd-Kqd-RobotQH-XBC-01-TKD}','{Kqd-Kqd-AGVQH-TKD-01}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Kqd-Kqd-RobotQH-XBC-01-TKD}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'Kqd'), ('Kqd-Kqd-RobotXH-TKD-02','机器人停靠点2卸货[Kqd齐套2]','Kqd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10',NULL,NULL,NULL,NULL,'T',NULL,'{Kqd-Kqd-RobotQH-PT-02}','{Kqd-Kqd-AGVQH-TKD-02}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Kqd-Kqd-RobotQH-PT-02}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','0','1',NULL,NULL,'Kqd'), ('Kqd-Kqd-RobotXH-TKD-02-XBC','机器人线边仓至停靠点2卸货[Kqd齐套1回]','Kqd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Kqd-Kqd-RobotQH-XBC-02-TKD}','{Kqd-Kqd-AGVQH-TKD-02}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Kqd-Kqd-RobotQH-XBC-02-TKD}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'Kqd'), ('Kqd-Kqd-RobotXH-TKD-03','机器人停靠点2卸货[Kqd齐套3]','Kqd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10',NULL,NULL,NULL,NULL,'T',NULL,'{Kqd-Kqd-RobotQH-MT-07,Kqd-Kqd-RobotQH-CC-07}','{Kqd-Kqd-AGVQH-TKD-03}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Kqd-Kqd-RobotQH-PT-03}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','0','1',NULL,NULL,'Kqd'), ('Kqd-Kqd-RobotXH-XBC-01-PT','机器人线边仓卸货[Kqd齐套1]','Kqd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Kqd-Kqd-RobotQH-TKD-01}','{Kqd-Kqd-RobotQH-XBC-01-PT}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Kqd-Kqd-RobotQH-TKD-01}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'Kqd'), ('Kqd-Kqd-RobotXH-XBC-01-TKD','机器人线边仓卸货[Kqd齐套1回]','Kqd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Kqd-Kqd-RobotQH-PT-01}','{Kqd-Kqd-RobotQH-XBC-01-TKD}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Kqd-Kqd-RobotQH-PT-01}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'Kqd'), ('Kqd-Kqd-RobotXH-XBC-02-PT','机器人线边仓卸货[Kqd齐套2]','Kqd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Kqd-Kqd-RobotQH-TKD-02}','{Kqd-Kqd-RobotQH-XBC-02-PT}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Kqd-Kqd-RobotQH-TKD-02}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'Kqd'), ('Kqd-Kqd-RobotXH-XBC-02-TKD','机器人线边仓卸货[Kqd齐套1回]','Kqd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Kqd-Kqd-RobotQH-PT-02}','{Kqd-Kqd-RobotQH-XBC-02-TKD}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Kqd-Kqd-RobotQH-PT-02}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'Kqd'), ('Kqd-Kqd-RobotXH-XBC-03-PT','机器人线边仓卸货[Kqd齐套3]','Kqd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Kqd-Kqd-RobotQH-TKD-03}','{Kqd-Kqd-RobotQH-XBC-03-PT}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Kqd-Kqd-RobotQH-TKD-03}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'Kqd'), ('Kqd-Kqd-ZP01-01','空气舵装配1','Kqd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'600',NULL,NULL,NULL,NULL,'T',NULL,'{Kqd-Kqd-RobotXH-PT-01,Kqd-Kqd-RobotXH-PT-01-XBC,Kqd-Kqd-RobotXH-PT-02,Kqd-Kqd-RobotXH-PT-02-XBC,Kqd-Kqd-RobotXH-PT-03,Kqd-Kqd-RobotXH-PT-03-XBC}','{Kqd-Kqd-RobotQH-PT-01,Kqd-Kqd-RobotQH-PT-02,Kqd-Kqd-RobotQH-PT-03}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Kqd-Kqd-RobotXH-PT-01,Kqd-Kqd-RobotXH-PT-01-XBC,Kqd-Kqd-RobotXH-PT-02,Kqd-Kqd-RobotXH-PT-03-XBC,Kqd-Kqd-RobotXH-PT-03,Kqd-Kqd-RobotXH-PT-03-XBC}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','0','0',NULL,NULL,'Kqd'), ('Yqc','仪器舱产品装配','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','0','0','0','0','0','T',NULL,'{Gyc}','{}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','1','0',NULL,'Yqc',NULL), ('Yqc-Gyc-AGVQH-CK-01','AGV仓库取货[Gyc齐套1]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'60','0',NULL,'0',NULL,'T',NULL,'{}','{Yqc-Gyc-AGVXH-TKD-01,Yqc-Gyc-AGVQH-CK-02}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'Gyc'), ('Yqc-Gyc-AGVQH-CK-02','AGV仓库取货[Gyc齐套2]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'60','0',NULL,'0',NULL,'T',NULL,'{Yqc-Gyc-AGVQH-CK-01,Yqc-Gyc-AGVQH-CK-01}','{Yqc-Gyc-AGVXH-TKD-02}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'Gyc'), ('Yqc-Gyc-AGVQH-TKD-01','AGV停靠点2取货[Gyc齐套1]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10',NULL,NULL,NULL,NULL,'T',NULL,'{Yqc-Gyc-RobotXH-TKD-01,Yqc-Gyc-RobotXH-TKD-01-XBC}','{Yqc-Gyc-AGVXH-CK-01,Yqc-Gyc-AGVQH-TKD-02}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-Gyc-RobotXH-TKD-01,Yqc-Gyc-RobotXH-TKD-01-XBC}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','0','1',NULL,NULL,'Gyc'), ('Yqc-Gyc-AGVQH-TKD-02','AGV停靠点2取货[Gyc齐套2]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10',NULL,NULL,NULL,NULL,'T',NULL,'{Yqc-Gyc-RobotXH-TKD-02,Yqc-Gyc-AGVQH-TKD-01,Yqc-Gyc-RobotXH-TKD-02-XBC}','{Yqc-Gyc-AGVXH-CK-02}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-Gyc-RobotXH-TKD-02,Yqc-Gyc-RobotXH-TKD-02-XBC}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','0','1',NULL,NULL,'Gyc'), ('Yqc-Gyc-AGVXH-CK-01','AGV仓库卸货[Gyc齐套1]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10',NULL,NULL,NULL,NULL,'T',NULL,'{Yqc-Gyc-AGVQH-TKD-01}','{Yqc-Gyc-AGVXH-CK-02}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','0','1',NULL,NULL,'Gyc'), ('Yqc-Gyc-AGVXH-CK-02','AGV仓库卸货[Gyc齐套2]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10',NULL,NULL,NULL,NULL,'T',NULL,'{Yqc-Gyc-AGVQH-TKD-02,Yqc-Gyc-AGVXH-CK-01}','{}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','0','1',NULL,NULL,'Gyc'), ('Yqc-Gyc-AGVXH-TKD-01','AGV停靠点1卸货[Gyc齐套1]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10','0',NULL,'0',NULL,'T',NULL,'{Yqc-Gyc-AGVQH-CK-01}','{Yqc-Gyc-RobotQH-TKD-01,Yqc-Gyc-AGVXH-TKD-02}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'Gyc'), ('Yqc-Gyc-AGVXH-TKD-02','AGV停靠点1卸货[Gyc齐套2]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10','0',NULL,'0',NULL,'T',NULL,'{Yqc-Gyc-AGVQH-CK-02,Yqc-Gyc-AGVXH-TKD-01}','{Yqc-Gyc-RobotQH-TKD-02}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'Gyc'), ('Yqc-Gyc-RobotQH-PT-01','机器人智能装配平台取货[Gyc齐套1]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10',NULL,NULL,NULL,NULL,'T',NULL,'{Yqc-Gyc-ZP02-02}','{Yqc-Gyc-RobotXH-TKD-01,Yqc-Gyc-RobotQH-PT-02,Yqc-Gyc-RobotXH-XBC-01-TKD}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','0','1',NULL,NULL,'Gyc'), ('Yqc-Gyc-RobotQH-PT-02','机器人智能装配平台取货[Gyc齐套2]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10',NULL,NULL,NULL,NULL,'T',NULL,'{Yqc-Gyc-ZP03-03,Yqc-Gyc-RobotQH-PT-01}','{Yqc-Gyc-RobotXH-TKD-02,Yqc-Gyc-RobotXH-XBC-02-TKD}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','0','1',NULL,NULL,'Gyc'), ('Yqc-Gyc-RobotQH-TKD-01','机器人停靠点1取货[Gyc齐套1]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Yqc-Gyc-AGVXH-TKD-01}','{Yqc-Gyc-RobotXH-PT-01,Yqc-Gyc-RobotXH-XBC-01-PT,Yqc-Gyc-RobotQH-TKD-02}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'Gyc'), ('Yqc-Gyc-RobotQH-TKD-02','机器人停靠点1取货[Gyc齐套2]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Yqc-Gyc-AGVXH-TKD-02,Yqc-Gyc-RobotQH-TKD-01}','{Yqc-Gyc-RobotXH-PT-02,Yqc-Gyc-RobotXH-XBC-02-PT}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'Gyc'), ('Yqc-Gyc-RobotQH-XBC-01-PT','机器人线边仓取货[Gyc齐套1]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Yqc-Gyc-RobotXH-XBC-01-PT}','{Yqc-Gyc-RobotXH-PT-01-XBC,Yqc-Gyc-RobotQH-XBC-02-PT}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-Gyc-RobotXH-XBC-01-PT}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'Gyc'), ('Yqc-Gyc-RobotQH-XBC-01-TKD','机器人线边仓取货[Gyc齐套1回]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Yqc-Gyc-RobotXH-XBC-01-TKD}','{Yqc-Gyc-RobotXH-TKD-01-XBC}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-Gyc-RobotXH-XBC-01-TKD}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'Gyc'), ('Yqc-Gyc-RobotQH-XBC-02-PT','机器人线边仓取货[Gyc齐套2]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Yqc-Gyc-RobotXH-XBC-02-PT,Yqc-Gyc-RobotQH-XBC-01-PT}','{Yqc-Gyc-RobotXH-PT-02-XBC}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-Gyc-RobotXH-XBC-02-PT}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'Gyc'), ('Yqc-Gyc-RobotQH-XBC-02-TKD','机器人线边仓取货[Gyc齐套1回]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Yqc-Gyc-RobotXH-XBC-02-TKD}','{Yqc-Gyc-RobotXH-TKD-02-XBC}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-Gyc-RobotXH-XBC-02-TKD}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'Gyc'), ('Yqc-Gyc-RobotXH-PT-01','机器人智能装配平台卸货[Gyc齐套1]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10','0',NULL,'0',NULL,'T',NULL,'{Yqc-Gyc-RobotQH-TKD-01}','{Yqc-Gyc-ZP01-01,Yqc-Gyc-RobotXH-PT-02}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-Gyc-RobotQH-TKD-01}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'Gyc'), ('Yqc-Gyc-RobotXH-PT-01-XBC','机器人线边仓至智能装配平台卸货[Gyc齐套1]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Yqc-Gyc-RobotQH-XBC-01-PT}','{Yqc-Gyc-ZP01-01,Yqc-Gyc-RobotXH-PT-02-XBC}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-Gyc-RobotQH-XBC-01-PT}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'Gyc'), ('Yqc-Gyc-RobotXH-PT-02','机器人智能装配平台卸货[Gyc齐套2]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10','0',NULL,'0',NULL,'T',NULL,'{Yqc-Gyc-AGVXH-TKD-02,Yqc-Gyc-RobotXH-PT-01}','{Yqc-Gyc-ZP01-01}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-Gyc-RobotQH-TKD-02}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'Gyc'), ('Yqc-Gyc-RobotXH-PT-02-XBC','机器人线边仓至智能装配平台卸货[Gyc齐套2]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Yqc-Gyc-RobotQH-XBC-02-PT,Yqc-Gyc-RobotXH-PT-01-XBC}','{Yqc-Gyc-ZP01-01}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-Gyc-RobotQH-XBC-02-PT}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'Gyc'), ('Yqc-Gyc-RobotXH-TKD-01','机器人停靠点2卸货[Gyc齐套1]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10',NULL,NULL,NULL,NULL,'T',NULL,'{Yqc-Gyc-RobotQH-PT-01}','{Yqc-Gyc-AGVQH-TKD-01,Yqc-Gyc-RobotXH-TKD-02}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-Gyc-RobotQH-PT-01}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','0','1',NULL,NULL,'Gyc'), ('Yqc-Gyc-RobotXH-TKD-01-XBC','机器人线边仓至停靠点2卸货[Gyc齐套1回]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Yqc-Gyc-RobotQH-XBC-01-TKD}','{Yqc-Gyc-AGVQH-TKD-01}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-Gyc-RobotQH-XBC-01-TKD}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'Gyc'), ('Yqc-Gyc-RobotXH-TKD-02','机器人停靠点2卸货[Gyc齐套2]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10',NULL,NULL,NULL,NULL,'T',NULL,'{Yqc-Gyc-RobotQH-PT-02,Yqc-Gyc-RobotXH-TKD-01}','{Yqc-Gyc-AGVQH-TKD-02}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-Gyc-RobotQH-PT-02}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','0','1',NULL,NULL,'Gyc'), ('Yqc-Gyc-RobotXH-TKD-02-XBC','机器人线边仓至停靠点2卸货[Gyc齐套1回]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Yqc-Gyc-RobotQH-XBC-02-TKD}','{Yqc-Gyc-AGVQH-TKD-02}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-Gyc-RobotQH-XBC-02-TKD}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'Gyc'), ('Yqc-Gyc-RobotXH-XBC-01-PT','机器人线边仓卸货[Gyc齐套1]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Yqc-Gyc-RobotQH-TKD-01}','{Yqc-Gyc-RobotQH-XBC-01-PT,Yqc-Gyc-RobotXH-XBC-02-PT}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-Gyc-RobotQH-TKD-01}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'Gyc'), ('Yqc-Gyc-RobotXH-XBC-01-TKD','机器人线边仓卸货[Gyc齐套1回]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Yqc-Gyc-RobotQH-PT-01}','{Yqc-Gyc-RobotQH-XBC-01-TKD}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-Gyc-RobotQH-PT-01}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'Gyc'), ('Yqc-Gyc-RobotXH-XBC-02-PT','机器人线边仓卸货[Gyc齐套2]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Yqc-Gyc-RobotQH-TKD-02,Yqc-Gyc-RobotXH-XBC-01-PT}','{Yqc-Gyc-RobotQH-XBC-02-PT}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-Gyc-RobotQH-TKD-02}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'Gyc'), ('Yqc-Gyc-RobotXH-XBC-02-TKD','机器人线边仓卸货[Gyc齐套1回]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Yqc-Gyc-RobotQH-PT-02}','{Yqc-Gyc-RobotQH-XBC-02-TKD}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-Gyc-RobotQH-PT-02}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'Gyc'), ('Yqc-Gyc-ZP01-01','工艺舱装配1','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'500','0',NULL,'0',NULL,'T',NULL,'{Yqc-Gyc-RobotXH-PT-01,Yqc-Gyc-RobotXH-PT-01-XBC,Yqc-Gyc-RobotXH-PT-02,Yqc-Gyc-RobotXH-PT-02-XBC}','{Yqc-Gyc-RobotQH-PT-01,Yqc-Gyc-RobotQH-PT-02}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-Gyc-RobotXH-PT-01,Yqc-Gyc-RobotXH-PT-01-XBC,Yqc-Gyc-RobotXH-PT-02,Yqc-Gyc-RobotXH-PT-02-XBC}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','0',NULL,NULL,'Gyc'), ('Yqc-Kjt-AGVQH-CK-01','AGV仓库取货[Kjt齐套1]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'60','0',NULL,'0',NULL,'T',NULL,'{}','{Yqc-Kjt-AGVXH-TKD-01,Yqc-Kjt-AGVQH-CK-02}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'Kjt'), ('Yqc-Kjt-AGVQH-CK-02','AGV仓库取货[Kjt齐套2]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'60','0',NULL,'0',NULL,'T',NULL,'{Yqc-Kjt-AGVQH-CK-01}','{Yqc-Kjt-AGVXH-TKD-02,Yqc-Kjt-AGVQH-CK-03}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'Kjt'), ('Yqc-Kjt-AGVQH-CK-03','AGV仓库取货[Kjt齐套3]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'60','0',NULL,'0',NULL,'T',NULL,'{Yqc-Kjt-AGVQH-CK-02,Yqc-Kjt-AGVQH-CK-02}','{Yqc-Kjt-AGVXH-TKD-03}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'Kjt'), ('Yqc-Kjt-AGVQH-TKD-01','AGV停靠点2取货[Kjt齐套1]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10',NULL,NULL,NULL,NULL,'T',NULL,'{Yqc-Kjt-RobotXH-TKD-01,Yqc-Kjt-RobotXH-TKD-01-XBC}','{Yqc-Kjt-AGVXH-CK-01,Yqc-Kjt-AGVQH-TKD-02}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-Kjt-RobotXH-TKD-01,Yqc-Kjt-RobotXH-TKD-01-XBC}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','0','1',NULL,NULL,'Kjt'), ('Yqc-Kjt-AGVQH-TKD-02','AGV停靠点2取货[Kjt齐套2]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10',NULL,NULL,NULL,NULL,'T',NULL,'{Yqc-Kjt-RobotXH-TKD-02,Yqc-Kjt-AGVQH-TKD-01,Yqc-Kjt-RobotXH-TKD-02-XBC}','{Yqc-Kjt-AGVXH-CK-02,Yqc-Kjt-AGVQH-TKD-03}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-Kjt-RobotXH-TKD-02,Yqc-Kjt-RobotXH-TKD-02-XBC}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','0','1',NULL,NULL,'Kjt'), ('Yqc-Kjt-AGVQH-TKD-03','AGV停靠点2取货[Kjt齐套3]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10',NULL,NULL,NULL,NULL,'T',NULL,'{Yqc-Kjt-RobotXH-TKD-03,Yqc-Kjt-AGVQH-TKD-02,Yqc-Kjt-RobotXH-TKD-03-XBC}','{Yqc-Kjt-AGVXH-CK-03}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-Kjt-RobotXH-TKD-03,Yqc-Kjt-RobotXH-TKD-03-XBC}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','0','1',NULL,NULL,'Kjt'), ('Yqc-Kjt-AGVXH-CK-01','AGV仓库卸货[Kjt齐套1]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10',NULL,NULL,NULL,NULL,'T',NULL,'{Yqc-Kjt-AGVQH-TKD-01}','{Yqc-Kjt-AGVXH-CK-02}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','0','1',NULL,NULL,'Kjt'), ('Yqc-Kjt-AGVXH-CK-02','AGV仓库卸货[Kjt齐套2]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10',NULL,NULL,NULL,NULL,'T',NULL,'{Yqc-Kjt-AGVQH-TKD-02,Yqc-Kjt-AGVXH-CK-01}','{Yqc-Kjt-AGVXH-CK-03}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','0','1',NULL,NULL,'Kjt'), ('Yqc-Kjt-AGVXH-CK-03','AGV仓库卸货[Kjt齐套3]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10',NULL,NULL,NULL,NULL,'T',NULL,'{Yqc-Kjt-AGVQH-TKD-03,Yqc-Kjt-AGVXH-CK-02}','{}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','0','1',NULL,NULL,'Kjt'), ('Yqc-Kjt-AGVXH-TKD-01','AGV停靠点1卸货[Kjt齐套1]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10','0',NULL,'0',NULL,'T',NULL,'{Yqc-Kjt-AGVQH-CK-01}','{Yqc-Kjt-RobotQH-TKD-01,Yqc-Kjt-AGVXH-TKD-02}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'Kjt'), ('Yqc-Kjt-AGVXH-TKD-02','AGV停靠点1卸货[Kjt齐套2]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10','0',NULL,'0',NULL,'T',NULL,'{Yqc-Kjt-AGVQH-CK-02,Yqc-Kjt-AGVXH-TKD-01}','{Yqc-Kjt-RobotQH-TKD-02,Yqc-Kjt-AGVXH-TKD-03}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'Kjt'), ('Yqc-Kjt-AGVXH-TKD-03','AGV停靠点1卸货[Kjt齐套3]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10','0',NULL,'0',NULL,'T',NULL,'{Yqc-Kjt-AGVQH-CK-03,Yqc-Kjt-AGVXH-TKD-02}','{Yqc-Kjt-RobotQH-TKD-03}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'Kjt'), ('Yqc-Kjt-RobotQH-PT-01','机器人智能装配平台取货[Kjt齐套1]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10',NULL,NULL,NULL,NULL,'T',NULL,'{Yqc-Kjt-ZP01-01}','{Yqc-Kjt-RobotXH-TKD-01,Yqc-Kjt-RobotQH-PT-02,Yqc-Kjt-RobotXH-XBC-01-TKD}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','0','1',NULL,NULL,'Kjt'), ('Yqc-Kjt-RobotQH-PT-02','机器人智能装配平台取货[Kjt齐套2]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10',NULL,NULL,NULL,NULL,'T',NULL,'{Yqc-Kjt-ZP01-01,Yqc-Kjt-RobotQH-PT-01}','{Yqc-Kjt-RobotXH-TKD-02,Yqc-Kjt-RobotQH-PT-03,Yqc-Kjt-RobotQH-XBC-02-TKD}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','0','1',NULL,NULL,'Kjt'), ('Yqc-Kjt-RobotQH-PT-03','机器人智能装配平台取货[Kjt齐套3]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10',NULL,NULL,NULL,NULL,'T',NULL,'{Yqc-Kjt-ZP01-01,Yqc-Kjt-RobotQH-PT-02}','{Yqc-Kjt-RobotXH-TKD-03,Yqc-Kjt-RobotXH-XBC-03-TKD}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','0','1',NULL,NULL,'Kjt'), ('Yqc-Kjt-RobotQH-TKD-01','机器人停靠点1取货[Kjt齐套1]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Yqc-Kjt-AGVXH-TKD-01}','{Yqc-Kjt-RobotXH-PT-01,Yqc-Kjt-RobotXH-XBC-01-PT,Yqc-Kjt-RobotQH-TKD-02}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'Kjt'), ('Yqc-Kjt-RobotQH-TKD-02','机器人停靠点1取货[Kjt齐套2]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Yqc-Kjt-AGVXH-TKD-02,Yqc-Kjt-RobotQH-TKD-01}','{Yqc-Kjt-RobotXH-PT-02,Yqc-Kjt-RobotXH-XBC-02-PT,Yqc-Kjt-RobotQH-TKD-03}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'Kjt'), ('Yqc-Kjt-RobotQH-TKD-03','机器人停靠点1取货[Kjt齐套3]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Yqc-Kjt-AGVXH-TKD-03,Yqc-Kjt-RobotQH-TKD-02}','{Yqc-Kjt-RobotXH-PT-03,Yqc-Kjt-RobotXH-XBC-03-PT}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'Kjt'), ('Yqc-Kjt-RobotQH-XBC-01-PT','机器人线边仓取货[Kjt齐套1]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Yqc-Kjt-RobotXH-XBC-01-PT}','{Yqc-Kjt-RobotXH-PT-01-XBC,Yqc-Kjt-RobotQH-XBC-02-PT}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-Kjt-RobotXH-XBC-01-PT}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'Kjt'), ('Yqc-Kjt-RobotQH-XBC-01-TKD','机器人线边仓取货[kjt齐套1回]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Yqc-Kjt-RobotXH-XBC-01-TKD}','{Yqc-Kjt-RobotXH-TKD-01-XBC}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-Kjt-RobotXH-XBC-01-TKD}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'Kjt');
INSERT INTO `rg_process` VALUES ('Yqc-Kjt-RobotQH-XBC-02-PT','机器人线边仓取货[Kjt齐套2]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Yqc-Kjt-RobotXH-XBC-02-PT,Yqc-Kjt-RobotQH-XBC-01-PT}','{Yqc-Kjt-RobotXH-PT-02-XBC,Yqc-Kjt-RobotQH-XBC-03-PT}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-Kjt-RobotXH-XBC-02-PT}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'Kjt'), ('Yqc-Kjt-RobotQH-XBC-02-TKD','机器人线边仓取货[kjt齐套1回]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Yqc-Kjt-RobotXH-XBC-02-TKD}','{Yqc-Kjt-RobotXH-TKD-02-XBC}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-Kjt-RobotXH-XBC-02-TKD}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'Kjt'), ('Yqc-Kjt-RobotQH-XBC-03-PT','机器人线边仓取货[Kjt齐套3]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Yqc-Kjt-RobotXH-XBC-03-PT,Yqc-Kjt-RobotQH-XBC-02-PT}','{Yqc-Kjt-RobotXH-PT-03-XBC}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-Kjt-RobotXH-XBC-03-PT}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'Kjt'), ('Yqc-Kjt-RobotQH-XBC-03-TKD','机器人线边仓取货[kjt齐套1回]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Yqc-Kjt-RobotXH-XBC-03-TKD}','{Yqc-Kjt-RobotXH-TKD-03-XBC}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-Kjt-RobotXH-XBC-03-TKD}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'Kjt'), ('Yqc-Kjt-RobotXH-PT-01','机器人智能装配平台卸货[Kjt齐套1]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10','0',NULL,'0',NULL,'T',NULL,'{Yqc-Kjt-RobotQH-TKD-01}','{Yqc-Kjt-ZP01-01,Yqc-Kjt-RobotXH-PT-02}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-Kjt-RobotQH-TKD-01}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'Kjt'), ('Yqc-Kjt-RobotXH-PT-01-XBC','机器人线边仓至智能装配平台卸货[Kjt齐套1]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Yqc-Kjt-RobotQH-XBC-01-PT}','{Yqc-Kjt-ZP01-01,Yqc-Kjt-RobotXH-PT-02-XBC}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-Kjt-RobotQH-XBC-01-PT}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'Kjt'), ('Yqc-Kjt-RobotXH-PT-02','机器人智能装配平台卸货[Kjt齐套2]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10','0',NULL,'0',NULL,'T',NULL,'{Yqc-Kjt-AGVXH-TKD-02,Yqc-Kjt-RobotXH-PT-01}','{Yqc-Kjt-ZP01-01,Yqc-Kjt-RobotXH-PT-03}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-Kjt-RobotQH-TKD-02}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'Kjt'), ('Yqc-Kjt-RobotXH-PT-02-XBC','机器人线边仓至智能装配平台卸货[Kjt齐套2]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Yqc-Kjt-RobotQH-XBC-02-PT,Yqc-Kjt-RobotXH-PT-01-XBC}','{Yqc-Kjt-ZP01-01,Yqc-Kjt-RobotXH-PT-03-XBC}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-Kjt-RobotQH-XBC-02-PT}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'Kjt'), ('Yqc-Kjt-RobotXH-PT-03','机器人智能装配平台卸货[Kjt齐套3]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10','0',NULL,'0',NULL,'T',NULL,'{Yqc-Kjt-RobotQH-TKD-03,Yqc-Kjt-RobotXH-PT-02}','{Yqc-Kjt-ZP01-01}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-Kjt-RobotQH-TKD-03}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'Kjt'), ('Yqc-Kjt-RobotXH-PT-03-XBC','机器人线边仓至智能装配平台卸货[Kjt齐套3]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Yqc-Kjt-RobotQH-XBC-03-PT,Yqc-Kjt-RobotXH-PT-02-XBC}','{Yqc-Kjt-ZP01-01}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-Kjt-RobotQH-XBC-03-PT}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'Kjt'), ('Yqc-Kjt-RobotXH-TKD-01','机器人停靠点2卸货[Kjt齐套1]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10',NULL,NULL,NULL,NULL,'T',NULL,'{Yqc-Kjt-RobotQH-PT-01}','{Yqc-Kjt-AGVQH-TKD-01,Yqc-Kjt-RobotXH-TKD-02}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-Kjt-RobotQH-PT-01}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','0','1',NULL,NULL,'Kjt'), ('Yqc-Kjt-RobotXH-TKD-01-XBC','机器人线边仓至停靠点2卸货[kjt齐套1回]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Yqc-Kjt-RobotQH-XBC-01-TKD}','{Yqc-Kjt-AGVQH-TKD-01}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-Kjt-RobotQH-XBC-01-TKD}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'Kjt'), ('Yqc-Kjt-RobotXH-TKD-02','机器人停靠点2卸货[Kjt齐套2]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10',NULL,NULL,NULL,NULL,'T',NULL,'{Yqc-Kjt-RobotQH-PT-02,Yqc-Kjt-RobotXH-TKD-01}','{Yqc-Kjt-AGVQH-TKD-02,Yqc-Kjt-RobotXH-TKD-03}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-Kjt-RobotQH-PT-02}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','0','1',NULL,NULL,'Kjt'), ('Yqc-Kjt-RobotXH-TKD-02-XBC','机器人线边仓至停靠点2卸货[kjt齐套1回]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Yqc-Kjt-RobotQH-XBC-02-TKD}','{Yqc-Kjt-AGVQH-TKD-02}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-Kjt-RobotQH-XBC-02-TKD}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'Kjt'), ('Yqc-Kjt-RobotXH-TKD-03','机器人停靠点2卸货[Kjt齐套3]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10',NULL,NULL,NULL,NULL,'T',NULL,'{Yqc-Kjt-RobotQH-PT-03,Yqc-Kjt-RobotXH-TKD-02}','{Yqc-Kjt-AGVQH-TKD-03}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-Kjt-RobotQH-PT-03}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','0','1',NULL,NULL,'Kjt'), ('Yqc-Kjt-RobotXH-TKD-03-XBC','机器人线边仓至停靠点2卸货[kjt齐套1回]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Yqc-Kjt-RobotQH-XBC-03-TKD}','{Yqc-Kjt-AGVQH-TKD-03}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-Kjt-RobotQH-XBC-03-TKD}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'Kjt'), ('Yqc-Kjt-RobotXH-XBC-01-PT','机器人线边仓卸货[Kjt齐套1]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Yqc-Kjt-RobotQH-TKD-01}','{Yqc-Kjt-RobotQH-XBC-01-PT,Yqc-Kjt-RobotXH-XBC-02-PT}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-Kjt-RobotQH-TKD-01}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'Kjt'), ('Yqc-Kjt-RobotXH-XBC-01-TKD','机器人线边仓卸货[kjt齐套1回]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Yqc-Kjt-RobotQH-PT-01}','{Yqc-Kjt-RobotQH-XBC-01-TKD}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-Kjt-RobotQH-PT-01}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'Kjt'), ('Yqc-Kjt-RobotXH-XBC-02-PT','机器人线边仓卸货[Kjt齐套2]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Yqc-Kjt-RobotQH-TKD-02,Yqc-Kjt-RobotXH-XBC-01-PT}','{Yqc-Kjt-RobotQH-XBC-02-PT,Yqc-Kjt-RobotXH-XBC-03-PT}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-Kjt-RobotQH-TKD-02}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'Kjt'), ('Yqc-Kjt-RobotXH-XBC-02-TKD','机器人线边仓卸货[kjt齐套1回]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Yqc-Kjt-RobotQH-PT-02}','{Yqc-Kjt-RobotQH-XBC-02-TKD}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-Kjt-RobotQH-PT-02}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'Kjt'), ('Yqc-Kjt-RobotXH-XBC-03-PT','机器人线边仓卸货[Kjt齐套3]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Yqc-Kjt-RobotQH-TKD-03,Yqc-Kjt-RobotXH-XBC-02-PT}','{Yqc-Kjt-RobotQH-XBC-03-PT}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-Kjt-RobotQH-TKD-03}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'Kjt'), ('Yqc-Kjt-RobotXH-XBC-03-TKD','机器人线边仓卸货[kjt齐套1回]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Yqc-Kjt-RobotQH-PT-03}','{Yqc-Kjt-RobotQH-XBC-03-TKD}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-Kjt-RobotQH-PT-03}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'Kjt'), ('Yqc-Kjt-ZP01-01','框架体装配1','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'300','0',NULL,'0',NULL,'T',NULL,'{Yqc-Kjt-RobotXH-PT-01,Yqc-Kjt-RobotXH-PT-01-XBC,Yqc-Kjt-RobotXH-PT-02,Yqc-Kjt-RobotXH-PT-02-XBC,Yqc-Kjt-RobotXH-PT-03,Yqc-Kjt-RobotXH-PT-03-XBC}','{Yqc-Kjt-RobotQH-PT-01,Yqc-Kjt-RobotQH-PT-02,Yqc-Kjt-RobotQH-PT-03}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-Kjt-RobotXH-PT-01,Yqc-Kjt-RobotXH-PT-01-XBC,Yqc-Kjt-RobotXH-PT-02,Yqc-Kjt-RobotXH-PT-02-XBC,Yqc-Kjt-RobotXH-PT-03,Yqc-Kjt-RobotXH-PT-03-XBC}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','0',NULL,NULL,'Kjt'), ('Yqc-KjtToGyc-AGVQH-CK-01','AGV仓库取货[KjtToGyc齐套1]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'60','0',NULL,'0',NULL,'T',NULL,'{}','{Yqc-KjtToGyc-AGVXH-TKD-01,Yqc-KjtToGyc-AGVQH-CK-02}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'KjtToGyc'), ('Yqc-KjtToGyc-AGVQH-CK-02','AGV仓库取货[KjtToGyc齐套2]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'60','0',NULL,'0',NULL,'T',NULL,'{Yqc-KjtToGyc-AGVQH-CK-01,Yqc-KjtToGyc-AGVQH-CK-01}','{Yqc-KjtToGyc-AGVXH-TKD-02}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'KjtToGyc'), ('Yqc-KjtToGyc-AGVQH-TKD-01','AGV停靠点2取货[KjtToGyc齐套1]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10',NULL,NULL,NULL,NULL,'T',NULL,'{Yqc-KjtToGyc-RobotXH-TKD-01,Yqc-KjtToGyc-RobotQH-XBC-01-TKD}','{Yqc-KjtToGyc-AGVXH-CK-01,Yqc-KjtToGyc-AGVQH-TKD-02}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-KjtToGyc-RobotXH-TKD-01,Yqc-KjtToGyc-RobotQH-XBC-01-TKD}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','0','1',NULL,NULL,'KjtToGyc'), ('Yqc-KjtToGyc-AGVQH-TKD-02','AGV停靠点2取货[KjtToGyc齐套2]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10',NULL,NULL,NULL,NULL,'T',NULL,'{Yqc-KjtToGyc-RobotXH-TKD-02,Yqc-KjtToGyc-AGVQH-TKD-01,Yqc-KjtToGyc-RobotXH-TKD-02-XBC}','{Yqc-KjtToGyc-AGVXH-CK-02}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-KjtToGyc-RobotXH-TKD-02,Yqc-KjtToGyc-RobotXH-TKD-02-XBC}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','0','1',NULL,NULL,'KjtToGyc'), ('Yqc-KjtToGyc-AGVXH-CK-01','AGV仓库卸货[KjtToGyc齐套1]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10',NULL,NULL,NULL,NULL,'T',NULL,'{Yqc-KjtToGyc-AGVQH-TKD-01}','{Yqc-KjtToGyc-AGVXH-CK-02}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','0','1',NULL,NULL,'KjtToGyc'), ('Yqc-KjtToGyc-AGVXH-CK-02','AGV仓库卸货[KjtToGyc齐套2]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10',NULL,NULL,NULL,NULL,'T',NULL,'{Yqc-KjtToGyc-AGVQH-TKD-02,Yqc-KjtToGyc-AGVXH-CK-01}','{}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','0','1',NULL,NULL,'KjtToGyc'), ('Yqc-KjtToGyc-AGVXH-TKD-01','AGV停靠点1卸货[KjtToGyc齐套1]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10','0',NULL,'0',NULL,'T',NULL,'{Yqc-KjtToGyc-AGVQH-CK-01}','{Yqc-KjtToGyc-RobotQH-TKD-01,Yqc-KjtToGyc-AGVXH-TKD-02}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'KjtToGyc'), ('Yqc-KjtToGyc-AGVXH-TKD-02','AGV停靠点1卸货[KjtToGyc齐套2]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10','0',NULL,'0',NULL,'T',NULL,'{Yqc-KjtToGyc-AGVQH-CK-02,Yqc-KjtToGyc-AGVXH-TKD-01}','{Yqc-KjtToGyc-RobotQH-TKD-02}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'KjtToGyc'), ('Yqc-KjtToGyc-RobotQH-PT-01','机器人智能装配平台取货[KjtToGyc齐套1]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10',NULL,NULL,NULL,NULL,'T',NULL,'{Yqc-KjtToGyc-ZP01-01}','{Yqc-KjtToGyc-RobotXH-TKD-01,Yqc-KjtToGyc-RobotQH-PT-02}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','0','1',NULL,NULL,'KjtToGyc'), ('Yqc-KjtToGyc-RobotQH-PT-02','机器人智能装配平台取货[KjtToGyc齐套2]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10',NULL,NULL,NULL,NULL,'T',NULL,'{Yqc-KjtToGyc-ZP01-01,Yqc-KjtToGyc-RobotQH-PT-01}','{Yqc-KjtToGyc-RobotXH-TKD-02,Yqc-KjtToGyc-RobotXH-XBC-02-TKD}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','0','1',NULL,NULL,'KjtToGyc'), ('Yqc-KjtToGyc-RobotQH-TKD-01','机器人停靠点1取货[KjtToGyc齐套1]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Yqc-KjtToGyc-AGVXH-TKD-01}','{Yqc-KjtToGyc-RobotXH-PT-01,Yqc-KjtToGyc-RobotXH-XBC-01-PT,Yqc-KjtToGyc-RobotQH-TKD-02}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'KjtToGyc'), ('Yqc-KjtToGyc-RobotQH-TKD-02','机器人停靠点1取货[KjtToGyc齐套2]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Yqc-KjtToGyc-AGVXH-TKD-02,Yqc-KjtToGyc-RobotQH-TKD-01}','{Yqc-KjtToGyc-RobotXH-PT-02,Yqc-KjtToGyc-RobotXH-XBC-02-PT}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'KjtToGyc'), ('Yqc-KjtToGyc-RobotQH-XBC-01-PT','机器人线边仓取货[KjtToGyc齐套1]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Yqc-KjtToGyc-RobotXH-XBC-01-PT}','{Yqc-KjtToGyc-RobotXH-PT-01-XBC,Yqc-KjtToGyc-RobotQH-XBC-02-PT}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-KjtToGyc-RobotXH-XBC-01-PT}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'KjtToGyc'), ('Yqc-KjtToGyc-RobotQH-XBC-01-TKD','机器人线边仓取货[KjtToGyc齐套1回]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Yqc-KjtToGyc-RobotXH-XBC-01-TKD}','{Yqc-KjtToGyc-RobotXH-TKD-01-XBC}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-KjtToGyc-RobotXH-XBC-01-TKD}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'KjtToGyc'), ('Yqc-KjtToGyc-RobotQH-XBC-02-PT','机器人线边仓取货[KjtToGyc齐套2]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Yqc-KjtToGyc-RobotXH-XBC-02-PT,Yqc-KjtToGyc-RobotQH-XBC-01-PT}','{Yqc-KjtToGyc-RobotXH-PT-02-XBC}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-KjtToGyc-RobotXH-XBC-02-PT}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'KjtToGyc'), ('Yqc-KjtToGyc-RobotQH-XBC-02-TKD','机器人线边仓取货[KjtToGyc齐套1回]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Yqc-KjtToGyc-RobotXH-XBC-02-TKD}','{Yqc-KjtToGyc-RobotXH-TKD-02-XBC}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-KjtToGyc-RobotXH-XBC-02-TKD}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'KjtToGyc'), ('Yqc-KjtToGyc-RobotXH-PT-01','机器人智能装配平台卸货[KjtToGyc齐套1]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10','0',NULL,'0',NULL,'T',NULL,'{Yqc-KjtToGyc-RobotQH-TKD-01}','{Yqc-KjtToGyc-ZP01-01,Yqc-KjtToGyc-RobotXH-PT-02}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-KjtToGyc-RobotQH-TKD-01}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'KjtToGyc'), ('Yqc-KjtToGyc-RobotXH-PT-01-XBC','机器人线边仓至智能装配平台卸货[KjtToGyc齐套1]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Yqc-KjtToGyc-RobotQH-XBC-01-PT}','{Yqc-KjtToGyc-ZP01-01,Yqc-KjtToGyc-RobotXH-PT-02-XBC}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-KjtToGyc-RobotQH-XBC-01-PT}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'KjtToGyc'), ('Yqc-KjtToGyc-RobotXH-PT-02','机器人智能装配平台卸货[KjtToGyc齐套2]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10','0',NULL,'0',NULL,'T',NULL,'{Yqc-KjtToGyc-AGVXH-TKD-02,Yqc-KjtToGyc-RobotXH-PT-01}','{Yqc-KjtToGyc-ZP01-01}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-KjtToGyc-RobotQH-TKD-02}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'KjtToGyc'), ('Yqc-KjtToGyc-RobotXH-PT-02-XBC','机器人线边仓至智能装配平台卸货[KjtToGyc齐套2]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Yqc-KjtToGyc-RobotQH-XBC-02-PT,Yqc-KjtToGyc-RobotXH-PT-01-XBC}','{Yqc-KjtToGyc-ZP01-01}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-KjtToGyc-RobotQH-XBC-02-PT}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'KjtToGyc'), ('Yqc-KjtToGyc-RobotXH-TKD-01','机器人停靠点2卸货[KjtToGyc齐套1]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10',NULL,NULL,NULL,NULL,'T',NULL,'{Yqc-KjtToGyc-RobotQH-PT-01}','{Yqc-KjtToGyc-AGVQH-TKD-01,Yqc-KjtToGyc-RobotXH-TKD-02}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-KjtToGyc-RobotQH-PT-01}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','0','1',NULL,NULL,'KjtToGyc'), ('Yqc-KjtToGyc-RobotXH-TKD-01-XBC','机器人线边仓至停靠点2卸货[KjtToGyc齐套1回]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Yqc-KjtToGyc-RobotQH-XBC-01-TKD}','{Yqc-KjtToGyc-AGVQH-TKD-01}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-KjtToGyc-RobotQH-XBC-01-TKD}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'KjtToGyc'), ('Yqc-KjtToGyc-RobotXH-TKD-02','机器人停靠点2卸货[KjtToGyc齐套2]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10',NULL,NULL,NULL,NULL,'T',NULL,'{Yqc-KjtToGyc-RobotQH-PT-02,Yqc-KjtToGyc-RobotXH-TKD-01}','{Yqc-KjtToGyc-AGVQH-TKD-02}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-KjtToGyc-RobotQH-PT-02}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','0','1',NULL,NULL,'KjtToGyc'), ('Yqc-KjtToGyc-RobotXH-TKD-02-XBC','机器人线边仓至停靠点2卸货[KjtToGyc齐套1回]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Yqc-KjtToGyc-RobotQH-XBC-02-TKD}','{Yqc-KjtToGyc-AGVQH-TKD-02}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-KjtToGyc-RobotQH-XBC-02-TKD}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'KjtToGyc'), ('Yqc-KjtToGyc-RobotXH-XBC-01-PT','机器人线边仓卸货[KjtToGyc齐套1]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Yqc-KjtToGyc-RobotQH-TKD-01}','{Yqc-KjtToGyc-RobotQH-XBC-01-PT,Yqc-KjtToGyc-RobotXH-XBC-02-PT}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-KjtToGyc-RobotQH-TKD-01}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'KjtToGyc'), ('Yqc-KjtToGyc-RobotXH-XBC-01-TKD','机器人线边仓卸货[KjtToGyc齐套1回]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Yqc-KjtToGyc-RobotQH-PT-01}','{Yqc-KjtToGyc-RobotQH-XBC-01-TKD}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-KjtToGyc-RobotQH-PT-01}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'KjtToGyc'), ('Yqc-KjtToGyc-RobotXH-XBC-02-PT','机器人线边仓卸货[KjtToGyc齐套2]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Yqc-KjtToGyc-RobotQH-TKD-02,Yqc-KjtToGyc-RobotXH-XBC-01-PT}','{Yqc-KjtToGyc-RobotQH-XBC-02-PT}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-KjtToGyc-RobotQH-TKD-02}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'KjtToGyc'), ('Yqc-KjtToGyc-RobotXH-XBC-02-TKD','机器人线边仓卸货[KjtToGyc齐套1回]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Yqc-KjtToGyc-RobotQH-PT-02}','{Yqc-KjtToGyc-RobotQH-XBC-02-TKD}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-KjtToGyc-RobotQH-PT-02}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'KjtToGyc'), ('Yqc-KjtToGyc-ZP01-01','框架体装入工艺舱1','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'500','0',NULL,'0',NULL,'T',NULL,'{Yqc-KjtToGyc-RobotXH-PT-01,Yqc-KjtToGyc-RobotXH-PT-01-XBC,Yqc-KjtToGyc-RobotXH-PT-02,Yqc-KjtToGyc-RobotXH-PT-02-XBC}','{Yqc-KjtToGyc-RobotQH-PT-01,Yqc-KjtToGyc-RobotXH-XBC-01-TKD}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-KjtToGyc-RobotXH-PT-01,Yqc-KjtToGyc-RobotXH-PT-01-XBC,Yqc-KjtToGyc-RobotXH-PT-02,Yqc-KjtToGyc-RobotXH-PT-02-XBC}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','0',NULL,NULL,'KjtToGyc'), ('Yqc-ZjHdmk-AGVQH-CK-01','AGV仓库取货[ZjHdmk齐套1]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'60','0',NULL,'0',NULL,'T',NULL,'{}','{Yqc-ZjHdmk-AGVXH-TKD-01,Yqc-ZjHdmk-AGVQH-CK-02}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'ZjHdmk'), ('Yqc-ZjHdmk-AGVQH-CK-02','AGV仓库取货[ZjHdmk齐套2]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'60','0',NULL,'0',NULL,'T',NULL,'{Yqc-ZjHdmk-AGVQH-CK-01,Yqc-ZjHdmk-AGVQH-CK-01}','{Yqc-ZjHdmk-AGVXH-TKD-02}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'ZjHdmk'), ('Yqc-ZjHdmk-AGVQH-TKD-01','AGV停靠点2取货[ZjHdmk齐套1]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10',NULL,NULL,NULL,NULL,'T',NULL,'{Yqc-ZjHdmk-RobotXH-TKD-01,Yqc-ZjHdmk-RobotXH-TKD-01-XBC}','{Yqc-ZjHdmk-AGVXH-CK-01}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-ZjHdmk-RobotXH-TKD-01,Yqc-ZjHdmk-RobotXH-TKD-01-XBC}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','0','1',NULL,NULL,'ZjHdmk'), ('Yqc-ZjHdmk-AGVQH-TKD-02','AGV停靠点2取货[ZjHdmk齐套2]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10',NULL,NULL,NULL,NULL,'T',NULL,'{Yqc-ZjHdmk-RobotXH-TKD-02}','{Yqc-ZjHdmk-AGVXH-CK-02}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-ZjHdmk-RobotXH-TKD-02,Yqc-ZjHdmk-RobotXH-TKD-02-XBC}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','0','1',NULL,NULL,'ZjHdmk'), ('Yqc-ZjHdmk-AGVXH-CK-01','AGV仓库卸货[ZjHdmk齐套1]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10',NULL,NULL,NULL,NULL,'T',NULL,'{Yqc-ZjHdmk-AGVQH-TKD-01}','{}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','0','1',NULL,NULL,'ZjHdmk'), ('Yqc-ZjHdmk-AGVXH-CK-02','AGV仓库卸货[ZjHdmk齐套2]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10',NULL,NULL,NULL,NULL,'T',NULL,'{Yqc-ZjHdmk-AGVQH-TKD-02}','{}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','0','1',NULL,NULL,'ZjHdmk'), ('Yqc-ZjHdmk-AGVXH-TKD-01','AGV停靠点1卸货[ZjHdmk齐套1]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10','0',NULL,'0',NULL,'T',NULL,'{Yqc-ZjHdmk-AGVQH-CK-01}','{Yqc-ZjHdmk-RobotQH-TKD-01,Yqc-ZjHdmk-AGVXH-TKD-02}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'ZjHdmk'), ('Yqc-ZjHdmk-AGVXH-TKD-02','AGV停靠点1卸货[ZjHdmk齐套2]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10','0',NULL,'0',NULL,'T',NULL,'{Yqc-ZjHdmk-AGVQH-CK-02,Yqc-ZjHdmk-AGVXH-TKD-01}','{Yqc-ZjHdmk-RobotQH-TKD-02}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'ZjHdmk'), ('Yqc-ZjHdmk-CCJC-05','尺寸精度检测','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'40',NULL,NULL,NULL,NULL,'T',NULL,'{Yqc-ZjHdmk-RobotXH-CC-02}','{Yqc-ZjHdmk-RobotQH-CC-02}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','0','0',NULL,NULL,'ZjHdmk'), ('Yqc-ZjHdmk-RobotQH-CC-02','机器人尺寸检测设备取货','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10',NULL,NULL,NULL,NULL,'T',NULL,'{Yqc-ZjHdmk-CCJC-05}','{Yqc-ZjHdmk-RobotXH-TKD-02}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','0','1',NULL,NULL,'ZjHdmk'), ('Yqc-ZjHdmk-RobotQH-PT-01','机器人智能装配平台取货[ZjHdmk齐套1]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10',NULL,NULL,NULL,NULL,'T',NULL,'{Yqc-ZjHdmk-ZP02-02}','{Yqc-ZjHdmk-RobotXH-TKD-01,Yqc-ZjHdmk-RobotXH-XBC-01-TKD}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','0','1',NULL,NULL,'ZjHdmk'), ('Yqc-ZjHdmk-RobotQH-PT-02','机器人智能装配平台取货[ZjHdmk齐套2]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10',NULL,NULL,NULL,NULL,'T',NULL,'{Yqc-ZjHdmk-ZP03-03}','{Yqc-ZjHdmk-RobotXH-ZHDXN-02}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','0','1',NULL,NULL,'ZjHdmk'), ('Yqc-ZjHdmk-RobotQH-TKD-01','机器人停靠点1取货[ZjHdmk齐套1]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Yqc-ZjHdmk-AGVXH-TKD-01}','{Yqc-ZjHdmk-RobotXH-PT-01,Yqc-ZjHdmk-RobotXH-XBC-01-PT,Yqc-ZjHdmk-RobotQH-TKD-02}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'ZjHdmk'), ('Yqc-ZjHdmk-RobotQH-TKD-02','机器人停靠点1取货[ZjHdmk齐套2]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Yqc-ZjHdmk-AGVXH-TKD-02,Yqc-ZjHdmk-RobotQH-TKD-01}','{Yqc-ZjHdmk-RobotXH-PT-02,Yqc-ZjHdmk-RobotXH-XBC-02-PT}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'ZjHdmk'), ('Yqc-ZjHdmk-RobotQH-XBC-01-PT','机器人线边仓取货[ZjHdmk齐套1]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Yqc-ZjHdmk-RobotXH-XBC-01-PT}','{Yqc-ZjHdmk-RobotXH-PT-01-XBC,Yqc-ZjHdmk-RobotQH-XBC-02-PT}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-ZjHdmk-RobotXH-XBC-01-PT}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'ZjHdmk'), ('Yqc-ZjHdmk-RobotQH-XBC-01-TKD','机器人线边仓取货[ZjHdmk齐套1回]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Yqc-ZjHdmk-RobotXH-XBC-01-TKD}','{Yqc-ZjHdmk-RobotXH-TKD-01-XBC}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-ZjHdmk-RobotXH-XBC-01-TKD}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'ZjHdmk'), ('Yqc-ZjHdmk-RobotQH-XBC-02-PT','机器人线边仓取货[ZjHdmk齐套2]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Yqc-ZjHdmk-RobotXH-XBC-02-PT,Yqc-ZjHdmk-RobotQH-XBC-01-PT}','{Yqc-ZjHdmk-RobotXH-PT-02-XBC}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-ZjHdmk-RobotXH-XBC-02-PT}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'ZjHdmk'), ('Yqc-ZjHdmk-RobotQH-ZHDXN-02','机器人综合电性能检测设备取货','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10',NULL,NULL,NULL,NULL,'T',NULL,'{Yqc-ZjHdmk-ZHDXNJC-04}','{Yqc-ZjHdmk-RobotXH-CC-02}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','0','1',NULL,NULL,'ZjHdmk'), ('Yqc-ZjHdmk-RobotXH-CC-02','机器人尺寸检测设备卸货','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10',NULL,NULL,NULL,NULL,'T',NULL,'{Yqc-ZjHdmk-RobotQH-ZHDXN-11}','{Yqc-ZjHdmk-CCJC-05}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','0','1',NULL,NULL,'ZjHdmk'), ('Yqc-ZjHdmk-RobotXH-PT-01','机器人智能装配平台卸货[ZjHdmk齐套1]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10','0',NULL,'0',NULL,'T',NULL,'{Yqc-ZjHdmk-RobotQH-TKD-01}','{Yqc-ZjHdmk-ZP01-01,Yqc-ZjHdmk-RobotXH-PT-02}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-ZjHdmk-RobotQH-PT-01}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'ZjHdmk'), ('Yqc-ZjHdmk-RobotXH-PT-01-XBC','机器人线边仓至智能装配平台卸货[ZjHdmk齐套1]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Yqc-ZjHdmk-RobotQH-XBC-01-PT}','{Yqc-ZjHdmk-ZP01-01,Yqc-ZjHdmk-RobotXH-PT-02-XBC}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-ZjHdmk-RobotQH-XBC-01-PT}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'ZjHdmk'), ('Yqc-ZjHdmk-RobotXH-PT-02','机器人智能装配平台卸货[ZjHdmk齐套2]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10','0',NULL,'0',NULL,'T',NULL,'{Yqc-ZjHdmk-AGVXH-TKD-02,Yqc-ZjHdmk-RobotXH-PT-01}','{Yqc-ZjHdmk-ZP01-01}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-ZjHdmk-RobotQH-PT-02}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'ZjHdmk'), ('Yqc-ZjHdmk-RobotXH-PT-02-XBC','机器人线边仓至智能装配平台卸货[ZjHdmk齐套2]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Yqc-ZjHdmk-RobotQH-XBC-02-PT,Yqc-ZjHdmk-RobotXH-PT-01-XBC}','{Yqc-ZjHdmk-ZP01-01}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-ZjHdmk-RobotQH-XBC-02-PT}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'ZjHdmk'), ('Yqc-ZjHdmk-RobotXH-TKD-01','机器人停靠点2卸货[ZjHdmk齐套1]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10',NULL,NULL,NULL,NULL,'T',NULL,'{Yqc-ZjHdmk-RobotQH-PT-01}','{Yqc-ZjHdmk-AGVQH-TKD-01}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-ZjHdmk-RobotQH-PT-01}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','0','1',NULL,NULL,'ZjHdmk'), ('Yqc-ZjHdmk-RobotXH-TKD-01-XBC','机器人线边仓至停靠点2卸货[ZjHdmk齐套1回]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Yqc-ZjHdmk-RobotQH-XBC-01-TKD}','{Yqc-ZjHdmk-AGVQH-TKD-01}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-ZjHdmk-RobotQH-XBC-01-TKD}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'ZjHdmk'), ('Yqc-ZjHdmk-RobotXH-TKD-02','机器人停靠点2卸货[ZjHdmk齐套2]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10',NULL,NULL,NULL,NULL,'T',NULL,'{Yqc-ZjHdmk-RobotQH-CC-02}','{Yqc-ZjHdmk-AGVQH-TKD-02}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-ZjHdmk-RobotQH-PT-02}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','0','1',NULL,NULL,'ZjHdmk'), ('Yqc-ZjHdmk-RobotXH-XBC-01-PT','机器人线边仓卸货[ZjHdmk齐套1]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Yqc-ZjHdmk-RobotQH-TKD-01}','{Yqc-ZjHdmk-RobotQH-XBC-01-PT,Yqc-ZjHdmk-RobotXH-XBC-02-PT}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-ZjHdmk-RobotQH-TKD-01}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'ZjHdmk'), ('Yqc-ZjHdmk-RobotXH-XBC-01-TKD','机器人线边仓卸货[ZjHdmk齐套1回]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Yqc-ZjHdmk-RobotQH-PT-01}','{Yqc-ZjHdmk-RobotQH-XBC-01-TKD}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-ZjHdmk-RobotQH-PT-01}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'ZjHdmk'), ('Yqc-ZjHdmk-RobotXH-XBC-02-PT','机器人线边仓卸货[ZjHdmk齐套2]','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}','0','10','0','0','0','0','T',NULL,'{Yqc-ZjHdmk-RobotQH-TKD-02,Yqc-ZjHdmk-RobotXH-XBC-01-PT}','{Yqc-ZjHdmk-RobotQH-XBC-02-PT}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-ZjHdmk-RobotQH-TKD-02}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','1',NULL,NULL,'ZjHdmk'), ('Yqc-ZjHdmk-RobotXH-ZHDXN-02','机器人综合电性能检测设备卸货','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'10',NULL,NULL,NULL,NULL,'T',NULL,'{Yqc-ZjHdmk-RobotQH-PT-02}','{Yqc-ZjHdmk-ZHDXNJC-04}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','0','1',NULL,NULL,'ZjHdmk'), ('Yqc-ZjHdmk-ZHDXNJC-04','综合电性能检测','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'40',NULL,NULL,NULL,NULL,'T',NULL,'{Yqc-ZjHdmk-RobotXH-ZHDXN-02}','{Yqc-ZjHdmk-RobotQH-ZHDXN-02}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','0','0',NULL,NULL,'ZjHdmk'), ('Yqc-ZjHdmk-ZP01-01','组件与后端模块装配1','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{}','{}',NULL,'500','0',NULL,'0',NULL,'T',NULL,'{Yqc-ZjHdmk-RobotXH-PT-01,Yqc-ZjHdmk-RobotXH-PT-01-XBC,Yqc-ZjHdmk-RobotXH-PT-02,Yqc-ZjHdmk-RobotXH-PT-02-XBC}','{Yqc-ZjHdmk-RobotQH-PT-01,Yqc-ZjHdmk-RobotQH-PT-02}',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,'{Yqc-ZjHdmk-RobotXH-PT-01,Yqc-ZjHdmk-RobotXH-PT-01-XBC,Yqc-ZjHdmk-RobotXH-PT-02,Yqc-ZjHdmk-RobotXH-PT-02-XBC}','1',NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','0','0',NULL,NULL,'ZjHdmk'), ('ZjHdmk','组件与后端模块装配','Yqc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'T',NULL,'{KjtToGyc}',NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','0','0',NULL,'ZjHdmk','Yqc');
INSERT INTO `rg_processassisant` VALUES ('1','Kqd-Kqd-AGVQH-CK-01',NULL,'AGV_R_GetRaw','KQD_TJ_01','AGV_L、AGV_R',NULL,'Y','AGV_R_MoveIn','120',NULL,'2',NULL,'Y','25','AGV_R_MoveOut','25','120',NULL,'2',NULL,NULL), ('2','Kqd-Kqd-AGVQH-CK-02',NULL,'AGV_R_GetRaw','KQD_TJ_02','AGV_L、AGV_R',NULL,'Y','AGV_R_MoveIn','120',NULL,'2',NULL,'Y','25','AGV_R_MoveOut','25','120',NULL,'2',NULL,NULL), ('3','Kqd-Kqd-AGVQH-CK-03',NULL,'AGV_R_GetRaw','KQD_TJ_03','AGV_L、AGV_R',NULL,'Y','AGV_R_MoveIn','120',NULL,'2',NULL,'Y','25','AGV_R_MoveOut','25','120',NULL,'2',NULL,NULL), ('14','Kqd-Kqd-MTJC-06',NULL,'OnlineTest_Make','KQD',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('15','Kqd-Kqd-RobotQH-MT-07','OnlineTest','KR16_MG_GetRaw','KQD_TJ_03','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('16','Kqd-Kqd-RobotQH-PT-01','ZNZPPT_01','KR16_MG_GetRaw','KQD_TJ_01','KR16_MG','ZNZPPT_01、ZNZPPT_02、RJXZPT_01、RJXZPT_02',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('17','Kqd-Kqd-RobotQH-PT-02','ZNZPPT_01','KR16_MG_GetRaw','KQD_TJ_02','KR16_MG','ZNZPPT_01、ZNZPPT_02、RJXZPT_01、RJXZPT_02',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('19','Kqd-Kqd-RobotQH-TKD-01','AGV_R','KR16_MG_GetRaw','KQD_TJ_01','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('20','Kqd-Kqd-RobotQH-TKD-02','AGV_R','KR16_MG_GetRaw','KQD_TJ_02','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('21','Kqd-Kqd-RobotQH-TKD-03','AGV_R','KR16_MG_GetRaw','KQD_TJ_03','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('22','Kqd-Kqd-RobotQH-XBC-02-PT','XBC','KR16_MG_GetRaw','KQD_TJ_02','KR16_MG',NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('23','Kqd-Kqd-RobotQH-XBC-03-PT','XBC','KR16_MG_GetRaw','KQD_TJ_03','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('26','Kqd-Kqd-RobotXH-MT-05','OnlineTest','KR16_MG_PutRaw','KQD_TJ_03','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('27','Kqd-Kqd-RobotXH-PT-01-XBC','ZNZPPT_01','KR16_MG_PutRaw','KQD_TJ_01','KR16_MG','ZNZPPT_01、ZNZPPT_02、RJXZPT_01、RJXZPT_02',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('28','Kqd-Kqd-RobotXH-PT-02-XBC','ZNZPPT_01','KR16_MG_PutRaw','KQD_TJ_02','KR16_MG','ZNZPPT_01、ZNZPPT_02、RJXZPT_01、RJXZPT_02',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('29','Kqd-Kqd-RobotXH-PT-03-XBC','ZNZPPT_01','KR16_MG_PutRaw','KQD_TJ_03','KR16_MG','ZNZPPT_01、ZNZPPT_02、RJXZPT_01、RJXZPT_02',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('30','Kqd-Kqd-RobotXH-TKD-01','AGV_L','KR16_MG_PutRaw','KQD_TJ_01','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('31','Kqd-Kqd-RobotXH-TKD-02','AGV_L','KR16_MG_PutRaw','KQD_TJ_02','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('32','Kqd-Kqd-RobotXH-TKD-03','AGV_L','KR16_MG_PutRaw','KQD_TJ_03','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('33','Kqd-Kqd-RobotXH-XBC-01-PT','XBC','KR16_MG_PutRaw','KQD_TJ_01','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('34','Kqd-Kqd-RobotXH-XBC-02-PT','XBC','KR16_MG_PutRaw','KQD_TJ_02','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('35','Kqd-Kqd-RobotXH-XBC-03-PT','XBC','KR16_MG_PutRaw','KQD_TJ_03','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('36','Kqd-Kqd-ZP01-01',NULL,'ZNZPPT_01_Make','KQD_TJ_01',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('304','Kqd-Kqd-RobotQH-XBC-01-PT','XBC','KR16_MG_GetRaw','KQD_TJ_01','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('305','Kqd-Kqd-RobotXH-PT-01','ZNZPPT_01','KR16_MG_PutRaw','KQD_TJ_01','KR16_MG','ZNZPPT_01、ZNZPPT_02、RJXZPT_01、RJXZPT_02',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('306','Kqd-Kqd-RobotXH-PT-02','ZNZPPT_01','KR16_MG_PutRaw','KQD_TJ_02','KR16_MG','ZNZPPT_01、ZNZPPT_02、RJXZPT_01、RJXZPT_02',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('307','Kqd-Kqd-RobotXH-PT-03','ZNZPPT_01','KR16_MG_PutRaw','KQD_TJ_03','KR16_MG','ZNZPPT_01、ZNZPPT_02、RJXZPT_01、RJXZPT_02',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('337','Yqc-Gyc-AGVQH-CK-01',NULL,'AGV_R_GetRaw','YQC','AGV_L、AGV_R',NULL,'Y','AGV_R_MoveIn','120',NULL,'2',NULL,'Y','25','AGV_R_MoveOut','25','120',NULL,'2',NULL,NULL), ('338','Yqc-Gyc-AGVQH-CK-02',NULL,'AGV_R_GetRaw','YQC','AGV_L、AGV_R',NULL,'Y','AGV_R_MoveIn','120',NULL,'2',NULL,'Y','25','AGV_R_MoveOut','25','120',NULL,'2',NULL,NULL), ('345','Yqc-Gyc-RobotQH-PT-01','ZNZPPT_01','KR16_MG_GetRaw','YQC','KR16_MG','ZNZPPT_01、ZNZPPT_02、RJXZPT_01、RJXZPT_02',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('346','Yqc-Gyc-RobotQH-PT-02','ZNZPPT_01','KR16_MG_GetRaw','YQC','KR16_MG','ZNZPPT_01、ZNZPPT_02、RJXZPT_01、RJXZPT_02',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('347','Yqc-Gyc-RobotQH-TKD-01','AGV_R','KR16_MG_GetRaw','YQC','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('348','Yqc-Gyc-RobotQH-TKD-02','AGV_R','KR16_MG_GetRaw','YQC','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('349','Yqc-Gyc-RobotQH-XBC-01-PT','XBC','KR16_MG_GetRaw','YQC','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('350','Yqc-Gyc-RobotQH-XBC-01-TKD','XBC','KR16_MG_GetRaw','YQC','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('351','Yqc-Gyc-RobotQH-XBC-02-PT','XBC','KR16_MG_GetRaw','YQC','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('352','Yqc-Gyc-RobotQH-XBC-02-TKD','XBC','KR16_MG_GetRaw','YQC','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('353','Yqc-Gyc-RobotXH-PT-01','ZNZPPT_01','KR16_MG_PutRaw','YQC','KR16_MG','ZNZPPT_01、ZNZPPT_02、RJXZPT_01、RJXZPT_02',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('354','Yqc-Gyc-RobotXH-PT-01-XBC','ZNZPPT_01','KR16_MG_PutRaw','YQC','KR16_MG','ZNZPPT_01、ZNZPPT_02、RJXZPT_01、RJXZPT_02',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('355','Yqc-Gyc-RobotXH-PT-02','ZNZPPT_01','KR16_MG_PutRaw','YQC','KR16_MG','ZNZPPT_01、ZNZPPT_02、RJXZPT_01、RJXZPT_02',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('356','Yqc-Gyc-RobotXH-PT-02-XBC','ZNZPPT_01','KR16_MG_PutRaw','YQC','KR16_MG','ZNZPPT_01、ZNZPPT_02、RJXZPT_01、RJXZPT_02',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('357','Yqc-Gyc-RobotXH-TKD-01','AGV_L','KR16_MG_PutRaw','YQC','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('358','Yqc-Gyc-RobotXH-TKD-01-XBC','AGV_L','KR16_MG_PutRaw','YQC','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('359','Yqc-Gyc-RobotXH-TKD-02','AGV_L','KR16_MG_PutRaw','YQC','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('360','Yqc-Gyc-RobotXH-TKD-02-XBC','AGV_L','KR16_MG_PutRaw','YQC','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('361','Yqc-Gyc-RobotXH-XBC-01-PT','XBC','KR16_MG_PutRaw','YQC','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('362','Yqc-Gyc-RobotXH-XBC-01-TKD','XBC','KR16_MG_PutRaw','YQC','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('363','Yqc-Gyc-RobotXH-XBC-02-PT','XBC','KR16_MG_PutRaw','YQC','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('364','Yqc-Gyc-RobotXH-XBC-02-TKD','XBC','KR16_MG_PutRaw','YQC','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('365','Yqc-Gyc-ZP01-01',NULL,'ZNZPPT_01_Make','YQC',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('366','Yqc-Kjt-AGVQH-CK-01',NULL,'AGV_R_GetRaw','YQC','AGV_L、AGV_R',NULL,'Y','AGV_R_MoveIn','120',NULL,'2',NULL,'Y','25','AGV_R_MoveOut','25','120',NULL,'2',NULL,NULL), ('367','Yqc-Kjt-AGVQH-CK-02',NULL,'AGV_R_GetRaw','YQC','AGV_L、AGV_R',NULL,'Y','AGV_R_MoveIn','120',NULL,'2',NULL,'Y','25','AGV_R_MoveOut','25','120',NULL,'2',NULL,NULL), ('368','Yqc-Kjt-AGVQH-CK-03',NULL,'AGV_R_GetRaw','YQC','AGV_L、AGV_R',NULL,'Y','AGV_R_MoveIn','120',NULL,'2',NULL,'Y','25','AGV_R_MoveOut','25','120',NULL,'2',NULL,NULL), ('378','Yqc-Kjt-RobotQH-PT-01','ZNZPPT_01','KR16_MG_GetRaw','YQC','KR16_MG','ZNZPPT_01、ZNZPPT_02、RJXZPT_01、RJXZPT_02',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('379','Yqc-Kjt-RobotQH-PT-02','ZNZPPT_01','KR16_MG_GetRaw','YQC','KR16_MG','ZNZPPT_01、ZNZPPT_02、RJXZPT_01、RJXZPT_02',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('380','Yqc-Kjt-RobotQH-PT-03','ZNZPPT_01','KR16_MG_GetRaw','YQC','KR16_MG','ZNZPPT_01、ZNZPPT_02、RJXZPT_01、RJXZPT_02',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('381','Yqc-Kjt-RobotQH-TKD-01','AGV_R','KR16_MG_GetRaw','YQC','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('382','Yqc-Kjt-RobotQH-TKD-02','AGV_R','KR16_MG_GetRaw','YQC','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('383','Yqc-Kjt-RobotQH-TKD-03','AGV_R','KR16_MG_GetRaw','YQC','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('384','Yqc-Kjt-RobotQH-XBC-01-PT','XBC','KR16_MG_GetRaw','YQC','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('385','Yqc-Kjt-RobotQH-XBC-01-TKD','XBC','KR16_MG_GetRaw','YQC','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('386','Yqc-Kjt-RobotQH-XBC-02-PT','XBC','KR16_MG_GetRaw','YQC','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('387','Yqc-Kjt-RobotQH-XBC-02-TKD','XBC','KR16_MG_GetRaw','YQC','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('388','Yqc-Kjt-RobotQH-XBC-03-PT','XBC','KR16_MG_GetRaw','YQC','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('389','Yqc-Kjt-RobotQH-XBC-03-TKD','XBC','KR16_MG_GetRaw','YQC','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('390','Yqc-Kjt-RobotXH-PT-01','ZNZPPT_01','KR16_MG_PutRaw','YQC','KR16_MG','ZNZPPT_01、ZNZPPT_02、RJXZPT_01、RJXZPT_02',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('391','Yqc-Kjt-RobotXH-PT-01-XBC','ZNZPPT_01','KR16_MG_PutRaw','YQC','KR16_MG','ZNZPPT_01、ZNZPPT_02、RJXZPT_01、RJXZPT_02',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('392','Yqc-Kjt-RobotXH-PT-02','ZNZPPT_01','KR16_MG_PutRaw','YQC','KR16_MG','ZNZPPT_01、ZNZPPT_02、RJXZPT_01、RJXZPT_02',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('393','Yqc-Kjt-RobotXH-PT-02-XBC','ZNZPPT_01','KR16_MG_PutRaw','YQC','KR16_MG','ZNZPPT_01、ZNZPPT_02、RJXZPT_01、RJXZPT_02',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('394','Yqc-Kjt-RobotXH-PT-03','ZNZPPT_01','KR16_MG_PutRaw','YQC','KR16_MG','ZNZPPT_01、ZNZPPT_02、RJXZPT_01、RJXZPT_02',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('395','Yqc-Kjt-RobotXH-PT-03-XBC','ZNZPPT_01','KR16_MG_PutRaw','YQC','KR16_MG','ZNZPPT_01、ZNZPPT_02、RJXZPT_01、RJXZPT_02',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('396','Yqc-Kjt-RobotXH-TKD-01','AGV_L','KR16_MG_PutRaw','YQC','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('397','Yqc-Kjt-RobotXH-TKD-01-XBC','AGV_L','KR16_MG_PutRaw','YQC','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('398','Yqc-Kjt-RobotXH-TKD-02','AGV_L','KR16_MG_PutRaw','YQC','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('399','Yqc-Kjt-RobotXH-TKD-02-XBC','AGV_L','KR16_MG_PutRaw','YQC','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('400','Yqc-Kjt-RobotXH-TKD-03','AGV_L','KR16_MG_PutRaw','YQC','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('401','Yqc-Kjt-RobotXH-TKD-03-XBC','AGV_L','KR16_MG_PutRaw','YQC','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('402','Yqc-Kjt-RobotXH-XBC-01-PT','XBC','KR16_MG_PutRaw','YQC','KR16_MG',NULL,NULL,'','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('403','Yqc-Kjt-RobotXH-XBC-01-TKD','XBC','KR16_MG_PutRaw','YQC','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('404','Yqc-Kjt-RobotXH-XBC-02-PT','XBC','KR16_MG_PutRaw','YQC','KR16_MG',NULL,NULL,'','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('405','Yqc-Kjt-RobotXH-XBC-02-TKD','XBC','KR16_MG_PutRaw','YQC','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('406','Yqc-Kjt-RobotXH-XBC-03-PT','XBC','KR16_MG_PutRaw','YQC','KR16_MG',NULL,NULL,'','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('407','Yqc-Kjt-RobotXH-XBC-03-TKD','XBC','KR16_MG_PutRaw','YQC','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('408','Yqc-Kjt-ZP01-01',NULL,'ZNZPPT_01_Make','YQC',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('409','Yqc-KjtToGyc-AGVQH-CK-01',NULL,'AGV_R_GetRaw','YQC','AGV_L、AGV_R',NULL,'Y','AGV_R_MoveIn','120',NULL,'2',NULL,'Y','25','AGV_R_MoveOut','25','120',NULL,'2',NULL,NULL), ('410','Yqc-KjtToGyc-AGVQH-CK-02',NULL,'AGV_R_GetRaw','YQC','AGV_L、AGV_R',NULL,'Y','AGV_R_MoveIn','120',NULL,'2',NULL,'Y','25','AGV_R_MoveOut','25','120',NULL,'2',NULL,NULL), ('417','Yqc-KjtToGyc-RobotQH-PT-01','RJXZPT_01','KR16_MG_GetRaw','YQC','KR16_MG','RJXZPT_01、RJXZPT_02',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('418','Yqc-KjtToGyc-RobotQH-PT-02','RJXZPT_01','KR16_MG_GetRaw','YQC','KR16_MG','RJXZPT_01、RJXZPT_02',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('419','Yqc-KjtToGyc-RobotQH-TKD-01','AGV_R','KR16_MG_GetRaw','YQC','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('420','Yqc-KjtToGyc-RobotQH-TKD-02','AGV_R','KR16_MG_GetRaw','YQC','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('421','Yqc-KjtToGyc-RobotQH-XBC-01-PT','XBC','KR16_MG_GetRaw','YQC','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('422','Yqc-KjtToGyc-RobotQH-XBC-01-TKD','XBC','KR16_MG_GetRaw','YQC','KR16_MG',NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('423','Yqc-KjtToGyc-RobotQH-XBC-02-PT','XBC','KR16_MG_GetRaw','YQC','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('424','Yqc-KjtToGyc-RobotQH-XBC-02-TKD','XBC','KR16_MG_GetRaw','YQC','KR16_MG',NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('425','Yqc-KjtToGyc-RobotXH-PT-01','RJXZPT_01','KR16_MG_PutRaw','YQC','KR16_MG','RJXZPT_01、RJXZPT_02',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('426','Yqc-KjtToGyc-RobotXH-PT-01-XBC','RJXZPT_01','KR16_MG_PutRaw','YQC','KR16_MG','RJXZPT_01、RJXZPT_02',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('427','Yqc-KjtToGyc-RobotXH-PT-02','RJXZPT_01','KR16_MG_PutRaw','YQC','KR16_MG','RJXZPT_01、RJXZPT_02','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('428','Yqc-KjtToGyc-RobotXH-PT-02-XBC','RJXZPT_01','KR16_MG_PutRaw','YQC','KR16_MG','RJXZPT_01、RJXZPT_02',NULL,'','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('429','Yqc-KjtToGyc-RobotXH-TKD-01','AGV_L','KR16_MG_PutRaw','YQC','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('430','Yqc-KjtToGyc-RobotXH-TKD-01-XBC','AGV_L','KR16_MG_PutRaw','YQC','KR16_MG',NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `rg_processassisant` VALUES ('431','Yqc-KjtToGyc-RobotXH-TKD-02','AGV_L','KR16_MG_PutRaw','YQC','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('432','Yqc-KjtToGyc-RobotXH-TKD-02-XBC','AGV_L','KR16_MG_PutRaw','YQC','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('433','Yqc-KjtToGyc-RobotXH-XBC-01-PT','XBC','KR16_MG_PutRaw','YQC','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('434','Yqc-KjtToGyc-RobotXH-XBC-01-TKD','XBC','KR16_MG_PutRaw','YQC','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('435','Yqc-KjtToGyc-RobotXH-XBC-02-PT','XBC','KR16_MG_PutRaw','YQC','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('436','Yqc-KjtToGyc-RobotXH-XBC-02-TKD','XBC','KR16_MG_PutRaw','YQC','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('437','Yqc-KjtToGyc-ZP01-01',NULL,'RJXZPT_01_Make','YQC',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('438','Yqc-ZjHdmk-AGVQH-CK-01',NULL,'AGV_R_GetRaw','YQC','AGV_L、AGV_R',NULL,'Y','AGV_R_MoveIn','120',NULL,'2',NULL,'Y','25','AGV_R_MoveOut','25','120',NULL,'2',NULL,NULL), ('439','Yqc-ZjHdmk-AGVQH-CK-02','','AGV_R_GetRaw','YQC','AGV_L、AGV_R',NULL,'Y','AGV_R_MoveIn','120',NULL,'2',NULL,'Y','25','AGV_R_MoveOut','25','120',NULL,'2',NULL,NULL), ('448','Yqc-ZjHdmk-RobotQH-PT-01','RJXZPT_01','KR16_MG_GetRaw','YQC','KR16_MG','RJXZPT_01、RJXZPT_02',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('449','Yqc-ZjHdmk-RobotQH-PT-02','ZNZPPT_01','KR16_MG_GetRaw','YQC','KR16_MG','ZNZPPT_01、ZNZPPT_02、RJXZPT_01、RJXZPT_02',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('450','Yqc-ZjHdmk-RobotQH-TKD-01','AGV_R','KR16_MG_GetRaw','YQC','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('451','Yqc-ZjHdmk-RobotQH-TKD-02','AGV_R','KR16_MG_GetRaw','YQC','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('452','Yqc-ZjHdmk-RobotQH-XBC-01-PT','XBC','KR16_MG_GetRaw','YQC','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('453','Yqc-ZjHdmk-RobotQH-XBC-01-TKD','XBC','KR16_MG_GetRaw','YQC','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('454','Yqc-ZjHdmk-RobotQH-XBC-02-PT','XBC','KR16_MG_GetRaw','YQC','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('455','Yqc-ZjHdmk-RobotQH-ZHDXN-02','AssembleAccuracyTest','KR16_MG_GetRaw','YQC','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('457','Yqc-ZjHdmk-RobotXH-PT-01','RJXZPT_01','KR16_MG_PutRaw','YQC','KR16_MG','RJXZPT_01、RJXZPT_02',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('458','Yqc-ZjHdmk-RobotXH-PT-01-XBC','RJXZPT_01','KR16_MG_PutRaw','YQC','KR16_MG','RJXZPT_01、RJXZPT_02',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('459','Yqc-ZjHdmk-RobotXH-PT-02','RJXZPT_01','KR16_MG_PutRaw','YQC','KR16_MG','RJXZPT_01、RJXZPT_02',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('460','Yqc-ZjHdmk-RobotXH-PT-02-XBC','RJXZPT_01','KR16_MG_PutRaw','YQC','KR16_MG','RJXZPT_01、RJXZPT_02',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('461','Yqc-ZjHdmk-RobotXH-TKD-01','AGV_L','KR16_MG_PutRaw','YQC','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('462','Yqc-ZjHdmk-RobotXH-TKD-01-XBC','AGV_L','KR16_MG_PutRaw','YQC','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('463','Yqc-ZjHdmk-RobotXH-TKD-02','AGV_L','KR16_MG_PutRaw','YQC','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('464','Yqc-ZjHdmk-RobotXH-XBC-01-PT','XBC','KR16_MG_PutRaw','YQC','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('465','Yqc-ZjHdmk-RobotXH-XBC-01-TKD','XBC','KR16_MG_PutRaw','YQC','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('466','Yqc-ZjHdmk-RobotXH-XBC-02-PT','XBC','KR16_MG_PutRaw','YQC','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('467','Yqc-ZjHdmk-RobotXH-ZHDXN-02','AssembleAccuracyTest','KR16_MG_PutRaw','YQC','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('468','Yqc-ZjHdmk-ZHDXNJC-04',NULL,'AssembleAccuracyTest_Make','YQC',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('469','Yqc-ZjHdmk-ZP01-01','RJXZPT_01','RJXZPT_01_Make','YQC',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('470','ZjHdmk','RJXZPT_01','RJXZPT_01_Make','YQC',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('471','Kqd-Kqd-AGVXH-CK-01','AGV_L','AGV_L_PutProduct','KQD','AGV_L、AGV_R',NULL,'Y','AGV_L_MoveIn','120','AGV_L','2',NULL,'Y','25','AGV_L_MoveOut','25','120','AGV_L','2',NULL,NULL), ('472','Kqd-Kqd-AGVXH-CK-02','AGV_L','AGV_L_PutProduct','KQD','AGV_L、AGV_R',NULL,'Y','AGV_L_MoveIn','120','AGV_L','2',NULL,'Y','25','AGV_L_MoveOut','25','120','AGV_L','2',NULL,NULL), ('473','Kqd-Kqd-AGVXH-CK-03','AGV_L','AGV_L_PutProduct','KQD','AGV_L、AGV_R',NULL,'Y','AGV_L_MoveIn','120','AGV_L','2',NULL,'Y','25','AGV_L_MoveOut','25','120','AGV_L','2',NULL,NULL), ('475','Yqc-Kjt-AGVXH-CK-01','AGV_L','AGV_L_PutProduct','YQC','AGV_L、AGV_R',NULL,'Y','AGV_L_MoveIn','120','AGV_L','2',NULL,'Y','25','AGV_L_MoveOut','25','120','AGV_L','2',NULL,NULL), ('476','Yqc-Kjt-AGVXH-CK-02','AGV_L','AGV_L_PutProduct','YQC','AGV_L、AGV_R',NULL,'Y','AGV_L_MoveIn','120','AGV_L','2',NULL,'Y','25','AGV_L_MoveOut','25','120','AGV_L','2',NULL,NULL), ('477','Yqc-Kjt-AGVXH-CK-03','AGV_L','AGV_L_PutProduct','YQC','AGV_L、AGV_R',NULL,'Y','AGV_L_MoveIn','120','AGV_L','2',NULL,'Y','25','AGV_L_MoveOut','25','120','AGV_L','2',NULL,NULL), ('478','Yqc-Gyc-AGVXH-CK-01','AGV_L','AGV_L_PutProduct','YQC','AGV_L、AGV_R',NULL,'Y','AGV_L_MoveIn','120','AGV_L','2',NULL,'Y','25','AGV_L_MoveOut','25','120','AGV_L','2',NULL,NULL), ('479','Yqc-Gyc-AGVXH-CK-02','AGV_L','AGV_L_PutProduct','YQC','AGV_L、AGV_R',NULL,'Y','AGV_L_MoveIn','120','AGV_L','2',NULL,'Y','25','AGV_L_MoveOut','25','120','AGV_L','2',NULL,NULL), ('480','Yqc-KjtToGyc-AGVXH-CK-01','AGV_L','AGV_L_PutProduct','YQC','AGV_L、AGV_R',NULL,'Y','AGV_L_MoveIn','120','AGV_L','2',NULL,'Y','25','AGV_L_MoveOut','25','120','AGV_L','2',NULL,NULL), ('481','Yqc-KjtToGyc-AGVXH-CK-02','AGV_L','AGV_L_PutProduct','YQC','AGV_L、AGV_R',NULL,'Y','AGV_L_MoveIn','120','AGV_L','2',NULL,'Y','25','AGV_L_MoveOut','25','120','AGV_L','2',NULL,NULL), ('482','Yqc-ZjHdmk-AGVXH-CK-01','AGV_L','AGV_L_PutProduct','YQC','AGV_L、AGV_R',NULL,'Y','AGV_L_MoveIn','120','AGV_L','2',NULL,'Y','25','AGV_L_MoveOut','25','120','AGV_L','2',NULL,NULL), ('483','Yqc-ZjHdmk-AGVXH-CK-02','AGV_L','AGV_L_PutProduct','YQC','AGV_L、AGV_R',NULL,'Y','AGV_L_MoveIn','120','AGV_L','2',NULL,'Y','25','AGV_L_MoveOut','25','120','AGV_L','2',NULL,NULL), ('484','Kqd-Kqd-RobotXH-XBC-01-TKD','XBC','KR16_MG_PutRaw','KQD','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('485','Kqd-Kqd-RobotQH-XBC-01-TKD','XBC','KR16_MG_GetRaw','KQD','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('486','Kqd-Kqd-RobotXH-TKD-01-XBC','AGV_L','KR16_MG_PutRaw','KQD','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('487','Kqd-Kqd-RobotQH-PT-03','ZNZPPT_01','KR16_MG_GetRaw','YQC','KR16_MG','ZNZPPT_01、ZNZPPT_02、RJXZPT_01、RJXZPT_02',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('488','Kqd-Kqd-RobotXH-CC-05','UR5','KR16_MG_PutRaw','YQC','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('489','Kqd-Kqd-CCJC-06','UR5','UR5_Make','YQC',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('490','Kqd-Kqd-RobotQH-CC-07','UR5','KR16_MG_GetRaw','KQD','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('491','Yqc-ZjHdmk-CCJC-05','UR5','UR5_Make','YQC',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('492','Yqc-ZjHdmk-RobotQH-CC-02','UR5','KR16_MG_GetRaw','YQC','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('493','Kqd-Kqd-RobotQH-XBC-02-TKD','XBC','KR16_MG_GetRaw','KQD','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('494','Kqd-Kqd-RobotXH-TKD-02-XBC','AGV_L','KR16_MG_PutRaw','KQD','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('495','Kqd-Kqd-RobotXH-XBC-02-TKD','XBC','KR16_MG_PutRaw','KQD','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), ('496','Yqc-ZjHdmk-RobotXH-CC-02','UR5','KR16_MG_PutRaw','YQC','KR16_MG',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `rg_product` VALUES ('Gyc','Craft Semi-product','0','Air Semi-product',NULL,'0',NULL,NULL,NULL,NULL,'8000X0121'), ('Kjt','Frame Semi-product','0','Frame Semi-product',NULL,'0',NULL,NULL,NULL,NULL,'8000X0120'), ('KjtToGyc','Frame To Craft Assembly 1b',NULL,'Module Combination',NULL,'0',NULL,NULL,NULL,NULL,'8000X0122'), ('Kqd','Air Product','0','Air Product',NULL,'0',NULL,NULL,NULL,NULL,'9000X9000'), ('Yqc','Instrument Product','0','Instrument Product',NULL,'0',NULL,NULL,NULL,NULL,'8000X8000'), ('ZjHdmk','Module Assembly',NULL,'Instrument Product',NULL,'0',NULL,NULL,NULL,NULL,'8000X8000');
INSERT INTO `rg_resource` VALUES ('AGV_L','AGV 02',NULL,NULL,NULL,'2',NULL,NULL,'0','T','08:30:00to22:59:59','{2017-07-20}','[08:30:00,22:59:00]',NULL,'周末不休','146 205 220','00:10:56','101','1','-32','AGV','TKD-L',NULL,NULL,'G01',NULL,'001'), ('AGV_R','AGV 01',NULL,NULL,NULL,'2',NULL,NULL,NULL,'T','08:30:00to22:59:59','{2017-07-20}','[08:30:00,22:59:00]',NULL,'周末不休','61 168 193','00:08:35','101','1','-32','AGV','CK',NULL,NULL,'G01',NULL,'001'), ('AssembleAccuracyTest','Electricity Checkout 01',NULL,NULL,NULL,NULL,NULL,NULL,'0','T','08:30:00to22:59:59','{2017-07-20}','[08:30:00,22:59:00]',NULL,'周末不休','252 213 180','00:00:40','0','1','-32','ZH','ZHDXNJCsb-01',NULL,'AssembleAccuracyTestZJ','G01',NULL,'001'), ('AssembleAccuracyTestZJ','Electricity Checkout Carrier 01',NULL,NULL,NULL,NULL,NULL,NULL,'0','F','08:30:00to22:59:59','{2017-07-20}','[08:30:00,22:59:00]',NULL,'周末不休','255 255 255','01:09:17','0','0','-32','ZH','ZHDXNJCsb-01',NULL,NULL,'G01',NULL,'001'), ('KR16_MG','Robot 01',NULL,NULL,NULL,'2',NULL,NULL,NULL,'T','08:30:00to22:59:59','{2017-07-20}','[08:30:00,22:59:00]',NULL,'周末不休','250 191 143','00:39:26','101','1','-32','Robot','TKD-R',NULL,NULL,'G01',NULL,'001'), ('OnlineTest','Modal Checkout 01',NULL,NULL,NULL,NULL,NULL,NULL,'0','T','08:30:00to22:59:59','{2017-07-20}','[08:30:00,22:59:00]',NULL,'周末不休','218 238 243','00:05:00','101','1','-32','JY','MTJDJCsb-01',NULL,'OnlineTestZJ','G01',NULL,'001'), ('OnlineTestZJ','Modal Checkout Carrier 01',NULL,NULL,NULL,NULL,NULL,NULL,'0','F','08:30:00to22:59:59','{2017-07-20}','[08:30:00,22:59:00]',NULL,'周末不休','255 255 255','00:51:55','0','0','-32','JY','MTJDJCsb-01',NULL,NULL,'G01',NULL,'001'), ('RJXZPTZJ_01','Man-Machine Platform Carrier 01',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'F','08:30:00to22:59:59','{2017-07-20}','[08:30:00,22:59:00]',NULL,'周末不休','255 255 255','01:05:21','0','0','-32','RJXZpt','RJXZpt-01',NULL,NULL,'G01',NULL,'001'), ('RJXZPTZJ_02','Man-Machine Platform Carrier 02',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'F','08:30:00to22:59:59','{2017-07-20}','[08:30:00,22:59:00]',NULL,'周末不休','255 255 255','01:05:21','0','0','-32','RJXZpt','RJXZpt-02',NULL,NULL,'G01',NULL,'001'), ('RJXZPT_01','Man-Machine Platform 01',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'T','08:30:00to22:59:59','{2017-07-20}','[08:30:00,22:59:00]',NULL,'周末不休','246 146 64','00:28:09','0','1','-32','RJXZpt','RJXZpt-01',NULL,'RJXZPTZJ_01','G01',NULL,'001'), ('RJXZPT_02','Man-Machine Platform 02',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'T','08:30:00to22:59:59','{2017-07-20}','[08:30:00,22:59:00]',NULL,'周末不休','246 146 64','00:28:09','0','0','-32','RJXZpt','RJXZpt-02',NULL,'RJXZPTZJ_02','G01',NULL,'001'), ('UR5','Size Checkout 01',NULL,NULL,NULL,NULL,NULL,NULL,'0','T','08:30:00to22:59:59','{2017-07-20}','[08:30:00,22:59:00]',NULL,'周末不休','183 222 232','00:03:20','101','1','-32','JY','CCJDJCsb-01',NULL,'UR5ZJ','G01',NULL,'001'), ('UR5ZJ','Size Checkout Carrier 01',NULL,NULL,NULL,NULL,NULL,NULL,'0','F','08:30:00to22:59:59','{2017-07-20}','[08:30:00,22:59:00]',NULL,'周末不休','255 255 255','01:31:50','0','0','-32','JY','CCJDJCsb-01',NULL,NULL,'G01',NULL,'001'), ('XBC','Depot 01',NULL,NULL,NULL,NULL,NULL,NULL,'0','F','08:30:00to22:59:59','{2017-07-20}','[08:30:00,22:59:00]',NULL,'周末不休','255 255 255','04:01:42','101','1',NULL,'XBC','XBC01',NULL,NULL,'G01',NULL,'001'), ('XZTP01_01','Carrier Desk 01',NULL,NULL,NULL,NULL,NULL,NULL,'0','F','08:30:00to22:59:59','{2017-07-20}','[08:30:00,22:59:00]',NULL,'周末不休','255 255 255','02:52:15','101','1','-32','XZTP','TKD-R',NULL,'','G01',NULL,'001'), ('XZTP02_02','Carrier Desk 02',NULL,NULL,NULL,NULL,NULL,NULL,'0','F','08:30:00to22:59:59','{2017-07-20}','[08:30:00,22:59:00]',NULL,'周末不休','255 255 255','04:03:48','101','1','-32','XZTP','TKD-L',NULL,NULL,'G01',NULL,'001'), ('ZNZPPTZJ_01','	Assembly Platform Carrier 01',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'F','08:30:00to22:59:59','{2017-07-20}','[08:30:00,22:59:00]',NULL,'周末不休','255 255 255','04:23:05','0','0','-32','ZNZPpt','ZNZPpt-01',NULL,NULL,'G01',NULL,'001'), ('ZNZPPTZJ_02','	Assembly Platform Carrier 02',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'F','08:30:00to22:59:59','{2017-07-20}','[08:30:00,22:59:00]',NULL,'周末不休','255 255 255','04:23:05','0','0','-32','ZNZPpt','ZNZPpt-02',NULL,NULL,'G01',NULL,'001'), ('ZNZPPT_01','	Assembly Platform 01',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'T','08:30:00to22:59:59','{2017-07-20}','[08:30:00,22:59:00]',NULL,'周末不休','253 233 217','00:10:00','101','1','-32','ZNZPpt','ZNZPpt-01',NULL,'ZNZPPTZJ_01','G01',NULL,'001'), ('ZNZPPT_02','	Assembly Platform 02',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'T','08:30:00to22:59:59','{2017-07-20}','[08:30:00,22:59:00]',NULL,'周末不休','253 233 217','00:08:20','0','0','-32','ZNZPpt','ZNZPpt-02',NULL,'ZNZPPTZJ_02','G01',NULL,'001');
INSERT INTO `rg_resourcestate` VALUES ('1','AGV_L','AGV 02','舜宇','SCJH0001','5','001','1','test','2017-07-22 17:10:45','2017-07-22 17:10:45','2017-08-02 16:58:10','2017-07-22 17:10:45','2017-07-22 17:10:45','1','0','0','0','AGV_L'), ('2','AGV_R','AGV 01','舜宇','SCJH0001','5','001','1','test','2017-07-22 17:10:45','2017-07-22 17:10:45','2017-08-02 16:59:36','2017-07-22 17:10:45','2017-07-22 17:10:45','1','0','0','0','AGV_R'), ('3','AssembleAccuracyTest','Electricity Checkout 01','舜宇','SCJH0002','6','001','1','kqd','2017-08-24 09:55:19','2017-08-24 09:55:22','2017-08-24 09:55:25','2017-08-24 09:55:28','2017-08-24 09:55:30','1','0','0','0','AssembleAccuracyTest'), ('4','UR5','Size Checkout 01','舜宇','SCJH0003','7','001','1','kqd','2017-08-24 09:56:33','2017-08-24 09:56:35','2017-08-24 09:56:38','2017-08-24 09:56:40','2017-08-24 09:56:42','1','0','0','0','UR5'), ('5','KR16_MG','Robot 01','舜宇','SCJH0004','8','001','1','kqd','2017-08-24 09:59:03','2017-08-24 09:59:19','2017-08-24 09:59:32','2017-08-24 09:59:49','2017-08-24 10:00:04','1','0','0','0','KR16_MG'), ('6','RJXZPT_01','Man-Machine Platform 01','舜宇','SCJH0005','9','001','1','kqd','2017-08-24 09:59:05','2017-08-24 09:59:21','2017-08-24 09:59:36','2017-08-24 09:59:52','2017-08-24 10:00:06','1','0','0','0','RJXZPT_01'), ('7','RJXZPT_02','Man-Machine Platform 02','舜宇','SCJH0006','11','001','1','kqd','2017-08-24 09:59:08','2017-08-24 09:59:23','2017-08-24 09:59:39','2017-08-24 09:59:55','2017-08-24 10:00:10','1','0','0','0','RJXZPT_02'), ('8','ZNZPPT_01','	Assembly Platform 01','舜宇','SCJH0007','12','001','1','kqd','2017-08-24 09:59:11','2017-08-24 09:59:26','2017-08-24 09:59:42','2017-08-24 09:59:57','2017-08-24 10:00:13','1','0','0','0','ZNZPPT_01'), ('9','ZNZPPT_02','	Assembly Platform 02','舜宇','SCJH0008','13','001','1','kqd','2017-08-24 09:59:14','2017-08-24 09:59:27','2017-08-24 09:59:44','2017-08-24 09:59:59','2017-08-24 10:00:15','1','0','0','0','ZNZPPT_02'), ('10','OnlineTest','Modal Checkout 01','舜宇','SCJH0009','14','001','1','kqd','2017-08-24 09:59:16','2017-08-24 09:59:30','2017-08-24 09:59:47','2017-08-24 10:00:01','2017-08-24 10:00:17','1','0','0','0','OnlineTest');
INSERT INTO `rg_shift` VALUES ('01','08:30:00to22:59:59','0','{08:30:00..22:59:00}','01',NULL);
INSERT INTO `rg_site` VALUES ('AssembleAccuracyTest','Electricity Checkout',NULL,'1000','240','79 129 189','ZH','-30',NULL,NULL,'G00000361'), ('CCJDJC','Size Checkout Stop',NULL,'600','300','79 129 189','TKD','-17',NULL,NULL,NULL), ('CK','Depot Stop',NULL,'1600','1200','79 129 189','TKD','-17','1',NULL,NULL), ('CK01','Depot',NULL,'1480','1200','79 129 189','CK','-90',NULL,NULL,NULL), ('MTJDJC','Modal Checkout Stop',NULL,'300','300','79 129 189','TKD','-17',NULL,NULL,NULL), ('OnlineTest','Modal Checkout',NULL,'300','240','79 129 189','JY','-30',NULL,NULL,'G00000359'), ('RJXZ','Man-Machine Platform Stop',NULL,'1500','300','79 129 189','TKD','-17',NULL,NULL,NULL), ('RJXZPT_01','Man-Machine Platform',NULL,'1500','240','79 129 189','RJXZpt','-30',NULL,NULL,'G00000362'), ('RJXZPT_02','Man-Machine Platform',NULL,'1500','360','79 129 189','RJXZpt','-30',NULL,NULL,NULL), ('TKD-L','AGV Left',NULL,'100','300','79 129 189','TKD','-17',NULL,NULL,NULL), ('TKD-R','AGV Right',NULL,'2200','300','79 129 189','TKD','-17',NULL,NULL,NULL), ('UR5','Size Checkout',NULL,'600','240','79 129 189','JY','-30',NULL,NULL,'G00000360'), ('XBC','Depot Stop',NULL,'1800','300','79 129 189','TKD','-17',NULL,NULL,NULL), ('XBC01','Depot',NULL,'1800','400','79 129 189','XBC','-40',NULL,NULL,NULL), ('XZTP-L','Carrier Desk Left',NULL,'50','300','79 129 189','XZTP','-17',NULL,NULL,NULL), ('XZTP-R','Carrier Desk Right',NULL,'2250','300','79 129 189','XZTP','-17',NULL,NULL,NULL), ('ZHDXNJC','Electricity Checkout Stop',NULL,'1000','300','79 129 189','TKD','-17',NULL,NULL,NULL), ('ZNZP','Assembly Platform Stop',NULL,'2000','300','79 129 189','TKD','-17',NULL,NULL,NULL), ('ZNZPPT_01','Assembly Platform',NULL,'2000','240','79 129 189','ZNZPpt','-30',NULL,NULL,'G00000363'), ('ZNZPPT_02','Assembly Platform',NULL,'2000','360','79 129 189','ZNZPpt','-30',NULL,NULL,NULL);
INSERT INTO `rg_sitetype` VALUES ('1','AssembleAccuracyTest','Electricity Checkout','','700','240','79 129 189','ZH','-30','0','1'), ('2','CCJDJC','Size Checkout Stop','','500','300','79 129 189','TKD','-17','0','1'), ('3','CK','Depot Stop','','1600','1200','79 129 189','TKD','-17','1','1'), ('4','CK01','Depot','','1480','1200','79 129 189','CK','-90','0','1'), ('5','MTJDJC','Modal Checkout Stop','','300','300','79 129 189','TKD','-17','0','1'), ('6','OnlineTest','Modal Checkout','','300','240','79 129 189','JY','-30','0','1'), ('7','RJXZ','Man-Machine Platform Stop','','900','300','79 129 189','TKD','-17','0','1'), ('8','RJXZPT_01','Man-Machine Platform','','900','240','79 129 189','RJXZpt','-30','0','1'), ('9','RJXZPT_02','Man-Machine Platform','','900','360','79 129 189','RJXZpt','-30','0','1'), ('10','TKD-L','AGV Left Stop','','100','300','79 129 189','TKD','-17','0','1'), ('11','TKD-R','AGV Right Stop','','1300','300','79 129 189','TKD','-17','0','1'), ('12','UR5','Size Checkout','','500','240','79 129 189','JY','-30','0','1'), ('13','XBC','Depot Stop','','1100','300','79 129 189','TKD','-17','0','1'), ('14','XBC01','Depot','','1100','400','79 129 189','XBC','-40','0','1'), ('15','XZTP-L','Carrier Desk Left','','100','300','79 129 189','XZTP','-17','0','1'), ('16','XZTP-R','Carrier Desk Right','','1300','300','79 129 189','XZTP','-17','0','1'), ('17','ZHDXNJC','Electricity Checkout Stop','','700','300','79 129 189','TKD','-17','0','1'), ('18','ZNZP','Assembly Platform Stop','','1100','300','79 129 189','TKD','-17','0','1'), ('19','ZNZPPT_01','Assembly Platform','','1100','240','79 129 189','ZNZPpt','-30','0','1'), ('20','ZNZPPT_02','Assembly Platform','','1100','360','79 129 189','ZNZPpt','-30','0','1'), ('21','AssembleAccuracyTest','Electricity Checkout','','700','240','79 129 189','ZH','-30','0','2'), ('22','CCJDJC','Size Checkout Stop','','500','300','79 129 189','TKD','-17','0','2'), ('23','CK','Depot Stop','','1600','1200','79 129 189','TKD','-17','1','2'), ('24','CK01','Depot','','1480','1200','79 129 189','CK','-90','0','2'), ('25','MTJDJC','Modal Checkout Stop','','300','300','79 129 189','TKD','-17','0','2'), ('26','OnlineTest','Modal Checkout','','300','240','79 129 189','JY','-30','0','2'), ('27','RJXZ','Man-Machine Platform Stop','','900','300','79 129 189','TKD','-17','0','2'), ('28','RJXZPT_01','Man-Machine Platform','','900','240','79 129 189','RJXZpt','-30','0','2'), ('29','RJXZPT_02','Man-Machine Platform','','900','360','79 129 189','RJXZpt','-30','0','2'), ('30','TKD-L','AGV Left Stop','','100','300','79 129 189','TKD','-17','0','2'), ('31','TKD-R','AGV Right Stop','','1300','300','79 129 189','TKD','-17','0','2'), ('32','UR5','Size Checkout','','500','240','79 129 189','JY','-30','0','2'), ('33','XBC','Depot Stop','','900','300','79 129 189','TKD','-17','0','2'), ('34','XBC01','Depot','','900','400','79 129 189','XBC','-40','0','2'), ('35','XZTP-L','Carrier Desk Left','','100','300','79 129 189','XZTP','-17','0','2'), ('36','XZTP-R','Carrier Desk Right','','1300','300','79 129 189','XZTP','-17','0','2'), ('37','ZHDXNJC','Electricity Checkout Stop','','700','300','79 129 189','TKD','-17','0','2'), ('38','ZNZP','Assembly Platform Stop','','1100','300','79 129 189','TKD','-17','0','2'), ('39','ZNZPPT_01','Assembly Platform','','1100','240','79 129 189','ZNZPpt','-30','0','2'), ('40','ZNZPPT_02','Assembly Platform','','1100','360','79 129 189','ZNZPpt','-30','0','2'), ('41','AssembleAccuracyTest','Electricity Checkout','','700','240','79 129 189','ZH','-30','0','3'), ('42','CCJDJC','Size Checkout Stop','','500','300','79 129 189','TKD','-17','0','3'), ('43','CK','Depot Stop','','1600','1200','79 129 189','TKD','-17','1','3'), ('44','CK01','Depot','','1480','1200','79 129 189','CK','-90','0','3'), ('45','MTJDJC','Modal Checkout Stop','','300','300','79 129 189','TKD','-17','0','3'), ('46','OnlineTest','Modal Checkout','','300','240','79 129 189','JY','-30','0','3'), ('47','RJXZ','Man-Machine Platform Stop','','900','300','79 129 189','TKD','-17','0','3'), ('48','RJXZPT_01','Man-Machine Platform','','900','240','79 129 189','RJXZpt','-30','0','3'), ('49','RJXZPT_02','Man-Machine Platform','','900','360','79 129 189','RJXZpt','-30','0','3'), ('50','TKD-L','AGV Left Stop','','100','300','79 129 189','TKD','-17','0','3'), ('51','TKD-R','AGV Right Stop','','1300','300','79 129 189','TKD','-17','0','3'), ('52','UR5','Size Checkout','','500','240','79 129 189','JY','-30','0','3'), ('53','XBC','Depot Stop','','700','300','79 129 189','TKD','-17','0','3'), ('54','XBC01','Depot','','700','400','79 129 189','XBC','-40','0','3'), ('55','XZTP-L','Carrier Desk Left','','100','300','79 129 189','XZTP','-17','0','3'), ('56','XZTP-R','Carrier Desk Right','','1300','300','79 129 189','XZTP','-17','0','3'), ('57','ZHDXNJC','Electricity Checkout Stop','','700','300','79 129 189','TKD','-17','0','3'), ('58','ZNZP','Assembly Platform Stop','','1100','300','79 129 189','TKD','-17','0','3'), ('59','ZNZPPT_01','Assembly Platform','','1100','240','79 129 189','ZNZPpt','-30','0','3'), ('60','ZNZPPT_02','Assembly Platform','','1100','360','79 129 189','ZNZPpt','-30','0','3');
INSERT INTO `rg_state3d` VALUES ('1','1','Layout1','1','90e300ee-9e19-47ff-98f4-ba19e0e751fe');
INSERT INTO `rg_typerescource` VALUES ('AGV01','AGV',NULL,NULL), ('AGV02','AGV',NULL,NULL), ('CCJDJCsb','Size Checkout',NULL,NULL), ('CCJDJCsbZJ','Size Checkout Carrier',NULL,NULL), ('MTJDJCsb','Modal Checkout',NULL,NULL), ('MTJDJCsbZJ','Modal Checkout Carrier',NULL,NULL), ('RJXZpt','Man-Machine Platform',NULL,NULL), ('RJXZptZJ','Man-Machine Platform Carrier',NULL,NULL), ('Robot','Robot',NULL,NULL), ('XBC','Depot',NULL,NULL), ('XZTP01','Carrier Desk 01',NULL,NULL), ('XZTP02','Carrier Desk 02',NULL,NULL), ('ZHDXNJCsb','Electricity Checkout',NULL,NULL), ('ZHDXNJCsbZJ','Electricity Checkout Carrier',NULL,NULL), ('ZNZPpt','	Assembly Platform',NULL,NULL), ('ZNZPptZJ','	Assembly Platform Carrier',NULL,NULL);
INSERT INTO `rg_user` VALUES ('001','SIWI                                                                                                ',NULL,NULL,'1','toto','001'), ('1','Root',NULL,NULL,NULL,NULL,'001');
INSERT INTO `rg_userconfig` VALUES ('1','97feb698-d4a2-40c2-a82a-3faadba120f1',' ','18ce6b65-5035-46b7-b6e0-bd1fc2d63a50','317b1c4a-7742-4281-b496-d2c3019abffe','90e300ee-9e19-47ff-98f4-ba19e0e751fe','0','1','0','rg_adjustorder','67cf4fe4-9c8d-4a96-a5c9-203238cef5e4','1','0f8a0154-f30e-4a5c-9a13-e3334396107d',' ','90e300ee-9e19-47ff-98f4-ba19e0e751fe');
INSERT INTO `shift_resource` VALUES ('01','AGV_L'), ('01','AGV_R'), ('01','AssembleAccuracyTest'), ('01','AssembleAccuracyTestZJ'), ('01','KR16_MG'), ('01','OnlineTest'), ('01','OnlineTestZJ'), ('01','RJXZPTZJ_01'), ('01','RJXZPTZJ_02'), ('01','RJXZPT_01'), ('01','RJXZPT_02'), ('01','UR5'), ('01','UR5ZJ'), ('01','XBC'), ('01','XZTP01_01'), ('01','XZTP02_02'), ('01','ZNZPPTZJ_01'), ('01','ZNZPPTZJ_02'), ('01','ZNZPPT_01'), ('01','ZNZPPT_02');
INSERT INTO `typeresource_resource` VALUES ('AGV_R','AGV01'), ('AGV_L','AGV02'), ('UR5','CCJDJCsb'), ('UR5ZJ','CCJDJCsbZJ'), ('OnlineTest','MTJDJCsb'), ('OnlineTestZJ','MTJDJCsbZJ'), ('RJXZPT_01','RJXZpt'), ('RJXZPT_02','RJXZpt'), ('RJXZPTZJ_01','RJXZptZJ'), ('RJXZPTZJ_02','RJXZptZJ'), ('KR16_MG','Robot'), ('XBC','XBC'), ('XZTP01_01','XZTP01'), ('XZTP02_02','XZTP02'), ('AssembleAccuracyTest','ZHDXNJCsb'), ('AssembleAccuracyTestZJ','ZHDXNJCsbZJ'), ('ZNZPPT_01','ZNZPpt'), ('ZNZPPT_02','ZNZPpt'), ('ZNZPPTZJ_01','ZNZPptZJ'), ('ZNZPPTZJ_02','ZNZPptZJ');
