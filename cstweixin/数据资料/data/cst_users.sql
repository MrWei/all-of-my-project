/*
Navicat MySQL Data Transfer

Source Server         : server
Source Server Version : 50524
Source Host           : localhost:3306
Source Database       : cst_db

Target Server Type    : MYSQL
Target Server Version : 50524
File Encoding         : 65001

Date: 2014-11-21 14:16:41
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `cst_users`
-- ----------------------------
DROP TABLE IF EXISTS `cst_users`;
CREATE TABLE `cst_users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `realname` varchar(30) NOT NULL COMMENT '真实姓名',
  `email` char(32) NOT NULL COMMENT '用户邮箱',
  `mobile` char(15) NOT NULL COMMENT '用户手机',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '用户状态',
  `companyid` smallint(6) NOT NULL COMMENT '公司id',
  `departmentid` smallint(6) NOT NULL COMMENT '部门id',
  `openid` varchar(20) NOT NULL COMMENT '微信openid',
  `reg_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `last_login_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `gid` tinyint(4) NOT NULL DEFAULT '1' COMMENT '用户分组',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of cst_users
-- ----------------------------
INSERT INTO `cst_users` VALUES ('1', '魏永1', 'weiyong.me@qq.com', '', '1', '1', '1', '', '1415864130', '1415864130', '1416451032', '1');
