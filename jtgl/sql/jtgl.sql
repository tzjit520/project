/*
Navicat MySQL Data Transfer

Source Server         : mysql
Source Server Version : 50522
Source Host           : localhost:3306
Source Database       : tzj

Target Server Type    : MYSQL
Target Server Version : 50522
File Encoding         : 65001

Date: 2018-06-19 14:51:54
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for im_t_friends
-- ----------------------------
DROP TABLE IF EXISTS `im_t_friends`;
CREATE TABLE `im_t_friends` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `friend_id` bigint(20) DEFAULT NULL COMMENT '好友ID,跟im_t_users表关联',
  `user_id` bigint(20) DEFAULT NULL COMMENT '自己ID,跟im_t_users表关联',
  `name` varchar(50) DEFAULT NULL COMMENT '备注昵称',
  `friend_type_id` bigint(20) DEFAULT NULL COMMENT '好友类型,跟im_t_friend_type表关联',
  `friend_group_id` bigint(20) DEFAULT NULL COMMENT '所属分组,跟im_t_friend_groups表关联',
  `remark` varchar(300) DEFAULT NULL COMMENT '备注',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '状态，1表示启用，0表示停用',
  `deleted` int(11) NOT NULL DEFAULT '0' COMMENT '是否删除标记，0表示正常，1表示已删除',
  `create_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '最后更新人',
  `update_date` datetime DEFAULT NULL COMMENT '最后更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='IM好友信息表';

-- ----------------------------
-- Records of im_t_friends
-- ----------------------------

-- ----------------------------
-- Table structure for im_t_friend_group
-- ----------------------------
DROP TABLE IF EXISTS `im_t_friend_group`;
CREATE TABLE `im_t_friend_group` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` bigint(20) NOT NULL COMMENT '分组名称',
  `user_id` bigint(20) NOT NULL COMMENT '用户ID,跟im_t_users表关联',
  `remark` varchar(300) DEFAULT NULL COMMENT '备注',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '状态，1表示启用，0表示停用',
  `deleted` int(11) NOT NULL DEFAULT '0' COMMENT '是否删除标记，0表示正常，1表示已删除',
  `create_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '最后更新人',
  `update_date` datetime DEFAULT NULL COMMENT '最后更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='IM好友分组信息表';

-- ----------------------------
-- Records of im_t_friend_group
-- ----------------------------

-- ----------------------------
-- Table structure for im_t_friend_type
-- ----------------------------
DROP TABLE IF EXISTS `im_t_friend_type`;
CREATE TABLE `im_t_friend_type` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` bigint(20) NOT NULL COMMENT '类型名称',
  `remark` varchar(300) DEFAULT NULL COMMENT '备注',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '状态，1表示启用，0表示停用',
  `deleted` int(11) NOT NULL DEFAULT '0' COMMENT '是否删除标记，0表示正常，1表示已删除',
  `create_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '最后更新人',
  `update_date` datetime DEFAULT NULL COMMENT '最后更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='IM好友类型信息表';

-- ----------------------------
-- Records of im_t_friend_type
-- ----------------------------

-- ----------------------------
-- Table structure for im_t_group_msg_content
-- ----------------------------
DROP TABLE IF EXISTS `im_t_group_msg_content`;
CREATE TABLE `im_t_group_msg_content` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_group_id` int(11) NOT NULL COMMENT '群组ID，跟im_t_user_groups表关联',
  `msg_content` varchar(3500) DEFAULT NULL COMMENT '消息内容',
  `from_user_id` int(11) NOT NULL COMMENT '发送者ID，跟im_t_users表关联',
  `from_user_nick_name` varchar(50) DEFAULT NULL COMMENT '发送者昵称',
  `send_time` datetime DEFAULT NULL COMMENT '发送时间',
  `remark` varchar(300) DEFAULT NULL COMMENT '备注',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '状态，1表示启用，0表示停用',
  `deleted` int(11) NOT NULL DEFAULT '0' COMMENT '是否删除标记，0表示正常，1表示已删除',
  `create_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '最后更新人',
  `update_date` datetime DEFAULT NULL COMMENT '最后更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='IM群组消息内容表';

-- ----------------------------
-- Records of im_t_group_msg_content
-- ----------------------------

-- ----------------------------
-- Table structure for im_t_group_msg_to_user
-- ----------------------------
DROP TABLE IF EXISTS `im_t_group_msg_to_user`;
CREATE TABLE `im_t_group_msg_to_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` int(11) NOT NULL COMMENT '接收者ID，跟im_t_users表关联',
  `group_msg_id` int(11) NOT NULL COMMENT '群组消息ID，跟im_t_group_msg_content表关联',
  `receiv_status` int(11) NOT NULL COMMENT '接收状态，0已接收，1未接收，-1撤回',
  `remark` varchar(300) DEFAULT NULL COMMENT '备注',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '状态，1表示启用，0表示停用',
  `deleted` int(11) NOT NULL DEFAULT '0' COMMENT '是否删除标记，0表示正常，1表示已删除',
  `create_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '最后更新人',
  `update_date` datetime DEFAULT NULL COMMENT '最后更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='IM群组消息关联表';

-- ----------------------------
-- Records of im_t_group_msg_to_user
-- ----------------------------

-- ----------------------------
-- Table structure for im_t_group_msg_user_to_user
-- ----------------------------
DROP TABLE IF EXISTS `im_t_group_msg_user_to_user`;
CREATE TABLE `im_t_group_msg_user_to_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `from_user_id` int(11) NOT NULL COMMENT '发送者ID，跟im_t_users表关联',
  `from_user_nick_name` varchar(50) DEFAULT NULL COMMENT '发送者昵称',
  `to_user_id` int(11) NOT NULL COMMENT '接收者ID，跟im_t_users表关联',
  `msg_content` varchar(3500) NOT NULL COMMENT '消息内容',
  `receiv_status` int(11) DEFAULT '1' COMMENT '接收状态，0已接收，1未接收，-1撤回',
  `send_time` datetime NOT NULL COMMENT '发送时间',
  `user_group_id` int(11) NOT NULL COMMENT '所属群组ID,跟im_t_user_groups表关联',
  `remark` varchar(300) DEFAULT NULL COMMENT '备注',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '状态，1表示启用，0表示停用',
  `deleted` int(11) NOT NULL DEFAULT '0' COMMENT '是否删除标记，0表示正常，1表示已删除',
  `create_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '最后更新人',
  `update_date` datetime DEFAULT NULL COMMENT '最后更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='IM群内私聊消息关联表';

-- ----------------------------
-- Records of im_t_group_msg_user_to_user
-- ----------------------------

-- ----------------------------
-- Table structure for im_t_group_to_user
-- ----------------------------
DROP TABLE IF EXISTS `im_t_group_to_user`;
CREATE TABLE `im_t_group_to_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` int(11) NOT NULL COMMENT '用户ID,跟im_t_users表关联',
  `group_id` int(11) NOT NULL COMMENT '群ID,跟im_t_user_groups表关联',
  `group_nick` varchar(50) DEFAULT NULL COMMENT '群内用户昵称',
  `remark` varchar(300) DEFAULT NULL COMMENT '备注',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '状态，1表示启用，0表示停用',
  `deleted` int(11) NOT NULL DEFAULT '0' COMMENT '是否删除标记，0表示正常，1表示已删除',
  `create_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '最后更新人',
  `update_date` datetime DEFAULT NULL COMMENT '最后更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='IM群组用户关联表';

-- ----------------------------
-- Records of im_t_group_to_user
-- ----------------------------

-- ----------------------------
-- Table structure for im_t_messages
-- ----------------------------
DROP TABLE IF EXISTS `im_t_messages`;
CREATE TABLE `im_t_messages` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `msg_content` varchar(3500) NOT NULL COMMENT '消息内容',
  `receiv_status` int(11) NOT NULL COMMENT '接收状态，0已接收，1未接收，-1撤回',
  `send_time` datetime NOT NULL COMMENT '发送时间',
  `message_type_id` int(11) NOT NULL COMMENT '消息类型ID,跟im_t_message_type表关联',
  `from_user_id` int(11) NOT NULL COMMENT '发送者ID,跟im_t_users表关联',
  `to_user_id` int(11) NOT NULL COMMENT '接收者ID,跟im_t_users表关联',
  `remark` varchar(300) DEFAULT NULL COMMENT '备注',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '状态，1表示启用，0表示停用',
  `deleted` int(11) NOT NULL DEFAULT '0' COMMENT '是否删除标记，0表示正常，1表示已删除',
  `create_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '最后更新人',
  `update_date` datetime DEFAULT NULL COMMENT '最后更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='IM聊天记录表';

-- ----------------------------
-- Records of im_t_messages
-- ----------------------------

-- ----------------------------
-- Table structure for im_t_message_type
-- ----------------------------
DROP TABLE IF EXISTS `im_t_message_type`;
CREATE TABLE `im_t_message_type` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(50) NOT NULL COMMENT '类型名称',
  `remark` varchar(300) DEFAULT NULL COMMENT '备注',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '状态，1表示启用，0表示停用',
  `deleted` int(11) NOT NULL DEFAULT '0' COMMENT '是否删除标记，0表示正常，1表示已删除',
  `create_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '最后更新人',
  `update_date` datetime DEFAULT NULL COMMENT '最后更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='IM消息类型表';

-- ----------------------------
-- Records of im_t_message_type
-- ----------------------------

-- ----------------------------
-- Table structure for im_t_users
-- ----------------------------
DROP TABLE IF EXISTS `im_t_users`;
CREATE TABLE `im_t_users` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `code` varchar(50) NOT NULL COMMENT '登录名',
  `nick_name` varchar(50) DEFAULT NULL COMMENT '备注昵称',
  `name` varchar(50) DEFAULT NULL COMMENT '真实姓名',
  `password` varchar(50) NOT NULL COMMENT '密码',
  `sex` varchar(2) DEFAULT NULL COMMENT '性别',
  `age` int(11) DEFAULT NULL COMMENT '年龄',
  `birthday` date DEFAULT NULL COMMENT '生日',
  `tele_phone` varchar(20) DEFAULT NULL COMMENT '电话',
  `email` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `head_img` varchar(50) DEFAULT NULL COMMENT '头像',
  `signa_ture` varchar(500) DEFAULT NULL COMMENT '个性签名',
  `intro` varchar(1000) DEFAULT NULL COMMENT '简介',
  `zodiac` varchar(20) DEFAULT NULL COMMENT '生肖',
  `constellation` varchar(20) DEFAULT NULL COMMENT '星座',
  `blood_type` varchar(10) DEFAULT NULL COMMENT '血型',
  `school_tag` varchar(50) DEFAULT NULL COMMENT '毕业学校',
  `vocation` varchar(30) DEFAULT NULL COMMENT '职业',
  `nation` varchar(20) DEFAULT NULL COMMENT '国家',
  `province` varchar(20) DEFAULT NULL COMMENT '省份',
  `city` varchar(20) DEFAULT NULL COMMENT '城市',
  `area` varchar(20) DEFAULT NULL COMMENT '区域',
  `friend_ship_policy` varchar(30) DEFAULT NULL COMMENT '好友添加方式',
  `friend_policy_question` varchar(50) DEFAULT NULL COMMENT '好友策略问题',
  `friend_policy_answer` varchar(50) DEFAULT NULL COMMENT '好友策略答案',
  `friend_policy_password` varchar(50) DEFAULT NULL COMMENT '好友策略密码',
  `remark` varchar(300) DEFAULT NULL COMMENT '备注',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '状态，1表示启用，0表示停用',
  `deleted` int(11) NOT NULL DEFAULT '0' COMMENT '是否删除标记，0表示正常，1表示已删除',
  `create_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '最后更新人',
  `update_date` datetime DEFAULT NULL COMMENT '最后更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='IM用户信息表';

-- ----------------------------
-- Records of im_t_users
-- ----------------------------

-- ----------------------------
-- Table structure for im_t_user_groups
-- ----------------------------
DROP TABLE IF EXISTS `im_t_user_groups`;
CREATE TABLE `im_t_user_groups` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(50) NOT NULL COMMENT '群名称',
  `admin_id` int(11) NOT NULL COMMENT '群主ID,跟im_t_users表关联',
  `icon` varchar(50) DEFAULT NULL COMMENT '群图标',
  `notice` varchar(500) DEFAULT NULL COMMENT '群公告',
  `intro` varchar(500) DEFAULT NULL COMMENT '群简介',
  `remark` varchar(300) DEFAULT NULL COMMENT '备注',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '状态，1表示启用，0表示停用',
  `deleted` int(11) NOT NULL DEFAULT '0' COMMENT '是否删除标记，0表示正常，1表示已删除',
  `create_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '最后更新人',
  `update_date` datetime DEFAULT NULL COMMENT '最后更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='IM用户群组表';

-- ----------------------------
-- Records of im_user_groups
-- ----------------------------

-- ----------------------------
-- Table structure for sys_t_db_object
-- ----------------------------
DROP TABLE IF EXISTS `sys_t_db_object`;
CREATE TABLE `sys_t_db_object` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `code` varchar(30) NOT NULL COMMENT '对象编码',
  `name` varchar(50) NOT NULL COMMENT '对象名称',
  `sys_module` varchar(30) DEFAULT 'global' COMMENT '模块',
  `sql_statements` longtext COMMENT 'SQL语句',
  `procedure_name` varchar(50) DEFAULT NULL COMMENT '存储过程名称',
  `remark` varchar(300) DEFAULT NULL COMMENT '备注',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '状态，1表示启用，0表示停用',
  `deleted` int(11) NOT NULL DEFAULT '0' COMMENT '是否删除标记，0表示正常，1表示已删除',
  `create_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '最后更新人',
  `update_date` datetime DEFAULT NULL COMMENT '最后更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `object_code_UNIQUE` (`code`),
  UNIQUE KEY `object_name_UNIQUE` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='数据库对象信息表';

-- ----------------------------
-- Records of sys_t_db_object
-- ----------------------------

-- ----------------------------
-- Table structure for sys_t_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_t_log`;
CREATE TABLE `sys_t_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `type` varchar(10) DEFAULT NULL COMMENT '日志类型，一般指模块名，在框架中暂时只使用了SYSTEM一个类型,业务应用有需要，可在业务类的常量中自行定义，通常使用大写字符串',
  `create_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `remote_ip` varchar(45) DEFAULT NULL COMMENT '操作IP地址',
  `request_uri` varchar(255) DEFAULT NULL COMMENT '请求URI',
  `method` varchar(45) DEFAULT NULL COMMENT '操作方式，put，get，delete等',
  `operate` varchar(45) DEFAULT NULL COMMENT '操作，指具体的业务操作，如权限变更、密码重置、系统登录成功、系统登录失败等，由业务模块决定其具体内容',
  `loglevel` varchar(10) DEFAULT NULL COMMENT '日志等级：DEBUG、INFO、WARN、ERROR、FATAL',
  `module` varchar(255) DEFAULT NULL COMMENT '模块，指被调用的类及方法',
  `request_time` bigint(20) DEFAULT NULL COMMENT '请求花费时间，单位为毫秒',
  `request_data` longtext COMMENT '请求数据',
  `response_data` longtext COMMENT '响应数据',
  `exception` mediumtext COMMENT '异常信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='日志表';

-- ----------------------------
-- Records of sys_t_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_t_lov
-- ----------------------------
DROP TABLE IF EXISTS `sys_t_lov`;
CREATE TABLE `sys_t_lov` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'LOV_ID',
  `module` varchar(30) DEFAULT 'global' COMMENT '系统模块',
  `code` varchar(50) NOT NULL COMMENT 'LOV编码',
  `name` varchar(100) NOT NULL COMMENT 'LOV名称',
  `type` int(11) DEFAULT '0' COMMENT '是否鉴权，1表示鉴权，0表示不鉴权',
  `remark` varchar(300) DEFAULT NULL COMMENT '备注',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '状态，1表示启用，0表示停用',
  `deleted` int(11) NOT NULL DEFAULT '0' COMMENT '是否删除标记，0表示正常，1表示已删除',
  `create_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '最后更新人',
  `update_date` datetime DEFAULT NULL COMMENT '最后更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_UNIQUE` (`code`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COMMENT='LOV定义表';

-- ----------------------------
-- Records of sys_t_lov
-- ----------------------------
INSERT INTO `sys_t_lov` VALUES ('1', 'global', 'statuses', '状态', '0', null, '1', '0', '1', '2017-07-05 15:48:48', '1', '2017-07-05 15:48:48');
INSERT INTO `sys_t_lov` VALUES ('2', 'global', 'userStatuses', '用户状态', '0', null, '1', '0', '1', '2017-07-05 15:48:48', '1', '2017-08-30 23:23:41');
INSERT INTO `sys_t_lov` VALUES ('3', 'global', 'privileges', '权限', '0', null, '1', '0', '1', '2017-07-05 15:48:48', '1', '2017-07-05 15:48:48');
INSERT INTO `sys_t_lov` VALUES ('4', 'global', 'unitTypes', '组织类型', '0', null, '1', '0', '1', '2017-07-05 15:48:48', '1', '2017-07-05 15:48:48');
INSERT INTO `sys_t_lov` VALUES ('5', 'global', 'menuTypes', '菜单类型', '0', null, '1', '0', '1', '2017-07-05 15:48:48', '1', '2017-07-05 15:48:48');
INSERT INTO `sys_t_lov` VALUES ('6', 'global', 'jobStatuses', '定时任务状态', '0', null, '1', '0', '1', '2017-09-16 20:58:04', '1', '2017-09-16 20:58:13');
INSERT INTO `sys_t_lov` VALUES ('7', 'global', 'yesOrNo', '是否', '0', null, '1', '0', '1', '2017-09-16 21:01:26', '1', '2017-09-16 21:01:26');

-- ----------------------------
-- Table structure for sys_t_lovline
-- ----------------------------
DROP TABLE IF EXISTS `sys_t_lovline`;
CREATE TABLE `sys_t_lovline` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `lov_id` bigint(20) NOT NULL COMMENT 'LOV主键',
  `code` varchar(50) NOT NULL COMMENT '编码值',
  `name` varchar(100) NOT NULL COMMENT '显示值',
  `value` varchar(255) DEFAULT NULL COMMENT '值',
  `sort` int(11) DEFAULT '0' COMMENT '显示排序',
  `remark` varchar(300) DEFAULT NULL COMMENT '备注',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '状态，1表示启用，0表示停用',
  `deleted` int(11) NOT NULL DEFAULT '0' COMMENT '是否删除标记，0表示正常，1表示已删除',
  `create_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '最后更新人',
  `update_date` datetime DEFAULT NULL COMMENT '最后更新时间',
  PRIMARY KEY (`id`),
  KEY `FK28E4AA9218E61C7D` (`lov_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COMMENT='LOV明细行';

-- ----------------------------
-- Records of sys_t_lovline
-- ----------------------------
INSERT INTO `sys_t_lovline` VALUES ('1', '1', '1', '启用', null, '0', null, '1', '0', '1', '2017-07-05 15:48:48', '1', '2017-07-05 15:48:48');
INSERT INTO `sys_t_lovline` VALUES ('2', '1', '0', '未启用', null, '1', null, '1', '0', '1', '2017-07-05 15:48:48', '1', '2017-07-05 15:48:48');
INSERT INTO `sys_t_lovline` VALUES ('3', '2', '1', '启用', null, '0', null, '1', '0', '1', '2017-07-05 15:48:48', '1', '2017-07-05 15:48:48');
INSERT INTO `sys_t_lovline` VALUES ('4', '2', '0', '未启用', null, '1', null, '1', '0', '1', '2017-07-05 15:48:48', '1', '2017-07-05 15:48:48');
INSERT INTO `sys_t_lovline` VALUES ('5', '2', '-1', '初始', null, '2', null, '1', '0', '1', '2017-07-05 15:48:48', '1', '2017-07-05 15:48:48');
INSERT INTO `sys_t_lovline` VALUES ('6', '3', '1', '是', null, '0', null, '1', '0', '1', '2017-07-05 15:48:48', '1', '2017-07-05 15:48:48');
INSERT INTO `sys_t_lovline` VALUES ('7', '3', '0', '否', null, '1', null, '1', '0', '1', '2017-07-05 15:48:48', '1', '2017-07-05 15:48:48');
INSERT INTO `sys_t_lovline` VALUES ('8', '4', '1', '公司', null, '0', null, '1', '0', '1', '2017-07-05 15:48:48', '1', '2017-07-05 15:48:48');
INSERT INTO `sys_t_lovline` VALUES ('9', '4', '2', '部门', null, '1', null, '1', '0', '1', '2017-07-05 15:48:48', '1', '2017-07-05 15:48:48');
INSERT INTO `sys_t_lovline` VALUES ('10', '5', '1', '内部链接', null, '0', null, '1', '0', '1', '2017-07-05 15:48:48', '1', '2017-07-05 15:48:48');
INSERT INTO `sys_t_lovline` VALUES ('11', '5', '2', '外部链接', null, '1', null, '1', '0', '1', '2017-07-05 15:48:48', '1', '2017-07-05 15:48:48');
INSERT INTO `sys_t_lovline` VALUES ('12', '6', '1', '正常', '1', '0', null, '1', '0', '1', '2017-09-16 20:58:04', '1', '2017-09-16 20:58:04');
INSERT INTO `sys_t_lovline` VALUES ('13', '6', '2', '暂停', '2', '1', null, '1', '0', '1', '2017-09-16 20:58:04', '1', '2017-09-16 20:58:04');
INSERT INTO `sys_t_lovline` VALUES ('14', '7', '1', '是', '1', '0', null, '1', '0', '1', '2017-09-16 21:01:26', '1', '2017-09-16 21:01:26');
INSERT INTO `sys_t_lovline` VALUES ('15', '7', '0', '否', '0', '1', null, '1', '0', '1', '2017-09-16 21:01:26', '1', '2017-09-16 21:01:26');

-- ----------------------------
-- Table structure for sys_t_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_t_menu`;
CREATE TABLE `sys_t_menu` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `css` varchar(255) DEFAULT NULL COMMENT '样式',
  `code` varchar(255) DEFAULT NULL COMMENT '编码',
  `name` varchar(255) DEFAULT NULL COMMENT '名称',
  `sort` int(4) DEFAULT NULL COMMENT '排序',
  `type` int(11) DEFAULT NULL COMMENT '类型，1-内部链接，2-外部链接',
  `url` varchar(255) DEFAULT NULL COMMENT '链接',
  `parent_id` bigint(32) DEFAULT NULL COMMENT '父节点主键',
  `permission` varchar(255) DEFAULT NULL COMMENT '权限',
  `remark` varchar(300) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '备注',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '状态，1表示启用，0表示停用',
  `deleted` int(11) NOT NULL DEFAULT '0' COMMENT '是否删除标记，0表示正常，1表示已删除',
  `create_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '最后更新人',
  `update_date` datetime DEFAULT NULL COMMENT '最后更新时间',
  PRIMARY KEY (`id`),
  KEY `FK_astulwpsla864at9igbas3eic` (`parent_id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_t_menu
-- ----------------------------
INSERT INTO `sys_t_menu` VALUES ('1', 'im-cog', 'system', '系统管理', '1000', '1', '', null, '', null, '1', '0', '1', null, '1', null);
INSERT INTO `sys_t_menu` VALUES ('2', 'im-stack', 'org', '组织管理', '10', '1', '', '1', '', null, '1', '0', '1', null, '1', null);
INSERT INTO `sys_t_menu` VALUES ('3', 'st-support', 'unit', '组织机构管理', '3', '1', 'smart.platform.unit.list', '2', 'unit:view', null, '1', '0', '1', null, '1', null);
INSERT INTO `sys_t_menu` VALUES ('4', 'st-user', 'user', '用户管理', '1', '1', 'smart.platform.user.list', '2', 'user:view', null, '1', '0', '1', null, '1', null);
INSERT INTO `sys_t_menu` VALUES ('5', 'st-users', 'role', '角色管理', '2', '1', 'smart.platform.role.list', '2', 'role:view', null, '1', '0', '1', null, '1', null);
INSERT INTO `sys_t_menu` VALUES ('6', 'im-tags', 'function', '功能管理', '20', '1', null, '1', '', null, '1', '0', '1', null, '1', null);
INSERT INTO `sys_t_menu` VALUES ('7', 'fa-cog', 'menu', '菜单管理', '1', '1', 'smart.platform.menu.list', '6', 'menu:view', null, '1', '0', '1', null, '1', null);
INSERT INTO `sys_t_menu` VALUES ('8', 'fa-edit-sign', 'resource', '资源管理', '2', '1', 'smart.platform.resource.list', '6', 'resource:view', '资源管理', '1', '0', '1', null, '1', '2018-06-06 13:55:12');
INSERT INTO `sys_t_menu` VALUES ('9', 'fa-share-sign', 'operation', '操作管理', '3', '1', 'smart.platform.operation.list', '6', 'operation:view', null, '1', '0', '1', null, '1', null);
INSERT INTO `sys_t_menu` VALUES ('10', 'fa-flickr', 'permission', '功能管理', '4', '1', 'smart.platform.permission.list', '6', 'permission:view', null, '1', '0', '1', null, '1', null);
INSERT INTO `sys_t_menu` VALUES ('11', 'fa-tasks', 'data', '数据管理', '30', '1', null, '1', '', null, '1', '0', '1', null, '1', null);
INSERT INTO `sys_t_menu` VALUES ('12', 'fa-twitter-sign', 'dbObject', '数据对象管理', '1', '1', 'smart.platform.dbobject.list', '11', 'dbObject:view', null, '1', '0', '1', null, '1', null);
INSERT INTO `sys_t_menu` VALUES ('13', 'fa-th-large', 'lov', '数据字典', '2', '1', 'smart.platform.lov.list', '11', 'lov:view', null, '1', '0', '1', null, '1', null);
INSERT INTO `sys_t_menu` VALUES ('14', 'en-database', 'sys', '系统管理', '40', '1', null, '1', '', null, '1', '0', '1', null, '1', null);
INSERT INTO `sys_t_menu` VALUES ('15', 'en-chat', 'session', '会话管理', '1', '1', 'smart.platform.system.session', '14', 'session:view', null, '1', '0', '1', null, '1', null);
INSERT INTO `sys_t_menu` VALUES ('16', 'en-book', 'log', '日志管理', '2', '1', 'smart.platform.system.log', '14', 'log:view', null, '1', '0', '1', null, '1', null);
INSERT INTO `sys_t_menu` VALUES ('17', 'en-flag', 'performance', '性能监控', '3', '1', 'smart.platform.system.performance', '14', 'performance:view', null, '1', '0', '1', null, '1', null);
INSERT INTO `sys_t_menu` VALUES ('18', 'en-suitcase', 'configuration', '系统配置', '4', '1', 'smart.platform.system.configuration', '14', 'system:view', null, '1', '0', '1', null, '1', null);
INSERT INTO `sys_t_menu` VALUES ('19', 'en-network', 'demo', 'demo项目', '2000', '1', null, null, null, null, '1', '0', '1', null, '1', null);
INSERT INTO `sys_t_menu` VALUES ('20', 'en-leaf', 'example', 'demo样例', '1', '1', null, '19', null, null, '1', '0', '1', null, '1', null);
INSERT INTO `sys_t_menu` VALUES ('21', 'im-location2', 'dt', '地图', '2', '1', 'api/v1/dt', '19', 'permission:view', '地图', '1', '0', '1', '2018-06-06 11:34:13', '1', '2018-06-06 11:34:13');

-- ----------------------------
-- Table structure for sys_t_operation
-- ----------------------------
DROP TABLE IF EXISTS `sys_t_operation`;
CREATE TABLE `sys_t_operation` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `code` varchar(100) NOT NULL COMMENT '操作编码',
  `name` varchar(100) NOT NULL COMMENT '操作名称',
  `remark` varchar(300) DEFAULT NULL COMMENT '备注',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '状态，1表示启用，0表示停用',
  `deleted` int(11) NOT NULL DEFAULT '0' COMMENT '是否删除标记，0表示正常，1表示已删除',
  `create_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '最后更新人',
  `update_date` datetime DEFAULT NULL COMMENT '最后更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COMMENT='操作信息表';

-- ----------------------------
-- Records of sys_t_operation
-- ----------------------------
INSERT INTO `sys_t_operation` VALUES ('1', 'view', '查看', '查看权限', '1', '0', '1', '2018-05-22 20:15:38', '1', '2018-05-22 20:15:38');
INSERT INTO `sys_t_operation` VALUES ('2', 'add', '添加', '添加权限', '1', '0', '1', '2018-05-22 20:15:38', '1', '2018-05-22 20:15:38');
INSERT INTO `sys_t_operation` VALUES ('3', 'update', '更新', '更新权限', '1', '0', '1', '2018-05-22 20:15:38', '1', '2018-05-22 20:15:38');
INSERT INTO `sys_t_operation` VALUES ('4', 'delete', '删除', '删除权限', '1', '0', '1', '2018-05-22 20:15:38', '1', '2018-05-22 20:15:38');

-- ----------------------------
-- Table structure for sys_t_permission
-- ----------------------------
DROP TABLE IF EXISTS `sys_t_permission`;
CREATE TABLE `sys_t_permission` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `resource_id` bigint(20) NOT NULL COMMENT '资源ID',
  `operation_id` bigint(20) NOT NULL COMMENT '操作ID',
  `remark` varchar(300) DEFAULT NULL COMMENT '备注',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '状态，1表示启用，0表示停用',
  `deleted` int(11) NOT NULL DEFAULT '0' COMMENT '是否删除标记，0表示正常，1表示已删除',
  `create_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '最后更新人',
  `update_date` datetime DEFAULT NULL COMMENT '最后更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=120 DEFAULT CHARSET=utf8mb4 COMMENT='系统权限表';

-- ----------------------------
-- Records of sys_t_permission
-- ----------------------------

-- ----------------------------
-- Table structure for sys_t_resource
-- ----------------------------
DROP TABLE IF EXISTS `sys_t_resource`;
CREATE TABLE `sys_t_resource` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `code` varchar(100) NOT NULL COMMENT '资源编码',
  `name` varchar(100) NOT NULL COMMENT '资源名称',
  `remark` varchar(300) DEFAULT NULL COMMENT '备注',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '状态，1表示启用，0表示停用',
  `deleted` int(11) NOT NULL DEFAULT '0' COMMENT '是否删除标记，0表示正常，1表示已删除',
  `create_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '最后更新人',
  `update_date` datetime DEFAULT NULL COMMENT '最后更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1001 DEFAULT CHARSET=utf8mb4 COMMENT='系统资源表';

-- ----------------------------
-- Records of sys_t_resource
-- ----------------------------
INSERT INTO `sys_t_resource` VALUES ('1', 'user', '用户管理', '用户管理', '1', '0', '1', '2016-09-18 13:26:43', '1', '2016-09-18 13:26:43');
INSERT INTO `sys_t_resource` VALUES ('2', 'resource', '资源管理', '资源管理', '1', '0', '1', '2016-09-18 13:26:48', '1', '2016-09-18 13:26:48');
INSERT INTO `sys_t_resource` VALUES ('3', 'role', '角色管理', '角色管理', '1', '0', '1', '2016-08-11 12:30:43', '1', '2016-09-18 13:26:54');
INSERT INTO `sys_t_resource` VALUES ('4', 'unit', '组织机构管理', '组织机构管理', '1', '0', '1', '2016-08-11 12:31:02', '1', '2016-09-18 13:06:30');
INSERT INTO `sys_t_resource` VALUES ('5', 'operation', '操作管理', '操作管理', '1', '0', '1', '2016-08-11 12:31:44', '1', '2016-08-11 12:31:44');
INSERT INTO `sys_t_resource` VALUES ('6', 'permission', '功能管理', '功能管理', '1', '0', '1', '2016-08-11 12:32:09', '1', '2016-09-18 13:05:42');
INSERT INTO `sys_t_resource` VALUES ('7', 'menu', '菜单', '菜单', '1', '0', '1', '2016-09-19 13:58:48', '1', '2016-09-19 13:58:48');
INSERT INTO `sys_t_resource` VALUES ('8', 'dbObject', '数据对象', '数据对象', '1', '0', '1', '2016-09-18 13:20:24', '1', '2016-09-18 13:27:09');
INSERT INTO `sys_t_resource` VALUES ('9', 'lov', '值类型', '值类型', '1', '0', '1', '2016-09-18 17:04:22', '1', '2016-09-18 17:04:22');
INSERT INTO `sys_t_resource` VALUES ('10', 'performance', '性能监控', '性能监控', '1', '0', '1', '2016-09-19 13:58:17', '1', '2016-09-19 13:58:17');
INSERT INTO `sys_t_resource` VALUES ('11', 'system', '系统配置', '系统配置', '1', '0', '1', '2016-09-19 13:58:48', '1', '2016-09-19 13:58:48');
INSERT INTO `sys_t_resource` VALUES ('12', 'session', '会话', '会话', '1', '0', '1', '2016-09-19 13:58:48', '1', '2016-09-19 13:58:48');

-- ----------------------------
-- Table structure for sys_t_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_t_role`;
CREATE TABLE `sys_t_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `code` varchar(2000) NOT NULL COMMENT '角色编码',
  `name` varchar(2000) NOT NULL COMMENT '角色名称',
  `remark` varchar(1000) DEFAULT NULL COMMENT '备注',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '状态，1表示启用，0表示停用',
  `deleted` int(11) NOT NULL DEFAULT '0' COMMENT '是否删除标记，0表示正常，1表示已删除',
  `create_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '最后更新人',
  `update_date` datetime DEFAULT NULL COMMENT '最后更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COMMENT='角色信息表';

-- ----------------------------
-- Records of sys_t_role
-- ----------------------------
INSERT INTO `sys_t_role` VALUES ('1', 'admin', '管理员', '系统管理员', '1', '0', '1', '2017-01-08 21:43:34', '1', '2017-01-08 21:43:34');
INSERT INTO `sys_t_role` VALUES ('2', 'user', '普通用户', '普通用户', '1', '0', '1', '2018-06-14 08:41:44', '1', '2018-06-14 08:41:44');
INSERT INTO `sys_t_role` VALUES ('3', 'test', '测试角色', '测试角色', '1', '0', '1', '2018-06-19 14:16:08', '1', '2018-06-19 14:40:58');

-- ----------------------------
-- Table structure for sys_t_role_permission
-- ----------------------------
DROP TABLE IF EXISTS `sys_t_role_permission`;
CREATE TABLE `sys_t_role_permission` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `permission_id` bigint(20) NOT NULL COMMENT '权限ID',
  `remark` varchar(300) DEFAULT NULL COMMENT '备注',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '状态，1表示启用，0表示停用',
  `deleted` int(11) NOT NULL DEFAULT '0' COMMENT '是否删除标记，0表示正常，1表示已删除',
  `create_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '最后更新人',
  `update_date` datetime DEFAULT NULL COMMENT '最后更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=431 DEFAULT CHARSET=utf8mb4 COMMENT='角色与系统权限关联表';

-- ----------------------------
-- Records of sys_t_role_permission
-- ----------------------------

-- ----------------------------
-- Table structure for sys_t_sequence
-- ----------------------------
DROP TABLE IF EXISTS `sys_t_sequence`;
CREATE TABLE `sys_t_sequence` (
  `sequence_code` varchar(20) NOT NULL COMMENT '序列编码',
  `sequence_name` varchar(50) NOT NULL COMMENT '序列名称',
  `formart_str` varchar(45) DEFAULT NULL COMMENT '序列格式化字符串',
  `sequence_number` int(11) unsigned NOT NULL COMMENT '序列数值',
  `sequence_step` int(11) NOT NULL DEFAULT '1' COMMENT '步长',
  `remark` varchar(300) DEFAULT NULL COMMENT '备注',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '状态，1表示启用，0表示停用',
  `deleted` int(11) NOT NULL DEFAULT '0' COMMENT '是否删除标记，0表示正常，1表示已删除',
  `create_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '最后更新人',
  `update_date` datetime DEFAULT NULL COMMENT '最后更新时间',
  PRIMARY KEY (`sequence_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='序列值定义表';

-- ----------------------------
-- Records of sys_t_sequence
-- ----------------------------
INSERT INTO `sys_t_sequence` VALUES ('test', '测试', 'NumSeq@6S0', '1001', '1', '测试', '1', '0', '1', null, '1', null);

-- ----------------------------
-- Table structure for sys_t_unit
-- ----------------------------
DROP TABLE IF EXISTS `sys_t_unit`;
CREATE TABLE `sys_t_unit` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `parent_id` bigint(20) DEFAULT NULL COMMENT '父节点ID',
  `code` varchar(100) NOT NULL COMMENT '编码',
  `name` varchar(100) NOT NULL COMMENT '名称',
  `type` int(11) DEFAULT NULL COMMENT '公司、部门的区分，1表示公司，2表示部门',
  `sort` int(11) DEFAULT '0' COMMENT '排序值',
  `remark` varchar(300) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '状态，1表示启用，0表示停用',
  `deleted` int(11) NOT NULL DEFAULT '0' COMMENT '是否删除标记，0表示正常，1表示已删除',
  `create_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '最后更新人',
  `update_date` datetime DEFAULT NULL COMMENT '最后更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COMMENT='组织结构表';

-- ----------------------------
-- Records of sys_t_unit
-- ----------------------------
INSERT INTO `sys_t_unit` VALUES ('1', null, 'company1', '公司一', '1', '100', null, '1', '0', '1', '2018-05-27 11:54:05', '1', '2018-05-27 11:54:05');
INSERT INTO `sys_t_unit` VALUES ('2', '1', 'XingZhengBu', '行政部', '2', '1', null, '1', '0', '1', '2018-05-27 11:58:02', '1', '2018-05-27 11:58:02');
INSERT INTO `sys_t_unit` VALUES ('3', '1', 'RuanJianBu', '软件部', '2', '2', null, '1', '0', '1', '2018-05-27 21:56:17', '1', '2018-05-27 21:56:17');
INSERT INTO `sys_t_unit` VALUES ('4', null, 'company2', '公司二', '1', '200', '', '1', '0', '1', '2018-05-27 22:48:17', '1', '2018-05-27 22:48:17');
INSERT INTO `sys_t_unit` VALUES ('5', '4', ' caiwubu', '财务部', '2', '1', '', '1', '0', '1', '2018-05-27 23:48:17', '1', '2018-05-27 23:48:17');
INSERT INTO `sys_t_unit` VALUES ('6', '4', 'yanfabu', '研发部', '2', '2', null, '1', '0', '1', '2018-05-27 23:52:44', '1', '2018-05-27 23:52:44');

-- ----------------------------
-- Table structure for sys_t_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_t_user`;
CREATE TABLE `sys_t_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `unit_id` bigint(20) DEFAULT NULL COMMENT '组织机构表公司ID',
  `dept_id` bigint(20) DEFAULT NULL COMMENT '组织机构表部门ID',
  `code` varchar(200) NOT NULL COMMENT '登录名',
  `name` varchar(200) NOT NULL COMMENT '姓名',
  `work_number` varchar(200) DEFAULT NULL COMMENT '工号',
  `password` varchar(200) DEFAULT NULL COMMENT '密码',
  `sex` varchar(50) DEFAULT NULL COMMENT '性别(男/女)',
  `headimgurl` varchar(255) DEFAULT NULL COMMENT '头像图片链接地址',
  `telephone` varchar(100) DEFAULT NULL COMMENT '电话',
  `mobile` varchar(100) DEFAULT NULL COMMENT '手机号码',
  `email` varchar(100) DEFAULT NULL COMMENT '邮箱',
  `login_flag` int(11) DEFAULT NULL COMMENT '是否可登录，0-长期锁定，1-可登录，2-短期锁定',
  `lock_day` int(11) DEFAULT '0' COMMENT '锁定天数，该天数由定时器每天扫描减一，直至0为止',
  `lock_date` datetime DEFAULT NULL COMMENT '锁定时间',
  `token` varchar(500) DEFAULT NULL COMMENT 'token验证',
  `remark` varchar(300) DEFAULT NULL COMMENT '备注',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '状态，1表示启用，0表示停用',
  `deleted` int(11) NOT NULL DEFAULT '0' COMMENT '是否删除标记，0表示正常，1表示已删除',
  `create_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '最后更新人',
  `update_date` datetime DEFAULT NULL COMMENT '最后更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COMMENT='用户信息表';

-- ----------------------------
-- Records of sys_t_user
-- ----------------------------
INSERT INTO `sys_t_user` VALUES ('1', '1', '2', 'admin', '管理员', '003', 'c6ac59a147fa349f1032c521b7e521a3', '男', 'IMG_2931.JPG', '18674762176', '18674762176', 'admin@163.com', '1', '0', null, null, '系统管理员', '1', '0', '1', '2018-05-18 14:50:23', '1', '2018-05-22 11:00:08');

-- ----------------------------
-- Table structure for sys_t_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_t_user_role`;
CREATE TABLE `sys_t_user_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `remark` varchar(300) DEFAULT NULL COMMENT '备注',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '状态，1表示启用，0表示停用',
  `deleted` int(11) NOT NULL DEFAULT '0' COMMENT '是否删除标记，0表示正常，1表示已删除',
  `create_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '最后更新人',
  `update_date` datetime DEFAULT NULL COMMENT '最后更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COMMENT='用户角色关联表';

-- ----------------------------
-- Records of sys_t_user_role
-- ----------------------------
INSERT INTO `sys_t_user_role` VALUES ('1', '1', '1', null, '1', '0', '1', '2018-06-14 09:55:19', '1', '2018-06-14 09:55:23');

-- ----------------------------
-- Table structure for test_users
-- ----------------------------
DROP TABLE IF EXISTS `test_users`;
CREATE TABLE `test_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID 主键 自增长',
  `name` varchar(100) NOT NULL COMMENT '姓名',
  `age` int(11) DEFAULT NULL COMMENT '年龄',
  `birth_day` datetime DEFAULT NULL COMMENT '生日',
  `head_img` blob,
  `info` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=91 DEFAULT CHARSET=utf8 COMMENT='测试表';

-- ----------------------------
-- Records of test_users
-- ----------------------------
INSERT INTO `test_users` VALUES ('1', '露露', '18', '1992-02-20 00:00:00', null, '活波可爱');
INSERT INTO `test_users` VALUES ('82', '测试1', '21', '1992-04-01 00:00:00', 0x696D6765732F74657374312E6A7067, '这是测试人员1');
INSERT INTO `test_users` VALUES ('83', '测试1', '21', '1992-04-01 00:00:00', 0x696D6765732F74657374312E6A7067, '这是测试人员1');
INSERT INTO `test_users` VALUES ('84', '测试1', '21', '1992-04-01 00:00:00', 0x696D6765732F74657374312E6A7067, '这是测试人员1');
INSERT INTO `test_users` VALUES ('85', '测试1', '21', '1992-04-01 00:00:00', 0x696D6765732F74657374312E6A7067, '这是测试人员1');
INSERT INTO `test_users` VALUES ('86', '测试1', '21', '1992-04-01 00:00:00', 0x696D6765732F74657374312E6A7067, '这是测试人员1');
INSERT INTO `test_users` VALUES ('87', '测试1', '21', '1992-04-01 00:00:00', 0x696D6765732F74657374312E6A7067, '这是测试人员1');
INSERT INTO `test_users` VALUES ('88', '测试1', '21', '1992-04-01 00:00:00', 0x696D6765732F74657374312E6A7067, '这是测试人员1');
INSERT INTO `test_users` VALUES ('89', '测试1', '21', '1992-04-01 00:00:00', 0x696D6765732F74657374312E6A7067, '这是测试人员1');
INSERT INTO `test_users` VALUES ('90', '测试1', '21', '1992-04-01 00:00:00', 0x696D6765732F74657374312E6A7067, '这是测试人员1');
