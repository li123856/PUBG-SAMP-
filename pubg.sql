/*
Navicat MySQL Data Transfer

Source Server         : local
Source Server Version : 50520
Source Host           : localhost:3306
Source Database       : pubg

Target Server Type    : MYSQL
Target Server Version : 50520
File Encoding         : 65001

Date: 2018-02-05 20:48:21
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `玩家好友`
-- ----------------------------
DROP TABLE IF EXISTS `玩家好友`;
CREATE TABLE `玩家好友` (
  `编号` int(11) NOT NULL AUTO_INCREMENT,
  `玩家归属` int(11) NOT NULL DEFAULT '-1',
  `好友归属` int(11) NOT NULL DEFAULT '-1',
  PRIMARY KEY (`编号`)
) ENGINE=MyISAM AUTO_INCREMENT=149 DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of 玩家好友
-- ----------------------------

-- ----------------------------
-- Table structure for `玩家数据`
-- ----------------------------
DROP TABLE IF EXISTS `玩家数据`;
CREATE TABLE `玩家数据` (
  `编号` int(11) NOT NULL AUTO_INCREMENT,
  `名字` varchar(64) NOT NULL,
  `密码` varchar(128) NOT NULL,
  `语言` int(11) NOT NULL DEFAULT '0',
  `皮肤` int(11) NOT NULL,
  `金币` int(11) NOT NULL DEFAULT '0',
  `主界面场景` int(11) NOT NULL,
  `主界面旋转` int(11) NOT NULL DEFAULT '1',
  `名字颜色` int(11) NOT NULL DEFAULT '0',
  `测试码` int(11) NOT NULL DEFAULT '0',
  `禁言期限` int(11) NOT NULL DEFAULT '0',
  `等级` int(11) NOT NULL DEFAULT '0',
  `经验` int(11) NOT NULL DEFAULT '0',
  `表情` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`编号`)
) ENGINE=MyISAM AUTO_INCREMENT=432 DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of 玩家数据
-- ----------------------------

-- ----------------------------
-- Table structure for `玩家背包`
-- ----------------------------
DROP TABLE IF EXISTS `玩家背包`;
CREATE TABLE `玩家背包` (
  `编号` int(11) NOT NULL AUTO_INCREMENT,
  `归属` int(11) NOT NULL DEFAULT '-1',
  `道具ID` int(11) NOT NULL DEFAULT '-1',
  `数量` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`编号`)
) ENGINE=MyISAM AUTO_INCREMENT=116 DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of 玩家背包
-- ----------------------------

-- ----------------------------
-- Table structure for `玩家装饰`
-- ----------------------------
DROP TABLE IF EXISTS `玩家装饰`;
CREATE TABLE `玩家装饰` (
  `编号` int(11) NOT NULL AUTO_INCREMENT,
  `归属` int(11) NOT NULL DEFAULT '-1',
  `道具ID` int(11) NOT NULL DEFAULT '-1',
  PRIMARY KEY (`编号`)
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of 玩家装饰
-- ----------------------------

-- ----------------------------
-- Table structure for `玩家邮箱`
-- ----------------------------
DROP TABLE IF EXISTS `玩家邮箱`;
CREATE TABLE `玩家邮箱` (
  `编号` int(11) NOT NULL AUTO_INCREMENT,
  `类型` int(11) NOT NULL DEFAULT '0',
  `玩家归属` int(11) NOT NULL DEFAULT '-1',
  `发送者归属` int(11) NOT NULL DEFAULT '-1',
  `标题` varchar(64) NOT NULL,
  `内容` varchar(256) NOT NULL,
  `金币` int(11) NOT NULL DEFAULT '0',
  `道具ID` int(11) NOT NULL DEFAULT '-1',
  `道具数量` int(11) NOT NULL DEFAULT '0',
  `其他` int(11) NOT NULL DEFAULT '-1',
  `已读` int(11) NOT NULL DEFAULT '0',
  `发送时间` varchar(32) NOT NULL,
  PRIMARY KEY (`编号`)
) ENGINE=MyISAM AUTO_INCREMENT=194 DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of 玩家邮箱
-- ----------------------------
