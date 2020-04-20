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

 Date: 10/04/2020 23:12:56
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for p_admin
-- ----------------------------
DROP TABLE IF EXISTS `p_admin`;
CREATE TABLE `p_admin` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `dept_id` bigint(20) NOT NULL COMMENT '团体id',
  `username` varchar(16) NOT NULL DEFAULT '' COMMENT '用户名',
  `password` char(32) NOT NULL COMMENT '密码',
  `mobile` char(15) NOT NULL DEFAULT '' COMMENT '手机号',
  `email` char(32) NOT NULL DEFAULT '' COMMENT '邮箱',
  `status` char(1) NOT NULL DEFAULT '1' COMMENT '状态，启用-禁用',
  `create_time` bigint(13) NOT NULL COMMENT '注册时间',
  `update_time` bigint(13) NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mobile` (`mobile`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='后台用户表';

-- ----------------------------
-- Records of p_admin
-- ----------------------------
BEGIN;
INSERT INTO `p_admin` VALUES (1, 0, '齐飘洋2', '4031b94cb113282a50b007fe12e955ad', '13886441638', '956634645@qq.com', '1', 0, 1586191082863);
INSERT INTO `p_admin` VALUES (3, 0, '何润升1', '98e7bad2e93f2740d6d6096be1aaee87', '13886441637', '956634645@qq.com', '0', 0, 1586189578835);
INSERT INTO `p_admin` VALUES (5, 0, '何润升', '98e7bad2e93f2740d6d6096be1aaee87', '13886441639', '956634645@qq.com', '1', 0, 1586189580640);
INSERT INTO `p_admin` VALUES (6, 0, '何润升', '98e7bad2e93f2740d6d6096be1aaee87', '13886441631', '956634645@qq.com', '0', 0, 1586190257424);
INSERT INTO `p_admin` VALUES (7, 0, '何润升', '98e7bad2e93f2740d6d6096be1aaee87', '13886441632', '956634645@qq.com', '0', 0, 1586189529047);
INSERT INTO `p_admin` VALUES (8, 0, '12312', '98e7bad2e93f2740d6d6096be1aaee87', '12312312', '12312312', '1', 1586167368523, 1586189108555);
INSERT INTO `p_admin` VALUES (9, 0, '测试用户', '4031b94cb113282a50b007fe12e955ad', '13886441138', '123456', '1', 1586167443355, 1586167443355);
INSERT INTO `p_admin` VALUES (10, 0, '测试222222222', '98e7bad2e93f2740d6d6096be1aaee87', '13886441238', '956634645@qq.com', '1', 1586167533633, 1586189459051);
INSERT INTO `p_admin` VALUES (11, 0, '测试用户111111111', '98e7bad2e93f2740d6d6096be1aaee87', '13886441428', '123456', '1', 1586167656491, 1586189493265);
INSERT INTO `p_admin` VALUES (12, 0, '测试用户', '4031b94cb113282a50b007fe12e955ad', '13886441678', '956634645@qq.com', '1', 1586168677206, 1586168677206);
INSERT INTO `p_admin` VALUES (13, 0, '潘少', '4031b94cb113282a50b007fe12e955ad', '13886441789', '9876554666@qq.com', '1', 1586168707764, 1586168707764);
INSERT INTO `p_admin` VALUES (14, 0, '何润升1', 'cb975a4555119bd47674fed729a141c1', '13886441635', '', '1', 1586177554264, 1586177554264);
INSERT INTO `p_admin` VALUES (15, 0, 'ceshi', '50ba393c1e544a199130750c72069520', '13886445678', '112312313123@qq.com', '1', 1586189515094, 1586189515094);
COMMIT;

-- ----------------------------
-- Table structure for p_admin_role
-- ----------------------------
DROP TABLE IF EXISTS `p_admin_role`;
CREATE TABLE `p_admin_role` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_role` (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='后台用户角色关联表';

-- ----------------------------
-- Table structure for p_dept
-- ----------------------------
DROP TABLE IF EXISTS `p_dept`;
CREATE TABLE `p_dept` (
  `dept_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '部门ID',
  `parent_id` bigint(20) NOT NULL COMMENT '上级部门ID',
  `dept_name` varchar(100) NOT NULL COMMENT '部门名称',
  `order_num` double(20,0) DEFAULT NULL COMMENT '排序',
  `create_time` bigint(13) DEFAULT NULL COMMENT '创建时间',
  `update_time` bigint(13) DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`dept_id`) USING BTREE,
  KEY `p_dept_parent_id` (`parent_id`),
  KEY `p_dept_id` (`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='部门表';

-- ----------------------------
-- Table structure for p_menu
-- ----------------------------
DROP TABLE IF EXISTS `p_menu`;
CREATE TABLE `p_menu` (
  `menu_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '菜单/按钮ID',
  `parent_id` bigint(20) NOT NULL COMMENT '上级菜单ID',
  `menu_name` varchar(50) NOT NULL COMMENT '菜单/按钮名称',
  `path` varchar(255) DEFAULT NULL COMMENT '对应路由path',
  `component` varchar(255) DEFAULT NULL COMMENT '对应路由组件component',
  `perms` varchar(50) DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(50) DEFAULT NULL COMMENT '图标',
  `type` char(2) NOT NULL COMMENT '类型 0菜单 1按钮',
  `order_num` double(20,0) DEFAULT NULL COMMENT '排序',
  `create_time` bigint(13) NOT NULL COMMENT '创建时间',
  `update_time` bigint(13) DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`menu_id`) USING BTREE,
  KEY `p_menu_parent_id` (`parent_id`),
  KEY `p_menu_id` (`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='菜单表';

-- ----------------------------
-- Table structure for p_role
-- ----------------------------
DROP TABLE IF EXISTS `p_role`;
CREATE TABLE `p_role` (
  `role_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `role_name` varchar(255) NOT NULL DEFAULT '' COMMENT '角色名称',
  `role_desc` varchar(80) NOT NULL DEFAULT '' COMMENT '角色描述信息',
  `status` char(1) NOT NULL DEFAULT '1' COMMENT '角色状体啊',
  `create_time` bigint(13) NOT NULL DEFAULT '0' COMMENT '角色创建时间',
  `update_time` bigint(13) NOT NULL COMMENT '角色更新时间',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='后台角色表';

-- ----------------------------
-- Records of p_role
-- ----------------------------
BEGIN;
INSERT INTO `p_role` VALUES (1, '超级管理员', '超级管理员', '1', 0, 0);
INSERT INTO `p_role` VALUES (2, '管理员', '管理员', '1', 0, 0);
COMMIT;

-- ----------------------------
-- Table structure for p_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `p_role_menu`;
CREATE TABLE `p_role_menu` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) DEFAULT NULL COMMENT '角色ID',
  `menu_id` bigint(20) DEFAULT NULL COMMENT '菜单ID',
  PRIMARY KEY (`id`),
  UNIQUE KEY `role_menu` (`role_id`,`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='后台角色菜单关系表';

SET FOREIGN_KEY_CHECKS = 1;
