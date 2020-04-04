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

 Date: 04/04/2020 22:48:02
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for p_auth_rule
-- ----------------------------
DROP TABLE IF EXISTS `p_auth_rule`;
CREATE TABLE `p_auth_rule` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `desc` varchar(255) NOT NULL DEFAULT '',
  `pid` int(11) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(11) NOT NULL DEFAULT '1',
  `condition` varchar(255) DEFAULT '',
  `module` varchar(20) NOT NULL COMMENT '规则所属module',
  `type` tinyint(2) NOT NULL DEFAULT '1' COMMENT '1-url;2-主菜单',
  PRIMARY KEY (`id`),
  KEY `module` (`module`,`status`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for p_user
-- ----------------------------
DROP TABLE IF EXISTS `p_user`;
CREATE TABLE `p_user` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `username` char(16) NOT NULL DEFAULT '' COMMENT '用户名',
  `password` char(32) NOT NULL COMMENT '密码',
  `mobile` char(15) NOT NULL DEFAULT '' COMMENT '手机号',
  `email` char(32) NOT NULL DEFAULT '' COMMENT '邮箱',
  `status` tinyint(11) NOT NULL DEFAULT '1' COMMENT '状态，启用-禁用',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mobile` (`mobile`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of p_user
-- ----------------------------
BEGIN;
INSERT INTO `p_user` VALUES (1, '齐飘洋', '4031b94cb113282a50b007fe12e955ad', '13886441638', '956634645@qq.com', 1);
INSERT INTO `p_user` VALUES (3, '何润升', '4031b94cb113282a50b007fe12e955ad', '13886441637', '956634645@qq.com', 1);
INSERT INTO `p_user` VALUES (5, '何润升', '4031b94cb113282a50b007fe12e955ad', '13886441639', '956634645@qq.com', 1);
INSERT INTO `p_user` VALUES (6, '何润升', '4031b94cb113282a50b007fe12e955ad', '13886441631', '956634645@qq.com', 1);
INSERT INTO `p_user` VALUES (7, '何润升', 'cb975a4555119bd47674fed729a141c1', '13886441632', '956634645@qq.com', 1);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
