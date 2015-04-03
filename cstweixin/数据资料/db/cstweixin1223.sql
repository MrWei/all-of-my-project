/*
Navicat MySQL Data Transfer

Source Server         : server
Source Server Version : 50524
Source Host           : localhost:3306
Source Database       : cstweixin

Target Server Type    : MYSQL
Target Server Version : 50524
File Encoding         : 65001

Date: 2014-12-23 15:06:04
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `cst_action`
-- ----------------------------
DROP TABLE IF EXISTS `cst_action`;
CREATE TABLE `cst_action` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` char(30) NOT NULL DEFAULT '' COMMENT '行为唯一标识',
  `title` char(80) NOT NULL DEFAULT '' COMMENT '行为说明',
  `remark` char(140) NOT NULL DEFAULT '' COMMENT '行为描述',
  `rule` text NOT NULL COMMENT '行为规则',
  `log` text NOT NULL COMMENT '日志规则',
  `type` tinyint(2) unsigned NOT NULL DEFAULT '1' COMMENT '类型',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '状态',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='系统行为表';

-- ----------------------------
-- Records of cst_action
-- ----------------------------
INSERT INTO `cst_action` VALUES ('1', 'user_login', '用户登录', '积分+10，每天一次', 'table:member|field:score|condition:uid={$self} AND status>-1|rule:score+10|cycle:24|max:1;', '[user|get_nickname]在[time|time_format]登录了后台', '1', '1', '1387181220');
INSERT INTO `cst_action` VALUES ('2', 'add_article', '发布文章', '积分+5，每天上限5次', 'table:member|field:score|condition:uid={$self}|rule:score+5|cycle:24|max:5', '', '2', '0', '1380173180');
INSERT INTO `cst_action` VALUES ('3', 'review', '评论', '评论积分+1，无限制', 'table:member|field:score|condition:uid={$self}|rule:score+1', '', '2', '1', '1383285646');
INSERT INTO `cst_action` VALUES ('4', 'add_document', '发表文档', '积分+10，每天上限5次', 'table:member|field:score|condition:uid={$self}|rule:score+10|cycle:24|max:5', '[user|get_nickname]在[time|time_format]发表了一篇文章。\r\n表[model]，记录编号[record]。', '2', '0', '1386139726');
INSERT INTO `cst_action` VALUES ('5', 'add_document_topic', '发表讨论', '积分+5，每天上限10次', 'table:member|field:score|condition:uid={$self}|rule:score+5|cycle:24|max:10', '', '2', '0', '1383285551');
INSERT INTO `cst_action` VALUES ('6', 'update_config', '更新配置', '新增或修改或删除配置', '', '', '1', '1', '1383294988');
INSERT INTO `cst_action` VALUES ('7', 'update_model', '更新模型', '新增或修改模型', '', '', '1', '1', '1383295057');
INSERT INTO `cst_action` VALUES ('8', 'update_attribute', '更新属性', '新增或更新或删除属性', '', '', '1', '1', '1383295963');
INSERT INTO `cst_action` VALUES ('9', 'update_channel', '更新导航', '新增或修改或删除导航', '', '', '1', '1', '1383296301');
INSERT INTO `cst_action` VALUES ('10', 'update_menu', '更新菜单', '新增或修改或删除菜单', '', '', '1', '1', '1383296392');
INSERT INTO `cst_action` VALUES ('11', 'update_category', '更新分类', '新增或修改或删除分类', '', '', '1', '1', '1383296765');

-- ----------------------------
-- Table structure for `cst_action_log`
-- ----------------------------
DROP TABLE IF EXISTS `cst_action_log`;
CREATE TABLE `cst_action_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `action_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '行为id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '执行用户id',
  `action_ip` bigint(20) NOT NULL COMMENT '执行行为者ip',
  `model` varchar(50) NOT NULL DEFAULT '' COMMENT '触发行为的表',
  `record_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '触发行为的数据id',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '日志备注',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '状态',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '执行行为的时间',
  PRIMARY KEY (`id`),
  KEY `action_ip_ix` (`action_ip`),
  KEY `action_id_ix` (`action_id`),
  KEY `user_id_ix` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=310 DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='行为日志表';

-- ----------------------------
-- Records of cst_action_log
-- ----------------------------
INSERT INTO `cst_action_log` VALUES ('1', '1', '1', '2130706433', 'member', '1', 'admin在2014-11-26 09:22登录了后台', '1', '1416964972');
INSERT INTO `cst_action_log` VALUES ('2', '1', '1', '2130706433', 'member', '1', 'admin在2014-11-26 09:29登录了后台', '1', '1416965345');
INSERT INTO `cst_action_log` VALUES ('3', '1', '1', '2130706433', 'member', '1', 'admin在2014-11-26 09:35登录了后台', '1', '1416965757');
INSERT INTO `cst_action_log` VALUES ('4', '1', '1', '2130706433', 'member', '1', 'admin在2014-11-26 09:46登录了后台', '1', '1416966371');
INSERT INTO `cst_action_log` VALUES ('5', '1', '1', '2130706433', 'member', '1', 'admin在2014-11-26 09:47登录了后台', '1', '1416966431');
INSERT INTO `cst_action_log` VALUES ('6', '1', '1', '2130706433', 'member', '1', 'admin在2014-11-26 09:48登录了后台', '1', '1416966518');
INSERT INTO `cst_action_log` VALUES ('7', '1', '1', '2130706433', 'member', '1', 'admin在2014-11-26 17:15登录了后台', '1', '1416993352');
INSERT INTO `cst_action_log` VALUES ('8', '10', '1', '2130706433', 'Menu', '144', '操作url：/index.php?m=admin&c=menu&a=add', '1', '1416995434');
INSERT INTO `cst_action_log` VALUES ('9', '1', '1', '2130706433', 'member', '1', 'admin在2014-11-27 09:03登录了后台', '1', '1417050181');
INSERT INTO `cst_action_log` VALUES ('10', '10', '1', '2130706433', 'Menu', '141', '操作url：/index.php?m=admin&c=menu&a=edit', '1', '1417050661');
INSERT INTO `cst_action_log` VALUES ('11', '6', '1', '2130706433', 'config', '48', '操作url：/index.php?m=admin&c=config&a=edit', '1', '1417052548');
INSERT INTO `cst_action_log` VALUES ('12', '6', '1', '2130706433', 'config', '48', '操作url：/index.php?m=admin&c=config&a=edit', '1', '1417052708');
INSERT INTO `cst_action_log` VALUES ('13', '1', '1', '2130706433', 'member', '1', 'admin在2014-11-27 10:29登录了后台', '1', '1417055384');
INSERT INTO `cst_action_log` VALUES ('14', '6', '1', '2130706433', 'config', '48', '操作url：/index.php?m=admin&c=config&a=edit', '1', '1417056787');
INSERT INTO `cst_action_log` VALUES ('15', '10', '1', '2130706433', 'Menu', '139', '操作url：/index.php?m=admin&c=menu&a=edit', '1', '1417071722');
INSERT INTO `cst_action_log` VALUES ('16', '1', '1', '2130706433', 'member', '1', 'admin在2014-11-28 14:04登录了后台', '1', '1417154675');
INSERT INTO `cst_action_log` VALUES ('17', '1', '1', '2130706433', 'member', '1', 'admin在2014-11-28 19:11登录了后台', '1', '1417173068');
INSERT INTO `cst_action_log` VALUES ('18', '1', '1', '2130706433', 'member', '1', 'admin在2014-12-01 09:10登录了后台', '1', '1417396228');
INSERT INTO `cst_action_log` VALUES ('19', '1', '1', '2130706433', 'member', '1', 'admin在2014-12-01 09:23登录了后台', '1', '1417396993');
INSERT INTO `cst_action_log` VALUES ('20', '1', '1', '2130706433', 'member', '1', 'admin在2014-12-01 15:50登录了后台', '1', '1417420248');
INSERT INTO `cst_action_log` VALUES ('21', '1', '1', '2130706433', 'member', '1', 'admin在2014-12-01 15:51登录了后台', '1', '1417420281');
INSERT INTO `cst_action_log` VALUES ('22', '1', '1', '2130706433', 'member', '1', 'admin在2014-12-02 09:14登录了后台', '1', '1417482880');
INSERT INTO `cst_action_log` VALUES ('23', '7', '1', '2130706433', 'model', '4', '操作url：/index.php?m=Admin&c=Model&a=update', '1', '1417491637');
INSERT INTO `cst_action_log` VALUES ('24', '8', '1', '2130706433', 'attribute', '33', '操作url：/index.php?m=Admin&c=Attribute&a=update', '1', '1417491701');
INSERT INTO `cst_action_log` VALUES ('25', '7', '1', '2130706433', 'model', '4', '操作url：/index.php?m=Admin&c=Model&a=update', '1', '1417491730');
INSERT INTO `cst_action_log` VALUES ('26', '7', '1', '2130706433', 'model', '4', '操作url：/index.php?m=Admin&c=Model&a=update', '1', '1417491744');
INSERT INTO `cst_action_log` VALUES ('27', '8', '1', '2130706433', 'attribute', '34', '操作url：/index.php?m=Admin&c=Attribute&a=update', '1', '1417491799');
INSERT INTO `cst_action_log` VALUES ('28', '8', '1', '2130706433', 'attribute', '35', '操作url：/index.php?m=Admin&c=Attribute&a=update', '1', '1417491868');
INSERT INTO `cst_action_log` VALUES ('29', '8', '1', '2130706433', 'attribute', '35', '操作url：/index.php?m=Admin&c=Attribute&a=update', '1', '1417491888');
INSERT INTO `cst_action_log` VALUES ('30', '7', '1', '2130706433', 'model', '4', '操作url：/index.php?m=Admin&c=Model&a=update', '1', '1417491966');
INSERT INTO `cst_action_log` VALUES ('31', '8', '1', '2130706433', 'attribute', '36', '操作url：/index.php?m=Admin&c=Attribute&a=update', '1', '1417492121');
INSERT INTO `cst_action_log` VALUES ('32', '8', '1', '2130706433', 'attribute', '37', '操作url：/index.php?m=Admin&c=Attribute&a=update', '1', '1417492180');
INSERT INTO `cst_action_log` VALUES ('33', '8', '1', '2130706433', 'attribute', '38', '操作url：/index.php?m=Admin&c=Attribute&a=update', '1', '1417492239');
INSERT INTO `cst_action_log` VALUES ('34', '7', '1', '2130706433', 'model', '4', '操作url：/index.php?m=Admin&c=Model&a=update', '1', '1417492385');
INSERT INTO `cst_action_log` VALUES ('35', '11', '1', '2130706433', 'category', '1', '操作url：/index.php?m=Admin&c=Category&a=edit', '1', '1417492424');
INSERT INTO `cst_action_log` VALUES ('36', '7', '1', '2130706433', 'model', '4', '操作url：/index.php?m=Admin&c=Model&a=update', '1', '1417492574');
INSERT INTO `cst_action_log` VALUES ('37', '10', '1', '2130706433', 'Menu', '2', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1417500402');
INSERT INTO `cst_action_log` VALUES ('38', '1', '1', '2130706433', 'member', '1', 'admin在2014-12-03 14:38登录了后台', '1', '1417588722');
INSERT INTO `cst_action_log` VALUES ('39', '1', '1', '2130706433', 'member', '1', 'admin在2014-12-03 15:51登录了后台', '1', '1417593070');
INSERT INTO `cst_action_log` VALUES ('40', '11', '1', '2130706433', 'category', '4', '操作url：/index.php?m=Admin&c=Category&a=add', '1', '1417593355');
INSERT INTO `cst_action_log` VALUES ('41', '7', '1', '2130706433', 'model', '2', '操作url：/index.php?m=Admin&c=Model&a=update', '1', '1417593468');
INSERT INTO `cst_action_log` VALUES ('42', '7', '1', '2130706433', 'model', '2', '操作url：/index.php?m=Admin&c=Model&a=update', '1', '1417593539');
INSERT INTO `cst_action_log` VALUES ('43', '11', '1', '2130706433', 'category', '2', '操作url：/index.php?m=Admin&c=Category&a=edit', '1', '1417594171');
INSERT INTO `cst_action_log` VALUES ('44', '11', '1', '2130706433', 'category', '3', '操作url：/index.php?m=Admin&c=Category&a=edit', '1', '1417594195');
INSERT INTO `cst_action_log` VALUES ('45', '11', '1', '2130706433', 'category', '4', '操作url：/index.php?m=Admin&c=Category&a=edit', '1', '1417594457');
INSERT INTO `cst_action_log` VALUES ('46', '11', '1', '2130706433', 'category', '3', '操作url：/index.php?m=Admin&c=Category&a=edit', '1', '1417594465');
INSERT INTO `cst_action_log` VALUES ('47', '11', '1', '2130706433', 'category', '2', '操作url：/index.php?m=Admin&c=Category&a=edit', '1', '1417594472');
INSERT INTO `cst_action_log` VALUES ('48', '11', '1', '2130706433', 'category', '1', '操作url：/index.php?m=Admin&c=Category&a=edit', '1', '1417594479');
INSERT INTO `cst_action_log` VALUES ('49', '11', '1', '2130706433', 'category', '1', '操作url：/index.php?m=Admin&c=Category&a=remove&id=1', '1', '1417605225');
INSERT INTO `cst_action_log` VALUES ('50', '7', '1', '2130706433', 'model', '5', '操作url：/index.php?m=Admin&c=Model&a=update', '1', '1417605279');
INSERT INTO `cst_action_log` VALUES ('51', '8', '1', '2130706433', 'attribute', '39', '操作url：/index.php?m=Admin&c=Attribute&a=update', '1', '1417605441');
INSERT INTO `cst_action_log` VALUES ('52', '7', '1', '2130706433', 'model', '5', '操作url：/index.php?m=Admin&c=Model&a=update', '1', '1417605472');
INSERT INTO `cst_action_log` VALUES ('53', '7', '1', '2130706433', 'model', '5', '操作url：/index.php?m=Admin&c=Model&a=update', '1', '1417605484');
INSERT INTO `cst_action_log` VALUES ('54', '1', '1', '2130706433', 'member', '1', 'admin在2014-12-04 09:22登录了后台', '1', '1417656166');
INSERT INTO `cst_action_log` VALUES ('55', '11', '1', '2130706433', 'category', '5', '操作url：/index.php?m=Admin&c=Category&a=add', '1', '1417656240');
INSERT INTO `cst_action_log` VALUES ('56', '7', '1', '2130706433', 'model', '5', '操作url：/index.php?m=Admin&c=Model&a=update', '1', '1417656342');
INSERT INTO `cst_action_log` VALUES ('57', '8', '1', '2130706433', 'attribute', '40', '操作url：/index.php?m=Admin&c=Attribute&a=update', '1', '1417656366');
INSERT INTO `cst_action_log` VALUES ('58', '8', '1', '2130706433', 'attribute', '41', '操作url：/index.php?m=Admin&c=Attribute&a=update', '1', '1417656380');
INSERT INTO `cst_action_log` VALUES ('59', '8', '1', '2130706433', 'attribute', '42', '操作url：/index.php?m=Admin&c=Attribute&a=update', '1', '1417656399');
INSERT INTO `cst_action_log` VALUES ('60', '7', '1', '2130706433', 'model', '5', '操作url：/index.php?m=Admin&c=Model&a=update', '1', '1417657791');
INSERT INTO `cst_action_log` VALUES ('61', '7', '1', '2130706433', 'model', '5', '操作url：/index.php?m=Admin&c=Model&a=update', '1', '1417657859');
INSERT INTO `cst_action_log` VALUES ('62', '11', '1', '2130706433', 'category', '3', '操作url：/index.php?m=Admin&c=Category&a=edit', '1', '1417664192');
INSERT INTO `cst_action_log` VALUES ('63', '11', '1', '2130706433', 'category', '3', '操作url：/index.php?m=Admin&c=Category&a=edit', '1', '1417670202');
INSERT INTO `cst_action_log` VALUES ('64', '1', '1', '2130706433', 'member', '1', 'admin在2014-12-04 13:24登录了后台', '1', '1417670695');
INSERT INTO `cst_action_log` VALUES ('65', '11', '1', '2130706433', 'category', '6', '操作url：/index.php?m=Admin&c=Category&a=add', '1', '1417670766');
INSERT INTO `cst_action_log` VALUES ('66', '11', '1', '2130706433', 'category', '6', '操作url：/index.php?m=Admin&c=Category&a=edit', '1', '1417670805');
INSERT INTO `cst_action_log` VALUES ('67', '11', '1', '2130706433', 'category', '7', '操作url：/index.php?m=Admin&c=Category&a=add', '1', '1417670821');
INSERT INTO `cst_action_log` VALUES ('68', '11', '1', '2130706433', 'category', '8', '操作url：/index.php?m=Admin&c=Category&a=add', '1', '1417670844');
INSERT INTO `cst_action_log` VALUES ('69', '8', '1', '2130706433', 'attribute', '43', '操作url：/index.php?m=Admin&c=Attribute&a=update', '1', '1417682385');
INSERT INTO `cst_action_log` VALUES ('70', '10', '1', '2130706433', 'Menu', '145', '操作url：/index.php?m=Admin&c=Menu&a=add', '1', '1417690270');
INSERT INTO `cst_action_log` VALUES ('71', '10', '1', '2130706433', 'Menu', '145', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1417690292');
INSERT INTO `cst_action_log` VALUES ('72', '1', '1', '2130706433', 'member', '1', 'admin在2014-12-08 19:06登录了后台', '1', '1418036767');
INSERT INTO `cst_action_log` VALUES ('73', '10', '1', '2130706433', 'Menu', '146', '操作url：/index.php?m=Admin&c=Menu&a=add', '1', '1418036879');
INSERT INTO `cst_action_log` VALUES ('74', '10', '1', '2130706433', 'Menu', '146', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1418036914');
INSERT INTO `cst_action_log` VALUES ('75', '10', '1', '2130706433', 'Menu', '146', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1418036966');
INSERT INTO `cst_action_log` VALUES ('76', '1', '1', '2130706433', 'member', '1', 'admin在2014-12-09 09:40登录了后台', '1', '1418089222');
INSERT INTO `cst_action_log` VALUES ('77', '6', '1', '2130706433', 'config', '51', '操作url：/index.php?m=Admin&c=Config&a=edit', '1', '1418089454');
INSERT INTO `cst_action_log` VALUES ('78', '1', '1', '2130706433', 'member', '1', 'admin在2014-12-09 15:13登录了后台', '1', '1418109219');
INSERT INTO `cst_action_log` VALUES ('79', '1', '1', '2130706433', 'member', '1', 'admin在2014-12-09 16:53登录了后台', '1', '1418115235');
INSERT INTO `cst_action_log` VALUES ('80', '6', '1', '2130706433', 'config', '52', '操作url：/index.php?m=Admin&c=Config&a=edit', '1', '1418115380');
INSERT INTO `cst_action_log` VALUES ('81', '1', '1', '2130706433', 'member', '1', 'admin在2014-12-09 18:31登录了后台', '1', '1418121073');
INSERT INTO `cst_action_log` VALUES ('82', '10', '1', '2130706433', 'Menu', '147', '操作url：/index.php?m=Admin&c=Menu&a=add', '1', '1418128999');
INSERT INTO `cst_action_log` VALUES ('83', '1', '1', '2130706433', 'member', '1', 'admin在2014-12-10 09:10登录了后台', '1', '1418173809');
INSERT INTO `cst_action_log` VALUES ('84', '6', '1', '2130706433', 'config', '53', '操作url：/index.php?m=Admin&c=Config&a=edit', '1', '1418180724');
INSERT INTO `cst_action_log` VALUES ('85', '6', '1', '2130706433', 'config', '53', '操作url：/index.php?m=Admin&c=Config&a=edit', '1', '1418180733');
INSERT INTO `cst_action_log` VALUES ('86', '1', '1', '2130706433', 'member', '1', 'admin在2014-12-10 14:33登录了后台', '1', '1418193238');
INSERT INTO `cst_action_log` VALUES ('87', '1', '1', '2130706433', 'member', '1', 'admin在2014-12-11 09:37登录了后台', '1', '1418261878');
INSERT INTO `cst_action_log` VALUES ('88', '10', '1', '2130706433', 'Menu', '148', '操作url：/index.php?m=Admin&c=Menu&a=add', '1', '1418261973');
INSERT INTO `cst_action_log` VALUES ('89', '10', '1', '2130706433', 'Menu', '149', '操作url：/index.php?m=Admin&c=Menu&a=add', '1', '1418262017');
INSERT INTO `cst_action_log` VALUES ('90', '10', '1', '2130706433', 'Menu', '150', '操作url：/index.php?m=Admin&c=Menu&a=add', '1', '1418262048');
INSERT INTO `cst_action_log` VALUES ('91', '10', '1', '2130706433', 'Menu', '150', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1418262075');
INSERT INTO `cst_action_log` VALUES ('92', '10', '1', '2130706433', 'Menu', '148', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1418262092');
INSERT INTO `cst_action_log` VALUES ('93', '10', '1', '2130706433', 'Menu', '151', '操作url：/index.php?m=Admin&c=Menu&a=add', '1', '1418267433');
INSERT INTO `cst_action_log` VALUES ('94', '1', '1', '2130706433', 'member', '1', 'admin在2014-12-11 11:53登录了后台', '1', '1418270011');
INSERT INTO `cst_action_log` VALUES ('95', '1', '1', '1898915655', 'member', '1', 'admin在2014-12-11 14:15登录了后台', '1', '1418278550');
INSERT INTO `cst_action_log` VALUES ('96', '1', '1', '1898915655', 'member', '1', 'admin在2014-12-11 14:47登录了后台', '1', '1418280438');
INSERT INTO `cst_action_log` VALUES ('97', '1', '1', '1898915655', 'member', '1', 'admin在2014-12-11 16:43登录了后台', '1', '1418287432');
INSERT INTO `cst_action_log` VALUES ('98', '1', '1', '2130706433', 'member', '1', 'admin在2014-12-12 09:48登录了后台', '1', '1418348888');
INSERT INTO `cst_action_log` VALUES ('99', '1', '1', '2130706433', 'member', '1', 'admin在2014-12-12 11:17登录了后台', '1', '1418354241');
INSERT INTO `cst_action_log` VALUES ('100', '10', '1', '2130706433', 'Menu', '152', '操作url：/index.php?m=Admin&c=Menu&a=add', '1', '1418356239');
INSERT INTO `cst_action_log` VALUES ('101', '1', '1', '2130706433', 'member', '1', 'admin在2014-12-12 14:19登录了后台', '1', '1418365196');
INSERT INTO `cst_action_log` VALUES ('102', '1', '1', '2130706433', 'member', '1', 'admin在2014-12-15 13:59登录了后台', '1', '1418623194');
INSERT INTO `cst_action_log` VALUES ('103', '1', '1', '2130706433', 'member', '1', 'admin在2014-12-15 18:25登录了后台', '1', '1418639113');
INSERT INTO `cst_action_log` VALUES ('104', '1', '1', '2130706433', 'member', '1', 'superAdmin在2014-12-16 09:07登录了后台', '1', '1418692029');
INSERT INTO `cst_action_log` VALUES ('105', '1', '2', '2130706433', 'member', '2', 'admin在2014-12-16 09:12登录了后台', '1', '1418692362');
INSERT INTO `cst_action_log` VALUES ('106', '1', '1', '2130706433', 'member', '1', 'superAdmin在2014-12-16 09:13登录了后台', '1', '1418692411');
INSERT INTO `cst_action_log` VALUES ('107', '1', '2', '2130706433', 'member', '2', 'admin在2014-12-16 09:17登录了后台', '1', '1418692652');
INSERT INTO `cst_action_log` VALUES ('108', '1', '2', '2130706433', 'member', '2', 'admin在2014-12-16 09:20登录了后台', '1', '1418692806');
INSERT INTO `cst_action_log` VALUES ('109', '10', '1', '2130706433', 'Menu', '2', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1418692910');
INSERT INTO `cst_action_log` VALUES ('110', '1', '2', '2130706433', 'member', '2', 'admin在2014-12-16 09:23登录了后台', '1', '1418693003');
INSERT INTO `cst_action_log` VALUES ('111', '1', '2', '2130706433', 'member', '2', 'admin在2014-12-16 09:23登录了后台', '1', '1418693038');
INSERT INTO `cst_action_log` VALUES ('112', '1', '2', '2130706433', 'member', '2', 'admin在2014-12-16 09:25登录了后台', '1', '1418693122');
INSERT INTO `cst_action_log` VALUES ('113', '10', '1', '2130706433', 'Menu', '43', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1418693361');
INSERT INTO `cst_action_log` VALUES ('114', '10', '1', '2130706433', 'Menu', '139', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1418693391');
INSERT INTO `cst_action_log` VALUES ('115', '10', '1', '2130706433', 'Menu', '68', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1418693403');
INSERT INTO `cst_action_log` VALUES ('116', '10', '1', '2130706433', 'Menu', '43', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1418693418');
INSERT INTO `cst_action_log` VALUES ('117', '10', '1', '2130706433', 'Menu', '93', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1418693432');
INSERT INTO `cst_action_log` VALUES ('118', '10', '1', '2130706433', 'Menu', '139', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1418693443');
INSERT INTO `cst_action_log` VALUES ('119', '10', '1', '2130706433', 'Menu', '16', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1418693481');
INSERT INTO `cst_action_log` VALUES ('120', '1', '2', '2130706433', 'member', '2', 'admin在2014-12-16 09:31登录了后台', '1', '1418693505');
INSERT INTO `cst_action_log` VALUES ('121', '1', '2', '1962082818', 'member', '2', 'admin在2014-12-16 11:17登录了后台', '1', '1418699849');
INSERT INTO `cst_action_log` VALUES ('122', '1', '2', '1962082818', 'member', '2', 'admin在2014-12-16 11:18登录了后台', '1', '1418699882');
INSERT INTO `cst_action_log` VALUES ('123', '1', '2', '1962082818', 'member', '2', 'admin在2014-12-16 11:49登录了后台', '1', '1418701745');
INSERT INTO `cst_action_log` VALUES ('124', '1', '2', '1962082818', 'member', '2', 'admin在2014-12-16 14:21登录了后台', '1', '1418710899');
INSERT INTO `cst_action_log` VALUES ('125', '1', '1', '1962082818', 'member', '1', 'superAdmin在2014-12-16 14:35登录了后台', '1', '1418711725');
INSERT INTO `cst_action_log` VALUES ('126', '1', '2', '1962082818', 'member', '2', 'admin在2014-12-16 14:36登录了后台', '1', '1418711804');
INSERT INTO `cst_action_log` VALUES ('127', '1', '1', '1962082818', 'member', '1', 'superAdmin在2014-12-16 14:39登录了后台', '1', '1418711946');
INSERT INTO `cst_action_log` VALUES ('128', '1', '2', '1962082818', 'member', '2', 'admin在2014-12-16 14:40登录了后台', '1', '1418712036');
INSERT INTO `cst_action_log` VALUES ('129', '1', '2', '996955474', 'member', '2', 'admin在2014-12-16 14:50登录了后台', '1', '1418712646');
INSERT INTO `cst_action_log` VALUES ('130', '1', '1', '1962082818', 'member', '1', 'superAdmin在2014-12-16 14:57登录了后台', '1', '1418713063');
INSERT INTO `cst_action_log` VALUES ('131', '10', '1', '1962082818', 'Menu', '153', '操作url：/cst/index.php?m=Admin&c=Menu&a=add', '1', '1418713540');
INSERT INTO `cst_action_log` VALUES ('132', '10', '1', '1962082818', 'Menu', '153', '操作url：/cst/index.php?m=Admin&c=Menu&a=edit', '1', '1418713556');
INSERT INTO `cst_action_log` VALUES ('133', '1', '2', '1962082818', 'member', '2', 'admin在2014-12-16 15:07登录了后台', '1', '1418713653');
INSERT INTO `cst_action_log` VALUES ('134', '1', '2', '996955474', 'member', '2', 'admin在2014-12-16 15:19登录了后台', '1', '1418714387');
INSERT INTO `cst_action_log` VALUES ('135', '1', '2', '996955474', 'member', '2', 'admin在2014-12-16 15:24登录了后台', '1', '1418714646');
INSERT INTO `cst_action_log` VALUES ('136', '1', '2', '996955474', 'member', '2', 'admin在2014-12-16 15:48登录了后台', '1', '1418716117');
INSERT INTO `cst_action_log` VALUES ('137', '1', '2', '1962082818', 'member', '2', 'admin在2014-12-16 16:07登录了后台', '1', '1418717258');
INSERT INTO `cst_action_log` VALUES ('138', '1', '2', '996955474', 'member', '2', 'admin在2014-12-16 16:23登录了后台', '1', '1418718200');
INSERT INTO `cst_action_log` VALUES ('139', '1', '1', '1962082818', 'member', '1', 'superAdmin在2014-12-16 16:58登录了后台', '1', '1418720292');
INSERT INTO `cst_action_log` VALUES ('140', '1', '2', '1962082818', 'member', '2', 'admin在2014-12-16 17:35登录了后台', '1', '1418722505');
INSERT INTO `cst_action_log` VALUES ('141', '1', '2', '996955474', 'member', '2', 'admin在2014-12-16 17:41登录了后台', '1', '1418722918');
INSERT INTO `cst_action_log` VALUES ('142', '1', '1', '1962082818', 'member', '1', 'superAdmin在2014-12-16 18:11登录了后台', '1', '1418724677');
INSERT INTO `cst_action_log` VALUES ('143', '1', '1', '2130706433', 'member', '1', 'superAdmin在2014-12-16 18:43登录了后台', '1', '1418726582');
INSERT INTO `cst_action_log` VALUES ('144', '10', '1', '2130706433', 'Menu', '154', '操作url：/index.php?m=Admin&c=Menu&a=add', '1', '1418726883');
INSERT INTO `cst_action_log` VALUES ('145', '10', '1', '2130706433', 'Menu', '155', '操作url：/index.php?m=Admin&c=Menu&a=add', '1', '1418726973');
INSERT INTO `cst_action_log` VALUES ('146', '10', '1', '2130706433', 'Menu', '156', '操作url：/index.php?m=Admin&c=Menu&a=add', '1', '1418727015');
INSERT INTO `cst_action_log` VALUES ('147', '10', '1', '2130706433', 'Menu', '157', '操作url：/index.php?m=Admin&c=Menu&a=add', '1', '1418727264');
INSERT INTO `cst_action_log` VALUES ('148', '10', '1', '2130706433', 'Menu', '155', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1418727321');
INSERT INTO `cst_action_log` VALUES ('149', '10', '1', '2130706433', 'Menu', '156', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1418727347');
INSERT INTO `cst_action_log` VALUES ('150', '10', '1', '2130706433', 'Menu', '150', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1418727460');
INSERT INTO `cst_action_log` VALUES ('151', '10', '1', '2130706433', 'Menu', '151', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1418727473');
INSERT INTO `cst_action_log` VALUES ('152', '10', '1', '2130706433', 'Menu', '149', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1418727483');
INSERT INTO `cst_action_log` VALUES ('153', '10', '1', '2130706433', 'Menu', '158', '操作url：/index.php?m=Admin&c=Menu&a=add', '1', '1418727592');
INSERT INTO `cst_action_log` VALUES ('154', '10', '1', '2130706433', 'Menu', '159', '操作url：/index.php?m=Admin&c=Menu&a=add', '1', '1418727617');
INSERT INTO `cst_action_log` VALUES ('155', '10', '1', '2130706433', 'Menu', '159', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1418727665');
INSERT INTO `cst_action_log` VALUES ('156', '10', '1', '2130706433', 'Menu', '158', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1418727675');
INSERT INTO `cst_action_log` VALUES ('157', '10', '1', '2130706433', 'Menu', '160', '操作url：/index.php?m=Admin&c=Menu&a=add', '1', '1418727742');
INSERT INTO `cst_action_log` VALUES ('158', '10', '1', '2130706433', 'Menu', '160', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1418727813');
INSERT INTO `cst_action_log` VALUES ('159', '10', '1', '2130706433', 'Menu', '161', '操作url：/index.php?m=Admin&c=Menu&a=add', '1', '1418727848');
INSERT INTO `cst_action_log` VALUES ('160', '10', '1', '2130706433', 'Menu', '162', '操作url：/index.php?m=Admin&c=Menu&a=add', '1', '1418727879');
INSERT INTO `cst_action_log` VALUES ('161', '10', '1', '2130706433', 'Menu', '163', '操作url：/index.php?m=Admin&c=Menu&a=add', '1', '1418727913');
INSERT INTO `cst_action_log` VALUES ('162', '10', '1', '2130706433', 'Menu', '164', '操作url：/index.php?m=Admin&c=Menu&a=add', '1', '1418727949');
INSERT INTO `cst_action_log` VALUES ('163', '10', '1', '2130706433', 'Menu', '165', '操作url：/index.php?m=Admin&c=Menu&a=add', '1', '1418727976');
INSERT INTO `cst_action_log` VALUES ('164', '10', '1', '2130706433', 'Menu', '154', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1418728050');
INSERT INTO `cst_action_log` VALUES ('165', '10', '1', '2130706433', 'Menu', '157', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1418729731');
INSERT INTO `cst_action_log` VALUES ('166', '10', '1', '2130706433', 'Menu', '158', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1418729743');
INSERT INTO `cst_action_log` VALUES ('167', '10', '1', '2130706433', 'Menu', '159', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1418729749');
INSERT INTO `cst_action_log` VALUES ('168', '1', '2', '2130706433', 'member', '2', 'admin在2014-12-16 19:36登录了后台', '1', '1418729805');
INSERT INTO `cst_action_log` VALUES ('169', '10', '1', '2130706433', 'Menu', '141', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1418734230');
INSERT INTO `cst_action_log` VALUES ('170', '10', '1', '2130706433', 'Menu', '158', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1418734278');
INSERT INTO `cst_action_log` VALUES ('171', '10', '1', '2130706433', 'Menu', '159', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1418734284');
INSERT INTO `cst_action_log` VALUES ('172', '1', '2', '2130706433', 'member', '2', 'admin在2014-12-17 09:29登录了后台', '1', '1418779796');
INSERT INTO `cst_action_log` VALUES ('173', '1', '2', '2130706433', 'member', '2', 'admin在2014-12-17 09:31登录了后台', '1', '1418779892');
INSERT INTO `cst_action_log` VALUES ('174', '1', '1', '2130706433', 'member', '1', 'superAdmin在2014-12-17 09:46登录了后台', '1', '1418780797');
INSERT INTO `cst_action_log` VALUES ('175', '10', '1', '2130706433', 'Menu', '166', '操作url：/index.php?m=Admin&c=Menu&a=add', '1', '1418785510');
INSERT INTO `cst_action_log` VALUES ('176', '10', '1', '2130706433', 'Menu', '167', '操作url：/index.php?m=Admin&c=Menu&a=add', '1', '1418786273');
INSERT INTO `cst_action_log` VALUES ('177', '10', '1', '2130706433', 'Menu', '168', '操作url：/index.php?m=Admin&c=Menu&a=add', '1', '1418786323');
INSERT INTO `cst_action_log` VALUES ('178', '1', '2', '2130706433', 'member', '2', 'admin在2014-12-17 13:40登录了后台', '1', '1418794858');
INSERT INTO `cst_action_log` VALUES ('179', '1', '2', '2130706433', 'member', '2', 'admin在2014-12-17 14:25登录了后台', '1', '1418797529');
INSERT INTO `cst_action_log` VALUES ('180', '1', '1', '2130706433', 'member', '1', 'superAdmin在2014-12-17 14:26登录了后台', '1', '1418797588');
INSERT INTO `cst_action_log` VALUES ('181', '1', '2', '2130706433', 'member', '2', 'admin在2014-12-17 14:27登录了后台', '1', '1418797646');
INSERT INTO `cst_action_log` VALUES ('182', '1', '2', '2130706433', 'member', '2', 'admin在2014-12-17 14:28登录了后台', '1', '1418797697');
INSERT INTO `cst_action_log` VALUES ('183', '10', '1', '2130706433', 'Menu', '169', '操作url：/index.php?m=Admin&c=Menu&a=add', '1', '1418798244');
INSERT INTO `cst_action_log` VALUES ('184', '1', '2', '2130706433', 'member', '2', 'admin在2014-12-17 14:38登录了后台', '1', '1418798284');
INSERT INTO `cst_action_log` VALUES ('185', '10', '1', '2130706433', 'Menu', '170', '操作url：/index.php?m=Admin&c=Menu&a=add', '1', '1418798409');
INSERT INTO `cst_action_log` VALUES ('186', '10', '1', '2130706433', 'Menu', '169', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1418798541');
INSERT INTO `cst_action_log` VALUES ('187', '10', '1', '2130706433', 'Menu', '170', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1418798556');
INSERT INTO `cst_action_log` VALUES ('188', '10', '1', '2130706433', 'Menu', '171', '操作url：/index.php?m=Admin&c=Menu&a=add', '1', '1418798592');
INSERT INTO `cst_action_log` VALUES ('189', '10', '1', '2130706433', 'Menu', '169', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1418798610');
INSERT INTO `cst_action_log` VALUES ('190', '10', '1', '2130706433', 'Menu', '170', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1418798618');
INSERT INTO `cst_action_log` VALUES ('191', '10', '1', '2130706433', 'Menu', '171', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1418798624');
INSERT INTO `cst_action_log` VALUES ('192', '10', '1', '2130706433', 'Menu', '171', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1418798633');
INSERT INTO `cst_action_log` VALUES ('193', '1', '2', '2130706433', 'member', '2', 'admin在2014-12-17 14:44登录了后台', '1', '1418798670');
INSERT INTO `cst_action_log` VALUES ('194', '10', '1', '2130706433', 'Menu', '172', '操作url：/index.php?m=Admin&c=Menu&a=add', '1', '1418798878');
INSERT INTO `cst_action_log` VALUES ('195', '10', '1', '2130706433', 'Menu', '173', '操作url：/index.php?m=Admin&c=Menu&a=add', '1', '1418798986');
INSERT INTO `cst_action_log` VALUES ('196', '10', '1', '2130706433', 'Menu', '172', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1418799000');
INSERT INTO `cst_action_log` VALUES ('197', '10', '1', '2130706433', 'Menu', '173', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1418799014');
INSERT INTO `cst_action_log` VALUES ('198', '10', '1', '2130706433', 'Menu', '174', '操作url：/index.php?m=Admin&c=Menu&a=add', '1', '1418799084');
INSERT INTO `cst_action_log` VALUES ('199', '1', '2', '2130706433', 'member', '2', 'admin在2014-12-17 14:52登录了后台', '1', '1418799120');
INSERT INTO `cst_action_log` VALUES ('200', '10', '1', '2130706433', 'Menu', '175', '操作url：/index.php?m=Admin&c=Menu&a=add', '1', '1418799435');
INSERT INTO `cst_action_log` VALUES ('201', '10', '1', '2130706433', 'Menu', '176', '操作url：/index.php?m=Admin&c=Menu&a=add', '1', '1418799471');
INSERT INTO `cst_action_log` VALUES ('202', '1', '2', '2130706433', 'member', '2', 'admin在2014-12-17 14:58登录了后台', '1', '1418799528');
INSERT INTO `cst_action_log` VALUES ('203', '10', '1', '2130706433', 'Menu', '176', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1418799561');
INSERT INTO `cst_action_log` VALUES ('204', '10', '1', '2130706433', 'Menu', '175', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1418799567');
INSERT INTO `cst_action_log` VALUES ('205', '1', '2', '2130706433', 'member', '2', 'admin在2014-12-17 15:00登录了后台', '1', '1418799606');
INSERT INTO `cst_action_log` VALUES ('206', '10', '1', '2130706433', 'Menu', '177', '操作url：/index.php?m=Admin&c=Menu&a=add', '1', '1418799740');
INSERT INTO `cst_action_log` VALUES ('207', '10', '1', '2130706433', 'Menu', '177', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1418799748');
INSERT INTO `cst_action_log` VALUES ('208', '10', '1', '2130706433', 'Menu', '166', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1418799773');
INSERT INTO `cst_action_log` VALUES ('209', '10', '1', '2130706433', 'Menu', '178', '操作url：/index.php?m=Admin&c=Menu&a=add', '1', '1418799834');
INSERT INTO `cst_action_log` VALUES ('210', '10', '1', '2130706433', 'Menu', '179', '操作url：/index.php?m=Admin&c=Menu&a=add', '1', '1418799885');
INSERT INTO `cst_action_log` VALUES ('211', '10', '1', '2130706433', 'Menu', '167', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1418799892');
INSERT INTO `cst_action_log` VALUES ('212', '10', '1', '2130706433', 'Menu', '179', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1418799898');
INSERT INTO `cst_action_log` VALUES ('213', '10', '1', '2130706433', 'Menu', '168', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1418799921');
INSERT INTO `cst_action_log` VALUES ('214', '10', '1', '2130706433', 'Menu', '180', '操作url：/index.php?m=Admin&c=Menu&a=add', '1', '1418799948');
INSERT INTO `cst_action_log` VALUES ('215', '10', '1', '2130706433', 'Menu', '180', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1418799955');
INSERT INTO `cst_action_log` VALUES ('216', '1', '2', '2130706433', 'member', '2', 'admin在2014-12-17 15:07登录了后台', '1', '1418800065');
INSERT INTO `cst_action_log` VALUES ('217', '10', '1', '2130706433', 'Menu', '181', '操作url：/index.php?m=Admin&c=Menu&a=add', '1', '1418803052');
INSERT INTO `cst_action_log` VALUES ('218', '1', '2', '2130706433', 'member', '2', 'admin在2014-12-17 15:58登录了后台', '1', '1418803131');
INSERT INTO `cst_action_log` VALUES ('219', '6', '1', '2130706433', 'config', '0', '操作url：/index.php?m=Admin&c=Config&a=del&id=46', '1', '1418803644');
INSERT INTO `cst_action_log` VALUES ('220', '6', '1', '2130706433', 'config', '0', '操作url：/index.php?m=Admin&c=Config&a=del&id=47', '1', '1418803647');
INSERT INTO `cst_action_log` VALUES ('221', '6', '1', '2130706433', 'config', '0', '操作url：/index.php?m=Admin&c=Config&a=del&id=51', '1', '1418803661');
INSERT INTO `cst_action_log` VALUES ('222', '6', '1', '2130706433', 'config', '56', '操作url：/index.php?m=Admin&c=Config&a=edit', '1', '1418805045');
INSERT INTO `cst_action_log` VALUES ('223', '1', '2', '2130706433', 'member', '2', 'admin在2014-12-17 16:53登录了后台', '1', '1418806413');
INSERT INTO `cst_action_log` VALUES ('224', '1', '2', '2130706433', 'member', '2', 'admin在2014-12-17 17:17登录了后台', '1', '1418807867');
INSERT INTO `cst_action_log` VALUES ('225', '1', '2', '2130706433', 'member', '2', 'admin在2014-12-17 17:23登录了后台', '1', '1418808180');
INSERT INTO `cst_action_log` VALUES ('226', '1', '2', '2130706433', 'member', '2', 'admin在2014-12-17 17:44登录了后台', '1', '1418809444');
INSERT INTO `cst_action_log` VALUES ('227', '1', '2', '2130706433', 'member', '2', 'admin在2014-12-17 18:26登录了后台', '1', '1418811964');
INSERT INTO `cst_action_log` VALUES ('228', '1', '2', '1962082818', 'member', '2', 'admin在2014-12-17 19:21登录了后台', '1', '1418815308');
INSERT INTO `cst_action_log` VALUES ('229', '1', '2', '1962082818', 'member', '2', 'admin在2014-12-17 20:00登录了后台', '1', '1418817607');
INSERT INTO `cst_action_log` VALUES ('230', '1', '2', '1962082818', 'member', '2', 'admin在2014-12-17 20:43登录了后台', '1', '1418820212');
INSERT INTO `cst_action_log` VALUES ('231', '1', '2', '243513319', 'member', '2', 'admin在2014-12-18 08:10登录了后台', '1', '1418861451');
INSERT INTO `cst_action_log` VALUES ('232', '1', '1', '243513319', 'member', '1', 'superAdmin在2014-12-18 08:25登录了后台', '1', '1418862321');
INSERT INTO `cst_action_log` VALUES ('233', '1', '2', '243513319', 'member', '2', 'admin在2014-12-18 08:27登录了后台', '1', '1418862441');
INSERT INTO `cst_action_log` VALUES ('234', '10', '1', '243513319', 'Menu', '182', '操作url：/cst/index.php?m=Admin&c=Menu&a=add', '1', '1418862697');
INSERT INTO `cst_action_log` VALUES ('235', '1', '2', '243513319', 'member', '2', 'admin在2014-12-18 08:33登录了后台', '1', '1418862786');
INSERT INTO `cst_action_log` VALUES ('236', '1', '2', '996955474', 'member', '2', 'admin在2014-12-18 10:39登录了后台', '1', '1418870340');
INSERT INTO `cst_action_log` VALUES ('237', '1', '2', '996955474', 'member', '2', 'admin在2014-12-18 11:06登录了后台', '1', '1418872013');
INSERT INTO `cst_action_log` VALUES ('238', '1', '2', '996955474', 'member', '2', 'admin在2014-12-18 11:32登录了后台', '1', '1418873540');
INSERT INTO `cst_action_log` VALUES ('239', '1', '2', '2130706433', 'member', '2', 'admin在2014-12-18 15:57登录了后台', '1', '1418889477');
INSERT INTO `cst_action_log` VALUES ('240', '1', '1', '2130706433', 'member', '1', 'superAdmin在2014-12-18 15:59登录了后台', '1', '1418889549');
INSERT INTO `cst_action_log` VALUES ('241', '1', '2', '2130706433', 'member', '2', 'admin在2014-12-18 16:01登录了后台', '1', '1418889680');
INSERT INTO `cst_action_log` VALUES ('242', '1', '2', '2130706433', 'member', '2', 'admin在2014-12-19 10:38登录了后台', '1', '1418956697');
INSERT INTO `cst_action_log` VALUES ('243', '1', '2', '2130706433', 'member', '2', 'admin在2014-12-22 09:25登录了后台', '1', '1419211540');
INSERT INTO `cst_action_log` VALUES ('244', '1', '2', '2130706433', 'member', '2', 'admin在2014-12-22 09:56登录了后台', '1', '1419213385');
INSERT INTO `cst_action_log` VALUES ('245', '1', '1', '2130706433', 'member', '1', 'superAdmin在2014-12-22 11:34登录了后台', '1', '1419219278');
INSERT INTO `cst_action_log` VALUES ('246', '10', '1', '2130706433', 'Menu', '2', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1419219332');
INSERT INTO `cst_action_log` VALUES ('247', '10', '1', '2130706433', 'Menu', '139', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1419219342');
INSERT INTO `cst_action_log` VALUES ('248', '10', '1', '2130706433', 'Menu', '16', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1419219426');
INSERT INTO `cst_action_log` VALUES ('249', '10', '1', '2130706433', 'Menu', '68', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1419219442');
INSERT INTO `cst_action_log` VALUES ('250', '10', '1', '2130706433', 'Menu', '122', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1419219458');
INSERT INTO `cst_action_log` VALUES ('251', '10', '1', '2130706433', 'Menu', '16', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1419219489');
INSERT INTO `cst_action_log` VALUES ('252', '1', '2', '2130706433', 'member', '2', 'admin在2014-12-22 11:38登录了后台', '1', '1419219511');
INSERT INTO `cst_action_log` VALUES ('253', '10', '1', '2130706433', 'Menu', '144', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1419219675');
INSERT INTO `cst_action_log` VALUES ('254', '10', '1', '2130706433', 'Menu', '144', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1419219728');
INSERT INTO `cst_action_log` VALUES ('255', '10', '1', '2130706433', 'Menu', '148', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1419219820');
INSERT INTO `cst_action_log` VALUES ('256', '10', '1', '2130706433', 'Menu', '148', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1419219857');
INSERT INTO `cst_action_log` VALUES ('257', '10', '1', '2130706433', 'Menu', '68', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1419219983');
INSERT INTO `cst_action_log` VALUES ('258', '10', '1', '2130706433', 'Menu', '157', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1419220132');
INSERT INTO `cst_action_log` VALUES ('259', '10', '1', '2130706433', 'Menu', '160', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1419220169');
INSERT INTO `cst_action_log` VALUES ('260', '10', '1', '2130706433', 'Menu', '163', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1419220192');
INSERT INTO `cst_action_log` VALUES ('261', '10', '1', '2130706433', 'Menu', '154', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1419220218');
INSERT INTO `cst_action_log` VALUES ('262', '1', '2', '2130706433', 'member', '2', 'admin在2014-12-22 14:42登录了后台', '1', '1419230521');
INSERT INTO `cst_action_log` VALUES ('263', '1', '1', '2130706433', 'member', '1', 'superAdmin在2014-12-22 15:05登录了后台', '1', '1419231932');
INSERT INTO `cst_action_log` VALUES ('264', '10', '1', '2130706433', 'Menu', '183', '操作url：/index.php?m=Admin&c=Menu&a=add', '1', '1419232023');
INSERT INTO `cst_action_log` VALUES ('265', '10', '1', '2130706433', 'Menu', '183', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1419232033');
INSERT INTO `cst_action_log` VALUES ('266', '10', '1', '2130706433', 'Menu', '178', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1419232055');
INSERT INTO `cst_action_log` VALUES ('267', '10', '1', '2130706433', 'Menu', '184', '操作url：/index.php?m=Admin&c=Menu&a=add', '1', '1419232119');
INSERT INTO `cst_action_log` VALUES ('268', '10', '1', '2130706433', 'Menu', '184', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1419232143');
INSERT INTO `cst_action_log` VALUES ('269', '10', '1', '2130706433', 'Menu', '184', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1419232149');
INSERT INTO `cst_action_log` VALUES ('270', '10', '1', '2130706433', 'Menu', '179', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1419232155');
INSERT INTO `cst_action_log` VALUES ('271', '10', '1', '2130706433', 'Menu', '184', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1419232163');
INSERT INTO `cst_action_log` VALUES ('272', '10', '1', '2130706433', 'Menu', '162', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1419232169');
INSERT INTO `cst_action_log` VALUES ('273', '10', '1', '2130706433', 'Menu', '161', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1419232175');
INSERT INTO `cst_action_log` VALUES ('274', '10', '1', '2130706433', 'Menu', '167', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1419232180');
INSERT INTO `cst_action_log` VALUES ('275', '10', '1', '2130706433', 'Menu', '185', '操作url：/index.php?m=Admin&c=Menu&a=add', '1', '1419232277');
INSERT INTO `cst_action_log` VALUES ('276', '10', '1', '2130706433', 'Menu', '185', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1419232285');
INSERT INTO `cst_action_log` VALUES ('277', '10', '1', '2130706433', 'Menu', '180', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1419232290');
INSERT INTO `cst_action_log` VALUES ('278', '10', '1', '2130706433', 'Menu', '168', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1419232295');
INSERT INTO `cst_action_log` VALUES ('279', '10', '1', '2130706433', 'Menu', '168', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1419232313');
INSERT INTO `cst_action_log` VALUES ('280', '10', '1', '2130706433', 'Menu', '0', '操作url：/index.php?m=Admin&c=Menu&a=del&id=167', '1', '1419232344');
INSERT INTO `cst_action_log` VALUES ('281', '10', '1', '2130706433', 'Menu', '0', '操作url：/index.php?m=Admin&c=Menu&a=del&id=168', '1', '1419232361');
INSERT INTO `cst_action_log` VALUES ('282', '1', '2', '2130706433', 'member', '2', 'admin在2014-12-22 15:13登录了后台', '1', '1419232398');
INSERT INTO `cst_action_log` VALUES ('283', '10', '1', '2130706433', 'Menu', '183', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1419232459');
INSERT INTO `cst_action_log` VALUES ('284', '1', '2', '2130706433', 'member', '2', 'admin在2014-12-22 15:14登录了后台', '1', '1419232484');
INSERT INTO `cst_action_log` VALUES ('285', '10', '1', '2130706433', 'Menu', '184', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1419232771');
INSERT INTO `cst_action_log` VALUES ('286', '10', '1', '2130706433', 'Menu', '179', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1419232784');
INSERT INTO `cst_action_log` VALUES ('287', '10', '1', '2130706433', 'Menu', '184', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1419232794');
INSERT INTO `cst_action_log` VALUES ('288', '10', '1', '2130706433', 'Menu', '185', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1419232861');
INSERT INTO `cst_action_log` VALUES ('289', '1', '2', '2130706433', 'member', '2', 'admin在2014-12-22 15:21登录了后台', '1', '1419232885');
INSERT INTO `cst_action_log` VALUES ('290', '10', '1', '2130706433', 'Menu', '186', '操作url：/index.php?m=Admin&c=Menu&a=add', '1', '1419241332');
INSERT INTO `cst_action_log` VALUES ('291', '10', '1', '2130706433', 'Menu', '187', '操作url：/index.php?m=Admin&c=Menu&a=add', '1', '1419241409');
INSERT INTO `cst_action_log` VALUES ('292', '10', '1', '2130706433', 'Menu', '187', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1419241418');
INSERT INTO `cst_action_log` VALUES ('293', '10', '1', '2130706433', 'Menu', '186', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1419241430');
INSERT INTO `cst_action_log` VALUES ('294', '10', '1', '2130706433', 'Menu', '186', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1419241442');
INSERT INTO `cst_action_log` VALUES ('295', '10', '1', '2130706433', 'Menu', '188', '操作url：/index.php?m=Admin&c=Menu&a=add', '1', '1419241500');
INSERT INTO `cst_action_log` VALUES ('296', '1', '2', '2130706433', 'member', '2', 'admin在2014-12-22 17:47登录了后台', '1', '1419241654');
INSERT INTO `cst_action_log` VALUES ('297', '1', '2', '2130706433', 'member', '2', 'admin在2014-12-22 19:15登录了后台', '1', '1419246927');
INSERT INTO `cst_action_log` VALUES ('298', '1', '2', '2130706433', 'member', '2', 'admin在2014-12-22 19:19登录了后台', '1', '1419247151');
INSERT INTO `cst_action_log` VALUES ('299', '1', '1', '2130706433', 'member', '1', 'superAdmin在2014-12-22 19:19登录了后台', '1', '1419247175');
INSERT INTO `cst_action_log` VALUES ('300', '10', '1', '2130706433', 'Menu', '189', '操作url：/index.php?m=Admin&c=Menu&a=add', '1', '1419247280');
INSERT INTO `cst_action_log` VALUES ('301', '10', '1', '2130706433', 'Menu', '188', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1419247305');
INSERT INTO `cst_action_log` VALUES ('302', '10', '1', '2130706433', 'Menu', '190', '操作url：/index.php?m=Admin&c=Menu&a=add', '1', '1419247334');
INSERT INTO `cst_action_log` VALUES ('303', '1', '2', '2130706433', 'member', '2', 'admin在2014-12-23 09:08登录了后台', '1', '1419296919');
INSERT INTO `cst_action_log` VALUES ('304', '1', '1', '2130706433', 'member', '1', 'superAdmin在2014-12-23 09:09登录了后台', '1', '1419296973');
INSERT INTO `cst_action_log` VALUES ('305', '10', '1', '2130706433', 'Menu', '139', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1419297015');
INSERT INTO `cst_action_log` VALUES ('306', '10', '1', '2130706433', 'Menu', '142', '操作url：/index.php?m=Admin&c=Menu&a=edit', '1', '1419297306');
INSERT INTO `cst_action_log` VALUES ('307', '1', '2', '2130706433', 'member', '2', 'admin在2014-12-23 09:18登录了后台', '1', '1419297482');
INSERT INTO `cst_action_log` VALUES ('308', '1', '2', '2130706433', 'member', '2', 'admin在2014-12-23 09:18登录了后台', '1', '1419297527');
INSERT INTO `cst_action_log` VALUES ('309', '1', '2', '2130706433', 'member', '2', 'admin在2014-12-23 10:18登录了后台', '1', '1419301098');

-- ----------------------------
-- Table structure for `cst_addons`
-- ----------------------------
DROP TABLE IF EXISTS `cst_addons`;
CREATE TABLE `cst_addons` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(40) NOT NULL COMMENT '插件名或标识',
  `title` varchar(20) NOT NULL DEFAULT '' COMMENT '中文名',
  `description` text COMMENT '插件描述',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  `config` text COMMENT '配置',
  `author` varchar(40) DEFAULT '' COMMENT '作者',
  `version` varchar(20) DEFAULT '' COMMENT '版本号',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '安装时间',
  `has_adminlist` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否有后台列表',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COMMENT='插件表';

-- ----------------------------
-- Records of cst_addons
-- ----------------------------
INSERT INTO `cst_addons` VALUES ('15', 'EditorForAdmin', '后台编辑器', '用于增强整站长文本的输入和显示', '1', '{\"editor_type\":\"2\",\"editor_wysiwyg\":\"2\",\"editor_height\":\"500px\",\"editor_resize_type\":\"1\"}', 'pami', '0.1', '1383126253', '0');
INSERT INTO `cst_addons` VALUES ('2', 'SiteStat', '站点统计信息', '统计站点的基础信息', '1', '{\"title\":\"\\u7cfb\\u7edf\\u4fe1\\u606f\",\"width\":\"4\",\"display\":\"1\"}', 'pami', '0.1', '1379512015', '0');
INSERT INTO `cst_addons` VALUES ('4', 'SystemInfo', '系统环境信息', '用于显示一些服务器的信息', '1', '{\"title\":\"\\u7cfb\\u7edf\\u4fe1\\u606f\",\"width\":\"1\",\"display\":\"1\"}', 'pami', '0.1', '1379512036', '0');
INSERT INTO `cst_addons` VALUES ('5', 'Editor', '前台编辑器', '用于增强整站长文本的输入和显示', '1', '{\"editor_type\":\"2\",\"editor_wysiwyg\":\"1\",\"editor_height\":\"300px\",\"editor_resize_type\":\"1\"}', 'pami', '0.1', '1379830910', '0');
INSERT INTO `cst_addons` VALUES ('6', 'Attachment', '附件', '用于文档模型上传附件', '0', 'null', 'pami', '0.1', '1379842319', '1');
INSERT INTO `cst_addons` VALUES ('9', 'SocialComment', '通用社交化评论', '集成了各种社交化评论插件，轻松集成到系统中。', '1', '{\"comment_type\":\"1\",\"comment_uid_youyan\":\"\",\"comment_short_name_duoshuo\":\"\",\"comment_data_list_duoshuo\":\"\"}', 'pami', '0.1', '1380273962', '0');

-- ----------------------------
-- Table structure for `cst_attachment`
-- ----------------------------
DROP TABLE IF EXISTS `cst_attachment`;
CREATE TABLE `cst_attachment` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `title` char(30) NOT NULL DEFAULT '' COMMENT '附件显示名',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '附件类型',
  `source` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '资源ID',
  `record_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '关联记录ID',
  `download` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '下载次数',
  `size` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '附件大小',
  `dir` int(12) unsigned NOT NULL DEFAULT '0' COMMENT '上级目录ID',
  `sort` int(8) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态',
  PRIMARY KEY (`id`),
  KEY `idx_record_status` (`record_id`,`status`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='附件表';

-- ----------------------------
-- Records of cst_attachment
-- ----------------------------

-- ----------------------------
-- Table structure for `cst_attribute`
-- ----------------------------
DROP TABLE IF EXISTS `cst_attribute`;
CREATE TABLE `cst_attribute` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '字段名',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '字段注释',
  `field` varchar(100) NOT NULL DEFAULT '' COMMENT '字段定义',
  `type` varchar(20) NOT NULL DEFAULT '' COMMENT '数据类型',
  `value` varchar(100) NOT NULL DEFAULT '' COMMENT '字段默认值',
  `remark` varchar(100) NOT NULL DEFAULT '' COMMENT '备注',
  `is_show` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '是否显示',
  `extra` varchar(255) NOT NULL DEFAULT '' COMMENT '参数',
  `model_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '模型id',
  `is_must` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否必填',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '状态',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `validate_rule` varchar(255) NOT NULL,
  `validate_time` tinyint(1) unsigned NOT NULL,
  `error_info` varchar(100) NOT NULL,
  `validate_type` varchar(25) NOT NULL,
  `auto_rule` varchar(100) NOT NULL,
  `auto_time` tinyint(1) unsigned NOT NULL,
  `auto_type` varchar(25) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `model_id` (`model_id`)
) ENGINE=MyISAM AUTO_INCREMENT=44 DEFAULT CHARSET=utf8 COMMENT='模型属性表';

-- ----------------------------
-- Records of cst_attribute
-- ----------------------------
INSERT INTO `cst_attribute` VALUES ('1', 'uid', '用户ID', 'int(10) unsigned NOT NULL ', 'num', '0', '', '0', '', '1', '0', '1', '1384508362', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `cst_attribute` VALUES ('2', 'name', '标识', 'char(40) NOT NULL ', 'string', '', '同一根节点下标识不重复', '1', '', '1', '0', '1', '1383894743', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `cst_attribute` VALUES ('3', 'title', '标题', 'char(80) NOT NULL ', 'string', '', '文档标题', '1', '', '1', '0', '1', '1383894778', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `cst_attribute` VALUES ('4', 'category_id', '所属分类', 'int(10) unsigned NOT NULL ', 'string', '', '', '0', '', '1', '0', '1', '1384508336', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `cst_attribute` VALUES ('5', 'description', '描述', 'char(140) NOT NULL ', 'textarea', '', '', '1', '', '1', '0', '1', '1383894927', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `cst_attribute` VALUES ('6', 'root', '根节点', 'int(10) unsigned NOT NULL ', 'num', '0', '该文档的顶级文档编号', '0', '', '1', '0', '1', '1384508323', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `cst_attribute` VALUES ('7', 'pid', '所属ID', 'int(10) unsigned NOT NULL ', 'num', '0', '父文档编号', '0', '', '1', '0', '1', '1384508543', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `cst_attribute` VALUES ('8', 'model_id', '内容模型ID', 'tinyint(3) unsigned NOT NULL ', 'num', '0', '该文档所对应的模型', '0', '', '1', '0', '1', '1384508350', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `cst_attribute` VALUES ('9', 'type', '内容类型', 'tinyint(3) unsigned NOT NULL ', 'select', '2', '', '1', '1:目录\r\n2:主题\r\n3:段落', '1', '0', '1', '1384511157', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `cst_attribute` VALUES ('10', 'position', '推荐位', 'smallint(5) unsigned NOT NULL ', 'checkbox', '0', '多个推荐则将其推荐值相加', '1', '1:列表推荐\r\n2:频道页推荐\r\n4:首页推荐', '1', '0', '1', '1383895640', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `cst_attribute` VALUES ('11', 'link_id', '外链', 'int(10) unsigned NOT NULL ', 'num', '0', '0-非外链，大于0-外链ID,需要函数进行链接与编号的转换', '1', '', '1', '0', '1', '1383895757', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `cst_attribute` VALUES ('12', 'cover_id', '封面', 'int(10) unsigned NOT NULL ', 'picture', '0', '0-无封面，大于0-封面图片ID，需要函数处理', '1', '', '1', '0', '1', '1384147827', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `cst_attribute` VALUES ('13', 'display', '可见性', 'tinyint(3) unsigned NOT NULL ', 'radio', '1', '', '1', '0:不可见\r\n1:所有人可见', '1', '0', '1', '1386662271', '1383891233', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `cst_attribute` VALUES ('14', 'deadline', '截至时间', 'int(10) unsigned NOT NULL ', 'datetime', '0', '0-永久有效', '1', '', '1', '0', '1', '1387163248', '1383891233', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `cst_attribute` VALUES ('15', 'attach', '附件数量', 'tinyint(3) unsigned NOT NULL ', 'num', '0', '', '0', '', '1', '0', '1', '1387260355', '1383891233', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `cst_attribute` VALUES ('16', 'view', '浏览量', 'int(10) unsigned NOT NULL ', 'num', '0', '', '1', '', '1', '0', '1', '1383895835', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `cst_attribute` VALUES ('17', 'comment', '评论数', 'int(10) unsigned NOT NULL ', 'num', '0', '', '1', '', '1', '0', '1', '1383895846', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `cst_attribute` VALUES ('18', 'extend', '扩展统计字段', 'int(10) unsigned NOT NULL ', 'num', '0', '根据需求自行使用', '0', '', '1', '0', '1', '1384508264', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `cst_attribute` VALUES ('19', 'level', '优先级', 'int(10) unsigned NOT NULL ', 'num', '0', '越高排序越靠前', '1', '', '1', '0', '1', '1383895894', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `cst_attribute` VALUES ('20', 'create_time', '创建时间', 'int(10) unsigned NOT NULL ', 'datetime', '0', '', '1', '', '1', '0', '1', '1383895903', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `cst_attribute` VALUES ('21', 'update_time', '更新时间', 'int(10) unsigned NOT NULL ', 'datetime', '0', '', '0', '', '1', '0', '1', '1384508277', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `cst_attribute` VALUES ('22', 'status', '数据状态', 'tinyint(4) NOT NULL ', 'radio', '0', '', '0', '-1:删除\r\n0:禁用\r\n1:正常\r\n2:待审核\r\n3:草稿', '1', '0', '1', '1384508496', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `cst_attribute` VALUES ('23', 'parse', '内容解析类型', 'tinyint(3) unsigned NOT NULL ', 'select', '0', '', '0', '0:html\r\n1:ubb\r\n2:markdown', '2', '0', '1', '1384511049', '1383891243', '', '0', '', '', '', '0', '');
INSERT INTO `cst_attribute` VALUES ('24', 'content', '文章内容', 'text NOT NULL ', 'editor', '', '', '1', '', '2', '0', '1', '1383896225', '1383891243', '', '0', '', '', '', '0', '');
INSERT INTO `cst_attribute` VALUES ('25', 'template', '详情页显示模板', 'varchar(100) NOT NULL ', 'string', '', '参照display方法参数的定义', '1', '', '2', '0', '1', '1383896190', '1383891243', '', '0', '', '', '', '0', '');
INSERT INTO `cst_attribute` VALUES ('26', 'bookmark', '收藏数', 'int(10) unsigned NOT NULL ', 'num', '0', '', '1', '', '2', '0', '1', '1383896103', '1383891243', '', '0', '', '', '', '0', '');
INSERT INTO `cst_attribute` VALUES ('27', 'parse', '内容解析类型', 'tinyint(3) unsigned NOT NULL ', 'select', '0', '', '0', '0:html\r\n1:ubb\r\n2:markdown', '3', '0', '1', '1387260461', '1383891252', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `cst_attribute` VALUES ('28', 'content', '下载详细描述', 'text NOT NULL ', 'editor', '', '', '1', '', '3', '0', '1', '1383896438', '1383891252', '', '0', '', '', '', '0', '');
INSERT INTO `cst_attribute` VALUES ('29', 'template', '详情页显示模板', 'varchar(100) NOT NULL ', 'string', '', '', '1', '', '3', '0', '1', '1383896429', '1383891252', '', '0', '', '', '', '0', '');
INSERT INTO `cst_attribute` VALUES ('30', 'file_id', '文件ID', 'int(10) unsigned NOT NULL ', 'file', '0', '需要函数处理', '1', '', '3', '0', '1', '1383896415', '1383891252', '', '0', '', '', '', '0', '');
INSERT INTO `cst_attribute` VALUES ('31', 'download', '下载次数', 'int(10) unsigned NOT NULL ', 'num', '0', '', '1', '', '3', '0', '1', '1383896380', '1383891252', '', '0', '', '', '', '0', '');
INSERT INTO `cst_attribute` VALUES ('32', 'size', '文件大小', 'bigint(20) unsigned NOT NULL ', 'num', '0', '单位bit', '1', '', '3', '0', '1', '1383896371', '1383891252', '', '0', '', '', '', '0', '');
INSERT INTO `cst_attribute` VALUES ('39', 'cover_1', '封面一', 'int(10) UNSIGNED NOT NULL', 'picture', '', '', '1', '', '5', '0', '1', '1417605441', '1417605441', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `cst_attribute` VALUES ('40', 'cover_2', '封面二', 'int(10) UNSIGNED NOT NULL', 'picture', '', '', '1', '', '5', '1', '1', '1417656366', '1417656366', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `cst_attribute` VALUES ('41', 'cover_3', '测试三', 'int(10) UNSIGNED NOT NULL', 'picture', '', '', '1', '', '5', '1', '1', '1417656380', '1417656380', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `cst_attribute` VALUES ('42', 'content', '产品介绍', 'text NOT NULL', 'editor', '', '', '1', '', '5', '0', '1', '1417656399', '1417656399', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `cst_attribute` VALUES ('43', 'vision', '版本号', 'varchar(255) NOT NULL', 'string', '1.0', '当前资料版本号', '1', '', '3', '1', '1', '1417682385', '1417682385', '', '3', '', 'regex', '', '3', 'function');

-- ----------------------------
-- Table structure for `cst_auth_extend`
-- ----------------------------
DROP TABLE IF EXISTS `cst_auth_extend`;
CREATE TABLE `cst_auth_extend` (
  `group_id` mediumint(10) unsigned NOT NULL COMMENT '用户id',
  `extend_id` mediumint(8) unsigned NOT NULL COMMENT '扩展表中数据的id',
  `type` tinyint(1) unsigned NOT NULL COMMENT '扩展类型标识 1:栏目分类权限;2:模型权限',
  UNIQUE KEY `group_extend_type` (`group_id`,`extend_id`,`type`),
  KEY `uid` (`group_id`),
  KEY `group_id` (`extend_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户组与分类的对应关系表';

-- ----------------------------
-- Records of cst_auth_extend
-- ----------------------------
INSERT INTO `cst_auth_extend` VALUES ('1', '1', '2');
INSERT INTO `cst_auth_extend` VALUES ('1', '2', '1');
INSERT INTO `cst_auth_extend` VALUES ('1', '2', '2');
INSERT INTO `cst_auth_extend` VALUES ('1', '3', '1');
INSERT INTO `cst_auth_extend` VALUES ('1', '3', '2');
INSERT INTO `cst_auth_extend` VALUES ('1', '4', '1');
INSERT INTO `cst_auth_extend` VALUES ('1', '5', '1');
INSERT INTO `cst_auth_extend` VALUES ('1', '6', '1');
INSERT INTO `cst_auth_extend` VALUES ('1', '7', '1');
INSERT INTO `cst_auth_extend` VALUES ('1', '8', '1');

-- ----------------------------
-- Table structure for `cst_auth_group`
-- ----------------------------
DROP TABLE IF EXISTS `cst_auth_group`;
CREATE TABLE `cst_auth_group` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户组id,自增主键',
  `module` varchar(20) NOT NULL COMMENT '用户组所属模块',
  `type` tinyint(4) NOT NULL COMMENT '组类型',
  `title` char(20) NOT NULL DEFAULT '' COMMENT '用户组中文名称',
  `description` varchar(80) NOT NULL DEFAULT '' COMMENT '描述信息',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '用户组状态：为1正常，为0禁用,-1为删除',
  `rules` varchar(500) NOT NULL DEFAULT '' COMMENT '用户组拥有的规则id，多个规则 , 隔开',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cst_auth_group
-- ----------------------------
INSERT INTO `cst_auth_group` VALUES ('1', 'admin', '1', '高级管理员', '系统分配高级管理员', '1', '1,3,5,7,8,9,10,11,12,13,14,15,16,17,18,26,28,29,30,31,32,33,34,35,36,37,38,39,40,41,65,71,72,73,74,79,80,81,82,83,84,86,87,88,89,90,91,92,93,94,95,108,109,211,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,232,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,256,257,258,259,262,263,264,265,266,267,268,269,270,272,273,277,278,279,280,281,282,284,285,286,287');
INSERT INTO `cst_auth_group` VALUES ('2', 'admin', '1', '普通管理员', '由高级管理员增加的管理员', '1', '1,2,5,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,79,80,82,83,84,88,89,90,91,92,93,96,97,100,102,103,195');

-- ----------------------------
-- Table structure for `cst_auth_group_access`
-- ----------------------------
DROP TABLE IF EXISTS `cst_auth_group_access`;
CREATE TABLE `cst_auth_group_access` (
  `uid` int(10) unsigned NOT NULL COMMENT '用户id',
  `group_id` mediumint(8) unsigned NOT NULL COMMENT '用户组id',
  UNIQUE KEY `uid_group_id` (`uid`,`group_id`),
  KEY `uid` (`uid`),
  KEY `group_id` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cst_auth_group_access
-- ----------------------------
INSERT INTO `cst_auth_group_access` VALUES ('2', '1');
INSERT INTO `cst_auth_group_access` VALUES ('3', '2');

-- ----------------------------
-- Table structure for `cst_auth_rule`
-- ----------------------------
DROP TABLE IF EXISTS `cst_auth_rule`;
CREATE TABLE `cst_auth_rule` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '规则id,自增主键',
  `module` varchar(20) NOT NULL COMMENT '规则所属module',
  `type` tinyint(2) NOT NULL DEFAULT '1' COMMENT '1-url;2-主菜单',
  `name` char(80) NOT NULL DEFAULT '' COMMENT '规则唯一英文标识',
  `title` char(20) NOT NULL DEFAULT '' COMMENT '规则中文描述',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否有效(0:无效,1:有效)',
  `condition` varchar(300) NOT NULL DEFAULT '' COMMENT '规则附加条件',
  PRIMARY KEY (`id`),
  KEY `module` (`module`,`status`,`type`)
) ENGINE=MyISAM AUTO_INCREMENT=288 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cst_auth_rule
-- ----------------------------
INSERT INTO `cst_auth_rule` VALUES ('1', 'admin', '2', 'Admin/Index/index', '首页', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('2', 'admin', '2', 'Admin/Article/mydocument', '内容', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('3', 'admin', '2', 'Admin/User/index', '管理', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('4', 'admin', '2', 'Admin/Addons/index', '设置', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('5', 'admin', '2', 'Admin/Config/group', '配置', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('7', 'admin', '1', 'Admin/article/add', '新增', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('8', 'admin', '1', 'Admin/article/edit', '编辑', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('9', 'admin', '1', 'Admin/article/setStatus', '改变状态', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('10', 'admin', '1', 'Admin/article/update', '保存', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('11', 'admin', '1', 'Admin/article/autoSave', '保存草稿', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('12', 'admin', '1', 'Admin/article/move', '移动', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('13', 'admin', '1', 'Admin/article/copy', '复制', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('14', 'admin', '1', 'Admin/article/paste', '粘贴', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('15', 'admin', '1', 'Admin/article/permit', '还原', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('16', 'admin', '1', 'Admin/article/clear', '清空', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('17', 'admin', '1', 'Admin/article/index', '文档列表', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('18', 'admin', '1', 'Admin/article/recycle', '回收站', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('19', 'admin', '1', 'Admin/User/addaction', '新增用户行为', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('20', 'admin', '1', 'Admin/User/editaction', '编辑用户行为', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('21', 'admin', '1', 'Admin/User/saveAction', '保存用户行为', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('22', 'admin', '1', 'Admin/User/setStatus', '变更行为状态', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('23', 'admin', '1', 'Admin/User/changeStatus?method=forbidUser', '禁用会员', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('24', 'admin', '1', 'Admin/User/changeStatus?method=resumeUser', '启用会员', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('25', 'admin', '1', 'Admin/User/changeStatus?method=deleteUser', '删除会员', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('26', 'admin', '1', 'Admin/User/index', '用户信息', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('27', 'admin', '1', 'Admin/User/action', '用户行为', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('28', 'admin', '1', 'Admin/AuthManager/changeStatus?method=deleteGroup', '删除', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('29', 'admin', '1', 'Admin/AuthManager/changeStatus?method=forbidGroup', '禁用', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('30', 'admin', '1', 'Admin/AuthManager/changeStatus?method=resumeGroup', '恢复', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('31', 'admin', '1', 'Admin/AuthManager/createGroup', '新增', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('32', 'admin', '1', 'Admin/AuthManager/editGroup', '编辑', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('33', 'admin', '1', 'Admin/AuthManager/writeGroup', '保存用户组', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('34', 'admin', '1', 'Admin/AuthManager/group', '授权', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('35', 'admin', '1', 'Admin/AuthManager/access', '访问授权', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('36', 'admin', '1', 'Admin/AuthManager/user', '成员授权', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('37', 'admin', '1', 'Admin/AuthManager/removeFromGroup', '解除授权', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('38', 'admin', '1', 'Admin/AuthManager/addToGroup', '保存成员授权', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('39', 'admin', '1', 'Admin/AuthManager/category', '分类授权', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('40', 'admin', '1', 'Admin/AuthManager/addToCategory', '保存分类授权', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('41', 'admin', '1', 'Admin/AuthManager/index', '权限管理', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('42', 'admin', '1', 'Admin/Addons/create', '创建', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('43', 'admin', '1', 'Admin/Addons/checkForm', '检测创建', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('44', 'admin', '1', 'Admin/Addons/preview', '预览', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('45', 'admin', '1', 'Admin/Addons/build', '快速生成插件', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('46', 'admin', '1', 'Admin/Addons/config', '设置', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('47', 'admin', '1', 'Admin/Addons/disable', '禁用', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('48', 'admin', '1', 'Admin/Addons/enable', '启用', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('49', 'admin', '1', 'Admin/Addons/install', '安装', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('50', 'admin', '1', 'Admin/Addons/uninstall', '卸载', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('51', 'admin', '1', 'Admin/Addons/saveconfig', '更新配置', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('52', 'admin', '1', 'Admin/Addons/adminList', '插件后台列表', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('53', 'admin', '1', 'Admin/Addons/execute', 'URL方式访问插件', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('54', 'admin', '1', 'Admin/Addons/index', '插件管理', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('55', 'admin', '1', 'Admin/Addons/hooks', '钩子管理', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('56', 'admin', '1', 'Admin/model/add', '新增', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('57', 'admin', '1', 'Admin/model/edit', '编辑', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('58', 'admin', '1', 'Admin/model/setStatus', '改变状态', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('59', 'admin', '1', 'Admin/model/update', '保存数据', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('60', 'admin', '1', 'Admin/Model/index', '模型管理', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('61', 'admin', '1', 'Admin/Config/edit', '编辑', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('62', 'admin', '1', 'Admin/Config/del', '删除', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('63', 'admin', '1', 'Admin/Config/add', '新增', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('64', 'admin', '1', 'Admin/Config/save', '保存', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('65', 'admin', '1', 'Admin/Config/group', '网站设置', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('66', 'admin', '1', 'Admin/Config/index', '配置管理', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('67', 'admin', '1', 'Admin/Channel/add', '新增', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('68', 'admin', '1', 'Admin/Channel/edit', '编辑', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('69', 'admin', '1', 'Admin/Channel/del', '删除', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('70', 'admin', '1', 'Admin/Channel/index', '导航管理', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('71', 'admin', '1', 'Admin/Category/edit', '编辑', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('72', 'admin', '1', 'Admin/Category/add', '新增', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('73', 'admin', '1', 'Admin/Category/remove', '删除', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('74', 'admin', '1', 'Admin/Category/index', '分类管理', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('75', 'admin', '1', 'Admin/file/upload', '上传控件', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('76', 'admin', '1', 'Admin/file/uploadPicture', '上传图片', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('77', 'admin', '1', 'Admin/file/download', '下载', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('94', 'admin', '1', 'Admin/AuthManager/modelauth', '模型授权', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('79', 'admin', '1', 'Admin/article/batchOperate', '导入', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('80', 'admin', '1', 'Admin/Database/index?type=export', '备份数据库', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('81', 'admin', '1', 'Admin/Database/index?type=import', '还原数据库', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('82', 'admin', '1', 'Admin/Database/export', '备份', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('83', 'admin', '1', 'Admin/Database/optimize', '优化表', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('84', 'admin', '1', 'Admin/Database/repair', '修复表', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('86', 'admin', '1', 'Admin/Database/import', '恢复', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('87', 'admin', '1', 'Admin/Database/del', '删除', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('88', 'admin', '1', 'Admin/User/add', '  增加管理用户', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('89', 'admin', '1', 'Admin/Attribute/index', '属性管理', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('90', 'admin', '1', 'Admin/Attribute/add', '新增', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('91', 'admin', '1', 'Admin/Attribute/edit', '编辑', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('92', 'admin', '1', 'Admin/Attribute/setStatus', '改变状态', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('93', 'admin', '1', 'Admin/Attribute/update', '保存数据', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('95', 'admin', '1', 'Admin/AuthManager/addToModel', '保存模型授权', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('96', 'admin', '1', 'Admin/Category/move', '移动', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('97', 'admin', '1', 'Admin/Category/merge', '合并', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('98', 'admin', '1', 'Admin/Config/menu', '后台菜单管理', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('99', 'admin', '1', 'Admin/Article/mydocument', '内容', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('100', 'admin', '1', 'Admin/Menu/index', '菜单管理', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('101', 'admin', '1', 'Admin/other', '其他', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('102', 'admin', '1', 'Admin/Menu/add', '新增', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('103', 'admin', '1', 'Admin/Menu/edit', '编辑', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('104', 'admin', '1', 'Admin/Think/lists?model=article', '文章管理', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('105', 'admin', '1', 'Admin/Think/lists?model=download', '下载管理', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('106', 'admin', '1', 'Admin/Think/lists?model=config', '配置管理', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('107', 'admin', '1', 'Admin/Action/actionlog', '行为日志', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('108', 'admin', '1', 'Admin/User/updatePassword', '修改密码', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('109', 'admin', '1', 'Admin/User/updateNickname', '修改昵称', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('110', 'admin', '1', 'Admin/action/edit', '查看行为日志', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('205', 'admin', '1', 'Admin/think/add', '新增数据', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('111', 'admin', '2', 'Admin/article/index', '文档列表', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('112', 'admin', '2', 'Admin/article/add', '新增', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('113', 'admin', '2', 'Admin/article/edit', '编辑', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('114', 'admin', '2', 'Admin/article/setStatus', '改变状态', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('115', 'admin', '2', 'Admin/article/update', '保存', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('116', 'admin', '2', 'Admin/article/autoSave', '保存草稿', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('117', 'admin', '2', 'Admin/article/move', '移动', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('118', 'admin', '2', 'Admin/article/copy', '复制', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('119', 'admin', '2', 'Admin/article/paste', '粘贴', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('120', 'admin', '2', 'Admin/article/batchOperate', '导入', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('121', 'admin', '2', 'Admin/article/recycle', '回收站', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('122', 'admin', '2', 'Admin/article/permit', '还原', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('123', 'admin', '2', 'Admin/article/clear', '清空', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('124', 'admin', '2', 'Admin/User/add', '新增用户', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('125', 'admin', '2', 'Admin/User/action', '用户行为', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('126', 'admin', '2', 'Admin/User/addAction', '新增用户行为', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('127', 'admin', '2', 'Admin/User/editAction', '编辑用户行为', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('128', 'admin', '2', 'Admin/User/saveAction', '保存用户行为', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('129', 'admin', '2', 'Admin/User/setStatus', '变更行为状态', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('130', 'admin', '2', 'Admin/User/changeStatus?method=forbidUser', '禁用会员', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('131', 'admin', '2', 'Admin/User/changeStatus?method=resumeUser', '启用会员', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('132', 'admin', '2', 'Admin/User/changeStatus?method=deleteUser', '删除会员', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('133', 'admin', '2', 'Admin/AuthManager/index', '权限管理', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('134', 'admin', '2', 'Admin/AuthManager/changeStatus?method=deleteGroup', '删除', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('135', 'admin', '2', 'Admin/AuthManager/changeStatus?method=forbidGroup', '禁用', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('136', 'admin', '2', 'Admin/AuthManager/changeStatus?method=resumeGroup', '恢复', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('137', 'admin', '2', 'Admin/AuthManager/createGroup', '新增', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('138', 'admin', '2', 'Admin/AuthManager/editGroup', '编辑', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('139', 'admin', '2', 'Admin/AuthManager/writeGroup', '保存用户组', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('140', 'admin', '2', 'Admin/AuthManager/group', '授权', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('141', 'admin', '2', 'Admin/AuthManager/access', '访问授权', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('142', 'admin', '2', 'Admin/AuthManager/user', '成员授权', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('143', 'admin', '2', 'Admin/AuthManager/removeFromGroup', '解除授权', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('144', 'admin', '2', 'Admin/AuthManager/addToGroup', '保存成员授权', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('145', 'admin', '2', 'Admin/AuthManager/category', '分类授权', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('146', 'admin', '2', 'Admin/AuthManager/addToCategory', '保存分类授权', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('147', 'admin', '2', 'Admin/AuthManager/modelauth', '模型授权', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('148', 'admin', '2', 'Admin/AuthManager/addToModel', '保存模型授权', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('149', 'admin', '2', 'Admin/Addons/create', '创建', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('150', 'admin', '2', 'Admin/Addons/checkForm', '检测创建', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('151', 'admin', '2', 'Admin/Addons/preview', '预览', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('152', 'admin', '2', 'Admin/Addons/build', '快速生成插件', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('153', 'admin', '2', 'Admin/Addons/config', '设置', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('154', 'admin', '2', 'Admin/Addons/disable', '禁用', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('155', 'admin', '2', 'Admin/Addons/enable', '启用', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('156', 'admin', '2', 'Admin/Addons/install', '安装', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('157', 'admin', '2', 'Admin/Addons/uninstall', '卸载', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('158', 'admin', '2', 'Admin/Addons/saveconfig', '更新配置', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('159', 'admin', '2', 'Admin/Addons/adminList', '插件后台列表', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('160', 'admin', '2', 'Admin/Addons/execute', 'URL方式访问插件', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('161', 'admin', '2', 'Admin/Addons/hooks', '钩子管理', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('162', 'admin', '2', 'Admin/Model/index', '模型管理', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('163', 'admin', '2', 'Admin/model/add', '新增', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('164', 'admin', '2', 'Admin/model/edit', '编辑', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('165', 'admin', '2', 'Admin/model/setStatus', '改变状态', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('166', 'admin', '2', 'Admin/model/update', '保存数据', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('167', 'admin', '2', 'Admin/Attribute/index', '属性管理', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('168', 'admin', '2', 'Admin/Attribute/add', '新增', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('169', 'admin', '2', 'Admin/Attribute/edit', '编辑', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('170', 'admin', '2', 'Admin/Attribute/setStatus', '改变状态', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('171', 'admin', '2', 'Admin/Attribute/update', '保存数据', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('172', 'admin', '2', 'Admin/Config/index', '配置管理', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('173', 'admin', '2', 'Admin/Config/edit', '编辑', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('174', 'admin', '2', 'Admin/Config/del', '删除', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('175', 'admin', '2', 'Admin/Config/add', '新增', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('176', 'admin', '2', 'Admin/Config/save', '保存', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('177', 'admin', '2', 'Admin/Menu/index', '菜单管理', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('178', 'admin', '2', 'Admin/Channel/index', '导航管理', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('179', 'admin', '2', 'Admin/Channel/add', '新增', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('180', 'admin', '2', 'Admin/Channel/edit', '编辑', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('181', 'admin', '2', 'Admin/Channel/del', '删除', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('182', 'admin', '2', 'Admin/Category/index', '分类管理', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('183', 'admin', '2', 'Admin/Category/edit', '编辑', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('184', 'admin', '2', 'Admin/Category/add', '新增', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('185', 'admin', '2', 'Admin/Category/remove', '删除', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('186', 'admin', '2', 'Admin/Category/move', '移动', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('187', 'admin', '2', 'Admin/Category/merge', '合并', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('188', 'admin', '2', 'Admin/Database/index?type=export', '备份数据库', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('189', 'admin', '2', 'Admin/Database/export', '备份', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('190', 'admin', '2', 'Admin/Database/optimize', '优化表', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('191', 'admin', '2', 'Admin/Database/repair', '修复表', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('192', 'admin', '2', 'Admin/Database/index?type=import', '还原数据库', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('193', 'admin', '2', 'Admin/Database/import', '恢复', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('194', 'admin', '2', 'Admin/Database/del', '删除', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('195', 'admin', '2', 'Admin/other', '其他', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('196', 'admin', '2', 'Admin/Menu/add', '新增', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('197', 'admin', '2', 'Admin/Menu/edit', '编辑', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('198', 'admin', '2', 'Admin/Think/lists?model=article', '应用', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('199', 'admin', '2', 'Admin/Think/lists?model=download', '下载管理', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('200', 'admin', '2', 'Admin/Think/lists?model=config', '应用', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('201', 'admin', '2', 'Admin/Action/actionlog', '行为日志', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('202', 'admin', '2', 'Admin/User/updatePassword', '修改密码', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('203', 'admin', '2', 'Admin/User/updateNickname', '修改昵称', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('204', 'admin', '2', 'Admin/action/edit', '查看行为日志', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('206', 'admin', '1', 'Admin/think/edit', '编辑数据', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('207', 'admin', '1', 'Admin/Menu/import', '导入', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('208', 'admin', '1', 'Admin/Model/generate', '生成', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('209', 'admin', '1', 'Admin/Addons/addHook', '新增钩子', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('210', 'admin', '1', 'Admin/Addons/edithook', '编辑钩子', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('211', 'admin', '1', 'Admin/Article/sort', '文档排序', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('212', 'admin', '1', 'Admin/Config/sort', '排序', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('213', 'admin', '1', 'Admin/Menu/sort', '排序', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('214', 'admin', '1', 'Admin/Channel/sort', '排序', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('215', 'admin', '1', 'Admin/Category/operate/type/move', '移动', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('216', 'admin', '1', 'Admin/Category/operate/type/merge', '合并', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('217', 'admin', '1', 'Admin/Weixin/subscribe', '关注回复', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('218', 'admin', '1', 'Admin/Weixin/menu', '菜单管理', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('219', 'admin', '1', 'Admin/Weixin/keywords', '关键字设置', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('220', 'admin', '1', 'Admin/Weixin/addmenu', '新增菜单', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('221', 'admin', '1', 'Admin/Weixin/editmenu', '编辑菜单', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('222', 'admin', '1', 'Admin/Weixin/addkeywords', '新增关键字', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('223', 'admin', '1', 'Admin/Weixin/editkeywords', '编辑关键字', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('224', 'admin', '1', 'Admin/Feedback/technology', '技术问题', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('225', 'admin', '1', 'Admin/Feedback/product', '产品问题', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('226', 'admin', '1', 'Admin/Feedback/experience', '用户体验', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('227', 'admin', '1', 'Admin/Member/Weixinuser', '关注用户', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('228', 'admin', '1', 'Admin/Member/subscribe', '邮件订阅', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('229', 'admin', '1', 'Admin/Member/setreg', '添加注册用户', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('230', 'admin', '1', 'Admin/Member/edit', '编辑用户信息', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('231', 'admin', '2', 'Admin/Article/index?cate_id=1', '内容', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('232', 'admin', '2', 'Admin/Weixin/subscribe', '微信', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('233', 'admin', '2', 'Admin/Member/index?gid=1', '用户', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('234', 'admin', '1', 'Admin/Member/index?gid=1', '普通用户', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('235', 'admin', '1', 'Admin/Member/index?gid=2', '内部用户', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('236', 'admin', '1', 'Admin/Member/view', '查看用户详细页', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('237', 'admin', '1', 'Admin/Member/getcode', '用户申请', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('238', 'admin', '2', 'Admin/Home/Index/index', '微网站', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('239', 'admin', '1', 'Admin/Weixin/chat', '微信信息记录', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('240', 'admin', '1', 'Admin/Member/Addcustomer', '增加客户', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('241', 'admin', '1', 'Admin/Member/Editcustomer', '编辑客户资料', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('242', 'admin', '1', 'Admin/Member/viewcustomer', '查看客户资料', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('243', 'admin', '1', 'Admin/Feedback/view', '用户信息反馈预览', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('244', 'admin', '1', 'Admin/Member/customer', '客户资料', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('245', 'admin', '2', 'Admin/Article/index?cate_id=2', '内容', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('246', 'admin', '1', 'Admin/Weixin/createmenu', '生成微信菜单', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('247', 'admin', '1', 'Admin/Company/index', '公司管理', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('248', 'admin', '1', 'Admin/Company/add', '增加公司或部门', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('249', 'admin', '1', 'Admin/Company/edit', '修改公司或部门', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('250', 'admin', '1', 'Admin/Label/index', '用户标签管理', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('251', 'admin', '1', 'Admin/Label/add', '增加用户标签', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('252', 'admin', '1', 'Admin/Label/edit', '修改用户标签', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('253', 'admin', '1', 'Admin/Productkey/index', '产品问题关键词', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('254', 'admin', '1', 'Admin/Productkey/add', '增加产品问题关键词', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('255', 'admin', '1', 'Admin/Productkey/edit', '编辑产品问题关键词', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('256', 'admin', '1', 'Admin/Technologykey/index', '技术问题关键词', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('257', 'admin', '1', 'Admin/Technologykey/add', '新增技术问题关键词', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('258', 'admin', '1', 'Admin/Technologykey/edit', '编辑技术问题关键词', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('259', 'admin', '1', 'Admin/Label/view', '标签用户列表', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('260', 'admin', '1', 'Admin/Productkey/problemlist', '关键词问题列表', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('261', 'admin', '1', 'Admin/Technologykey/problemlist', '关键词问题列表', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('262', 'admin', '1', 'Admin/Member/state', '用户通用状态处理', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('263', 'admin', '1', 'Admin/Member/deletedo', '用户通用删除', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('264', 'admin', '1', 'Admin/Member/dodelete', '用户通用批量删除', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('265', 'admin', '1', 'Admin/Feedback/deletedo', '反馈信息通用删除', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('266', 'admin', '1', 'Admin/Feedback/state', '反馈信息通用状态设置', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('267', 'admin', '1', 'Admin/Feedback/dolete', '用户信息反馈通用批量删除', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('268', 'admin', '1', 'Admin/Weixin/Stateset', '微信通用删除', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('269', 'admin', '1', 'Admin/Company/update', '增加或修改公司。部门', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('270', 'admin', '1', 'Admin/Label/update', '增加或修改用户标签', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('271', 'admin', '1', 'Admin/Product/update', '增加或修改产品问题关键词', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('272', 'admin', '1', 'Admin/Technologykey/update', '技术问题关键词', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('273', 'admin', '1', 'Admin/Member/check', '用户申请审核', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('274', 'admin', '1', 'Admin/Label/deatil', '查看标签下的用户', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('275', 'admin', '1', 'Admin/Product/detail', '关键词下的用户列表', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('276', 'admin', '1', 'Admin/Technology/detail', '关键词下的问题', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('277', 'admin', '1', 'Admin/Label/detail', '查看标签下的用户', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('278', 'admin', '1', 'Admin/Productkey/update', '增加或修改产品问题关键词', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('279', 'admin', '1', 'Admin/Productkey/detail', '关键词下的问题列表', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('280', 'admin', '1', 'Admin/Technologykey/detail', '关键词下的问题列表', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('281', 'admin', '1', 'Admin/Productkey/remove', '从关键词中移除', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('282', 'admin', '1', 'Admin/Label/remove', '从标签中移除', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('283', 'admin', '1', 'Admin/Technology/remove', '从关键词中移除', '-1', '');
INSERT INTO `cst_auth_rule` VALUES ('284', 'admin', '1', 'Admin/Technologykey/remove', '从关键词中移除', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('285', 'admin', '1', 'Admin/Productkey/view', '查看关键词问题', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('286', 'admin', '1', 'Admin/Technologykey/view', '查看关键词问题', '1', '');
INSERT INTO `cst_auth_rule` VALUES ('287', 'admin', '2', 'Admin/Member/Weixinuser', '用户', '1', '');

-- ----------------------------
-- Table structure for `cst_category`
-- ----------------------------
DROP TABLE IF EXISTS `cst_category`;
CREATE TABLE `cst_category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '分类ID',
  `name` varchar(30) NOT NULL COMMENT '标志',
  `title` varchar(50) NOT NULL COMMENT '标题',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级分类ID',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序（同级有效）',
  `list_row` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '列表每页行数',
  `meta_title` varchar(50) NOT NULL DEFAULT '' COMMENT 'SEO的网页标题',
  `keywords` varchar(255) NOT NULL DEFAULT '' COMMENT '关键字',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '描述',
  `template_index` varchar(100) NOT NULL COMMENT '频道页模板',
  `template_lists` varchar(100) NOT NULL COMMENT '列表页模板',
  `template_detail` varchar(100) NOT NULL COMMENT '详情页模板',
  `template_edit` varchar(100) NOT NULL COMMENT '编辑页模板',
  `model` varchar(100) NOT NULL DEFAULT '' COMMENT '关联模型',
  `type` varchar(100) NOT NULL DEFAULT '' COMMENT '允许发布的内容类型',
  `link_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '外链',
  `allow_publish` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否允许发布内容',
  `display` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '可见性',
  `reply` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否允许回复',
  `check` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '发布的文章是否需要审核',
  `reply_model` varchar(100) NOT NULL DEFAULT '',
  `extend` text NOT NULL COMMENT '扩展设置',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '数据状态',
  `icon` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '分类图标',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_name` (`name`),
  KEY `pid` (`pid`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='分类表';

-- ----------------------------
-- Records of cst_category
-- ----------------------------
INSERT INTO `cst_category` VALUES ('2', 'technology', '技术动态', '0', '0', '10', '', '', '', '', '', '', '', '2', '3', '0', '1', '1', '1', '0', '', '', '1415872043', '1417594472', '1', '0');
INSERT INTO `cst_category` VALUES ('3', 'resource', '技术资料', '0', '0', '1', '', '', '', '', 'resource', '', '', '3', '3', '0', '1', '1', '1', '0', '', '', '1415872066', '1417670202', '1', '0');
INSERT INTO `cst_category` VALUES ('4', 'slide', '幻灯片列表', '0', '0', '10', '', '', '', '', '', '', '', '2', '3', '0', '1', '1', '1', '0', '', '', '1417593355', '1417594457', '1', '0');
INSERT INTO `cst_category` VALUES ('5', 'product', '产品管理', '0', '0', '10', '', '', '', '', '', '', '', '5', '3', '0', '1', '1', '1', '0', '', '', '1417656240', '1417656240', '1', '0');
INSERT INTO `cst_category` VALUES ('6', 'ICDSys', 'ICDSys', '3', '0', '10', '', '', '', '', '', '', '', '3', '3', '0', '1', '1', '1', '0', '', '', '1417670766', '1417670805', '1', '0');
INSERT INTO `cst_category` VALUES ('7', 'SMod', 'SMod', '3', '0', '10', '', '', '', '', '', '', '', '3', '3', '0', '1', '1', '1', '0', '', '', '1417670821', '1417670821', '1', '0');
INSERT INTO `cst_category` VALUES ('8', 'SSim', 'SSim', '3', '0', '10', '', '', '', '', '', '', '', '3', '3', '0', '1', '1', '1', '0', '', '', '1417670844', '1417670844', '1', '0');

-- ----------------------------
-- Table structure for `cst_channel`
-- ----------------------------
DROP TABLE IF EXISTS `cst_channel`;
CREATE TABLE `cst_channel` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '频道ID',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级频道ID',
  `title` char(30) NOT NULL COMMENT '频道标题',
  `url` char(100) NOT NULL COMMENT '频道连接',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '导航排序',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态',
  `target` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '新窗口打开',
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cst_channel
-- ----------------------------
INSERT INTO `cst_channel` VALUES ('1', '0', '首页', 'Index/index', '1', '1379475111', '1379923177', '1', '0');
INSERT INTO `cst_channel` VALUES ('2', '0', '博客', 'Article/index?category=blog', '2', '1379475131', '1379483713', '1', '0');
INSERT INTO `cst_channel` VALUES ('3', '0', '官网', 'http://www.onethink.cn', '3', '1379475154', '1387163458', '1', '0');

-- ----------------------------
-- Table structure for `cst_chat`
-- ----------------------------
DROP TABLE IF EXISTS `cst_chat`;
CREATE TABLE `cst_chat` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文档ID',
  `content` varchar(255) NOT NULL COMMENT '信息',
  `openid` varchar(60) NOT NULL DEFAULT '0' COMMENT '是否仅开发者模式可见',
  `create_time` int(11) NOT NULL COMMENT '信息时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=124 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cst_chat
-- ----------------------------
INSERT INTO `cst_chat` VALUES ('1', '4', 'o2AIEtzDbzdvaFHmaPk2pdTwxQbM', '1418702180');
INSERT INTO `cst_chat` VALUES ('2', '@魏永', 'o2AIEtzDbzdvaFHmaPk2pdTwxQbM', '1418702234');
INSERT INTO `cst_chat` VALUES ('3', '4', 'o2AIEtzDbzdvaFHmaPk2pdTwxQbM', '1418711315');
INSERT INTO `cst_chat` VALUES ('4', '技术资料', 'o2AIEtzDbzdvaFHmaPk2pdTwxQbM', '1418711349');
INSERT INTO `cst_chat` VALUES ('5', '技术咨询', 'o2AIEtzDbzdvaFHmaPk2pdTwxQbM', '1418711362');
INSERT INTO `cst_chat` VALUES ('6', '技术反馈', 'o2AIEtzDbzdvaFHmaPk2pdTwxQbM', '1418711384');
INSERT INTO `cst_chat` VALUES ('7', '产品反馈', 'o2AIEtzDbzdvaFHmaPk2pdTwxQbM', '1418711395');
INSERT INTO `cst_chat` VALUES ('8', '技术咨询', 'o2AIEtzDbzdvaFHmaPk2pdTwxQbM', '1418711445');
INSERT INTO `cst_chat` VALUES ('9', '技术咨询', 'o2AIEtzDbzdvaFHmaPk2pdTwxQbM', '1418711505');
INSERT INTO `cst_chat` VALUES ('10', '@白林', 'o2AIEtzDbzdvaFHmaPk2pdTwxQbM', '1418712107');
INSERT INTO `cst_chat` VALUES ('11', '你好', 'o2AIEt2XYFKtedwQnZCP5QRPEZgU', '1418712670');
INSERT INTO `cst_chat` VALUES ('12', '1', 'o2AIEt2XYFKtedwQnZCP5QRPEZgU', '1418712734');
INSERT INTO `cst_chat` VALUES ('13', '4', 'o2AIEt2XYFKtedwQnZCP5QRPEZgU', '1418712747');
INSERT INTO `cst_chat` VALUES ('14', '查询', 'o2AIEt2XYFKtedwQnZCP5QRPEZgU', '1418712943');
INSERT INTO `cst_chat` VALUES ('15', '@章磊', 'o2AIEt2XYFKtedwQnZCP5QRPEZgU', '1418713193');
INSERT INTO `cst_chat` VALUES ('16', '@你', 'o2AIEt2XYFKtedwQnZCP5QRPEZgU', '1418713206');
INSERT INTO `cst_chat` VALUES ('17', '@白林', 'o2AIEt2XYFKtedwQnZCP5QRPEZgU', '1418713302');
INSERT INTO `cst_chat` VALUES ('18', '@白', 'o2AIEt2XYFKtedwQnZCP5QRPEZgU', '1418713507');
INSERT INTO `cst_chat` VALUES ('19', '？', 'o2AIEt2XYFKtedwQnZCP5QRPEZgU', '1418713621');
INSERT INTO `cst_chat` VALUES ('20', '技术咨询', 'o2AIEt2XYFKtedwQnZCP5QRPEZgU', '1418713909');
INSERT INTO `cst_chat` VALUES ('21', '文本1', 'o2AIEt51Pvfwp8nEwIpkATP154uI', '1418714408');
INSERT INTO `cst_chat` VALUES ('22', '我的', 'o2AIEt51Pvfwp8nEwIpkATP154uI', '1418714420');
INSERT INTO `cst_chat` VALUES ('23', '1', 'o2AIEt5WbnzZxoIwqeTG80Yk7KjU', '1418714801');
INSERT INTO `cst_chat` VALUES ('24', '2', 'o2AIEtxujf5S6nPN48O8ZR3TUs4U', '1418714884');
INSERT INTO `cst_chat` VALUES ('25', '@高平', 'o2AIEtxujf5S6nPN48O8ZR3TUs4U', '1418716206');
INSERT INTO `cst_chat` VALUES ('26', '@高平', 'o2AIEt2XYFKtedwQnZCP5QRPEZgU', '1418722776');
INSERT INTO `cst_chat` VALUES ('27', '@高平', 'o2AIEt5WbnzZxoIwqeTG80Yk7KjU', '1418722789');
INSERT INTO `cst_chat` VALUES ('28', '@高平', 'o2AIEt5WbnzZxoIwqeTG80Yk7KjU', '1418722955');
INSERT INTO `cst_chat` VALUES ('29', '@高平', 'o2AIEtzDbzdvaFHmaPk2pdTwxQbM', '1418723021');
INSERT INTO `cst_chat` VALUES ('30', '@高平', 'o2AIEtzDbzdvaFHmaPk2pdTwxQbM', '1418725117');
INSERT INTO `cst_chat` VALUES ('31', '@高平', 'o2AIEtzDbzdvaFHmaPk2pdTwxQbM', '1418725175');
INSERT INTO `cst_chat` VALUES ('32', '1', 'o2AIEtzDbzdvaFHmaPk2pdTwxQbM', '1418816314');
INSERT INTO `cst_chat` VALUES ('33', 'w', 'o2AIEtzDbzdvaFHmaPk2pdTwxQbM', '1418816322');
INSERT INTO `cst_chat` VALUES ('34', '3', 'o2AIEtzDbzdvaFHmaPk2pdTwxQbM', '1418816325');
INSERT INTO `cst_chat` VALUES ('35', '2', 'o2AIEtzDbzdvaFHmaPk2pdTwxQbM', '1418816330');
INSERT INTO `cst_chat` VALUES ('36', '2', 'o2AIEtzDbzdvaFHmaPk2pdTwxQbM', '1418816397');
INSERT INTO `cst_chat` VALUES ('37', '2', 'o2AIEtzDbzdvaFHmaPk2pdTwxQbM', '1418816667');
INSERT INTO `cst_chat` VALUES ('38', '1', 'o2AIEtzDbzdvaFHmaPk2pdTwxQbM', '1418816702');
INSERT INTO `cst_chat` VALUES ('39', '?', 'o2AIEtzDbzdvaFHmaPk2pdTwxQbM', '1418816893');
INSERT INTO `cst_chat` VALUES ('40', '1', 'o2AIEtzDbzdvaFHmaPk2pdTwxQbM', '1418816898');
INSERT INTO `cst_chat` VALUES ('41', 'G', 'o2AIEtzDbzdvaFHmaPk2pdTwxQbM', '1418816904');
INSERT INTO `cst_chat` VALUES ('42', 'G', 'o2AIEtzDbzdvaFHmaPk2pdTwxQbM', '1418816984');
INSERT INTO `cst_chat` VALUES ('43', 'G', 'o2AIEtzDbzdvaFHmaPk2pdTwxQbM', '1418817092');
INSERT INTO `cst_chat` VALUES ('44', '1', 'o2AIEtzDbzdvaFHmaPk2pdTwxQbM', '1418818242');
INSERT INTO `cst_chat` VALUES ('45', '@魏永', 'o2AIEtzDbzdvaFHmaPk2pdTwxQbM', '1418820033');
INSERT INTO `cst_chat` VALUES ('46', '？', 'o2AIEtzDbzdvaFHmaPk2pdTwxQbM', '1418820046');
INSERT INTO `cst_chat` VALUES ('47', 'B', 'o2AIEtzDbzdvaFHmaPk2pdTwxQbM', '1418820054');
INSERT INTO `cst_chat` VALUES ('48', '3', 'o2AIEtzDbzdvaFHmaPk2pdTwxQbM', '1418820190');
INSERT INTO `cst_chat` VALUES ('49', 'D', 'o2AIEtzDbzdvaFHmaPk2pdTwxQbM', '1418820511');
INSERT INTO `cst_chat` VALUES ('50', 'E', 'o2AIEtzDbzdvaFHmaPk2pdTwxQbM', '1418820541');
INSERT INTO `cst_chat` VALUES ('51', 'G', 'o2AIEtzDbzdvaFHmaPk2pdTwxQbM', '1418820598');
INSERT INTO `cst_chat` VALUES ('52', '@魏永', 'o2AIEt9uAWZ5HDd2-vl0D_s6VfkU', '1418821347');
INSERT INTO `cst_chat` VALUES ('53', '@魏永', 'o2AIEt9uAWZ5HDd2-vl0D_s6VfkU', '1418821410');
INSERT INTO `cst_chat` VALUES ('54', '@魏永', 'o2AIEt9uAWZ5HDd2-vl0D_s6VfkU', '1418821508');
INSERT INTO `cst_chat` VALUES ('55', '菜单', 'o2AIEt2XYFKtedwQnZCP5QRPEZgU', '1418826026');
INSERT INTO `cst_chat` VALUES ('56', 'A', 'o2AIEt2XYFKtedwQnZCP5QRPEZgU', '1418826037');
INSERT INTO `cst_chat` VALUES ('57', 'B', 'o2AIEt2XYFKtedwQnZCP5QRPEZgU', '1418826046');
INSERT INTO `cst_chat` VALUES ('58', '？', 'o2AIEt2XYFKtedwQnZCP5QRPEZgU', '1418826054');
INSERT INTO `cst_chat` VALUES ('59', '而', 'o2AIEt2XYFKtedwQnZCP5QRPEZgU', '1418826059');
INSERT INTO `cst_chat` VALUES ('60', 'G', 'o2AIEt2XYFKtedwQnZCP5QRPEZgU', '1418826073');
INSERT INTO `cst_chat` VALUES ('61', 'H', 'o2AIEt2XYFKtedwQnZCP5QRPEZgU', '1418826078');
INSERT INTO `cst_chat` VALUES ('62', '你好', 'o2AIEt2XYFKtedwQnZCP5QRPEZgU', '1418826090');
INSERT INTO `cst_chat` VALUES ('63', 'F', 'o2AIEt2XYFKtedwQnZCP5QRPEZgU', '1418826100');
INSERT INTO `cst_chat` VALUES ('64', '3', 'o2AIEtzDbzdvaFHmaPk2pdTwxQbM', '1418831795');
INSERT INTO `cst_chat` VALUES ('65', 'E', 'o2AIEtzDbzdvaFHmaPk2pdTwxQbM', '1418831807');
INSERT INTO `cst_chat` VALUES ('66', '好画画', 'o2AIEt0D9oyUQq38k_6ybqauiCSw', '1418867464');
INSERT INTO `cst_chat` VALUES ('67', 'c', 'o2AIEt0D9oyUQq38k_6ybqauiCSw', '1418868054');
INSERT INTO `cst_chat` VALUES ('68', '@魏永', 'o2AIEtzDbzdvaFHmaPk2pdTwxQbM', '1418868158');
INSERT INTO `cst_chat` VALUES ('69', '1', 'o2AIEt2XYFKtedwQnZCP5QRPEZgU', '1418871357');
INSERT INTO `cst_chat` VALUES ('70', '1', 'o2AIEt5WbnzZxoIwqeTG80Yk7KjU', '1418871360');
INSERT INTO `cst_chat` VALUES ('71', '1', 'o2AIEtxujf5S6nPN48O8ZR3TUs4U', '1418871366');
INSERT INTO `cst_chat` VALUES ('72', '1', 'o2AIEt9zyg_iQDcH8yODyXoxMP6k', '1418871380');
INSERT INTO `cst_chat` VALUES ('73', '1', 'o2AIEt1WMLxNvxK6G2oFHnVxy8OM', '1418871404');
INSERT INTO `cst_chat` VALUES ('74', '1', 'o2AIEt0D9oyUQq38k_6ybqauiCSw', '1418871479');
INSERT INTO `cst_chat` VALUES ('75', '3', 'o2AIEt0D9oyUQq38k_6ybqauiCSw', '1418871483');
INSERT INTO `cst_chat` VALUES ('76', '1', 'o2AIEtzDbzdvaFHmaPk2pdTwxQbM', '1418871678');
INSERT INTO `cst_chat` VALUES ('77', '1', 'o2AIEt8DEwawpypoHs0b5O8QgG3c', '1418871835');
INSERT INTO `cst_chat` VALUES ('78', '3', 'o2AIEt8DEwawpypoHs0b5O8QgG3c', '1418871941');
INSERT INTO `cst_chat` VALUES ('79', '@李晋', 'o2AIEt5WbnzZxoIwqeTG80Yk7KjU', '1418872214');
INSERT INTO `cst_chat` VALUES ('80', '@魏晨', 'o2AIEtxujf5S6nPN48O8ZR3TUs4U', '1418872232');
INSERT INTO `cst_chat` VALUES ('81', '@毛小毛', 'o2AIEtxujf5S6nPN48O8ZR3TUs4U', '1418872246');
INSERT INTO `cst_chat` VALUES ('82', 'B', 'o2AIEt8DEwawpypoHs0b5O8QgG3c', '1418872259');
INSERT INTO `cst_chat` VALUES ('83', '？', 'o2AIEt2XYFKtedwQnZCP5QRPEZgU', '1418872625');
INSERT INTO `cst_chat` VALUES ('84', 'C', 'o2AIEt2XYFKtedwQnZCP5QRPEZgU', '1418872637');
INSERT INTO `cst_chat` VALUES ('85', 'a', 'o2AIEt0D9oyUQq38k_6ybqauiCSw', '1418872658');
INSERT INTO `cst_chat` VALUES ('86', 'b', 'o2AIEt0D9oyUQq38k_6ybqauiCSw', '1418872687');
INSERT INTO `cst_chat` VALUES ('87', 'B', 'o2AIEt2XYFKtedwQnZCP5QRPEZgU', '1418872690');
INSERT INTO `cst_chat` VALUES ('88', '1', 'o2AIEt5WbnzZxoIwqeTG80Yk7KjU', '1418872747');
INSERT INTO `cst_chat` VALUES ('89', 'B', 'o2AIEt8DEwawpypoHs0b5O8QgG3c', '1418872852');
INSERT INTO `cst_chat` VALUES ('90', 'B', 'o2AIEtzDbzdvaFHmaPk2pdTwxQbM', '1418872861');
INSERT INTO `cst_chat` VALUES ('91', '3', 'o2AIEtxujf5S6nPN48O8ZR3TUs4U', '1418872883');
INSERT INTO `cst_chat` VALUES ('92', 'b', 'o2AIEtxujf5S6nPN48O8ZR3TUs4U', '1418872890');
INSERT INTO `cst_chat` VALUES ('93', 'E', 'o2AIEt2XYFKtedwQnZCP5QRPEZgU', '1418872901');
INSERT INTO `cst_chat` VALUES ('94', 'c', 'o2AIEtxujf5S6nPN48O8ZR3TUs4U', '1418873043');
INSERT INTO `cst_chat` VALUES ('95', 'd', 'o2AIEtxujf5S6nPN48O8ZR3TUs4U', '1418873086');
INSERT INTO `cst_chat` VALUES ('96', '3', 'o2AIEt5WbnzZxoIwqeTG80Yk7KjU', '1418873098');
INSERT INTO `cst_chat` VALUES ('97', 'b', 'o2AIEt5WbnzZxoIwqeTG80Yk7KjU', '1418873119');
INSERT INTO `cst_chat` VALUES ('98', 'h', 'o2AIEt5WbnzZxoIwqeTG80Yk7KjU', '1418873122');
INSERT INTO `cst_chat` VALUES ('99', '2', 'o2AIEt5WbnzZxoIwqeTG80Yk7KjU', '1418873178');
INSERT INTO `cst_chat` VALUES ('100', 'e', 'o2AIEtxujf5S6nPN48O8ZR3TUs4U', '1418873203');
INSERT INTO `cst_chat` VALUES ('101', 'f', 'o2AIEtxujf5S6nPN48O8ZR3TUs4U', '1418873292');
INSERT INTO `cst_chat` VALUES ('102', 'g', 'o2AIEtxujf5S6nPN48O8ZR3TUs4U', '1418873300');
INSERT INTO `cst_chat` VALUES ('103', '你e', 'o2AIEt2XYFKtedwQnZCP5QRPEZgU', '1418873319');
INSERT INTO `cst_chat` VALUES ('104', '菜单', 'o2AIEt5WbnzZxoIwqeTG80Yk7KjU', '1418873326');
INSERT INTO `cst_chat` VALUES ('105', '天气', 'o2AIEt5WbnzZxoIwqeTG80Yk7KjU', '1418873335');
INSERT INTO `cst_chat` VALUES ('106', '淡淡的', 'o2AIEt5WbnzZxoIwqeTG80Yk7KjU', '1418873347');
INSERT INTO `cst_chat` VALUES ('107', 'hhhjjkkk', 'o2AIEt0D9oyUQq38k_6ybqauiCSw', '1418873352');
INSERT INTO `cst_chat` VALUES ('108', '欢迎', 'o2AIEt5WbnzZxoIwqeTG80Yk7KjU', '1418873379');
INSERT INTO `cst_chat` VALUES ('109', '@高平', 'o2AIEtxujf5S6nPN48O8ZR3TUs4U', '1418873406');
INSERT INTO `cst_chat` VALUES ('110', '@高', 'o2AIEt2XYFKtedwQnZCP5QRPEZgU', '1418873409');
INSERT INTO `cst_chat` VALUES ('111', '@李晋  ok', 'o2AIEt8DEwawpypoHs0b5O8QgG3c', '1418873422');
INSERT INTO `cst_chat` VALUES ('112', '@高平', 'o2AIEt2XYFKtedwQnZCP5QRPEZgU', '1418873431');
INSERT INTO `cst_chat` VALUES ('113', '@魏晨 11', 'o2AIEt8DEwawpypoHs0b5O8QgG3c', '1418873442');
INSERT INTO `cst_chat` VALUES ('114', '@高', 'o2AIEt0D9oyUQq38k_6ybqauiCSw', '1418873442');
INSERT INTO `cst_chat` VALUES ('115', '@白林', 'o2AIEtxujf5S6nPN48O8ZR3TUs4U', '1418873448');
INSERT INTO `cst_chat` VALUES ('116', '@高平 1', 'o2AIEt8DEwawpypoHs0b5O8QgG3c', '1418873458');
INSERT INTO `cst_chat` VALUES ('117', '@高平', 'o2AIEtzDbzdvaFHmaPk2pdTwxQbM', '1418873464');
INSERT INTO `cst_chat` VALUES ('118', '@杨栋 1', 'o2AIEt8DEwawpypoHs0b5O8QgG3c', '1418873477');
INSERT INTO `cst_chat` VALUES ('119', '@白林  1', 'o2AIEt8DEwawpypoHs0b5O8QgG3c', '1418873498');
INSERT INTO `cst_chat` VALUES ('120', '@高平', 'o2AIEtxujf5S6nPN48O8ZR3TUs4U', '1418873506');
INSERT INTO `cst_chat` VALUES ('121', '@曲奇  1', 'o2AIEt8DEwawpypoHs0b5O8QgG3c', '1418873531');
INSERT INTO `cst_chat` VALUES ('122', '@高平', 'o2AIEt2XYFKtedwQnZCP5QRPEZgU', '1418873700');
INSERT INTO `cst_chat` VALUES ('123', '@白', 'o2AIEtzDbzdvaFHmaPk2pdTwxQbM', '1418873714');

-- ----------------------------
-- Table structure for `cst_company`
-- ----------------------------
DROP TABLE IF EXISTS `cst_company`;
CREATE TABLE `cst_company` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT '文档ID',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '标题',
  `description` varchar(255) NOT NULL COMMENT '公司信息',
  `pid` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '上级分类ID',
  `sort` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '排序（同级有效）',
  `create_time` int(11) NOT NULL COMMENT '添加时间',
  `update_time` int(11) NOT NULL COMMENT '更新时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT ' 状态',
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cst_company
-- ----------------------------
INSERT INTO `cst_company` VALUES ('1', '北京帕米信息科技', '北京帕米信息科技app开发', '0', '0', '1416388195', '0', '1');
INSERT INTO `cst_company` VALUES ('2', '索为工业电子', '索为高科公司信息', '0', '0', '1416388637', '1418731982', '1');
INSERT INTO `cst_company` VALUES ('3', '百度', '', '0', '0', '1418731121', '0', '1');
INSERT INTO `cst_company` VALUES ('4', 'php开发', '', '1', '0', '1418731540', '0', '1');
INSERT INTO `cst_company` VALUES ('5', 'Android', '', '1', '0', '1418735356', '0', '1');
INSERT INTO `cst_company` VALUES ('6', '市场部', '', '2', '0', '1418784233', '0', '1');
INSERT INTO `cst_company` VALUES ('7', '研发部1', '', '2', '0', '1418784299', '1418800075', '1');
INSERT INTO `cst_company` VALUES ('8', '北京帕米信息', '', '0', '0', '0', '0', '1');
INSERT INTO `cst_company` VALUES ('9', '网易', '', '0', '0', '0', '1419220333', '1');
INSERT INTO `cst_company` VALUES ('10', '帕米信息', '', '0', '0', '0', '0', '1');

-- ----------------------------
-- Table structure for `cst_config`
-- ----------------------------
DROP TABLE IF EXISTS `cst_config`;
CREATE TABLE `cst_config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '配置ID',
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '配置名称',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '配置类型',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '配置说明',
  `group` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '配置分组',
  `extra` varchar(255) NOT NULL DEFAULT '' COMMENT '配置值',
  `remark` varchar(100) NOT NULL COMMENT '配置说明',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态',
  `value` text NOT NULL COMMENT '配置值',
  `sort` smallint(3) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_name` (`name`),
  KEY `type` (`type`),
  KEY `group` (`group`)
) ENGINE=MyISAM AUTO_INCREMENT=57 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cst_config
-- ----------------------------
INSERT INTO `cst_config` VALUES ('1', 'WEB_SITE_TITLE', '1', '网站标题', '1', '', '网站标题前台显示标题', '1378898976', '1379235274', '1', 'CST微信客服系统', '0');
INSERT INTO `cst_config` VALUES ('2', 'WEB_SITE_DESCRIPTION', '2', '网站描述', '1', '', '网站搜索引擎描述', '1378898976', '1379235841', '1', 'CST微信客服系统', '1');
INSERT INTO `cst_config` VALUES ('3', 'WEB_SITE_KEYWORD', '2', '网站关键字', '1', '', '网站搜索引擎关键字', '1378898976', '1381390100', '1', 'CST', '8');
INSERT INTO `cst_config` VALUES ('4', 'WEB_SITE_CLOSE', '4', '关闭站点', '1', '0:关闭,1:开启', '站点关闭后其他用户不能访问，管理员可以正常访问', '1378898976', '1379235296', '1', '1', '1');
INSERT INTO `cst_config` VALUES ('9', 'CONFIG_TYPE_LIST', '3', '配置类型列表', '4', '', '主要用于数据解析和页面表单的生成', '1378898976', '1379235348', '1', '0:数字\r\n1:字符\r\n2:文本\r\n3:数组\r\n4:枚举', '2');
INSERT INTO `cst_config` VALUES ('10', 'WEB_SITE_ICP', '1', '网站备案号', '1', '', '设置在网站底部显示的备案号，如“沪ICP备12007941号-2', '1378900335', '1379235859', '1', '', '9');
INSERT INTO `cst_config` VALUES ('11', 'DOCUMENT_POSITION', '3', '文档推荐位', '2', '', '文档推荐位，推荐到多个位置KEY值相加即可', '1379053380', '1379235329', '1', '1:列表页推荐\r\n2:频道页推荐\r\n4:网站首页推荐', '3');
INSERT INTO `cst_config` VALUES ('12', 'DOCUMENT_DISPLAY', '3', '文档可见性', '2', '', '文章可见性仅影响前台显示，后台不收影响', '1379056370', '1379235322', '1', '0:所有人可见\r\n1:仅注册会员可见\r\n2:仅管理员可见', '4');
INSERT INTO `cst_config` VALUES ('13', 'COLOR_STYLE', '4', '后台色系', '1', 'default_color:默认\r\nblue_color:紫罗兰', '后台颜色风格', '1379122533', '1379235904', '1', 'blue_color', '10');
INSERT INTO `cst_config` VALUES ('20', 'CONFIG_GROUP_LIST', '3', '配置分组', '4', '', '配置分组', '1379228036', '1384418383', '1', '1:基本\r\n2:内容\r\n3:用户\r\n4:系统\r\n5:微信', '4');
INSERT INTO `cst_config` VALUES ('21', 'HOOKS_TYPE', '3', '钩子的类型', '4', '', '类型 1-用于扩展显示内容，2-用于扩展业务处理', '1379313397', '1379313407', '1', '1:视图\r\n2:控制器', '6');
INSERT INTO `cst_config` VALUES ('22', 'AUTH_CONFIG', '3', 'Auth配置', '4', '', '自定义Auth.class.php类配置', '1379409310', '1379409564', '1', 'AUTH_ON:1\r\nAUTH_TYPE:2', '8');
INSERT INTO `cst_config` VALUES ('23', 'OPEN_DRAFTBOX', '4', '是否开启草稿功能', '2', '0:关闭草稿功能\r\n1:开启草稿功能\r\n', '新增文章时的草稿功能配置', '1379484332', '1379484591', '1', '0', '1');
INSERT INTO `cst_config` VALUES ('24', 'DRAFT_AOTOSAVE_INTERVAL', '0', '自动保存草稿时间', '2', '', '自动保存草稿的时间间隔，单位：秒', '1379484574', '1386143323', '1', '60', '2');
INSERT INTO `cst_config` VALUES ('25', 'LIST_ROWS', '0', '后台每页记录数', '2', '', '后台数据每页显示记录数', '1379503896', '1416219797', '1', '15', '15');
INSERT INTO `cst_config` VALUES ('26', 'USER_ALLOW_REGISTER', '4', '是否允许用户注册', '3', '0:关闭注册\r\n1:允许注册', '是否开放用户注册', '1379504487', '1379504580', '1', '1', '3');
INSERT INTO `cst_config` VALUES ('27', 'CODEMIRROR_THEME', '4', '预览插件的CodeMirror主题', '4', '3024-day:3024 day\r\n3024-night:3024 night\r\nambiance:ambiance\r\nbase16-dark:base16 dark\r\nbase16-light:base16 light\r\nblackboard:blackboard\r\ncobalt:cobalt\r\neclipse:eclipse\r\nelegant:elegant\r\nerlang-dark:erlang-dark\r\nlesser-dark:lesser-dark\r\nmidnight:midnight', '详情见CodeMirror官网', '1379814385', '1384740813', '1', '3024-day', '3');
INSERT INTO `cst_config` VALUES ('28', 'DATA_BACKUP_PATH', '1', '数据库备份根路径', '4', '', '路径必须以 / 结尾', '1381482411', '1381482411', '1', './Data/', '5');
INSERT INTO `cst_config` VALUES ('29', 'DATA_BACKUP_PART_SIZE', '0', '数据库备份卷大小', '4', '', '该值用于限制压缩后的分卷最大长度。单位：B；建议设置20M', '1381482488', '1381729564', '1', '20971520', '7');
INSERT INTO `cst_config` VALUES ('30', 'DATA_BACKUP_COMPRESS', '4', '数据库备份文件是否启用压缩', '4', '0:不压缩\r\n1:启用压缩', '压缩备份文件需要PHP环境支持gzopen,gzwrite函数', '1381713345', '1381729544', '1', '1', '9');
INSERT INTO `cst_config` VALUES ('31', 'DATA_BACKUP_COMPRESS_LEVEL', '4', '数据库备份文件压缩级别', '4', '1:普通\r\n4:一般\r\n9:最高', '数据库备份文件的压缩级别，该配置在开启压缩时生效', '1381713408', '1381713408', '1', '9', '10');
INSERT INTO `cst_config` VALUES ('32', 'DEVELOP_MODE', '4', '开启开发者模式', '4', '0:关闭\r\n1:开启', '是否开启开发者模式', '1383105995', '1383291877', '1', '1', '11');
INSERT INTO `cst_config` VALUES ('33', 'ALLOW_VISIT', '3', '不受限控制器方法', '1', '', '', '1386644047', '1415931298', '1', '0:article/draftbox\r\n1:article/mydocument\r\n2:Category/tree\r\n3:Index/verify\r\n4:file/upload\r\n5:file/download\r\n6:user/updatePassword\r\n7:user/updateNickname\r\n8:user/submitPassword\r\n9:user/submitNickname\r\n10:file/uploadpicture\r\n11:Member/updatecustomer\r\n12:Member/changeCompany\r\n13:changeCompany\r\n14:Config/save', '10');
INSERT INTO `cst_config` VALUES ('34', 'DENY_VISIT', '3', '超管专限控制器方法', '1', '', '仅超级管理员可访问的控制器方法', '1386644141', '1415931310', '1', '0:Addons/addhook\r\n1:Addons/edithook\r\n2:Addons/delhook\r\n3:Addons/updateHook\r\n4:Admin/getMenus\r\n5:Admin/recordList\r\n6:AuthManager/updateRules\r\n7:AuthManager/tree', '11');
INSERT INTO `cst_config` VALUES ('35', 'REPLY_LIST_ROWS', '0', '回复列表每页条数', '2', '', '', '1386645376', '1387178083', '1', '15', '0');
INSERT INTO `cst_config` VALUES ('36', 'ADMIN_ALLOW_IP', '2', '后台允许访问IP', '4', '', '多个用逗号分隔，如果不配置表示不限制IP访问', '1387165454', '1387165553', '1', '', '12');
INSERT INTO `cst_config` VALUES ('37', 'SHOW_PAGE_TRACE', '4', '是否显示页面Trace', '4', '0:关闭\r\n1:开启', '是否显示页面Trace信息', '1387165685', '1387165685', '1', '0', '1');
INSERT INTO `cst_config` VALUES ('40', 'WX_APPID', '1', '微信账号appid', '5', '', '请输入微信公众账号的appid', '1415873461', '1415930232', '1', 'wxcaf971ebcf19fc6c', '0');
INSERT INTO `cst_config` VALUES ('41', 'WX_APPSECRET', '1', '微信账号appsecret', '5', '', '请输入微信公众账号的appsecret', '1415873513', '1415930242', '1', 'f2585e1c72ebe9f576a9718f293fffec', '0');
INSERT INTO `cst_config` VALUES ('42', 'WX_TOKEN', '1', '微信认证token', '5', '', '', '1415931150', '1415931168', '1', 'cstweixin', '0');
INSERT INTO `cst_config` VALUES ('43', 'WX_RESPONSE_TYPE', '3', '响应信息类型', '5', '', '', '1415937180', '1416207894', '1', 'text:文本\r\nnews:图文', '0');
INSERT INTO `cst_config` VALUES ('44', 'VAR_PAGE', '1', '分页标识', '0', '', '', '1416274841', '1416274841', '1', 'page', '0');
INSERT INTO `cst_config` VALUES ('45', 'EMPTY_DATA', '1', '输出的数组为空时显示的提示信息', '2', '', '', '1416300368', '1416300368', '1', '没有相关记录', '0');
INSERT INTO `cst_config` VALUES ('48', 'FEEDBACK_TYPE', '3', '反馈方式', '3', '', '用户反馈响应的方式', '1417052462', '1417056787', '1', '1:电话\r\n2:邮件', '0');
INSERT INTO `cst_config` VALUES ('49', 'PRODUCT_TYPE', '3', '产品问题类型', '3', '', '用户反馈产品问题类型', '1417058512', '1417058512', '1', '1:类型1\r\n2:类型2\r\n3:类型3\r\n4:类型4', '0');
INSERT INTO `cst_config` VALUES ('50', 'TIME_SEARCH', '3', '按时间搜索', '2', '', '', '1417680195', '1417680195', '1', '1:最新\r\n2:最近一个月', '0');
INSERT INTO `cst_config` VALUES ('56', 'USER_GROUP', '3', '用户分组', '3', '', '', '1418803776', '1418805045', '1', '1:普通用户\r\n2:内部用户', '0');
INSERT INTO `cst_config` VALUES ('52', 'ENCODINGAESKEY', '1', '消息加解密密钥', '5', '', '', '1418115343', '1418115380', '1', 'zyFZGitJIOuuKOXdzvjIhZMeci85WUMEGqhCd0MAnFz', '0');
INSERT INTO `cst_config` VALUES ('53', 'SITE_DOMAIN', '1', '站点域名', '1', '', '', '1418180677', '1418180733', '1', 'http://juba.aipami.com', '0');
INSERT INTO `cst_config` VALUES ('54', 'FEEDBACK_TIME', '3', '反馈时间', '3', '', '', '1418291710', '1418291710', '1', '1:非常紧急(1个工作日内)\r\n2:越早越好(1~5个工作日内)', '0');
INSERT INTO `cst_config` VALUES ('55', 'ADMIN_EMAIL', '1', '管理员邮箱', '1', '', '', '1418699250', '1418699250', '1', 'zhanglei@sysware.com.cn', '0');

-- ----------------------------
-- Table structure for `cst_customer`
-- ----------------------------
DROP TABLE IF EXISTS `cst_customer`;
CREATE TABLE `cst_customer` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `realname` varchar(30) NOT NULL COMMENT '真实姓名',
  `sex` tinyint(1) NOT NULL COMMENT '客户性别',
  `email` char(32) NOT NULL COMMENT '用户邮箱',
  `mobile` char(15) NOT NULL COMMENT '用户手机',
  `content` varchar(255) NOT NULL COMMENT '客户备注信息',
  `companyid` smallint(6) NOT NULL COMMENT '公司id',
  `departmentid` smallint(6) NOT NULL COMMENT '部门id',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of cst_customer
-- ----------------------------
INSERT INTO `cst_customer` VALUES ('1', '魏永', '1', 'weiyong.me@qq.com', '18710283199', 'php程序开发', '1', '4', '1418176815', '1418893214');
INSERT INTO `cst_customer` VALUES ('2', '白林', '0', 'bailin@qq.com', '18710283100', '111111', '1', '5', '1418712079', '1418897420');
INSERT INTO `cst_customer` VALUES ('3', '高平', '1', '123@ss.com', '15000000000', '', '1', '4', '1418716178', '1418897149');
INSERT INTO `cst_customer` VALUES ('6', '魏122永', '1', '820540000@qq.com', '13820540980', '', '10', '0', '1418956553', '1418973562');

-- ----------------------------
-- Table structure for `cst_department`
-- ----------------------------
DROP TABLE IF EXISTS `cst_department`;
CREATE TABLE `cst_department` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT '文档ID',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '标题',
  `pid` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '上级分类ID',
  `sort` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '排序（同级有效）',
  `create_time` int(11) NOT NULL COMMENT '添加时间',
  `update_time` int(11) NOT NULL COMMENT '更新时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT ' 状态',
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cst_department
-- ----------------------------
INSERT INTO `cst_department` VALUES ('1', '市场部', '0', '0', '1416388515', '0', '1');
INSERT INTO `cst_department` VALUES ('2', '营销部', '0', '0', '1416388650', '0', '1');
INSERT INTO `cst_department` VALUES ('3', '公关部', '0', '0', '1416388659', '0', '1');
INSERT INTO `cst_department` VALUES ('4', '工业电子', '0', '0', '1418718288', '0', '1');

-- ----------------------------
-- Table structure for `cst_document`
-- ----------------------------
DROP TABLE IF EXISTS `cst_document`;
CREATE TABLE `cst_document` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文档ID',
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `name` char(40) NOT NULL DEFAULT '' COMMENT '标识',
  `title` char(80) NOT NULL DEFAULT '' COMMENT '标题',
  `category_id` int(10) unsigned NOT NULL COMMENT '所属分类',
  `description` char(140) NOT NULL DEFAULT '' COMMENT '描述',
  `root` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '根节点',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '所属ID',
  `model_id` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '内容模型ID',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '2' COMMENT '内容类型',
  `position` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '推荐位',
  `link_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '外链',
  `cover_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '封面',
  `display` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '可见性',
  `deadline` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '截至时间',
  `attach` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '附件数量',
  `view` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览量',
  `comment` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '评论数',
  `extend` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '扩展统计字段',
  `level` int(10) NOT NULL DEFAULT '0' COMMENT '优先级',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '数据状态',
  PRIMARY KEY (`id`),
  KEY `idx_category_status` (`category_id`,`status`),
  KEY `idx_status_type_pid` (`status`,`uid`,`pid`)
) ENGINE=MyISAM AUTO_INCREMENT=26 DEFAULT CHARSET=utf8 COMMENT='文档模型基础表';

-- ----------------------------
-- Records of cst_document
-- ----------------------------
INSERT INTO `cst_document` VALUES ('3', '1', '', '技术动态测试一', '2', '为了突破传统计算机辅助工具体系的局限性，分立的计为了突破传统计算机辅助工具体系的局限', '0', '0', '2', '2', '0', '0', '2', '1', '0', '0', '7', '0', '0', '0', '1415931720', '1418892257', '-1');
INSERT INTO `cst_document` VALUES ('4', '1', '', '资料下载', '3', '为了突破传统计算机辅助工具体系的局限性，分立的计为了突破传统计算机辅助工具体系的局', '0', '0', '3', '2', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '1415931817', '1415931817', '3');
INSERT INTO `cst_document` VALUES ('5', '1', '', '资料下载', '7', '为了突破传统计算机辅助工具体系的局限性，分立的计为了突破传统计算机辅助工具体系的局', '0', '0', '3', '2', '0', '0', '0', '1', '0', '0', '8', '0', '0', '0', '1415931895', '1415931895', '1');
INSERT INTO `cst_document` VALUES ('10', '1', '', '产品12213221', '6', '为了突破传统计算机辅助工具体系的局限性，分立的计为了突破传统计算机辅助工具体系的局', '0', '0', '3', '2', '0', '0', '0', '1', '0', '0', '5', '0', '0', '0', '1416965640', '1417682417', '1');
INSERT INTO `cst_document` VALUES ('12', '1', '', '测试', '4', '为了突破传统计算机辅助工具体系的局限性，分立的计为了突破传统计算机辅助工具体系的局', '0', '0', '2', '2', '0', '3', '1', '1', '0', '0', '0', '0', '0', '0', '1417593615', '1417593615', '1');
INSERT INTO `cst_document` VALUES ('14', '1', '', '测试二', '4', '为了突破传统计算机辅助工具体系的局限性，分立的计为了突破传统计算机辅助工具体系的局', '0', '0', '2', '2', '0', '0', '1', '1', '0', '0', '0', '0', '0', '0', '1417594078', '1417594078', '1');
INSERT INTO `cst_document` VALUES ('15', '1', '', '测试三', '4', '为了突破传统计算机辅助工具体系的局限性，分立的计为了突破传统计算机辅助工具体系的局', '0', '0', '2', '2', '0', '0', '1', '1', '0', '0', '0', '0', '0', '0', '1417594097', '1417594097', '1');
INSERT INTO `cst_document` VALUES ('16', '1', '', '技术动态测试二', '2', '为了突破传统计算机辅助工具体系的局限性，分立的计为了突破传统计算机辅助工具体系的局限', '0', '0', '2', '2', '0', '0', '2', '1', '0', '0', '2', '0', '0', '0', '1417595040', '1417603259', '1');
INSERT INTO `cst_document` VALUES ('17', '1', '', '技术动态测试三', '2', '为了突破传统计算机辅助工具体系的局限性，分立的计为了突破传统计算机辅助工具体系的局限', '0', '0', '2', '2', '0', '0', '2', '1', '0', '0', '7', '0', '0', '0', '1417595100', '1417603268', '1');
INSERT INTO `cst_document` VALUES ('18', '1', '', '技术动态测试四', '2', '为了突破传统计算机辅助工具体系的局限性，分立的计为了突破传统计算机辅助工具体系的局限', '0', '0', '2', '2', '0', '0', '2', '1', '0', '0', '43', '0', '0', '0', '1417599360', '1417602494', '1');
INSERT INTO `cst_document` VALUES ('23', '1', '', 'ICDSys', '5', '为了突破传统计算机辅助工具体系的局限性，分立的计为了突破传统计算机辅助工具体系的局', '0', '0', '5', '2', '0', '0', '1', '1', '0', '0', '115', '0', '0', '0', '1417657680', '1417661707', '1');
INSERT INTO `cst_document` VALUES ('24', '1', 'SMod', 'SMod', '5', '为了突破传统计算机辅助工具体系的局限性，分立的计为了突破传统计算机辅助工具体系的局', '0', '0', '5', '2', '0', '0', '2', '1', '0', '0', '79', '0', '0', '0', '1417658040', '1417661716', '1');
INSERT INTO `cst_document` VALUES ('25', '1', 'SSim', 'SSim', '5', 'SSim', '0', '0', '5', '2', '0', '0', '1', '1', '0', '0', '76', '0', '0', '0', '1417658040', '1417661725', '1');

-- ----------------------------
-- Table structure for `cst_document_article`
-- ----------------------------
DROP TABLE IF EXISTS `cst_document_article`;
CREATE TABLE `cst_document_article` (
  `id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文档ID',
  `parse` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '内容解析类型',
  `content` text NOT NULL COMMENT '文章内容',
  `template` varchar(100) NOT NULL DEFAULT '' COMMENT '详情页显示模板',
  `bookmark` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '收藏数',
  `ugroup` char(10) NOT NULL DEFAULT '0' COMMENT '允许查看的用户租',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='文档模型文章表';

-- ----------------------------
-- Records of cst_document_article
-- ----------------------------
INSERT INTO `cst_document_article` VALUES ('1', '0', '<h1>\r\n	OneThink1.0正式版发布&nbsp;\r\n</h1>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<strong>OneThink是一个开源的内容管理框架，基于最新的ThinkPHP3.2版本开发，提供更方便、更安全的WEB应用开发体验，采用了全新的架构设计和命名空间机制，融合了模块化、驱动化和插件化的设计理念于一体，开启了国内WEB应用傻瓜式开发的新潮流。&nbsp;</strong> \r\n</p>\r\n<h2>\r\n	主要特性：\r\n</h2>\r\n<p>\r\n	1. 基于ThinkPHP最新3.2版本。\r\n</p>\r\n<p>\r\n	2. 模块化：全新的架构和模块化的开发机制，便于灵活扩展和二次开发。&nbsp;\r\n</p>\r\n<p>\r\n	3. 文档模型/分类体系：通过和文档模型绑定，以及不同的文档类型，不同分类可以实现差异化的功能，轻松实现诸如资讯、下载、讨论和图片等功能。\r\n</p>\r\n<p>\r\n	4. 开源免费：OneThink遵循Apache2开源协议,免费提供使用。&nbsp;\r\n</p>\r\n<p>\r\n	5. 用户行为：支持自定义用户行为，可以对单个用户或者群体用户的行为进行记录及分享，为您的运营决策提供有效参考数据。\r\n</p>\r\n<p>\r\n	6. 云端部署：通过驱动的方式可以轻松支持平台的部署，让您的网站无缝迁移，内置已经支持SAE和BAE3.0。\r\n</p>\r\n<p>\r\n	7. 云服务支持：即将启动支持云存储、云安全、云过滤和云统计等服务，更多贴心的服务让您的网站更安心。\r\n</p>\r\n<p>\r\n	8. 安全稳健：提供稳健的安全策略，包括备份恢复、容错、防止恶意攻击登录，网页防篡改等多项安全管理功能，保证系统安全，可靠、稳定的运行。&nbsp;\r\n</p>\r\n<p>\r\n	9. 应用仓库：官方应用仓库拥有大量来自第三方插件和应用模块、模板主题，有众多来自开源社区的贡献，让您的网站“One”美无缺。&nbsp;\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<strong>&nbsp;OneThink集成了一个完善的后台管理体系和前台模板标签系统，让你轻松管理数据和进行前台网站的标签式开发。&nbsp;</strong> \r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<h2>\r\n	后台主要功能：\r\n</h2>\r\n<p>\r\n	1. 用户Passport系统\r\n</p>\r\n<p>\r\n	2. 配置管理系统&nbsp;\r\n</p>\r\n<p>\r\n	3. 权限控制系统\r\n</p>\r\n<p>\r\n	4. 后台建模系统&nbsp;\r\n</p>\r\n<p>\r\n	5. 多级分类系统&nbsp;\r\n</p>\r\n<p>\r\n	6. 用户行为系统&nbsp;\r\n</p>\r\n<p>\r\n	7. 钩子和插件系统\r\n</p>\r\n<p>\r\n	8. 系统日志系统&nbsp;\r\n</p>\r\n<p>\r\n	9. 数据备份和还原\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	&nbsp;[ 官方下载：&nbsp;<a href=\"http://www.onethink.cn/download.html\" target=\"_blank\">http://www.onethink.cn/download.html</a>&nbsp;&nbsp;开发手册：<a href=\"http://document.onethink.cn/\" target=\"_blank\">http://document.onethink.cn/</a>&nbsp;]&nbsp;\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<strong>OneThink开发团队 2013</strong> \r\n</p>', '', '0', '0');
INSERT INTO `cst_document_article` VALUES ('2', '0', '产品112321', '', '0', '0');
INSERT INTO `cst_document_article` VALUES ('3', '0', '技术技术动态测试一', '', '0', '0');
INSERT INTO `cst_document_article` VALUES ('6', '0', '图文关键字', '', '0', '0');
INSERT INTO `cst_document_article` VALUES ('7', '0', '产品3', '', '0', '0');
INSERT INTO `cst_document_article` VALUES ('8', '0', '产品3', '', '0', '0');
INSERT INTO `cst_document_article` VALUES ('12', '0', '测试', '', '0', '0');
INSERT INTO `cst_document_article` VALUES ('14', '0', '测试二', '', '0', '0');
INSERT INTO `cst_document_article` VALUES ('15', '0', '测试二测试二', '', '0', '0');
INSERT INTO `cst_document_article` VALUES ('16', '0', '为了突破传统计算机辅助工具体系的局限性，分立的计为了突破传统计算机辅助工具体系的局限', '', '0', '0');
INSERT INTO `cst_document_article` VALUES ('17', '0', '为了突破传统计算机辅助工具体系的局限性，分立的计为了突破传统计算机辅助工具体系的局限<br />', '', '0', '0');
INSERT INTO `cst_document_article` VALUES ('18', '0', '技术动态测试四&nbsp;&nbsp;&nbsp; 为了突破传统计算机辅助工具体系的局限性，分立的计为了突破传统计算机辅助工具体系的局限', '', '0', '0');

-- ----------------------------
-- Table structure for `cst_document_chanpin`
-- ----------------------------
DROP TABLE IF EXISTS `cst_document_chanpin`;
CREATE TABLE `cst_document_chanpin` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `cover_1` int(10) unsigned NOT NULL COMMENT '封面一',
  `cover_2` int(10) unsigned NOT NULL COMMENT '封面二',
  `cover_3` int(10) unsigned NOT NULL COMMENT '测试三',
  `content` text NOT NULL COMMENT '产品介绍',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=26 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of cst_document_chanpin
-- ----------------------------
INSERT INTO `cst_document_chanpin` VALUES ('23', '5', '6', '7', '<div class=\"item\">\r\n    <h2>工具简介：</h2>\r\n    <p class=\"info\">本工具采用符合UML/SysML标准的活动图、顺序图和状态机图实现对系统行为的完整描述，建立系统的运行场景，场景转换逻辑关系，场景内部的交互行为和单独设备的逻辑接口模型，场景内部的交互行为和单独设备的逻辑接口模型。。</p>\r\n  </div>\r\n  <div class=\"item\">\r\n    <h2>工具简介：</h2>\r\n    <p class=\"info\">本工具采用符合UML/SysML标准的活动图、顺序图和状态机图实现对系统行为的完整描述，建立系统的运行场景，场景转换逻辑关系，场景内部的交互行为和单独设备的逻辑接口模型，场景内部的交互行为和单独设备的逻辑接口模型。。</p>\r\n  </div>\r\n  <div class=\"item\">\r\n    <h2>工具简介：</h2>\r\n    <p class=\"info\">本工具采用符合UML/SysML标准的活动图、顺序图和状态机图实现对系统行为的完整描述，建立系统的运行场景，场景转换逻辑关系，场景内部的交互行为和单独设备的逻辑接口模型，场景内部的交互行为和单独设备的逻辑接口模型。。</p>\r\n  </div>\r\n  <div class=\"item\">\r\n    <h2>工具简介：</h2>\r\n    <p class=\"info\">本工具采用符合UML/SysML标准的活动图、顺序图和状态机图实现对系统行为的完整描述，建立系统的运行场景，场景转换逻辑关系，场景内部的交互行为和单独设备的逻辑接口模型，场景内部的交互行为和单独设备的逻辑接口模型。。</p>\r\n  </div>');
INSERT INTO `cst_document_chanpin` VALUES ('24', '7', '5', '6', '<div class=\"item\">\r\n    <h2>工具简介：</h2>\r\n    <p class=\"info\">本工具采用符合UML/SysML标准的活动图、顺序图和状态机图实现对系统行为的完整描述，建立系统的运行场景，场景转换逻辑关系，场景内部的交互行为和单独设备的逻辑接口模型，场景内部的交互行为和单独设备的逻辑接口模型。。</p>\r\n  </div>\r\n  <div class=\"item\">\r\n    <h2>工具简介：</h2>\r\n    <p class=\"info\">本工具采用符合UML/SysML标准的活动图、顺序图和状态机图实现对系统行为的完整描述，建立系统的运行场景，场景转换逻辑关系，场景内部的交互行为和单独设备的逻辑接口模型，场景内部的交互行为和单独设备的逻辑接口模型。。</p>\r\n  </div>\r\n  <div class=\"item\">\r\n    <h2>工具简介：</h2>\r\n    <p class=\"info\">本工具采用符合UML/SysML标准的活动图、顺序图和状态机图实现对系统行为的完整描述，建立系统的运行场景，场景转换逻辑关系，场景内部的交互行为和单独设备的逻辑接口模型，场景内部的交互行为和单独设备的逻辑接口模型。。</p>\r\n  </div>\r\n  <div class=\"item\">\r\n    <h2>工具简介：</h2>\r\n    <p class=\"info\">本工具采用符合UML/SysML标准的活动图、顺序图和状态机图实现对系统行为的完整描述，建立系统的运行场景，场景转换逻辑关系，场景内部的交互行为和单独设备的逻辑接口模型，场景内部的交互行为和单独设备的逻辑接口模型。。</p>\r\n  </div>');
INSERT INTO `cst_document_chanpin` VALUES ('25', '7', '5', '6', '<div class=\"item\">\r\n    <h2>工具简介：</h2>\r\n    <p class=\"info\">本工具采用符合UML/SysML标准的活动图、顺序图和状态机图实现对系统行为的完整描述，建立系统的运行场景，场景转换逻辑关系，场景内部的交互行为和单独设备的逻辑接口模型，场景内部的交互行为和单独设备的逻辑接口模型。。</p>\r\n  </div>\r\n  <div class=\"item\">\r\n    <h2>工具简介：</h2>\r\n    <p class=\"info\">本工具采用符合UML/SysML标准的活动图、顺序图和状态机图实现对系统行为的完整描述，建立系统的运行场景，场景转换逻辑关系，场景内部的交互行为和单独设备的逻辑接口模型，场景内部的交互行为和单独设备的逻辑接口模型。。</p>\r\n  </div>\r\n  <div class=\"item\">\r\n    <h2>工具简介：</h2>\r\n    <p class=\"info\">本工具采用符合UML/SysML标准的活动图、顺序图和状态机图实现对系统行为的完整描述，建立系统的运行场景，场景转换逻辑关系，场景内部的交互行为和单独设备的逻辑接口模型，场景内部的交互行为和单独设备的逻辑接口模型。。</p>\r\n  </div>\r\n  <div class=\"item\">\r\n    <h2>工具简介：</h2>\r\n    <p class=\"info\">本工具采用符合UML/SysML标准的活动图、顺序图和状态机图实现对系统行为的完整描述，建立系统的运行场景，场景转换逻辑关系，场景内部的交互行为和单独设备的逻辑接口模型，场景内部的交互行为和单独设备的逻辑接口模型。。</p>\r\n  </div>');

-- ----------------------------
-- Table structure for `cst_document_download`
-- ----------------------------
DROP TABLE IF EXISTS `cst_document_download`;
CREATE TABLE `cst_document_download` (
  `id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文档ID',
  `parse` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '内容解析类型',
  `content` text NOT NULL COMMENT '下载详细描述',
  `template` varchar(100) NOT NULL DEFAULT '' COMMENT '详情页显示模板',
  `file_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文件ID',
  `download` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '下载次数',
  `size` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '文件大小',
  `vision` varchar(255) NOT NULL DEFAULT '1.0' COMMENT '版本号',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='文档模型下载表';

-- ----------------------------
-- Records of cst_document_download
-- ----------------------------
INSERT INTO `cst_document_download` VALUES ('5', '0', '资料下载', '', '1', '0', '70', '1.0');
INSERT INTO `cst_document_download` VALUES ('10', '0', '43212131', '', '2', '2', '50644', '1.0');

-- ----------------------------
-- Table structure for `cst_document_prodcut`
-- ----------------------------
DROP TABLE IF EXISTS `cst_document_prodcut`;
CREATE TABLE `cst_document_prodcut` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `cover1` int(10) unsigned NOT NULL COMMENT '封面图一',
  `cover2` int(10) unsigned NOT NULL COMMENT '封面图二',
  `cover3` int(10) unsigned NOT NULL COMMENT '封面图三',
  `content` text NOT NULL COMMENT '产品介绍',
  `template` varchar(255) NOT NULL COMMENT '详情页显示模板',
  `parse` tinyint(3) unsigned NOT NULL COMMENT '内容解析类型',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of cst_document_prodcut
-- ----------------------------

-- ----------------------------
-- Table structure for `cst_experience`
-- ----------------------------
DROP TABLE IF EXISTS `cst_experience`;
CREATE TABLE `cst_experience` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `title` varchar(60) NOT NULL COMMENT '标题',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cst_experience
-- ----------------------------

-- ----------------------------
-- Table structure for `cst_file`
-- ----------------------------
DROP TABLE IF EXISTS `cst_file`;
CREATE TABLE `cst_file` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文件ID',
  `name` char(30) NOT NULL DEFAULT '' COMMENT '原始文件名',
  `savename` char(20) NOT NULL DEFAULT '' COMMENT '保存名称',
  `savepath` char(30) NOT NULL DEFAULT '' COMMENT '文件保存路径',
  `ext` char(5) NOT NULL DEFAULT '' COMMENT '文件后缀',
  `mime` char(40) NOT NULL DEFAULT '' COMMENT '文件mime类型',
  `size` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文件大小',
  `md5` char(32) NOT NULL DEFAULT '' COMMENT '文件md5',
  `sha1` char(40) NOT NULL DEFAULT '' COMMENT '文件 sha1编码',
  `location` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '文件保存位置',
  `create_time` int(10) unsigned NOT NULL COMMENT '上传时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_md5` (`md5`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='文件表';

-- ----------------------------
-- Records of cst_file
-- ----------------------------
INSERT INTO `cst_file` VALUES ('1', 'images.rar', '54752e3b82dc7.rar', '2014-11-26/', 'rar', 'application/octet-stream', '270185', '4bb7c14b6b56a624838648cff9dd03db', 'ddcdf14583d2e5d3731c1b5c7612816acd1591c4', '0', '1416965691');
INSERT INTO `cst_file` VALUES ('2', '3.rar', '547fc322e43b1.rar', '2014-12-04/', 'rar', 'application/octet-stream', '50644', '4e7ba5ab846691d7c86300ad67aa47ef', '845a4fa13f8f0ad199248579404498de16fed4b4', '0', '1417659170');

-- ----------------------------
-- Table structure for `cst_getcode`
-- ----------------------------
DROP TABLE IF EXISTS `cst_getcode`;
CREATE TABLE `cst_getcode` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `username` varchar(32) NOT NULL COMMENT '申请者的姓名',
  `email` varchar(32) NOT NULL COMMENT '用户邮箱',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态0待处理，1正在处理，2已答复',
  `create_time` int(11) NOT NULL COMMENT '反馈时间',
  `openid` varchar(60) NOT NULL COMMENT '用户openid',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cst_getcode
-- ----------------------------
INSERT INTO `cst_getcode` VALUES ('4', '魏永', 'weiyong.me@qq.com', '2', '1418819745', '');
INSERT INTO `cst_getcode` VALUES ('5', '范畴', '360842709@qq.com', '1', '1418821181', '');
INSERT INTO `cst_getcode` VALUES ('6', '李晋', '876837383@qq.com', '1', '1418871409', '');
INSERT INTO `cst_getcode` VALUES ('7', '魏晨', 'weich@sysware.com.cn', '0', '1418871530', '');
INSERT INTO `cst_getcode` VALUES ('8', '毛小毛', 'maoj@sysware.com.cn', '1', '1418871537', '');
INSERT INTO `cst_getcode` VALUES ('9', '章磊', 'zhanglei@sysware.com.cn', '1', '1418871557', '');
INSERT INTO `cst_getcode` VALUES ('10', 'lzflzf', '11@sina.com', '1', '1418871604', '');
INSERT INTO `cst_getcode` VALUES ('11', '李晓妍', 'lixy@sysware.com', '1', '1418871608', '');
INSERT INTO `cst_getcode` VALUES ('12', '杨栋', 'yangd@sysware.com.cn', '1', '1418872533', '');

-- ----------------------------
-- Table structure for `cst_hooks`
-- ----------------------------
DROP TABLE IF EXISTS `cst_hooks`;
CREATE TABLE `cst_hooks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(40) NOT NULL DEFAULT '' COMMENT '钩子名称',
  `description` text NOT NULL COMMENT '描述',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '类型',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `addons` varchar(255) NOT NULL DEFAULT '' COMMENT '钩子挂载的插件 ''，''分割',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cst_hooks
-- ----------------------------
INSERT INTO `cst_hooks` VALUES ('1', 'pageHeader', '页面header钩子，一般用于加载插件CSS文件和代码', '1', '0', '');
INSERT INTO `cst_hooks` VALUES ('2', 'pageFooter', '页面footer钩子，一般用于加载插件JS文件和JS代码', '1', '0', 'ReturnTop');
INSERT INTO `cst_hooks` VALUES ('3', 'documentEditForm', '添加编辑表单的 扩展内容钩子', '1', '0', 'Attachment');
INSERT INTO `cst_hooks` VALUES ('4', 'documentDetailAfter', '文档末尾显示', '1', '0', 'Attachment,SocialComment');
INSERT INTO `cst_hooks` VALUES ('5', 'documentDetailBefore', '页面内容前显示用钩子', '1', '0', '');
INSERT INTO `cst_hooks` VALUES ('6', 'documentSaveComplete', '保存文档数据后的扩展钩子', '2', '0', 'Attachment');
INSERT INTO `cst_hooks` VALUES ('7', 'documentEditFormContent', '添加编辑表单的内容显示钩子', '1', '0', 'Editor');
INSERT INTO `cst_hooks` VALUES ('8', 'adminArticleEdit', '后台内容编辑页编辑器', '1', '1378982734', 'EditorForAdmin');
INSERT INTO `cst_hooks` VALUES ('13', 'AdminIndex', '首页小格子个性化显示', '1', '1382596073', 'SiteStat,SystemInfo');
INSERT INTO `cst_hooks` VALUES ('14', 'topicComment', '评论提交方式扩展钩子。', '1', '1380163518', 'Editor');
INSERT INTO `cst_hooks` VALUES ('16', 'app_begin', '应用开始', '2', '1384481614', '');

-- ----------------------------
-- Table structure for `cst_keywords_article`
-- ----------------------------
DROP TABLE IF EXISTS `cst_keywords_article`;
CREATE TABLE `cst_keywords_article` (
  `kid` mediumint(9) NOT NULL COMMENT '关键字id',
  `aid` int(11) NOT NULL COMMENT '图文绑定信息id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cst_keywords_article
-- ----------------------------
INSERT INTO `cst_keywords_article` VALUES ('31', '25');
INSERT INTO `cst_keywords_article` VALUES ('31', '24');
INSERT INTO `cst_keywords_article` VALUES ('31', '23');
INSERT INTO `cst_keywords_article` VALUES ('31', '3');

-- ----------------------------
-- Table structure for `cst_label`
-- ----------------------------
DROP TABLE IF EXISTS `cst_label`;
CREATE TABLE `cst_label` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `title` varchar(60) NOT NULL COMMENT '标签名',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cst_label
-- ----------------------------
INSERT INTO `cst_label` VALUES ('1', '测试标签1');
INSERT INTO `cst_label` VALUES ('2', '测试标签2');
INSERT INTO `cst_label` VALUES ('3', '测试标签3');
INSERT INTO `cst_label` VALUES ('4', '测试标签4');
INSERT INTO `cst_label` VALUES ('5', '测试标签5');
INSERT INTO `cst_label` VALUES ('6', '测试标签6');
INSERT INTO `cst_label` VALUES ('7', '测试标签7');
INSERT INTO `cst_label` VALUES ('8', '测试标签8');
INSERT INTO `cst_label` VALUES ('9', '测试标签9');
INSERT INTO `cst_label` VALUES ('10', '测试标签10');
INSERT INTO `cst_label` VALUES ('11', '测试标签11');
INSERT INTO `cst_label` VALUES ('12', '测试标签12');
INSERT INTO `cst_label` VALUES ('13', '测试标签13');
INSERT INTO `cst_label` VALUES ('14', '测试标签14');
INSERT INTO `cst_label` VALUES ('15', '测试标签15');
INSERT INTO `cst_label` VALUES ('16', '测试标签16');
INSERT INTO `cst_label` VALUES ('17', '测试标签17');
INSERT INTO `cst_label` VALUES ('18', '测试标签18');

-- ----------------------------
-- Table structure for `cst_member`
-- ----------------------------
DROP TABLE IF EXISTS `cst_member`;
CREATE TABLE `cst_member` (
  `uid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `nickname` char(16) NOT NULL DEFAULT '' COMMENT '昵称',
  `sex` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '性别',
  `birthday` date NOT NULL DEFAULT '0000-00-00' COMMENT '生日',
  `qq` char(10) NOT NULL DEFAULT '' COMMENT 'qq号',
  `score` mediumint(8) NOT NULL DEFAULT '0' COMMENT '用户积分',
  `login` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '登录次数',
  `reg_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '注册IP',
  `reg_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `last_login_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '最后登录IP',
  `last_login_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '会员状态',
  PRIMARY KEY (`uid`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='会员表';

-- ----------------------------
-- Records of cst_member
-- ----------------------------
INSERT INTO `cst_member` VALUES ('1', 'superAdmin', '0', '0000-00-00', '', '70', '54', '0', '1416964520', '2130706433', '1419296973', '1');
INSERT INTO `cst_member` VALUES ('2', 'admin', '0', '0000-00-00', '', '20', '67', '0', '0', '2130706433', '1419301098', '1');
INSERT INTO `cst_member` VALUES ('3', 'weiyong', '0', '0000-00-00', '', '0', '0', '0', '0', '0', '0', '1');

-- ----------------------------
-- Table structure for `cst_menu`
-- ----------------------------
DROP TABLE IF EXISTS `cst_menu`;
CREATE TABLE `cst_menu` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文档ID',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '标题',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级分类ID',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序（同级有效）',
  `url` char(255) NOT NULL DEFAULT '' COMMENT '链接地址',
  `hide` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否隐藏',
  `tip` varchar(255) NOT NULL DEFAULT '' COMMENT '提示',
  `group` varchar(50) DEFAULT '' COMMENT '分组',
  `is_dev` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否仅开发者模式可见',
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`)
) ENGINE=MyISAM AUTO_INCREMENT=191 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cst_menu
-- ----------------------------
INSERT INTO `cst_menu` VALUES ('1', '首页', '0', '1', 'Index/index', '0', '', '', '0');
INSERT INTO `cst_menu` VALUES ('2', '内容', '0', '3', 'Article/index?cate_id=2', '0', '', '', '0');
INSERT INTO `cst_menu` VALUES ('3', '文档列表', '2', '0', 'article/index', '1', '', '内容', '0');
INSERT INTO `cst_menu` VALUES ('4', '新增', '3', '0', 'article/add', '0', '', '', '0');
INSERT INTO `cst_menu` VALUES ('5', '编辑', '3', '0', 'article/edit', '0', '', '', '0');
INSERT INTO `cst_menu` VALUES ('6', '改变状态', '3', '0', 'article/setStatus', '0', '', '', '0');
INSERT INTO `cst_menu` VALUES ('7', '保存', '3', '0', 'article/update', '0', '', '', '0');
INSERT INTO `cst_menu` VALUES ('8', '保存草稿', '3', '0', 'article/autoSave', '0', '', '', '0');
INSERT INTO `cst_menu` VALUES ('9', '移动', '3', '0', 'article/move', '1', '', '', '1');
INSERT INTO `cst_menu` VALUES ('10', '复制', '3', '0', 'article/copy', '1', '', '', '1');
INSERT INTO `cst_menu` VALUES ('11', '粘贴', '3', '0', 'article/paste', '1', '', '', '1');
INSERT INTO `cst_menu` VALUES ('12', '导入', '3', '0', 'article/batchOperate', '1', '', '', '1');
INSERT INTO `cst_menu` VALUES ('13', '回收站', '2', '0', 'article/recycle', '1', '', '内容', '0');
INSERT INTO `cst_menu` VALUES ('14', '还原', '13', '0', 'article/permit', '0', '', '', '0');
INSERT INTO `cst_menu` VALUES ('15', '清空', '13', '0', 'article/clear', '0', '', '', '0');
INSERT INTO `cst_menu` VALUES ('16', '管理', '0', '6', 'User/index', '0', '', '', '0');
INSERT INTO `cst_menu` VALUES ('17', '用户信息', '16', '0', 'User/index', '0', '', '用户管理', '0');
INSERT INTO `cst_menu` VALUES ('19', '用户行为', '16', '0', 'User/action', '0', '', '行为管理', '0');
INSERT INTO `cst_menu` VALUES ('20', '新增用户行为', '19', '0', 'User/addaction', '1', '', '', '1');
INSERT INTO `cst_menu` VALUES ('21', '编辑用户行为', '19', '0', 'User/editaction', '0', '', '', '0');
INSERT INTO `cst_menu` VALUES ('22', '保存用户行为', '19', '0', 'User/saveAction', '0', '\"用户->用户行为\"保存编辑和新增的用户行为', '', '0');
INSERT INTO `cst_menu` VALUES ('23', '变更行为状态', '19', '0', 'User/setStatus', '0', '\"用户->用户行为\"中的启用,禁用和删除权限', '', '0');
INSERT INTO `cst_menu` VALUES ('24', '禁用会员', '19', '0', 'User/changeStatus?method=forbidUser', '0', '\"用户->用户信息\"中的禁用', '', '0');
INSERT INTO `cst_menu` VALUES ('25', '启用会员', '19', '0', 'User/changeStatus?method=resumeUser', '0', '\"用户->用户信息\"中的启用', '', '0');
INSERT INTO `cst_menu` VALUES ('26', '删除会员', '19', '0', 'User/changeStatus?method=deleteUser', '0', '\"用户->用户信息\"中的删除', '', '0');
INSERT INTO `cst_menu` VALUES ('27', '权限管理', '16', '0', 'AuthManager/index', '0', '', '用户管理', '0');
INSERT INTO `cst_menu` VALUES ('28', '删除', '27', '0', 'AuthManager/changeStatus?method=deleteGroup', '0', '删除用户组', '', '0');
INSERT INTO `cst_menu` VALUES ('29', '禁用', '27', '0', 'AuthManager/changeStatus?method=forbidGroup', '0', '禁用用户组', '', '0');
INSERT INTO `cst_menu` VALUES ('30', '恢复', '27', '0', 'AuthManager/changeStatus?method=resumeGroup', '0', '恢复已禁用的用户组', '', '0');
INSERT INTO `cst_menu` VALUES ('31', '新增', '27', '0', 'AuthManager/createGroup', '0', '创建新的用户组', '', '0');
INSERT INTO `cst_menu` VALUES ('32', '编辑', '27', '0', 'AuthManager/editGroup', '0', '编辑用户组名称和描述', '', '0');
INSERT INTO `cst_menu` VALUES ('33', '保存用户组', '27', '0', 'AuthManager/writeGroup', '0', '新增和编辑用户组的\"保存\"按钮', '', '0');
INSERT INTO `cst_menu` VALUES ('34', '授权', '27', '0', 'AuthManager/group', '0', '\"后台 \\ 用户 \\ 用户信息\"列表页的\"授权\"操作按钮,用于设置用户所属用户组', '', '0');
INSERT INTO `cst_menu` VALUES ('35', '访问授权', '27', '0', 'AuthManager/access', '0', '\"后台 \\ 用户 \\ 权限管理\"列表页的\"访问授权\"操作按钮', '', '0');
INSERT INTO `cst_menu` VALUES ('36', '成员授权', '27', '0', 'AuthManager/user', '0', '\"后台 \\ 用户 \\ 权限管理\"列表页的\"成员授权\"操作按钮', '', '0');
INSERT INTO `cst_menu` VALUES ('37', '解除授权', '27', '0', 'AuthManager/removeFromGroup', '0', '\"成员授权\"列表页内的解除授权操作按钮', '', '0');
INSERT INTO `cst_menu` VALUES ('38', '保存成员授权', '27', '0', 'AuthManager/addToGroup', '0', '\"用户信息\"列表页\"授权\"时的\"保存\"按钮和\"成员授权\"里右上角的\"添加\"按钮)', '', '0');
INSERT INTO `cst_menu` VALUES ('39', '分类授权', '27', '0', 'AuthManager/category', '0', '\"后台 \\ 用户 \\ 权限管理\"列表页的\"分类授权\"操作按钮', '', '0');
INSERT INTO `cst_menu` VALUES ('40', '保存分类授权', '27', '0', 'AuthManager/addToCategory', '0', '\"分类授权\"页面的\"保存\"按钮', '', '0');
INSERT INTO `cst_menu` VALUES ('41', '模型授权', '27', '0', 'AuthManager/modelauth', '0', '\"后台 \\ 用户 \\ 权限管理\"列表页的\"模型授权\"操作按钮', '', '0');
INSERT INTO `cst_menu` VALUES ('42', '保存模型授权', '27', '0', 'AuthManager/addToModel', '0', '\"分类授权\"页面的\"保存\"按钮', '', '0');
INSERT INTO `cst_menu` VALUES ('43', '设置', '0', '6', 'Addons/index', '0', '', '', '0');
INSERT INTO `cst_menu` VALUES ('44', '插件管理', '43', '1', 'Addons/index', '0', '', '扩展管理', '0');
INSERT INTO `cst_menu` VALUES ('45', '创建', '44', '0', 'Addons/create', '0', '服务器上创建插件结构向导', '', '0');
INSERT INTO `cst_menu` VALUES ('46', '检测创建', '44', '0', 'Addons/checkForm', '0', '检测插件是否可以创建', '', '0');
INSERT INTO `cst_menu` VALUES ('47', '预览', '44', '0', 'Addons/preview', '0', '预览插件定义类文件', '', '0');
INSERT INTO `cst_menu` VALUES ('48', '快速生成插件', '44', '0', 'Addons/build', '0', '开始生成插件结构', '', '0');
INSERT INTO `cst_menu` VALUES ('49', '设置', '44', '0', 'Addons/config', '0', '设置插件配置', '', '0');
INSERT INTO `cst_menu` VALUES ('50', '禁用', '44', '0', 'Addons/disable', '0', '禁用插件', '', '0');
INSERT INTO `cst_menu` VALUES ('51', '启用', '44', '0', 'Addons/enable', '0', '启用插件', '', '0');
INSERT INTO `cst_menu` VALUES ('52', '安装', '44', '0', 'Addons/install', '0', '安装插件', '', '0');
INSERT INTO `cst_menu` VALUES ('53', '卸载', '44', '0', 'Addons/uninstall', '0', '卸载插件', '', '0');
INSERT INTO `cst_menu` VALUES ('54', '更新配置', '44', '0', 'Addons/saveconfig', '0', '更新插件配置处理', '', '0');
INSERT INTO `cst_menu` VALUES ('55', '插件后台列表', '44', '0', 'Addons/adminList', '0', '', '', '0');
INSERT INTO `cst_menu` VALUES ('56', 'URL方式访问插件', '44', '0', 'Addons/execute', '0', '控制是否有权限通过url访问插件控制器方法', '', '0');
INSERT INTO `cst_menu` VALUES ('57', '钩子管理', '43', '2', 'Addons/hooks', '0', '', '扩展管理', '0');
INSERT INTO `cst_menu` VALUES ('58', '模型管理', '68', '3', 'Model/index', '0', '', '系统设置', '0');
INSERT INTO `cst_menu` VALUES ('59', '新增', '58', '0', 'model/add', '0', '', '', '0');
INSERT INTO `cst_menu` VALUES ('60', '编辑', '58', '0', 'model/edit', '0', '', '', '0');
INSERT INTO `cst_menu` VALUES ('61', '改变状态', '58', '0', 'model/setStatus', '0', '', '', '0');
INSERT INTO `cst_menu` VALUES ('62', '保存数据', '58', '0', 'model/update', '0', '', '', '0');
INSERT INTO `cst_menu` VALUES ('63', '属性管理', '68', '0', 'Attribute/index', '1', '网站属性配置。', '', '0');
INSERT INTO `cst_menu` VALUES ('64', '新增', '63', '0', 'Attribute/add', '0', '', '', '0');
INSERT INTO `cst_menu` VALUES ('65', '编辑', '63', '0', 'Attribute/edit', '0', '', '', '0');
INSERT INTO `cst_menu` VALUES ('66', '改变状态', '63', '0', 'Attribute/setStatus', '0', '', '', '0');
INSERT INTO `cst_menu` VALUES ('67', '保存数据', '63', '0', 'Attribute/update', '0', '', '', '0');
INSERT INTO `cst_menu` VALUES ('68', '配置', '0', '4', 'Config/group', '0', '', '', '0');
INSERT INTO `cst_menu` VALUES ('69', '网站设置', '68', '1', 'Config/group', '0', '', '系统设置', '0');
INSERT INTO `cst_menu` VALUES ('70', '配置管理', '68', '4', 'Config/index', '0', '', '系统设置', '0');
INSERT INTO `cst_menu` VALUES ('71', '编辑', '70', '0', 'Config/edit', '0', '新增编辑和保存配置', '', '0');
INSERT INTO `cst_menu` VALUES ('72', '删除', '70', '0', 'Config/del', '0', '删除配置', '', '0');
INSERT INTO `cst_menu` VALUES ('73', '新增', '70', '0', 'Config/add', '0', '新增配置', '', '0');
INSERT INTO `cst_menu` VALUES ('74', '保存', '70', '0', 'Config/save', '0', '保存配置', '', '0');
INSERT INTO `cst_menu` VALUES ('75', '菜单管理', '68', '5', 'Menu/index', '0', '', '系统设置', '0');
INSERT INTO `cst_menu` VALUES ('76', '导航管理', '68', '6', 'Channel/index', '0', '', '系统设置', '0');
INSERT INTO `cst_menu` VALUES ('77', '新增', '76', '0', 'Channel/add', '0', '', '', '0');
INSERT INTO `cst_menu` VALUES ('78', '编辑', '76', '0', 'Channel/edit', '0', '', '', '0');
INSERT INTO `cst_menu` VALUES ('79', '删除', '76', '0', 'Channel/del', '0', '', '', '0');
INSERT INTO `cst_menu` VALUES ('80', '分类管理', '68', '2', 'Category/index', '0', '', '系统设置', '0');
INSERT INTO `cst_menu` VALUES ('81', '编辑', '80', '0', 'Category/edit', '0', '编辑和保存栏目分类', '', '0');
INSERT INTO `cst_menu` VALUES ('82', '新增', '80', '0', 'Category/add', '0', '新增栏目分类', '', '0');
INSERT INTO `cst_menu` VALUES ('83', '删除', '80', '0', 'Category/remove', '0', '删除栏目分类', '', '0');
INSERT INTO `cst_menu` VALUES ('84', '移动', '80', '0', 'Category/operate/type/move', '0', '移动栏目分类', '', '0');
INSERT INTO `cst_menu` VALUES ('85', '合并', '80', '0', 'Category/operate/type/merge', '0', '合并栏目分类', '', '0');
INSERT INTO `cst_menu` VALUES ('86', '备份数据库', '68', '0', 'Database/index?type=export', '0', '', '数据备份', '0');
INSERT INTO `cst_menu` VALUES ('87', '备份', '86', '0', 'Database/export', '0', '备份数据库', '', '0');
INSERT INTO `cst_menu` VALUES ('88', '优化表', '86', '0', 'Database/optimize', '0', '优化数据表', '', '0');
INSERT INTO `cst_menu` VALUES ('89', '修复表', '86', '0', 'Database/repair', '0', '修复数据表', '', '0');
INSERT INTO `cst_menu` VALUES ('90', '还原数据库', '68', '0', 'Database/index?type=import', '0', '', '数据备份', '0');
INSERT INTO `cst_menu` VALUES ('91', '恢复', '90', '0', 'Database/import', '0', '数据库恢复', '', '0');
INSERT INTO `cst_menu` VALUES ('92', '删除', '90', '0', 'Database/del', '0', '删除备份文件', '', '0');
INSERT INTO `cst_menu` VALUES ('93', '其他', '0', '100', 'other', '1', '', '', '0');
INSERT INTO `cst_menu` VALUES ('96', '新增', '75', '0', 'Menu/add', '0', '', '系统设置', '0');
INSERT INTO `cst_menu` VALUES ('98', '编辑', '75', '0', 'Menu/edit', '0', '', '', '0');
INSERT INTO `cst_menu` VALUES ('104', '下载管理', '102', '0', 'Think/lists?model=download', '0', '', '', '0');
INSERT INTO `cst_menu` VALUES ('105', '配置管理', '102', '0', 'Think/lists?model=config', '0', '', '', '0');
INSERT INTO `cst_menu` VALUES ('106', '行为日志', '16', '0', 'Action/actionlog', '0', '', '行为管理', '0');
INSERT INTO `cst_menu` VALUES ('108', '修改密码', '16', '0', 'User/updatePassword', '0', '', '', '0');
INSERT INTO `cst_menu` VALUES ('109', '修改昵称', '16', '0', 'User/updateNickname', '1', '', '', '0');
INSERT INTO `cst_menu` VALUES ('110', '查看行为日志', '106', '0', 'action/edit', '1', '', '', '0');
INSERT INTO `cst_menu` VALUES ('112', '新增数据', '58', '0', 'think/add', '1', '', '', '0');
INSERT INTO `cst_menu` VALUES ('113', '编辑数据', '58', '0', 'think/edit', '1', '', '', '0');
INSERT INTO `cst_menu` VALUES ('114', '导入', '75', '0', 'Menu/import', '0', '', '', '0');
INSERT INTO `cst_menu` VALUES ('115', '生成', '58', '0', 'Model/generate', '0', '', '', '0');
INSERT INTO `cst_menu` VALUES ('116', '新增钩子', '57', '0', 'Addons/addHook', '0', '', '', '0');
INSERT INTO `cst_menu` VALUES ('117', '编辑钩子', '57', '0', 'Addons/edithook', '0', '', '', '0');
INSERT INTO `cst_menu` VALUES ('118', '文档排序', '3', '0', 'Article/sort', '1', '', '', '0');
INSERT INTO `cst_menu` VALUES ('119', '排序', '70', '0', 'Config/sort', '1', '', '', '0');
INSERT INTO `cst_menu` VALUES ('120', '排序', '75', '0', 'Menu/sort', '1', '', '', '0');
INSERT INTO `cst_menu` VALUES ('121', '排序', '76', '0', 'Channel/sort', '1', '', '', '0');
INSERT INTO `cst_menu` VALUES ('122', '微信', '0', '5', 'Weixin/subscribe', '0', '', '', '0');
INSERT INTO `cst_menu` VALUES ('123', '关注回复', '122', '0', 'Weixin/subscribe', '0', '', '微信管理', '0');
INSERT INTO `cst_menu` VALUES ('124', '微网站', '0', '8', 'Home/Index/index', '0', '', '', '0');
INSERT INTO `cst_menu` VALUES ('125', '菜单管理', '122', '0', 'Weixin/menu', '0', '', '微信管理', '0');
INSERT INTO `cst_menu` VALUES ('126', '关键字设置', '122', '0', 'Weixin/keywords', '0', '', '微信管理', '0');
INSERT INTO `cst_menu` VALUES ('127', '新增菜单', '125', '0', 'Weixin/addmenu', '0', '', '', '0');
INSERT INTO `cst_menu` VALUES ('128', '编辑菜单', '125', '0', 'Weixin/editmenu', '0', '', '', '0');
INSERT INTO `cst_menu` VALUES ('129', '新增关键字', '126', '0', 'Weixin/addkeywords', '0', '', '', '0');
INSERT INTO `cst_menu` VALUES ('130', '编辑关键字', '126', '0', 'Weixin/editkeywords', '0', '', '', '0');
INSERT INTO `cst_menu` VALUES ('141', '微信信息记录', '139', '100', 'Weixin/chat', '0', '', '用户管理', '0');
INSERT INTO `cst_menu` VALUES ('132', '普通用户', '139', '4', 'Member/index?gid=1', '0', '', '用户管理', '0');
INSERT INTO `cst_menu` VALUES ('139', '用户', '0', '2', 'Member/Weixinuser', '0', '', '', '0');
INSERT INTO `cst_menu` VALUES ('136', '技术问题', '139', '0', 'Feedback/technology', '0', '', '用户信息反馈', '0');
INSERT INTO `cst_menu` VALUES ('137', '产品问题', '139', '0', 'Feedback/product', '0', '', '用户信息反馈', '0');
INSERT INTO `cst_menu` VALUES ('138', '用户体验', '139', '0', 'Feedback/experience', '0', '', '用户信息反馈', '0');
INSERT INTO `cst_menu` VALUES ('140', '内部用户', '139', '5', 'Member/index?gid=2', '0', '', '用户管理', '0');
INSERT INTO `cst_menu` VALUES ('142', '查看用户详细页', '140', '6', 'Member/view', '1', '', '用户管理', '1');
INSERT INTO `cst_menu` VALUES ('143', '关注用户', '139', '0', 'Member/Weixinuser', '0', '', '用户管理', '0');
INSERT INTO `cst_menu` VALUES ('144', '邮件订阅', '139', '8', 'Member/subscribe', '0', '', '用户管理', '0');
INSERT INTO `cst_menu` VALUES ('145', '添加注册用户', '139', '0', 'Member/setreg', '1', '', '用户管理', '0');
INSERT INTO `cst_menu` VALUES ('146', '用户申请', '139', '7', 'Member/getcode', '0', '', '用户管理', '0');
INSERT INTO `cst_menu` VALUES ('147', '编辑用户信息', '139', '0', 'Member/edit', '1', '', '用户管理', '1');
INSERT INTO `cst_menu` VALUES ('148', '客户资料', '139', '0', 'Member/customer', '0', '', '客户资料管理', '0');
INSERT INTO `cst_menu` VALUES ('149', '增加客户', '148', '0', 'Member/Addcustomer', '1', '', '用户管理', '1');
INSERT INTO `cst_menu` VALUES ('150', '编辑客户资料', '148', '0', 'Member/Editcustomer', '1', '', '用户管理', '1');
INSERT INTO `cst_menu` VALUES ('151', '查看客户资料', '148', '0', 'Member/viewcustomer', '1', '', '用户管理', '1');
INSERT INTO `cst_menu` VALUES ('152', '用户信息反馈预览', '139', '0', 'Feedback/view', '1', '', '用户信息反馈', '1');
INSERT INTO `cst_menu` VALUES ('153', '生成微信菜单', '125', '0', 'Weixin/createmenu', '1', '', '', '1');
INSERT INTO `cst_menu` VALUES ('154', '公司管理', '68', '0', 'Company/index', '0', '', '组织机构', '0');
INSERT INTO `cst_menu` VALUES ('155', '增加公司或部门', '154', '0', 'Company/add', '1', '', '用户信息设置', '1');
INSERT INTO `cst_menu` VALUES ('156', '修改公司或部门', '154', '0', 'Company/edit', '1', '', '用户信息设置', '1');
INSERT INTO `cst_menu` VALUES ('157', '用户标签管理', '68', '0', 'Label/index', '0', '', '用户标签', '0');
INSERT INTO `cst_menu` VALUES ('158', '增加用户标签', '157', '0', 'Label/add', '1', '', '用户信息设置', '1');
INSERT INTO `cst_menu` VALUES ('159', '修改用户标签', '157', '0', 'Label/edit', '1', '', '用户信息设置', '1');
INSERT INTO `cst_menu` VALUES ('160', '产品问题关键词', '68', '0', 'Productkey/index', '0', '', '关键词', '0');
INSERT INTO `cst_menu` VALUES ('161', '增加产品问题关键词', '160', '0', 'Productkey/add', '1', '', '产品问题关键词', '1');
INSERT INTO `cst_menu` VALUES ('162', '编辑产品问题关键词', '160', '0', 'Productkey/edit', '1', '', '产品问题关键词', '1');
INSERT INTO `cst_menu` VALUES ('163', '技术问题关键词', '68', '0', 'Technologykey/index', '0', '', '关键词', '0');
INSERT INTO `cst_menu` VALUES ('164', '新增技术问题关键词', '163', '0', 'Technologykey/add', '1', '', '用户信息设置', '1');
INSERT INTO `cst_menu` VALUES ('165', '编辑技术问题关键词', '163', '0', 'Technologykey/edit', '1', '', '用户信息设置', '1');
INSERT INTO `cst_menu` VALUES ('166', '标签用户列表', '157', '0', 'Label/view', '1', '', '用户信息设置', '1');
INSERT INTO `cst_menu` VALUES ('187', '从关键词中移除', '160', '0', 'Productkey/remove', '1', '', '产品问题关键词', '1');
INSERT INTO `cst_menu` VALUES ('186', '从标签中移除', '157', '0', 'Label/remove', '1', '', '用户信息设置', '1');
INSERT INTO `cst_menu` VALUES ('169', '用户通用状态处理', '139', '0', 'Member/state', '1', '', '用户管理', '1');
INSERT INTO `cst_menu` VALUES ('170', '用户通用删除', '139', '0', 'Member/deletedo', '1', '', '用户管理', '1');
INSERT INTO `cst_menu` VALUES ('171', '用户通用批量删除', '139', '0', 'Member/dodelete', '1', '', '用户管理', '1');
INSERT INTO `cst_menu` VALUES ('172', '反馈信息通用删除', '139', '0', 'Feedback/deletedo', '1', '', '用户信息反馈', '1');
INSERT INTO `cst_menu` VALUES ('173', '反馈信息通用状态设置', '139', '0', 'Feedback/state', '1', '', '用户信息反馈', '1');
INSERT INTO `cst_menu` VALUES ('174', '用户信息反馈通用批量删除', '139', '0', 'Feedback/dolete', '1', '', '用户信息反馈', '1');
INSERT INTO `cst_menu` VALUES ('175', '微信通用状态设置', '122', '0', 'Weixin/Stateset', '1', '', '微信管理', '1');
INSERT INTO `cst_menu` VALUES ('176', '微信通用删除', '122', '0', 'Weixin/Stateset', '1', '', '微信管理', '1');
INSERT INTO `cst_menu` VALUES ('177', '增加或修改公司。部门', '154', '0', 'Company/update', '0', '', '用户信息设置', '0');
INSERT INTO `cst_menu` VALUES ('178', '增加或修改用户标签', '157', '0', 'Label/update', '1', '', '用户信息设置', '1');
INSERT INTO `cst_menu` VALUES ('179', '增加或修改产品问题关键词', '160', '0', 'Productkey/update', '1', '', '产品问题关键词', '1');
INSERT INTO `cst_menu` VALUES ('180', '技术问题关键词', '163', '0', 'Technologykey/update', '1', '', '技术问题关键词', '1');
INSERT INTO `cst_menu` VALUES ('181', '用户申请审核', '146', '0', 'Member/check', '1', '', '用户信息', '1');
INSERT INTO `cst_menu` VALUES ('182', '  增加管理用户', '17', '0', 'User/add', '1', '', '', '1');
INSERT INTO `cst_menu` VALUES ('183', '查看标签下的用户', '157', '0', 'Label/detail', '1', '', '用户信息设置', '1');
INSERT INTO `cst_menu` VALUES ('184', '关键词下的问题列表', '160', '0', 'Productkey/detail', '1', '', '产品问题关键词', '1');
INSERT INTO `cst_menu` VALUES ('185', '关键词下的问题列表', '163', '0', 'Technologykey/detail', '1', '', '技术问题关键词', '1');
INSERT INTO `cst_menu` VALUES ('188', '从关键词中移除', '163', '0', 'Technologykey/remove', '1', '', '技术问题关键词', '1');
INSERT INTO `cst_menu` VALUES ('189', '查看关键词问题', '160', '0', 'Productkey/view', '1', '', '产品问题关键词', '1');
INSERT INTO `cst_menu` VALUES ('190', '查看关键词问题', '163', '0', 'Technologykey/view', '1', '', '技术问题关键词', '1');

-- ----------------------------
-- Table structure for `cst_model`
-- ----------------------------
DROP TABLE IF EXISTS `cst_model`;
CREATE TABLE `cst_model` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '模型ID',
  `name` char(30) NOT NULL DEFAULT '' COMMENT '模型标识',
  `title` char(30) NOT NULL DEFAULT '' COMMENT '模型名称',
  `extend` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '继承的模型',
  `relation` varchar(30) NOT NULL DEFAULT '' COMMENT '继承与被继承模型的关联字段',
  `need_pk` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '新建表时是否需要主键字段',
  `field_sort` text NOT NULL COMMENT '表单字段排序',
  `field_group` varchar(255) NOT NULL DEFAULT '1:基础' COMMENT '字段分组',
  `attribute_list` text NOT NULL COMMENT '属性列表（表的字段）',
  `template_list` varchar(100) NOT NULL DEFAULT '' COMMENT '列表模板',
  `template_add` varchar(100) NOT NULL DEFAULT '' COMMENT '新增模板',
  `template_edit` varchar(100) NOT NULL DEFAULT '' COMMENT '编辑模板',
  `list_grid` text NOT NULL COMMENT '列表定义',
  `list_row` smallint(2) unsigned NOT NULL DEFAULT '10' COMMENT '列表数据长度',
  `search_key` varchar(50) NOT NULL DEFAULT '' COMMENT '默认搜索字段',
  `search_list` varchar(255) NOT NULL DEFAULT '' COMMENT '高级搜索的字段',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态',
  `engine_type` varchar(25) NOT NULL DEFAULT 'MyISAM' COMMENT '数据库引擎',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='文档模型表';

-- ----------------------------
-- Records of cst_model
-- ----------------------------
INSERT INTO `cst_model` VALUES ('1', 'document', '基础文档', '0', '', '1', '{\"1\":[\"1\",\"2\",\"3\",\"4\",\"5\",\"6\",\"7\",\"8\",\"9\",\"10\",\"11\",\"12\",\"13\",\"14\",\"15\",\"16\",\"17\",\"18\",\"19\",\"20\",\"21\",\"22\"]}', '1:基础', '', '', '', '', 'id:编号\r\ntitle:标题:article/index?cate_id=[category_id]&pid=[id]\r\ntype|get_document_type:类型\r\nlevel:优先级\r\nupdate_time|time_format:最后更新\r\nstatus_text:状态\r\nview:浏览\r\nid:操作:[EDIT]&cate_id=[category_id]|编辑,article/setstatus?status=-1&ids=[id]|删除', '0', '', '', '1383891233', '1384507827', '0', 'MyISAM');
INSERT INTO `cst_model` VALUES ('2', 'article', '文章', '1', '', '1', '{\"1\":[\"3\",\"24\",\"2\",\"11\",\"5\",\"12\"],\"2\":[\"9\",\"13\",\"19\",\"10\",\"16\",\"17\",\"26\",\"20\",\"14\",\"25\"]}', '1:基础,2:扩展', '', '', '', '', 'id:编号\r\ntitle:标题:article/edit?cate_id=[category_id]&id=[id]\r\ncontent:内容', '0', '', '', '1383891243', '1417593539', '1', 'MyISAM');
INSERT INTO `cst_model` VALUES ('3', 'download', '下载', '1', '', '1', '{\"1\":[\"3\",\"28\",\"30\",\"32\",\"2\",\"5\",\"31\"],\"2\":[\"13\",\"10\",\"27\",\"9\",\"12\",\"16\",\"17\",\"19\",\"11\",\"20\",\"14\",\"29\"]}', '1:基础,2:扩展', '', '', '', '', 'id:编号\r\ntitle:标题', '0', '', '', '1383891252', '1387260449', '1', 'MyISAM');
INSERT INTO `cst_model` VALUES ('5', 'chanpin', '产品', '1', '', '1', '{\"1\":[\"3\",\"2\",\"5\",\"42\",\"39\",\"41\",\"40\"],\"2\":[\"11\",\"12\",\"13\",\"17\",\"9\",\"10\",\"20\",\"14\",\"19\",\"16\"]}', '1:基础,2:扩展', '', '', '', '', 'id:编号\r\ntitle:产品名称', '10', '', '', '1417605279', '1417657859', '1', 'MyISAM');

-- ----------------------------
-- Table structure for `cst_picture`
-- ----------------------------
DROP TABLE IF EXISTS `cst_picture`;
CREATE TABLE `cst_picture` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id自增',
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT '路径',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '图片链接',
  `md5` char(32) NOT NULL DEFAULT '' COMMENT '文件md5',
  `sha1` char(40) NOT NULL DEFAULT '' COMMENT '文件 sha1编码',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '状态',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cst_picture
-- ----------------------------
INSERT INTO `cst_picture` VALUES ('1', '/Uploads/Picture/2014-12-03/547ec2ec01db3.png', '', '04f7995d7d044fce30c9bf9381afa5a7', '6e09e53d4b0bd85e9f80df693e85ed08324582c8', '1', '1417593579');
INSERT INTO `cst_picture` VALUES ('2', '/Uploads/Picture/2014-12-03/547ee5bc7d814.png', '', '908c6e719c4fe67dd6b4442477599139', 'd7c41cc771f3fe51882e2db84120162a849ca03d', '1', '1417602492');
INSERT INTO `cst_picture` VALUES ('3', '/Uploads/Picture/2014-12-03/547ee67d6c219.png', '', '5fa7cefc4d2f6b95d10d5dfb1e3debd6', 'd8f57d988330881f16c8e49a46532265ee536eee', '1', '1417602685');
INSERT INTO `cst_picture` VALUES ('4', '/Uploads/Picture/2014-12-03/547ee6825011b.png', '', 'fd6d7f590d8438df90684dfc12fcbac3', 'b7c0c5fb48f02545c2e1ea3c0ede0a19e6329dc7', '1', '1417602690');
INSERT INTO `cst_picture` VALUES ('5', '/Uploads/Picture/2014-12-03/547eeee7d5ee5.jpg', '', '4bc147d30e089deaaa2bfc6e977d7bb7', 'be3ce801d92ffe0dd6bf059d7acb5dd47e361607', '1', '1417604839');
INSERT INTO `cst_picture` VALUES ('6', '/Uploads/Picture/2014-12-03/547eeef5bcea4.jpg', '', '5dec75b727491808df04358514d6d5c0', '71658b298b813d1d18859161bab5d70655aa678b', '1', '1417604853');
INSERT INTO `cst_picture` VALUES ('7', '/Uploads/Picture/2014-12-03/547eeef9412aa.jpg', '', '391a18c3af60e35ce4687b31958d9b39', 'ce31d1b0392b1884d5bc8e5a5280c025d290c69e', '1', '1417604857');

-- ----------------------------
-- Table structure for `cst_product`
-- ----------------------------
DROP TABLE IF EXISTS `cst_product`;
CREATE TABLE `cst_product` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `product_id` int(11) NOT NULL COMMENT '产品id',
  `ptype` smallint(6) NOT NULL COMMENT '产品问题类型',
  `p_description` varchar(300) NOT NULL COMMENT '问题描述',
  `type` tinyint(1) NOT NULL COMMENT '反馈方式',
  `time` tinyint(1) NOT NULL COMMENT '反馈时间 ',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态0待处理，1正在处理，2已答复',
  `create_time` int(11) NOT NULL COMMENT '反馈时间',
  `uid` mediumint(9) NOT NULL COMMENT '用户id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cst_product
-- ----------------------------
INSERT INTO `cst_product` VALUES ('1', '23', '1', '产品', '1', '1', '1', '1418820566', '1');
INSERT INTO `cst_product` VALUES ('2', '23', '1', '你好', '1', '1', '0', '1418872943', '6');
INSERT INTO `cst_product` VALUES ('3', '24', '4', '我', '1', '1', '0', '1418873232', '3');
INSERT INTO `cst_product` VALUES ('4', '25', '2', '', '1', '1', '0', '1418873389', '7');
INSERT INTO `cst_product` VALUES ('5', '23', '1', '', '1', '1', '0', '1419302682', '1');
INSERT INTO `cst_product` VALUES ('6', '24', '2', '', '1', '1', '0', '1419302693', '1');
INSERT INTO `cst_product` VALUES ('7', '24', '3', '', '1', '1', '0', '1419302704', '1');

-- ----------------------------
-- Table structure for `cst_productkey`
-- ----------------------------
DROP TABLE IF EXISTS `cst_productkey`;
CREATE TABLE `cst_productkey` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '频道ID',
  `title` char(30) NOT NULL COMMENT '关键字名称',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cst_productkey
-- ----------------------------
INSERT INTO `cst_productkey` VALUES ('1', '产品问题key1', '1417050536', '1418733754');
INSERT INTO `cst_productkey` VALUES ('2', '产品问题key2', '1417050536', '0');
INSERT INTO `cst_productkey` VALUES ('3', '产品问题key3', '1417050536', '0');
INSERT INTO `cst_productkey` VALUES ('4', '产品问题key4', '1417050536', '0');
INSERT INTO `cst_productkey` VALUES ('5', '产品问题key5', '1418377156', '0');
INSERT INTO `cst_productkey` VALUES ('6', '产品问题key6', '1418377156', '0');
INSERT INTO `cst_productkey` VALUES ('7', '产品问题key7', '1418377156', '0');
INSERT INTO `cst_productkey` VALUES ('8', '产品问题key8', '1418632901', '1418733743');
INSERT INTO `cst_productkey` VALUES ('9', '产品问题key9', '1418733759', '0');

-- ----------------------------
-- Table structure for `cst_pro_key`
-- ----------------------------
DROP TABLE IF EXISTS `cst_pro_key`;
CREATE TABLE `cst_pro_key` (
  `pid` int(11) NOT NULL COMMENT '产品反馈信息id',
  `kid` int(11) NOT NULL COMMENT '8关键字id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cst_pro_key
-- ----------------------------
INSERT INTO `cst_pro_key` VALUES ('6', '3');
INSERT INTO `cst_pro_key` VALUES ('6', '4');
INSERT INTO `cst_pro_key` VALUES ('6', '5');
INSERT INTO `cst_pro_key` VALUES ('6', '6');
INSERT INTO `cst_pro_key` VALUES ('6', '7');
INSERT INTO `cst_pro_key` VALUES ('7', '2');
INSERT INTO `cst_pro_key` VALUES ('7', '8');

-- ----------------------------
-- Table structure for `cst_subscribe`
-- ----------------------------
DROP TABLE IF EXISTS `cst_subscribe`;
CREATE TABLE `cst_subscribe` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `email` varchar(255) NOT NULL COMMENT '标题',
  `create_time` int(11) NOT NULL COMMENT '反馈时间',
  `uid` mediumint(9) NOT NULL COMMENT '用户id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cst_subscribe
-- ----------------------------

-- ----------------------------
-- Table structure for `cst_technology`
-- ----------------------------
DROP TABLE IF EXISTS `cst_technology`;
CREATE TABLE `cst_technology` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `title` varchar(30) NOT NULL COMMENT '标题',
  `kid` mediumint(9) NOT NULL COMMENT '关键字',
  `type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '反馈方式',
  `time` tinyint(1) NOT NULL DEFAULT '1' COMMENT '反馈时间',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态0待处理，1正在处理，2已答复',
  `create_time` int(11) NOT NULL COMMENT '反馈时间',
  `uid` mediumint(9) NOT NULL COMMENT '用户id',
  `p_description` varchar(300) NOT NULL COMMENT '描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cst_technology
-- ----------------------------
INSERT INTO `cst_technology` VALUES ('1', '有个问题', '1', '1', '1', '1', '1418872556', '4', '问题内容');
INSERT INTO `cst_technology` VALUES ('2', 'cgggv', '2', '2', '2', '0', '1418872599', '5', 'f g vvvh h f cc cf v j nv g');
INSERT INTO `cst_technology` VALUES ('3', 'cgggv', '3', '2', '2', '0', '1418872599', '5', 'f g vvvh h f cc cf v j nv g');
INSERT INTO `cst_technology` VALUES ('4', '你好章磊', '4', '1', '1', '0', '1418872666', '6', '啥');
INSERT INTO `cst_technology` VALUES ('5', 'hhhh', '5', '1', '1', '0', '1418873277', '9', 'hhhhhjjjjkkkkk');
INSERT INTO `cst_technology` VALUES ('6', 'hhhh', '6', '1', '1', '1', '1418873278', '9', 'hhhhhjjjjkkkkk');
INSERT INTO `cst_technology` VALUES ('7', 'test', '7', '1', '1', '0', '1418874112', '7', 'testtesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttest');

-- ----------------------------
-- Table structure for `cst_technologykey`
-- ----------------------------
DROP TABLE IF EXISTS `cst_technologykey`;
CREATE TABLE `cst_technologykey` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '频道ID',
  `title` char(30) NOT NULL COMMENT '关键字名称',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cst_technologykey
-- ----------------------------
INSERT INTO `cst_technologykey` VALUES ('1', '技术问题关键字', '1416900127', '1416900127');
INSERT INTO `cst_technologykey` VALUES ('2', '关键字2', '1416900127', '1416900127');
INSERT INTO `cst_technologykey` VALUES ('3', '关键字3', '1416900127', '0');
INSERT INTO `cst_technologykey` VALUES ('4', '关键字4', '1416900127', '0');
INSERT INTO `cst_technologykey` VALUES ('5', '关键字5', '1416900127', '0');
INSERT INTO `cst_technologykey` VALUES ('6', '关键字6', '1418369651', '0');
INSERT INTO `cst_technologykey` VALUES ('7', '新关键字1', '1418369823', '0');
INSERT INTO `cst_technologykey` VALUES ('8', '新关键字2', '1418369823', '0');
INSERT INTO `cst_technologykey` VALUES ('9', '新关键字3', '1418369823', '0');
INSERT INTO `cst_technologykey` VALUES ('10', '新关键字4', '1418369823', '0');
INSERT INTO `cst_technologykey` VALUES ('11', '新关键字6', '1418369823', '0');
INSERT INTO `cst_technologykey` VALUES ('13', 'v gun c f f', '1418872599', '0');

-- ----------------------------
-- Table structure for `cst_tech_key`
-- ----------------------------
DROP TABLE IF EXISTS `cst_tech_key`;
CREATE TABLE `cst_tech_key` (
  `tid` int(11) NOT NULL,
  `kid` int(11) NOT NULL COMMENT '关键字id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cst_tech_key
-- ----------------------------
INSERT INTO `cst_tech_key` VALUES ('1', '1');
INSERT INTO `cst_tech_key` VALUES ('1', '2');
INSERT INTO `cst_tech_key` VALUES ('2', '13');
INSERT INTO `cst_tech_key` VALUES ('2', '6');
INSERT INTO `cst_tech_key` VALUES ('2', '10');
INSERT INTO `cst_tech_key` VALUES ('2', '2');
INSERT INTO `cst_tech_key` VALUES ('3', '13');
INSERT INTO `cst_tech_key` VALUES ('3', '6');
INSERT INTO `cst_tech_key` VALUES ('3', '10');
INSERT INTO `cst_tech_key` VALUES ('3', '2');
INSERT INTO `cst_tech_key` VALUES ('4', '13');

-- ----------------------------
-- Table structure for `cst_ucenter_admin`
-- ----------------------------
DROP TABLE IF EXISTS `cst_ucenter_admin`;
CREATE TABLE `cst_ucenter_admin` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '管理员ID',
  `member_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '管理员用户ID',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '管理员状态',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='管理员表';

-- ----------------------------
-- Records of cst_ucenter_admin
-- ----------------------------

-- ----------------------------
-- Table structure for `cst_ucenter_app`
-- ----------------------------
DROP TABLE IF EXISTS `cst_ucenter_app`;
CREATE TABLE `cst_ucenter_app` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '应用ID',
  `title` varchar(30) NOT NULL COMMENT '应用名称',
  `url` varchar(100) NOT NULL COMMENT '应用URL',
  `ip` char(15) NOT NULL COMMENT '应用IP',
  `auth_key` varchar(100) NOT NULL COMMENT '加密KEY',
  `sys_login` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '同步登陆',
  `allow_ip` varchar(255) NOT NULL COMMENT '允许访问的IP',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '应用状态',
  PRIMARY KEY (`id`),
  KEY `status` (`status`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='应用表';

-- ----------------------------
-- Records of cst_ucenter_app
-- ----------------------------

-- ----------------------------
-- Table structure for `cst_ucenter_member`
-- ----------------------------
DROP TABLE IF EXISTS `cst_ucenter_member`;
CREATE TABLE `cst_ucenter_member` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` char(16) NOT NULL COMMENT '用户名',
  `password` char(32) NOT NULL COMMENT '密码',
  `email` char(32) NOT NULL COMMENT '用户邮箱',
  `mobile` char(15) NOT NULL COMMENT '用户手机',
  `reg_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `reg_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '注册IP',
  `last_login_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `last_login_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '最后登录IP',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) DEFAULT '0' COMMENT '用户状态',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of cst_ucenter_member
-- ----------------------------
INSERT INTO `cst_ucenter_member` VALUES ('1', 'pami', '4a0065997b56a6991afcb87929333043', 'weiyong.me@qq.com', '', '1416964520', '2130706433', '1419296973', '2130706433', '1416964520', '1');
INSERT INTO `cst_ucenter_member` VALUES ('2', 'admin', '4a0065997b56a6991afcb87929333043', 'zhanglei@sysware.com.cn', '', '1418692118', '2130706433', '1419301098', '2130706433', '1418692118', '1');
INSERT INTO `cst_ucenter_member` VALUES ('3', 'weiyong', 'f59252c252bff8b91481c7ec220f21b2', 'weiyong@qq.com', '', '1418862840', '243513319', '0', '0', '1418862840', '1');

-- ----------------------------
-- Table structure for `cst_ucenter_setting`
-- ----------------------------
DROP TABLE IF EXISTS `cst_ucenter_setting`;
CREATE TABLE `cst_ucenter_setting` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '设置ID',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '配置类型（1-用户配置）',
  `value` text NOT NULL COMMENT '配置数据',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='设置表';

-- ----------------------------
-- Records of cst_ucenter_setting
-- ----------------------------

-- ----------------------------
-- Table structure for `cst_url`
-- ----------------------------
DROP TABLE IF EXISTS `cst_url`;
CREATE TABLE `cst_url` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '链接唯一标识',
  `url` char(255) NOT NULL DEFAULT '' COMMENT '链接地址',
  `short` char(100) NOT NULL DEFAULT '' COMMENT '短网址',
  `status` tinyint(2) NOT NULL DEFAULT '2' COMMENT '状态',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_url` (`url`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='链接表';

-- ----------------------------
-- Records of cst_url
-- ----------------------------

-- ----------------------------
-- Table structure for `cst_userdata`
-- ----------------------------
DROP TABLE IF EXISTS `cst_userdata`;
CREATE TABLE `cst_userdata` (
  `uid` int(10) unsigned NOT NULL COMMENT '用户id',
  `type` tinyint(3) unsigned NOT NULL COMMENT '类型标识',
  `target_id` int(10) unsigned NOT NULL COMMENT '目标id',
  UNIQUE KEY `uid` (`uid`,`type`,`target_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cst_userdata
-- ----------------------------

-- ----------------------------
-- Table structure for `cst_users`
-- ----------------------------
DROP TABLE IF EXISTS `cst_users`;
CREATE TABLE `cst_users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `realname` varchar(30) NOT NULL COMMENT '真实姓名',
  `email` char(32) NOT NULL COMMENT '用户邮箱',
  `mobile` char(15) NOT NULL COMMENT '用户手机',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '用户状态0取消关注1关注中',
  `companyid` smallint(6) NOT NULL COMMENT '公司id',
  `departmentid` smallint(6) NOT NULL COMMENT '部门id',
  `reg_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `last_login_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `eid` varchar(60) NOT NULL COMMENT '工业电子id',
  `gid` tinyint(4) NOT NULL DEFAULT '1' COMMENT '用户分组',
  `openid` varchar(64) NOT NULL COMMENT '微信openid',
  `order` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否订阅邮件',
  `code` varchar(20) NOT NULL COMMENT '用户邀请码',
  `save` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否可以修改用户信息',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of cst_users
-- ----------------------------
INSERT INTO `cst_users` VALUES ('1', '魏永', 'weiyong.me@qq.com', '', '1', '0', '0', '1418819910', '1418985580', '0', '', '2', 'o2AIEtzDbzdvaFHmaPk2pdTwxQbM', '1', 'weiyong', '1');
INSERT INTO `cst_users` VALUES ('3', '李晋', '876837383@qq.com', '', '1', '0', '0', '1418871805', '0', '0', '', '2', '', '0', 'lijin1234', '0');
INSERT INTO `cst_users` VALUES ('4', '魏晨', 'weichen@qq.com', '', '1', '2', '7', '1418872077', '1418872150', '0', 'licehn', '1', 'o2AIEt5WbnzZxoIwqeTG80Yk7KjU', '0', 'weichen', '0');
INSERT INTO `cst_users` VALUES ('5', '毛小毛', 'maoj@sysware.com.cn', '18500525477', '1', '0', '0', '1418872115', '1419241084', '0', '', '1', 'o2AIEt1WMLxNvxK6G2oFHnVxy8OM', '1', 'maoxiaomao', '0');
INSERT INTO `cst_users` VALUES ('6', '章磊', 'zhanglei@sysware.com.cn', '', '1', '0', '0', '1418872319', '1419241090', '0', '', '1', '', '0', 'zhanglei', '0');
INSERT INTO `cst_users` VALUES ('7', '杨栋', 'yangd@sysware.com.cn', '18991399422', '1', '2', '7', '1418872706', '1418873045', '0', '', '2', 'o2AIEt8DEwawpypoHs0b5O8QgG3c', '0', 'yangdong', '0');
INSERT INTO `cst_users` VALUES ('8', '李晓妍', 'lixy@sysware.com', '', '1', '0', '0', '1418872812', '1419241096', '0', '', '1', '', '0', 'lixiaoyan', '0');
INSERT INTO `cst_users` VALUES ('9', 'lzflzf', '11@sina.com', '', '1', '0', '0', '1418872825', '1419241102', '0', '', '1', '', '0', 'lizhifeng', '0');

-- ----------------------------
-- Table structure for `cst_users_product`
-- ----------------------------
DROP TABLE IF EXISTS `cst_users_product`;
CREATE TABLE `cst_users_product` (
  `uid` int(11) NOT NULL COMMENT '用户id',
  `pid` int(11) NOT NULL COMMENT '产品id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cst_users_product
-- ----------------------------

-- ----------------------------
-- Table structure for `cst_user_label`
-- ----------------------------
DROP TABLE IF EXISTS `cst_user_label`;
CREATE TABLE `cst_user_label` (
  `uid` int(11) NOT NULL COMMENT '用户id',
  `labelid` int(11) NOT NULL COMMENT '产品id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cst_user_label
-- ----------------------------
INSERT INTO `cst_user_label` VALUES ('4', '1');
INSERT INTO `cst_user_label` VALUES ('4', '16');
INSERT INTO `cst_user_label` VALUES ('1', '7');
INSERT INTO `cst_user_label` VALUES ('1', '8');
INSERT INTO `cst_user_label` VALUES ('1', '9');
INSERT INTO `cst_user_label` VALUES ('5', '1');
INSERT INTO `cst_user_label` VALUES ('8', '1');

-- ----------------------------
-- Table structure for `cst_weixin_keywords`
-- ----------------------------
DROP TABLE IF EXISTS `cst_weixin_keywords`;
CREATE TABLE `cst_weixin_keywords` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(30) NOT NULL COMMENT '菜单名称',
  `type` varchar(10) NOT NULL DEFAULT 'text' COMMENT '响应的信息text,news',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否启用1是0不是',
  `create_time` int(11) NOT NULL COMMENT '增加时间',
  `update_time` int(11) NOT NULL COMMENT '更新时间',
  `content` text NOT NULL COMMENT '文本里的信息',
  UNIQUE KEY `mid_UNIQUE` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cst_weixin_keywords
-- ----------------------------
INSERT INTO `cst_weixin_keywords` VALUES ('1', '1', 'text', '1', '1418270681', '1418794975', '&lt;p&gt;点击&lt;a title=&quot;&quot; target=&quot;_self&quot; href=&quot;http://juba.aipami.com/cst/index.php?m=&amp;amp;m=Home&amp;amp;c=Public&amp;amp;a=login&quot;&gt;用邀请码登录&lt;/a&gt;&lt;/p&gt;');
INSERT INTO `cst_weixin_keywords` VALUES ('2', '2', 'text', '1', '1418278375', '1418795036', '暂无技术支持人员信息&lt;br/&gt;');
INSERT INTO `cst_weixin_keywords` VALUES ('8', 'D', 'text', '1', '1418795746', '0', '&lt;p&gt;点击&lt;a title=&quot;&quot; target=&quot;_self&quot; href=&quot;http://juba.aipami.com/cst/index.php?m=Home&amp;amp;c=Article&amp;amp;a=resource&quot;&gt;进入获取技术资料&lt;/a&gt;&lt;/p&gt;');
INSERT INTO `cst_weixin_keywords` VALUES ('3', '3', 'text', '1', '1418278375', '1418799268', '&lt;p&gt;A 用户登录&lt;br/&gt;B 查看/更新个人信息&lt;br/&gt;C 沟通技术问题&lt;br/&gt;D 获取技术资料&lt;br/&gt;E 反映产品问题&lt;br/&gt;F 参与用户体验反馈&lt;br/&gt;G 获取技术支持&lt;br/&gt;H 帮助&lt;/p&gt;');
INSERT INTO `cst_weixin_keywords` VALUES ('4', '菜单', 'text', '1', '1418278375', '1418795806', '&lt;p&gt;A 用户登录&lt;br/&gt;B 查看/更新个人信息&lt;br/&gt;C 沟通技术问题&lt;br/&gt;D 获取技术资料&lt;br/&gt;E 反映产品问题&lt;br/&gt;F 参与用户体验反馈&lt;br/&gt;G 获取技术支持&lt;br/&gt;H 帮助&lt;/p&gt;');
INSERT INTO `cst_weixin_keywords` VALUES ('5', 'A', 'text', '1', '1418349162', '1418795486', '&lt;p&gt;点击&lt;a title=&quot;&quot; target=&quot;_self&quot; href=&quot;http://juba.aipami.com/cst/index.php?m=&amp;amp;m=Home&amp;amp;c=Public&amp;amp;a=login&quot;&gt;用户登录&lt;/a&gt;&lt;/p&gt;');
INSERT INTO `cst_weixin_keywords` VALUES ('6', 'B', 'text', '1', '1418349206', '1418795556', '&lt;p&gt;点击&lt;a textvalue=&quot;进入查看/更新个人信息&quot; title=&quot;&quot; target=&quot;_self&quot; href=&quot;http://juba.aipami.com/cst/index.php?m=Home&amp;amp;c=User&amp;amp;a=index&quot;&gt;进入查看/更新个人信息&lt;/a&gt;&lt;/p&gt;');
INSERT INTO `cst_weixin_keywords` VALUES ('7', 'C', 'text', '1', '1418698530', '1418795670', '&lt;p&gt;点击&lt;a textvalue=&quot;沟通技术问题&quot; title=&quot;&quot; target=&quot;_self&quot; href=&quot;http://juba.aipami.com/cst/index.php?m=Home&amp;amp;c=User&amp;amp;a=technology&quot;&gt;沟通技术问题&lt;/a&gt;&lt;/p&gt;');
INSERT INTO `cst_weixin_keywords` VALUES ('9', 'E', 'text', '1', '1418795756', '1418795956', '&lt;p&gt;点击&lt;a title=&quot;&quot; target=&quot;_self&quot; href=&quot;http://juba.aipami.com/cst/index.php?m=Home&amp;amp;c=User&amp;amp;a=product&quot;&gt;进入反映产品问题&lt;/a&gt;&lt;/p&gt;');
INSERT INTO `cst_weixin_keywords` VALUES ('10', 'F', 'text', '1', '1418795763', '1418795997', '&lt;p&gt;用户体验反馈功能开发中&lt;/p&gt;');
INSERT INTO `cst_weixin_keywords` VALUES ('11', 'G', 'text', '1', '1418795770', '1418820644', '&lt;p&gt;暂无技术支持人员信息列表&lt;/p&gt;');
INSERT INTO `cst_weixin_keywords` VALUES ('12', 'H', 'text', '1', '1418795780', '1418796612', '&lt;p&gt;暂无帮助信息&lt;br/&gt;&lt;/p&gt;');
INSERT INTO `cst_weixin_keywords` VALUES ('13', '?', 'text', '1', '1418795837', '0', '&lt;p&gt;A 用户登录&lt;br/&gt;B 查看/更新个人信息&lt;br/&gt;C 沟通技术问题&lt;br/&gt;D 获取技术资料&lt;br/&gt;E 反映产品问题&lt;br/&gt;F 参与用户体验反馈&lt;br/&gt;G 获取技术支持&lt;br/&gt;H 帮助&lt;/p&gt;');
INSERT INTO `cst_weixin_keywords` VALUES ('14', 'add', 'text', '1', '1418956954', '0', '&lt;p&gt;请输入信息&lt;/p&gt;&lt;p&gt;格式&amp;quot;张三%13888888888%13888888888@qq.com%北京索为高科系统技术有限公司&amp;quot;&lt;/p&gt;');
INSERT INTO `cst_weixin_keywords` VALUES ('15', 'save', 'text', '1', '1418957276', '1419218746', '&lt;p&gt;请输入要修改客户的信息,如#张三&lt;/p&gt;');

-- ----------------------------
-- Table structure for `cst_weixin_menu`
-- ----------------------------
DROP TABLE IF EXISTS `cst_weixin_menu`;
CREATE TABLE `cst_weixin_menu` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `name` char(20) NOT NULL COMMENT '菜单名称',
  `pid` smallint(6) NOT NULL COMMENT '菜单父类id',
  `type` varchar(20) NOT NULL DEFAULT 'click' COMMENT '菜单类型1.click0view',
  `key` char(20) NOT NULL COMMENT 'click 时的Key值',
  `url` varchar(128) NOT NULL DEFAULT 'http://' COMMENT 'view链接地址',
  `reply` varchar(10) NOT NULL DEFAULT 'text' COMMENT '响应的信息text,news',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否启用1是0不是',
  `sort` smallint(3) NOT NULL DEFAULT '100' COMMENT '菜单排序',
  `create_time` int(11) NOT NULL COMMENT '增加时间',
  `update_time` int(11) NOT NULL COMMENT '更新时间',
  UNIQUE KEY `mid_UNIQUE` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cst_weixin_menu
-- ----------------------------
INSERT INTO `cst_weixin_menu` VALUES ('1', '微官网', '0', 'view', 'menu1', 'http://juba.aipami.com/cst/', 'text', '1', '0', '1416186618', '1418720352');
INSERT INTO `cst_weixin_menu` VALUES ('2', '交流', '0', 'click', 'menu2', '', 'text', '1', '0', '1416186650', '1418799256');
INSERT INTO `cst_weixin_menu` VALUES ('3', '我', '0', 'view', 'menu3', 'http://juba.aipami.com/cst/index.php?m=Home&amp;c=User', 'text', '1', '0', '1416186674', '1418721392');
INSERT INTO `cst_weixin_menu` VALUES ('4', '技术问题', '2', 'view', 'C', 'http://juba.aipami.com/cst/index.php?m=Home&amp;c=User&amp;a=technology', 'text', '1', '0', '1416316096', '1419217500');
INSERT INTO `cst_weixin_menu` VALUES ('5', '技术资料', '2', 'view', 'D', 'http://juba.aipami.com/cst/index.php?m=Home&amp;c=Article&amp;a=resource', 'text', '1', '0', '1418720663', '1419217581');
INSERT INTO `cst_weixin_menu` VALUES ('6', '产品问题', '2', 'view', 'E', 'http://juba.aipami.com/cst/index.php?m=Home&amp;c=User&amp;a=product', 'text', '1', '0', '1418720881', '1419217552');
INSERT INTO `cst_weixin_menu` VALUES ('7', '体验反馈', '2', 'click', 'F', '', 'text', '1', '0', '1418720919', '1419217238');
INSERT INTO `cst_weixin_menu` VALUES ('8', '技术支持', '2', 'click', 'G', '', 'text', '1', '0', '1418721015', '1419217252');

-- ----------------------------
-- Table structure for `cst_weixin_subscribe`
-- ----------------------------
DROP TABLE IF EXISTS `cst_weixin_subscribe`;
CREATE TABLE `cst_weixin_subscribe` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `content` text NOT NULL COMMENT '关注回复的内容',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='会员表';

-- ----------------------------
-- Records of cst_weixin_subscribe
-- ----------------------------
INSERT INTO `cst_weixin_subscribe` VALUES ('1', '&lt;p&gt;欢迎关注索为工业电子！&lt;br/&gt;在这里您可以：探索最新产品，&lt;br/&gt;交流前沿技术，反馈您的问题，&lt;br/&gt;索为工业电子会给您&lt;br/&gt;好用的产品，专业的技术，&lt;br/&gt;严谨的态度，细致的服务。&lt;br/&gt;【1】用邀请码登录&lt;br/&gt;【2】联系技术支持人员&lt;br/&gt;【3】显示完整菜单&lt;/p&gt;');

-- ----------------------------
-- Table structure for `cst_weixin_users`
-- ----------------------------
DROP TABLE IF EXISTS `cst_weixin_users`;
CREATE TABLE `cst_weixin_users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `nickname` varchar(30) NOT NULL COMMENT '微信昵称',
  `sex` tinyint(1) NOT NULL DEFAULT '1' COMMENT '性别1男0女',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '关注时间',
  `openid` varchar(255) NOT NULL COMMENT '微信openid',
  `is_reg` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否已是注册用户0不是1是',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of cst_weixin_users
-- ----------------------------
INSERT INTO `cst_weixin_users` VALUES ('1', 'Weiyong', '1', '1418816692', 'o2AIEtzDbzdvaFHmaPk2pdTwxQbM', '0');
INSERT INTO `cst_weixin_users` VALUES ('2', '范范', '1', '1418821108', 'o2AIEt9uAWZ5HDd2-vl0D_s6VfkU', '0');
INSERT INTO `cst_weixin_users` VALUES ('3', '李晋', '1', '1418871156', 'o2AIEtxujf5S6nPN48O8ZR3TUs4U', '0');
INSERT INTO `cst_weixin_users` VALUES ('4', '', '1', '1418871197', 'o2AIEt2XYFKtedwQnZCP5QRPEZgU', '0');
INSERT INTO `cst_weixin_users` VALUES ('5', '毛小毛', '2', '1418871206', 'o2AIEt1WMLxNvxK6G2oFHnVxy8OM', '0');
INSERT INTO `cst_weixin_users` VALUES ('6', '包子', '1', '1418871214', 'o2AIEt5WbnzZxoIwqeTG80Yk7KjU', '1');
INSERT INTO `cst_weixin_users` VALUES ('7', 'Anita Lee', '2', '1418871228', 'o2AIEt9zyg_iQDcH8yODyXoxMP6k', '0');
INSERT INTO `cst_weixin_users` VALUES ('8', '曲奇', '1', '1418871393', 'o2AIEt8DEwawpypoHs0b5O8QgG3c', '0');
INSERT INTO `cst_weixin_users` VALUES ('9', '李志峰', '1', '1418871433', 'o2AIEt0D9oyUQq38k_6ybqauiCSw', '0');
