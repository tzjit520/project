/*
Navicat MySQL Data Transfer

Source Server         : mysql
Source Server Version : 50522
Source Host           : localhost:3306
Source Database       : tzj

Target Server Type    : MYSQL
Target Server Version : 50522
File Encoding         : 65001

Date: 2018-07-11 15:16:55
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for test_users
-- ----------------------------
DROP TABLE IF EXISTS `test_users`;
CREATE TABLE `test_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID 主键 自增长',
  `name` varchar(100) NOT NULL COMMENT '姓名',
  `nick_name` varchar(100) DEFAULT NULL COMMENT '昵称',
  `sex` varchar(10) DEFAULT NULL COMMENT '性别',
  `age` int(11) DEFAULT NULL COMMENT '年龄',
  `birth_day` date DEFAULT NULL COMMENT '生日',
  `hobby` varchar(500) DEFAULT NULL COMMENT '兴趣爱好',
  `info` text COMMENT '简介',
  `head_img` varchar(100) DEFAULT NULL COMMENT '头像',
  `attachment` varchar(200) DEFAULT NULL COMMENT '附件',
  `file` blob COMMENT '二进制文件',
  `remark` varchar(300) DEFAULT NULL COMMENT '备注',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '状态，1表示启用，0表示停用',
  `deleted` int(11) NOT NULL DEFAULT '0' COMMENT '是否删除标记，0表示正常，1表示已删除',
  `create_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '最后更新人',
  `update_date` datetime DEFAULT NULL COMMENT '最后更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=utf8 COMMENT='测试表';

-- ----------------------------
-- Records of test_users
-- ----------------------------
INSERT INTO `test_users` VALUES ('91', '刘露', '露露', '女', '18', '1992-02-20', '运动,美食', '活波可爱', null, null, null, '温柔', '1', '0', '1', '2018-07-05 16:52:28', '4', '2018-07-08 21:06:16');
INSERT INTO `test_users` VALUES ('95', '谭志杰', '杰哥', '男', '20', '1992-04-04', null, '非常勤劳', null, null, null, '爱好运动', '1', '0', '4', '2018-07-11 14:24:25', '4', '2018-07-11 14:24:25');
