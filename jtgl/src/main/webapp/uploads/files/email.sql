/*
Navicat MySQL Data Transfer

Source Server         : mysql
Source Server Version : 50522
Source Host           : localhost:3306
Source Database       : family

Target Server Type    : MYSQL
Target Server Version : 50522
File Encoding         : 65001

Date: 2018-07-24 09:53:26
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for email
-- ----------------------------
DROP TABLE IF EXISTS `email`;
CREATE TABLE `email` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '邮箱ID 主键 自增长',
  `title` varchar(100) NOT NULL COMMENT '邮箱标题',
  `content` varchar(50) NOT NULL COMMENT '主要内容',
  `user_ids` varchar(100) NOT NULL COMMENT '收件人Id,逗号隔开',
  `send_status` varchar(20) NOT NULL COMMENT '发送状态。0、失败。1、成功、2、新建。3、待审核。4、驳回。5、审核通过',
  `status` int(11) DEFAULT '1' COMMENT '状态。0、无效。1、有效',
  `created_by` int(11) NOT NULL COMMENT '创建人',
  `created_date` datetime NOT NULL COMMENT '创建时间',
  `last_updated_by` int(11) DEFAULT NULL COMMENT '修改人',
  `last_update_date` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='邮箱信息';

-- ----------------------------
-- Records of email
-- ----------------------------
INSERT INTO `email` VALUES ('11', '这是刚刚发送的邮箱', '这是刚刚发送的邮箱', '', '-1', '1', '1', '2017-02-02 20:25:48', '1', '2017-02-02 20:25:48');
INSERT INTO `email` VALUES ('12', '这是刚刚发送的邮箱', '这是刚刚发送的邮箱', '', '-1', '1', '1', '2017-02-02 20:25:57', '1', '2017-02-02 20:25:57');
INSERT INTO `email` VALUES ('13', '这是刚刚发送的邮箱', '这是刚刚发送的邮箱', '58', '1', '1', '1', '2017-02-02 20:26:08', '1', '2017-02-02 20:26:10');
INSERT INTO `email` VALUES ('14', '这是刚刚发送的邮箱', '这是刚刚发送的邮箱', '58', '1', '1', '1', '2017-02-02 20:26:10', '1', '2017-02-02 20:26:11');
