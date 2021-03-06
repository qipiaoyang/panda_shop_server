/*
 Navicat Premium Data Transfer

 Source Server         : aliyun
 Source Server Type    : MySQL
 Source Server Version : 50729
 Source Host           : 47.75.78.93:3306
 Source Schema         : panda

 Target Server Type    : MySQL
 Target Server Version : 50729
 File Encoding         : 65001

 Date: 09/04/2020 00:35:40
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for p_auth_role
-- ----------------------------
DROP TABLE IF EXISTS `p_auth_role`;
CREATE TABLE `p_auth_role` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `desc` varchar(255) NOT NULL DEFAULT '',
  `description` varchar(80) NOT NULL DEFAULT '' COMMENT '描述信息',
  `status` tinyint(11) NOT NULL DEFAULT '1',
  `rule_ids` text,
  `module` varchar(20) NOT NULL DEFAULT '' COMMENT '用户组所属模块',
  `type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '组类型',
  `sort` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='后台角色表';

-- ----------------------------
-- Records of p_auth_role
-- ----------------------------
BEGIN;
INSERT INTO `p_auth_role` VALUES (1, '超级管理员', '超级管理员', 1, NULL, 'admin', 0, 0);
INSERT INTO `p_auth_role` VALUES (2, '管理员', '管理员', 1, NULL, 'admin', 1, 0);
COMMIT;

-- ----------------------------
-- Table structure for p_auth_user
-- ----------------------------
DROP TABLE IF EXISTS `p_auth_user`;
CREATE TABLE `p_auth_user` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `username` char(16) NOT NULL DEFAULT '' COMMENT '用户名',
  `password` char(32) NOT NULL COMMENT '密码',
  `mobile` char(15) NOT NULL DEFAULT '' COMMENT '手机号',
  `email` char(32) NOT NULL DEFAULT '' COMMENT '邮箱',
  `status` tinyint(11) NOT NULL DEFAULT '1' COMMENT '状态，启用-禁用',
  `reg_time` bigint(13) NOT NULL COMMENT '注册时间',
  `update_time` bigint(13) NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mobile` (`mobile`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='后台用户表';

-- ----------------------------
-- Records of p_auth_user
-- ----------------------------
BEGIN;
INSERT INTO `p_auth_user` VALUES (1, '齐飘洋2', '4031b94cb113282a50b007fe12e955ad', '13886441638', '956634645@qq.com', 1, 0, 1586191082863);
INSERT INTO `p_auth_user` VALUES (3, '何润升1', '98e7bad2e93f2740d6d6096be1aaee87', '13886441637', '956634645@qq.com', 0, 0, 1586189578835);
INSERT INTO `p_auth_user` VALUES (5, '何润升', '98e7bad2e93f2740d6d6096be1aaee87', '13886441639', '956634645@qq.com', 1, 0, 1586189580640);
INSERT INTO `p_auth_user` VALUES (6, '何润升', '98e7bad2e93f2740d6d6096be1aaee87', '13886441631', '956634645@qq.com', 0, 0, 1586190257424);
INSERT INTO `p_auth_user` VALUES (7, '何润升', '98e7bad2e93f2740d6d6096be1aaee87', '13886441632', '956634645@qq.com', 0, 0, 1586189529047);
INSERT INTO `p_auth_user` VALUES (8, '12312', '98e7bad2e93f2740d6d6096be1aaee87', '12312312', '12312312', 1, 1586167368523, 1586189108555);
INSERT INTO `p_auth_user` VALUES (9, '测试用户', '4031b94cb113282a50b007fe12e955ad', '13886441138', '123456', 1, 1586167443355, 1586167443355);
INSERT INTO `p_auth_user` VALUES (10, '测试222222222', '98e7bad2e93f2740d6d6096be1aaee87', '13886441238', '956634645@qq.com', 1, 1586167533633, 1586189459051);
INSERT INTO `p_auth_user` VALUES (11, '测试用户111111111', '98e7bad2e93f2740d6d6096be1aaee87', '13886441428', '123456', 1, 1586167656491, 1586189493265);
INSERT INTO `p_auth_user` VALUES (12, '测试用户', '4031b94cb113282a50b007fe12e955ad', '13886441678', '956634645@qq.com', 1, 1586168677206, 1586168677206);
INSERT INTO `p_auth_user` VALUES (13, '潘少', '4031b94cb113282a50b007fe12e955ad', '13886441789', '9876554666@qq.com', 1, 1586168707764, 1586168707764);
INSERT INTO `p_auth_user` VALUES (14, '何润升1', 'cb975a4555119bd47674fed729a141c1', '13886441635', '', 1, 1586177554264, 1586177554264);
INSERT INTO `p_auth_user` VALUES (15, 'ceshi', '50ba393c1e544a199130750c72069520', '13886445678', '112312313123@qq.com', 1, 1586189515094, 1586189515094);
COMMIT;

-- ----------------------------
-- Table structure for p_auth_user_role
-- ----------------------------
DROP TABLE IF EXISTS `p_auth_user_role`;
CREATE TABLE `p_auth_user_role` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_role` (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='后台用户角色关联表';

-- ----------------------------
-- Table structure for p_menu
-- ----------------------------
DROP TABLE IF EXISTS `p_menu`;
CREATE TABLE `p_menu` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) DEFAULT NULL COMMENT '父级ID',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `title` varchar(100) DEFAULT NULL COMMENT '菜单名称',
  `level` int(4) DEFAULT NULL COMMENT '菜单级数',
  `sort` int(4) DEFAULT NULL COMMENT '菜单排序',
  `name` varchar(100) DEFAULT NULL COMMENT '前端名称',
  `icon` varchar(200) DEFAULT NULL COMMENT '前端图标',
  `hidden` int(1) DEFAULT NULL COMMENT '前端隐藏',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='后台菜单表';

-- ----------------------------
-- Table structure for p_permission
-- ----------------------------
DROP TABLE IF EXISTS `p_permission`;
CREATE TABLE `p_permission` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `pid` bigint(20) DEFAULT NULL COMMENT '父级权限id',
  `name` varchar(100) DEFAULT NULL COMMENT '名称',
  `value` varchar(200) DEFAULT NULL COMMENT '权限值',
  `icon` varchar(500) DEFAULT NULL COMMENT '图标',
  `type` int(1) DEFAULT NULL COMMENT '权限类型：0->目录；1->菜单；2->按钮（接口绑定权限）',
  `uri` varchar(200) DEFAULT NULL COMMENT '前端资源路径',
  `status` int(1) DEFAULT NULL COMMENT '启用状态；0->禁用；1->启用',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `sort` int(11) DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='后台用户权限表';

-- ----------------------------
-- Table structure for p_power
-- ----------------------------
DROP TABLE IF EXISTS `p_power`;
CREATE TABLE `p_power` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `name` varchar(200) DEFAULT NULL COMMENT '资源名称',
  `url` varchar(200) DEFAULT NULL COMMENT '资源URL',
  `description` varchar(500) DEFAULT NULL COMMENT '描述',
  `category_id` bigint(20) DEFAULT NULL COMMENT '资源分类ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='后台资源表';

-- ----------------------------
-- Table structure for p_power_module
-- ----------------------------
DROP TABLE IF EXISTS `p_power_module`;
CREATE TABLE `p_power_module` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `name` varchar(200) DEFAULT NULL COMMENT '分类名称',
  `sort` int(4) DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='资源分类表';

-- ----------------------------
-- Table structure for p_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `p_role_menu`;
CREATE TABLE `p_role_menu` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) DEFAULT NULL COMMENT '角色ID',
  `menu_id` bigint(20) DEFAULT NULL COMMENT '菜单ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='后台角色菜单关系表';

-- ----------------------------
-- Table structure for p_role_permission
-- ----------------------------
DROP TABLE IF EXISTS `p_role_permission`;
CREATE TABLE `p_role_permission` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) DEFAULT NULL,
  `permission_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='后台用户角色和权限关系表';

-- ----------------------------
-- Table structure for p_role_power
-- ----------------------------
DROP TABLE IF EXISTS `p_role_power`;
CREATE TABLE `p_role_power` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) DEFAULT NULL COMMENT '角色ID',
  `resource_id` bigint(20) DEFAULT NULL COMMENT '资源ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='后台角色资源关系表';

SET FOREIGN_KEY_CHECKS = 1;
