/*
Navicat MySQL Data Transfer

Source Server         : local
Source Server Version : 50520
Source Host           : localhost:3306
Source Database       : pubgset

Target Server Type    : MYSQL
Target Server Version : 50520
File Encoding         : 65001

Date: 2018-02-05 20:48:31
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `配置`
-- ----------------------------
DROP TABLE IF EXISTS `配置`;
CREATE TABLE `配置` (
  `运行时间` int(11) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of 配置
-- ----------------------------
INSERT INTO `配置` VALUES ('0');

-- ----------------------------
-- Table structure for `音乐`
-- ----------------------------
DROP TABLE IF EXISTS `音乐`;
CREATE TABLE `音乐` (
  `编号` int(11) NOT NULL AUTO_INCREMENT,
  `歌曲时间` int(11) NOT NULL,
  `演唱者` varchar(32) NOT NULL,
  `歌曲名` varchar(32) NOT NULL,
  `歌曲链接` varchar(128) NOT NULL,
  PRIMARY KEY (`编号`)
) ENGINE=MyISAM AUTO_INCREMENT=28 DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of 音乐
-- ----------------------------
