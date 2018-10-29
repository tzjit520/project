/*
Navicat MySQL Data Transfer

Source Server         : mysql
Source Server Version : 50522
Source Host           : localhost:3306
Source Database       : family

Target Server Type    : MYSQL
Target Server Version : 50522
File Encoding         : 65001

Date: 2018-07-19 15:30:28
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for message
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '消息ID 主键 自增长',
  `title` varchar(200) NOT NULL COMMENT '消息标题',
  `content` varchar(500) DEFAULT NULL COMMENT '主要内容',
  `type` int(11) NOT NULL COMMENT '消息类型：1、消息。2、公告。',
  `status` int(11) DEFAULT '1' COMMENT '状态',
  `created_by` int(11) NOT NULL COMMENT '创建人',
  `created_date` datetime NOT NULL COMMENT '创建时间',
  `last_updated_by` int(11) DEFAULT NULL COMMENT '修改人',
  `last_update_date` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='消息信息';

-- ----------------------------
-- Records of message
-- ----------------------------
INSERT INTO `message` VALUES ('10', '新版本来袭', '家庭管理系统新增功能了！！', '2', '1', '20', '2016-06-07 14:15:32', '1', '2016-07-01 16:01:50');
INSERT INTO `message` VALUES ('11', '快来围观了', '这里有个逗逼', '2', '1', '20', '2016-06-07 16:07:37', '1', '2016-11-04 16:13:53');
INSERT INTO `message` VALUES ('12', '家庭消息', '谭奕琛小宝宝出生啦', '2', '1', '1', '2017-12-19 11:44:39', '1', '2017-12-19 11:44:39');
