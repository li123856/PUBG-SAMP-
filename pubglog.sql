/*
Navicat MySQL Data Transfer

Source Server         : local
Source Server Version : 50520
Source Host           : localhost:3306
Source Database       : pubglog

Target Server Type    : MYSQL
Target Server Version : 50520
File Encoding         : 65001

Date: 2018-02-05 20:48:27
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `反作弊日志`
-- ----------------------------
DROP TABLE IF EXISTS `反作弊日志`;
CREATE TABLE `反作弊日志` (
  `归属` int(11) NOT NULL,
  `用户名` varchar(32) NOT NULL,
  `内容` varchar(256) NOT NULL,
  `时间` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of 反作弊日志
-- ----------------------------
