/*
 Navicat Premium Data Transfer

 Source Server         : he800_dev
 Source Server Type    : MySQL
 Source Server Version : 50721
 Source Host           : 192.168.60.5:3306
 Source Schema         : demo_dev

 Target Server Type    : MySQL
 Target Server Version : 50721
 File Encoding         : 65001

 Date: 10/12/2018 16:25:00
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin_sys_app_info
-- ----------------------------
DROP TABLE IF EXISTS `admin_sys_app_info`;
CREATE TABLE `admin_sys_app_info`  (
  `id` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `description` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `target_url` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '跳转路径',
  `params_json` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '跳转参数',
  `auth_url_prefix` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '授权uri前缀，不用*号结束，会授权以此路径开头的url',
  `icon_class` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图标',
  `directory` int(1) NOT NULL DEFAULT 1 COMMENT '是否为目录，0、否，1、是',
  `read_write_type` int(1) NOT NULL DEFAULT 0 COMMENT '控制授权url下，读写级别，优先级比排除授权资源高，0、读写，1、只读，2、只写',
  `parent_id` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `left_val` int(5) NOT NULL DEFAULT 1,
  `right_val` int(5) NOT NULL DEFAULT 2,
  `status` int(1) NOT NULL DEFAULT 0 COMMENT '是否已禁用，0、否，1、是',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '管理端授权应用' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_sys_app_info
-- ----------------------------
INSERT INTO `admin_sys_app_info` VALUES ('0058d22e-95f0-44f9-a9b8-5854b60514cc', '基础信息', '', NULL, NULL, NULL, 'fa fa-bars', 1, 0, 'ROOT', 2, 7, 1);
INSERT INTO `admin_sys_app_info` VALUES ('09547654-805f-40d9-bf1a-33d23d2a810c', '权限管理', '', NULL, NULL, NULL, 'fa fa-sitemap', 1, 0, 'ROOT', 38, 47, 1);
INSERT INTO `admin_sys_app_info` VALUES ('135518ad-84f6-47b9-8404-3e7e91ddb19e', '动态表单编号', '管理动态表单编号', '/admin/dynamicform/codeindex', NULL, '/admin/dynamicform/', 'fa fa-wrench', 0, 0, '477684ff-7340-43cd-bd87-d3bbfb55c462', 28, 29, 1);
INSERT INTO `admin_sys_app_info` VALUES ('16c185e9-b8a0-4fe9-b2f8-a851bcd1521f', '动态表单字段', '动态表单的字段维护，包括子列表字段', '/admin/dynamicform/columnsindex', NULL, '/admin/dynamicform/', 'fa fa-leaf', 0, 0, '477684ff-7340-43cd-bd87-d3bbfb55c462', 30, 31, 1);
INSERT INTO `admin_sys_app_info` VALUES ('1a33054e-fdd4-4ed5-b82c-fb77c8e08d42', '调度作业', '', '/admin/task/index', NULL, '/admin/task/', 'fa fa-clock-o', 0, 0, '742c688f-4976-435d-a491-b3e1c5ce90ed', 51, 52, 1);
INSERT INTO `admin_sys_app_info` VALUES ('1b7b19f1-c6cf-4d27-8dd0-8d37828fdfe7', '短信管理', '短信管理', NULL, NULL, NULL, 'fa fa-envelope-o', 1, 0, '1c0b2584-bfb9-4b3f-8017-b78af38c7499', 33, 36, 1);
INSERT INTO `admin_sys_app_info` VALUES ('1c0b2584-bfb9-4b3f-8017-b78af38c7499', '运营管理', '', NULL, NULL, NULL, 'fa fa-truck', 1, 0, 'ROOT', 16, 37, 1);
INSERT INTO `admin_sys_app_info` VALUES ('36cdd4bd-d2e9-44f9-94f9-546d7e7f2115', '模板管理', '模板管理', '/admin/operation/sms/template/index', NULL, '/admin/operation/sms/template/', 'fa fa-cogs', 0, 0, '1b7b19f1-c6cf-4d27-8dd0-8d37828fdfe7', 34, 35, 1);
INSERT INTO `admin_sys_app_info` VALUES ('431dbaa2-6b8f-45ff-9942-feb92b904de1', '邮件服务', '', '/admin/operation/mail/index', NULL, '/admin/operation/mail/', 'fa fa-envelope-o', 0, 0, '1c0b2584-bfb9-4b3f-8017-b78af38c7499', 17, 18, 1);
INSERT INTO `admin_sys_app_info` VALUES ('477684ff-7340-43cd-bd87-d3bbfb55c462', '动态表单', '动态表单数据相关', NULL, NULL, NULL, 'fa fa-bolt', 1, 0, '1c0b2584-bfb9-4b3f-8017-b78af38c7499', 25, 32, 1);
INSERT INTO `admin_sys_app_info` VALUES ('52bb2b9e-fe36-4a59-ac7c-fe4a17ec112f', '后端帐号管理', '', '/admin/member/index', NULL, '/admin/member/', 'fa fa-users', 0, 0, '09547654-805f-40d9-bf1a-33d23d2a810c', 43, 44, 1);
INSERT INTO `admin_sys_app_info` VALUES ('52c675f5-784e-423b-a33b-db98958a1a68', '消息事件', '', '/admin/event/index', NULL, '/event/index', 'fa fa-bolt', 0, 0, '742c688f-4976-435d-a491-b3e1c5ce90ed', 53, 54, 1);
INSERT INTO `admin_sys_app_info` VALUES ('55b4ebc8-0e6f-4d56-a6db-21201a22f4ca', 'swagger', 'swagger', '/admin/doc.html', NULL, '/admin/', 'fa fa-bullseye', 0, 0, '09547654-805f-40d9-bf1a-33d23d2a810c', 45, 46, 1);
INSERT INTO `admin_sys_app_info` VALUES ('5abc526b-91d2-4a32-8934-7def5e203d12', '菜单管理', '', '/admin/appInfo/index', NULL, '/admin/appInfo/', 'fa fa-list-ul', 0, 0, '09547654-805f-40d9-bf1a-33d23d2a810c', 39, 40, 1);
INSERT INTO `admin_sys_app_info` VALUES ('5d7ced1d-3a82-49d3-81b6-e7fc2c3e0709', '用户管理', '', NULL, NULL, NULL, 'fa fa-user', 1, 0, 'ROOT', 8, 11, 1);
INSERT INTO `admin_sys_app_info` VALUES ('5f3cb494-59c6-4475-bbe3-b8a58c66c8d2', 'ElasticSearch', '', '/admin/es/index', NULL, '/admin/es/', 'fa fa-book', 0, 0, '742c688f-4976-435d-a491-b3e1c5ce90ed', 49, 50, 1);
INSERT INTO `admin_sys_app_info` VALUES ('6783617b-9985-4a93-bf3d-c9949eeefc9a', '角色管理', '', '/admin/role/index', NULL, '/admin/role/', 'fa fa-smile-o', 0, 0, '09547654-805f-40d9-bf1a-33d23d2a810c', 41, 42, 1);
INSERT INTO `admin_sys_app_info` VALUES ('742c688f-4976-435d-a491-b3e1c5ce90ed', '系统管理', '', NULL, NULL, NULL, 'fa fa-cogs', 1, 0, 'ROOT', 48, 55, 1);
INSERT INTO `admin_sys_app_info` VALUES ('86de9396-e575-4014-9668-e3138034e11b', '人员分类', '', '/admin/userType/index', NULL, '/admin/userType/', 'fa fa-tags', 0, 0, '97738031-12c3-48b6-8e5f-788951dcc7ab', 13, 14, 1);
INSERT INTO `admin_sys_app_info` VALUES ('97738031-12c3-48b6-8e5f-788951dcc7ab', '服务对象', '', NULL, NULL, NULL, 'fa fa-users', 1, 0, 'ROOT', 12, 15, 1);
INSERT INTO `admin_sys_app_info` VALUES ('b04f2b00-8f8d-47e4-9b6f-20392e9c3c02', '区域管理', '', '/admin/region/index', NULL, '/admin/region/', 'fa fa-map-marker', 0, 0, '0058d22e-95f0-44f9-a9b8-5854b60514cc', 3, 4, 1);
INSERT INTO `admin_sys_app_info` VALUES ('b4d0bee0-5cce-4e1a-8e82-2b66289525d6', '字典数据', '字典数据', '/admin/sys/dictionary/index', NULL, '/admin/sys/dictionary,/admin/sys/dictionary/', 'fa fa-book', 0, 0, '0058d22e-95f0-44f9-a9b8-5854b60514cc', 5, 6, 1);
INSERT INTO `admin_sys_app_info` VALUES ('b893e895-4310-4e78-ad32-355fb6f8c7a8', '短信服务', '', '/admin/operation/sms/index', NULL, '/admin/operation/sms/', 'fa fa-mobile', 0, 0, '1c0b2584-bfb9-4b3f-8017-b78af38c7499', 19, 20, 1);
INSERT INTO `admin_sys_app_info` VALUES ('dacd1838-f480-4ace-b695-d1ca03bb946e', '系统消息', '', '/admin/message/index', NULL, '/admin/message/', 'fa fa-comment-o', 0, 0, '1c0b2584-bfb9-4b3f-8017-b78af38c7499', 21, 22, 1);
INSERT INTO `admin_sys_app_info` VALUES ('e2eecc2b-bb0f-4af3-8086-8893b02fc8a6', '动态表单', '', '/admin/dynamicform/index', NULL, '/admin/dynamicform/', 'fa fa-fighter-jet', 0, 0, '477684ff-7340-43cd-bd87-d3bbfb55c462', 26, 27, 1);
INSERT INTO `admin_sys_app_info` VALUES ('f298af01-5284-4a6f-a290-62d89fd049da', '动态数据配置', '配置前端展示的动态数据', '/admin/sys/variable/index', NULL, '/admin/sys/variable/', 'fa fa-align-center', 0, 0, '1c0b2584-bfb9-4b3f-8017-b78af38c7499', 23, 24, 1);
INSERT INTO `admin_sys_app_info` VALUES ('f478f151-dde3-4424-b737-a57f26e614a2', '注册用户列表', '', '/admin/user/manager/index', NULL, '/admin/user/manager/,/admin/service/,/admin/order/,/admin/service/consult/', 'fa fa-star-o', 0, 0, '5d7ced1d-3a82-49d3-81b6-e7fc2c3e0709', 9, 10, 1);
INSERT INTO `admin_sys_app_info` VALUES ('ROOT', '应用菜单', '根节点，不会显示', NULL, NULL, NULL, 'fa fa-rocket', 1, 0, '', 1, 56, 1);

-- ----------------------------
-- Table structure for admin_sys_app_info_role
-- ----------------------------
DROP TABLE IF EXISTS `admin_sys_app_info_role`;
CREATE TABLE `admin_sys_app_info_role`  (
  `id` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `app_info_id` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `role_id` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for admin_sys_member
-- ----------------------------
DROP TABLE IF EXISTS `admin_sys_member`;
CREATE TABLE `admin_sys_member`  (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `account` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `pwd` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `member_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '成员编码',
  `member_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `gender` int(2) NULL DEFAULT 0 COMMENT '0、 未填写  1、男  2、女',
  `email_address` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `member_type` int(2) NOT NULL DEFAULT 0 COMMENT '0、部门 1、员工用户',
  `create_time` datetime(0) NOT NULL,
  `last_login_time` datetime(0) NULL DEFAULT NULL,
  `last_login_ip` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `status` int(2) NOT NULL DEFAULT 1 COMMENT '1,正常 0.限制登录',
  `parent_id` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `left_val` int(11) NOT NULL DEFAULT 0,
  `right_val` int(11) NOT NULL DEFAULT 0,
  `tree_kind` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '树分类',
  `region_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `default_org` int(11) NULL DEFAULT 0 COMMENT '是否默认机构',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '后台组织机构' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_sys_member
-- ----------------------------
INSERT INTO `admin_sys_member` VALUES ('0', NULL, NULL, NULL, NULL, '后台成员', NULL, NULL, 0, '2018-03-17 10:56:11', NULL, NULL, 1, '', 1, 12, 'ADMIN', NULL, NULL);
INSERT INTO `admin_sys_member` VALUES ('0af929d5-839e-4bc2-bede-bb796de0421c', 'admin', 'qv5L2DYfMpXn/e5lVTJ8fQ==', NULL, NULL, 'Super Man', NULL, NULL, 1, '2018-04-09 13:32:08', '2018-12-10 16:11:35', '127.0.0.1', 1, '69f09f47-137c-4172-a10e-e9e03840c90a', 3, 4, 'ADMIN', NULL, 0);
INSERT INTO `admin_sys_member` VALUES ('1083edd2-6cd9-463b-80ae-7dfcffee57c4', '13444444444', 'vdm485asZ5poXPRuOxc9BQBrSvudoU7kwVZhrKlEGWY=', NULL, NULL, '李四', NULL, NULL, 1, '2018-04-26 13:34:29', NULL, NULL, 1, 'a85d8ed0-717a-47e3-a8e1-6d85e20466b5', 9, 10, 'ADMIN', NULL, NULL);
INSERT INTO `admin_sys_member` VALUES ('3a1ffe62-9303-4b42-8c3d-97ed00ed5d48', '13333333333', 'fODTFyp4J01dex3j+FQaMwBrSvudoU7kwVZhrKlEGWY=', NULL, NULL, '张三', NULL, NULL, 1, '2018-04-26 13:33:50', NULL, NULL, 1, 'a85d8ed0-717a-47e3-a8e1-6d85e20466b5', 7, 8, 'ADMIN', NULL, NULL);
INSERT INTO `admin_sys_member` VALUES ('69f09f47-137c-4172-a10e-e9e03840c90a', NULL, NULL, NULL, NULL, '管理员', NULL, NULL, 0, '2018-03-20 11:54:12', NULL, NULL, 1, '0', 2, 5, 'ADMIN', NULL, 0);
INSERT INTO `admin_sys_member` VALUES ('a85d8ed0-717a-47e3-a8e1-6d85e20466b5', NULL, NULL, NULL, NULL, '运营人员', NULL, NULL, 0, '2018-04-26 13:32:21', NULL, NULL, 1, '0', 6, 11, 'ADMIN', NULL, 0);

-- ----------------------------
-- Table structure for admin_sys_member_attr
-- ----------------------------
DROP TABLE IF EXISTS `admin_sys_member_attr`;
CREATE TABLE `admin_sys_member_attr`  (
  `id` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `member_id` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `attr_key` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `attr_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `attr_value` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for admin_sys_member_role
-- ----------------------------
DROP TABLE IF EXISTS `admin_sys_member_role`;
CREATE TABLE `admin_sys_member_role`  (
  `id` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `member_id` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `role_id` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_sys_member_role
-- ----------------------------
INSERT INTO `admin_sys_member_role` VALUES ('03e09fd1-f856-489d-b365-9be0958cfbd4', '0af929d5-839e-4bc2-bede-bb796de0421c', 'd1817b1b-7a12-480e-b2d7-f3856e099b2a');

-- ----------------------------
-- Table structure for admin_sys_role
-- ----------------------------
DROP TABLE IF EXISTS `admin_sys_role`;
CREATE TABLE `admin_sys_role`  (
  `id` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `order_no` int(5) NOT NULL DEFAULT 1,
  `description` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `code` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '编码',
  `status` int(1) NOT NULL DEFAULT 1 COMMENT '启用状态，0、禁用，1、启用',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_sys_role
-- ----------------------------
INSERT INTO `admin_sys_role` VALUES ('17f3af57-3738-4947-ba8b-159ee5fc23e5', '后台监控', 2, '监控后台业务数据', NULL, 1);
INSERT INTO `admin_sys_role` VALUES ('d1817b1b-7a12-480e-b2d7-f3856e099b2a', '超级管理员', 1, '开放全部权限', '', 1);

-- ----------------------------
-- Table structure for base_attachment
-- ----------------------------
DROP TABLE IF EXISTS `base_attachment`;
CREATE TABLE `base_attachment`  (
  `id` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `url` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `file_type` int(11) NOT NULL COMMENT '0、其他，1、企业营业执照，2、法人身份证，3、银行流水，4、协议书，5、合同',
  `remark` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ref_id` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `size` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '大小',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '附件表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for base_attachment_auth
-- ----------------------------
DROP TABLE IF EXISTS `base_attachment_auth`;
CREATE TABLE `base_attachment_auth`  (
  `id` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `attachment_id` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `user_id` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `url` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '附件权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for base_attachment_ref
-- ----------------------------
DROP TABLE IF EXISTS `base_attachment_ref`;
CREATE TABLE `base_attachment_ref`  (
  `id` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `attachment_id` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `ref_id` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `ref_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '附件关联关系表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for base_dictionary
-- ----------------------------
DROP TABLE IF EXISTS `base_dictionary`;
CREATE TABLE `base_dictionary`  (
  `id` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `dict_code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `dict_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `remarks` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `data_type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `order_no` int(11) NULL DEFAULT NULL,
  `status` int(1) NOT NULL DEFAULT 0 COMMENT '0、禁用 1、启用',
  `can_edit` int(1) NOT NULL DEFAULT 1 COMMENT '0、不可编辑 1、可编辑',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '字典表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for base_dictionary_data
-- ----------------------------
DROP TABLE IF EXISTS `base_dictionary_data`;
CREATE TABLE `base_dictionary_data`  (
  `id` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `dict_id` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `data_value` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `data_key` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `data_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `order_no` int(11) NOT NULL,
  `remarks` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `status` int(1) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '字典数据表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for base_dynamic_data_child
-- ----------------------------
DROP TABLE IF EXISTS `base_dynamic_data_child`;
CREATE TABLE `base_dynamic_data_child`  (
  `id` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `ref_id` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '统一社会信用代码',
  `json_data` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '机构名称',
  `status` int(11) NOT NULL COMMENT '法定代表人',
  `code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '动态表单数据从表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for base_dynamic_data_code
-- ----------------------------
DROP TABLE IF EXISTS `base_dynamic_data_code`;
CREATE TABLE `base_dynamic_data_code`  (
  `id` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '表单编号',
  `begin_time` datetime(0) NOT NULL COMMENT '开始时间',
  `end_time` datetime(0) NOT NULL COMMENT '结束时间',
  `title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '表单标题',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `status` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '动态表单类型' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for base_dynamic_data_columns
-- ----------------------------
DROP TABLE IF EXISTS `base_dynamic_data_columns`;
CREATE TABLE `base_dynamic_data_columns`  (
  `id` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `json_data` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '机构名称',
  `status` int(11) NOT NULL COMMENT '法定代表人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '动态表单列' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for base_dynamic_form_data
-- ----------------------------
DROP TABLE IF EXISTS `base_dynamic_form_data`;
CREATE TABLE `base_dynamic_form_data`  (
  `id` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `code` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标识某次表单类型',
  `title` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '表单标题',
  `json_data` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '{\"columns\":[{\"field\":\"name\",\"title\":\"名字\"},{\"field\":\"sex\",\"title\":\"性别\"}],\"data\":[{\"name\":\"哈哈哈\",\"sex\":\"男\"},{\"name\":\"tec\",\"sex\":\"男\"}]}',
  `create_time` datetime(0) NOT NULL,
  `status` int(255) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '动态表单数据' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for base_email
-- ----------------------------
DROP TABLE IF EXISTS `base_email`;
CREATE TABLE `base_email`  (
  `id` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `subject` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `addressee` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime(0) NOT NULL,
  `author_id` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `status` int(11) NOT NULL DEFAULT 0 COMMENT '0、未发送 1、已发送',
  `mailbox_id` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `count` int(11) NOT NULL DEFAULT 0,
  `send_time` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '邮件' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for base_mailbox
-- ----------------------------
DROP TABLE IF EXISTS `base_mailbox`;
CREATE TABLE `base_mailbox`  (
  `id` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `address` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `password` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sign` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime(0) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 0 COMMENT '0、禁用 1、启用',
  `priority` int(11) NOT NULL DEFAULT 0,
  `smtp` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '邮箱' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for base_region
-- ----------------------------
DROP TABLE IF EXISTS `base_region`;
CREATE TABLE `base_region`  (
  `id` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name_path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `order_no` int(11) NOT NULL DEFAULT 0,
  `parent_id` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `leaf` int(11) NULL DEFAULT 0 COMMENT '0、否 1、是',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime(0) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 0 COMMENT '0、禁用 1、启用',
  `left_val` int(11) NOT NULL DEFAULT 0,
  `right_val` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `parentId`(`parent_id`) USING BTREE,
  INDEX `region_id_index`(`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '地区' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of base_region
-- ----------------------------
INSERT INTO `base_region` VALUES ('09579f35-276f-4af0-992e-37bffb35e776', '经开区', '重庆-重庆-经开区', 1044601, '1040100', 1, '经开区', '2018-08-28 10:27:45', 1, 192, 193);
INSERT INTO `base_region` VALUES ('1010000', '北京', '北京', 1010000, 'ROOT', 0, NULL, '2018-03-30 12:00:00', 1, 2, 37);
INSERT INTO `base_region` VALUES ('1010100', '北京', '北京-北京', 1010100, '1010000', 0, NULL, '2018-03-30 12:00:00', 1, 3, 36);
INSERT INTO `base_region` VALUES ('1010200', '海淀', '北京-北京-海淀', 1010200, '1010100', 1, NULL, '2018-03-30 12:00:00', 1, 4, 5);
INSERT INTO `base_region` VALUES ('1010300', '朝阳', '北京-北京-朝阳', 1010300, '1010100', 1, NULL, '2018-03-30 12:00:00', 1, 6, 7);
INSERT INTO `base_region` VALUES ('1010400', '顺义', '北京-北京-顺义', 1010400, '1010100', 1, NULL, '2018-03-30 12:00:00', 1, 8, 9);
INSERT INTO `base_region` VALUES ('1010500', '怀柔', '北京-北京-怀柔', 1010500, '1010100', 1, NULL, '2018-03-30 12:00:00', 1, 10, 11);
INSERT INTO `base_region` VALUES ('1010600', '通州', '北京-北京-通州', 1010600, '1010100', 1, NULL, '2018-03-30 12:00:00', 1, 12, 13);
INSERT INTO `base_region` VALUES ('1010700', '昌平', '北京-北京-昌平', 1010700, '1010100', 1, NULL, '2018-03-30 12:00:00', 1, 14, 15);
INSERT INTO `base_region` VALUES ('1010800', '延庆', '北京-北京-延庆', 1010800, '1010100', 1, NULL, '2018-03-30 12:00:00', 1, 16, 17);
INSERT INTO `base_region` VALUES ('1010900', '丰台', '北京-北京-丰台', 1010900, '1010100', 1, NULL, '2018-03-30 12:00:00', 1, 18, 19);
INSERT INTO `base_region` VALUES ('1011000', '石景山', '北京-北京-石景山', 1011000, '1010100', 1, NULL, '2018-03-30 12:00:00', 1, 20, 21);
INSERT INTO `base_region` VALUES ('1011100', '大兴', '北京-北京-大兴', 1011100, '1010100', 1, NULL, '2018-03-30 12:00:00', 1, 22, 23);
INSERT INTO `base_region` VALUES ('1011200', '房山', '北京-北京-房山', 1011200, '1010100', 1, NULL, '2018-03-30 12:00:00', 1, 24, 25);
INSERT INTO `base_region` VALUES ('1011300', '密云', '北京-北京-密云', 1011300, '1010100', 1, NULL, '2018-03-30 12:00:00', 1, 26, 27);
INSERT INTO `base_region` VALUES ('1011400', '门头沟', '北京-北京-门头沟', 1011400, '1010100', 1, NULL, '2018-03-30 12:00:00', 1, 28, 29);
INSERT INTO `base_region` VALUES ('1011500', '平谷', '北京-北京-平谷', 1011500, '1010100', 1, NULL, '2018-03-30 12:00:00', 1, 30, 31);
INSERT INTO `base_region` VALUES ('1011600', '东城', '北京-北京-东城', 1011600, '1010100', 1, NULL, '2018-03-30 12:00:00', 1, 32, 33);
INSERT INTO `base_region` VALUES ('1011700', '西城', '北京-北京-西城', 1011700, '1010100', 1, NULL, '2018-03-30 12:00:00', 1, 34, 35);
INSERT INTO `base_region` VALUES ('1020000', '上海', '上海', 1020000, 'ROOT', 0, NULL, '2018-03-30 12:00:00', 1, 38, 73);
INSERT INTO `base_region` VALUES ('1020100', '上海', '上海-上海', 1020100, '1020000', 0, NULL, '2018-03-30 12:00:00', 1, 39, 72);
INSERT INTO `base_region` VALUES ('1020200', '闵行', '上海-上海-闵行', 1020200, '1020100', 1, NULL, '2018-03-30 12:00:00', 1, 40, 41);
INSERT INTO `base_region` VALUES ('1020300', '宝山', '上海-上海-宝山', 1020300, '1020100', 1, NULL, '2018-03-30 12:00:00', 1, 42, 43);
INSERT INTO `base_region` VALUES ('1020400', '黄浦', '上海-上海-黄浦', 1020400, '1020100', 1, NULL, '2018-03-30 12:00:00', 1, 44, 45);
INSERT INTO `base_region` VALUES ('1020500', '嘉定', '上海-上海-嘉定', 1020500, '1020100', 1, NULL, '2018-03-30 12:00:00', 1, 46, 47);
INSERT INTO `base_region` VALUES ('1020600', '浦东新区', '上海-上海-浦东新区', 1020600, '1020100', 1, NULL, '2018-03-30 12:00:00', 1, 48, 49);
INSERT INTO `base_region` VALUES ('1020700', '金山', '上海-上海-金山', 1020700, '1020100', 1, NULL, '2018-03-30 12:00:00', 1, 50, 51);
INSERT INTO `base_region` VALUES ('1020800', '青浦', '上海-上海-青浦', 1020800, '1020100', 1, NULL, '2018-03-30 12:00:00', 1, 52, 53);
INSERT INTO `base_region` VALUES ('1020900', '松江', '上海-上海-松江', 1020900, '1020100', 1, NULL, '2018-03-30 12:00:00', 1, 54, 55);
INSERT INTO `base_region` VALUES ('1021000', '奉贤', '上海-上海-奉贤', 1021000, '1020100', 1, NULL, '2018-03-30 12:00:00', 1, 56, 57);
INSERT INTO `base_region` VALUES ('1021100', '崇明', '上海-上海-崇明', 1021100, '1020100', 1, NULL, '2018-03-30 12:00:00', 1, 58, 59);
INSERT INTO `base_region` VALUES ('1021200', '徐汇', '上海-上海-徐汇', 1021200, '1020100', 1, NULL, '2018-03-30 12:00:00', 1, 60, 61);
INSERT INTO `base_region` VALUES ('1021300', '长宁', '上海-上海-长宁', 1021300, '1020100', 1, NULL, '2018-03-30 12:00:00', 1, 62, 63);
INSERT INTO `base_region` VALUES ('1021400', '静安', '上海-上海-静安', 1021400, '1020100', 1, NULL, '2018-03-30 12:00:00', 1, 64, 65);
INSERT INTO `base_region` VALUES ('1021500', '普陀', '上海-上海-普陀', 1021500, '1020100', 1, NULL, '2018-03-30 12:00:00', 1, 66, 67);
INSERT INTO `base_region` VALUES ('1021600', '虹口', '上海-上海-虹口', 1021600, '1020100', 1, NULL, '2018-03-30 12:00:00', 1, 68, 69);
INSERT INTO `base_region` VALUES ('1021700', '杨浦', '上海-上海-杨浦', 1021700, '1020100', 1, NULL, '2018-03-30 12:00:00', 1, 70, 71);
INSERT INTO `base_region` VALUES ('1030000', '天津', '天津', 1030000, 'ROOT', 0, NULL, '2018-03-30 12:00:00', 1, 74, 109);
INSERT INTO `base_region` VALUES ('1030100', '天津', '天津-天津', 1030100, '1030000', 0, NULL, '2018-03-30 12:00:00', 1, 75, 108);
INSERT INTO `base_region` VALUES ('1030200', '武清', '天津-天津-武清', 1030200, '1030100', 1, NULL, '2018-03-30 12:00:00', 1, 76, 77);
INSERT INTO `base_region` VALUES ('1030300', '宝坻', '天津-天津-宝坻', 1030300, '1030100', 1, NULL, '2018-03-30 12:00:00', 1, 78, 79);
INSERT INTO `base_region` VALUES ('1030400', '东丽', '天津-天津-东丽', 1030400, '1030100', 1, NULL, '2018-03-30 12:00:00', 1, 80, 81);
INSERT INTO `base_region` VALUES ('1030500', '西青', '天津-天津-西青', 1030500, '1030100', 1, NULL, '2018-03-30 12:00:00', 1, 82, 83);
INSERT INTO `base_region` VALUES ('1030600', '北辰', '天津-天津-北辰', 1030600, '1030100', 1, NULL, '2018-03-30 12:00:00', 1, 84, 85);
INSERT INTO `base_region` VALUES ('1030700', '宁河', '天津-天津-宁河', 1030700, '1030100', 1, NULL, '2018-03-30 12:00:00', 1, 86, 87);
INSERT INTO `base_region` VALUES ('1030800', '和平', '天津-天津-和平', 1030800, '1030100', 1, NULL, '2018-03-30 12:00:00', 1, 88, 89);
INSERT INTO `base_region` VALUES ('1030900', '静海', '天津-天津-静海', 1030900, '1030100', 1, NULL, '2018-03-30 12:00:00', 1, 90, 91);
INSERT INTO `base_region` VALUES ('1031000', '津南', '天津-天津-津南', 1031000, '1030100', 1, NULL, '2018-03-30 12:00:00', 1, 92, 93);
INSERT INTO `base_region` VALUES ('1031100', '滨海新区', '天津-天津-滨海新区', 1031100, '1030100', 1, NULL, '2018-03-30 12:00:00', 1, 94, 95);
INSERT INTO `base_region` VALUES ('1031200', '河东', '天津-天津-河东', 1031200, '1030100', 1, NULL, '2018-03-30 12:00:00', 1, 96, 97);
INSERT INTO `base_region` VALUES ('1031300', '河西', '天津-天津-河西', 1031300, '1030100', 1, NULL, '2018-03-30 12:00:00', 1, 98, 99);
INSERT INTO `base_region` VALUES ('1031400', '蓟州', '天津-天津-蓟州', 1031400, '1030100', 1, NULL, '2018-03-30 12:00:00', 1, 100, 101);
INSERT INTO `base_region` VALUES ('1031500', '南开', '天津-天津-南开', 1031500, '1030100', 1, NULL, '2018-03-30 12:00:00', 1, 102, 103);
INSERT INTO `base_region` VALUES ('1031600', '河北区', '天津-天津-河北区', 1031600, '1030100', 1, NULL, '2018-03-30 12:00:00', 1, 104, 105);
INSERT INTO `base_region` VALUES ('1031700', '红桥', '天津-天津-红桥', 1031700, '1030100', 1, NULL, '2018-03-30 12:00:00', 1, 106, 107);
INSERT INTO `base_region` VALUES ('1040000', '重庆', '重庆', 1040000, 'ROOT', 0, NULL, '2018-03-30 12:00:00', 1, 110, 199);
INSERT INTO `base_region` VALUES ('1040100', '重庆', '重庆-重庆', 1040100, '1040000', 0, NULL, '2018-03-30 12:00:00', 1, 111, 198);
INSERT INTO `base_region` VALUES ('1040200', '永川', '重庆-重庆-永川', 1040200, '1040100', 1, NULL, '2018-03-30 12:00:00', 1, 112, 113);
INSERT INTO `base_region` VALUES ('1040300', '合川', '重庆-重庆-合川', 1040300, '1040100', 1, NULL, '2018-03-30 12:00:00', 1, 114, 115);
INSERT INTO `base_region` VALUES ('1040400', '南川', '重庆-重庆-南川', 1040400, '1040100', 1, NULL, '2018-03-30 12:00:00', 1, 116, 117);
INSERT INTO `base_region` VALUES ('1040500', '江津', '重庆-重庆-江津', 1040500, '1040100', 1, NULL, '2018-03-30 12:00:00', 1, 118, 119);
INSERT INTO `base_region` VALUES ('1040700', '渝北', '重庆-重庆-渝北', 1040700, '1040100', 1, NULL, '2018-03-30 12:00:00', 1, 120, 121);
INSERT INTO `base_region` VALUES ('1040800', '北碚', '重庆-重庆-北碚', 1040800, '1040100', 1, NULL, '2018-03-30 12:00:00', 1, 122, 123);
INSERT INTO `base_region` VALUES ('1040900', '巴南', '重庆-重庆-巴南', 1040900, '1040100', 1, NULL, '2018-03-30 12:00:00', 1, 124, 125);
INSERT INTO `base_region` VALUES ('1041000', '长寿', '重庆-重庆-长寿', 1041000, '1040100', 1, NULL, '2018-03-30 12:00:00', 1, 126, 127);
INSERT INTO `base_region` VALUES ('1041100', '黔江', '重庆-重庆-黔江', 1041100, '1040100', 1, NULL, '2018-03-30 12:00:00', 1, 128, 129);
INSERT INTO `base_region` VALUES ('1041200', '渝中', '重庆-重庆-渝中', 1041200, '1040100', 1, NULL, '2018-03-30 12:00:00', 1, 130, 131);
INSERT INTO `base_region` VALUES ('1041300', '万州', '重庆-重庆-万州', 1041300, '1040100', 1, NULL, '2018-03-30 12:00:00', 1, 132, 133);
INSERT INTO `base_region` VALUES ('1041400', '涪陵', '重庆-重庆-涪陵', 1041400, '1040100', 1, NULL, '2018-03-30 12:00:00', 1, 134, 135);
INSERT INTO `base_region` VALUES ('1041500', '开县', '重庆-重庆-开县', 1041500, '1040100', 1, NULL, '2018-03-30 12:00:00', 1, 136, 137);
INSERT INTO `base_region` VALUES ('1041600', '城口', '重庆-重庆-城口', 1041600, '1040100', 1, NULL, '2018-03-30 12:00:00', 1, 138, 139);
INSERT INTO `base_region` VALUES ('1041700', '云阳', '重庆-重庆-云阳', 1041700, '1040100', 1, NULL, '2018-03-30 12:00:00', 1, 140, 141);
INSERT INTO `base_region` VALUES ('1041800', '巫溪', '重庆-重庆-巫溪', 1041800, '1040100', 1, NULL, '2018-03-30 12:00:00', 1, 142, 143);
INSERT INTO `base_region` VALUES ('1041900', '奉节', '重庆-重庆-奉节', 1041900, '1040100', 1, NULL, '2018-03-30 12:00:00', 1, 144, 145);
INSERT INTO `base_region` VALUES ('1042000', '巫山', '重庆-重庆-巫山', 1042000, '1040100', 1, NULL, '2018-03-30 12:00:00', 1, 146, 147);
INSERT INTO `base_region` VALUES ('1042100', '潼南', '重庆-重庆-潼南', 1042100, '1040100', 1, NULL, '2018-03-30 12:00:00', 1, 148, 149);
INSERT INTO `base_region` VALUES ('1042200', '垫江', '重庆-重庆-垫江', 1042200, '1040100', 1, NULL, '2018-03-30 12:00:00', 1, 150, 151);
INSERT INTO `base_region` VALUES ('1042300', '梁平', '重庆-重庆-梁平', 1042300, '1040100', 1, NULL, '2018-03-30 12:00:00', 1, 152, 153);
INSERT INTO `base_region` VALUES ('1042400', '忠县', '重庆-重庆-忠县', 1042400, '1040100', 1, NULL, '2018-03-30 12:00:00', 1, 154, 155);
INSERT INTO `base_region` VALUES ('1042500', '石柱', '重庆-重庆-石柱', 1042500, '1040100', 1, NULL, '2018-03-30 12:00:00', 1, 156, 157);
INSERT INTO `base_region` VALUES ('1042600', '大足', '重庆-重庆-大足', 1042600, '1040100', 1, NULL, '2018-03-30 12:00:00', 1, 158, 159);
INSERT INTO `base_region` VALUES ('1042700', '荣昌', '重庆-重庆-荣昌', 1042700, '1040100', 1, NULL, '2018-03-30 12:00:00', 1, 160, 161);
INSERT INTO `base_region` VALUES ('1042800', '铜梁', '重庆-重庆-铜梁', 1042800, '1040100', 1, NULL, '2018-03-30 12:00:00', 1, 162, 163);
INSERT INTO `base_region` VALUES ('1042900', '璧山', '重庆-重庆-璧山', 1042900, '1040100', 1, NULL, '2018-03-30 12:00:00', 1, 164, 165);
INSERT INTO `base_region` VALUES ('1043000', '丰都', '重庆-重庆-丰都', 1043000, '1040100', 1, NULL, '2018-03-30 12:00:00', 1, 166, 167);
INSERT INTO `base_region` VALUES ('1043100', '武隆', '重庆-重庆-武隆', 1043100, '1040100', 1, NULL, '2018-03-30 12:00:00', 1, 168, 169);
INSERT INTO `base_region` VALUES ('1043200', '彭水', '重庆-重庆-彭水', 1043200, '1040100', 1, NULL, '2018-03-30 12:00:00', 1, 170, 171);
INSERT INTO `base_region` VALUES ('1043300', '綦江', '重庆-重庆-綦江', 1043300, '1040100', 1, NULL, '2018-03-30 12:00:00', 1, 172, 173);
INSERT INTO `base_region` VALUES ('1043400', '酉阳', '重庆-重庆-酉阳', 1043400, '1040100', 1, NULL, '2018-03-30 12:00:00', 1, 174, 175);
INSERT INTO `base_region` VALUES ('1043500', '大渡口', '重庆-重庆-大渡口', 1043500, '1040100', 1, NULL, '2018-03-30 12:00:00', 1, 176, 177);
INSERT INTO `base_region` VALUES ('1043600', '秀山', '重庆-重庆-秀山', 1043600, '1040100', 1, NULL, '2018-03-30 12:00:00', 1, 178, 179);
INSERT INTO `base_region` VALUES ('1043700', '江北', '重庆-重庆-江北', 1043700, '1040100', 1, NULL, '2018-03-30 12:00:00', 1, 180, 181);
INSERT INTO `base_region` VALUES ('1043800', '沙坪坝', '重庆-重庆-沙坪坝', 1043800, '1040100', 1, NULL, '2018-03-30 12:00:00', 1, 182, 183);
INSERT INTO `base_region` VALUES ('1043900', '九龙坡', '重庆-重庆-九龙坡', 1043900, '1040100', 1, NULL, '2018-03-30 12:00:00', 1, 184, 185);
INSERT INTO `base_region` VALUES ('1044000', '南岸', '重庆-重庆-南岸', 1044000, '1040100', 1, NULL, '2018-03-30 12:00:00', 1, 186, 187);
INSERT INTO `base_region` VALUES ('1044100', '开州', '重庆-重庆-开州', 1044100, '1040100', 1, NULL, '2018-03-30 12:00:00', 1, 188, 189);
INSERT INTO `base_region` VALUES ('1050000', '黑龙江', '黑龙江', 1050000, 'ROOT', 0, NULL, '2018-03-30 12:00:00', 1, 200, 481);
INSERT INTO `base_region` VALUES ('1050101', '哈尔滨', '黑龙江-哈尔滨', 1050101, '1050000', 0, NULL, '2018-03-30 12:00:00', 1, 201, 238);
INSERT INTO `base_region` VALUES ('1050102', '双城', '黑龙江-哈尔滨-双城', 1050102, '1050101', 1, NULL, '2018-03-30 12:00:00', 1, 202, 203);
INSERT INTO `base_region` VALUES ('1050103', '呼兰', '黑龙江-哈尔滨-呼兰', 1050103, '1050101', 1, NULL, '2018-03-30 12:00:00', 1, 204, 205);
INSERT INTO `base_region` VALUES ('1050104', '阿城', '黑龙江-哈尔滨-阿城', 1050104, '1050101', 1, NULL, '2018-03-30 12:00:00', 1, 206, 207);
INSERT INTO `base_region` VALUES ('1050105', '宾县', '黑龙江-哈尔滨-宾县', 1050105, '1050101', 1, NULL, '2018-03-30 12:00:00', 1, 208, 209);
INSERT INTO `base_region` VALUES ('1050106', '依兰', '黑龙江-哈尔滨-依兰', 1050106, '1050101', 1, NULL, '2018-03-30 12:00:00', 1, 210, 211);
INSERT INTO `base_region` VALUES ('1050107', '巴彦', '黑龙江-哈尔滨-巴彦', 1050107, '1050101', 1, NULL, '2018-03-30 12:00:00', 1, 212, 213);
INSERT INTO `base_region` VALUES ('1050108', '通河', '黑龙江-哈尔滨-通河', 1050108, '1050101', 1, NULL, '2018-03-30 12:00:00', 1, 214, 215);
INSERT INTO `base_region` VALUES ('1050109', '方正', '黑龙江-哈尔滨-方正', 1050109, '1050101', 1, NULL, '2018-03-30 12:00:00', 1, 216, 217);
INSERT INTO `base_region` VALUES ('1050110', '延寿', '黑龙江-哈尔滨-延寿', 1050110, '1050101', 1, NULL, '2018-03-30 12:00:00', 1, 218, 219);
INSERT INTO `base_region` VALUES ('1050111', '尚志', '黑龙江-哈尔滨-尚志', 1050111, '1050101', 1, NULL, '2018-03-30 12:00:00', 1, 220, 221);
INSERT INTO `base_region` VALUES ('1050112', '五常', '黑龙江-哈尔滨-五常', 1050112, '1050101', 1, NULL, '2018-03-30 12:00:00', 1, 222, 223);
INSERT INTO `base_region` VALUES ('1050113', '木兰', '黑龙江-哈尔滨-木兰', 1050113, '1050101', 1, NULL, '2018-03-30 12:00:00', 1, 224, 225);
INSERT INTO `base_region` VALUES ('1050114', '道里', '黑龙江-哈尔滨-道里', 1050114, '1050101', 1, NULL, '2018-03-30 12:00:00', 1, 226, 227);
INSERT INTO `base_region` VALUES ('1050115', '南岗', '黑龙江-哈尔滨-南岗', 1050115, '1050101', 1, NULL, '2018-03-30 12:00:00', 1, 228, 229);
INSERT INTO `base_region` VALUES ('1050116', '道外', '黑龙江-哈尔滨-道外', 1050116, '1050101', 1, NULL, '2018-03-30 12:00:00', 1, 230, 231);
INSERT INTO `base_region` VALUES ('1050117', '平房', '黑龙江-哈尔滨-平房', 1050117, '1050101', 1, NULL, '2018-03-30 12:00:00', 1, 232, 233);
INSERT INTO `base_region` VALUES ('1050118', '松北', '黑龙江-哈尔滨-松北', 1050118, '1050101', 1, NULL, '2018-03-30 12:00:00', 1, 234, 235);
INSERT INTO `base_region` VALUES ('1050119', '香坊', '黑龙江-哈尔滨-香坊', 1050119, '1050101', 1, NULL, '2018-03-30 12:00:00', 1, 236, 237);
INSERT INTO `base_region` VALUES ('1050201', '齐齐哈尔', '黑龙江-齐齐哈尔', 1050201, '1050000', 0, NULL, '2018-03-30 12:00:00', 1, 239, 272);
INSERT INTO `base_region` VALUES ('1050202', '讷河', '黑龙江-齐齐哈尔-讷河', 1050202, '1050201', 1, NULL, '2018-03-30 12:00:00', 1, 240, 241);
INSERT INTO `base_region` VALUES ('1050203', '龙江', '黑龙江-齐齐哈尔-龙江', 1050203, '1050201', 1, NULL, '2018-03-30 12:00:00', 1, 242, 243);
INSERT INTO `base_region` VALUES ('1050204', '甘南', '黑龙江-齐齐哈尔-甘南', 1050204, '1050201', 1, NULL, '2018-03-30 12:00:00', 1, 244, 245);
INSERT INTO `base_region` VALUES ('1050205', '富裕', '黑龙江-齐齐哈尔-富裕', 1050205, '1050201', 1, NULL, '2018-03-30 12:00:00', 1, 246, 247);
INSERT INTO `base_region` VALUES ('1050206', '依安', '黑龙江-齐齐哈尔-依安', 1050206, '1050201', 1, NULL, '2018-03-30 12:00:00', 1, 248, 249);
INSERT INTO `base_region` VALUES ('1050207', '拜泉', '黑龙江-齐齐哈尔-拜泉', 1050207, '1050201', 1, NULL, '2018-03-30 12:00:00', 1, 250, 251);
INSERT INTO `base_region` VALUES ('1050208', '克山', '黑龙江-齐齐哈尔-克山', 1050208, '1050201', 1, NULL, '2018-03-30 12:00:00', 1, 252, 253);
INSERT INTO `base_region` VALUES ('1050209', '克东', '黑龙江-齐齐哈尔-克东', 1050209, '1050201', 1, NULL, '2018-03-30 12:00:00', 1, 254, 255);
INSERT INTO `base_region` VALUES ('1050210', '泰来', '黑龙江-齐齐哈尔-泰来', 1050210, '1050201', 1, NULL, '2018-03-30 12:00:00', 1, 256, 257);
INSERT INTO `base_region` VALUES ('1050211', '龙沙', '黑龙江-齐齐哈尔-龙沙', 1050211, '1050201', 1, NULL, '2018-03-30 12:00:00', 1, 258, 259);
INSERT INTO `base_region` VALUES ('1050212', '建华', '黑龙江-齐齐哈尔-建华', 1050212, '1050201', 1, NULL, '2018-03-30 12:00:00', 1, 260, 261);
INSERT INTO `base_region` VALUES ('1050213', '铁锋', '黑龙江-齐齐哈尔-铁锋', 1050213, '1050201', 1, NULL, '2018-03-30 12:00:00', 1, 262, 263);
INSERT INTO `base_region` VALUES ('1050214', '昂昂溪', '黑龙江-齐齐哈尔-昂昂溪', 1050214, '1050201', 1, NULL, '2018-03-30 12:00:00', 1, 264, 265);
INSERT INTO `base_region` VALUES ('1050215', '富拉尔基', '黑龙江-齐齐哈尔-富拉尔基', 1050215, '1050201', 1, NULL, '2018-03-30 12:00:00', 1, 266, 267);
INSERT INTO `base_region` VALUES ('1050216', '碾子山', '黑龙江-齐齐哈尔-碾子山', 1050216, '1050201', 1, NULL, '2018-03-30 12:00:00', 1, 268, 269);
INSERT INTO `base_region` VALUES ('1050217', '梅里斯', '黑龙江-齐齐哈尔-梅里斯', 1050217, '1050201', 1, NULL, '2018-03-30 12:00:00', 1, 270, 271);
INSERT INTO `base_region` VALUES ('1050301', '牡丹江', '黑龙江-牡丹江', 1050301, '1050000', 0, NULL, '2018-03-30 12:00:00', 1, 273, 294);
INSERT INTO `base_region` VALUES ('1050302', '海林', '黑龙江-牡丹江-海林', 1050302, '1050301', 1, NULL, '2018-03-30 12:00:00', 1, 274, 275);
INSERT INTO `base_region` VALUES ('1050303', '穆棱', '黑龙江-牡丹江-穆棱', 1050303, '1050301', 1, NULL, '2018-03-30 12:00:00', 1, 276, 277);
INSERT INTO `base_region` VALUES ('1050304', '林口', '黑龙江-牡丹江-林口', 1050304, '1050301', 1, NULL, '2018-03-30 12:00:00', 1, 278, 279);
INSERT INTO `base_region` VALUES ('1050305', '绥芬河', '黑龙江-牡丹江-绥芬河', 1050305, '1050301', 1, NULL, '2018-03-30 12:00:00', 1, 280, 281);
INSERT INTO `base_region` VALUES ('1050306', '宁安', '黑龙江-牡丹江-宁安', 1050306, '1050301', 1, NULL, '2018-03-30 12:00:00', 1, 282, 283);
INSERT INTO `base_region` VALUES ('1050307', '东宁', '黑龙江-牡丹江-东宁', 1050307, '1050301', 1, NULL, '2018-03-30 12:00:00', 1, 284, 285);
INSERT INTO `base_region` VALUES ('1050308', '东安', '黑龙江-牡丹江-东安', 1050308, '1050301', 1, NULL, '2018-03-30 12:00:00', 1, 286, 287);
INSERT INTO `base_region` VALUES ('1050309', '阳明', '黑龙江-牡丹江-阳明', 1050309, '1050301', 1, NULL, '2018-03-30 12:00:00', 1, 288, 289);
INSERT INTO `base_region` VALUES ('1050310', '爱民', '黑龙江-牡丹江-爱民', 1050310, '1050301', 1, NULL, '2018-03-30 12:00:00', 1, 290, 291);
INSERT INTO `base_region` VALUES ('1050311', '西安', '黑龙江-牡丹江-西安', 1050311, '1050301', 1, NULL, '2018-03-30 12:00:00', 1, 292, 293);
INSERT INTO `base_region` VALUES ('1050401', '佳木斯', '黑龙江-佳木斯', 1050401, '1050000', 0, NULL, '2018-03-30 12:00:00', 1, 295, 316);
INSERT INTO `base_region` VALUES ('1050402', '汤原', '黑龙江-佳木斯-汤原', 1050402, '1050401', 1, NULL, '2018-03-30 12:00:00', 1, 296, 297);
INSERT INTO `base_region` VALUES ('1050403', '抚远', '黑龙江-佳木斯-抚远', 1050403, '1050401', 1, NULL, '2018-03-30 12:00:00', 1, 298, 299);
INSERT INTO `base_region` VALUES ('1050404', '桦川', '黑龙江-佳木斯-桦川', 1050404, '1050401', 1, NULL, '2018-03-30 12:00:00', 1, 300, 301);
INSERT INTO `base_region` VALUES ('1050405', '桦南', '黑龙江-佳木斯-桦南', 1050405, '1050401', 1, NULL, '2018-03-30 12:00:00', 1, 302, 303);
INSERT INTO `base_region` VALUES ('1050406', '同江', '黑龙江-佳木斯-同江', 1050406, '1050401', 1, NULL, '2018-03-30 12:00:00', 1, 304, 305);
INSERT INTO `base_region` VALUES ('1050407', '富锦', '黑龙江-佳木斯-富锦', 1050407, '1050401', 1, NULL, '2018-03-30 12:00:00', 1, 306, 307);
INSERT INTO `base_region` VALUES ('1050408', '向阳', '黑龙江-佳木斯-向阳', 1050408, '1050401', 1, NULL, '2018-03-30 12:00:00', 1, 308, 309);
INSERT INTO `base_region` VALUES ('1050409', '前进', '黑龙江-佳木斯-前进', 1050409, '1050401', 1, NULL, '2018-03-30 12:00:00', 1, 310, 311);
INSERT INTO `base_region` VALUES ('1050410', '东风', '黑龙江-佳木斯-东风', 1050410, '1050401', 1, NULL, '2018-03-30 12:00:00', 1, 312, 313);
INSERT INTO `base_region` VALUES ('1050411', '郊区', '黑龙江-佳木斯-郊区', 1050411, '1050401', 1, NULL, '2018-03-30 12:00:00', 1, 314, 315);
INSERT INTO `base_region` VALUES ('1050501', '绥化', '黑龙江-绥化', 1050501, '1050000', 0, NULL, '2018-03-30 12:00:00', 1, 317, 338);
INSERT INTO `base_region` VALUES ('1050502', '肇东', '黑龙江-绥化-肇东', 1050502, '1050501', 1, NULL, '2018-03-30 12:00:00', 1, 318, 319);
INSERT INTO `base_region` VALUES ('1050503', '安达', '黑龙江-绥化-安达', 1050503, '1050501', 1, NULL, '2018-03-30 12:00:00', 1, 320, 321);
INSERT INTO `base_region` VALUES ('1050504', '海伦', '黑龙江-绥化-海伦', 1050504, '1050501', 1, NULL, '2018-03-30 12:00:00', 1, 322, 323);
INSERT INTO `base_region` VALUES ('1050505', '明水', '黑龙江-绥化-明水', 1050505, '1050501', 1, NULL, '2018-03-30 12:00:00', 1, 324, 325);
INSERT INTO `base_region` VALUES ('1050506', '望奎', '黑龙江-绥化-望奎', 1050506, '1050501', 1, NULL, '2018-03-30 12:00:00', 1, 326, 327);
INSERT INTO `base_region` VALUES ('1050507', '兰西', '黑龙江-绥化-兰西', 1050507, '1050501', 1, NULL, '2018-03-30 12:00:00', 1, 328, 329);
INSERT INTO `base_region` VALUES ('1050508', '青冈', '黑龙江-绥化-青冈', 1050508, '1050501', 1, NULL, '2018-03-30 12:00:00', 1, 330, 331);
INSERT INTO `base_region` VALUES ('1050509', '庆安', '黑龙江-绥化-庆安', 1050509, '1050501', 1, NULL, '2018-03-30 12:00:00', 1, 332, 333);
INSERT INTO `base_region` VALUES ('1050510', '绥棱', '黑龙江-绥化-绥棱', 1050510, '1050501', 1, NULL, '2018-03-30 12:00:00', 1, 334, 335);
INSERT INTO `base_region` VALUES ('1050511', '北林', '黑龙江-绥化-北林', 1050511, '1050501', 1, NULL, '2018-03-30 12:00:00', 1, 336, 337);
INSERT INTO `base_region` VALUES ('1050601', '黑河', '黑龙江-黑河', 1050601, '1050000', 0, NULL, '2018-03-30 12:00:00', 1, 339, 352);
INSERT INTO `base_region` VALUES ('1050602', '嫩江', '黑龙江-黑河-嫩江', 1050602, '1050601', 1, NULL, '2018-03-30 12:00:00', 1, 340, 341);
INSERT INTO `base_region` VALUES ('1050603', '孙吴', '黑龙江-黑河-孙吴', 1050603, '1050601', 1, NULL, '2018-03-30 12:00:00', 1, 342, 343);
INSERT INTO `base_region` VALUES ('1050604', '逊克', '黑龙江-黑河-逊克', 1050604, '1050601', 1, NULL, '2018-03-30 12:00:00', 1, 344, 345);
INSERT INTO `base_region` VALUES ('1050605', '五大连池', '黑龙江-黑河-五大连池', 1050605, '1050601', 1, NULL, '2018-03-30 12:00:00', 1, 346, 347);
INSERT INTO `base_region` VALUES ('1050606', '北安', '黑龙江-黑河-北安', 1050606, '1050601', 1, NULL, '2018-03-30 12:00:00', 1, 348, 349);
INSERT INTO `base_region` VALUES ('1050607', '爱辉', '黑龙江-黑河-爱辉', 1050607, '1050601', 1, NULL, '2018-03-30 12:00:00', 1, 350, 351);
INSERT INTO `base_region` VALUES ('1050701', '大兴安岭', '黑龙江-大兴安岭', 1050701, '1050000', 0, NULL, '2018-03-30 12:00:00', 1, 353, 360);
INSERT INTO `base_region` VALUES ('1050702', '塔河', '黑龙江-大兴安岭-塔河', 1050702, '1050701', 1, NULL, '2018-03-30 12:00:00', 1, 354, 355);
INSERT INTO `base_region` VALUES ('1050703', '漠河', '黑龙江-大兴安岭-漠河', 1050703, '1050701', 1, NULL, '2018-03-30 12:00:00', 1, 356, 357);
INSERT INTO `base_region` VALUES ('1050704', '呼玛', '黑龙江-大兴安岭-呼玛', 1050704, '1050701', 1, NULL, '2018-03-30 12:00:00', 1, 358, 359);
INSERT INTO `base_region` VALUES ('1050801', '伊春', '黑龙江-伊春', 1050801, '1050000', 0, NULL, '2018-03-30 12:00:00', 1, 361, 394);
INSERT INTO `base_region` VALUES ('1050802', '乌伊岭', '黑龙江-伊春-乌伊岭', 1050802, '1050801', 1, NULL, '2018-03-30 12:00:00', 1, 362, 363);
INSERT INTO `base_region` VALUES ('1050803', '五营', '黑龙江-伊春-五营', 1050803, '1050801', 1, NULL, '2018-03-30 12:00:00', 1, 364, 365);
INSERT INTO `base_region` VALUES ('1050804', '铁力', '黑龙江-伊春-铁力', 1050804, '1050801', 1, NULL, '2018-03-30 12:00:00', 1, 366, 367);
INSERT INTO `base_region` VALUES ('1050805', '嘉荫', '黑龙江-伊春-嘉荫', 1050805, '1050801', 1, NULL, '2018-03-30 12:00:00', 1, 368, 369);
INSERT INTO `base_region` VALUES ('1050806', '南岔', '黑龙江-伊春-南岔', 1050806, '1050801', 1, NULL, '2018-03-30 12:00:00', 1, 370, 371);
INSERT INTO `base_region` VALUES ('1050807', '友好', '黑龙江-伊春-友好', 1050807, '1050801', 1, NULL, '2018-03-30 12:00:00', 1, 372, 373);
INSERT INTO `base_region` VALUES ('1050808', '西林', '黑龙江-伊春-西林', 1050808, '1050801', 1, NULL, '2018-03-30 12:00:00', 1, 374, 375);
INSERT INTO `base_region` VALUES ('1050809', '翠峦', '黑龙江-伊春-翠峦', 1050809, '1050801', 1, NULL, '2018-03-30 12:00:00', 1, 376, 377);
INSERT INTO `base_region` VALUES ('1050810', '新青', '黑龙江-伊春-新青', 1050810, '1050801', 1, NULL, '2018-03-30 12:00:00', 1, 378, 379);
INSERT INTO `base_region` VALUES ('1050811', '美溪', '黑龙江-伊春-美溪', 1050811, '1050801', 1, NULL, '2018-03-30 12:00:00', 1, 380, 381);
INSERT INTO `base_region` VALUES ('1050812', '金山屯', '黑龙江-伊春-金山屯', 1050812, '1050801', 1, NULL, '2018-03-30 12:00:00', 1, 382, 383);
INSERT INTO `base_region` VALUES ('1050813', '乌马河', '黑龙江-伊春-乌马河', 1050813, '1050801', 1, NULL, '2018-03-30 12:00:00', 1, 384, 385);
INSERT INTO `base_region` VALUES ('1050814', '汤旺河', '黑龙江-伊春-汤旺河', 1050814, '1050801', 1, NULL, '2018-03-30 12:00:00', 1, 386, 387);
INSERT INTO `base_region` VALUES ('1050815', '带岭', '黑龙江-伊春-带岭', 1050815, '1050801', 1, NULL, '2018-03-30 12:00:00', 1, 388, 389);
INSERT INTO `base_region` VALUES ('1050816', '红星', '黑龙江-伊春-红星', 1050816, '1050801', 1, NULL, '2018-03-30 12:00:00', 1, 390, 391);
INSERT INTO `base_region` VALUES ('1050817', '上甘岭', '黑龙江-伊春-上甘岭', 1050817, '1050801', 1, NULL, '2018-03-30 12:00:00', 1, 392, 393);
INSERT INTO `base_region` VALUES ('1050901', '大庆', '黑龙江-大庆', 1050901, '1050000', 0, NULL, '2018-03-30 12:00:00', 1, 395, 414);
INSERT INTO `base_region` VALUES ('1050902', '林甸', '黑龙江-大庆-林甸', 1050902, '1050901', 1, NULL, '2018-03-30 12:00:00', 1, 396, 397);
INSERT INTO `base_region` VALUES ('1050903', '肇州', '黑龙江-大庆-肇州', 1050903, '1050901', 1, NULL, '2018-03-30 12:00:00', 1, 398, 399);
INSERT INTO `base_region` VALUES ('1050904', '肇源', '黑龙江-大庆-肇源', 1050904, '1050901', 1, NULL, '2018-03-30 12:00:00', 1, 400, 401);
INSERT INTO `base_region` VALUES ('1050905', '杜尔伯特', '黑龙江-大庆-杜尔伯特', 1050905, '1050901', 1, NULL, '2018-03-30 12:00:00', 1, 402, 403);
INSERT INTO `base_region` VALUES ('1050906', '萨尔图', '黑龙江-大庆-萨尔图', 1050906, '1050901', 1, NULL, '2018-03-30 12:00:00', 1, 404, 405);
INSERT INTO `base_region` VALUES ('1050907', '龙凤', '黑龙江-大庆-龙凤', 1050907, '1050901', 1, NULL, '2018-03-30 12:00:00', 1, 406, 407);
INSERT INTO `base_region` VALUES ('1050908', '让胡路', '黑龙江-大庆-让胡路', 1050908, '1050901', 1, NULL, '2018-03-30 12:00:00', 1, 408, 409);
INSERT INTO `base_region` VALUES ('1050909', '红岗', '黑龙江-大庆-红岗', 1050909, '1050901', 1, NULL, '2018-03-30 12:00:00', 1, 410, 411);
INSERT INTO `base_region` VALUES ('1050910', '大同', '黑龙江-大庆-大同', 1050910, '1050901', 1, NULL, '2018-03-30 12:00:00', 1, 412, 413);
INSERT INTO `base_region` VALUES ('1051001', '新兴', '黑龙江-七台河-新兴', 1051001, '1051002', 1, NULL, '2018-03-30 12:00:00', 1, 416, 417);
INSERT INTO `base_region` VALUES ('1051002', '七台河', '黑龙江-七台河', 1051002, '1050000', 0, NULL, '2018-03-30 12:00:00', 1, 415, 424);
INSERT INTO `base_region` VALUES ('1051003', '勃利', '黑龙江-七台河-勃利', 1051003, '1051002', 1, NULL, '2018-03-30 12:00:00', 1, 418, 419);
INSERT INTO `base_region` VALUES ('1051004', '桃山', '黑龙江-七台河-桃山', 1051004, '1051002', 1, NULL, '2018-03-30 12:00:00', 1, 420, 421);
INSERT INTO `base_region` VALUES ('1051005', '茄子河', '黑龙江-七台河-茄子河', 1051005, '1051002', 1, NULL, '2018-03-30 12:00:00', 1, 422, 423);
INSERT INTO `base_region` VALUES ('1051101', '鸡西', '黑龙江-鸡西', 1051101, '1050000', 0, NULL, '2018-03-30 12:00:00', 1, 425, 444);
INSERT INTO `base_region` VALUES ('1051102', '虎林', '黑龙江-鸡西-虎林', 1051102, '1051101', 1, NULL, '2018-03-30 12:00:00', 1, 426, 427);
INSERT INTO `base_region` VALUES ('1051103', '密山', '黑龙江-鸡西-密山', 1051103, '1051101', 1, NULL, '2018-03-30 12:00:00', 1, 428, 429);
INSERT INTO `base_region` VALUES ('1051104', '鸡东', '黑龙江-鸡西-鸡东', 1051104, '1051101', 1, NULL, '2018-03-30 12:00:00', 1, 430, 431);
INSERT INTO `base_region` VALUES ('1051105', '鸡冠', '黑龙江-鸡西-鸡冠', 1051105, '1051101', 1, NULL, '2018-03-30 12:00:00', 1, 432, 433);
INSERT INTO `base_region` VALUES ('1051106', '恒山', '黑龙江-鸡西-恒山', 1051106, '1051101', 1, NULL, '2018-03-30 12:00:00', 1, 434, 435);
INSERT INTO `base_region` VALUES ('1051107', '滴道', '黑龙江-鸡西-滴道', 1051107, '1051101', 1, NULL, '2018-03-30 12:00:00', 1, 436, 437);
INSERT INTO `base_region` VALUES ('1051108', '梨树', '黑龙江-鸡西-梨树', 1051108, '1051101', 1, NULL, '2018-03-30 12:00:00', 1, 438, 439);
INSERT INTO `base_region` VALUES ('1051109', '城子河', '黑龙江-鸡西-城子河', 1051109, '1051101', 1, NULL, '2018-03-30 12:00:00', 1, 440, 441);
INSERT INTO `base_region` VALUES ('1051110', '麻山', '黑龙江-鸡西-麻山', 1051110, '1051101', 1, NULL, '2018-03-30 12:00:00', 1, 442, 443);
INSERT INTO `base_region` VALUES ('1051201', '鹤岗', '黑龙江-鹤岗', 1051201, '1050000', 0, NULL, '2018-03-30 12:00:00', 1, 445, 462);
INSERT INTO `base_region` VALUES ('1051202', '绥滨', '黑龙江-鹤岗-绥滨', 1051202, '1051201', 1, NULL, '2018-03-30 12:00:00', 1, 446, 447);
INSERT INTO `base_region` VALUES ('1051203', '萝北', '黑龙江-鹤岗-萝北', 1051203, '1051201', 1, NULL, '2018-03-30 12:00:00', 1, 448, 449);
INSERT INTO `base_region` VALUES ('1051204', '向阳', '黑龙江-鹤岗-向阳', 1051204, '1051201', 1, NULL, '2018-03-30 12:00:00', 1, 450, 451);
INSERT INTO `base_region` VALUES ('1051205', '工农', '黑龙江-鹤岗-工农', 1051205, '1051201', 1, NULL, '2018-03-30 12:00:00', 1, 452, 453);
INSERT INTO `base_region` VALUES ('1051206', '南山', '黑龙江-鹤岗-南山', 1051206, '1051201', 1, NULL, '2018-03-30 12:00:00', 1, 454, 455);
INSERT INTO `base_region` VALUES ('1051207', '兴安', '黑龙江-鹤岗-兴安', 1051207, '1051201', 1, NULL, '2018-03-30 12:00:00', 1, 456, 457);
INSERT INTO `base_region` VALUES ('1051208', '东山', '黑龙江-鹤岗-东山', 1051208, '1051201', 1, NULL, '2018-03-30 12:00:00', 1, 458, 459);
INSERT INTO `base_region` VALUES ('1051209', '兴山', '黑龙江-鹤岗-兴山', 1051209, '1051201', 1, NULL, '2018-03-30 12:00:00', 1, 460, 461);
INSERT INTO `base_region` VALUES ('1051301', '双鸭山', '黑龙江-双鸭山', 1051301, '1050000', 0, NULL, '2018-03-30 12:00:00', 1, 463, 480);
INSERT INTO `base_region` VALUES ('1051302', '集贤', '黑龙江-双鸭山-集贤', 1051302, '1051301', 1, NULL, '2018-03-30 12:00:00', 1, 464, 465);
INSERT INTO `base_region` VALUES ('1051303', '宝清', '黑龙江-双鸭山-宝清', 1051303, '1051301', 1, NULL, '2018-03-30 12:00:00', 1, 466, 467);
INSERT INTO `base_region` VALUES ('1051304', '饶河', '黑龙江-双鸭山-饶河', 1051304, '1051301', 1, NULL, '2018-03-30 12:00:00', 1, 468, 469);
INSERT INTO `base_region` VALUES ('1051305', '友谊', '黑龙江-双鸭山-友谊', 1051305, '1051301', 1, NULL, '2018-03-30 12:00:00', 1, 470, 471);
INSERT INTO `base_region` VALUES ('1051306', '尖山', '黑龙江-双鸭山-尖山', 1051306, '1051301', 1, NULL, '2018-03-30 12:00:00', 1, 472, 473);
INSERT INTO `base_region` VALUES ('1051307', '岭东', '黑龙江-双鸭山-岭东', 1051307, '1051301', 1, NULL, '2018-03-30 12:00:00', 1, 474, 475);
INSERT INTO `base_region` VALUES ('1051308', '四方台', '黑龙江-双鸭山-四方台', 1051308, '1051301', 1, NULL, '2018-03-30 12:00:00', 1, 476, 477);
INSERT INTO `base_region` VALUES ('1051309', '宝山', '黑龙江-双鸭山-宝山', 1051309, '1051301', 1, NULL, '2018-03-30 12:00:00', 1, 478, 479);
INSERT INTO `base_region` VALUES ('1060000', '吉林', '吉林', 1060000, 'ROOT', 0, NULL, '2018-03-30 12:00:00', 1, 482, 621);
INSERT INTO `base_region` VALUES ('1060101', '长春', '吉林-长春', 1060101, '1060000', 0, NULL, '2018-03-30 12:00:00', 1, 483, 504);
INSERT INTO `base_region` VALUES ('1060102', '农安', '吉林-长春-农安', 1060102, '1060101', 1, NULL, '2018-03-30 12:00:00', 1, 484, 485);
INSERT INTO `base_region` VALUES ('1060103', '德惠', '吉林-长春-德惠', 1060103, '1060101', 1, NULL, '2018-03-30 12:00:00', 1, 486, 487);
INSERT INTO `base_region` VALUES ('1060104', '九台', '吉林-长春-九台', 1060104, '1060101', 1, NULL, '2018-03-30 12:00:00', 1, 488, 489);
INSERT INTO `base_region` VALUES ('1060105', '榆树', '吉林-长春-榆树', 1060105, '1060101', 1, NULL, '2018-03-30 12:00:00', 1, 490, 491);
INSERT INTO `base_region` VALUES ('1060106', '双阳', '吉林-长春-双阳', 1060106, '1060101', 1, NULL, '2018-03-30 12:00:00', 1, 492, 493);
INSERT INTO `base_region` VALUES ('1060107', '二道', '吉林-长春-二道', 1060107, '1060101', 1, NULL, '2018-03-30 12:00:00', 1, 494, 495);
INSERT INTO `base_region` VALUES ('1060108', '南关', '吉林-长春-南关', 1060108, '1060101', 1, NULL, '2018-03-30 12:00:00', 1, 496, 497);
INSERT INTO `base_region` VALUES ('1060109', '宽城', '吉林-长春-宽城', 1060109, '1060101', 1, NULL, '2018-03-30 12:00:00', 1, 498, 499);
INSERT INTO `base_region` VALUES ('1060110', '朝阳', '吉林-长春-朝阳', 1060110, '1060101', 1, NULL, '2018-03-30 12:00:00', 1, 500, 501);
INSERT INTO `base_region` VALUES ('1060111', '绿园', '吉林-长春-绿园', 1060111, '1060101', 1, NULL, '2018-03-30 12:00:00', 1, 502, 503);
INSERT INTO `base_region` VALUES ('1060201', '吉林', '吉林-吉林', 1060201, '1060000', 0, NULL, '2018-03-30 12:00:00', 1, 505, 524);
INSERT INTO `base_region` VALUES ('1060202', '舒兰', '吉林-吉林-舒兰', 1060202, '1060201', 1, NULL, '2018-03-30 12:00:00', 1, 506, 507);
INSERT INTO `base_region` VALUES ('1060203', '永吉', '吉林-吉林-永吉', 1060203, '1060201', 1, NULL, '2018-03-30 12:00:00', 1, 508, 509);
INSERT INTO `base_region` VALUES ('1060204', '蛟河', '吉林-吉林-蛟河', 1060204, '1060201', 1, NULL, '2018-03-30 12:00:00', 1, 510, 511);
INSERT INTO `base_region` VALUES ('1060205', '磐石', '吉林-吉林-磐石', 1060205, '1060201', 1, NULL, '2018-03-30 12:00:00', 1, 512, 513);
INSERT INTO `base_region` VALUES ('1060206', '桦甸', '吉林-吉林-桦甸', 1060206, '1060201', 1, NULL, '2018-03-30 12:00:00', 1, 514, 515);
INSERT INTO `base_region` VALUES ('1060207', '昌邑', '吉林-吉林-昌邑', 1060207, '1060201', 1, NULL, '2018-03-30 12:00:00', 1, 516, 517);
INSERT INTO `base_region` VALUES ('1060208', '龙潭', '吉林-吉林-龙潭', 1060208, '1060201', 1, NULL, '2018-03-30 12:00:00', 1, 518, 519);
INSERT INTO `base_region` VALUES ('1060209', '船营', '吉林-吉林-船营', 1060209, '1060201', 1, NULL, '2018-03-30 12:00:00', 1, 520, 521);
INSERT INTO `base_region` VALUES ('1060210', '丰满', '吉林-吉林-丰满', 1060210, '1060201', 1, NULL, '2018-03-30 12:00:00', 1, 522, 523);
INSERT INTO `base_region` VALUES ('1060301', '延吉', '吉林-延边-延吉', 1060301, '1060306', 1, NULL, '2018-03-30 12:00:00', 1, 526, 527);
INSERT INTO `base_region` VALUES ('1060302', '敦化', '吉林-延边-敦化', 1060302, '1060306', 1, NULL, '2018-03-30 12:00:00', 1, 528, 529);
INSERT INTO `base_region` VALUES ('1060303', '安图', '吉林-延边-安图', 1060303, '1060306', 1, NULL, '2018-03-30 12:00:00', 1, 530, 531);
INSERT INTO `base_region` VALUES ('1060304', '汪清', '吉林-延边-汪清', 1060304, '1060306', 1, NULL, '2018-03-30 12:00:00', 1, 532, 533);
INSERT INTO `base_region` VALUES ('1060305', '和龙', '吉林-延边-和龙', 1060305, '1060306', 1, NULL, '2018-03-30 12:00:00', 1, 534, 535);
INSERT INTO `base_region` VALUES ('1060306', '延边', '吉林-延边', 1060306, '1060000', 0, NULL, '2018-03-30 12:00:00', 1, 525, 542);
INSERT INTO `base_region` VALUES ('1060307', '龙井', '吉林-延边-龙井', 1060307, '1060306', 1, NULL, '2018-03-30 12:00:00', 1, 536, 537);
INSERT INTO `base_region` VALUES ('1060308', '珲春', '吉林-延边-珲春', 1060308, '1060306', 1, NULL, '2018-03-30 12:00:00', 1, 538, 539);
INSERT INTO `base_region` VALUES ('1060309', '图们', '吉林-延边-图们', 1060309, '1060306', 1, NULL, '2018-03-30 12:00:00', 1, 540, 541);
INSERT INTO `base_region` VALUES ('1060401', '四平', '吉林-四平', 1060401, '1060000', 0, NULL, '2018-03-30 12:00:00', 1, 543, 556);
INSERT INTO `base_region` VALUES ('1060402', '双辽', '吉林-四平-双辽', 1060402, '1060401', 1, NULL, '2018-03-30 12:00:00', 1, 544, 545);
INSERT INTO `base_region` VALUES ('1060403', '梨树', '吉林-四平-梨树', 1060403, '1060401', 1, NULL, '2018-03-30 12:00:00', 1, 546, 547);
INSERT INTO `base_region` VALUES ('1060404', '公主岭', '吉林-四平-公主岭', 1060404, '1060401', 1, NULL, '2018-03-30 12:00:00', 1, 548, 549);
INSERT INTO `base_region` VALUES ('1060405', '伊通', '吉林-四平-伊通', 1060405, '1060401', 1, NULL, '2018-03-30 12:00:00', 1, 550, 551);
INSERT INTO `base_region` VALUES ('1060406', '铁西', '吉林-四平-铁西', 1060406, '1060401', 1, NULL, '2018-03-30 12:00:00', 1, 552, 553);
INSERT INTO `base_region` VALUES ('1060407', '铁东', '吉林-四平-铁东', 1060407, '1060401', 1, NULL, '2018-03-30 12:00:00', 1, 554, 555);
INSERT INTO `base_region` VALUES ('1060501', '通化', '吉林-通化', 1060501, '1060000', 0, NULL, '2018-03-30 12:00:00', 1, 557, 572);
INSERT INTO `base_region` VALUES ('1060502', '梅河口', '吉林-通化-梅河口', 1060502, '1060501', 1, NULL, '2018-03-30 12:00:00', 1, 558, 559);
INSERT INTO `base_region` VALUES ('1060503', '柳河', '吉林-通化-柳河', 1060503, '1060501', 1, NULL, '2018-03-30 12:00:00', 1, 560, 561);
INSERT INTO `base_region` VALUES ('1060504', '辉南', '吉林-通化-辉南', 1060504, '1060501', 1, NULL, '2018-03-30 12:00:00', 1, 562, 563);
INSERT INTO `base_region` VALUES ('1060505', '集安', '吉林-通化-集安', 1060505, '1060501', 1, NULL, '2018-03-30 12:00:00', 1, 564, 565);
INSERT INTO `base_region` VALUES ('1060506', '通化县', '吉林-通化-通化县', 1060506, '1060501', 1, NULL, '2018-03-30 12:00:00', 1, 566, 567);
INSERT INTO `base_region` VALUES ('1060507', '东昌', '吉林-通化-东昌', 1060507, '1060501', 1, NULL, '2018-03-30 12:00:00', 1, 568, 569);
INSERT INTO `base_region` VALUES ('1060508', '二道江', '吉林-通化-二道江', 1060508, '1060501', 1, NULL, '2018-03-30 12:00:00', 1, 570, 571);
INSERT INTO `base_region` VALUES ('1060601', '白城', '吉林-白城', 1060601, '1060000', 0, NULL, '2018-03-30 12:00:00', 1, 573, 584);
INSERT INTO `base_region` VALUES ('1060602', '洮南', '吉林-白城-洮南', 1060602, '1060601', 1, NULL, '2018-03-30 12:00:00', 1, 574, 575);
INSERT INTO `base_region` VALUES ('1060603', '大安', '吉林-白城-大安', 1060603, '1060601', 1, NULL, '2018-03-30 12:00:00', 1, 576, 577);
INSERT INTO `base_region` VALUES ('1060604', '镇赉', '吉林-白城-镇赉', 1060604, '1060601', 1, NULL, '2018-03-30 12:00:00', 1, 578, 579);
INSERT INTO `base_region` VALUES ('1060605', '通榆', '吉林-白城-通榆', 1060605, '1060601', 1, NULL, '2018-03-30 12:00:00', 1, 580, 581);
INSERT INTO `base_region` VALUES ('1060606', '洮北', '吉林-白城-洮北', 1060606, '1060601', 1, NULL, '2018-03-30 12:00:00', 1, 582, 583);
INSERT INTO `base_region` VALUES ('1060701', '辽源', '吉林-辽源', 1060701, '1060000', 0, NULL, '2018-03-30 12:00:00', 1, 585, 594);
INSERT INTO `base_region` VALUES ('1060702', '东丰', '吉林-辽源-东丰', 1060702, '1060701', 1, NULL, '2018-03-30 12:00:00', 1, 586, 587);
INSERT INTO `base_region` VALUES ('1060703', '东辽', '吉林-辽源-东辽', 1060703, '1060701', 1, NULL, '2018-03-30 12:00:00', 1, 588, 589);
INSERT INTO `base_region` VALUES ('1060704', '龙山', '吉林-辽源-龙山', 1060704, '1060701', 1, NULL, '2018-03-30 12:00:00', 1, 590, 591);
INSERT INTO `base_region` VALUES ('1060705', '西安', '吉林-辽源-西安', 1060705, '1060701', 1, NULL, '2018-03-30 12:00:00', 1, 592, 593);
INSERT INTO `base_region` VALUES ('1060801', '松原', '吉林-松原', 1060801, '1060000', 0, NULL, '2018-03-30 12:00:00', 1, 595, 606);
INSERT INTO `base_region` VALUES ('1060802', '乾安', '吉林-松原-乾安', 1060802, '1060801', 1, NULL, '2018-03-30 12:00:00', 1, 596, 597);
INSERT INTO `base_region` VALUES ('1060803', '前郭', '吉林-松原-前郭', 1060803, '1060801', 1, NULL, '2018-03-30 12:00:00', 1, 598, 599);
INSERT INTO `base_region` VALUES ('1060804', '长岭', '吉林-松原-长岭', 1060804, '1060801', 1, NULL, '2018-03-30 12:00:00', 1, 600, 601);
INSERT INTO `base_region` VALUES ('1060805', '扶余', '吉林-松原-扶余', 1060805, '1060801', 1, NULL, '2018-03-30 12:00:00', 1, 602, 603);
INSERT INTO `base_region` VALUES ('1060806', '宁江', '吉林-松原-宁江', 1060806, '1060801', 1, NULL, '2018-03-30 12:00:00', 1, 604, 605);
INSERT INTO `base_region` VALUES ('1060901', '白山', '吉林-白山', 1060901, '1060000', 0, NULL, '2018-03-30 12:00:00', 1, 607, 620);
INSERT INTO `base_region` VALUES ('1060902', '靖宇', '吉林-白山-靖宇', 1060902, '1060901', 1, NULL, '2018-03-30 12:00:00', 1, 608, 609);
INSERT INTO `base_region` VALUES ('1060903', '临江', '吉林-白山-临江', 1060903, '1060901', 1, NULL, '2018-03-30 12:00:00', 1, 610, 611);
INSERT INTO `base_region` VALUES ('1060905', '长白', '吉林-白山-长白', 1060905, '1060901', 1, NULL, '2018-03-30 12:00:00', 1, 612, 613);
INSERT INTO `base_region` VALUES ('1060906', '抚松', '吉林-白山-抚松', 1060906, '1060901', 1, NULL, '2018-03-30 12:00:00', 1, 614, 615);
INSERT INTO `base_region` VALUES ('1060907', '江源', '吉林-白山-江源', 1060907, '1060901', 1, NULL, '2018-03-30 12:00:00', 1, 616, 617);
INSERT INTO `base_region` VALUES ('1060908', '浑江', '吉林-白山-浑江', 1060908, '1060901', 1, NULL, '2018-03-30 12:00:00', 1, 618, 619);
INSERT INTO `base_region` VALUES ('1070000', '辽宁', '辽宁', 1070000, 'ROOT', 0, NULL, '2018-03-30 12:00:00', 1, 622, 845);
INSERT INTO `base_region` VALUES ('1070101', '沈阳', '辽宁-沈阳', 1070101, '1070000', 0, NULL, '2018-03-30 12:00:00', 1, 623, 652);
INSERT INTO `base_region` VALUES ('1070102', '浑南', '辽宁-沈阳-浑南', 1070102, '1070101', 1, NULL, '2018-03-30 12:00:00', 1, 624, 625);
INSERT INTO `base_region` VALUES ('1070103', '辽中', '辽宁-沈阳-辽中', 1070103, '1070101', 1, NULL, '2018-03-30 12:00:00', 1, 626, 627);
INSERT INTO `base_region` VALUES ('1070104', '康平', '辽宁-沈阳-康平', 1070104, '1070101', 1, NULL, '2018-03-30 12:00:00', 1, 628, 629);
INSERT INTO `base_region` VALUES ('1070105', '法库', '辽宁-沈阳-法库', 1070105, '1070101', 1, NULL, '2018-03-30 12:00:00', 1, 630, 631);
INSERT INTO `base_region` VALUES ('1070106', '新民', '辽宁-沈阳-新民', 1070106, '1070101', 1, NULL, '2018-03-30 12:00:00', 1, 632, 633);
INSERT INTO `base_region` VALUES ('1070107', '和平', '辽宁-沈阳-和平', 1070107, '1070101', 1, NULL, '2018-03-30 12:00:00', 1, 634, 635);
INSERT INTO `base_region` VALUES ('1070108', '沈河', '辽宁-沈阳-沈河', 1070108, '1070101', 1, NULL, '2018-03-30 12:00:00', 1, 636, 637);
INSERT INTO `base_region` VALUES ('1070109', '大东', '辽宁-沈阳-大东', 1070109, '1070101', 1, NULL, '2018-03-30 12:00:00', 1, 638, 639);
INSERT INTO `base_region` VALUES ('1070110', '皇姑', '辽宁-沈阳-皇姑', 1070110, '1070101', 1, NULL, '2018-03-30 12:00:00', 1, 640, 641);
INSERT INTO `base_region` VALUES ('1070111', '铁西', '辽宁-沈阳-铁西', 1070111, '1070101', 1, NULL, '2018-03-30 12:00:00', 1, 642, 643);
INSERT INTO `base_region` VALUES ('1070112', '苏家屯', '辽宁-沈阳-苏家屯', 1070112, '1070101', 1, NULL, '2018-03-30 12:00:00', 1, 644, 645);
INSERT INTO `base_region` VALUES ('1070113', '沈北新区', '辽宁-沈阳-沈北新区', 1070113, '1070101', 1, NULL, '2018-03-30 12:00:00', 1, 646, 647);
INSERT INTO `base_region` VALUES ('1070114', '于洪', '辽宁-沈阳-于洪', 1070114, '1070101', 1, NULL, '2018-03-30 12:00:00', 1, 648, 649);
INSERT INTO `base_region` VALUES ('1070115', '东陵', '辽宁-沈阳-东陵', 1070115, '1070101', 1, NULL, '2018-03-30 12:00:00', 1, 650, 651);
INSERT INTO `base_region` VALUES ('1070201', '大连', '辽宁-大连', 1070201, '1070000', 0, NULL, '2018-03-30 12:00:00', 1, 653, 674);
INSERT INTO `base_region` VALUES ('1070202', '瓦房店', '辽宁-大连-瓦房店', 1070202, '1070201', 1, NULL, '2018-03-30 12:00:00', 1, 654, 655);
INSERT INTO `base_region` VALUES ('1070203', '金州', '辽宁-大连-金州', 1070203, '1070201', 1, NULL, '2018-03-30 12:00:00', 1, 656, 657);
INSERT INTO `base_region` VALUES ('1070204', '普兰店', '辽宁-大连-普兰店', 1070204, '1070201', 1, NULL, '2018-03-30 12:00:00', 1, 658, 659);
INSERT INTO `base_region` VALUES ('1070205', '旅顺', '辽宁-大连-旅顺', 1070205, '1070201', 1, NULL, '2018-03-30 12:00:00', 1, 660, 661);
INSERT INTO `base_region` VALUES ('1070206', '长海', '辽宁-大连-长海', 1070206, '1070201', 1, NULL, '2018-03-30 12:00:00', 1, 662, 663);
INSERT INTO `base_region` VALUES ('1070207', '庄河', '辽宁-大连-庄河', 1070207, '1070201', 1, NULL, '2018-03-30 12:00:00', 1, 664, 665);
INSERT INTO `base_region` VALUES ('1070208', '中山', '辽宁-大连-中山', 1070208, '1070201', 1, NULL, '2018-03-30 12:00:00', 1, 666, 667);
INSERT INTO `base_region` VALUES ('1070209', '西岗', '辽宁-大连-西岗', 1070209, '1070201', 1, NULL, '2018-03-30 12:00:00', 1, 668, 669);
INSERT INTO `base_region` VALUES ('1070210', '沙河口', '辽宁-大连-沙河口', 1070210, '1070201', 1, NULL, '2018-03-30 12:00:00', 1, 670, 671);
INSERT INTO `base_region` VALUES ('1070211', '甘井子', '辽宁-大连-甘井子', 1070211, '1070201', 1, NULL, '2018-03-30 12:00:00', 1, 672, 673);
INSERT INTO `base_region` VALUES ('1070301', '鞍山', '辽宁-鞍山', 1070301, '1070000', 0, NULL, '2018-03-30 12:00:00', 1, 675, 690);
INSERT INTO `base_region` VALUES ('1070302', '台安', '辽宁-鞍山-台安', 1070302, '1070301', 1, NULL, '2018-03-30 12:00:00', 1, 676, 677);
INSERT INTO `base_region` VALUES ('1070303', '岫岩', '辽宁-鞍山-岫岩', 1070303, '1070301', 1, NULL, '2018-03-30 12:00:00', 1, 678, 679);
INSERT INTO `base_region` VALUES ('1070304', '海城', '辽宁-鞍山-海城', 1070304, '1070301', 1, NULL, '2018-03-30 12:00:00', 1, 680, 681);
INSERT INTO `base_region` VALUES ('1070305', '铁东', '辽宁-鞍山-铁东', 1070305, '1070301', 1, NULL, '2018-03-30 12:00:00', 1, 682, 683);
INSERT INTO `base_region` VALUES ('1070306', '铁西', '辽宁-鞍山-铁西', 1070306, '1070301', 1, NULL, '2018-03-30 12:00:00', 1, 684, 685);
INSERT INTO `base_region` VALUES ('1070307', '立山', '辽宁-鞍山-立山', 1070307, '1070301', 1, NULL, '2018-03-30 12:00:00', 1, 686, 687);
INSERT INTO `base_region` VALUES ('1070308', '千山', '辽宁-鞍山-千山', 1070308, '1070301', 1, NULL, '2018-03-30 12:00:00', 1, 688, 689);
INSERT INTO `base_region` VALUES ('1070401', '抚顺', '辽宁-抚顺', 1070401, '1070000', 0, NULL, '2018-03-30 12:00:00', 1, 691, 704);
INSERT INTO `base_region` VALUES ('1070402', '新宾', '辽宁-抚顺-新宾', 1070402, '1070401', 1, NULL, '2018-03-30 12:00:00', 1, 692, 693);
INSERT INTO `base_region` VALUES ('1070403', '清原', '辽宁-抚顺-清原', 1070403, '1070401', 1, NULL, '2018-03-30 12:00:00', 1, 694, 695);
INSERT INTO `base_region` VALUES ('1070405', '新抚', '辽宁-抚顺-新抚', 1070405, '1070401', 1, NULL, '2018-03-30 12:00:00', 1, 696, 697);
INSERT INTO `base_region` VALUES ('1070406', '东洲', '辽宁-抚顺-东洲', 1070406, '1070401', 1, NULL, '2018-03-30 12:00:00', 1, 698, 699);
INSERT INTO `base_region` VALUES ('1070407', '望花', '辽宁-抚顺-望花', 1070407, '1070401', 1, NULL, '2018-03-30 12:00:00', 1, 700, 701);
INSERT INTO `base_region` VALUES ('1070408', '顺城', '辽宁-抚顺-顺城', 1070408, '1070401', 1, NULL, '2018-03-30 12:00:00', 1, 702, 703);
INSERT INTO `base_region` VALUES ('1070501', '本溪', '辽宁-本溪', 1070501, '1070000', 0, NULL, '2018-03-30 12:00:00', 1, 705, 718);
INSERT INTO `base_region` VALUES ('1070502', '本溪县', '辽宁-本溪-本溪县', 1070502, '1070501', 1, NULL, '2018-03-30 12:00:00', 1, 706, 707);
INSERT INTO `base_region` VALUES ('1070503', '平山', '辽宁-本溪-平山', 1070503, '1070501', 1, NULL, '2018-03-30 12:00:00', 1, 708, 709);
INSERT INTO `base_region` VALUES ('1070504', '桓仁', '辽宁-本溪-桓仁', 1070504, '1070501', 1, NULL, '2018-03-30 12:00:00', 1, 710, 711);
INSERT INTO `base_region` VALUES ('1070505', '溪湖', '辽宁-本溪-溪湖', 1070505, '1070501', 1, NULL, '2018-03-30 12:00:00', 1, 712, 713);
INSERT INTO `base_region` VALUES ('1070506', '明山', '辽宁-本溪-明山', 1070506, '1070501', 1, NULL, '2018-03-30 12:00:00', 1, 714, 715);
INSERT INTO `base_region` VALUES ('1070507', '南芬', '辽宁-本溪-南芬', 1070507, '1070501', 1, NULL, '2018-03-30 12:00:00', 1, 716, 717);
INSERT INTO `base_region` VALUES ('1070601', '丹东', '辽宁-丹东', 1070601, '1070000', 0, NULL, '2018-03-30 12:00:00', 1, 719, 732);
INSERT INTO `base_region` VALUES ('1070602', '凤城', '辽宁-丹东-凤城', 1070602, '1070601', 1, NULL, '2018-03-30 12:00:00', 1, 720, 721);
INSERT INTO `base_region` VALUES ('1070603', '宽甸', '辽宁-丹东-宽甸', 1070603, '1070601', 1, NULL, '2018-03-30 12:00:00', 1, 722, 723);
INSERT INTO `base_region` VALUES ('1070604', '东港', '辽宁-丹东-东港', 1070604, '1070601', 1, NULL, '2018-03-30 12:00:00', 1, 724, 725);
INSERT INTO `base_region` VALUES ('1070605', '元宝', '辽宁-丹东-元宝', 1070605, '1070601', 1, NULL, '2018-03-30 12:00:00', 1, 726, 727);
INSERT INTO `base_region` VALUES ('1070606', '振兴', '辽宁-丹东-振兴', 1070606, '1070601', 1, NULL, '2018-03-30 12:00:00', 1, 728, 729);
INSERT INTO `base_region` VALUES ('1070607', '振安', '辽宁-丹东-振安', 1070607, '1070601', 1, NULL, '2018-03-30 12:00:00', 1, 730, 731);
INSERT INTO `base_region` VALUES ('1070701', '锦州', '辽宁-锦州', 1070701, '1070000', 0, NULL, '2018-03-30 12:00:00', 1, 733, 748);
INSERT INTO `base_region` VALUES ('1070702', '凌海', '辽宁-锦州-凌海', 1070702, '1070701', 1, NULL, '2018-03-30 12:00:00', 1, 734, 735);
INSERT INTO `base_region` VALUES ('1070703', '古塔', '辽宁-锦州-古塔', 1070703, '1070701', 1, NULL, '2018-03-30 12:00:00', 1, 736, 737);
INSERT INTO `base_region` VALUES ('1070704', '义县', '辽宁-锦州-义县', 1070704, '1070701', 1, NULL, '2018-03-30 12:00:00', 1, 738, 739);
INSERT INTO `base_region` VALUES ('1070705', '黑山', '辽宁-锦州-黑山', 1070705, '1070701', 1, NULL, '2018-03-30 12:00:00', 1, 740, 741);
INSERT INTO `base_region` VALUES ('1070706', '北镇', '辽宁-锦州-北镇', 1070706, '1070701', 1, NULL, '2018-03-30 12:00:00', 1, 742, 743);
INSERT INTO `base_region` VALUES ('1070707', '凌河', '辽宁-锦州-凌河', 1070707, '1070701', 1, NULL, '2018-03-30 12:00:00', 1, 744, 745);
INSERT INTO `base_region` VALUES ('1070708', '太和', '辽宁-锦州-太和', 1070708, '1070701', 1, NULL, '2018-03-30 12:00:00', 1, 746, 747);
INSERT INTO `base_region` VALUES ('1070801', '营口', '辽宁-营口', 1070801, '1070000', 0, NULL, '2018-03-30 12:00:00', 1, 749, 762);
INSERT INTO `base_region` VALUES ('1070802', '大石桥', '辽宁-营口-大石桥', 1070802, '1070801', 1, NULL, '2018-03-30 12:00:00', 1, 750, 751);
INSERT INTO `base_region` VALUES ('1070803', '盖州', '辽宁-营口-盖州', 1070803, '1070801', 1, NULL, '2018-03-30 12:00:00', 1, 752, 753);
INSERT INTO `base_region` VALUES ('1070804', '站前', '辽宁-营口-站前', 1070804, '1070801', 1, NULL, '2018-03-30 12:00:00', 1, 754, 755);
INSERT INTO `base_region` VALUES ('1070805', '西市', '辽宁-营口-西市', 1070805, '1070801', 1, NULL, '2018-03-30 12:00:00', 1, 756, 757);
INSERT INTO `base_region` VALUES ('1070806', '鲅鱼圈', '辽宁-营口-鲅鱼圈', 1070806, '1070801', 1, NULL, '2018-03-30 12:00:00', 1, 758, 759);
INSERT INTO `base_region` VALUES ('1070807', '老边', '辽宁-营口-老边', 1070807, '1070801', 1, NULL, '2018-03-30 12:00:00', 1, 760, 761);
INSERT INTO `base_region` VALUES ('1070901', '阜新', '辽宁-阜新', 1070901, '1070000', 0, NULL, '2018-03-30 12:00:00', 1, 763, 776);
INSERT INTO `base_region` VALUES ('1070902', '彰武', '辽宁-阜新-彰武', 1070902, '1070901', 1, NULL, '2018-03-30 12:00:00', 1, 764, 765);
INSERT INTO `base_region` VALUES ('1070903', '海州', '辽宁-阜新-海州', 1070903, '1070901', 1, NULL, '2018-03-30 12:00:00', 1, 766, 767);
INSERT INTO `base_region` VALUES ('1070904', '新邱', '辽宁-阜新-新邱', 1070904, '1070901', 1, NULL, '2018-03-30 12:00:00', 1, 768, 769);
INSERT INTO `base_region` VALUES ('1070905', '太平', '辽宁-阜新-太平', 1070905, '1070901', 1, NULL, '2018-03-30 12:00:00', 1, 770, 771);
INSERT INTO `base_region` VALUES ('1070906', '清河门', '辽宁-阜新-清河门', 1070906, '1070901', 1, NULL, '2018-03-30 12:00:00', 1, 772, 773);
INSERT INTO `base_region` VALUES ('1070907', '细河', '辽宁-阜新-细河', 1070907, '1070901', 1, NULL, '2018-03-30 12:00:00', 1, 774, 775);
INSERT INTO `base_region` VALUES ('1071001', '辽阳', '辽宁-辽阳', 1071001, '1070000', 0, NULL, '2018-03-30 12:00:00', 1, 777, 792);
INSERT INTO `base_region` VALUES ('1071002', '辽阳县', '辽宁-辽阳-辽阳县', 1071002, '1071001', 1, NULL, '2018-03-30 12:00:00', 1, 778, 779);
INSERT INTO `base_region` VALUES ('1071003', '灯塔', '辽宁-辽阳-灯塔', 1071003, '1071001', 1, NULL, '2018-03-30 12:00:00', 1, 780, 781);
INSERT INTO `base_region` VALUES ('1071004', '弓长岭', '辽宁-辽阳-弓长岭', 1071004, '1071001', 1, NULL, '2018-03-30 12:00:00', 1, 782, 783);
INSERT INTO `base_region` VALUES ('1071005', '白塔', '辽宁-辽阳-白塔', 1071005, '1071001', 1, NULL, '2018-03-30 12:00:00', 1, 784, 785);
INSERT INTO `base_region` VALUES ('1071006', '文圣', '辽宁-辽阳-文圣', 1071006, '1071001', 1, NULL, '2018-03-30 12:00:00', 1, 786, 787);
INSERT INTO `base_region` VALUES ('1071007', '宏伟', '辽宁-辽阳-宏伟', 1071007, '1071001', 1, NULL, '2018-03-30 12:00:00', 1, 788, 789);
INSERT INTO `base_region` VALUES ('1071008', '太子河', '辽宁-辽阳-太子河', 1071008, '1071001', 1, NULL, '2018-03-30 12:00:00', 1, 790, 791);
INSERT INTO `base_region` VALUES ('1071101', '铁岭', '辽宁-铁岭', 1071101, '1070000', 0, NULL, '2018-03-30 12:00:00', 1, 793, 806);
INSERT INTO `base_region` VALUES ('1071102', '开原', '辽宁-铁岭-开原', 1071102, '1071101', 1, NULL, '2018-03-30 12:00:00', 1, 794, 795);
INSERT INTO `base_region` VALUES ('1071103', '昌图', '辽宁-铁岭-昌图', 1071103, '1071101', 1, NULL, '2018-03-30 12:00:00', 1, 796, 797);
INSERT INTO `base_region` VALUES ('1071104', '西丰', '辽宁-铁岭-西丰', 1071104, '1071101', 1, NULL, '2018-03-30 12:00:00', 1, 798, 799);
INSERT INTO `base_region` VALUES ('1071105', '调兵山', '辽宁-铁岭-调兵山', 1071105, '1071101', 1, NULL, '2018-03-30 12:00:00', 1, 800, 801);
INSERT INTO `base_region` VALUES ('1071106', '银州', '辽宁-铁岭-银州', 1071106, '1071101', 1, NULL, '2018-03-30 12:00:00', 1, 802, 803);
INSERT INTO `base_region` VALUES ('1071107', '清河', '辽宁-铁岭-清河', 1071107, '1071101', 1, NULL, '2018-03-30 12:00:00', 1, 804, 805);
INSERT INTO `base_region` VALUES ('1071201', '朝阳', '辽宁-朝阳', 1071201, '1070000', 0, NULL, '2018-03-30 12:00:00', 1, 807, 820);
INSERT INTO `base_region` VALUES ('1071202', '双塔', '辽宁-朝阳-双塔', 1071202, '1071201', 1, NULL, '2018-03-30 12:00:00', 1, 808, 809);
INSERT INTO `base_region` VALUES ('1071203', '凌源', '辽宁-朝阳-凌源', 1071203, '1071201', 1, NULL, '2018-03-30 12:00:00', 1, 810, 811);
INSERT INTO `base_region` VALUES ('1071204', '喀左', '辽宁-朝阳-喀左', 1071204, '1071201', 1, NULL, '2018-03-30 12:00:00', 1, 812, 813);
INSERT INTO `base_region` VALUES ('1071205', '北票', '辽宁-朝阳-北票', 1071205, '1071201', 1, NULL, '2018-03-30 12:00:00', 1, 814, 815);
INSERT INTO `base_region` VALUES ('1071206', '龙城', '辽宁-朝阳-龙城', 1071206, '1071201', 1, NULL, '2018-03-30 12:00:00', 1, 816, 817);
INSERT INTO `base_region` VALUES ('1071207', '建平县', '辽宁-朝阳-建平县', 1071207, '1071201', 1, NULL, '2018-03-30 12:00:00', 1, 818, 819);
INSERT INTO `base_region` VALUES ('1071301', '盘锦', '辽宁-盘锦', 1071301, '1070000', 0, NULL, '2018-03-30 12:00:00', 1, 821, 830);
INSERT INTO `base_region` VALUES ('1071302', '大洼', '辽宁-盘锦-大洼', 1071302, '1071301', 1, NULL, '2018-03-30 12:00:00', 1, 822, 823);
INSERT INTO `base_region` VALUES ('1071303', '盘山', '辽宁-盘锦-盘山', 1071303, '1071301', 1, NULL, '2018-03-30 12:00:00', 1, 824, 825);
INSERT INTO `base_region` VALUES ('1071304', '双台子', '辽宁-盘锦-双台子', 1071304, '1071301', 1, NULL, '2018-03-30 12:00:00', 1, 826, 827);
INSERT INTO `base_region` VALUES ('1071305', '兴隆台', '辽宁-盘锦-兴隆台', 1071305, '1071301', 1, NULL, '2018-03-30 12:00:00', 1, 828, 829);
INSERT INTO `base_region` VALUES ('1071401', '葫芦岛', '辽宁-葫芦岛', 1071401, '1070000', 0, NULL, '2018-03-30 12:00:00', 1, 831, 844);
INSERT INTO `base_region` VALUES ('1071402', '建昌', '辽宁-葫芦岛-建昌', 1071402, '1071401', 1, NULL, '2018-03-30 12:00:00', 1, 832, 833);
INSERT INTO `base_region` VALUES ('1071403', '绥中', '辽宁-葫芦岛-绥中', 1071403, '1071401', 1, NULL, '2018-03-30 12:00:00', 1, 834, 835);
INSERT INTO `base_region` VALUES ('1071404', '兴城', '辽宁-葫芦岛-兴城', 1071404, '1071401', 1, NULL, '2018-03-30 12:00:00', 1, 836, 837);
INSERT INTO `base_region` VALUES ('1071405', '连山', '辽宁-葫芦岛-连山', 1071405, '1071401', 1, NULL, '2018-03-30 12:00:00', 1, 838, 839);
INSERT INTO `base_region` VALUES ('1071406', '龙港', '辽宁-葫芦岛-龙港', 1071406, '1071401', 1, NULL, '2018-03-30 12:00:00', 1, 840, 841);
INSERT INTO `base_region` VALUES ('1071407', '南票', '辽宁-葫芦岛-南票', 1071407, '1071401', 1, NULL, '2018-03-30 12:00:00', 1, 842, 843);
INSERT INTO `base_region` VALUES ('1080000', '内蒙古', '内蒙古', 1080000, 'ROOT', 0, NULL, '2018-03-30 12:00:00', 1, 846, 1075);
INSERT INTO `base_region` VALUES ('1080101', '呼和浩特', '内蒙古-呼和浩特', 1080101, '1080000', 0, NULL, '2018-03-30 12:00:00', 1, 847, 866);
INSERT INTO `base_region` VALUES ('1080102', '土左旗', '内蒙古-呼和浩特-土左旗', 1080102, '1080101', 1, NULL, '2018-03-30 12:00:00', 1, 848, 849);
INSERT INTO `base_region` VALUES ('1080103', '托县', '内蒙古-呼和浩特-托县', 1080103, '1080101', 1, NULL, '2018-03-30 12:00:00', 1, 850, 851);
INSERT INTO `base_region` VALUES ('1080104', '和林', '内蒙古-呼和浩特-和林', 1080104, '1080101', 1, NULL, '2018-03-30 12:00:00', 1, 852, 853);
INSERT INTO `base_region` VALUES ('1080105', '清水河', '内蒙古-呼和浩特-清水河', 1080105, '1080101', 1, NULL, '2018-03-30 12:00:00', 1, 854, 855);
INSERT INTO `base_region` VALUES ('1080106', '赛罕', '内蒙古-呼和浩特-赛罕', 1080106, '1080101', 1, NULL, '2018-03-30 12:00:00', 1, 856, 857);
INSERT INTO `base_region` VALUES ('1080107', '武川', '内蒙古-呼和浩特-武川', 1080107, '1080101', 1, NULL, '2018-03-30 12:00:00', 1, 858, 859);
INSERT INTO `base_region` VALUES ('1080108', '新城', '内蒙古-呼和浩特-新城', 1080108, '1080101', 1, NULL, '2018-03-30 12:00:00', 1, 860, 861);
INSERT INTO `base_region` VALUES ('1080109', '回民', '内蒙古-呼和浩特-回民', 1080109, '1080101', 1, NULL, '2018-03-30 12:00:00', 1, 862, 863);
INSERT INTO `base_region` VALUES ('1080110', '玉泉', '内蒙古-呼和浩特-玉泉', 1080110, '1080101', 1, NULL, '2018-03-30 12:00:00', 1, 864, 865);
INSERT INTO `base_region` VALUES ('1080201', '包头', '内蒙古-包头', 1080201, '1080000', 0, NULL, '2018-03-30 12:00:00', 1, 867, 886);
INSERT INTO `base_region` VALUES ('1080202', '白云鄂博', '内蒙古-包头-白云鄂博', 1080202, '1080201', 1, NULL, '2018-03-30 12:00:00', 1, 868, 869);
INSERT INTO `base_region` VALUES ('1080204', '土右旗', '内蒙古-包头-土右旗', 1080204, '1080201', 1, NULL, '2018-03-30 12:00:00', 1, 870, 871);
INSERT INTO `base_region` VALUES ('1080205', '固阳', '内蒙古-包头-固阳', 1080205, '1080201', 1, NULL, '2018-03-30 12:00:00', 1, 872, 873);
INSERT INTO `base_region` VALUES ('1080206', '达茂旗', '内蒙古-包头-达茂旗', 1080206, '1080201', 1, NULL, '2018-03-30 12:00:00', 1, 874, 875);
INSERT INTO `base_region` VALUES ('1080208', '东河', '内蒙古-包头-东河', 1080208, '1080201', 1, NULL, '2018-03-30 12:00:00', 1, 876, 877);
INSERT INTO `base_region` VALUES ('1080209', '昆都仑', '内蒙古-包头-昆都仑', 1080209, '1080201', 1, NULL, '2018-03-30 12:00:00', 1, 878, 879);
INSERT INTO `base_region` VALUES ('1080210', '青山', '内蒙古-包头-青山', 1080210, '1080201', 1, NULL, '2018-03-30 12:00:00', 1, 880, 881);
INSERT INTO `base_region` VALUES ('1080211', '石拐', '内蒙古-包头-石拐', 1080211, '1080201', 1, NULL, '2018-03-30 12:00:00', 1, 882, 883);
INSERT INTO `base_region` VALUES ('1080212', '九原', '内蒙古-包头-九原', 1080212, '1080201', 1, NULL, '2018-03-30 12:00:00', 1, 884, 885);
INSERT INTO `base_region` VALUES ('1080301', '乌海', '内蒙古-乌海', 1080301, '1080000', 0, NULL, '2018-03-30 12:00:00', 1, 887, 894);
INSERT INTO `base_region` VALUES ('1080302', '海勃湾', '内蒙古-乌海-海勃湾', 1080302, '1080301', 1, NULL, '2018-03-30 12:00:00', 1, 888, 889);
INSERT INTO `base_region` VALUES ('1080303', '海南', '内蒙古-乌海-海南', 1080303, '1080301', 1, NULL, '2018-03-30 12:00:00', 1, 890, 891);
INSERT INTO `base_region` VALUES ('1080304', '乌达', '内蒙古-乌海-乌达', 1080304, '1080301', 1, NULL, '2018-03-30 12:00:00', 1, 892, 893);
INSERT INTO `base_region` VALUES ('1080401', '集宁', '内蒙古-乌兰察布-集宁', 1080401, '1080405', 1, NULL, '2018-03-30 12:00:00', 1, 896, 897);
INSERT INTO `base_region` VALUES ('1080402', '卓资', '内蒙古-乌兰察布-卓资', 1080402, '1080405', 1, NULL, '2018-03-30 12:00:00', 1, 898, 899);
INSERT INTO `base_region` VALUES ('1080403', '化德', '内蒙古-乌兰察布-化德', 1080403, '1080405', 1, NULL, '2018-03-30 12:00:00', 1, 900, 901);
INSERT INTO `base_region` VALUES ('1080404', '商都', '内蒙古-乌兰察布-商都', 1080404, '1080405', 1, NULL, '2018-03-30 12:00:00', 1, 902, 903);
INSERT INTO `base_region` VALUES ('1080405', '乌兰察布', '内蒙古-乌兰察布', 1080405, '1080000', 0, NULL, '2018-03-30 12:00:00', 1, 895, 918);
INSERT INTO `base_region` VALUES ('1080406', '兴和', '内蒙古-乌兰察布-兴和', 1080406, '1080405', 1, NULL, '2018-03-30 12:00:00', 1, 904, 905);
INSERT INTO `base_region` VALUES ('1080407', '凉城', '内蒙古-乌兰察布-凉城', 1080407, '1080405', 1, NULL, '2018-03-30 12:00:00', 1, 906, 907);
INSERT INTO `base_region` VALUES ('1080408', '察右前旗', '内蒙古-乌兰察布-察右前旗', 1080408, '1080405', 1, NULL, '2018-03-30 12:00:00', 1, 908, 909);
INSERT INTO `base_region` VALUES ('1080409', '察右中旗', '内蒙古-乌兰察布-察右中旗', 1080409, '1080405', 1, NULL, '2018-03-30 12:00:00', 1, 910, 911);
INSERT INTO `base_region` VALUES ('1080410', '察右后旗', '内蒙古-乌兰察布-察右后旗', 1080410, '1080405', 1, NULL, '2018-03-30 12:00:00', 1, 912, 913);
INSERT INTO `base_region` VALUES ('1080411', '四子王旗', '内蒙古-乌兰察布-四子王旗', 1080411, '1080405', 1, NULL, '2018-03-30 12:00:00', 1, 914, 915);
INSERT INTO `base_region` VALUES ('1080412', '丰镇', '内蒙古-乌兰察布-丰镇', 1080412, '1080405', 1, NULL, '2018-03-30 12:00:00', 1, 916, 917);
INSERT INTO `base_region` VALUES ('1080501', '通辽', '内蒙古-通辽', 1080501, '1080000', 0, NULL, '2018-03-30 12:00:00', 1, 919, 936);
INSERT INTO `base_region` VALUES ('1080503', '科左中旗', '内蒙古-通辽-科左中旗', 1080503, '1080501', 1, NULL, '2018-03-30 12:00:00', 1, 920, 921);
INSERT INTO `base_region` VALUES ('1080504', '科左后旗', '内蒙古-通辽-科左后旗', 1080504, '1080501', 1, NULL, '2018-03-30 12:00:00', 1, 922, 923);
INSERT INTO `base_region` VALUES ('1080506', '开鲁', '内蒙古-通辽-开鲁', 1080506, '1080501', 1, NULL, '2018-03-30 12:00:00', 1, 924, 925);
INSERT INTO `base_region` VALUES ('1080507', '库伦', '内蒙古-通辽-库伦', 1080507, '1080501', 1, NULL, '2018-03-30 12:00:00', 1, 926, 927);
INSERT INTO `base_region` VALUES ('1080508', '奈曼', '内蒙古-通辽-奈曼', 1080508, '1080501', 1, NULL, '2018-03-30 12:00:00', 1, 928, 929);
INSERT INTO `base_region` VALUES ('1080509', '扎鲁特', '内蒙古-通辽-扎鲁特', 1080509, '1080501', 1, NULL, '2018-03-30 12:00:00', 1, 930, 931);
INSERT INTO `base_region` VALUES ('1080510', '科尔沁', '内蒙古-通辽-科尔沁', 1080510, '1080501', 1, NULL, '2018-03-30 12:00:00', 1, 932, 933);
INSERT INTO `base_region` VALUES ('1080512', '霍林郭勒', '内蒙古-通辽-霍林郭勒', 1080512, '1080501', 1, NULL, '2018-03-30 12:00:00', 1, 934, 935);
INSERT INTO `base_region` VALUES ('1080601', '赤峰', '内蒙古-赤峰', 1080601, '1080000', 0, NULL, '2018-03-30 12:00:00', 1, 937, 962);
INSERT INTO `base_region` VALUES ('1080602', '红山', '内蒙古-赤峰-红山', 1080602, '1080601', 1, NULL, '2018-03-30 12:00:00', 1, 938, 939);
INSERT INTO `base_region` VALUES ('1080603', '阿鲁旗', '内蒙古-赤峰-阿鲁旗', 1080603, '1080601', 1, NULL, '2018-03-30 12:00:00', 1, 940, 941);
INSERT INTO `base_region` VALUES ('1080605', '巴林左旗', '内蒙古-赤峰-巴林左旗', 1080605, '1080601', 1, NULL, '2018-03-30 12:00:00', 1, 942, 943);
INSERT INTO `base_region` VALUES ('1080606', '巴林右旗', '内蒙古-赤峰-巴林右旗', 1080606, '1080601', 1, NULL, '2018-03-30 12:00:00', 1, 944, 945);
INSERT INTO `base_region` VALUES ('1080607', '林西', '内蒙古-赤峰-林西', 1080607, '1080601', 1, NULL, '2018-03-30 12:00:00', 1, 946, 947);
INSERT INTO `base_region` VALUES ('1080608', '克什克腾', '内蒙古-赤峰-克什克腾', 1080608, '1080601', 1, NULL, '2018-03-30 12:00:00', 1, 948, 949);
INSERT INTO `base_region` VALUES ('1080609', '翁牛特', '内蒙古-赤峰-翁牛特', 1080609, '1080601', 1, NULL, '2018-03-30 12:00:00', 1, 950, 951);
INSERT INTO `base_region` VALUES ('1080611', '喀喇沁', '内蒙古-赤峰-喀喇沁', 1080611, '1080601', 1, NULL, '2018-03-30 12:00:00', 1, 952, 953);
INSERT INTO `base_region` VALUES ('1080613', '宁城', '内蒙古-赤峰-宁城', 1080613, '1080601', 1, NULL, '2018-03-30 12:00:00', 1, 954, 955);
INSERT INTO `base_region` VALUES ('1080614', '敖汉', '内蒙古-赤峰-敖汉', 1080614, '1080601', 1, NULL, '2018-03-30 12:00:00', 1, 956, 957);
INSERT INTO `base_region` VALUES ('1080616', '元宝山', '内蒙古-赤峰-元宝山', 1080616, '1080601', 1, NULL, '2018-03-30 12:00:00', 1, 958, 959);
INSERT INTO `base_region` VALUES ('1080617', '松山', '内蒙古-赤峰-松山', 1080617, '1080601', 1, NULL, '2018-03-30 12:00:00', 1, 960, 961);
INSERT INTO `base_region` VALUES ('1080701', '鄂尔多斯', '内蒙古-鄂尔多斯', 1080701, '1080000', 0, NULL, '2018-03-30 12:00:00', 1, 963, 980);
INSERT INTO `base_region` VALUES ('1080703', '达拉特', '内蒙古-鄂尔多斯-达拉特', 1080703, '1080701', 1, NULL, '2018-03-30 12:00:00', 1, 964, 965);
INSERT INTO `base_region` VALUES ('1080704', '准格尔', '内蒙古-鄂尔多斯-准格尔', 1080704, '1080701', 1, NULL, '2018-03-30 12:00:00', 1, 966, 967);
INSERT INTO `base_region` VALUES ('1080705', '鄂前旗', '内蒙古-鄂尔多斯-鄂前旗', 1080705, '1080701', 1, NULL, '2018-03-30 12:00:00', 1, 968, 969);
INSERT INTO `base_region` VALUES ('1080708', '鄂托克', '内蒙古-鄂尔多斯-鄂托克', 1080708, '1080701', 1, NULL, '2018-03-30 12:00:00', 1, 970, 971);
INSERT INTO `base_region` VALUES ('1080709', '杭锦旗', '内蒙古-鄂尔多斯-杭锦旗', 1080709, '1080701', 1, NULL, '2018-03-30 12:00:00', 1, 972, 973);
INSERT INTO `base_region` VALUES ('1080710', '乌审旗', '内蒙古-鄂尔多斯-乌审旗', 1080710, '1080701', 1, NULL, '2018-03-30 12:00:00', 1, 974, 975);
INSERT INTO `base_region` VALUES ('1080711', '伊金霍洛', '内蒙古-鄂尔多斯-伊金霍洛', 1080711, '1080701', 1, NULL, '2018-03-30 12:00:00', 1, 976, 977);
INSERT INTO `base_region` VALUES ('1080713', '东胜', '内蒙古-鄂尔多斯-东胜', 1080713, '1080701', 1, NULL, '2018-03-30 12:00:00', 1, 978, 979);
INSERT INTO `base_region` VALUES ('1080801', '临河', '内蒙古-巴彦淖尔-临河', 1080801, '1080811', 1, NULL, '2018-03-30 12:00:00', 1, 982, 983);
INSERT INTO `base_region` VALUES ('1080802', '五原', '内蒙古-巴彦淖尔-五原', 1080802, '1080811', 1, NULL, '2018-03-30 12:00:00', 1, 984, 985);
INSERT INTO `base_region` VALUES ('1080803', '磴口', '内蒙古-巴彦淖尔-磴口', 1080803, '1080811', 1, NULL, '2018-03-30 12:00:00', 1, 986, 987);
INSERT INTO `base_region` VALUES ('1080804', '乌前旗', '内蒙古-巴彦淖尔-乌前旗', 1080804, '1080811', 1, NULL, '2018-03-30 12:00:00', 1, 988, 989);
INSERT INTO `base_region` VALUES ('1080806', '乌中旗', '内蒙古-巴彦淖尔-乌中旗', 1080806, '1080811', 1, NULL, '2018-03-30 12:00:00', 1, 990, 991);
INSERT INTO `base_region` VALUES ('1080807', '乌后旗', '内蒙古-巴彦淖尔-乌后旗', 1080807, '1080811', 1, NULL, '2018-03-30 12:00:00', 1, 992, 993);
INSERT INTO `base_region` VALUES ('1080810', '杭锦后旗', '内蒙古-巴彦淖尔-杭锦后旗', 1080810, '1080811', 1, NULL, '2018-03-30 12:00:00', 1, 994, 995);
INSERT INTO `base_region` VALUES ('1080811', '巴彦淖尔', '内蒙古-巴彦淖尔', 1080811, '1080000', 0, NULL, '2018-03-30 12:00:00', 1, 981, 996);
INSERT INTO `base_region` VALUES ('1080901', '锡林浩特', '内蒙古-锡林郭勒-锡林浩特', 1080901, '1080902', 1, NULL, '2018-03-30 12:00:00', 1, 998, 999);
INSERT INTO `base_region` VALUES ('1080902', '锡林郭勒', '内蒙古-锡林郭勒', 1080902, '1080000', 0, NULL, '2018-03-30 12:00:00', 1, 997, 1022);
INSERT INTO `base_region` VALUES ('1080903', '二连浩特', '内蒙古-锡林郭勒-二连浩特', 1080903, '1080902', 1, NULL, '2018-03-30 12:00:00', 1, 1000, 1001);
INSERT INTO `base_region` VALUES ('1080904', '阿巴嘎', '内蒙古-锡林郭勒-阿巴嘎', 1080904, '1080902', 1, NULL, '2018-03-30 12:00:00', 1, 1002, 1003);
INSERT INTO `base_region` VALUES ('1080906', '苏左旗', '内蒙古-锡林郭勒-苏左旗', 1080906, '1080902', 1, NULL, '2018-03-30 12:00:00', 1, 1004, 1005);
INSERT INTO `base_region` VALUES ('1080907', '苏右旗', '内蒙古-锡林郭勒-苏右旗', 1080907, '1080902', 1, NULL, '2018-03-30 12:00:00', 1, 1006, 1007);
INSERT INTO `base_region` VALUES ('1080909', '东乌旗', '内蒙古-锡林郭勒-东乌旗', 1080909, '1080902', 1, NULL, '2018-03-30 12:00:00', 1, 1008, 1009);
INSERT INTO `base_region` VALUES ('1080910', '西乌旗', '内蒙古-锡林郭勒-西乌旗', 1080910, '1080902', 1, NULL, '2018-03-30 12:00:00', 1, 1010, 1011);
INSERT INTO `base_region` VALUES ('1080911', '太仆寺', '内蒙古-锡林郭勒-太仆寺', 1080911, '1080902', 1, NULL, '2018-03-30 12:00:00', 1, 1012, 1013);
INSERT INTO `base_region` VALUES ('1080912', '镶黄旗', '内蒙古-锡林郭勒-镶黄旗', 1080912, '1080902', 1, NULL, '2018-03-30 12:00:00', 1, 1014, 1015);
INSERT INTO `base_region` VALUES ('1080913', '正镶白旗', '内蒙古-锡林郭勒-正镶白旗', 1080913, '1080902', 1, NULL, '2018-03-30 12:00:00', 1, 1016, 1017);
INSERT INTO `base_region` VALUES ('1080914', '正蓝旗', '内蒙古-锡林郭勒-正蓝旗', 1080914, '1080902', 1, NULL, '2018-03-30 12:00:00', 1, 1018, 1019);
INSERT INTO `base_region` VALUES ('1080915', '多伦', '内蒙古-锡林郭勒-多伦', 1080915, '1080902', 1, NULL, '2018-03-30 12:00:00', 1, 1020, 1021);
INSERT INTO `base_region` VALUES ('1081001', '海拉尔', '内蒙古-呼伦贝尔-海拉尔', 1081001, '1081013', 1, NULL, '2018-03-30 12:00:00', 1, 1024, 1025);
INSERT INTO `base_region` VALUES ('1081003', '阿荣旗', '内蒙古-呼伦贝尔-阿荣旗', 1081003, '1081013', 1, NULL, '2018-03-30 12:00:00', 1, 1026, 1027);
INSERT INTO `base_region` VALUES ('1081004', '莫力达瓦', '内蒙古-呼伦贝尔-莫力达瓦', 1081004, '1081013', 1, NULL, '2018-03-30 12:00:00', 1, 1028, 1029);
INSERT INTO `base_region` VALUES ('1081005', '鄂伦春旗', '内蒙古-呼伦贝尔-鄂伦春旗', 1081005, '1081013', 1, NULL, '2018-03-30 12:00:00', 1, 1030, 1031);
INSERT INTO `base_region` VALUES ('1081006', '鄂温克旗', '内蒙古-呼伦贝尔-鄂温克旗', 1081006, '1081013', 1, NULL, '2018-03-30 12:00:00', 1, 1032, 1033);
INSERT INTO `base_region` VALUES ('1081007', '陈旗', '内蒙古-呼伦贝尔-陈旗', 1081007, '1081013', 1, NULL, '2018-03-30 12:00:00', 1, 1034, 1035);
INSERT INTO `base_region` VALUES ('1081008', '新左旗', '内蒙古-呼伦贝尔-新左旗', 1081008, '1081013', 1, NULL, '2018-03-30 12:00:00', 1, 1036, 1037);
INSERT INTO `base_region` VALUES ('1081009', '新右旗', '内蒙古-呼伦贝尔-新右旗', 1081009, '1081013', 1, NULL, '2018-03-30 12:00:00', 1, 1038, 1039);
INSERT INTO `base_region` VALUES ('1081010', '满洲里', '内蒙古-呼伦贝尔-满洲里', 1081010, '1081013', 1, NULL, '2018-03-30 12:00:00', 1, 1040, 1041);
INSERT INTO `base_region` VALUES ('1081011', '牙克石', '内蒙古-呼伦贝尔-牙克石', 1081011, '1081013', 1, NULL, '2018-03-30 12:00:00', 1, 1042, 1043);
INSERT INTO `base_region` VALUES ('1081012', '扎兰屯', '内蒙古-呼伦贝尔-扎兰屯', 1081012, '1081013', 1, NULL, '2018-03-30 12:00:00', 1, 1044, 1045);
INSERT INTO `base_region` VALUES ('1081013', '呼伦贝尔', '内蒙古-呼伦贝尔', 1081013, '1080000', 0, NULL, '2018-03-30 12:00:00', 1, 1023, 1052);
INSERT INTO `base_region` VALUES ('1081014', '额尔古纳', '内蒙古-呼伦贝尔-额尔古纳', 1081014, '1081013', 1, NULL, '2018-03-30 12:00:00', 1, 1046, 1047);
INSERT INTO `base_region` VALUES ('1081015', '根河', '内蒙古-呼伦贝尔-根河', 1081015, '1081013', 1, NULL, '2018-03-30 12:00:00', 1, 1048, 1049);
INSERT INTO `base_region` VALUES ('1081017', '扎赉诺尔', '内蒙古-呼伦贝尔-扎赉诺尔', 1081017, '1081013', 1, NULL, '2018-03-30 12:00:00', 1, 1050, 1051);
INSERT INTO `base_region` VALUES ('1081101', '乌兰浩特', '内蒙古-兴安盟-乌兰浩特', 1081101, '1081108', 1, NULL, '2018-03-30 12:00:00', 1, 1054, 1055);
INSERT INTO `base_region` VALUES ('1081102', '阿尔山', '内蒙古-兴安盟-阿尔山', 1081102, '1081108', 1, NULL, '2018-03-30 12:00:00', 1, 1056, 1057);
INSERT INTO `base_region` VALUES ('1081103', '科右中旗', '内蒙古-兴安盟-科右中旗', 1081103, '1081108', 1, NULL, '2018-03-30 12:00:00', 1, 1058, 1059);
INSERT INTO `base_region` VALUES ('1081105', '扎赉特', '内蒙古-兴安盟-扎赉特', 1081105, '1081108', 1, NULL, '2018-03-30 12:00:00', 1, 1060, 1061);
INSERT INTO `base_region` VALUES ('1081107', '突泉', '内蒙古-兴安盟-突泉', 1081107, '1081108', 1, NULL, '2018-03-30 12:00:00', 1, 1062, 1063);
INSERT INTO `base_region` VALUES ('1081108', '兴安盟', '内蒙古-兴安盟', 1081108, '1080000', 0, NULL, '2018-03-30 12:00:00', 1, 1053, 1066);
INSERT INTO `base_region` VALUES ('1081109', '科右前旗', '内蒙古-兴安盟-科右前旗', 1081109, '1081108', 1, NULL, '2018-03-30 12:00:00', 1, 1064, 1065);
INSERT INTO `base_region` VALUES ('1081201', '阿左旗', '内蒙古-阿拉善盟-阿左旗', 1081201, '1081213', 1, NULL, '2018-03-30 12:00:00', 1, 1068, 1069);
INSERT INTO `base_region` VALUES ('1081202', '阿右旗', '内蒙古-阿拉善盟-阿右旗', 1081202, '1081213', 1, NULL, '2018-03-30 12:00:00', 1, 1070, 1071);
INSERT INTO `base_region` VALUES ('1081203', '额济纳', '内蒙古-阿拉善盟-额济纳', 1081203, '1081213', 1, NULL, '2018-03-30 12:00:00', 1, 1072, 1073);
INSERT INTO `base_region` VALUES ('1081213', '阿拉善盟', '内蒙古-阿拉善盟', 1081213, '1080000', 0, NULL, '2018-03-30 12:00:00', 1, 1067, 1074);
INSERT INTO `base_region` VALUES ('1090000', '河北', '河北', 1090000, 'ROOT', 0, NULL, '2018-03-30 12:00:00', 1, 1076, 1435);
INSERT INTO `base_region` VALUES ('1090101', '石家庄', '河北-石家庄', 1090101, '1090000', 0, NULL, '2018-03-30 12:00:00', 1, 1077, 1122);
INSERT INTO `base_region` VALUES ('1090102', '井陉', '河北-石家庄-井陉', 1090102, '1090101', 1, NULL, '2018-03-30 12:00:00', 1, 1078, 1079);
INSERT INTO `base_region` VALUES ('1090103', '正定', '河北-石家庄-正定', 1090103, '1090101', 1, NULL, '2018-03-30 12:00:00', 1, 1080, 1081);
INSERT INTO `base_region` VALUES ('1090104', '栾城', '河北-石家庄-栾城', 1090104, '1090101', 1, NULL, '2018-03-30 12:00:00', 1, 1082, 1083);
INSERT INTO `base_region` VALUES ('1090105', '行唐', '河北-石家庄-行唐', 1090105, '1090101', 1, NULL, '2018-03-30 12:00:00', 1, 1084, 1085);
INSERT INTO `base_region` VALUES ('1090106', '灵寿', '河北-石家庄-灵寿', 1090106, '1090101', 1, NULL, '2018-03-30 12:00:00', 1, 1086, 1087);
INSERT INTO `base_region` VALUES ('1090107', '高邑', '河北-石家庄-高邑', 1090107, '1090101', 1, NULL, '2018-03-30 12:00:00', 1, 1088, 1089);
INSERT INTO `base_region` VALUES ('1090108', '深泽', '河北-石家庄-深泽', 1090108, '1090101', 1, NULL, '2018-03-30 12:00:00', 1, 1090, 1091);
INSERT INTO `base_region` VALUES ('1090109', '赞皇', '河北-石家庄-赞皇', 1090109, '1090101', 1, NULL, '2018-03-30 12:00:00', 1, 1092, 1093);
INSERT INTO `base_region` VALUES ('1090110', '无极', '河北-石家庄-无极', 1090110, '1090101', 1, NULL, '2018-03-30 12:00:00', 1, 1094, 1095);
INSERT INTO `base_region` VALUES ('1090111', '平山', '河北-石家庄-平山', 1090111, '1090101', 1, NULL, '2018-03-30 12:00:00', 1, 1096, 1097);
INSERT INTO `base_region` VALUES ('1090112', '元氏', '河北-石家庄-元氏', 1090112, '1090101', 1, NULL, '2018-03-30 12:00:00', 1, 1098, 1099);
INSERT INTO `base_region` VALUES ('1090113', '赵县', '河北-石家庄-赵县', 1090113, '1090101', 1, NULL, '2018-03-30 12:00:00', 1, 1100, 1101);
INSERT INTO `base_region` VALUES ('1090114', '辛集', '河北-石家庄-辛集', 1090114, '1090101', 1, NULL, '2018-03-30 12:00:00', 1, 1102, 1103);
INSERT INTO `base_region` VALUES ('1090115', '藁城', '河北-石家庄-藁城', 1090115, '1090101', 1, NULL, '2018-03-30 12:00:00', 1, 1104, 1105);
INSERT INTO `base_region` VALUES ('1090116', '晋州', '河北-石家庄-晋州', 1090116, '1090101', 1, NULL, '2018-03-30 12:00:00', 1, 1106, 1107);
INSERT INTO `base_region` VALUES ('1090117', '新乐', '河北-石家庄-新乐', 1090117, '1090101', 1, NULL, '2018-03-30 12:00:00', 1, 1108, 1109);
INSERT INTO `base_region` VALUES ('1090118', '鹿泉', '河北-石家庄-鹿泉', 1090118, '1090101', 1, NULL, '2018-03-30 12:00:00', 1, 1110, 1111);
INSERT INTO `base_region` VALUES ('1090119', '长安', '河北-石家庄-长安', 1090119, '1090101', 1, NULL, '2018-03-30 12:00:00', 1, 1112, 1113);
INSERT INTO `base_region` VALUES ('1090120', '桥西', '河北-石家庄-桥西', 1090120, '1090101', 1, NULL, '2018-03-30 12:00:00', 1, 1114, 1115);
INSERT INTO `base_region` VALUES ('1090121', '新华', '河北-石家庄-新华', 1090121, '1090101', 1, NULL, '2018-03-30 12:00:00', 1, 1116, 1117);
INSERT INTO `base_region` VALUES ('1090122', '井陉矿区', '河北-石家庄-井陉矿区', 1090122, '1090101', 1, NULL, '2018-03-30 12:00:00', 1, 1118, 1119);
INSERT INTO `base_region` VALUES ('1090123', '裕华', '河北-石家庄-裕华', 1090123, '1090101', 1, NULL, '2018-03-30 12:00:00', 1, 1120, 1121);
INSERT INTO `base_region` VALUES ('1090201', '保定', '河北-保定', 1090201, '1090000', 0, NULL, '2018-03-30 12:00:00', 1, 1123, 1174);
INSERT INTO `base_region` VALUES ('1090202', '满城', '河北-保定-满城', 1090202, '1090201', 1, NULL, '2018-03-30 12:00:00', 1, 1124, 1125);
INSERT INTO `base_region` VALUES ('1090203', '阜平', '河北-保定-阜平', 1090203, '1090201', 1, NULL, '2018-03-30 12:00:00', 1, 1126, 1127);
INSERT INTO `base_region` VALUES ('1090204', '徐水', '河北-保定-徐水', 1090204, '1090201', 1, NULL, '2018-03-30 12:00:00', 1, 1128, 1129);
INSERT INTO `base_region` VALUES ('1090205', '唐县', '河北-保定-唐县', 1090205, '1090201', 1, NULL, '2018-03-30 12:00:00', 1, 1130, 1131);
INSERT INTO `base_region` VALUES ('1090206', '高阳', '河北-保定-高阳', 1090206, '1090201', 1, NULL, '2018-03-30 12:00:00', 1, 1132, 1133);
INSERT INTO `base_region` VALUES ('1090207', '容城', '河北-保定-容城', 1090207, '1090201', 1, NULL, '2018-03-30 12:00:00', 1, 1134, 1135);
INSERT INTO `base_region` VALUES ('1090208', '竞秀', '河北-保定-竞秀', 1090208, '1090201', 1, NULL, '2018-03-30 12:00:00', 1, 1136, 1137);
INSERT INTO `base_region` VALUES ('1090209', '涞源', '河北-保定-涞源', 1090209, '1090201', 1, NULL, '2018-03-30 12:00:00', 1, 1138, 1139);
INSERT INTO `base_region` VALUES ('1090210', '望都', '河北-保定-望都', 1090210, '1090201', 1, NULL, '2018-03-30 12:00:00', 1, 1140, 1141);
INSERT INTO `base_region` VALUES ('1090211', '安新', '河北-保定-安新', 1090211, '1090201', 1, NULL, '2018-03-30 12:00:00', 1, 1142, 1143);
INSERT INTO `base_region` VALUES ('1090212', '易县', '河北-保定-易县', 1090212, '1090201', 1, NULL, '2018-03-30 12:00:00', 1, 1144, 1145);
INSERT INTO `base_region` VALUES ('1090213', '莲池', '河北-保定-莲池', 1090213, '1090201', 1, NULL, '2018-03-30 12:00:00', 1, 1146, 1147);
INSERT INTO `base_region` VALUES ('1090214', '曲阳', '河北-保定-曲阳', 1090214, '1090201', 1, NULL, '2018-03-30 12:00:00', 1, 1148, 1149);
INSERT INTO `base_region` VALUES ('1090215', '蠡县', '河北-保定-蠡县', 1090215, '1090201', 1, NULL, '2018-03-30 12:00:00', 1, 1150, 1151);
INSERT INTO `base_region` VALUES ('1090216', '顺平', '河北-保定-顺平', 1090216, '1090201', 1, NULL, '2018-03-30 12:00:00', 1, 1152, 1153);
INSERT INTO `base_region` VALUES ('1090217', '雄县', '河北-保定-雄县', 1090217, '1090201', 1, NULL, '2018-03-30 12:00:00', 1, 1154, 1155);
INSERT INTO `base_region` VALUES ('1090218', '涿州', '河北-保定-涿州', 1090218, '1090201', 1, NULL, '2018-03-30 12:00:00', 1, 1156, 1157);
INSERT INTO `base_region` VALUES ('1090219', '定州', '河北-保定-定州', 1090219, '1090201', 1, NULL, '2018-03-30 12:00:00', 1, 1158, 1159);
INSERT INTO `base_region` VALUES ('1090220', '安国', '河北-保定-安国', 1090220, '1090201', 1, NULL, '2018-03-30 12:00:00', 1, 1160, 1161);
INSERT INTO `base_region` VALUES ('1090221', '高碑店', '河北-保定-高碑店', 1090221, '1090201', 1, NULL, '2018-03-30 12:00:00', 1, 1162, 1163);
INSERT INTO `base_region` VALUES ('1090222', '涞水', '河北-保定-涞水', 1090222, '1090201', 1, NULL, '2018-03-30 12:00:00', 1, 1164, 1165);
INSERT INTO `base_region` VALUES ('1090223', '定兴', '河北-保定-定兴', 1090223, '1090201', 1, NULL, '2018-03-30 12:00:00', 1, 1166, 1167);
INSERT INTO `base_region` VALUES ('1090224', '清苑', '河北-保定-清苑', 1090224, '1090201', 1, NULL, '2018-03-30 12:00:00', 1, 1168, 1169);
INSERT INTO `base_region` VALUES ('1090225', '博野', '河北-保定-博野', 1090225, '1090201', 1, NULL, '2018-03-30 12:00:00', 1, 1170, 1171);
INSERT INTO `base_region` VALUES ('1090226', '南市', '河北-保定-南市', 1090226, '1090201', 1, NULL, '2018-03-30 12:00:00', 1, 1172, 1173);
INSERT INTO `base_region` VALUES ('1090301', '张家口', '河北-张家口', 1090301, '1090000', 0, NULL, '2018-03-30 12:00:00', 1, 1175, 1208);
INSERT INTO `base_region` VALUES ('1090302', '宣化', '河北-张家口-宣化', 1090302, '1090301', 1, NULL, '2018-03-30 12:00:00', 1, 1176, 1177);
INSERT INTO `base_region` VALUES ('1090303', '张北', '河北-张家口-张北', 1090303, '1090301', 1, NULL, '2018-03-30 12:00:00', 1, 1178, 1179);
INSERT INTO `base_region` VALUES ('1090304', '康保', '河北-张家口-康保', 1090304, '1090301', 1, NULL, '2018-03-30 12:00:00', 1, 1180, 1181);
INSERT INTO `base_region` VALUES ('1090305', '沽源', '河北-张家口-沽源', 1090305, '1090301', 1, NULL, '2018-03-30 12:00:00', 1, 1182, 1183);
INSERT INTO `base_region` VALUES ('1090306', '尚义', '河北-张家口-尚义', 1090306, '1090301', 1, NULL, '2018-03-30 12:00:00', 1, 1184, 1185);
INSERT INTO `base_region` VALUES ('1090307', '蔚县', '河北-张家口-蔚县', 1090307, '1090301', 1, NULL, '2018-03-30 12:00:00', 1, 1186, 1187);
INSERT INTO `base_region` VALUES ('1090308', '阳原', '河北-张家口-阳原', 1090308, '1090301', 1, NULL, '2018-03-30 12:00:00', 1, 1188, 1189);
INSERT INTO `base_region` VALUES ('1090309', '怀安', '河北-张家口-怀安', 1090309, '1090301', 1, NULL, '2018-03-30 12:00:00', 1, 1190, 1191);
INSERT INTO `base_region` VALUES ('1090310', '万全', '河北-张家口-万全', 1090310, '1090301', 1, NULL, '2018-03-30 12:00:00', 1, 1192, 1193);
INSERT INTO `base_region` VALUES ('1090311', '怀来', '河北-张家口-怀来', 1090311, '1090301', 1, NULL, '2018-03-30 12:00:00', 1, 1194, 1195);
INSERT INTO `base_region` VALUES ('1090312', '涿鹿', '河北-张家口-涿鹿', 1090312, '1090301', 1, NULL, '2018-03-30 12:00:00', 1, 1196, 1197);
INSERT INTO `base_region` VALUES ('1090313', '赤城', '河北-张家口-赤城', 1090313, '1090301', 1, NULL, '2018-03-30 12:00:00', 1, 1198, 1199);
INSERT INTO `base_region` VALUES ('1090314', '崇礼', '河北-张家口-崇礼', 1090314, '1090301', 1, NULL, '2018-03-30 12:00:00', 1, 1200, 1201);
INSERT INTO `base_region` VALUES ('1090315', '桥东', '河北-张家口-桥东', 1090315, '1090301', 1, NULL, '2018-03-30 12:00:00', 1, 1202, 1203);
INSERT INTO `base_region` VALUES ('1090316', '桥西', '河北-张家口-桥西', 1090316, '1090301', 1, NULL, '2018-03-30 12:00:00', 1, 1204, 1205);
INSERT INTO `base_region` VALUES ('1090317', '下花园', '河北-张家口-下花园', 1090317, '1090301', 1, NULL, '2018-03-30 12:00:00', 1, 1206, 1207);
INSERT INTO `base_region` VALUES ('1090401', '双桥', '河北-承德-双桥', 1090401, '1090402', 1, NULL, '2018-03-30 12:00:00', 1, 1210, 1211);
INSERT INTO `base_region` VALUES ('1090402', '承德', '河北-承德', 1090402, '1090000', 0, NULL, '2018-03-30 12:00:00', 1, 1209, 1232);
INSERT INTO `base_region` VALUES ('1090403', '承德县', '河北-承德-承德县', 1090403, '1090402', 1, NULL, '2018-03-30 12:00:00', 1, 1212, 1213);
INSERT INTO `base_region` VALUES ('1090404', '兴隆', '河北-承德-兴隆', 1090404, '1090402', 1, NULL, '2018-03-30 12:00:00', 1, 1214, 1215);
INSERT INTO `base_region` VALUES ('1090405', '平泉', '河北-承德-平泉', 1090405, '1090402', 1, NULL, '2018-03-30 12:00:00', 1, 1216, 1217);
INSERT INTO `base_region` VALUES ('1090406', '滦平', '河北-承德-滦平', 1090406, '1090402', 1, NULL, '2018-03-30 12:00:00', 1, 1218, 1219);
INSERT INTO `base_region` VALUES ('1090407', '隆化', '河北-承德-隆化', 1090407, '1090402', 1, NULL, '2018-03-30 12:00:00', 1, 1220, 1221);
INSERT INTO `base_region` VALUES ('1090408', '丰宁', '河北-承德-丰宁', 1090408, '1090402', 1, NULL, '2018-03-30 12:00:00', 1, 1222, 1223);
INSERT INTO `base_region` VALUES ('1090409', '宽城', '河北-承德-宽城', 1090409, '1090402', 1, NULL, '2018-03-30 12:00:00', 1, 1224, 1225);
INSERT INTO `base_region` VALUES ('1090410', '围场', '河北-承德-围场', 1090410, '1090402', 1, NULL, '2018-03-30 12:00:00', 1, 1226, 1227);
INSERT INTO `base_region` VALUES ('1090411', '双滦', '河北-承德-双滦', 1090411, '1090402', 1, NULL, '2018-03-30 12:00:00', 1, 1228, 1229);
INSERT INTO `base_region` VALUES ('1090412', '鹰手营子矿', '河北-承德-鹰手营子矿', 1090412, '1090402', 1, NULL, '2018-03-30 12:00:00', 1, 1230, 1231);
INSERT INTO `base_region` VALUES ('1090501', '唐山', '河北-唐山', 1090501, '1090000', 0, NULL, '2018-03-30 12:00:00', 1, 1233, 1262);
INSERT INTO `base_region` VALUES ('1090502', '丰南', '河北-唐山-丰南', 1090502, '1090501', 1, NULL, '2018-03-30 12:00:00', 1, 1234, 1235);
INSERT INTO `base_region` VALUES ('1090503', '丰润', '河北-唐山-丰润', 1090503, '1090501', 1, NULL, '2018-03-30 12:00:00', 1, 1236, 1237);
INSERT INTO `base_region` VALUES ('1090504', '滦县', '河北-唐山-滦县', 1090504, '1090501', 1, NULL, '2018-03-30 12:00:00', 1, 1238, 1239);
INSERT INTO `base_region` VALUES ('1090505', '滦南', '河北-唐山-滦南', 1090505, '1090501', 1, NULL, '2018-03-30 12:00:00', 1, 1240, 1241);
INSERT INTO `base_region` VALUES ('1090506', '乐亭', '河北-唐山-乐亭', 1090506, '1090501', 1, NULL, '2018-03-30 12:00:00', 1, 1242, 1243);
INSERT INTO `base_region` VALUES ('1090507', '迁西', '河北-唐山-迁西', 1090507, '1090501', 1, NULL, '2018-03-30 12:00:00', 1, 1244, 1245);
INSERT INTO `base_region` VALUES ('1090508', '玉田', '河北-唐山-玉田', 1090508, '1090501', 1, NULL, '2018-03-30 12:00:00', 1, 1246, 1247);
INSERT INTO `base_region` VALUES ('1090509', '曹妃甸', '河北-唐山-曹妃甸', 1090509, '1090501', 1, NULL, '2018-03-30 12:00:00', 1, 1248, 1249);
INSERT INTO `base_region` VALUES ('1090510', '遵化', '河北-唐山-遵化', 1090510, '1090501', 1, NULL, '2018-03-30 12:00:00', 1, 1250, 1251);
INSERT INTO `base_region` VALUES ('1090511', '迁安', '河北-唐山-迁安', 1090511, '1090501', 1, NULL, '2018-03-30 12:00:00', 1, 1252, 1253);
INSERT INTO `base_region` VALUES ('1090513', '路南', '河北-唐山-路南', 1090513, '1090501', 1, NULL, '2018-03-30 12:00:00', 1, 1254, 1255);
INSERT INTO `base_region` VALUES ('1090514', '路北', '河北-唐山-路北', 1090514, '1090501', 1, NULL, '2018-03-30 12:00:00', 1, 1256, 1257);
INSERT INTO `base_region` VALUES ('1090515', '古冶', '河北-唐山-古冶', 1090515, '1090501', 1, NULL, '2018-03-30 12:00:00', 1, 1258, 1259);
INSERT INTO `base_region` VALUES ('1090516', '开平', '河北-唐山-开平', 1090516, '1090501', 1, NULL, '2018-03-30 12:00:00', 1, 1260, 1261);
INSERT INTO `base_region` VALUES ('1090601', '廊坊', '河北-廊坊', 1090601, '1090000', 0, NULL, '2018-03-30 12:00:00', 1, 1263, 1284);
INSERT INTO `base_region` VALUES ('1090602', '固安', '河北-廊坊-固安', 1090602, '1090601', 1, NULL, '2018-03-30 12:00:00', 1, 1264, 1265);
INSERT INTO `base_region` VALUES ('1090603', '永清', '河北-廊坊-永清', 1090603, '1090601', 1, NULL, '2018-03-30 12:00:00', 1, 1266, 1267);
INSERT INTO `base_region` VALUES ('1090604', '香河', '河北-廊坊-香河', 1090604, '1090601', 1, NULL, '2018-03-30 12:00:00', 1, 1268, 1269);
INSERT INTO `base_region` VALUES ('1090605', '大城', '河北-廊坊-大城', 1090605, '1090601', 1, NULL, '2018-03-30 12:00:00', 1, 1270, 1271);
INSERT INTO `base_region` VALUES ('1090606', '文安', '河北-廊坊-文安', 1090606, '1090601', 1, NULL, '2018-03-30 12:00:00', 1, 1272, 1273);
INSERT INTO `base_region` VALUES ('1090607', '大厂', '河北-廊坊-大厂', 1090607, '1090601', 1, NULL, '2018-03-30 12:00:00', 1, 1274, 1275);
INSERT INTO `base_region` VALUES ('1090608', '霸州', '河北-廊坊-霸州', 1090608, '1090601', 1, NULL, '2018-03-30 12:00:00', 1, 1276, 1277);
INSERT INTO `base_region` VALUES ('1090609', '三河', '河北-廊坊-三河', 1090609, '1090601', 1, NULL, '2018-03-30 12:00:00', 1, 1278, 1279);
INSERT INTO `base_region` VALUES ('1090610', '安次', '河北-廊坊-安次', 1090610, '1090601', 1, NULL, '2018-03-30 12:00:00', 1, 1280, 1281);
INSERT INTO `base_region` VALUES ('1090611', '广阳', '河北-廊坊-广阳', 1090611, '1090601', 1, NULL, '2018-03-30 12:00:00', 1, 1282, 1283);
INSERT INTO `base_region` VALUES ('1090701', '沧州', '河北-沧州', 1090701, '1090000', 0, NULL, '2018-03-30 12:00:00', 1, 1285, 1318);
INSERT INTO `base_region` VALUES ('1090702', '青县', '河北-沧州-青县', 1090702, '1090701', 1, NULL, '2018-03-30 12:00:00', 1, 1286, 1287);
INSERT INTO `base_region` VALUES ('1090703', '东光', '河北-沧州-东光', 1090703, '1090701', 1, NULL, '2018-03-30 12:00:00', 1, 1288, 1289);
INSERT INTO `base_region` VALUES ('1090704', '海兴', '河北-沧州-海兴', 1090704, '1090701', 1, NULL, '2018-03-30 12:00:00', 1, 1290, 1291);
INSERT INTO `base_region` VALUES ('1090705', '盐山', '河北-沧州-盐山', 1090705, '1090701', 1, NULL, '2018-03-30 12:00:00', 1, 1292, 1293);
INSERT INTO `base_region` VALUES ('1090706', '肃宁', '河北-沧州-肃宁', 1090706, '1090701', 1, NULL, '2018-03-30 12:00:00', 1, 1294, 1295);
INSERT INTO `base_region` VALUES ('1090707', '南皮', '河北-沧州-南皮', 1090707, '1090701', 1, NULL, '2018-03-30 12:00:00', 1, 1296, 1297);
INSERT INTO `base_region` VALUES ('1090708', '吴桥', '河北-沧州-吴桥', 1090708, '1090701', 1, NULL, '2018-03-30 12:00:00', 1, 1298, 1299);
INSERT INTO `base_region` VALUES ('1090709', '献县', '河北-沧州-献县', 1090709, '1090701', 1, NULL, '2018-03-30 12:00:00', 1, 1300, 1301);
INSERT INTO `base_region` VALUES ('1090710', '孟村', '河北-沧州-孟村', 1090710, '1090701', 1, NULL, '2018-03-30 12:00:00', 1, 1302, 1303);
INSERT INTO `base_region` VALUES ('1090711', '泊头', '河北-沧州-泊头', 1090711, '1090701', 1, NULL, '2018-03-30 12:00:00', 1, 1304, 1305);
INSERT INTO `base_region` VALUES ('1090712', '任丘', '河北-沧州-任丘', 1090712, '1090701', 1, NULL, '2018-03-30 12:00:00', 1, 1306, 1307);
INSERT INTO `base_region` VALUES ('1090713', '黄骅', '河北-沧州-黄骅', 1090713, '1090701', 1, NULL, '2018-03-30 12:00:00', 1, 1308, 1309);
INSERT INTO `base_region` VALUES ('1090714', '河间', '河北-沧州-河间', 1090714, '1090701', 1, NULL, '2018-03-30 12:00:00', 1, 1310, 1311);
INSERT INTO `base_region` VALUES ('1090715', '新华', '河北-沧州-新华', 1090715, '1090701', 1, NULL, '2018-03-30 12:00:00', 1, 1312, 1313);
INSERT INTO `base_region` VALUES ('1090716', '沧县', '河北-沧州-沧县', 1090716, '1090701', 1, NULL, '2018-03-30 12:00:00', 1, 1314, 1315);
INSERT INTO `base_region` VALUES ('1090717', '运河', '河北-沧州-运河', 1090717, '1090701', 1, NULL, '2018-03-30 12:00:00', 1, 1316, 1317);
INSERT INTO `base_region` VALUES ('1090801', '衡水', '河北-衡水', 1090801, '1090000', 0, NULL, '2018-03-30 12:00:00', 1, 1319, 1342);
INSERT INTO `base_region` VALUES ('1090802', '枣强', '河北-衡水-枣强', 1090802, '1090801', 1, NULL, '2018-03-30 12:00:00', 1, 1320, 1321);
INSERT INTO `base_region` VALUES ('1090803', '武邑', '河北-衡水-武邑', 1090803, '1090801', 1, NULL, '2018-03-30 12:00:00', 1, 1322, 1323);
INSERT INTO `base_region` VALUES ('1090804', '武强', '河北-衡水-武强', 1090804, '1090801', 1, NULL, '2018-03-30 12:00:00', 1, 1324, 1325);
INSERT INTO `base_region` VALUES ('1090805', '饶阳', '河北-衡水-饶阳', 1090805, '1090801', 1, NULL, '2018-03-30 12:00:00', 1, 1326, 1327);
INSERT INTO `base_region` VALUES ('1090806', '安平', '河北-衡水-安平', 1090806, '1090801', 1, NULL, '2018-03-30 12:00:00', 1, 1328, 1329);
INSERT INTO `base_region` VALUES ('1090807', '故城', '河北-衡水-故城', 1090807, '1090801', 1, NULL, '2018-03-30 12:00:00', 1, 1330, 1331);
INSERT INTO `base_region` VALUES ('1090808', '景县', '河北-衡水-景县', 1090808, '1090801', 1, NULL, '2018-03-30 12:00:00', 1, 1332, 1333);
INSERT INTO `base_region` VALUES ('1090809', '阜城', '河北-衡水-阜城', 1090809, '1090801', 1, NULL, '2018-03-30 12:00:00', 1, 1334, 1335);
INSERT INTO `base_region` VALUES ('1090810', '冀州', '河北-衡水-冀州', 1090810, '1090801', 1, NULL, '2018-03-30 12:00:00', 1, 1336, 1337);
INSERT INTO `base_region` VALUES ('1090811', '深州', '河北-衡水-深州', 1090811, '1090801', 1, NULL, '2018-03-30 12:00:00', 1, 1338, 1339);
INSERT INTO `base_region` VALUES ('1090812', '桃城', '河北-衡水-桃城', 1090812, '1090801', 1, NULL, '2018-03-30 12:00:00', 1, 1340, 1341);
INSERT INTO `base_region` VALUES ('1090901', '邢台', '河北-邢台', 1090901, '1090000', 0, NULL, '2018-03-30 12:00:00', 1, 1343, 1380);
INSERT INTO `base_region` VALUES ('1090902', '临城', '河北-邢台-临城', 1090902, '1090901', 1, NULL, '2018-03-30 12:00:00', 1, 1344, 1345);
INSERT INTO `base_region` VALUES ('1090903', '桥东', '河北-邢台-桥东', 1090903, '1090901', 1, NULL, '2018-03-30 12:00:00', 1, 1346, 1347);
INSERT INTO `base_region` VALUES ('1090904', '内丘', '河北-邢台-内丘', 1090904, '1090901', 1, NULL, '2018-03-30 12:00:00', 1, 1348, 1349);
INSERT INTO `base_region` VALUES ('1090905', '柏乡', '河北-邢台-柏乡', 1090905, '1090901', 1, NULL, '2018-03-30 12:00:00', 1, 1350, 1351);
INSERT INTO `base_region` VALUES ('1090906', '隆尧', '河北-邢台-隆尧', 1090906, '1090901', 1, NULL, '2018-03-30 12:00:00', 1, 1352, 1353);
INSERT INTO `base_region` VALUES ('1090907', '南和', '河北-邢台-南和', 1090907, '1090901', 1, NULL, '2018-03-30 12:00:00', 1, 1354, 1355);
INSERT INTO `base_region` VALUES ('1090908', '宁晋', '河北-邢台-宁晋', 1090908, '1090901', 1, NULL, '2018-03-30 12:00:00', 1, 1356, 1357);
INSERT INTO `base_region` VALUES ('1090909', '巨鹿', '河北-邢台-巨鹿', 1090909, '1090901', 1, NULL, '2018-03-30 12:00:00', 1, 1358, 1359);
INSERT INTO `base_region` VALUES ('1090910', '新河', '河北-邢台-新河', 1090910, '1090901', 1, NULL, '2018-03-30 12:00:00', 1, 1360, 1361);
INSERT INTO `base_region` VALUES ('1090911', '广宗', '河北-邢台-广宗', 1090911, '1090901', 1, NULL, '2018-03-30 12:00:00', 1, 1362, 1363);
INSERT INTO `base_region` VALUES ('1090912', '平乡', '河北-邢台-平乡', 1090912, '1090901', 1, NULL, '2018-03-30 12:00:00', 1, 1364, 1365);
INSERT INTO `base_region` VALUES ('1090913', '威县', '河北-邢台-威县', 1090913, '1090901', 1, NULL, '2018-03-30 12:00:00', 1, 1366, 1367);
INSERT INTO `base_region` VALUES ('1090914', '清河', '河北-邢台-清河', 1090914, '1090901', 1, NULL, '2018-03-30 12:00:00', 1, 1368, 1369);
INSERT INTO `base_region` VALUES ('1090915', '临西', '河北-邢台-临西', 1090915, '1090901', 1, NULL, '2018-03-30 12:00:00', 1, 1370, 1371);
INSERT INTO `base_region` VALUES ('1090916', '南宫', '河北-邢台-南宫', 1090916, '1090901', 1, NULL, '2018-03-30 12:00:00', 1, 1372, 1373);
INSERT INTO `base_region` VALUES ('1090917', '沙河', '河北-邢台-沙河', 1090917, '1090901', 1, NULL, '2018-03-30 12:00:00', 1, 1374, 1375);
INSERT INTO `base_region` VALUES ('1090918', '任县', '河北-邢台-任县', 1090918, '1090901', 1, NULL, '2018-03-30 12:00:00', 1, 1376, 1377);
INSERT INTO `base_region` VALUES ('1090919', '桥西', '河北-邢台-桥西', 1090919, '1090901', 1, NULL, '2018-03-30 12:00:00', 1, 1378, 1379);
INSERT INTO `base_region` VALUES ('1091001', '邯郸', '河北-邯郸', 1091001, '1090000', 0, NULL, '2018-03-30 12:00:00', 1, 1381, 1418);
INSERT INTO `base_region` VALUES ('1091002', '峰峰', '河北-邯郸-峰峰', 1091002, '1091001', 1, NULL, '2018-03-30 12:00:00', 1, 1382, 1383);
INSERT INTO `base_region` VALUES ('1091003', '临漳', '河北-邯郸-临漳', 1091003, '1091001', 1, NULL, '2018-03-30 12:00:00', 1, 1384, 1385);
INSERT INTO `base_region` VALUES ('1091004', '成安', '河北-邯郸-成安', 1091004, '1091001', 1, NULL, '2018-03-30 12:00:00', 1, 1386, 1387);
INSERT INTO `base_region` VALUES ('1091005', '大名', '河北-邯郸-大名', 1091005, '1091001', 1, NULL, '2018-03-30 12:00:00', 1, 1388, 1389);
INSERT INTO `base_region` VALUES ('1091006', '涉县', '河北-邯郸-涉县', 1091006, '1091001', 1, NULL, '2018-03-30 12:00:00', 1, 1390, 1391);
INSERT INTO `base_region` VALUES ('1091007', '磁县', '河北-邯郸-磁县', 1091007, '1091001', 1, NULL, '2018-03-30 12:00:00', 1, 1392, 1393);
INSERT INTO `base_region` VALUES ('1091008', '肥乡', '河北-邯郸-肥乡', 1091008, '1091001', 1, NULL, '2018-03-30 12:00:00', 1, 1394, 1395);
INSERT INTO `base_region` VALUES ('1091009', '永年', '河北-邯郸-永年', 1091009, '1091001', 1, NULL, '2018-03-30 12:00:00', 1, 1396, 1397);
INSERT INTO `base_region` VALUES ('1091010', '邱县', '河北-邯郸-邱县', 1091010, '1091001', 1, NULL, '2018-03-30 12:00:00', 1, 1398, 1399);
INSERT INTO `base_region` VALUES ('1091011', '鸡泽', '河北-邯郸-鸡泽', 1091011, '1091001', 1, NULL, '2018-03-30 12:00:00', 1, 1400, 1401);
INSERT INTO `base_region` VALUES ('1091012', '广平', '河北-邯郸-广平', 1091012, '1091001', 1, NULL, '2018-03-30 12:00:00', 1, 1402, 1403);
INSERT INTO `base_region` VALUES ('1091013', '馆陶', '河北-邯郸-馆陶', 1091013, '1091001', 1, NULL, '2018-03-30 12:00:00', 1, 1404, 1405);
INSERT INTO `base_region` VALUES ('1091014', '魏县', '河北-邯郸-魏县', 1091014, '1091001', 1, NULL, '2018-03-30 12:00:00', 1, 1406, 1407);
INSERT INTO `base_region` VALUES ('1091015', '曲周', '河北-邯郸-曲周', 1091015, '1091001', 1, NULL, '2018-03-30 12:00:00', 1, 1408, 1409);
INSERT INTO `base_region` VALUES ('1091016', '武安', '河北-邯郸-武安', 1091016, '1091001', 1, NULL, '2018-03-30 12:00:00', 1, 1410, 1411);
INSERT INTO `base_region` VALUES ('1091017', '邯山', '河北-邯郸-邯山', 1091017, '1091001', 1, NULL, '2018-03-30 12:00:00', 1, 1412, 1413);
INSERT INTO `base_region` VALUES ('1091018', '丛台', '河北-邯郸-丛台', 1091018, '1091001', 1, NULL, '2018-03-30 12:00:00', 1, 1414, 1415);
INSERT INTO `base_region` VALUES ('1091019', '复兴', '河北-邯郸-复兴', 1091019, '1091001', 1, NULL, '2018-03-30 12:00:00', 1, 1416, 1417);
INSERT INTO `base_region` VALUES ('1091101', '秦皇岛', '河北-秦皇岛', 1091101, '1090000', 0, NULL, '2018-03-30 12:00:00', 1, 1419, 1434);
INSERT INTO `base_region` VALUES ('1091102', '青龙', '河北-秦皇岛-青龙', 1091102, '1091101', 1, NULL, '2018-03-30 12:00:00', 1, 1420, 1421);
INSERT INTO `base_region` VALUES ('1091103', '昌黎', '河北-秦皇岛-昌黎', 1091103, '1091101', 1, NULL, '2018-03-30 12:00:00', 1, 1422, 1423);
INSERT INTO `base_region` VALUES ('1091104', '抚宁', '河北-秦皇岛-抚宁', 1091104, '1091101', 1, NULL, '2018-03-30 12:00:00', 1, 1424, 1425);
INSERT INTO `base_region` VALUES ('1091105', '卢龙', '河北-秦皇岛-卢龙', 1091105, '1091101', 1, NULL, '2018-03-30 12:00:00', 1, 1426, 1427);
INSERT INTO `base_region` VALUES ('1091106', '北戴河', '河北-秦皇岛-北戴河', 1091106, '1091101', 1, NULL, '2018-03-30 12:00:00', 1, 1428, 1429);
INSERT INTO `base_region` VALUES ('1091107', '海港', '河北-秦皇岛-海港', 1091107, '1091101', 1, NULL, '2018-03-30 12:00:00', 1, 1430, 1431);
INSERT INTO `base_region` VALUES ('1091108', '山海关', '河北-秦皇岛-山海关', 1091108, '1091101', 1, NULL, '2018-03-30 12:00:00', 1, 1432, 1433);
INSERT INTO `base_region` VALUES ('1100000', '山西', '山西', 1100000, 'ROOT', 0, NULL, '2018-03-30 12:00:00', 1, 1436, 1687);
INSERT INTO `base_region` VALUES ('1100101', '太原', '山西-太原', 1100101, '1100000', 0, NULL, '2018-03-30 12:00:00', 1, 1437, 1458);
INSERT INTO `base_region` VALUES ('1100102', '清徐', '山西-太原-清徐', 1100102, '1100101', 1, NULL, '2018-03-30 12:00:00', 1, 1438, 1439);
INSERT INTO `base_region` VALUES ('1100103', '阳曲', '山西-太原-阳曲', 1100103, '1100101', 1, NULL, '2018-03-30 12:00:00', 1, 1440, 1441);
INSERT INTO `base_region` VALUES ('1100104', '娄烦', '山西-太原-娄烦', 1100104, '1100101', 1, NULL, '2018-03-30 12:00:00', 1, 1442, 1443);
INSERT INTO `base_region` VALUES ('1100105', '古交', '山西-太原-古交', 1100105, '1100101', 1, NULL, '2018-03-30 12:00:00', 1, 1444, 1445);
INSERT INTO `base_region` VALUES ('1100106', '尖草坪区', '山西-太原-尖草坪区', 1100106, '1100101', 1, NULL, '2018-03-30 12:00:00', 1, 1446, 1447);
INSERT INTO `base_region` VALUES ('1100107', '小店区', '山西-太原-小店区', 1100107, '1100101', 1, NULL, '2018-03-30 12:00:00', 1, 1448, 1449);
INSERT INTO `base_region` VALUES ('1100108', '迎泽', '山西-太原-迎泽', 1100108, '1100101', 1, NULL, '2018-03-30 12:00:00', 1, 1450, 1451);
INSERT INTO `base_region` VALUES ('1100109', '杏花岭', '山西-太原-杏花岭', 1100109, '1100101', 1, NULL, '2018-03-30 12:00:00', 1, 1452, 1453);
INSERT INTO `base_region` VALUES ('1100110', '万柏林', '山西-太原-万柏林', 1100110, '1100101', 1, NULL, '2018-03-30 12:00:00', 1, 1454, 1455);
INSERT INTO `base_region` VALUES ('1100111', '晋源', '山西-太原-晋源', 1100111, '1100101', 1, NULL, '2018-03-30 12:00:00', 1, 1456, 1457);
INSERT INTO `base_region` VALUES ('1100201', '大同', '山西-大同', 1100201, '1100000', 0, NULL, '2018-03-30 12:00:00', 1, 1459, 1480);
INSERT INTO `base_region` VALUES ('1100202', '阳高', '山西-大同-阳高', 1100202, '1100201', 1, NULL, '2018-03-30 12:00:00', 1, 1460, 1461);
INSERT INTO `base_region` VALUES ('1100203', '大同县', '山西-大同-大同县', 1100203, '1100201', 1, NULL, '2018-03-30 12:00:00', 1, 1462, 1463);
INSERT INTO `base_region` VALUES ('1100204', '天镇', '山西-大同-天镇', 1100204, '1100201', 1, NULL, '2018-03-30 12:00:00', 1, 1464, 1465);
INSERT INTO `base_region` VALUES ('1100205', '广灵', '山西-大同-广灵', 1100205, '1100201', 1, NULL, '2018-03-30 12:00:00', 1, 1466, 1467);
INSERT INTO `base_region` VALUES ('1100206', '灵丘', '山西-大同-灵丘', 1100206, '1100201', 1, NULL, '2018-03-30 12:00:00', 1, 1468, 1469);
INSERT INTO `base_region` VALUES ('1100207', '浑源', '山西-大同-浑源', 1100207, '1100201', 1, NULL, '2018-03-30 12:00:00', 1, 1470, 1471);
INSERT INTO `base_region` VALUES ('1100208', '左云', '山西-大同-左云', 1100208, '1100201', 1, NULL, '2018-03-30 12:00:00', 1, 1472, 1473);
INSERT INTO `base_region` VALUES ('1100209', '矿区', '山西-大同-矿区', 1100209, '1100201', 1, NULL, '2018-03-30 12:00:00', 1, 1474, 1475);
INSERT INTO `base_region` VALUES ('1100210', '南郊', '山西-大同-南郊', 1100210, '1100201', 1, NULL, '2018-03-30 12:00:00', 1, 1476, 1477);
INSERT INTO `base_region` VALUES ('1100211', '新荣', '山西-大同-新荣', 1100211, '1100201', 1, NULL, '2018-03-30 12:00:00', 1, 1478, 1479);
INSERT INTO `base_region` VALUES ('1100301', '阳泉', '山西-阳泉', 1100301, '1100000', 0, NULL, '2018-03-30 12:00:00', 1, 1481, 1490);
INSERT INTO `base_region` VALUES ('1100302', '盂县', '山西-阳泉-盂县', 1100302, '1100301', 1, NULL, '2018-03-30 12:00:00', 1, 1482, 1483);
INSERT INTO `base_region` VALUES ('1100303', '平定', '山西-阳泉-平定', 1100303, '1100301', 1, NULL, '2018-03-30 12:00:00', 1, 1484, 1485);
INSERT INTO `base_region` VALUES ('1100304', '矿区', '山西-阳泉-矿区', 1100304, '1100301', 1, NULL, '2018-03-30 12:00:00', 1, 1486, 1487);
INSERT INTO `base_region` VALUES ('1100305', '郊区', '山西-阳泉-郊区', 1100305, '1100301', 1, NULL, '2018-03-30 12:00:00', 1, 1488, 1489);
INSERT INTO `base_region` VALUES ('1100401', '晋中', '山西-晋中', 1100401, '1100000', 0, NULL, '2018-03-30 12:00:00', 1, 1491, 1514);
INSERT INTO `base_region` VALUES ('1100402', '榆次', '山西-晋中-榆次', 1100402, '1100401', 1, NULL, '2018-03-30 12:00:00', 1, 1492, 1493);
INSERT INTO `base_region` VALUES ('1100403', '榆社', '山西-晋中-榆社', 1100403, '1100401', 1, NULL, '2018-03-30 12:00:00', 1, 1494, 1495);
INSERT INTO `base_region` VALUES ('1100404', '左权', '山西-晋中-左权', 1100404, '1100401', 1, NULL, '2018-03-30 12:00:00', 1, 1496, 1497);
INSERT INTO `base_region` VALUES ('1100405', '和顺', '山西-晋中-和顺', 1100405, '1100401', 1, NULL, '2018-03-30 12:00:00', 1, 1498, 1499);
INSERT INTO `base_region` VALUES ('1100406', '昔阳', '山西-晋中-昔阳', 1100406, '1100401', 1, NULL, '2018-03-30 12:00:00', 1, 1500, 1501);
INSERT INTO `base_region` VALUES ('1100407', '寿阳', '山西-晋中-寿阳', 1100407, '1100401', 1, NULL, '2018-03-30 12:00:00', 1, 1502, 1503);
INSERT INTO `base_region` VALUES ('1100408', '太谷', '山西-晋中-太谷', 1100408, '1100401', 1, NULL, '2018-03-30 12:00:00', 1, 1504, 1505);
INSERT INTO `base_region` VALUES ('1100409', '祁县', '山西-晋中-祁县', 1100409, '1100401', 1, NULL, '2018-03-30 12:00:00', 1, 1506, 1507);
INSERT INTO `base_region` VALUES ('1100410', '平遥', '山西-晋中-平遥', 1100410, '1100401', 1, NULL, '2018-03-30 12:00:00', 1, 1508, 1509);
INSERT INTO `base_region` VALUES ('1100411', '灵石', '山西-晋中-灵石', 1100411, '1100401', 1, NULL, '2018-03-30 12:00:00', 1, 1510, 1511);
INSERT INTO `base_region` VALUES ('1100412', '介休', '山西-晋中-介休', 1100412, '1100401', 1, NULL, '2018-03-30 12:00:00', 1, 1512, 1513);
INSERT INTO `base_region` VALUES ('1100501', '长治', '山西-长治', 1100501, '1100000', 0, NULL, '2018-03-30 12:00:00', 1, 1515, 1538);
INSERT INTO `base_region` VALUES ('1100502', '黎城', '山西-长治-黎城', 1100502, '1100501', 1, NULL, '2018-03-30 12:00:00', 1, 1516, 1517);
INSERT INTO `base_region` VALUES ('1100503', '屯留', '山西-长治-屯留', 1100503, '1100501', 1, NULL, '2018-03-30 12:00:00', 1, 1518, 1519);
INSERT INTO `base_region` VALUES ('1100504', '潞城', '山西-长治-潞城', 1100504, '1100501', 1, NULL, '2018-03-30 12:00:00', 1, 1520, 1521);
INSERT INTO `base_region` VALUES ('1100505', '襄垣', '山西-长治-襄垣', 1100505, '1100501', 1, NULL, '2018-03-30 12:00:00', 1, 1522, 1523);
INSERT INTO `base_region` VALUES ('1100506', '平顺', '山西-长治-平顺', 1100506, '1100501', 1, NULL, '2018-03-30 12:00:00', 1, 1524, 1525);
INSERT INTO `base_region` VALUES ('1100507', '武乡', '山西-长治-武乡', 1100507, '1100501', 1, NULL, '2018-03-30 12:00:00', 1, 1526, 1527);
INSERT INTO `base_region` VALUES ('1100508', '沁县', '山西-长治-沁县', 1100508, '1100501', 1, NULL, '2018-03-30 12:00:00', 1, 1528, 1529);
INSERT INTO `base_region` VALUES ('1100509', '长子', '山西-长治-长子', 1100509, '1100501', 1, NULL, '2018-03-30 12:00:00', 1, 1530, 1531);
INSERT INTO `base_region` VALUES ('1100510', '沁源', '山西-长治-沁源', 1100510, '1100501', 1, NULL, '2018-03-30 12:00:00', 1, 1532, 1533);
INSERT INTO `base_region` VALUES ('1100511', '壶关', '山西-长治-壶关', 1100511, '1100501', 1, NULL, '2018-03-30 12:00:00', 1, 1534, 1535);
INSERT INTO `base_region` VALUES ('1100512', '郊区', '山西-长治-郊区', 1100512, '1100501', 1, NULL, '2018-03-30 12:00:00', 1, 1536, 1537);
INSERT INTO `base_region` VALUES ('1100601', '晋城', '山西-晋城', 1100601, '1100000', 0, NULL, '2018-03-30 12:00:00', 1, 1539, 1550);
INSERT INTO `base_region` VALUES ('1100602', '沁水', '山西-晋城-沁水', 1100602, '1100601', 1, NULL, '2018-03-30 12:00:00', 1, 1540, 1541);
INSERT INTO `base_region` VALUES ('1100603', '阳城', '山西-晋城-阳城', 1100603, '1100601', 1, NULL, '2018-03-30 12:00:00', 1, 1542, 1543);
INSERT INTO `base_region` VALUES ('1100604', '陵川', '山西-晋城-陵川', 1100604, '1100601', 1, NULL, '2018-03-30 12:00:00', 1, 1544, 1545);
INSERT INTO `base_region` VALUES ('1100605', '高平', '山西-晋城-高平', 1100605, '1100601', 1, NULL, '2018-03-30 12:00:00', 1, 1546, 1547);
INSERT INTO `base_region` VALUES ('1100606', '泽州', '山西-晋城-泽州', 1100606, '1100601', 1, NULL, '2018-03-30 12:00:00', 1, 1548, 1549);
INSERT INTO `base_region` VALUES ('1100701', '临汾', '山西-临汾', 1100701, '1100000', 0, NULL, '2018-03-30 12:00:00', 1, 1551, 1586);
INSERT INTO `base_region` VALUES ('1100702', '曲沃', '山西-临汾-曲沃', 1100702, '1100701', 1, NULL, '2018-03-30 12:00:00', 1, 1552, 1553);
INSERT INTO `base_region` VALUES ('1100703', '永和', '山西-临汾-永和', 1100703, '1100701', 1, NULL, '2018-03-30 12:00:00', 1, 1554, 1555);
INSERT INTO `base_region` VALUES ('1100704', '隰县', '山西-临汾-隰县', 1100704, '1100701', 1, NULL, '2018-03-30 12:00:00', 1, 1556, 1557);
INSERT INTO `base_region` VALUES ('1100705', '大宁', '山西-临汾-大宁', 1100705, '1100701', 1, NULL, '2018-03-30 12:00:00', 1, 1558, 1559);
INSERT INTO `base_region` VALUES ('1100706', '吉县', '山西-临汾-吉县', 1100706, '1100701', 1, NULL, '2018-03-30 12:00:00', 1, 1560, 1561);
INSERT INTO `base_region` VALUES ('1100707', '襄汾', '山西-临汾-襄汾', 1100707, '1100701', 1, NULL, '2018-03-30 12:00:00', 1, 1562, 1563);
INSERT INTO `base_region` VALUES ('1100708', '蒲县', '山西-临汾-蒲县', 1100708, '1100701', 1, NULL, '2018-03-30 12:00:00', 1, 1564, 1565);
INSERT INTO `base_region` VALUES ('1100709', '汾西', '山西-临汾-汾西', 1100709, '1100701', 1, NULL, '2018-03-30 12:00:00', 1, 1566, 1567);
INSERT INTO `base_region` VALUES ('1100710', '洪洞', '山西-临汾-洪洞', 1100710, '1100701', 1, NULL, '2018-03-30 12:00:00', 1, 1568, 1569);
INSERT INTO `base_region` VALUES ('1100711', '霍州', '山西-临汾-霍州', 1100711, '1100701', 1, NULL, '2018-03-30 12:00:00', 1, 1570, 1571);
INSERT INTO `base_region` VALUES ('1100712', '乡宁', '山西-临汾-乡宁', 1100712, '1100701', 1, NULL, '2018-03-30 12:00:00', 1, 1572, 1573);
INSERT INTO `base_region` VALUES ('1100713', '翼城', '山西-临汾-翼城', 1100713, '1100701', 1, NULL, '2018-03-30 12:00:00', 1, 1574, 1575);
INSERT INTO `base_region` VALUES ('1100714', '侯马', '山西-临汾-侯马', 1100714, '1100701', 1, NULL, '2018-03-30 12:00:00', 1, 1576, 1577);
INSERT INTO `base_region` VALUES ('1100715', '浮山', '山西-临汾-浮山', 1100715, '1100701', 1, NULL, '2018-03-30 12:00:00', 1, 1578, 1579);
INSERT INTO `base_region` VALUES ('1100716', '安泽', '山西-临汾-安泽', 1100716, '1100701', 1, NULL, '2018-03-30 12:00:00', 1, 1580, 1581);
INSERT INTO `base_region` VALUES ('1100717', '古县', '山西-临汾-古县', 1100717, '1100701', 1, NULL, '2018-03-30 12:00:00', 1, 1582, 1583);
INSERT INTO `base_region` VALUES ('1100718', '尧都', '山西-临汾-尧都', 1100718, '1100701', 1, NULL, '2018-03-30 12:00:00', 1, 1584, 1585);
INSERT INTO `base_region` VALUES ('1100801', '运城', '山西-运城', 1100801, '1100000', 0, NULL, '2018-03-30 12:00:00', 1, 1587, 1614);
INSERT INTO `base_region` VALUES ('1100802', '临猗', '山西-运城-临猗', 1100802, '1100801', 1, NULL, '2018-03-30 12:00:00', 1, 1588, 1589);
INSERT INTO `base_region` VALUES ('1100803', '稷山', '山西-运城-稷山', 1100803, '1100801', 1, NULL, '2018-03-30 12:00:00', 1, 1590, 1591);
INSERT INTO `base_region` VALUES ('1100804', '万荣', '山西-运城-万荣', 1100804, '1100801', 1, NULL, '2018-03-30 12:00:00', 1, 1592, 1593);
INSERT INTO `base_region` VALUES ('1100805', '河津', '山西-运城-河津', 1100805, '1100801', 1, NULL, '2018-03-30 12:00:00', 1, 1594, 1595);
INSERT INTO `base_region` VALUES ('1100806', '新绛', '山西-运城-新绛', 1100806, '1100801', 1, NULL, '2018-03-30 12:00:00', 1, 1596, 1597);
INSERT INTO `base_region` VALUES ('1100807', '绛县', '山西-运城-绛县', 1100807, '1100801', 1, NULL, '2018-03-30 12:00:00', 1, 1598, 1599);
INSERT INTO `base_region` VALUES ('1100808', '闻喜', '山西-运城-闻喜', 1100808, '1100801', 1, NULL, '2018-03-30 12:00:00', 1, 1600, 1601);
INSERT INTO `base_region` VALUES ('1100809', '垣曲', '山西-运城-垣曲', 1100809, '1100801', 1, NULL, '2018-03-30 12:00:00', 1, 1602, 1603);
INSERT INTO `base_region` VALUES ('1100810', '永济', '山西-运城-永济', 1100810, '1100801', 1, NULL, '2018-03-30 12:00:00', 1, 1604, 1605);
INSERT INTO `base_region` VALUES ('1100811', '芮城', '山西-运城-芮城', 1100811, '1100801', 1, NULL, '2018-03-30 12:00:00', 1, 1606, 1607);
INSERT INTO `base_region` VALUES ('1100812', '夏县', '山西-运城-夏县', 1100812, '1100801', 1, NULL, '2018-03-30 12:00:00', 1, 1608, 1609);
INSERT INTO `base_region` VALUES ('1100813', '平陆', '山西-运城-平陆', 1100813, '1100801', 1, NULL, '2018-03-30 12:00:00', 1, 1610, 1611);
INSERT INTO `base_region` VALUES ('1100814', '盐湖', '山西-运城-盐湖', 1100814, '1100801', 1, NULL, '2018-03-30 12:00:00', 1, 1612, 1613);
INSERT INTO `base_region` VALUES ('1100901', '朔州', '山西-朔州', 1100901, '1100000', 0, NULL, '2018-03-30 12:00:00', 1, 1615, 1628);
INSERT INTO `base_region` VALUES ('1100902', '平鲁', '山西-朔州-平鲁', 1100902, '1100901', 1, NULL, '2018-03-30 12:00:00', 1, 1616, 1617);
INSERT INTO `base_region` VALUES ('1100903', '山阴', '山西-朔州-山阴', 1100903, '1100901', 1, NULL, '2018-03-30 12:00:00', 1, 1618, 1619);
INSERT INTO `base_region` VALUES ('1100904', '右玉', '山西-朔州-右玉', 1100904, '1100901', 1, NULL, '2018-03-30 12:00:00', 1, 1620, 1621);
INSERT INTO `base_region` VALUES ('1100905', '应县', '山西-朔州-应县', 1100905, '1100901', 1, NULL, '2018-03-30 12:00:00', 1, 1622, 1623);
INSERT INTO `base_region` VALUES ('1100906', '怀仁', '山西-朔州-怀仁', 1100906, '1100901', 1, NULL, '2018-03-30 12:00:00', 1, 1624, 1625);
INSERT INTO `base_region` VALUES ('1100907', '朔城', '山西-朔州-朔城', 1100907, '1100901', 1, NULL, '2018-03-30 12:00:00', 1, 1626, 1627);
INSERT INTO `base_region` VALUES ('1101001', '忻州', '山西-忻州', 1101001, '1100000', 0, NULL, '2018-03-30 12:00:00', 1, 1629, 1658);
INSERT INTO `base_region` VALUES ('1101002', '定襄', '山西-忻州-定襄', 1101002, '1101001', 1, NULL, '2018-03-30 12:00:00', 1, 1630, 1631);
INSERT INTO `base_region` VALUES ('1101003', '五台县', '山西-忻州-五台县', 1101003, '1101001', 1, NULL, '2018-03-30 12:00:00', 1, 1632, 1633);
INSERT INTO `base_region` VALUES ('1101004', '河曲', '山西-忻州-河曲', 1101004, '1101001', 1, NULL, '2018-03-30 12:00:00', 1, 1634, 1635);
INSERT INTO `base_region` VALUES ('1101005', '偏关', '山西-忻州-偏关', 1101005, '1101001', 1, NULL, '2018-03-30 12:00:00', 1, 1636, 1637);
INSERT INTO `base_region` VALUES ('1101006', '神池', '山西-忻州-神池', 1101006, '1101001', 1, NULL, '2018-03-30 12:00:00', 1, 1638, 1639);
INSERT INTO `base_region` VALUES ('1101007', '宁武', '山西-忻州-宁武', 1101007, '1101001', 1, NULL, '2018-03-30 12:00:00', 1, 1640, 1641);
INSERT INTO `base_region` VALUES ('1101008', '代县', '山西-忻州-代县', 1101008, '1101001', 1, NULL, '2018-03-30 12:00:00', 1, 1642, 1643);
INSERT INTO `base_region` VALUES ('1101009', '繁峙', '山西-忻州-繁峙', 1101009, '1101001', 1, NULL, '2018-03-30 12:00:00', 1, 1644, 1645);
INSERT INTO `base_region` VALUES ('1101011', '保德', '山西-忻州-保德', 1101011, '1101001', 1, NULL, '2018-03-30 12:00:00', 1, 1646, 1647);
INSERT INTO `base_region` VALUES ('1101012', '静乐', '山西-忻州-静乐', 1101012, '1101001', 1, NULL, '2018-03-30 12:00:00', 1, 1648, 1649);
INSERT INTO `base_region` VALUES ('1101013', '岢岚', '山西-忻州-岢岚', 1101013, '1101001', 1, NULL, '2018-03-30 12:00:00', 1, 1650, 1651);
INSERT INTO `base_region` VALUES ('1101014', '五寨', '山西-忻州-五寨', 1101014, '1101001', 1, NULL, '2018-03-30 12:00:00', 1, 1652, 1653);
INSERT INTO `base_region` VALUES ('1101015', '原平', '山西-忻州-原平', 1101015, '1101001', 1, NULL, '2018-03-30 12:00:00', 1, 1654, 1655);
INSERT INTO `base_region` VALUES ('1101016', '忻府', '山西-忻州-忻府', 1101016, '1101001', 1, NULL, '2018-03-30 12:00:00', 1, 1656, 1657);
INSERT INTO `base_region` VALUES ('1101100', '吕梁', '山西-吕梁', 1101100, '1100000', 0, NULL, '2018-03-30 12:00:00', 1, 1659, 1686);
INSERT INTO `base_region` VALUES ('1101101', '离石', '山西-吕梁-离石', 1101101, '1101100', 1, NULL, '2018-03-30 12:00:00', 1, 1660, 1661);
INSERT INTO `base_region` VALUES ('1101102', '临县', '山西-吕梁-临县', 1101102, '1101100', 1, NULL, '2018-03-30 12:00:00', 1, 1662, 1663);
INSERT INTO `base_region` VALUES ('1101103', '兴县', '山西-吕梁-兴县', 1101103, '1101100', 1, NULL, '2018-03-30 12:00:00', 1, 1664, 1665);
INSERT INTO `base_region` VALUES ('1101104', '岚县', '山西-吕梁-岚县', 1101104, '1101100', 1, NULL, '2018-03-30 12:00:00', 1, 1666, 1667);
INSERT INTO `base_region` VALUES ('1101105', '柳林', '山西-吕梁-柳林', 1101105, '1101100', 1, NULL, '2018-03-30 12:00:00', 1, 1668, 1669);
INSERT INTO `base_region` VALUES ('1101106', '石楼', '山西-吕梁-石楼', 1101106, '1101100', 1, NULL, '2018-03-30 12:00:00', 1, 1670, 1671);
INSERT INTO `base_region` VALUES ('1101107', '方山', '山西-吕梁-方山', 1101107, '1101100', 1, NULL, '2018-03-30 12:00:00', 1, 1672, 1673);
INSERT INTO `base_region` VALUES ('1101108', '交口', '山西-吕梁-交口', 1101108, '1101100', 1, NULL, '2018-03-30 12:00:00', 1, 1674, 1675);
INSERT INTO `base_region` VALUES ('1101109', '中阳', '山西-吕梁-中阳', 1101109, '1101100', 1, NULL, '2018-03-30 12:00:00', 1, 1676, 1677);
INSERT INTO `base_region` VALUES ('1101110', '孝义', '山西-吕梁-孝义', 1101110, '1101100', 1, NULL, '2018-03-30 12:00:00', 1, 1678, 1679);
INSERT INTO `base_region` VALUES ('1101111', '汾阳', '山西-吕梁-汾阳', 1101111, '1101100', 1, NULL, '2018-03-30 12:00:00', 1, 1680, 1681);
INSERT INTO `base_region` VALUES ('1101112', '文水', '山西-吕梁-文水', 1101112, '1101100', 1, NULL, '2018-03-30 12:00:00', 1, 1682, 1683);
INSERT INTO `base_region` VALUES ('1101113', '交城', '山西-吕梁-交城', 1101113, '1101100', 1, NULL, '2018-03-30 12:00:00', 1, 1684, 1685);
INSERT INTO `base_region` VALUES ('1110000', '陕西', '陕西', 1110000, 'ROOT', 0, NULL, '2018-03-30 12:00:00', 1, 1688, 1927);
INSERT INTO `base_region` VALUES ('1110101', '西安', '陕西-西安', 1110101, '1110000', 0, NULL, '2018-03-30 12:00:00', 1, 1689, 1716);
INSERT INTO `base_region` VALUES ('1110102', '长安', '陕西-西安-长安', 1110102, '1110101', 1, NULL, '2018-03-30 12:00:00', 1, 1690, 1691);
INSERT INTO `base_region` VALUES ('1110103', '临潼', '陕西-西安-临潼', 1110103, '1110101', 1, NULL, '2018-03-30 12:00:00', 1, 1692, 1693);
INSERT INTO `base_region` VALUES ('1110104', '蓝田', '陕西-西安-蓝田', 1110104, '1110101', 1, NULL, '2018-03-30 12:00:00', 1, 1694, 1695);
INSERT INTO `base_region` VALUES ('1110105', '周至', '陕西-西安-周至', 1110105, '1110101', 1, NULL, '2018-03-30 12:00:00', 1, 1696, 1697);
INSERT INTO `base_region` VALUES ('1110106', '户县', '陕西-西安-户县', 1110106, '1110101', 1, NULL, '2018-03-30 12:00:00', 1, 1698, 1699);
INSERT INTO `base_region` VALUES ('1110107', '高陵', '陕西-西安-高陵', 1110107, '1110101', 1, NULL, '2018-03-30 12:00:00', 1, 1700, 1701);
INSERT INTO `base_region` VALUES ('1110108', '新城', '陕西-西安-新城', 1110108, '1110101', 1, NULL, '2018-03-30 12:00:00', 1, 1702, 1703);
INSERT INTO `base_region` VALUES ('1110109', '碑林', '陕西-西安-碑林', 1110109, '1110101', 1, NULL, '2018-03-30 12:00:00', 1, 1704, 1705);
INSERT INTO `base_region` VALUES ('1110110', '莲湖', '陕西-西安-莲湖', 1110110, '1110101', 1, NULL, '2018-03-30 12:00:00', 1, 1706, 1707);
INSERT INTO `base_region` VALUES ('1110111', '灞桥', '陕西-西安-灞桥', 1110111, '1110101', 1, NULL, '2018-03-30 12:00:00', 1, 1708, 1709);
INSERT INTO `base_region` VALUES ('1110112', '未央', '陕西-西安-未央', 1110112, '1110101', 1, NULL, '2018-03-30 12:00:00', 1, 1710, 1711);
INSERT INTO `base_region` VALUES ('1110113', '雁塔', '陕西-西安-雁塔', 1110113, '1110101', 1, NULL, '2018-03-30 12:00:00', 1, 1712, 1713);
INSERT INTO `base_region` VALUES ('1110114', '阎良', '陕西-西安-阎良', 1110114, '1110101', 1, NULL, '2018-03-30 12:00:00', 1, 1714, 1715);
INSERT INTO `base_region` VALUES ('1110200', '咸阳', '陕西-咸阳', 1110200, '1110000', 0, NULL, '2018-03-30 12:00:00', 1, 1717, 1744);
INSERT INTO `base_region` VALUES ('1110201', '三原', '陕西-咸阳-三原', 1110201, '1110200', 1, NULL, '2018-03-30 12:00:00', 1, 1718, 1719);
INSERT INTO `base_region` VALUES ('1110202', '礼泉', '陕西-咸阳-礼泉', 1110202, '1110200', 1, NULL, '2018-03-30 12:00:00', 1, 1720, 1721);
INSERT INTO `base_region` VALUES ('1110203', '永寿', '陕西-咸阳-永寿', 1110203, '1110200', 1, NULL, '2018-03-30 12:00:00', 1, 1722, 1723);
INSERT INTO `base_region` VALUES ('1110204', '淳化', '陕西-咸阳-淳化', 1110204, '1110200', 1, NULL, '2018-03-30 12:00:00', 1, 1724, 1725);
INSERT INTO `base_region` VALUES ('1110205', '泾阳', '陕西-咸阳-泾阳', 1110205, '1110200', 1, NULL, '2018-03-30 12:00:00', 1, 1726, 1727);
INSERT INTO `base_region` VALUES ('1110206', '武功', '陕西-咸阳-武功', 1110206, '1110200', 1, NULL, '2018-03-30 12:00:00', 1, 1728, 1729);
INSERT INTO `base_region` VALUES ('1110207', '乾县', '陕西-咸阳-乾县', 1110207, '1110200', 1, NULL, '2018-03-30 12:00:00', 1, 1730, 1731);
INSERT INTO `base_region` VALUES ('1110208', '彬县', '陕西-咸阳-彬县', 1110208, '1110200', 1, NULL, '2018-03-30 12:00:00', 1, 1732, 1733);
INSERT INTO `base_region` VALUES ('1110209', '长武', '陕西-咸阳-长武', 1110209, '1110200', 1, NULL, '2018-03-30 12:00:00', 1, 1734, 1735);
INSERT INTO `base_region` VALUES ('1110210', '旬邑', '陕西-咸阳-旬邑', 1110210, '1110200', 1, NULL, '2018-03-30 12:00:00', 1, 1736, 1737);
INSERT INTO `base_region` VALUES ('1110211', '兴平', '陕西-咸阳-兴平', 1110211, '1110200', 1, NULL, '2018-03-30 12:00:00', 1, 1738, 1739);
INSERT INTO `base_region` VALUES ('1110212', '秦都', '陕西-咸阳-秦都', 1110212, '1110200', 1, NULL, '2018-03-30 12:00:00', 1, 1740, 1741);
INSERT INTO `base_region` VALUES ('1110213', '渭城', '陕西-咸阳-渭城', 1110213, '1110200', 1, NULL, '2018-03-30 12:00:00', 1, 1742, 1743);
INSERT INTO `base_region` VALUES ('1110300', '延安', '陕西-延安', 1110300, '1110000', 0, NULL, '2018-03-30 12:00:00', 1, 1745, 1772);
INSERT INTO `base_region` VALUES ('1110301', '延长', '陕西-延安-延长', 1110301, '1110300', 1, NULL, '2018-03-30 12:00:00', 1, 1746, 1747);
INSERT INTO `base_region` VALUES ('1110302', '延川', '陕西-延安-延川', 1110302, '1110300', 1, NULL, '2018-03-30 12:00:00', 1, 1748, 1749);
INSERT INTO `base_region` VALUES ('1110303', '子长', '陕西-延安-子长', 1110303, '1110300', 1, NULL, '2018-03-30 12:00:00', 1, 1750, 1751);
INSERT INTO `base_region` VALUES ('1110304', '宜川', '陕西-延安-宜川', 1110304, '1110300', 1, NULL, '2018-03-30 12:00:00', 1, 1752, 1753);
INSERT INTO `base_region` VALUES ('1110305', '富县', '陕西-延安-富县', 1110305, '1110300', 1, NULL, '2018-03-30 12:00:00', 1, 1754, 1755);
INSERT INTO `base_region` VALUES ('1110306', '志丹', '陕西-延安-志丹', 1110306, '1110300', 1, NULL, '2018-03-30 12:00:00', 1, 1756, 1757);
INSERT INTO `base_region` VALUES ('1110307', '安塞', '陕西-延安-安塞', 1110307, '1110300', 1, NULL, '2018-03-30 12:00:00', 1, 1758, 1759);
INSERT INTO `base_region` VALUES ('1110308', '甘泉', '陕西-延安-甘泉', 1110308, '1110300', 1, NULL, '2018-03-30 12:00:00', 1, 1760, 1761);
INSERT INTO `base_region` VALUES ('1110309', '洛川', '陕西-延安-洛川', 1110309, '1110300', 1, NULL, '2018-03-30 12:00:00', 1, 1762, 1763);
INSERT INTO `base_region` VALUES ('1110310', '黄陵', '陕西-延安-黄陵', 1110310, '1110300', 1, NULL, '2018-03-30 12:00:00', 1, 1764, 1765);
INSERT INTO `base_region` VALUES ('1110311', '黄龙', '陕西-延安-黄龙', 1110311, '1110300', 1, NULL, '2018-03-30 12:00:00', 1, 1766, 1767);
INSERT INTO `base_region` VALUES ('1110312', '吴起', '陕西-延安-吴起', 1110312, '1110300', 1, NULL, '2018-03-30 12:00:00', 1, 1768, 1769);
INSERT INTO `base_region` VALUES ('1110313', '宝塔', '陕西-延安-宝塔', 1110313, '1110300', 1, NULL, '2018-03-30 12:00:00', 1, 1770, 1771);
INSERT INTO `base_region` VALUES ('1110401', '榆林', '陕西-榆林', 1110401, '1110000', 0, NULL, '2018-03-30 12:00:00', 1, 1773, 1798);
INSERT INTO `base_region` VALUES ('1110402', '府谷', '陕西-榆林-府谷', 1110402, '1110401', 1, NULL, '2018-03-30 12:00:00', 1, 1774, 1775);
INSERT INTO `base_region` VALUES ('1110403', '神木', '陕西-榆林-神木', 1110403, '1110401', 1, NULL, '2018-03-30 12:00:00', 1, 1776, 1777);
INSERT INTO `base_region` VALUES ('1110404', '佳县', '陕西-榆林-佳县', 1110404, '1110401', 1, NULL, '2018-03-30 12:00:00', 1, 1778, 1779);
INSERT INTO `base_region` VALUES ('1110405', '定边', '陕西-榆林-定边', 1110405, '1110401', 1, NULL, '2018-03-30 12:00:00', 1, 1780, 1781);
INSERT INTO `base_region` VALUES ('1110406', '靖边', '陕西-榆林-靖边', 1110406, '1110401', 1, NULL, '2018-03-30 12:00:00', 1, 1782, 1783);
INSERT INTO `base_region` VALUES ('1110407', '横山', '陕西-榆林-横山', 1110407, '1110401', 1, NULL, '2018-03-30 12:00:00', 1, 1784, 1785);
INSERT INTO `base_region` VALUES ('1110408', '米脂', '陕西-榆林-米脂', 1110408, '1110401', 1, NULL, '2018-03-30 12:00:00', 1, 1786, 1787);
INSERT INTO `base_region` VALUES ('1110409', '子洲', '陕西-榆林-子洲', 1110409, '1110401', 1, NULL, '2018-03-30 12:00:00', 1, 1788, 1789);
INSERT INTO `base_region` VALUES ('1110410', '绥德', '陕西-榆林-绥德', 1110410, '1110401', 1, NULL, '2018-03-30 12:00:00', 1, 1790, 1791);
INSERT INTO `base_region` VALUES ('1110411', '吴堡', '陕西-榆林-吴堡', 1110411, '1110401', 1, NULL, '2018-03-30 12:00:00', 1, 1792, 1793);
INSERT INTO `base_region` VALUES ('1110412', '清涧', '陕西-榆林-清涧', 1110412, '1110401', 1, NULL, '2018-03-30 12:00:00', 1, 1794, 1795);
INSERT INTO `base_region` VALUES ('1110413', '榆阳', '陕西-榆林-榆阳', 1110413, '1110401', 1, NULL, '2018-03-30 12:00:00', 1, 1796, 1797);
INSERT INTO `base_region` VALUES ('1110501', '渭南', '陕西-渭南', 1110501, '1110000', 0, NULL, '2018-03-30 12:00:00', 1, 1799, 1824);
INSERT INTO `base_region` VALUES ('1110502', '华县', '陕西-渭南-华县', 1110502, '1110501', 1, NULL, '2018-03-30 12:00:00', 1, 1800, 1801);
INSERT INTO `base_region` VALUES ('1110503', '潼关', '陕西-渭南-潼关', 1110503, '1110501', 1, NULL, '2018-03-30 12:00:00', 1, 1802, 1803);
INSERT INTO `base_region` VALUES ('1110504', '大荔', '陕西-渭南-大荔', 1110504, '1110501', 1, NULL, '2018-03-30 12:00:00', 1, 1804, 1805);
INSERT INTO `base_region` VALUES ('1110505', '白水', '陕西-渭南-白水', 1110505, '1110501', 1, NULL, '2018-03-30 12:00:00', 1, 1806, 1807);
INSERT INTO `base_region` VALUES ('1110506', '富平', '陕西-渭南-富平', 1110506, '1110501', 1, NULL, '2018-03-30 12:00:00', 1, 1808, 1809);
INSERT INTO `base_region` VALUES ('1110507', '蒲城', '陕西-渭南-蒲城', 1110507, '1110501', 1, NULL, '2018-03-30 12:00:00', 1, 1810, 1811);
INSERT INTO `base_region` VALUES ('1110508', '澄城', '陕西-渭南-澄城', 1110508, '1110501', 1, NULL, '2018-03-30 12:00:00', 1, 1812, 1813);
INSERT INTO `base_region` VALUES ('1110509', '合阳', '陕西-渭南-合阳', 1110509, '1110501', 1, NULL, '2018-03-30 12:00:00', 1, 1814, 1815);
INSERT INTO `base_region` VALUES ('1110510', '韩城', '陕西-渭南-韩城', 1110510, '1110501', 1, NULL, '2018-03-30 12:00:00', 1, 1816, 1817);
INSERT INTO `base_region` VALUES ('1110511', '华阴', '陕西-渭南-华阴', 1110511, '1110501', 1, NULL, '2018-03-30 12:00:00', 1, 1818, 1819);
INSERT INTO `base_region` VALUES ('1110512', '临渭', '陕西-渭南-临渭', 1110512, '1110501', 1, NULL, '2018-03-30 12:00:00', 1, 1820, 1821);
INSERT INTO `base_region` VALUES ('1110513', '华州', '陕西-渭南-华州', 1110513, '1110501', 1, NULL, '2018-03-30 12:00:00', 1, 1822, 1823);
INSERT INTO `base_region` VALUES ('1110601', '商洛', '陕西-商洛', 1110601, '1110000', 0, NULL, '2018-03-30 12:00:00', 1, 1825, 1840);
INSERT INTO `base_region` VALUES ('1110602', '洛南', '陕西-商洛-洛南', 1110602, '1110601', 1, NULL, '2018-03-30 12:00:00', 1, 1826, 1827);
INSERT INTO `base_region` VALUES ('1110603', '柞水', '陕西-商洛-柞水', 1110603, '1110601', 1, NULL, '2018-03-30 12:00:00', 1, 1828, 1829);
INSERT INTO `base_region` VALUES ('1110604', '商州', '陕西-商洛-商州', 1110604, '1110601', 1, NULL, '2018-03-30 12:00:00', 1, 1830, 1831);
INSERT INTO `base_region` VALUES ('1110605', '镇安', '陕西-商洛-镇安', 1110605, '1110601', 1, NULL, '2018-03-30 12:00:00', 1, 1832, 1833);
INSERT INTO `base_region` VALUES ('1110606', '丹凤', '陕西-商洛-丹凤', 1110606, '1110601', 1, NULL, '2018-03-30 12:00:00', 1, 1834, 1835);
INSERT INTO `base_region` VALUES ('1110607', '商南', '陕西-商洛-商南', 1110607, '1110601', 1, NULL, '2018-03-30 12:00:00', 1, 1836, 1837);
INSERT INTO `base_region` VALUES ('1110608', '山阳', '陕西-商洛-山阳', 1110608, '1110601', 1, NULL, '2018-03-30 12:00:00', 1, 1838, 1839);
INSERT INTO `base_region` VALUES ('1110701', '安康', '陕西-安康', 1110701, '1110000', 0, NULL, '2018-03-30 12:00:00', 1, 1841, 1862);
INSERT INTO `base_region` VALUES ('1110702', '紫阳', '陕西-安康-紫阳', 1110702, '1110701', 1, NULL, '2018-03-30 12:00:00', 1, 1842, 1843);
INSERT INTO `base_region` VALUES ('1110703', '石泉', '陕西-安康-石泉', 1110703, '1110701', 1, NULL, '2018-03-30 12:00:00', 1, 1844, 1845);
INSERT INTO `base_region` VALUES ('1110704', '汉阴', '陕西-安康-汉阴', 1110704, '1110701', 1, NULL, '2018-03-30 12:00:00', 1, 1846, 1847);
INSERT INTO `base_region` VALUES ('1110705', '旬阳', '陕西-安康-旬阳', 1110705, '1110701', 1, NULL, '2018-03-30 12:00:00', 1, 1848, 1849);
INSERT INTO `base_region` VALUES ('1110706', '岚皋', '陕西-安康-岚皋', 1110706, '1110701', 1, NULL, '2018-03-30 12:00:00', 1, 1850, 1851);
INSERT INTO `base_region` VALUES ('1110707', '平利', '陕西-安康-平利', 1110707, '1110701', 1, NULL, '2018-03-30 12:00:00', 1, 1852, 1853);
INSERT INTO `base_region` VALUES ('1110708', '白河', '陕西-安康-白河', 1110708, '1110701', 1, NULL, '2018-03-30 12:00:00', 1, 1854, 1855);
INSERT INTO `base_region` VALUES ('1110709', '镇坪', '陕西-安康-镇坪', 1110709, '1110701', 1, NULL, '2018-03-30 12:00:00', 1, 1856, 1857);
INSERT INTO `base_region` VALUES ('1110710', '宁陕', '陕西-安康-宁陕', 1110710, '1110701', 1, NULL, '2018-03-30 12:00:00', 1, 1858, 1859);
INSERT INTO `base_region` VALUES ('1110711', '汉滨', '陕西-安康-汉滨', 1110711, '1110701', 1, NULL, '2018-03-30 12:00:00', 1, 1860, 1861);
INSERT INTO `base_region` VALUES ('1110801', '汉中', '陕西-汉中', 1110801, '1110000', 0, NULL, '2018-03-30 12:00:00', 1, 1863, 1886);
INSERT INTO `base_region` VALUES ('1110802', '略阳', '陕西-汉中-略阳', 1110802, '1110801', 1, NULL, '2018-03-30 12:00:00', 1, 1864, 1865);
INSERT INTO `base_region` VALUES ('1110803', '勉县', '陕西-汉中-勉县', 1110803, '1110801', 1, NULL, '2018-03-30 12:00:00', 1, 1866, 1867);
INSERT INTO `base_region` VALUES ('1110804', '留坝', '陕西-汉中-留坝', 1110804, '1110801', 1, NULL, '2018-03-30 12:00:00', 1, 1868, 1869);
INSERT INTO `base_region` VALUES ('1110805', '洋县', '陕西-汉中-洋县', 1110805, '1110801', 1, NULL, '2018-03-30 12:00:00', 1, 1870, 1871);
INSERT INTO `base_region` VALUES ('1110806', '城固', '陕西-汉中-城固', 1110806, '1110801', 1, NULL, '2018-03-30 12:00:00', 1, 1872, 1873);
INSERT INTO `base_region` VALUES ('1110807', '西乡', '陕西-汉中-西乡', 1110807, '1110801', 1, NULL, '2018-03-30 12:00:00', 1, 1874, 1875);
INSERT INTO `base_region` VALUES ('1110808', '佛坪', '陕西-汉中-佛坪', 1110808, '1110801', 1, NULL, '2018-03-30 12:00:00', 1, 1876, 1877);
INSERT INTO `base_region` VALUES ('1110809', '宁强', '陕西-汉中-宁强', 1110809, '1110801', 1, NULL, '2018-03-30 12:00:00', 1, 1878, 1879);
INSERT INTO `base_region` VALUES ('1110810', '南郑', '陕西-汉中-南郑', 1110810, '1110801', 1, NULL, '2018-03-30 12:00:00', 1, 1880, 1881);
INSERT INTO `base_region` VALUES ('1110811', '镇巴', '陕西-汉中-镇巴', 1110811, '1110801', 1, NULL, '2018-03-30 12:00:00', 1, 1882, 1883);
INSERT INTO `base_region` VALUES ('1110812', '汉台', '陕西-汉中-汉台', 1110812, '1110801', 1, NULL, '2018-03-30 12:00:00', 1, 1884, 1885);
INSERT INTO `base_region` VALUES ('1110901', '宝鸡', '陕西-宝鸡', 1110901, '1110000', 0, NULL, '2018-03-30 12:00:00', 1, 1887, 1912);
INSERT INTO `base_region` VALUES ('1110902', '渭滨', '陕西-宝鸡-渭滨', 1110902, '1110901', 1, NULL, '2018-03-30 12:00:00', 1, 1888, 1889);
INSERT INTO `base_region` VALUES ('1110903', '千阳', '陕西-宝鸡-千阳', 1110903, '1110901', 1, NULL, '2018-03-30 12:00:00', 1, 1890, 1891);
INSERT INTO `base_region` VALUES ('1110904', '麟游', '陕西-宝鸡-麟游', 1110904, '1110901', 1, NULL, '2018-03-30 12:00:00', 1, 1892, 1893);
INSERT INTO `base_region` VALUES ('1110905', '岐山', '陕西-宝鸡-岐山', 1110905, '1110901', 1, NULL, '2018-03-30 12:00:00', 1, 1894, 1895);
INSERT INTO `base_region` VALUES ('1110906', '凤翔', '陕西-宝鸡-凤翔', 1110906, '1110901', 1, NULL, '2018-03-30 12:00:00', 1, 1896, 1897);
INSERT INTO `base_region` VALUES ('1110907', '扶风', '陕西-宝鸡-扶风', 1110907, '1110901', 1, NULL, '2018-03-30 12:00:00', 1, 1898, 1899);
INSERT INTO `base_region` VALUES ('1110908', '眉县', '陕西-宝鸡-眉县', 1110908, '1110901', 1, NULL, '2018-03-30 12:00:00', 1, 1900, 1901);
INSERT INTO `base_region` VALUES ('1110909', '太白', '陕西-宝鸡-太白', 1110909, '1110901', 1, NULL, '2018-03-30 12:00:00', 1, 1902, 1903);
INSERT INTO `base_region` VALUES ('1110910', '凤县', '陕西-宝鸡-凤县', 1110910, '1110901', 1, NULL, '2018-03-30 12:00:00', 1, 1904, 1905);
INSERT INTO `base_region` VALUES ('1110911', '陇县', '陕西-宝鸡-陇县', 1110911, '1110901', 1, NULL, '2018-03-30 12:00:00', 1, 1906, 1907);
INSERT INTO `base_region` VALUES ('1110912', '陈仓', '陕西-宝鸡-陈仓', 1110912, '1110901', 1, NULL, '2018-03-30 12:00:00', 1, 1908, 1909);
INSERT INTO `base_region` VALUES ('1110913', '金台', '陕西-宝鸡-金台', 1110913, '1110901', 1, NULL, '2018-03-30 12:00:00', 1, 1910, 1911);
INSERT INTO `base_region` VALUES ('1111001', '铜川', '陕西-铜川', 1111001, '1110000', 0, NULL, '2018-03-30 12:00:00', 1, 1913, 1922);
INSERT INTO `base_region` VALUES ('1111003', '宜君', '陕西-铜川-宜君', 1111003, '1111001', 1, NULL, '2018-03-30 12:00:00', 1, 1914, 1915);
INSERT INTO `base_region` VALUES ('1111004', '耀州', '陕西-铜川-耀州', 1111004, '1111001', 1, NULL, '2018-03-30 12:00:00', 1, 1916, 1917);
INSERT INTO `base_region` VALUES ('1111005', '王益', '陕西-铜川-王益', 1111005, '1111001', 1, NULL, '2018-03-30 12:00:00', 1, 1918, 1919);
INSERT INTO `base_region` VALUES ('1111006', '印台', '陕西-铜川-印台', 1111006, '1111001', 1, NULL, '2018-03-30 12:00:00', 1, 1920, 1921);
INSERT INTO `base_region` VALUES ('1111101', '杨凌', '陕西-杨凌', 1111101, '1110000', 0, NULL, '2018-03-30 12:00:00', 1, 1923, 1926);
INSERT INTO `base_region` VALUES ('1111102', '杨陵', '陕西-杨凌-杨陵', 1111102, '1111101', 1, NULL, '2018-03-30 12:00:00', 1, 1924, 1925);
INSERT INTO `base_region` VALUES ('1120000', '山东', '山东', 1120000, 'ROOT', 0, NULL, '2018-03-30 12:00:00', 1, 1928, 2235);
INSERT INTO `base_region` VALUES ('1120101', '济南', '山东-济南', 1120101, '1120000', 0, NULL, '2018-03-30 12:00:00', 1, 1929, 1950);
INSERT INTO `base_region` VALUES ('1120102', '长清', '山东-济南-长清', 1120102, '1120101', 1, NULL, '2018-03-30 12:00:00', 1, 1930, 1931);
INSERT INTO `base_region` VALUES ('1120103', '商河', '山东-济南-商河', 1120103, '1120101', 1, NULL, '2018-03-30 12:00:00', 1, 1932, 1933);
INSERT INTO `base_region` VALUES ('1120104', '章丘', '山东-济南-章丘', 1120104, '1120101', 1, NULL, '2018-03-30 12:00:00', 1, 1934, 1935);
INSERT INTO `base_region` VALUES ('1120105', '平阴', '山东-济南-平阴', 1120105, '1120101', 1, NULL, '2018-03-30 12:00:00', 1, 1936, 1937);
INSERT INTO `base_region` VALUES ('1120106', '济阳', '山东-济南-济阳', 1120106, '1120101', 1, NULL, '2018-03-30 12:00:00', 1, 1938, 1939);
INSERT INTO `base_region` VALUES ('1120107', '历下', '山东-济南-历下', 1120107, '1120101', 1, NULL, '2018-03-30 12:00:00', 1, 1940, 1941);
INSERT INTO `base_region` VALUES ('1120108', '市中', '山东-济南-市中', 1120108, '1120101', 1, NULL, '2018-03-30 12:00:00', 1, 1942, 1943);
INSERT INTO `base_region` VALUES ('1120109', '槐荫', '山东-济南-槐荫', 1120109, '1120101', 1, NULL, '2018-03-30 12:00:00', 1, 1944, 1945);
INSERT INTO `base_region` VALUES ('1120110', '天桥', '山东-济南-天桥', 1120110, '1120101', 1, NULL, '2018-03-30 12:00:00', 1, 1946, 1947);
INSERT INTO `base_region` VALUES ('1120111', '历城', '山东-济南-历城', 1120111, '1120101', 1, NULL, '2018-03-30 12:00:00', 1, 1948, 1949);
INSERT INTO `base_region` VALUES ('1120201', '青岛', '山东-青岛', 1120201, '1120000', 0, NULL, '2018-03-30 12:00:00', 1, 1951, 1972);
INSERT INTO `base_region` VALUES ('1120202', '崂山', '山东-青岛-崂山', 1120202, '1120201', 1, NULL, '2018-03-30 12:00:00', 1, 1952, 1953);
INSERT INTO `base_region` VALUES ('1120203', '市南', '山东-青岛-市南', 1120203, '1120201', 1, NULL, '2018-03-30 12:00:00', 1, 1954, 1955);
INSERT INTO `base_region` VALUES ('1120204', '即墨', '山东-青岛-即墨', 1120204, '1120201', 1, NULL, '2018-03-30 12:00:00', 1, 1956, 1957);
INSERT INTO `base_region` VALUES ('1120205', '胶州', '山东-青岛-胶州', 1120205, '1120201', 1, NULL, '2018-03-30 12:00:00', 1, 1958, 1959);
INSERT INTO `base_region` VALUES ('1120206', '黄岛', '山东-青岛-黄岛', 1120206, '1120201', 1, NULL, '2018-03-30 12:00:00', 1, 1960, 1961);
INSERT INTO `base_region` VALUES ('1120207', '莱西', '山东-青岛-莱西', 1120207, '1120201', 1, NULL, '2018-03-30 12:00:00', 1, 1962, 1963);
INSERT INTO `base_region` VALUES ('1120208', '平度', '山东-青岛-平度', 1120208, '1120201', 1, NULL, '2018-03-30 12:00:00', 1, 1964, 1965);
INSERT INTO `base_region` VALUES ('1120209', '市北', '山东-青岛-市北', 1120209, '1120201', 1, NULL, '2018-03-30 12:00:00', 1, 1966, 1967);
INSERT INTO `base_region` VALUES ('1120210', '李沧', '山东-青岛-李沧', 1120210, '1120201', 1, NULL, '2018-03-30 12:00:00', 1, 1968, 1969);
INSERT INTO `base_region` VALUES ('1120211', '城阳', '山东-青岛-城阳', 1120211, '1120201', 1, NULL, '2018-03-30 12:00:00', 1, 1970, 1971);
INSERT INTO `base_region` VALUES ('1120301', '淄博', '山东-淄博', 1120301, '1120000', 0, NULL, '2018-03-30 12:00:00', 1, 1973, 1990);
INSERT INTO `base_region` VALUES ('1120302', '淄川', '山东-淄博-淄川', 1120302, '1120301', 1, NULL, '2018-03-30 12:00:00', 1, 1974, 1975);
INSERT INTO `base_region` VALUES ('1120303', '博山', '山东-淄博-博山', 1120303, '1120301', 1, NULL, '2018-03-30 12:00:00', 1, 1976, 1977);
INSERT INTO `base_region` VALUES ('1120304', '高青', '山东-淄博-高青', 1120304, '1120301', 1, NULL, '2018-03-30 12:00:00', 1, 1978, 1979);
INSERT INTO `base_region` VALUES ('1120305', '周村', '山东-淄博-周村', 1120305, '1120301', 1, NULL, '2018-03-30 12:00:00', 1, 1980, 1981);
INSERT INTO `base_region` VALUES ('1120306', '沂源', '山东-淄博-沂源', 1120306, '1120301', 1, NULL, '2018-03-30 12:00:00', 1, 1982, 1983);
INSERT INTO `base_region` VALUES ('1120307', '桓台', '山东-淄博-桓台', 1120307, '1120301', 1, NULL, '2018-03-30 12:00:00', 1, 1984, 1985);
INSERT INTO `base_region` VALUES ('1120308', '临淄', '山东-淄博-临淄', 1120308, '1120301', 1, NULL, '2018-03-30 12:00:00', 1, 1986, 1987);
INSERT INTO `base_region` VALUES ('1120309', '张店', '山东-淄博-张店', 1120309, '1120301', 1, NULL, '2018-03-30 12:00:00', 1, 1988, 1989);
INSERT INTO `base_region` VALUES ('1120401', '德州', '山东-德州', 1120401, '1120000', 0, NULL, '2018-03-30 12:00:00', 1, 1991, 2014);
INSERT INTO `base_region` VALUES ('1120402', '武城', '山东-德州-武城', 1120402, '1120401', 1, NULL, '2018-03-30 12:00:00', 1, 1992, 1993);
INSERT INTO `base_region` VALUES ('1120403', '临邑', '山东-德州-临邑', 1120403, '1120401', 1, NULL, '2018-03-30 12:00:00', 1, 1994, 1995);
INSERT INTO `base_region` VALUES ('1120405', '齐河', '山东-德州-齐河', 1120405, '1120401', 1, NULL, '2018-03-30 12:00:00', 1, 1996, 1997);
INSERT INTO `base_region` VALUES ('1120406', '乐陵', '山东-德州-乐陵', 1120406, '1120401', 1, NULL, '2018-03-30 12:00:00', 1, 1998, 1999);
INSERT INTO `base_region` VALUES ('1120407', '庆云', '山东-德州-庆云', 1120407, '1120401', 1, NULL, '2018-03-30 12:00:00', 1, 2000, 2001);
INSERT INTO `base_region` VALUES ('1120408', '平原', '山东-德州-平原', 1120408, '1120401', 1, NULL, '2018-03-30 12:00:00', 1, 2002, 2003);
INSERT INTO `base_region` VALUES ('1120409', '宁津', '山东-德州-宁津', 1120409, '1120401', 1, NULL, '2018-03-30 12:00:00', 1, 2004, 2005);
INSERT INTO `base_region` VALUES ('1120410', '夏津', '山东-德州-夏津', 1120410, '1120401', 1, NULL, '2018-03-30 12:00:00', 1, 2006, 2007);
INSERT INTO `base_region` VALUES ('1120411', '禹城', '山东-德州-禹城', 1120411, '1120401', 1, NULL, '2018-03-30 12:00:00', 1, 2008, 2009);
INSERT INTO `base_region` VALUES ('1120412', '德城', '山东-德州-德城', 1120412, '1120401', 1, NULL, '2018-03-30 12:00:00', 1, 2010, 2011);
INSERT INTO `base_region` VALUES ('1120413', '陵城', '山东-德州-陵城', 1120413, '1120401', 1, NULL, '2018-03-30 12:00:00', 1, 2012, 2013);
INSERT INTO `base_region` VALUES ('1120501', '烟台', '山东-烟台', 1120501, '1120000', 0, NULL, '2018-03-30 12:00:00', 1, 2015, 2040);
INSERT INTO `base_region` VALUES ('1120502', '莱州', '山东-烟台-莱州', 1120502, '1120501', 1, NULL, '2018-03-30 12:00:00', 1, 2016, 2017);
INSERT INTO `base_region` VALUES ('1120503', '长岛', '山东-烟台-长岛', 1120503, '1120501', 1, NULL, '2018-03-30 12:00:00', 1, 2018, 2019);
INSERT INTO `base_region` VALUES ('1120504', '蓬莱', '山东-烟台-蓬莱', 1120504, '1120501', 1, NULL, '2018-03-30 12:00:00', 1, 2020, 2021);
INSERT INTO `base_region` VALUES ('1120505', '龙口', '山东-烟台-龙口', 1120505, '1120501', 1, NULL, '2018-03-30 12:00:00', 1, 2022, 2023);
INSERT INTO `base_region` VALUES ('1120506', '招远', '山东-烟台-招远', 1120506, '1120501', 1, NULL, '2018-03-30 12:00:00', 1, 2024, 2025);
INSERT INTO `base_region` VALUES ('1120507', '栖霞', '山东-烟台-栖霞', 1120507, '1120501', 1, NULL, '2018-03-30 12:00:00', 1, 2026, 2027);
INSERT INTO `base_region` VALUES ('1120508', '福山', '山东-烟台-福山', 1120508, '1120501', 1, NULL, '2018-03-30 12:00:00', 1, 2028, 2029);
INSERT INTO `base_region` VALUES ('1120509', '牟平', '山东-烟台-牟平', 1120509, '1120501', 1, NULL, '2018-03-30 12:00:00', 1, 2030, 2031);
INSERT INTO `base_region` VALUES ('1120510', '莱阳', '山东-烟台-莱阳', 1120510, '1120501', 1, NULL, '2018-03-30 12:00:00', 1, 2032, 2033);
INSERT INTO `base_region` VALUES ('1120511', '海阳', '山东-烟台-海阳', 1120511, '1120501', 1, NULL, '2018-03-30 12:00:00', 1, 2034, 2035);
INSERT INTO `base_region` VALUES ('1120512', '芝罘', '山东-烟台-芝罘', 1120512, '1120501', 1, NULL, '2018-03-30 12:00:00', 1, 2036, 2037);
INSERT INTO `base_region` VALUES ('1120513', '莱山', '山东-烟台-莱山', 1120513, '1120501', 1, NULL, '2018-03-30 12:00:00', 1, 2038, 2039);
INSERT INTO `base_region` VALUES ('1120601', '潍坊', '山东-潍坊', 1120601, '1120000', 0, NULL, '2018-03-30 12:00:00', 1, 2041, 2066);
INSERT INTO `base_region` VALUES ('1120602', '青州', '山东-潍坊-青州', 1120602, '1120601', 1, NULL, '2018-03-30 12:00:00', 1, 2042, 2043);
INSERT INTO `base_region` VALUES ('1120603', '寿光', '山东-潍坊-寿光', 1120603, '1120601', 1, NULL, '2018-03-30 12:00:00', 1, 2044, 2045);
INSERT INTO `base_region` VALUES ('1120604', '临朐', '山东-潍坊-临朐', 1120604, '1120601', 1, NULL, '2018-03-30 12:00:00', 1, 2046, 2047);
INSERT INTO `base_region` VALUES ('1120605', '昌乐', '山东-潍坊-昌乐', 1120605, '1120601', 1, NULL, '2018-03-30 12:00:00', 1, 2048, 2049);
INSERT INTO `base_region` VALUES ('1120606', '昌邑', '山东-潍坊-昌邑', 1120606, '1120601', 1, NULL, '2018-03-30 12:00:00', 1, 2050, 2051);
INSERT INTO `base_region` VALUES ('1120607', '安丘', '山东-潍坊-安丘', 1120607, '1120601', 1, NULL, '2018-03-30 12:00:00', 1, 2052, 2053);
INSERT INTO `base_region` VALUES ('1120608', '高密', '山东-潍坊-高密', 1120608, '1120601', 1, NULL, '2018-03-30 12:00:00', 1, 2054, 2055);
INSERT INTO `base_region` VALUES ('1120609', '诸城', '山东-潍坊-诸城', 1120609, '1120601', 1, NULL, '2018-03-30 12:00:00', 1, 2056, 2057);
INSERT INTO `base_region` VALUES ('1120610', '潍城', '山东-潍坊-潍城', 1120610, '1120601', 1, NULL, '2018-03-30 12:00:00', 1, 2058, 2059);
INSERT INTO `base_region` VALUES ('1120611', '寒亭', '山东-潍坊-寒亭', 1120611, '1120601', 1, NULL, '2018-03-30 12:00:00', 1, 2060, 2061);
INSERT INTO `base_region` VALUES ('1120612', '坊子', '山东-潍坊-坊子', 1120612, '1120601', 1, NULL, '2018-03-30 12:00:00', 1, 2062, 2063);
INSERT INTO `base_region` VALUES ('1120613', '奎文', '山东-潍坊-奎文', 1120613, '1120601', 1, NULL, '2018-03-30 12:00:00', 1, 2064, 2065);
INSERT INTO `base_region` VALUES ('1120701', '济宁', '山东-济宁', 1120701, '1120000', 0, NULL, '2018-03-30 12:00:00', 1, 2067, 2090);
INSERT INTO `base_region` VALUES ('1120702', '嘉祥', '山东-济宁-嘉祥', 1120702, '1120701', 1, NULL, '2018-03-30 12:00:00', 1, 2068, 2069);
INSERT INTO `base_region` VALUES ('1120703', '微山', '山东-济宁-微山', 1120703, '1120701', 1, NULL, '2018-03-30 12:00:00', 1, 2070, 2071);
INSERT INTO `base_region` VALUES ('1120704', '鱼台', '山东-济宁-鱼台', 1120704, '1120701', 1, NULL, '2018-03-30 12:00:00', 1, 2072, 2073);
INSERT INTO `base_region` VALUES ('1120705', '兖州', '山东-济宁-兖州', 1120705, '1120701', 1, NULL, '2018-03-30 12:00:00', 1, 2074, 2075);
INSERT INTO `base_region` VALUES ('1120706', '金乡', '山东-济宁-金乡', 1120706, '1120701', 1, NULL, '2018-03-30 12:00:00', 1, 2076, 2077);
INSERT INTO `base_region` VALUES ('1120707', '汶上', '山东-济宁-汶上', 1120707, '1120701', 1, NULL, '2018-03-30 12:00:00', 1, 2078, 2079);
INSERT INTO `base_region` VALUES ('1120708', '泗水', '山东-济宁-泗水', 1120708, '1120701', 1, NULL, '2018-03-30 12:00:00', 1, 2080, 2081);
INSERT INTO `base_region` VALUES ('1120709', '梁山', '山东-济宁-梁山', 1120709, '1120701', 1, NULL, '2018-03-30 12:00:00', 1, 2082, 2083);
INSERT INTO `base_region` VALUES ('1120710', '曲阜', '山东-济宁-曲阜', 1120710, '1120701', 1, NULL, '2018-03-30 12:00:00', 1, 2084, 2085);
INSERT INTO `base_region` VALUES ('1120711', '邹城', '山东-济宁-邹城', 1120711, '1120701', 1, NULL, '2018-03-30 12:00:00', 1, 2086, 2087);
INSERT INTO `base_region` VALUES ('1120712', '任城', '山东-济宁-任城', 1120712, '1120701', 1, NULL, '2018-03-30 12:00:00', 1, 2088, 2089);
INSERT INTO `base_region` VALUES ('1120801', '泰安', '山东-泰安', 1120801, '1120000', 0, NULL, '2018-03-30 12:00:00', 1, 2091, 2104);
INSERT INTO `base_region` VALUES ('1120802', '新泰', '山东-泰安-新泰', 1120802, '1120801', 1, NULL, '2018-03-30 12:00:00', 1, 2092, 2093);
INSERT INTO `base_region` VALUES ('1120803', '泰山', '山东-泰安-泰山', 1120803, '1120801', 1, NULL, '2018-03-30 12:00:00', 1, 2094, 2095);
INSERT INTO `base_region` VALUES ('1120804', '肥城', '山东-泰安-肥城', 1120804, '1120801', 1, NULL, '2018-03-30 12:00:00', 1, 2096, 2097);
INSERT INTO `base_region` VALUES ('1120805', '东平', '山东-泰安-东平', 1120805, '1120801', 1, NULL, '2018-03-30 12:00:00', 1, 2098, 2099);
INSERT INTO `base_region` VALUES ('1120806', '宁阳', '山东-泰安-宁阳', 1120806, '1120801', 1, NULL, '2018-03-30 12:00:00', 1, 2100, 2101);
INSERT INTO `base_region` VALUES ('1120807', '岱岳', '山东-泰安-岱岳', 1120807, '1120801', 1, NULL, '2018-03-30 12:00:00', 1, 2102, 2103);
INSERT INTO `base_region` VALUES ('1120901', '临沂', '山东-临沂', 1120901, '1120000', 0, NULL, '2018-03-30 12:00:00', 1, 2105, 2130);
INSERT INTO `base_region` VALUES ('1120902', '莒南', '山东-临沂-莒南', 1120902, '1120901', 1, NULL, '2018-03-30 12:00:00', 1, 2106, 2107);
INSERT INTO `base_region` VALUES ('1120903', '沂南', '山东-临沂-沂南', 1120903, '1120901', 1, NULL, '2018-03-30 12:00:00', 1, 2108, 2109);
INSERT INTO `base_region` VALUES ('1120904', '兰陵', '山东-临沂-兰陵', 1120904, '1120901', 1, NULL, '2018-03-30 12:00:00', 1, 2110, 2111);
INSERT INTO `base_region` VALUES ('1120905', '临沭', '山东-临沂-临沭', 1120905, '1120901', 1, NULL, '2018-03-30 12:00:00', 1, 2112, 2113);
INSERT INTO `base_region` VALUES ('1120906', '郯城', '山东-临沂-郯城', 1120906, '1120901', 1, NULL, '2018-03-30 12:00:00', 1, 2114, 2115);
INSERT INTO `base_region` VALUES ('1120907', '蒙阴', '山东-临沂-蒙阴', 1120907, '1120901', 1, NULL, '2018-03-30 12:00:00', 1, 2116, 2117);
INSERT INTO `base_region` VALUES ('1120908', '平邑', '山东-临沂-平邑', 1120908, '1120901', 1, NULL, '2018-03-30 12:00:00', 1, 2118, 2119);
INSERT INTO `base_region` VALUES ('1120909', '费县', '山东-临沂-费县', 1120909, '1120901', 1, NULL, '2018-03-30 12:00:00', 1, 2120, 2121);
INSERT INTO `base_region` VALUES ('1120910', '沂水', '山东-临沂-沂水', 1120910, '1120901', 1, NULL, '2018-03-30 12:00:00', 1, 2122, 2123);
INSERT INTO `base_region` VALUES ('1120911', '兰山', '山东-临沂-兰山', 1120911, '1120901', 1, NULL, '2018-03-30 12:00:00', 1, 2124, 2125);
INSERT INTO `base_region` VALUES ('1120912', '罗庄', '山东-临沂-罗庄', 1120912, '1120901', 1, NULL, '2018-03-30 12:00:00', 1, 2126, 2127);
INSERT INTO `base_region` VALUES ('1120913', '河东', '山东-临沂-河东', 1120913, '1120901', 1, NULL, '2018-03-30 12:00:00', 1, 2128, 2129);
INSERT INTO `base_region` VALUES ('1121001', '菏泽', '山东-菏泽', 1121001, '1120000', 0, NULL, '2018-03-30 12:00:00', 1, 2131, 2150);
INSERT INTO `base_region` VALUES ('1121002', '鄄城', '山东-菏泽-鄄城', 1121002, '1121001', 1, NULL, '2018-03-30 12:00:00', 1, 2132, 2133);
INSERT INTO `base_region` VALUES ('1121003', '郓城', '山东-菏泽-郓城', 1121003, '1121001', 1, NULL, '2018-03-30 12:00:00', 1, 2134, 2135);
INSERT INTO `base_region` VALUES ('1121004', '东明', '山东-菏泽-东明', 1121004, '1121001', 1, NULL, '2018-03-30 12:00:00', 1, 2136, 2137);
INSERT INTO `base_region` VALUES ('1121005', '定陶', '山东-菏泽-定陶', 1121005, '1121001', 1, NULL, '2018-03-30 12:00:00', 1, 2138, 2139);
INSERT INTO `base_region` VALUES ('1121006', '巨野', '山东-菏泽-巨野', 1121006, '1121001', 1, NULL, '2018-03-30 12:00:00', 1, 2140, 2141);
INSERT INTO `base_region` VALUES ('1121007', '曹县', '山东-菏泽-曹县', 1121007, '1121001', 1, NULL, '2018-03-30 12:00:00', 1, 2142, 2143);
INSERT INTO `base_region` VALUES ('1121008', '成武', '山东-菏泽-成武', 1121008, '1121001', 1, NULL, '2018-03-30 12:00:00', 1, 2144, 2145);
INSERT INTO `base_region` VALUES ('1121009', '单县', '山东-菏泽-单县', 1121009, '1121001', 1, NULL, '2018-03-30 12:00:00', 1, 2146, 2147);
INSERT INTO `base_region` VALUES ('1121010', '牡丹', '山东-菏泽-牡丹', 1121010, '1121001', 1, NULL, '2018-03-30 12:00:00', 1, 2148, 2149);
INSERT INTO `base_region` VALUES ('1121101', '滨州', '山东-滨州', 1121101, '1120000', 0, NULL, '2018-03-30 12:00:00', 1, 2151, 2166);
INSERT INTO `base_region` VALUES ('1121102', '博兴', '山东-滨州-博兴', 1121102, '1121101', 1, NULL, '2018-03-30 12:00:00', 1, 2152, 2153);
INSERT INTO `base_region` VALUES ('1121103', '无棣', '山东-滨州-无棣', 1121103, '1121101', 1, NULL, '2018-03-30 12:00:00', 1, 2154, 2155);
INSERT INTO `base_region` VALUES ('1121104', '阳信', '山东-滨州-阳信', 1121104, '1121101', 1, NULL, '2018-03-30 12:00:00', 1, 2156, 2157);
INSERT INTO `base_region` VALUES ('1121105', '惠民', '山东-滨州-惠民', 1121105, '1121101', 1, NULL, '2018-03-30 12:00:00', 1, 2158, 2159);
INSERT INTO `base_region` VALUES ('1121106', '沾化', '山东-滨州-沾化', 1121106, '1121101', 1, NULL, '2018-03-30 12:00:00', 1, 2160, 2161);
INSERT INTO `base_region` VALUES ('1121107', '邹平', '山东-滨州-邹平', 1121107, '1121101', 1, NULL, '2018-03-30 12:00:00', 1, 2162, 2163);
INSERT INTO `base_region` VALUES ('1121108', '滨城', '山东-滨州-滨城', 1121108, '1121101', 1, NULL, '2018-03-30 12:00:00', 1, 2164, 2165);
INSERT INTO `base_region` VALUES ('1121201', '东营', '山东-东营', 1121201, '1120000', 0, NULL, '2018-03-30 12:00:00', 1, 2167, 2176);
INSERT INTO `base_region` VALUES ('1121202', '河口', '山东-东营-河口', 1121202, '1121201', 1, NULL, '2018-03-30 12:00:00', 1, 2168, 2169);
INSERT INTO `base_region` VALUES ('1121203', '垦利', '山东-东营-垦利', 1121203, '1121201', 1, NULL, '2018-03-30 12:00:00', 1, 2170, 2171);
INSERT INTO `base_region` VALUES ('1121204', '利津', '山东-东营-利津', 1121204, '1121201', 1, NULL, '2018-03-30 12:00:00', 1, 2172, 2173);
INSERT INTO `base_region` VALUES ('1121205', '广饶', '山东-东营-广饶', 1121205, '1121201', 1, NULL, '2018-03-30 12:00:00', 1, 2174, 2175);
INSERT INTO `base_region` VALUES ('1121301', '威海', '山东-威海', 1121301, '1120000', 0, NULL, '2018-03-30 12:00:00', 1, 2177, 2186);
INSERT INTO `base_region` VALUES ('1121302', '文登', '山东-威海-文登', 1121302, '1121301', 1, NULL, '2018-03-30 12:00:00', 1, 2178, 2179);
INSERT INTO `base_region` VALUES ('1121303', '荣成', '山东-威海-荣成', 1121303, '1121301', 1, NULL, '2018-03-30 12:00:00', 1, 2180, 2181);
INSERT INTO `base_region` VALUES ('1121304', '乳山', '山东-威海-乳山', 1121304, '1121301', 1, NULL, '2018-03-30 12:00:00', 1, 2182, 2183);
INSERT INTO `base_region` VALUES ('1121307', '环翠', '山东-威海-环翠', 1121307, '1121301', 1, NULL, '2018-03-30 12:00:00', 1, 2184, 2185);
INSERT INTO `base_region` VALUES ('1121401', '枣庄', '山东-枣庄', 1121401, '1120000', 0, NULL, '2018-03-30 12:00:00', 1, 2187, 2200);
INSERT INTO `base_region` VALUES ('1121402', '薛城', '山东-枣庄-薛城', 1121402, '1121401', 1, NULL, '2018-03-30 12:00:00', 1, 2188, 2189);
INSERT INTO `base_region` VALUES ('1121403', '峄城', '山东-枣庄-峄城', 1121403, '1121401', 1, NULL, '2018-03-30 12:00:00', 1, 2190, 2191);
INSERT INTO `base_region` VALUES ('1121404', '台儿庄', '山东-枣庄-台儿庄', 1121404, '1121401', 1, NULL, '2018-03-30 12:00:00', 1, 2192, 2193);
INSERT INTO `base_region` VALUES ('1121405', '滕州', '山东-枣庄-滕州', 1121405, '1121401', 1, NULL, '2018-03-30 12:00:00', 1, 2194, 2195);
INSERT INTO `base_region` VALUES ('1121406', '市中', '山东-枣庄-市中', 1121406, '1121401', 1, NULL, '2018-03-30 12:00:00', 1, 2196, 2197);
INSERT INTO `base_region` VALUES ('1121407', '山亭', '山东-枣庄-山亭', 1121407, '1121401', 1, NULL, '2018-03-30 12:00:00', 1, 2198, 2199);
INSERT INTO `base_region` VALUES ('1121501', '日照', '山东-日照', 1121501, '1120000', 0, NULL, '2018-03-30 12:00:00', 1, 2201, 2210);
INSERT INTO `base_region` VALUES ('1121502', '五莲', '山东-日照-五莲', 1121502, '1121501', 1, NULL, '2018-03-30 12:00:00', 1, 2202, 2203);
INSERT INTO `base_region` VALUES ('1121503', '莒县', '山东-日照-莒县', 1121503, '1121501', 1, NULL, '2018-03-30 12:00:00', 1, 2204, 2205);
INSERT INTO `base_region` VALUES ('1121504', '东港', '山东-日照-东港', 1121504, '1121501', 1, NULL, '2018-03-30 12:00:00', 1, 2206, 2207);
INSERT INTO `base_region` VALUES ('1121505', '岚山', '山东-日照-岚山', 1121505, '1121501', 1, NULL, '2018-03-30 12:00:00', 1, 2208, 2209);
INSERT INTO `base_region` VALUES ('1121601', '莱芜', '山东-莱芜', 1121601, '1120000', 0, NULL, '2018-03-30 12:00:00', 1, 2211, 2216);
INSERT INTO `base_region` VALUES ('1121602', '莱城', '山东-莱芜-莱城', 1121602, '1121601', 1, NULL, '2018-03-30 12:00:00', 1, 2212, 2213);
INSERT INTO `base_region` VALUES ('1121603', '钢城', '山东-莱芜-钢城', 1121603, '1121601', 1, NULL, '2018-03-30 12:00:00', 1, 2214, 2215);
INSERT INTO `base_region` VALUES ('1121701', '聊城', '山东-聊城', 1121701, '1120000', 0, NULL, '2018-03-30 12:00:00', 1, 2217, 2234);
INSERT INTO `base_region` VALUES ('1121702', '冠县', '山东-聊城-冠县', 1121702, '1121701', 1, NULL, '2018-03-30 12:00:00', 1, 2218, 2219);
INSERT INTO `base_region` VALUES ('1121703', '阳谷', '山东-聊城-阳谷', 1121703, '1121701', 1, NULL, '2018-03-30 12:00:00', 1, 2220, 2221);
INSERT INTO `base_region` VALUES ('1121704', '高唐', '山东-聊城-高唐', 1121704, '1121701', 1, NULL, '2018-03-30 12:00:00', 1, 2222, 2223);
INSERT INTO `base_region` VALUES ('1121705', '茌平', '山东-聊城-茌平', 1121705, '1121701', 1, NULL, '2018-03-30 12:00:00', 1, 2224, 2225);
INSERT INTO `base_region` VALUES ('1121706', '东阿', '山东-聊城-东阿', 1121706, '1121701', 1, NULL, '2018-03-30 12:00:00', 1, 2226, 2227);
INSERT INTO `base_region` VALUES ('1121707', '临清', '山东-聊城-临清', 1121707, '1121701', 1, NULL, '2018-03-30 12:00:00', 1, 2228, 2229);
INSERT INTO `base_region` VALUES ('1121708', '东昌府', '山东-聊城-东昌府', 1121708, '1121701', 1, NULL, '2018-03-30 12:00:00', 1, 2230, 2231);
INSERT INTO `base_region` VALUES ('1121709', '莘县', '山东-聊城-莘县', 1121709, '1121701', 1, NULL, '2018-03-30 12:00:00', 1, 2232, 2233);
INSERT INTO `base_region` VALUES ('1130000', '新疆', '新疆', 1130000, 'ROOT', 0, NULL, '2018-03-30 12:00:00', 1, 2236, 2457);
INSERT INTO `base_region` VALUES ('1130101', '乌鲁木齐', '新疆-乌鲁木齐', 1130101, '1130000', 0, NULL, '2018-03-30 12:00:00', 1, 2237, 2254);
INSERT INTO `base_region` VALUES ('1130102', '天山', '新疆-乌鲁木齐-天山', 1130102, '1130101', 1, NULL, '2018-03-30 12:00:00', 1, 2238, 2239);
INSERT INTO `base_region` VALUES ('1130104', '沙依巴克', '新疆-乌鲁木齐-沙依巴克', 1130104, '1130101', 1, NULL, '2018-03-30 12:00:00', 1, 2240, 2241);
INSERT INTO `base_region` VALUES ('1130105', '达坂城', '新疆-乌鲁木齐-达坂城', 1130105, '1130101', 1, NULL, '2018-03-30 12:00:00', 1, 2242, 2243);
INSERT INTO `base_region` VALUES ('1130106', '新市', '新疆-乌鲁木齐-新市', 1130106, '1130101', 1, NULL, '2018-03-30 12:00:00', 1, 2244, 2245);
INSERT INTO `base_region` VALUES ('1130107', '水磨沟', '新疆-乌鲁木齐-水磨沟', 1130107, '1130101', 1, NULL, '2018-03-30 12:00:00', 1, 2246, 2247);
INSERT INTO `base_region` VALUES ('1130111', '头屯河', '新疆-乌鲁木齐-头屯河', 1130111, '1130101', 1, NULL, '2018-03-30 12:00:00', 1, 2248, 2249);
INSERT INTO `base_region` VALUES ('1130112', '米东', '新疆-乌鲁木齐-米东', 1130112, '1130101', 1, NULL, '2018-03-30 12:00:00', 1, 2250, 2251);
INSERT INTO `base_region` VALUES ('1130113', '乌鲁木齐县', '新疆-乌鲁木齐-乌鲁木齐县', 1130113, '1130101', 1, NULL, '2018-03-30 12:00:00', 1, 2252, 2253);
INSERT INTO `base_region` VALUES ('1130201', '克拉玛依', '新疆-克拉玛依', 1130201, '1130000', 0, NULL, '2018-03-30 12:00:00', 1, 2255, 2262);
INSERT INTO `base_region` VALUES ('1130202', '乌尔禾', '新疆-克拉玛依-乌尔禾', 1130202, '1130201', 1, NULL, '2018-03-30 12:00:00', 1, 2256, 2257);
INSERT INTO `base_region` VALUES ('1130203', '白碱滩', '新疆-克拉玛依-白碱滩', 1130203, '1130201', 1, NULL, '2018-03-30 12:00:00', 1, 2258, 2259);
INSERT INTO `base_region` VALUES ('1130204', '独山子', '新疆-克拉玛依-独山子', 1130204, '1130201', 1, NULL, '2018-03-30 12:00:00', 1, 2260, 2261);
INSERT INTO `base_region` VALUES ('1130301', '石河子', '新疆-石河子', 1130301, '1130000', 0, NULL, '2018-03-30 12:00:00', 1, 2263, 2264);
INSERT INTO `base_region` VALUES ('1130401', '昌吉', '新疆-昌吉', 1130401, '1130000', 0, NULL, '2018-03-30 12:00:00', 1, 2265, 2278);
INSERT INTO `base_region` VALUES ('1130402', '呼图壁', '新疆-昌吉-呼图壁', 1130402, '1130401', 1, NULL, '2018-03-30 12:00:00', 1, 2266, 2267);
INSERT INTO `base_region` VALUES ('1130404', '阜康', '新疆-昌吉-阜康', 1130404, '1130401', 1, NULL, '2018-03-30 12:00:00', 1, 2268, 2269);
INSERT INTO `base_region` VALUES ('1130405', '吉木萨尔', '新疆-昌吉-吉木萨尔', 1130405, '1130401', 1, NULL, '2018-03-30 12:00:00', 1, 2270, 2271);
INSERT INTO `base_region` VALUES ('1130406', '奇台', '新疆-昌吉-奇台', 1130406, '1130401', 1, NULL, '2018-03-30 12:00:00', 1, 2272, 2273);
INSERT INTO `base_region` VALUES ('1130407', '玛纳斯', '新疆-昌吉-玛纳斯', 1130407, '1130401', 1, NULL, '2018-03-30 12:00:00', 1, 2274, 2275);
INSERT INTO `base_region` VALUES ('1130408', '木垒', '新疆-昌吉-木垒', 1130408, '1130401', 1, NULL, '2018-03-30 12:00:00', 1, 2276, 2277);
INSERT INTO `base_region` VALUES ('1130501', '吐鲁番', '新疆-吐鲁番', 1130501, '1130000', 0, NULL, '2018-03-30 12:00:00', 1, 2279, 2286);
INSERT INTO `base_region` VALUES ('1130502', '托克逊', '新疆-吐鲁番-托克逊', 1130502, '1130501', 1, NULL, '2018-03-30 12:00:00', 1, 2280, 2281);
INSERT INTO `base_region` VALUES ('1130503', '高昌', '新疆-吐鲁番-高昌', 1130503, '1130501', 1, NULL, '2018-03-30 12:00:00', 1, 2282, 2283);
INSERT INTO `base_region` VALUES ('1130504', '鄯善', '新疆-吐鲁番-鄯善', 1130504, '1130501', 1, NULL, '2018-03-30 12:00:00', 1, 2284, 2285);
INSERT INTO `base_region` VALUES ('1130601', '库尔勒', '新疆-巴音郭楞-库尔勒', 1130601, '1130609', 1, NULL, '2018-03-30 12:00:00', 1, 2288, 2289);
INSERT INTO `base_region` VALUES ('1130602', '轮台', '新疆-巴音郭楞-轮台', 1130602, '1130609', 1, NULL, '2018-03-30 12:00:00', 1, 2290, 2291);
INSERT INTO `base_region` VALUES ('1130603', '尉犁', '新疆-巴音郭楞-尉犁', 1130603, '1130609', 1, NULL, '2018-03-30 12:00:00', 1, 2292, 2293);
INSERT INTO `base_region` VALUES ('1130604', '若羌', '新疆-巴音郭楞-若羌', 1130604, '1130609', 1, NULL, '2018-03-30 12:00:00', 1, 2294, 2295);
INSERT INTO `base_region` VALUES ('1130605', '且末', '新疆-巴音郭楞-且末', 1130605, '1130609', 1, NULL, '2018-03-30 12:00:00', 1, 2296, 2297);
INSERT INTO `base_region` VALUES ('1130606', '和静', '新疆-巴音郭楞-和静', 1130606, '1130609', 1, NULL, '2018-03-30 12:00:00', 1, 2298, 2299);
INSERT INTO `base_region` VALUES ('1130607', '焉耆', '新疆-巴音郭楞-焉耆', 1130607, '1130609', 1, NULL, '2018-03-30 12:00:00', 1, 2300, 2301);
INSERT INTO `base_region` VALUES ('1130608', '和硕', '新疆-巴音郭楞-和硕', 1130608, '1130609', 1, NULL, '2018-03-30 12:00:00', 1, 2302, 2303);
INSERT INTO `base_region` VALUES ('1130609', '巴音郭楞', '新疆-巴音郭楞', 1130609, '1130000', 0, NULL, '2018-03-30 12:00:00', 1, 2287, 2306);
INSERT INTO `base_region` VALUES ('1130612', '博湖', '新疆-巴音郭楞-博湖', 1130612, '1130609', 1, NULL, '2018-03-30 12:00:00', 1, 2304, 2305);
INSERT INTO `base_region` VALUES ('1130701', '阿拉尔', '新疆-阿拉尔', 1130701, '1130000', 0, NULL, '2018-03-30 12:00:00', 1, 2307, 2308);
INSERT INTO `base_region` VALUES ('1130801', '阿克苏', '新疆-阿克苏', 1130801, '1130000', 0, NULL, '2018-03-30 12:00:00', 1, 2309, 2326);
INSERT INTO `base_region` VALUES ('1130802', '乌什', '新疆-阿克苏-乌什', 1130802, '1130801', 1, NULL, '2018-03-30 12:00:00', 1, 2310, 2311);
INSERT INTO `base_region` VALUES ('1130803', '温宿', '新疆-阿克苏-温宿', 1130803, '1130801', 1, NULL, '2018-03-30 12:00:00', 1, 2312, 2313);
INSERT INTO `base_region` VALUES ('1130804', '拜城', '新疆-阿克苏-拜城', 1130804, '1130801', 1, NULL, '2018-03-30 12:00:00', 1, 2314, 2315);
INSERT INTO `base_region` VALUES ('1130805', '新和', '新疆-阿克苏-新和', 1130805, '1130801', 1, NULL, '2018-03-30 12:00:00', 1, 2316, 2317);
INSERT INTO `base_region` VALUES ('1130806', '沙雅', '新疆-阿克苏-沙雅', 1130806, '1130801', 1, NULL, '2018-03-30 12:00:00', 1, 2318, 2319);
INSERT INTO `base_region` VALUES ('1130807', '库车', '新疆-阿克苏-库车', 1130807, '1130801', 1, NULL, '2018-03-30 12:00:00', 1, 2320, 2321);
INSERT INTO `base_region` VALUES ('1130808', '柯坪', '新疆-阿克苏-柯坪', 1130808, '1130801', 1, NULL, '2018-03-30 12:00:00', 1, 2322, 2323);
INSERT INTO `base_region` VALUES ('1130809', '阿瓦提', '新疆-阿克苏-阿瓦提', 1130809, '1130801', 1, NULL, '2018-03-30 12:00:00', 1, 2324, 2325);
INSERT INTO `base_region` VALUES ('1130901', '喀什', '新疆-喀什', 1130901, '1130000', 0, NULL, '2018-03-30 12:00:00', 1, 2327, 2350);
INSERT INTO `base_region` VALUES ('1130902', '英吉沙', '新疆-喀什-英吉沙', 1130902, '1130901', 1, NULL, '2018-03-30 12:00:00', 1, 2328, 2329);
INSERT INTO `base_region` VALUES ('1130903', '塔什库尔干', '新疆-喀什-塔什库尔干', 1130903, '1130901', 1, NULL, '2018-03-30 12:00:00', 1, 2330, 2331);
INSERT INTO `base_region` VALUES ('1130904', '麦盖提', '新疆-喀什-麦盖提', 1130904, '1130901', 1, NULL, '2018-03-30 12:00:00', 1, 2332, 2333);
INSERT INTO `base_region` VALUES ('1130905', '莎车', '新疆-喀什-莎车', 1130905, '1130901', 1, NULL, '2018-03-30 12:00:00', 1, 2334, 2335);
INSERT INTO `base_region` VALUES ('1130906', '叶城', '新疆-喀什-叶城', 1130906, '1130901', 1, NULL, '2018-03-30 12:00:00', 1, 2336, 2337);
INSERT INTO `base_region` VALUES ('1130907', '泽普', '新疆-喀什-泽普', 1130907, '1130901', 1, NULL, '2018-03-30 12:00:00', 1, 2338, 2339);
INSERT INTO `base_region` VALUES ('1130908', '巴楚', '新疆-喀什-巴楚', 1130908, '1130901', 1, NULL, '2018-03-30 12:00:00', 1, 2340, 2341);
INSERT INTO `base_region` VALUES ('1130909', '岳普湖', '新疆-喀什-岳普湖', 1130909, '1130901', 1, NULL, '2018-03-30 12:00:00', 1, 2342, 2343);
INSERT INTO `base_region` VALUES ('1130910', '伽师', '新疆-喀什-伽师', 1130910, '1130901', 1, NULL, '2018-03-30 12:00:00', 1, 2344, 2345);
INSERT INTO `base_region` VALUES ('1130911', '疏附', '新疆-喀什-疏附', 1130911, '1130901', 1, NULL, '2018-03-30 12:00:00', 1, 2346, 2347);
INSERT INTO `base_region` VALUES ('1130912', '疏勒', '新疆-喀什-疏勒', 1130912, '1130901', 1, NULL, '2018-03-30 12:00:00', 1, 2348, 2349);
INSERT INTO `base_region` VALUES ('1131001', '伊宁', '新疆-伊犁-伊宁', 1131001, '1131012', 1, NULL, '2018-03-30 12:00:00', 1, 2352, 2353);
INSERT INTO `base_region` VALUES ('1131002', '察布查尔', '新疆-伊犁-察布查尔', 1131002, '1131012', 1, NULL, '2018-03-30 12:00:00', 1, 2354, 2355);
INSERT INTO `base_region` VALUES ('1131003', '尼勒克', '新疆-伊犁-尼勒克', 1131003, '1131012', 1, NULL, '2018-03-30 12:00:00', 1, 2356, 2357);
INSERT INTO `base_region` VALUES ('1131004', '伊宁县', '新疆-伊犁-伊宁县', 1131004, '1131012', 1, NULL, '2018-03-30 12:00:00', 1, 2358, 2359);
INSERT INTO `base_region` VALUES ('1131005', '巩留', '新疆-伊犁-巩留', 1131005, '1131012', 1, NULL, '2018-03-30 12:00:00', 1, 2360, 2361);
INSERT INTO `base_region` VALUES ('1131006', '新源', '新疆-伊犁-新源', 1131006, '1131012', 1, NULL, '2018-03-30 12:00:00', 1, 2362, 2363);
INSERT INTO `base_region` VALUES ('1131007', '昭苏', '新疆-伊犁-昭苏', 1131007, '1131012', 1, NULL, '2018-03-30 12:00:00', 1, 2364, 2365);
INSERT INTO `base_region` VALUES ('1131008', '特克斯', '新疆-伊犁-特克斯', 1131008, '1131012', 1, NULL, '2018-03-30 12:00:00', 1, 2366, 2367);
INSERT INTO `base_region` VALUES ('1131009', '霍城', '新疆-伊犁-霍城', 1131009, '1131012', 1, NULL, '2018-03-30 12:00:00', 1, 2368, 2369);
INSERT INTO `base_region` VALUES ('1131010', '霍尔果斯', '新疆-伊犁-霍尔果斯', 1131010, '1131012', 1, NULL, '2018-03-30 12:00:00', 1, 2370, 2371);
INSERT INTO `base_region` VALUES ('1131011', '奎屯', '新疆-伊犁-奎屯', 1131011, '1131012', 1, NULL, '2018-03-30 12:00:00', 1, 2372, 2373);
INSERT INTO `base_region` VALUES ('1131012', '伊犁', '新疆-伊犁', 1131012, '1130000', 0, NULL, '2018-03-30 12:00:00', 1, 2351, 2374);
INSERT INTO `base_region` VALUES ('1131101', '塔城', '新疆-塔城', 1131101, '1130000', 0, NULL, '2018-03-30 12:00:00', 1, 2375, 2388);
INSERT INTO `base_region` VALUES ('1131102', '裕民', '新疆-塔城-裕民', 1131102, '1131101', 1, NULL, '2018-03-30 12:00:00', 1, 2376, 2377);
INSERT INTO `base_region` VALUES ('1131103', '额敏', '新疆-塔城-额敏', 1131103, '1131101', 1, NULL, '2018-03-30 12:00:00', 1, 2378, 2379);
INSERT INTO `base_region` VALUES ('1131104', '和布克赛尔', '新疆-塔城-和布克赛尔', 1131104, '1131101', 1, NULL, '2018-03-30 12:00:00', 1, 2380, 2381);
INSERT INTO `base_region` VALUES ('1131105', '托里', '新疆-塔城-托里', 1131105, '1131101', 1, NULL, '2018-03-30 12:00:00', 1, 2382, 2383);
INSERT INTO `base_region` VALUES ('1131106', '乌苏', '新疆-塔城-乌苏', 1131106, '1131101', 1, NULL, '2018-03-30 12:00:00', 1, 2384, 2385);
INSERT INTO `base_region` VALUES ('1131107', '沙湾', '新疆-塔城-沙湾', 1131107, '1131101', 1, NULL, '2018-03-30 12:00:00', 1, 2386, 2387);
INSERT INTO `base_region` VALUES ('1131201', '哈密', '新疆-哈密', 1131201, '1130000', 0, NULL, '2018-03-30 12:00:00', 1, 2389, 2396);
INSERT INTO `base_region` VALUES ('1131202', '伊州', '新疆-哈密-伊州', 1131202, '1131201', 1, NULL, '2018-03-30 12:00:00', 1, 2390, 2391);
INSERT INTO `base_region` VALUES ('1131203', '巴里坤', '新疆-哈密-巴里坤', 1131203, '1131201', 1, NULL, '2018-03-30 12:00:00', 1, 2392, 2393);
INSERT INTO `base_region` VALUES ('1131204', '伊吾', '新疆-哈密-伊吾', 1131204, '1131201', 1, NULL, '2018-03-30 12:00:00', 1, 2394, 2395);
INSERT INTO `base_region` VALUES ('1131301', '和田', '新疆-和田', 1131301, '1130000', 0, NULL, '2018-03-30 12:00:00', 1, 2397, 2410);
INSERT INTO `base_region` VALUES ('1131302', '皮山', '新疆-和田-皮山', 1131302, '1131301', 1, NULL, '2018-03-30 12:00:00', 1, 2398, 2399);
INSERT INTO `base_region` VALUES ('1131303', '策勒', '新疆-和田-策勒', 1131303, '1131301', 1, NULL, '2018-03-30 12:00:00', 1, 2400, 2401);
INSERT INTO `base_region` VALUES ('1131304', '墨玉', '新疆-和田-墨玉', 1131304, '1131301', 1, NULL, '2018-03-30 12:00:00', 1, 2402, 2403);
INSERT INTO `base_region` VALUES ('1131305', '洛浦', '新疆-和田-洛浦', 1131305, '1131301', 1, NULL, '2018-03-30 12:00:00', 1, 2404, 2405);
INSERT INTO `base_region` VALUES ('1131306', '民丰', '新疆-和田-民丰', 1131306, '1131301', 1, NULL, '2018-03-30 12:00:00', 1, 2406, 2407);
INSERT INTO `base_region` VALUES ('1131307', '于田', '新疆-和田-于田', 1131307, '1131301', 1, NULL, '2018-03-30 12:00:00', 1, 2408, 2409);
INSERT INTO `base_region` VALUES ('1131401', '阿勒泰', '新疆-阿勒泰', 1131401, '1130000', 0, NULL, '2018-03-30 12:00:00', 1, 2411, 2430);
INSERT INTO `base_region` VALUES ('1131402', '哈巴河', '新疆-阿勒泰-哈巴河', 1131402, '1131401', 1, NULL, '2018-03-30 12:00:00', 1, 2412, 2413);
INSERT INTO `base_region` VALUES ('1131405', '吉木乃', '新疆-阿勒泰-吉木乃', 1131405, '1131401', 1, NULL, '2018-03-30 12:00:00', 1, 2414, 2415);
INSERT INTO `base_region` VALUES ('1131406', '布尔津', '新疆-阿勒泰-布尔津', 1131406, '1131401', 1, NULL, '2018-03-30 12:00:00', 1, 2416, 2417);
INSERT INTO `base_region` VALUES ('1131407', '福海', '新疆-阿勒泰-福海', 1131407, '1131401', 1, NULL, '2018-03-30 12:00:00', 1, 2418, 2419);
INSERT INTO `base_region` VALUES ('1131408', '富蕴', '新疆-阿勒泰-富蕴', 1131408, '1131401', 1, NULL, '2018-03-30 12:00:00', 1, 2420, 2421);
INSERT INTO `base_region` VALUES ('1131409', '青河', '新疆-阿勒泰-青河', 1131409, '1131401', 1, NULL, '2018-03-30 12:00:00', 1, 2422, 2423);
INSERT INTO `base_region` VALUES ('1131410', '北屯', '新疆-阿勒泰-北屯', 1131410, '1131401', 1, NULL, '2018-03-30 12:00:00', 1, 2424, 2425);
INSERT INTO `base_region` VALUES ('1131412', '双河', '新疆-阿勒泰-双河', 1131412, '1131401', 1, NULL, '2018-03-30 12:00:00', 1, 2426, 2427);
INSERT INTO `base_region` VALUES ('1131413', '可克达拉', '新疆-阿勒泰-可克达拉', 1131413, '1131401', 1, NULL, '2018-03-30 12:00:00', 1, 2428, 2429);
INSERT INTO `base_region` VALUES ('1131501', '阿图什', '新疆-克州-阿图什', 1131501, '1131505', 1, NULL, '2018-03-30 12:00:00', 1, 2432, 2433);
INSERT INTO `base_region` VALUES ('1131502', '乌恰', '新疆-克州-乌恰', 1131502, '1131505', 1, NULL, '2018-03-30 12:00:00', 1, 2434, 2435);
INSERT INTO `base_region` VALUES ('1131503', '阿克陶', '新疆-克州-阿克陶', 1131503, '1131505', 1, NULL, '2018-03-30 12:00:00', 1, 2436, 2437);
INSERT INTO `base_region` VALUES ('1131504', '阿合奇', '新疆-克州-阿合奇', 1131504, '1131505', 1, NULL, '2018-03-30 12:00:00', 1, 2438, 2439);
INSERT INTO `base_region` VALUES ('1131505', '克州', '新疆-克州', 1131505, '1130000', 0, NULL, '2018-03-30 12:00:00', 1, 2431, 2440);
INSERT INTO `base_region` VALUES ('1131601', '博乐', '新疆-博尔塔拉-博乐', 1131601, '1131604', 1, NULL, '2018-03-30 12:00:00', 1, 2442, 2443);
INSERT INTO `base_region` VALUES ('1131602', '温泉', '新疆-博尔塔拉-温泉', 1131602, '1131604', 1, NULL, '2018-03-30 12:00:00', 1, 2444, 2445);
INSERT INTO `base_region` VALUES ('1131603', '精河', '新疆-博尔塔拉-精河', 1131603, '1131604', 1, NULL, '2018-03-30 12:00:00', 1, 2446, 2447);
INSERT INTO `base_region` VALUES ('1131604', '博尔塔拉', '新疆-博尔塔拉', 1131604, '1130000', 0, NULL, '2018-03-30 12:00:00', 1, 2441, 2450);
INSERT INTO `base_region` VALUES ('1131606', '阿拉山口', '新疆-博尔塔拉-阿拉山口', 1131606, '1131604', 1, NULL, '2018-03-30 12:00:00', 1, 2448, 2449);
INSERT INTO `base_region` VALUES ('1131701', '图木舒克', '新疆-图木舒克', 1131701, '1130000', 0, NULL, '2018-03-30 12:00:00', 1, 2451, 2452);
INSERT INTO `base_region` VALUES ('1131801', '五家渠', '新疆-五家渠', 1131801, '1130000', 0, NULL, '2018-03-30 12:00:00', 1, 2453, 2454);
INSERT INTO `base_region` VALUES ('1131901', '铁门关', '新疆-铁门关', 1131901, '1130000', 0, NULL, '2018-03-30 12:00:00', 1, 2455, 2456);
INSERT INTO `base_region` VALUES ('1140000', '西藏', '西藏', 1140000, 'ROOT', 0, NULL, '2018-03-30 12:00:00', 1, 2458, 2619);
INSERT INTO `base_region` VALUES ('1140101', '拉萨', '西藏-拉萨', 1140101, '1140000', 0, NULL, '2018-03-30 12:00:00', 1, 2459, 2476);
INSERT INTO `base_region` VALUES ('1140102', '当雄', '西藏-拉萨-当雄', 1140102, '1140101', 1, NULL, '2018-03-30 12:00:00', 1, 2460, 2461);
INSERT INTO `base_region` VALUES ('1140103', '尼木', '西藏-拉萨-尼木', 1140103, '1140101', 1, NULL, '2018-03-30 12:00:00', 1, 2462, 2463);
INSERT INTO `base_region` VALUES ('1140104', '林周', '西藏-拉萨-林周', 1140104, '1140101', 1, NULL, '2018-03-30 12:00:00', 1, 2464, 2465);
INSERT INTO `base_region` VALUES ('1140105', '堆龙德庆', '西藏-拉萨-堆龙德庆', 1140105, '1140101', 1, NULL, '2018-03-30 12:00:00', 1, 2466, 2467);
INSERT INTO `base_region` VALUES ('1140106', '曲水', '西藏-拉萨-曲水', 1140106, '1140101', 1, NULL, '2018-03-30 12:00:00', 1, 2468, 2469);
INSERT INTO `base_region` VALUES ('1140107', '达孜', '西藏-拉萨-达孜', 1140107, '1140101', 1, NULL, '2018-03-30 12:00:00', 1, 2470, 2471);
INSERT INTO `base_region` VALUES ('1140108', '墨竹工卡', '西藏-拉萨-墨竹工卡', 1140108, '1140101', 1, NULL, '2018-03-30 12:00:00', 1, 2472, 2473);
INSERT INTO `base_region` VALUES ('1140109', '城关', '西藏-拉萨-城关', 1140109, '1140101', 1, NULL, '2018-03-30 12:00:00', 1, 2474, 2475);
INSERT INTO `base_region` VALUES ('1140201', '日喀则', '西藏-日喀则', 1140201, '1140000', 0, NULL, '2018-03-30 12:00:00', 1, 2477, 2514);
INSERT INTO `base_region` VALUES ('1140202', '拉孜', '西藏-日喀则-拉孜', 1140202, '1140201', 1, NULL, '2018-03-30 12:00:00', 1, 2478, 2479);
INSERT INTO `base_region` VALUES ('1140203', '南木林', '西藏-日喀则-南木林', 1140203, '1140201', 1, NULL, '2018-03-30 12:00:00', 1, 2480, 2481);
INSERT INTO `base_region` VALUES ('1140204', '聂拉木', '西藏-日喀则-聂拉木', 1140204, '1140201', 1, NULL, '2018-03-30 12:00:00', 1, 2482, 2483);
INSERT INTO `base_region` VALUES ('1140205', '定日', '西藏-日喀则-定日', 1140205, '1140201', 1, NULL, '2018-03-30 12:00:00', 1, 2484, 2485);
INSERT INTO `base_region` VALUES ('1140206', '江孜', '西藏-日喀则-江孜', 1140206, '1140201', 1, NULL, '2018-03-30 12:00:00', 1, 2486, 2487);
INSERT INTO `base_region` VALUES ('1140208', '仲巴', '西藏-日喀则-仲巴', 1140208, '1140201', 1, NULL, '2018-03-30 12:00:00', 1, 2488, 2489);
INSERT INTO `base_region` VALUES ('1140209', '萨嘎', '西藏-日喀则-萨嘎', 1140209, '1140201', 1, NULL, '2018-03-30 12:00:00', 1, 2490, 2491);
INSERT INTO `base_region` VALUES ('1140210', '吉隆', '西藏-日喀则-吉隆', 1140210, '1140201', 1, NULL, '2018-03-30 12:00:00', 1, 2492, 2493);
INSERT INTO `base_region` VALUES ('1140211', '昂仁', '西藏-日喀则-昂仁', 1140211, '1140201', 1, NULL, '2018-03-30 12:00:00', 1, 2494, 2495);
INSERT INTO `base_region` VALUES ('1140212', '定结', '西藏-日喀则-定结', 1140212, '1140201', 1, NULL, '2018-03-30 12:00:00', 1, 2496, 2497);
INSERT INTO `base_region` VALUES ('1140213', '萨迦', '西藏-日喀则-萨迦', 1140213, '1140201', 1, NULL, '2018-03-30 12:00:00', 1, 2498, 2499);
INSERT INTO `base_region` VALUES ('1140214', '谢通门', '西藏-日喀则-谢通门', 1140214, '1140201', 1, NULL, '2018-03-30 12:00:00', 1, 2500, 2501);
INSERT INTO `base_region` VALUES ('1140215', '桑珠孜', '西藏-日喀则-桑珠孜', 1140215, '1140201', 1, NULL, '2018-03-30 12:00:00', 1, 2502, 2503);
INSERT INTO `base_region` VALUES ('1140216', '岗巴', '西藏-日喀则-岗巴', 1140216, '1140201', 1, NULL, '2018-03-30 12:00:00', 1, 2504, 2505);
INSERT INTO `base_region` VALUES ('1140217', '白朗', '西藏-日喀则-白朗', 1140217, '1140201', 1, NULL, '2018-03-30 12:00:00', 1, 2506, 2507);
INSERT INTO `base_region` VALUES ('1140218', '亚东', '西藏-日喀则-亚东', 1140218, '1140201', 1, NULL, '2018-03-30 12:00:00', 1, 2508, 2509);
INSERT INTO `base_region` VALUES ('1140219', '康马', '西藏-日喀则-康马', 1140219, '1140201', 1, NULL, '2018-03-30 12:00:00', 1, 2510, 2511);
INSERT INTO `base_region` VALUES ('1140220', '仁布', '西藏-日喀则-仁布', 1140220, '1140201', 1, NULL, '2018-03-30 12:00:00', 1, 2512, 2513);
INSERT INTO `base_region` VALUES ('1140301', '山南', '西藏-山南', 1140301, '1140000', 0, NULL, '2018-03-30 12:00:00', 1, 2515, 2540);
INSERT INTO `base_region` VALUES ('1140302', '贡嘎', '西藏-山南-贡嘎', 1140302, '1140301', 1, NULL, '2018-03-30 12:00:00', 1, 2516, 2517);
INSERT INTO `base_region` VALUES ('1140303', '扎囊', '西藏-山南-扎囊', 1140303, '1140301', 1, NULL, '2018-03-30 12:00:00', 1, 2518, 2519);
INSERT INTO `base_region` VALUES ('1140304', '加查', '西藏-山南-加查', 1140304, '1140301', 1, NULL, '2018-03-30 12:00:00', 1, 2520, 2521);
INSERT INTO `base_region` VALUES ('1140305', '浪卡子', '西藏-山南-浪卡子', 1140305, '1140301', 1, NULL, '2018-03-30 12:00:00', 1, 2522, 2523);
INSERT INTO `base_region` VALUES ('1140306', '错那', '西藏-山南-错那', 1140306, '1140301', 1, NULL, '2018-03-30 12:00:00', 1, 2524, 2525);
INSERT INTO `base_region` VALUES ('1140307', '隆子', '西藏-山南-隆子', 1140307, '1140301', 1, NULL, '2018-03-30 12:00:00', 1, 2526, 2527);
INSERT INTO `base_region` VALUES ('1140309', '乃东', '西藏-山南-乃东', 1140309, '1140301', 1, NULL, '2018-03-30 12:00:00', 1, 2528, 2529);
INSERT INTO `base_region` VALUES ('1140310', '桑日', '西藏-山南-桑日', 1140310, '1140301', 1, NULL, '2018-03-30 12:00:00', 1, 2530, 2531);
INSERT INTO `base_region` VALUES ('1140311', '洛扎', '西藏-山南-洛扎', 1140311, '1140301', 1, NULL, '2018-03-30 12:00:00', 1, 2532, 2533);
INSERT INTO `base_region` VALUES ('1140312', '措美', '西藏-山南-措美', 1140312, '1140301', 1, NULL, '2018-03-30 12:00:00', 1, 2534, 2535);
INSERT INTO `base_region` VALUES ('1140313', '琼结', '西藏-山南-琼结', 1140313, '1140301', 1, NULL, '2018-03-30 12:00:00', 1, 2536, 2537);
INSERT INTO `base_region` VALUES ('1140314', '曲松', '西藏-山南-曲松', 1140314, '1140301', 1, NULL, '2018-03-30 12:00:00', 1, 2538, 2539);
INSERT INTO `base_region` VALUES ('1140401', '林芝', '西藏-林芝', 1140401, '1140000', 0, NULL, '2018-03-30 12:00:00', 1, 2541, 2556);
INSERT INTO `base_region` VALUES ('1140402', '波密', '西藏-林芝-波密', 1140402, '1140401', 1, NULL, '2018-03-30 12:00:00', 1, 2542, 2543);
INSERT INTO `base_region` VALUES ('1140403', '米林', '西藏-林芝-米林', 1140403, '1140401', 1, NULL, '2018-03-30 12:00:00', 1, 2544, 2545);
INSERT INTO `base_region` VALUES ('1140404', '察隅', '西藏-林芝-察隅', 1140404, '1140401', 1, NULL, '2018-03-30 12:00:00', 1, 2546, 2547);
INSERT INTO `base_region` VALUES ('1140405', '工布江达', '西藏-林芝-工布江达', 1140405, '1140401', 1, NULL, '2018-03-30 12:00:00', 1, 2548, 2549);
INSERT INTO `base_region` VALUES ('1140406', '朗县', '西藏-林芝-朗县', 1140406, '1140401', 1, NULL, '2018-03-30 12:00:00', 1, 2550, 2551);
INSERT INTO `base_region` VALUES ('1140407', '墨脱', '西藏-林芝-墨脱', 1140407, '1140401', 1, NULL, '2018-03-30 12:00:00', 1, 2552, 2553);
INSERT INTO `base_region` VALUES ('1140408', '巴宜', '西藏-林芝-巴宜', 1140408, '1140401', 1, NULL, '2018-03-30 12:00:00', 1, 2554, 2555);
INSERT INTO `base_region` VALUES ('1140501', '昌都', '西藏-昌都', 1140501, '1140000', 0, NULL, '2018-03-30 12:00:00', 1, 2557, 2580);
INSERT INTO `base_region` VALUES ('1140502', '丁青', '西藏-昌都-丁青', 1140502, '1140501', 1, NULL, '2018-03-30 12:00:00', 1, 2558, 2559);
INSERT INTO `base_region` VALUES ('1140503', '边坝', '西藏-昌都-边坝', 1140503, '1140501', 1, NULL, '2018-03-30 12:00:00', 1, 2560, 2561);
INSERT INTO `base_region` VALUES ('1140504', '洛隆', '西藏-昌都-洛隆', 1140504, '1140501', 1, NULL, '2018-03-30 12:00:00', 1, 2562, 2563);
INSERT INTO `base_region` VALUES ('1140505', '左贡', '西藏-昌都-左贡', 1140505, '1140501', 1, NULL, '2018-03-30 12:00:00', 1, 2564, 2565);
INSERT INTO `base_region` VALUES ('1140506', '芒康', '西藏-昌都-芒康', 1140506, '1140501', 1, NULL, '2018-03-30 12:00:00', 1, 2566, 2567);
INSERT INTO `base_region` VALUES ('1140507', '类乌齐', '西藏-昌都-类乌齐', 1140507, '1140501', 1, NULL, '2018-03-30 12:00:00', 1, 2568, 2569);
INSERT INTO `base_region` VALUES ('1140508', '八宿', '西藏-昌都-八宿', 1140508, '1140501', 1, NULL, '2018-03-30 12:00:00', 1, 2570, 2571);
INSERT INTO `base_region` VALUES ('1140509', '江达', '西藏-昌都-江达', 1140509, '1140501', 1, NULL, '2018-03-30 12:00:00', 1, 2572, 2573);
INSERT INTO `base_region` VALUES ('1140510', '察雅', '西藏-昌都-察雅', 1140510, '1140501', 1, NULL, '2018-03-30 12:00:00', 1, 2574, 2575);
INSERT INTO `base_region` VALUES ('1140511', '贡觉', '西藏-昌都-贡觉', 1140511, '1140501', 1, NULL, '2018-03-30 12:00:00', 1, 2576, 2577);
INSERT INTO `base_region` VALUES ('1140512', '卡若', '西藏-昌都-卡若', 1140512, '1140501', 1, NULL, '2018-03-30 12:00:00', 1, 2578, 2579);
INSERT INTO `base_region` VALUES ('1140601', '那曲', '西藏-那曲', 1140601, '1140000', 0, NULL, '2018-03-30 12:00:00', 1, 2581, 2602);
INSERT INTO `base_region` VALUES ('1140602', '尼玛', '西藏-那曲-尼玛', 1140602, '1140601', 1, NULL, '2018-03-30 12:00:00', 1, 2582, 2583);
INSERT INTO `base_region` VALUES ('1140603', '嘉黎', '西藏-那曲-嘉黎', 1140603, '1140601', 1, NULL, '2018-03-30 12:00:00', 1, 2584, 2585);
INSERT INTO `base_region` VALUES ('1140604', '班戈', '西藏-那曲-班戈', 1140604, '1140601', 1, NULL, '2018-03-30 12:00:00', 1, 2586, 2587);
INSERT INTO `base_region` VALUES ('1140605', '安多', '西藏-那曲-安多', 1140605, '1140601', 1, NULL, '2018-03-30 12:00:00', 1, 2588, 2589);
INSERT INTO `base_region` VALUES ('1140606', '索县', '西藏-那曲-索县', 1140606, '1140601', 1, NULL, '2018-03-30 12:00:00', 1, 2590, 2591);
INSERT INTO `base_region` VALUES ('1140607', '聂荣', '西藏-那曲-聂荣', 1140607, '1140601', 1, NULL, '2018-03-30 12:00:00', 1, 2592, 2593);
INSERT INTO `base_region` VALUES ('1140608', '巴青', '西藏-那曲-巴青', 1140608, '1140601', 1, NULL, '2018-03-30 12:00:00', 1, 2594, 2595);
INSERT INTO `base_region` VALUES ('1140609', '比如', '西藏-那曲-比如', 1140609, '1140601', 1, NULL, '2018-03-30 12:00:00', 1, 2596, 2597);
INSERT INTO `base_region` VALUES ('1140610', '双湖', '西藏-那曲-双湖', 1140610, '1140601', 1, NULL, '2018-03-30 12:00:00', 1, 2598, 2599);
INSERT INTO `base_region` VALUES ('1140611', '申扎', '西藏-那曲-申扎', 1140611, '1140601', 1, NULL, '2018-03-30 12:00:00', 1, 2600, 2601);
INSERT INTO `base_region` VALUES ('1140701', '阿里', '西藏-阿里', 1140701, '1140000', 0, NULL, '2018-03-30 12:00:00', 1, 2603, 2618);
INSERT INTO `base_region` VALUES ('1140702', '改则', '西藏-阿里-改则', 1140702, '1140701', 1, NULL, '2018-03-30 12:00:00', 1, 2604, 2605);
INSERT INTO `base_region` VALUES ('1140705', '普兰', '西藏-阿里-普兰', 1140705, '1140701', 1, NULL, '2018-03-30 12:00:00', 1, 2606, 2607);
INSERT INTO `base_region` VALUES ('1140706', '札达', '西藏-阿里-札达', 1140706, '1140701', 1, NULL, '2018-03-30 12:00:00', 1, 2608, 2609);
INSERT INTO `base_region` VALUES ('1140707', '噶尔', '西藏-阿里-噶尔', 1140707, '1140701', 1, NULL, '2018-03-30 12:00:00', 1, 2610, 2611);
INSERT INTO `base_region` VALUES ('1140708', '日土', '西藏-阿里-日土', 1140708, '1140701', 1, NULL, '2018-03-30 12:00:00', 1, 2612, 2613);
INSERT INTO `base_region` VALUES ('1140709', '革吉', '西藏-阿里-革吉', 1140709, '1140701', 1, NULL, '2018-03-30 12:00:00', 1, 2614, 2615);
INSERT INTO `base_region` VALUES ('1140710', '措勤', '西藏-阿里-措勤', 1140710, '1140701', 1, NULL, '2018-03-30 12:00:00', 1, 2616, 2617);
INSERT INTO `base_region` VALUES ('1150000', '青海', '青海', 1150000, 'ROOT', 0, NULL, '2018-03-30 12:00:00', 1, 2620, 2727);
INSERT INTO `base_region` VALUES ('1150101', '西宁', '青海-西宁', 1150101, '1150000', 0, NULL, '2018-03-30 12:00:00', 1, 2621, 2636);
INSERT INTO `base_region` VALUES ('1150102', '大通', '青海-西宁-大通', 1150102, '1150101', 1, NULL, '2018-03-30 12:00:00', 1, 2622, 2623);
INSERT INTO `base_region` VALUES ('1150103', '湟源', '青海-西宁-湟源', 1150103, '1150101', 1, NULL, '2018-03-30 12:00:00', 1, 2624, 2625);
INSERT INTO `base_region` VALUES ('1150104', '湟中', '青海-西宁-湟中', 1150104, '1150101', 1, NULL, '2018-03-30 12:00:00', 1, 2626, 2627);
INSERT INTO `base_region` VALUES ('1150105', '城东', '青海-西宁-城东', 1150105, '1150101', 1, NULL, '2018-03-30 12:00:00', 1, 2628, 2629);
INSERT INTO `base_region` VALUES ('1150106', '城中', '青海-西宁-城中', 1150106, '1150101', 1, NULL, '2018-03-30 12:00:00', 1, 2630, 2631);
INSERT INTO `base_region` VALUES ('1150107', '城西', '青海-西宁-城西', 1150107, '1150101', 1, NULL, '2018-03-30 12:00:00', 1, 2632, 2633);
INSERT INTO `base_region` VALUES ('1150108', '城北', '青海-西宁-城北', 1150108, '1150101', 1, NULL, '2018-03-30 12:00:00', 1, 2634, 2635);
INSERT INTO `base_region` VALUES ('1150201', '平安', '青海-海东-平安', 1150201, '1150207', 1, NULL, '2018-03-30 12:00:00', 1, 2638, 2639);
INSERT INTO `base_region` VALUES ('1150202', '乐都', '青海-海东-乐都', 1150202, '1150207', 1, NULL, '2018-03-30 12:00:00', 1, 2640, 2641);
INSERT INTO `base_region` VALUES ('1150203', '民和', '青海-海东-民和', 1150203, '1150207', 1, NULL, '2018-03-30 12:00:00', 1, 2642, 2643);
INSERT INTO `base_region` VALUES ('1150204', '互助', '青海-海东-互助', 1150204, '1150207', 1, NULL, '2018-03-30 12:00:00', 1, 2644, 2645);
INSERT INTO `base_region` VALUES ('1150205', '化隆', '青海-海东-化隆', 1150205, '1150207', 1, NULL, '2018-03-30 12:00:00', 1, 2646, 2647);
INSERT INTO `base_region` VALUES ('1150206', '循化', '青海-海东-循化', 1150206, '1150207', 1, NULL, '2018-03-30 12:00:00', 1, 2648, 2649);
INSERT INTO `base_region` VALUES ('1150207', '海东', '青海-海东', 1150207, '1150000', 0, NULL, '2018-03-30 12:00:00', 1, 2637, 2650);
INSERT INTO `base_region` VALUES ('1150301', '同仁', '青海-黄南-同仁', 1150301, '1150305', 1, NULL, '2018-03-30 12:00:00', 1, 2652, 2653);
INSERT INTO `base_region` VALUES ('1150302', '尖扎', '青海-黄南-尖扎', 1150302, '1150305', 1, NULL, '2018-03-30 12:00:00', 1, 2654, 2655);
INSERT INTO `base_region` VALUES ('1150303', '泽库', '青海-黄南-泽库', 1150303, '1150305', 1, NULL, '2018-03-30 12:00:00', 1, 2656, 2657);
INSERT INTO `base_region` VALUES ('1150304', '河南', '青海-黄南-河南', 1150304, '1150305', 1, NULL, '2018-03-30 12:00:00', 1, 2658, 2659);
INSERT INTO `base_region` VALUES ('1150305', '黄南', '青海-黄南', 1150305, '1150000', 0, NULL, '2018-03-30 12:00:00', 1, 2651, 2660);
INSERT INTO `base_region` VALUES ('1150401', '共和', '青海-海南-共和', 1150401, '1150402', 1, NULL, '2018-03-30 12:00:00', 1, 2662, 2663);
INSERT INTO `base_region` VALUES ('1150402', '海南', '青海-海南', 1150402, '1150000', 0, NULL, '2018-03-30 12:00:00', 1, 2661, 2672);
INSERT INTO `base_region` VALUES ('1150404', '贵德', '青海-海南-贵德', 1150404, '1150402', 1, NULL, '2018-03-30 12:00:00', 1, 2664, 2665);
INSERT INTO `base_region` VALUES ('1150406', '兴海', '青海-海南-兴海', 1150406, '1150402', 1, NULL, '2018-03-30 12:00:00', 1, 2666, 2667);
INSERT INTO `base_region` VALUES ('1150407', '贵南', '青海-海南-贵南', 1150407, '1150402', 1, NULL, '2018-03-30 12:00:00', 1, 2668, 2669);
INSERT INTO `base_region` VALUES ('1150408', '同德', '青海-海南-同德', 1150408, '1150402', 1, NULL, '2018-03-30 12:00:00', 1, 2670, 2671);
INSERT INTO `base_region` VALUES ('1150501', '玛沁', '青海-果洛-玛沁', 1150501, '1150507', 1, NULL, '2018-03-30 12:00:00', 1, 2674, 2675);
INSERT INTO `base_region` VALUES ('1150502', '班玛', '青海-果洛-班玛', 1150502, '1150507', 1, NULL, '2018-03-30 12:00:00', 1, 2676, 2677);
INSERT INTO `base_region` VALUES ('1150503', '甘德', '青海-果洛-甘德', 1150503, '1150507', 1, NULL, '2018-03-30 12:00:00', 1, 2678, 2679);
INSERT INTO `base_region` VALUES ('1150504', '达日', '青海-果洛-达日', 1150504, '1150507', 1, NULL, '2018-03-30 12:00:00', 1, 2680, 2681);
INSERT INTO `base_region` VALUES ('1150505', '久治', '青海-果洛-久治', 1150505, '1150507', 1, NULL, '2018-03-30 12:00:00', 1, 2682, 2683);
INSERT INTO `base_region` VALUES ('1150506', '玛多', '青海-果洛-玛多', 1150506, '1150507', 1, NULL, '2018-03-30 12:00:00', 1, 2684, 2685);
INSERT INTO `base_region` VALUES ('1150507', '果洛', '青海-果洛', 1150507, '1150000', 0, NULL, '2018-03-30 12:00:00', 1, 2673, 2686);
INSERT INTO `base_region` VALUES ('1150601', '玉树', '青海-玉树', 1150601, '1150000', 0, NULL, '2018-03-30 12:00:00', 1, 2687, 2698);
INSERT INTO `base_region` VALUES ('1150602', '称多', '青海-玉树-称多', 1150602, '1150601', 1, NULL, '2018-03-30 12:00:00', 1, 2688, 2689);
INSERT INTO `base_region` VALUES ('1150603', '治多', '青海-玉树-治多', 1150603, '1150601', 1, NULL, '2018-03-30 12:00:00', 1, 2690, 2691);
INSERT INTO `base_region` VALUES ('1150604', '杂多', '青海-玉树-杂多', 1150604, '1150601', 1, NULL, '2018-03-30 12:00:00', 1, 2692, 2693);
INSERT INTO `base_region` VALUES ('1150605', '囊谦', '青海-玉树-囊谦', 1150605, '1150601', 1, NULL, '2018-03-30 12:00:00', 1, 2694, 2695);
INSERT INTO `base_region` VALUES ('1150606', '曲麻莱', '青海-玉树-曲麻莱', 1150606, '1150601', 1, NULL, '2018-03-30 12:00:00', 1, 2696, 2697);
INSERT INTO `base_region` VALUES ('1150701', '德令哈', '青海-海西-德令哈', 1150701, '1150702', 1, NULL, '2018-03-30 12:00:00', 1, 2700, 2701);
INSERT INTO `base_region` VALUES ('1150702', '海西', '青海-海西', 1150702, '1150000', 0, NULL, '2018-03-30 12:00:00', 1, 2699, 2716);
INSERT INTO `base_region` VALUES ('1150708', '天峻', '青海-海西-天峻', 1150708, '1150702', 1, NULL, '2018-03-30 12:00:00', 1, 2702, 2703);
INSERT INTO `base_region` VALUES ('1150709', '乌兰', '青海-海西-乌兰', 1150709, '1150702', 1, NULL, '2018-03-30 12:00:00', 1, 2704, 2705);
INSERT INTO `base_region` VALUES ('1150712', '茫崖', '青海-海西-茫崖', 1150712, '1150702', 1, NULL, '2018-03-30 12:00:00', 1, 2706, 2707);
INSERT INTO `base_region` VALUES ('1150713', '大柴旦', '青海-海西-大柴旦', 1150713, '1150702', 1, NULL, '2018-03-30 12:00:00', 1, 2708, 2709);
INSERT INTO `base_region` VALUES ('1150714', '格尔木', '青海-海西-格尔木', 1150714, '1150702', 1, NULL, '2018-03-30 12:00:00', 1, 2710, 2711);
INSERT INTO `base_region` VALUES ('1150715', '都兰', '青海-海西-都兰', 1150715, '1150702', 1, NULL, '2018-03-30 12:00:00', 1, 2712, 2713);
INSERT INTO `base_region` VALUES ('1150716', '冷湖', '青海-海西-冷湖', 1150716, '1150702', 1, NULL, '2018-03-30 12:00:00', 1, 2714, 2715);
INSERT INTO `base_region` VALUES ('1150801', '海晏', '青海-海北-海晏', 1150801, '1150804', 1, NULL, '2018-03-30 12:00:00', 1, 2718, 2719);
INSERT INTO `base_region` VALUES ('1150802', '门源', '青海-海北-门源', 1150802, '1150804', 1, NULL, '2018-03-30 12:00:00', 1, 2720, 2721);
INSERT INTO `base_region` VALUES ('1150803', '祁连', '青海-海北-祁连', 1150803, '1150804', 1, NULL, '2018-03-30 12:00:00', 1, 2722, 2723);
INSERT INTO `base_region` VALUES ('1150804', '海北', '青海-海北', 1150804, '1150000', 0, NULL, '2018-03-30 12:00:00', 1, 2717, 2726);
INSERT INTO `base_region` VALUES ('1150806', '刚察', '青海-海北-刚察', 1150806, '1150804', 1, NULL, '2018-03-30 12:00:00', 1, 2724, 2725);
INSERT INTO `base_region` VALUES ('1160000', '甘肃', '甘肃', 1160000, 'ROOT', 0, NULL, '2018-03-30 12:00:00', 1, 2728, 2923);
INSERT INTO `base_region` VALUES ('1160101', '兰州', '甘肃-兰州', 1160101, '1160000', 0, NULL, '2018-03-30 12:00:00', 1, 2729, 2746);
INSERT INTO `base_region` VALUES ('1160102', '皋兰', '甘肃-兰州-皋兰', 1160102, '1160101', 1, NULL, '2018-03-30 12:00:00', 1, 2730, 2731);
INSERT INTO `base_region` VALUES ('1160103', '永登', '甘肃-兰州-永登', 1160103, '1160101', 1, NULL, '2018-03-30 12:00:00', 1, 2732, 2733);
INSERT INTO `base_region` VALUES ('1160104', '榆中', '甘肃-兰州-榆中', 1160104, '1160101', 1, NULL, '2018-03-30 12:00:00', 1, 2734, 2735);
INSERT INTO `base_region` VALUES ('1160105', '城关', '甘肃-兰州-城关', 1160105, '1160101', 1, NULL, '2018-03-30 12:00:00', 1, 2736, 2737);
INSERT INTO `base_region` VALUES ('1160106', '七里河', '甘肃-兰州-七里河', 1160106, '1160101', 1, NULL, '2018-03-30 12:00:00', 1, 2738, 2739);
INSERT INTO `base_region` VALUES ('1160107', '西固', '甘肃-兰州-西固', 1160107, '1160101', 1, NULL, '2018-03-30 12:00:00', 1, 2740, 2741);
INSERT INTO `base_region` VALUES ('1160108', '安宁', '甘肃-兰州-安宁', 1160108, '1160101', 1, NULL, '2018-03-30 12:00:00', 1, 2742, 2743);
INSERT INTO `base_region` VALUES ('1160109', '红古', '甘肃-兰州-红古', 1160109, '1160101', 1, NULL, '2018-03-30 12:00:00', 1, 2744, 2745);
INSERT INTO `base_region` VALUES ('1160201', '定西', '甘肃-定西', 1160201, '1160000', 0, NULL, '2018-03-30 12:00:00', 1, 2747, 2762);
INSERT INTO `base_region` VALUES ('1160202', '通渭', '甘肃-定西-通渭', 1160202, '1160201', 1, NULL, '2018-03-30 12:00:00', 1, 2748, 2749);
INSERT INTO `base_region` VALUES ('1160203', '陇西', '甘肃-定西-陇西', 1160203, '1160201', 1, NULL, '2018-03-30 12:00:00', 1, 2750, 2751);
INSERT INTO `base_region` VALUES ('1160204', '渭源', '甘肃-定西-渭源', 1160204, '1160201', 1, NULL, '2018-03-30 12:00:00', 1, 2752, 2753);
INSERT INTO `base_region` VALUES ('1160205', '临洮', '甘肃-定西-临洮', 1160205, '1160201', 1, NULL, '2018-03-30 12:00:00', 1, 2754, 2755);
INSERT INTO `base_region` VALUES ('1160206', '漳县', '甘肃-定西-漳县', 1160206, '1160201', 1, NULL, '2018-03-30 12:00:00', 1, 2756, 2757);
INSERT INTO `base_region` VALUES ('1160207', '岷县', '甘肃-定西-岷县', 1160207, '1160201', 1, NULL, '2018-03-30 12:00:00', 1, 2758, 2759);
INSERT INTO `base_region` VALUES ('1160208', '安定', '甘肃-定西-安定', 1160208, '1160201', 1, NULL, '2018-03-30 12:00:00', 1, 2760, 2761);
INSERT INTO `base_region` VALUES ('1160301', '平凉', '甘肃-平凉', 1160301, '1160000', 0, NULL, '2018-03-30 12:00:00', 1, 2763, 2778);
INSERT INTO `base_region` VALUES ('1160302', '泾川', '甘肃-平凉-泾川', 1160302, '1160301', 1, NULL, '2018-03-30 12:00:00', 1, 2764, 2765);
INSERT INTO `base_region` VALUES ('1160303', '灵台', '甘肃-平凉-灵台', 1160303, '1160301', 1, NULL, '2018-03-30 12:00:00', 1, 2766, 2767);
INSERT INTO `base_region` VALUES ('1160304', '崇信', '甘肃-平凉-崇信', 1160304, '1160301', 1, NULL, '2018-03-30 12:00:00', 1, 2768, 2769);
INSERT INTO `base_region` VALUES ('1160305', '华亭', '甘肃-平凉-华亭', 1160305, '1160301', 1, NULL, '2018-03-30 12:00:00', 1, 2770, 2771);
INSERT INTO `base_region` VALUES ('1160306', '庄浪', '甘肃-平凉-庄浪', 1160306, '1160301', 1, NULL, '2018-03-30 12:00:00', 1, 2772, 2773);
INSERT INTO `base_region` VALUES ('1160307', '静宁', '甘肃-平凉-静宁', 1160307, '1160301', 1, NULL, '2018-03-30 12:00:00', 1, 2774, 2775);
INSERT INTO `base_region` VALUES ('1160308', '崆峒', '甘肃-平凉-崆峒', 1160308, '1160301', 1, NULL, '2018-03-30 12:00:00', 1, 2776, 2777);
INSERT INTO `base_region` VALUES ('1160401', '庆阳', '甘肃-庆阳', 1160401, '1160000', 0, NULL, '2018-03-30 12:00:00', 1, 2779, 2796);
INSERT INTO `base_region` VALUES ('1160402', '西峰', '甘肃-庆阳-西峰', 1160402, '1160401', 1, NULL, '2018-03-30 12:00:00', 1, 2780, 2781);
INSERT INTO `base_region` VALUES ('1160403', '环县', '甘肃-庆阳-环县', 1160403, '1160401', 1, NULL, '2018-03-30 12:00:00', 1, 2782, 2783);
INSERT INTO `base_region` VALUES ('1160404', '华池', '甘肃-庆阳-华池', 1160404, '1160401', 1, NULL, '2018-03-30 12:00:00', 1, 2784, 2785);
INSERT INTO `base_region` VALUES ('1160405', '合水', '甘肃-庆阳-合水', 1160405, '1160401', 1, NULL, '2018-03-30 12:00:00', 1, 2786, 2787);
INSERT INTO `base_region` VALUES ('1160406', '正宁', '甘肃-庆阳-正宁', 1160406, '1160401', 1, NULL, '2018-03-30 12:00:00', 1, 2788, 2789);
INSERT INTO `base_region` VALUES ('1160407', '宁县', '甘肃-庆阳-宁县', 1160407, '1160401', 1, NULL, '2018-03-30 12:00:00', 1, 2790, 2791);
INSERT INTO `base_region` VALUES ('1160408', '镇原', '甘肃-庆阳-镇原', 1160408, '1160401', 1, NULL, '2018-03-30 12:00:00', 1, 2792, 2793);
INSERT INTO `base_region` VALUES ('1160409', '庆城', '甘肃-庆阳-庆城', 1160409, '1160401', 1, NULL, '2018-03-30 12:00:00', 1, 2794, 2795);
INSERT INTO `base_region` VALUES ('1160501', '武威', '甘肃-武威', 1160501, '1160000', 0, NULL, '2018-03-30 12:00:00', 1, 2797, 2806);
INSERT INTO `base_region` VALUES ('1160502', '民勤', '甘肃-武威-民勤', 1160502, '1160501', 1, NULL, '2018-03-30 12:00:00', 1, 2798, 2799);
INSERT INTO `base_region` VALUES ('1160503', '古浪', '甘肃-武威-古浪', 1160503, '1160501', 1, NULL, '2018-03-30 12:00:00', 1, 2800, 2801);
INSERT INTO `base_region` VALUES ('1160504', '凉州', '甘肃-武威-凉州', 1160504, '1160501', 1, NULL, '2018-03-30 12:00:00', 1, 2802, 2803);
INSERT INTO `base_region` VALUES ('1160505', '天祝', '甘肃-武威-天祝', 1160505, '1160501', 1, NULL, '2018-03-30 12:00:00', 1, 2804, 2805);
INSERT INTO `base_region` VALUES ('1160601', '金昌', '甘肃-金昌', 1160601, '1160000', 0, NULL, '2018-03-30 12:00:00', 1, 2807, 2812);
INSERT INTO `base_region` VALUES ('1160602', '永昌', '甘肃-金昌-永昌', 1160602, '1160601', 1, NULL, '2018-03-30 12:00:00', 1, 2808, 2809);
INSERT INTO `base_region` VALUES ('1160603', '金川', '甘肃-金昌-金川', 1160603, '1160601', 1, NULL, '2018-03-30 12:00:00', 1, 2810, 2811);
INSERT INTO `base_region` VALUES ('1160701', '张掖', '甘肃-张掖', 1160701, '1160000', 0, NULL, '2018-03-30 12:00:00', 1, 2813, 2826);
INSERT INTO `base_region` VALUES ('1160702', '肃南', '甘肃-张掖-肃南', 1160702, '1160701', 1, NULL, '2018-03-30 12:00:00', 1, 2814, 2815);
INSERT INTO `base_region` VALUES ('1160703', '民乐', '甘肃-张掖-民乐', 1160703, '1160701', 1, NULL, '2018-03-30 12:00:00', 1, 2816, 2817);
INSERT INTO `base_region` VALUES ('1160704', '临泽', '甘肃-张掖-临泽', 1160704, '1160701', 1, NULL, '2018-03-30 12:00:00', 1, 2818, 2819);
INSERT INTO `base_region` VALUES ('1160705', '高台', '甘肃-张掖-高台', 1160705, '1160701', 1, NULL, '2018-03-30 12:00:00', 1, 2820, 2821);
INSERT INTO `base_region` VALUES ('1160706', '山丹', '甘肃-张掖-山丹', 1160706, '1160701', 1, NULL, '2018-03-30 12:00:00', 1, 2822, 2823);
INSERT INTO `base_region` VALUES ('1160707', '甘州', '甘肃-张掖-甘州', 1160707, '1160701', 1, NULL, '2018-03-30 12:00:00', 1, 2824, 2825);
INSERT INTO `base_region` VALUES ('1160801', '酒泉', '甘肃-酒泉', 1160801, '1160000', 0, NULL, '2018-03-30 12:00:00', 1, 2827, 2842);
INSERT INTO `base_region` VALUES ('1160802', '肃州', '甘肃-酒泉-肃州', 1160802, '1160801', 1, NULL, '2018-03-30 12:00:00', 1, 2828, 2829);
INSERT INTO `base_region` VALUES ('1160803', '金塔', '甘肃-酒泉-金塔', 1160803, '1160801', 1, NULL, '2018-03-30 12:00:00', 1, 2830, 2831);
INSERT INTO `base_region` VALUES ('1160804', '阿克塞', '甘肃-酒泉-阿克塞', 1160804, '1160801', 1, NULL, '2018-03-30 12:00:00', 1, 2832, 2833);
INSERT INTO `base_region` VALUES ('1160805', '瓜州', '甘肃-酒泉-瓜州', 1160805, '1160801', 1, NULL, '2018-03-30 12:00:00', 1, 2834, 2835);
INSERT INTO `base_region` VALUES ('1160806', '肃北', '甘肃-酒泉-肃北', 1160806, '1160801', 1, NULL, '2018-03-30 12:00:00', 1, 2836, 2837);
INSERT INTO `base_region` VALUES ('1160807', '玉门', '甘肃-酒泉-玉门', 1160807, '1160801', 1, NULL, '2018-03-30 12:00:00', 1, 2838, 2839);
INSERT INTO `base_region` VALUES ('1160808', '敦煌', '甘肃-酒泉-敦煌', 1160808, '1160801', 1, NULL, '2018-03-30 12:00:00', 1, 2840, 2841);
INSERT INTO `base_region` VALUES ('1160901', '天水', '甘肃-天水', 1160901, '1160000', 0, NULL, '2018-03-30 12:00:00', 1, 2843, 2858);
INSERT INTO `base_region` VALUES ('1160902', '秦州', '甘肃-天水-秦州', 1160902, '1160901', 1, NULL, '2018-03-30 12:00:00', 1, 2844, 2845);
INSERT INTO `base_region` VALUES ('1160903', '清水', '甘肃-天水-清水', 1160903, '1160901', 1, NULL, '2018-03-30 12:00:00', 1, 2846, 2847);
INSERT INTO `base_region` VALUES ('1160904', '秦安', '甘肃-天水-秦安', 1160904, '1160901', 1, NULL, '2018-03-30 12:00:00', 1, 2848, 2849);
INSERT INTO `base_region` VALUES ('1160905', '甘谷', '甘肃-天水-甘谷', 1160905, '1160901', 1, NULL, '2018-03-30 12:00:00', 1, 2850, 2851);
INSERT INTO `base_region` VALUES ('1160906', '武山', '甘肃-天水-武山', 1160906, '1160901', 1, NULL, '2018-03-30 12:00:00', 1, 2852, 2853);
INSERT INTO `base_region` VALUES ('1160907', '张家川', '甘肃-天水-张家川', 1160907, '1160901', 1, NULL, '2018-03-30 12:00:00', 1, 2854, 2855);
INSERT INTO `base_region` VALUES ('1160908', '麦积', '甘肃-天水-麦积', 1160908, '1160901', 1, NULL, '2018-03-30 12:00:00', 1, 2856, 2857);
INSERT INTO `base_region` VALUES ('1161001', '武都', '甘肃-陇南-武都', 1161001, '1161010', 1, NULL, '2018-03-30 12:00:00', 1, 2860, 2861);
INSERT INTO `base_region` VALUES ('1161002', '成县', '甘肃-陇南-成县', 1161002, '1161010', 1, NULL, '2018-03-30 12:00:00', 1, 2862, 2863);
INSERT INTO `base_region` VALUES ('1161003', '文县', '甘肃-陇南-文县', 1161003, '1161010', 1, NULL, '2018-03-30 12:00:00', 1, 2864, 2865);
INSERT INTO `base_region` VALUES ('1161004', '宕昌', '甘肃-陇南-宕昌', 1161004, '1161010', 1, NULL, '2018-03-30 12:00:00', 1, 2866, 2867);
INSERT INTO `base_region` VALUES ('1161005', '康县', '甘肃-陇南-康县', 1161005, '1161010', 1, NULL, '2018-03-30 12:00:00', 1, 2868, 2869);
INSERT INTO `base_region` VALUES ('1161006', '西和', '甘肃-陇南-西和', 1161006, '1161010', 1, NULL, '2018-03-30 12:00:00', 1, 2870, 2871);
INSERT INTO `base_region` VALUES ('1161007', '礼县', '甘肃-陇南-礼县', 1161007, '1161010', 1, NULL, '2018-03-30 12:00:00', 1, 2872, 2873);
INSERT INTO `base_region` VALUES ('1161008', '徽县', '甘肃-陇南-徽县', 1161008, '1161010', 1, NULL, '2018-03-30 12:00:00', 1, 2874, 2875);
INSERT INTO `base_region` VALUES ('1161009', '两当', '甘肃-陇南-两当', 1161009, '1161010', 1, NULL, '2018-03-30 12:00:00', 1, 2876, 2877);
INSERT INTO `base_region` VALUES ('1161010', '陇南', '甘肃-陇南', 1161010, '1160000', 0, NULL, '2018-03-30 12:00:00', 1, 2859, 2878);
INSERT INTO `base_region` VALUES ('1161101', '临夏', '甘肃-临夏', 1161101, '1160000', 0, NULL, '2018-03-30 12:00:00', 1, 2879, 2892);
INSERT INTO `base_region` VALUES ('1161102', '康乐', '甘肃-临夏-康乐', 1161102, '1161101', 1, NULL, '2018-03-30 12:00:00', 1, 2880, 2881);
INSERT INTO `base_region` VALUES ('1161103', '永靖', '甘肃-临夏-永靖', 1161103, '1161101', 1, NULL, '2018-03-30 12:00:00', 1, 2882, 2883);
INSERT INTO `base_region` VALUES ('1161104', '广河', '甘肃-临夏-广河', 1161104, '1161101', 1, NULL, '2018-03-30 12:00:00', 1, 2884, 2885);
INSERT INTO `base_region` VALUES ('1161105', '和政', '甘肃-临夏-和政', 1161105, '1161101', 1, NULL, '2018-03-30 12:00:00', 1, 2886, 2887);
INSERT INTO `base_region` VALUES ('1161106', '东乡', '甘肃-临夏-东乡', 1161106, '1161101', 1, NULL, '2018-03-30 12:00:00', 1, 2888, 2889);
INSERT INTO `base_region` VALUES ('1161107', '积石山', '甘肃-临夏-积石山', 1161107, '1161101', 1, NULL, '2018-03-30 12:00:00', 1, 2890, 2891);
INSERT INTO `base_region` VALUES ('1161201', '合作', '甘肃-甘南-合作', 1161201, '1161209', 1, NULL, '2018-03-30 12:00:00', 1, 2894, 2895);
INSERT INTO `base_region` VALUES ('1161202', '临潭', '甘肃-甘南-临潭', 1161202, '1161209', 1, NULL, '2018-03-30 12:00:00', 1, 2896, 2897);
INSERT INTO `base_region` VALUES ('1161203', '卓尼', '甘肃-甘南-卓尼', 1161203, '1161209', 1, NULL, '2018-03-30 12:00:00', 1, 2898, 2899);
INSERT INTO `base_region` VALUES ('1161204', '舟曲', '甘肃-甘南-舟曲', 1161204, '1161209', 1, NULL, '2018-03-30 12:00:00', 1, 2900, 2901);
INSERT INTO `base_region` VALUES ('1161205', '迭部', '甘肃-甘南-迭部', 1161205, '1161209', 1, NULL, '2018-03-30 12:00:00', 1, 2902, 2903);
INSERT INTO `base_region` VALUES ('1161206', '玛曲', '甘肃-甘南-玛曲', 1161206, '1161209', 1, NULL, '2018-03-30 12:00:00', 1, 2904, 2905);
INSERT INTO `base_region` VALUES ('1161207', '碌曲', '甘肃-甘南-碌曲', 1161207, '1161209', 1, NULL, '2018-03-30 12:00:00', 1, 2906, 2907);
INSERT INTO `base_region` VALUES ('1161208', '夏河', '甘肃-甘南-夏河', 1161208, '1161209', 1, NULL, '2018-03-30 12:00:00', 1, 2908, 2909);
INSERT INTO `base_region` VALUES ('1161209', '甘南', '甘肃-甘南', 1161209, '1160000', 0, NULL, '2018-03-30 12:00:00', 1, 2893, 2910);
INSERT INTO `base_region` VALUES ('1161301', '白银', '甘肃-白银', 1161301, '1160000', 0, NULL, '2018-03-30 12:00:00', 1, 2911, 2920);
INSERT INTO `base_region` VALUES ('1161302', '靖远', '甘肃-白银-靖远', 1161302, '1161301', 1, NULL, '2018-03-30 12:00:00', 1, 2912, 2913);
INSERT INTO `base_region` VALUES ('1161303', '会宁', '甘肃-白银-会宁', 1161303, '1161301', 1, NULL, '2018-03-30 12:00:00', 1, 2914, 2915);
INSERT INTO `base_region` VALUES ('1161304', '平川', '甘肃-白银-平川', 1161304, '1161301', 1, NULL, '2018-03-30 12:00:00', 1, 2916, 2917);
INSERT INTO `base_region` VALUES ('1161305', '景泰', '甘肃-白银-景泰', 1161305, '1161301', 1, NULL, '2018-03-30 12:00:00', 1, 2918, 2919);
INSERT INTO `base_region` VALUES ('1161401', '嘉峪关', '甘肃-嘉峪关', 1161401, '1160000', 0, NULL, '2018-03-30 12:00:00', 1, 2921, 2922);
INSERT INTO `base_region` VALUES ('1170000', '宁夏', '宁夏', 1170000, 'ROOT', 0, NULL, '2018-03-30 12:00:00', 1, 2924, 2979);
INSERT INTO `base_region` VALUES ('1170101', '银川', '宁夏-银川', 1170101, '1170000', 0, NULL, '2018-03-30 12:00:00', 1, 2925, 2938);
INSERT INTO `base_region` VALUES ('1170102', '永宁', '宁夏-银川-永宁', 1170102, '1170101', 1, NULL, '2018-03-30 12:00:00', 1, 2926, 2927);
INSERT INTO `base_region` VALUES ('1170103', '灵武', '宁夏-银川-灵武', 1170103, '1170101', 1, NULL, '2018-03-30 12:00:00', 1, 2928, 2929);
INSERT INTO `base_region` VALUES ('1170104', '贺兰', '宁夏-银川-贺兰', 1170104, '1170101', 1, NULL, '2018-03-30 12:00:00', 1, 2930, 2931);
INSERT INTO `base_region` VALUES ('1170105', '兴庆', '宁夏-银川-兴庆', 1170105, '1170101', 1, NULL, '2018-03-30 12:00:00', 1, 2932, 2933);
INSERT INTO `base_region` VALUES ('1170106', '西夏', '宁夏-银川-西夏', 1170106, '1170101', 1, NULL, '2018-03-30 12:00:00', 1, 2934, 2935);
INSERT INTO `base_region` VALUES ('1170107', '金凤', '宁夏-银川-金凤', 1170107, '1170101', 1, NULL, '2018-03-30 12:00:00', 1, 2936, 2937);
INSERT INTO `base_region` VALUES ('1170201', '石嘴山', '宁夏-石嘴山', 1170201, '1170000', 0, NULL, '2018-03-30 12:00:00', 1, 2939, 2946);
INSERT INTO `base_region` VALUES ('1170202', '惠农', '宁夏-石嘴山-惠农', 1170202, '1170201', 1, NULL, '2018-03-30 12:00:00', 1, 2940, 2941);
INSERT INTO `base_region` VALUES ('1170203', '平罗', '宁夏-石嘴山-平罗', 1170203, '1170201', 1, NULL, '2018-03-30 12:00:00', 1, 2942, 2943);
INSERT INTO `base_region` VALUES ('1170205', '大武口', '宁夏-石嘴山-大武口', 1170205, '1170201', 1, NULL, '2018-03-30 12:00:00', 1, 2944, 2945);
INSERT INTO `base_region` VALUES ('1170301', '吴忠', '宁夏-吴忠', 1170301, '1170000', 0, NULL, '2018-03-30 12:00:00', 1, 2947, 2958);
INSERT INTO `base_region` VALUES ('1170302', '同心', '宁夏-吴忠-同心', 1170302, '1170301', 1, NULL, '2018-03-30 12:00:00', 1, 2948, 2949);
INSERT INTO `base_region` VALUES ('1170303', '盐池', '宁夏-吴忠-盐池', 1170303, '1170301', 1, NULL, '2018-03-30 12:00:00', 1, 2950, 2951);
INSERT INTO `base_region` VALUES ('1170304', '利通', '宁夏-吴忠-利通', 1170304, '1170301', 1, NULL, '2018-03-30 12:00:00', 1, 2952, 2953);
INSERT INTO `base_region` VALUES ('1170305', '红寺堡', '宁夏-吴忠-红寺堡', 1170305, '1170301', 1, NULL, '2018-03-30 12:00:00', 1, 2954, 2955);
INSERT INTO `base_region` VALUES ('1170306', '青铜峡', '宁夏-吴忠-青铜峡', 1170306, '1170301', 1, NULL, '2018-03-30 12:00:00', 1, 2956, 2957);
INSERT INTO `base_region` VALUES ('1170401', '固原', '宁夏-固原', 1170401, '1170000', 0, NULL, '2018-03-30 12:00:00', 1, 2959, 2970);
INSERT INTO `base_region` VALUES ('1170402', '西吉', '宁夏-固原-西吉', 1170402, '1170401', 1, NULL, '2018-03-30 12:00:00', 1, 2960, 2961);
INSERT INTO `base_region` VALUES ('1170403', '隆德', '宁夏-固原-隆德', 1170403, '1170401', 1, NULL, '2018-03-30 12:00:00', 1, 2962, 2963);
INSERT INTO `base_region` VALUES ('1170404', '泾源', '宁夏-固原-泾源', 1170404, '1170401', 1, NULL, '2018-03-30 12:00:00', 1, 2964, 2965);
INSERT INTO `base_region` VALUES ('1170405', '原州', '宁夏-固原-原州', 1170405, '1170401', 1, NULL, '2018-03-30 12:00:00', 1, 2966, 2967);
INSERT INTO `base_region` VALUES ('1170406', '彭阳', '宁夏-固原-彭阳', 1170406, '1170401', 1, NULL, '2018-03-30 12:00:00', 1, 2968, 2969);
INSERT INTO `base_region` VALUES ('1170501', '中卫', '宁夏-中卫', 1170501, '1170000', 0, NULL, '2018-03-30 12:00:00', 1, 2971, 2978);
INSERT INTO `base_region` VALUES ('1170502', '中宁', '宁夏-中卫-中宁', 1170502, '1170501', 1, NULL, '2018-03-30 12:00:00', 1, 2972, 2973);
INSERT INTO `base_region` VALUES ('1170503', '沙坡头', '宁夏-中卫-沙坡头', 1170503, '1170501', 1, NULL, '2018-03-30 12:00:00', 1, 2974, 2975);
INSERT INTO `base_region` VALUES ('1170504', '海原', '宁夏-中卫-海原', 1170504, '1170501', 1, NULL, '2018-03-30 12:00:00', 1, 2976, 2977);
INSERT INTO `base_region` VALUES ('1180000', '河南', '河南', 1180000, 'ROOT', 0, NULL, '2018-03-30 12:00:00', 1, 2980, 3325);
INSERT INTO `base_region` VALUES ('1180101', '郑州', '河南-郑州', 1180101, '1180000', 0, NULL, '2018-03-30 12:00:00', 1, 2981, 3006);
INSERT INTO `base_region` VALUES ('1180102', '巩义', '河南-郑州-巩义', 1180102, '1180101', 1, NULL, '2018-03-30 12:00:00', 1, 2982, 2983);
INSERT INTO `base_region` VALUES ('1180103', '荥阳', '河南-郑州-荥阳', 1180103, '1180101', 1, NULL, '2018-03-30 12:00:00', 1, 2984, 2985);
INSERT INTO `base_region` VALUES ('1180104', '登封', '河南-郑州-登封', 1180104, '1180101', 1, NULL, '2018-03-30 12:00:00', 1, 2986, 2987);
INSERT INTO `base_region` VALUES ('1180105', '新密', '河南-郑州-新密', 1180105, '1180101', 1, NULL, '2018-03-30 12:00:00', 1, 2988, 2989);
INSERT INTO `base_region` VALUES ('1180106', '新郑', '河南-郑州-新郑', 1180106, '1180101', 1, NULL, '2018-03-30 12:00:00', 1, 2990, 2991);
INSERT INTO `base_region` VALUES ('1180107', '中牟', '河南-郑州-中牟', 1180107, '1180101', 1, NULL, '2018-03-30 12:00:00', 1, 2992, 2993);
INSERT INTO `base_region` VALUES ('1180108', '上街', '河南-郑州-上街', 1180108, '1180101', 1, NULL, '2018-03-30 12:00:00', 1, 2994, 2995);
INSERT INTO `base_region` VALUES ('1180109', '中原', '河南-郑州-中原', 1180109, '1180101', 1, NULL, '2018-03-30 12:00:00', 1, 2996, 2997);
INSERT INTO `base_region` VALUES ('1180110', '二七', '河南-郑州-二七', 1180110, '1180101', 1, NULL, '2018-03-30 12:00:00', 1, 2998, 2999);
INSERT INTO `base_region` VALUES ('1180111', '管城', '河南-郑州-管城', 1180111, '1180101', 1, NULL, '2018-03-30 12:00:00', 1, 3000, 3001);
INSERT INTO `base_region` VALUES ('1180112', '金水', '河南-郑州-金水', 1180112, '1180101', 1, NULL, '2018-03-30 12:00:00', 1, 3002, 3003);
INSERT INTO `base_region` VALUES ('1180113', '惠济', '河南-郑州-惠济', 1180113, '1180101', 1, NULL, '2018-03-30 12:00:00', 1, 3004, 3005);
INSERT INTO `base_region` VALUES ('1180201', '安阳', '河南-安阳', 1180201, '1180000', 0, NULL, '2018-03-30 12:00:00', 1, 3007, 3024);
INSERT INTO `base_region` VALUES ('1180202', '汤阴', '河南-安阳-汤阴', 1180202, '1180201', 1, NULL, '2018-03-30 12:00:00', 1, 3008, 3009);
INSERT INTO `base_region` VALUES ('1180203', '滑县', '河南-安阳-滑县', 1180203, '1180201', 1, NULL, '2018-03-30 12:00:00', 1, 3010, 3011);
INSERT INTO `base_region` VALUES ('1180204', '内黄', '河南-安阳-内黄', 1180204, '1180201', 1, NULL, '2018-03-30 12:00:00', 1, 3012, 3013);
INSERT INTO `base_region` VALUES ('1180205', '林州', '河南-安阳-林州', 1180205, '1180201', 1, NULL, '2018-03-30 12:00:00', 1, 3014, 3015);
INSERT INTO `base_region` VALUES ('1180206', '文峰', '河南-安阳-文峰', 1180206, '1180201', 1, NULL, '2018-03-30 12:00:00', 1, 3016, 3017);
INSERT INTO `base_region` VALUES ('1180207', '北关', '河南-安阳-北关', 1180207, '1180201', 1, NULL, '2018-03-30 12:00:00', 1, 3018, 3019);
INSERT INTO `base_region` VALUES ('1180208', '殷都', '河南-安阳-殷都', 1180208, '1180201', 1, NULL, '2018-03-30 12:00:00', 1, 3020, 3021);
INSERT INTO `base_region` VALUES ('1180209', '龙安', '河南-安阳-龙安', 1180209, '1180201', 1, NULL, '2018-03-30 12:00:00', 1, 3022, 3023);
INSERT INTO `base_region` VALUES ('1180301', '新乡', '河南-新乡', 1180301, '1180000', 0, NULL, '2018-03-30 12:00:00', 1, 3025, 3048);
INSERT INTO `base_region` VALUES ('1180302', '获嘉', '河南-新乡-获嘉', 1180302, '1180301', 1, NULL, '2018-03-30 12:00:00', 1, 3026, 3027);
INSERT INTO `base_region` VALUES ('1180303', '原阳', '河南-新乡-原阳', 1180303, '1180301', 1, NULL, '2018-03-30 12:00:00', 1, 3028, 3029);
INSERT INTO `base_region` VALUES ('1180304', '辉县', '河南-新乡-辉县', 1180304, '1180301', 1, NULL, '2018-03-30 12:00:00', 1, 3030, 3031);
INSERT INTO `base_region` VALUES ('1180305', '卫辉', '河南-新乡-卫辉', 1180305, '1180301', 1, NULL, '2018-03-30 12:00:00', 1, 3032, 3033);
INSERT INTO `base_region` VALUES ('1180306', '延津', '河南-新乡-延津', 1180306, '1180301', 1, NULL, '2018-03-30 12:00:00', 1, 3034, 3035);
INSERT INTO `base_region` VALUES ('1180307', '封丘', '河南-新乡-封丘', 1180307, '1180301', 1, NULL, '2018-03-30 12:00:00', 1, 3036, 3037);
INSERT INTO `base_region` VALUES ('1180308', '长垣', '河南-新乡-长垣', 1180308, '1180301', 1, NULL, '2018-03-30 12:00:00', 1, 3038, 3039);
INSERT INTO `base_region` VALUES ('1180309', '红旗', '河南-新乡-红旗', 1180309, '1180301', 1, NULL, '2018-03-30 12:00:00', 1, 3040, 3041);
INSERT INTO `base_region` VALUES ('1180310', '卫滨', '河南-新乡-卫滨', 1180310, '1180301', 1, NULL, '2018-03-30 12:00:00', 1, 3042, 3043);
INSERT INTO `base_region` VALUES ('1180311', '凤泉', '河南-新乡-凤泉', 1180311, '1180301', 1, NULL, '2018-03-30 12:00:00', 1, 3044, 3045);
INSERT INTO `base_region` VALUES ('1180312', '牧野', '河南-新乡-牧野', 1180312, '1180301', 1, NULL, '2018-03-30 12:00:00', 1, 3046, 3047);
INSERT INTO `base_region` VALUES ('1180401', '许昌', '河南-许昌', 1180401, '1180000', 0, NULL, '2018-03-30 12:00:00', 1, 3049, 3060);
INSERT INTO `base_region` VALUES ('1180402', '鄢陵', '河南-许昌-鄢陵', 1180402, '1180401', 1, NULL, '2018-03-30 12:00:00', 1, 3050, 3051);
INSERT INTO `base_region` VALUES ('1180403', '襄城', '河南-许昌-襄城', 1180403, '1180401', 1, NULL, '2018-03-30 12:00:00', 1, 3052, 3053);
INSERT INTO `base_region` VALUES ('1180404', '长葛', '河南-许昌-长葛', 1180404, '1180401', 1, NULL, '2018-03-30 12:00:00', 1, 3054, 3055);
INSERT INTO `base_region` VALUES ('1180405', '禹州', '河南-许昌-禹州', 1180405, '1180401', 1, NULL, '2018-03-30 12:00:00', 1, 3056, 3057);
INSERT INTO `base_region` VALUES ('1180406', '魏都', '河南-许昌-魏都', 1180406, '1180401', 1, NULL, '2018-03-30 12:00:00', 1, 3058, 3059);
INSERT INTO `base_region` VALUES ('1180501', '平顶山', '河南-平顶山', 1180501, '1180000', 0, NULL, '2018-03-30 12:00:00', 1, 3061, 3082);
INSERT INTO `base_region` VALUES ('1180502', '郏县', '河南-平顶山-郏县', 1180502, '1180501', 1, NULL, '2018-03-30 12:00:00', 1, 3062, 3063);
INSERT INTO `base_region` VALUES ('1180503', '宝丰', '河南-平顶山-宝丰', 1180503, '1180501', 1, NULL, '2018-03-30 12:00:00', 1, 3064, 3065);
INSERT INTO `base_region` VALUES ('1180504', '汝州', '河南-平顶山-汝州', 1180504, '1180501', 1, NULL, '2018-03-30 12:00:00', 1, 3066, 3067);
INSERT INTO `base_region` VALUES ('1180505', '叶县', '河南-平顶山-叶县', 1180505, '1180501', 1, NULL, '2018-03-30 12:00:00', 1, 3068, 3069);
INSERT INTO `base_region` VALUES ('1180506', '舞钢', '河南-平顶山-舞钢', 1180506, '1180501', 1, NULL, '2018-03-30 12:00:00', 1, 3070, 3071);
INSERT INTO `base_region` VALUES ('1180507', '鲁山', '河南-平顶山-鲁山', 1180507, '1180501', 1, NULL, '2018-03-30 12:00:00', 1, 3072, 3073);
INSERT INTO `base_region` VALUES ('1180508', '石龙', '河南-平顶山-石龙', 1180508, '1180501', 1, NULL, '2018-03-30 12:00:00', 1, 3074, 3075);
INSERT INTO `base_region` VALUES ('1180509', '新华', '河南-平顶山-新华', 1180509, '1180501', 1, NULL, '2018-03-30 12:00:00', 1, 3076, 3077);
INSERT INTO `base_region` VALUES ('1180510', '卫东', '河南-平顶山-卫东', 1180510, '1180501', 1, NULL, '2018-03-30 12:00:00', 1, 3078, 3079);
INSERT INTO `base_region` VALUES ('1180511', '湛河', '河南-平顶山-湛河', 1180511, '1180501', 1, NULL, '2018-03-30 12:00:00', 1, 3080, 3081);
INSERT INTO `base_region` VALUES ('1180601', '信阳', '河南-信阳', 1180601, '1180000', 0, NULL, '2018-03-30 12:00:00', 1, 3083, 3104);
INSERT INTO `base_region` VALUES ('1180602', '息县', '河南-信阳-息县', 1180602, '1180601', 1, NULL, '2018-03-30 12:00:00', 1, 3084, 3085);
INSERT INTO `base_region` VALUES ('1180603', '罗山', '河南-信阳-罗山', 1180603, '1180601', 1, NULL, '2018-03-30 12:00:00', 1, 3086, 3087);
INSERT INTO `base_region` VALUES ('1180604', '光山', '河南-信阳-光山', 1180604, '1180601', 1, NULL, '2018-03-30 12:00:00', 1, 3088, 3089);
INSERT INTO `base_region` VALUES ('1180605', '新县', '河南-信阳-新县', 1180605, '1180601', 1, NULL, '2018-03-30 12:00:00', 1, 3090, 3091);
INSERT INTO `base_region` VALUES ('1180606', '淮滨', '河南-信阳-淮滨', 1180606, '1180601', 1, NULL, '2018-03-30 12:00:00', 1, 3092, 3093);
INSERT INTO `base_region` VALUES ('1180607', '潢川', '河南-信阳-潢川', 1180607, '1180601', 1, NULL, '2018-03-30 12:00:00', 1, 3094, 3095);
INSERT INTO `base_region` VALUES ('1180608', '固始', '河南-信阳-固始', 1180608, '1180601', 1, NULL, '2018-03-30 12:00:00', 1, 3096, 3097);
INSERT INTO `base_region` VALUES ('1180609', '商城', '河南-信阳-商城', 1180609, '1180601', 1, NULL, '2018-03-30 12:00:00', 1, 3098, 3099);
INSERT INTO `base_region` VALUES ('1180610', '浉河', '河南-信阳-浉河', 1180610, '1180601', 1, NULL, '2018-03-30 12:00:00', 1, 3100, 3101);
INSERT INTO `base_region` VALUES ('1180611', '平桥', '河南-信阳-平桥', 1180611, '1180601', 1, NULL, '2018-03-30 12:00:00', 1, 3102, 3103);
INSERT INTO `base_region` VALUES ('1180701', '南阳', '河南-南阳', 1180701, '1180000', 0, NULL, '2018-03-30 12:00:00', 1, 3105, 3132);
INSERT INTO `base_region` VALUES ('1180702', '南召', '河南-南阳-南召', 1180702, '1180701', 1, NULL, '2018-03-30 12:00:00', 1, 3106, 3107);
INSERT INTO `base_region` VALUES ('1180703', '方城', '河南-南阳-方城', 1180703, '1180701', 1, NULL, '2018-03-30 12:00:00', 1, 3108, 3109);
INSERT INTO `base_region` VALUES ('1180704', '社旗', '河南-南阳-社旗', 1180704, '1180701', 1, NULL, '2018-03-30 12:00:00', 1, 3110, 3111);
INSERT INTO `base_region` VALUES ('1180705', '西峡', '河南-南阳-西峡', 1180705, '1180701', 1, NULL, '2018-03-30 12:00:00', 1, 3112, 3113);
INSERT INTO `base_region` VALUES ('1180706', '内乡', '河南-南阳-内乡', 1180706, '1180701', 1, NULL, '2018-03-30 12:00:00', 1, 3114, 3115);
INSERT INTO `base_region` VALUES ('1180707', '镇平', '河南-南阳-镇平', 1180707, '1180701', 1, NULL, '2018-03-30 12:00:00', 1, 3116, 3117);
INSERT INTO `base_region` VALUES ('1180708', '淅川', '河南-南阳-淅川', 1180708, '1180701', 1, NULL, '2018-03-30 12:00:00', 1, 3118, 3119);
INSERT INTO `base_region` VALUES ('1180709', '新野', '河南-南阳-新野', 1180709, '1180701', 1, NULL, '2018-03-30 12:00:00', 1, 3120, 3121);
INSERT INTO `base_region` VALUES ('1180710', '唐河', '河南-南阳-唐河', 1180710, '1180701', 1, NULL, '2018-03-30 12:00:00', 1, 3122, 3123);
INSERT INTO `base_region` VALUES ('1180711', '邓州', '河南-南阳-邓州', 1180711, '1180701', 1, NULL, '2018-03-30 12:00:00', 1, 3124, 3125);
INSERT INTO `base_region` VALUES ('1180712', '桐柏', '河南-南阳-桐柏', 1180712, '1180701', 1, NULL, '2018-03-30 12:00:00', 1, 3126, 3127);
INSERT INTO `base_region` VALUES ('1180713', '宛城', '河南-南阳-宛城', 1180713, '1180701', 1, NULL, '2018-03-30 12:00:00', 1, 3128, 3129);
INSERT INTO `base_region` VALUES ('1180714', '卧龙', '河南-南阳-卧龙', 1180714, '1180701', 1, NULL, '2018-03-30 12:00:00', 1, 3130, 3131);
INSERT INTO `base_region` VALUES ('1180801', '开封', '河南-开封', 1180801, '1180000', 0, NULL, '2018-03-30 12:00:00', 1, 3133, 3152);
INSERT INTO `base_region` VALUES ('1180802', '杞县', '河南-开封-杞县', 1180802, '1180801', 1, NULL, '2018-03-30 12:00:00', 1, 3134, 3135);
INSERT INTO `base_region` VALUES ('1180803', '尉氏', '河南-开封-尉氏', 1180803, '1180801', 1, NULL, '2018-03-30 12:00:00', 1, 3136, 3137);
INSERT INTO `base_region` VALUES ('1180804', '通许', '河南-开封-通许', 1180804, '1180801', 1, NULL, '2018-03-30 12:00:00', 1, 3138, 3139);
INSERT INTO `base_region` VALUES ('1180805', '兰考', '河南-开封-兰考', 1180805, '1180801', 1, NULL, '2018-03-30 12:00:00', 1, 3140, 3141);
INSERT INTO `base_region` VALUES ('1180806', '龙亭', '河南-开封-龙亭', 1180806, '1180801', 1, NULL, '2018-03-30 12:00:00', 1, 3142, 3143);
INSERT INTO `base_region` VALUES ('1180807', '顺河', '河南-开封-顺河', 1180807, '1180801', 1, NULL, '2018-03-30 12:00:00', 1, 3144, 3145);
INSERT INTO `base_region` VALUES ('1180808', '鼓楼', '河南-开封-鼓楼', 1180808, '1180801', 1, NULL, '2018-03-30 12:00:00', 1, 3146, 3147);
INSERT INTO `base_region` VALUES ('1180809', '禹王台', '河南-开封-禹王台', 1180809, '1180801', 1, NULL, '2018-03-30 12:00:00', 1, 3148, 3149);
INSERT INTO `base_region` VALUES ('1180810', '祥符', '河南-开封-祥符', 1180810, '1180801', 1, NULL, '2018-03-30 12:00:00', 1, 3150, 3151);
INSERT INTO `base_region` VALUES ('1180901', '洛阳', '河南-洛阳', 1180901, '1180000', 0, NULL, '2018-03-30 12:00:00', 1, 3153, 3184);
INSERT INTO `base_region` VALUES ('1180902', '新安', '河南-洛阳-新安', 1180902, '1180901', 1, NULL, '2018-03-30 12:00:00', 1, 3154, 3155);
INSERT INTO `base_region` VALUES ('1180903', '孟津', '河南-洛阳-孟津', 1180903, '1180901', 1, NULL, '2018-03-30 12:00:00', 1, 3156, 3157);
INSERT INTO `base_region` VALUES ('1180904', '宜阳', '河南-洛阳-宜阳', 1180904, '1180901', 1, NULL, '2018-03-30 12:00:00', 1, 3158, 3159);
INSERT INTO `base_region` VALUES ('1180905', '洛宁', '河南-洛阳-洛宁', 1180905, '1180901', 1, NULL, '2018-03-30 12:00:00', 1, 3160, 3161);
INSERT INTO `base_region` VALUES ('1180906', '伊川', '河南-洛阳-伊川', 1180906, '1180901', 1, NULL, '2018-03-30 12:00:00', 1, 3162, 3163);
INSERT INTO `base_region` VALUES ('1180907', '嵩县', '河南-洛阳-嵩县', 1180907, '1180901', 1, NULL, '2018-03-30 12:00:00', 1, 3164, 3165);
INSERT INTO `base_region` VALUES ('1180908', '偃师', '河南-洛阳-偃师', 1180908, '1180901', 1, NULL, '2018-03-30 12:00:00', 1, 3166, 3167);
INSERT INTO `base_region` VALUES ('1180909', '栾川', '河南-洛阳-栾川', 1180909, '1180901', 1, NULL, '2018-03-30 12:00:00', 1, 3168, 3169);
INSERT INTO `base_region` VALUES ('1180910', '汝阳', '河南-洛阳-汝阳', 1180910, '1180901', 1, NULL, '2018-03-30 12:00:00', 1, 3170, 3171);
INSERT INTO `base_region` VALUES ('1180911', '吉利', '河南-洛阳-吉利', 1180911, '1180901', 1, NULL, '2018-03-30 12:00:00', 1, 3172, 3173);
INSERT INTO `base_region` VALUES ('1180912', '老城', '河南-洛阳-老城', 1180912, '1180901', 1, NULL, '2018-03-30 12:00:00', 1, 3174, 3175);
INSERT INTO `base_region` VALUES ('1180913', '西工', '河南-洛阳-西工', 1180913, '1180901', 1, NULL, '2018-03-30 12:00:00', 1, 3176, 3177);
INSERT INTO `base_region` VALUES ('1180914', '瀍河', '河南-洛阳-瀍河', 1180914, '1180901', 1, NULL, '2018-03-30 12:00:00', 1, 3178, 3179);
INSERT INTO `base_region` VALUES ('1180915', '涧西', '河南-洛阳-涧西', 1180915, '1180901', 1, NULL, '2018-03-30 12:00:00', 1, 3180, 3181);
INSERT INTO `base_region` VALUES ('1180916', '洛龙', '河南-洛阳-洛龙', 1180916, '1180901', 1, NULL, '2018-03-30 12:00:00', 1, 3182, 3183);
INSERT INTO `base_region` VALUES ('1181001', '商丘', '河南-商丘', 1181001, '1180000', 0, NULL, '2018-03-30 12:00:00', 1, 3185, 3204);
INSERT INTO `base_region` VALUES ('1181002', '梁园', '河南-商丘-梁园', 1181002, '1181001', 1, NULL, '2018-03-30 12:00:00', 1, 3186, 3187);
INSERT INTO `base_region` VALUES ('1181003', '睢县', '河南-商丘-睢县', 1181003, '1181001', 1, NULL, '2018-03-30 12:00:00', 1, 3188, 3189);
INSERT INTO `base_region` VALUES ('1181004', '民权', '河南-商丘-民权', 1181004, '1181001', 1, NULL, '2018-03-30 12:00:00', 1, 3190, 3191);
INSERT INTO `base_region` VALUES ('1181005', '虞城', '河南-商丘-虞城', 1181005, '1181001', 1, NULL, '2018-03-30 12:00:00', 1, 3192, 3193);
INSERT INTO `base_region` VALUES ('1181006', '柘城', '河南-商丘-柘城', 1181006, '1181001', 1, NULL, '2018-03-30 12:00:00', 1, 3194, 3195);
INSERT INTO `base_region` VALUES ('1181007', '宁陵', '河南-商丘-宁陵', 1181007, '1181001', 1, NULL, '2018-03-30 12:00:00', 1, 3196, 3197);
INSERT INTO `base_region` VALUES ('1181008', '夏邑', '河南-商丘-夏邑', 1181008, '1181001', 1, NULL, '2018-03-30 12:00:00', 1, 3198, 3199);
INSERT INTO `base_region` VALUES ('1181009', '永城', '河南-商丘-永城', 1181009, '1181001', 1, NULL, '2018-03-30 12:00:00', 1, 3200, 3201);
INSERT INTO `base_region` VALUES ('1181010', '睢阳', '河南-商丘-睢阳', 1181010, '1181001', 1, NULL, '2018-03-30 12:00:00', 1, 3202, 3203);
INSERT INTO `base_region` VALUES ('1181101', '焦作', '河南-焦作', 1181101, '1180000', 0, NULL, '2018-03-30 12:00:00', 1, 3205, 3226);
INSERT INTO `base_region` VALUES ('1181102', '修武', '河南-焦作-修武', 1181102, '1181101', 1, NULL, '2018-03-30 12:00:00', 1, 3206, 3207);
INSERT INTO `base_region` VALUES ('1181103', '武陟', '河南-焦作-武陟', 1181103, '1181101', 1, NULL, '2018-03-30 12:00:00', 1, 3208, 3209);
INSERT INTO `base_region` VALUES ('1181104', '沁阳', '河南-焦作-沁阳', 1181104, '1181101', 1, NULL, '2018-03-30 12:00:00', 1, 3210, 3211);
INSERT INTO `base_region` VALUES ('1181105', '解放', '河南-焦作-解放', 1181105, '1181101', 1, NULL, '2018-03-30 12:00:00', 1, 3212, 3213);
INSERT INTO `base_region` VALUES ('1181106', '博爱', '河南-焦作-博爱', 1181106, '1181101', 1, NULL, '2018-03-30 12:00:00', 1, 3214, 3215);
INSERT INTO `base_region` VALUES ('1181107', '温县', '河南-焦作-温县', 1181107, '1181101', 1, NULL, '2018-03-30 12:00:00', 1, 3216, 3217);
INSERT INTO `base_region` VALUES ('1181108', '孟州', '河南-焦作-孟州', 1181108, '1181101', 1, NULL, '2018-03-30 12:00:00', 1, 3218, 3219);
INSERT INTO `base_region` VALUES ('1181109', '中站', '河南-焦作-中站', 1181109, '1181101', 1, NULL, '2018-03-30 12:00:00', 1, 3220, 3221);
INSERT INTO `base_region` VALUES ('1181110', '马村', '河南-焦作-马村', 1181110, '1181101', 1, NULL, '2018-03-30 12:00:00', 1, 3222, 3223);
INSERT INTO `base_region` VALUES ('1181111', '山阳', '河南-焦作-山阳', 1181111, '1181101', 1, NULL, '2018-03-30 12:00:00', 1, 3224, 3225);
INSERT INTO `base_region` VALUES ('1181201', '鹤壁', '河南-鹤壁', 1181201, '1180000', 0, NULL, '2018-03-30 12:00:00', 1, 3227, 3238);
INSERT INTO `base_region` VALUES ('1181202', '浚县', '河南-鹤壁-浚县', 1181202, '1181201', 1, NULL, '2018-03-30 12:00:00', 1, 3228, 3229);
INSERT INTO `base_region` VALUES ('1181203', '淇县', '河南-鹤壁-淇县', 1181203, '1181201', 1, NULL, '2018-03-30 12:00:00', 1, 3230, 3231);
INSERT INTO `base_region` VALUES ('1181204', '鹤山', '河南-鹤壁-鹤山', 1181204, '1181201', 1, NULL, '2018-03-30 12:00:00', 1, 3232, 3233);
INSERT INTO `base_region` VALUES ('1181205', '山城', '河南-鹤壁-山城', 1181205, '1181201', 1, NULL, '2018-03-30 12:00:00', 1, 3234, 3235);
INSERT INTO `base_region` VALUES ('1181206', '淇滨', '河南-鹤壁-淇滨', 1181206, '1181201', 1, NULL, '2018-03-30 12:00:00', 1, 3236, 3237);
INSERT INTO `base_region` VALUES ('1181301', '濮阳', '河南-濮阳', 1181301, '1180000', 0, NULL, '2018-03-30 12:00:00', 1, 3239, 3250);
INSERT INTO `base_region` VALUES ('1181302', '台前', '河南-濮阳-台前', 1181302, '1181301', 1, NULL, '2018-03-30 12:00:00', 1, 3240, 3241);
INSERT INTO `base_region` VALUES ('1181303', '南乐', '河南-濮阳-南乐', 1181303, '1181301', 1, NULL, '2018-03-30 12:00:00', 1, 3242, 3243);
INSERT INTO `base_region` VALUES ('1181304', '清丰', '河南-濮阳-清丰', 1181304, '1181301', 1, NULL, '2018-03-30 12:00:00', 1, 3244, 3245);
INSERT INTO `base_region` VALUES ('1181305', '范县', '河南-濮阳-范县', 1181305, '1181301', 1, NULL, '2018-03-30 12:00:00', 1, 3246, 3247);
INSERT INTO `base_region` VALUES ('1181306', '华龙', '河南-濮阳-华龙', 1181306, '1181301', 1, NULL, '2018-03-30 12:00:00', 1, 3248, 3249);
INSERT INTO `base_region` VALUES ('1181401', '周口', '河南-周口', 1181401, '1180000', 0, NULL, '2018-03-30 12:00:00', 1, 3251, 3272);
INSERT INTO `base_region` VALUES ('1181402', '扶沟', '河南-周口-扶沟', 1181402, '1181401', 1, NULL, '2018-03-30 12:00:00', 1, 3252, 3253);
INSERT INTO `base_region` VALUES ('1181403', '太康', '河南-周口-太康', 1181403, '1181401', 1, NULL, '2018-03-30 12:00:00', 1, 3254, 3255);
INSERT INTO `base_region` VALUES ('1181404', '淮阳', '河南-周口-淮阳', 1181404, '1181401', 1, NULL, '2018-03-30 12:00:00', 1, 3256, 3257);
INSERT INTO `base_region` VALUES ('1181405', '西华', '河南-周口-西华', 1181405, '1181401', 1, NULL, '2018-03-30 12:00:00', 1, 3258, 3259);
INSERT INTO `base_region` VALUES ('1181406', '商水', '河南-周口-商水', 1181406, '1181401', 1, NULL, '2018-03-30 12:00:00', 1, 3260, 3261);
INSERT INTO `base_region` VALUES ('1181407', '项城', '河南-周口-项城', 1181407, '1181401', 1, NULL, '2018-03-30 12:00:00', 1, 3262, 3263);
INSERT INTO `base_region` VALUES ('1181408', '郸城', '河南-周口-郸城', 1181408, '1181401', 1, NULL, '2018-03-30 12:00:00', 1, 3264, 3265);
INSERT INTO `base_region` VALUES ('1181409', '鹿邑', '河南-周口-鹿邑', 1181409, '1181401', 1, NULL, '2018-03-30 12:00:00', 1, 3266, 3267);
INSERT INTO `base_region` VALUES ('1181410', '沈丘', '河南-周口-沈丘', 1181410, '1181401', 1, NULL, '2018-03-30 12:00:00', 1, 3268, 3269);
INSERT INTO `base_region` VALUES ('1181411', '川汇', '河南-周口-川汇', 1181411, '1181401', 1, NULL, '2018-03-30 12:00:00', 1, 3270, 3271);
INSERT INTO `base_region` VALUES ('1181501', '漯河', '河南-漯河', 1181501, '1180000', 0, NULL, '2018-03-30 12:00:00', 1, 3273, 3284);
INSERT INTO `base_region` VALUES ('1181502', '临颍', '河南-漯河-临颍', 1181502, '1181501', 1, NULL, '2018-03-30 12:00:00', 1, 3274, 3275);
INSERT INTO `base_region` VALUES ('1181503', '舞阳', '河南-漯河-舞阳', 1181503, '1181501', 1, NULL, '2018-03-30 12:00:00', 1, 3276, 3277);
INSERT INTO `base_region` VALUES ('1181504', '源汇', '河南-漯河-源汇', 1181504, '1181501', 1, NULL, '2018-03-30 12:00:00', 1, 3278, 3279);
INSERT INTO `base_region` VALUES ('1181505', '郾城', '河南-漯河-郾城', 1181505, '1181501', 1, NULL, '2018-03-30 12:00:00', 1, 3280, 3281);
INSERT INTO `base_region` VALUES ('1181506', '召陵', '河南-漯河-召陵', 1181506, '1181501', 1, NULL, '2018-03-30 12:00:00', 1, 3282, 3283);
INSERT INTO `base_region` VALUES ('1181601', '驻马店', '河南-驻马店', 1181601, '1180000', 0, NULL, '2018-03-30 12:00:00', 1, 3285, 3306);
INSERT INTO `base_region` VALUES ('1181602', '西平', '河南-驻马店-西平', 1181602, '1181601', 1, NULL, '2018-03-30 12:00:00', 1, 3286, 3287);
INSERT INTO `base_region` VALUES ('1181603', '遂平', '河南-驻马店-遂平', 1181603, '1181601', 1, NULL, '2018-03-30 12:00:00', 1, 3288, 3289);
INSERT INTO `base_region` VALUES ('1181604', '上蔡', '河南-驻马店-上蔡', 1181604, '1181601', 1, NULL, '2018-03-30 12:00:00', 1, 3290, 3291);
INSERT INTO `base_region` VALUES ('1181605', '汝南', '河南-驻马店-汝南', 1181605, '1181601', 1, NULL, '2018-03-30 12:00:00', 1, 3292, 3293);
INSERT INTO `base_region` VALUES ('1181606', '泌阳', '河南-驻马店-泌阳', 1181606, '1181601', 1, NULL, '2018-03-30 12:00:00', 1, 3294, 3295);
INSERT INTO `base_region` VALUES ('1181607', '平舆', '河南-驻马店-平舆', 1181607, '1181601', 1, NULL, '2018-03-30 12:00:00', 1, 3296, 3297);
INSERT INTO `base_region` VALUES ('1181608', '新蔡', '河南-驻马店-新蔡', 1181608, '1181601', 1, NULL, '2018-03-30 12:00:00', 1, 3298, 3299);
INSERT INTO `base_region` VALUES ('1181609', '确山', '河南-驻马店-确山', 1181609, '1181601', 1, NULL, '2018-03-30 12:00:00', 1, 3300, 3301);
INSERT INTO `base_region` VALUES ('1181610', '正阳', '河南-驻马店-正阳', 1181610, '1181601', 1, NULL, '2018-03-30 12:00:00', 1, 3302, 3303);
INSERT INTO `base_region` VALUES ('1181611', '驿城', '河南-驻马店-驿城', 1181611, '1181601', 1, NULL, '2018-03-30 12:00:00', 1, 3304, 3305);
INSERT INTO `base_region` VALUES ('1181701', '三门峡', '河南-三门峡', 1181701, '1180000', 0, NULL, '2018-03-30 12:00:00', 1, 3307, 3322);
INSERT INTO `base_region` VALUES ('1181702', '灵宝', '河南-三门峡-灵宝', 1181702, '1181701', 1, NULL, '2018-03-30 12:00:00', 1, 3308, 3309);
INSERT INTO `base_region` VALUES ('1181703', '渑池', '河南-三门峡-渑池', 1181703, '1181701', 1, NULL, '2018-03-30 12:00:00', 1, 3310, 3311);
INSERT INTO `base_region` VALUES ('1181704', '卢氏', '河南-三门峡-卢氏', 1181704, '1181701', 1, NULL, '2018-03-30 12:00:00', 1, 3312, 3313);
INSERT INTO `base_region` VALUES ('1181705', '义马', '河南-三门峡-义马', 1181705, '1181701', 1, NULL, '2018-03-30 12:00:00', 1, 3314, 3315);
INSERT INTO `base_region` VALUES ('1181706', '陕县', '河南-三门峡-陕县', 1181706, '1181701', 1, NULL, '2018-03-30 12:00:00', 1, 3316, 3317);
INSERT INTO `base_region` VALUES ('1181707', '湖滨', '河南-三门峡-湖滨', 1181707, '1181701', 1, NULL, '2018-03-30 12:00:00', 1, 3318, 3319);
INSERT INTO `base_region` VALUES ('1181708', '陕州', '河南-三门峡-陕州', 1181708, '1181701', 1, NULL, '2018-03-30 12:00:00', 1, 3320, 3321);
INSERT INTO `base_region` VALUES ('1181801', '济源', '河南-济源', 1181801, '1180000', 0, NULL, '2018-03-30 12:00:00', 1, 3323, 3324);
INSERT INTO `base_region` VALUES ('1190000', '江苏', '江苏', 1190000, 'ROOT', 0, NULL, '2018-03-30 12:00:00', 1, 3326, 3545);
INSERT INTO `base_region` VALUES ('1190101', '南京', '江苏-南京', 1190101, '1190000', 0, NULL, '2018-03-30 12:00:00', 1, 3327, 3350);
INSERT INTO `base_region` VALUES ('1190102', '溧水', '江苏-南京-溧水', 1190102, '1190101', 1, NULL, '2018-03-30 12:00:00', 1, 3328, 3329);
INSERT INTO `base_region` VALUES ('1190103', '高淳', '江苏-南京-高淳', 1190103, '1190101', 1, NULL, '2018-03-30 12:00:00', 1, 3330, 3331);
INSERT INTO `base_region` VALUES ('1190104', '江宁', '江苏-南京-江宁', 1190104, '1190101', 1, NULL, '2018-03-30 12:00:00', 1, 3332, 3333);
INSERT INTO `base_region` VALUES ('1190105', '六合', '江苏-南京-六合', 1190105, '1190101', 1, NULL, '2018-03-30 12:00:00', 1, 3334, 3335);
INSERT INTO `base_region` VALUES ('1190107', '浦口', '江苏-南京-浦口', 1190107, '1190101', 1, NULL, '2018-03-30 12:00:00', 1, 3336, 3337);
INSERT INTO `base_region` VALUES ('1190108', '玄武', '江苏-南京-玄武', 1190108, '1190101', 1, NULL, '2018-03-30 12:00:00', 1, 3338, 3339);
INSERT INTO `base_region` VALUES ('1190109', '秦淮', '江苏-南京-秦淮', 1190109, '1190101', 1, NULL, '2018-03-30 12:00:00', 1, 3340, 3341);
INSERT INTO `base_region` VALUES ('1190110', '建邺', '江苏-南京-建邺', 1190110, '1190101', 1, NULL, '2018-03-30 12:00:00', 1, 3342, 3343);
INSERT INTO `base_region` VALUES ('1190111', '鼓楼', '江苏-南京-鼓楼', 1190111, '1190101', 1, NULL, '2018-03-30 12:00:00', 1, 3344, 3345);
INSERT INTO `base_region` VALUES ('1190112', '栖霞', '江苏-南京-栖霞', 1190112, '1190101', 1, NULL, '2018-03-30 12:00:00', 1, 3346, 3347);
INSERT INTO `base_region` VALUES ('1190113', '雨花台', '江苏-南京-雨花台', 1190113, '1190101', 1, NULL, '2018-03-30 12:00:00', 1, 3348, 3349);
INSERT INTO `base_region` VALUES ('1190201', '无锡', '江苏-无锡', 1190201, '1190000', 0, NULL, '2018-03-30 12:00:00', 1, 3351, 3366);
INSERT INTO `base_region` VALUES ('1190202', '江阴', '江苏-无锡-江阴', 1190202, '1190201', 1, NULL, '2018-03-30 12:00:00', 1, 3352, 3353);
INSERT INTO `base_region` VALUES ('1190203', '宜兴', '江苏-无锡-宜兴', 1190203, '1190201', 1, NULL, '2018-03-30 12:00:00', 1, 3354, 3355);
INSERT INTO `base_region` VALUES ('1190204', '锡山', '江苏-无锡-锡山', 1190204, '1190201', 1, NULL, '2018-03-30 12:00:00', 1, 3356, 3357);
INSERT INTO `base_region` VALUES ('1190205', '惠山', '江苏-无锡-惠山', 1190205, '1190201', 1, NULL, '2018-03-30 12:00:00', 1, 3358, 3359);
INSERT INTO `base_region` VALUES ('1190206', '滨湖', '江苏-无锡-滨湖', 1190206, '1190201', 1, NULL, '2018-03-30 12:00:00', 1, 3360, 3361);
INSERT INTO `base_region` VALUES ('1190207', '梁溪', '江苏-无锡-梁溪', 1190207, '1190201', 1, NULL, '2018-03-30 12:00:00', 1, 3362, 3363);
INSERT INTO `base_region` VALUES ('1190208', '新吴', '江苏-无锡-新吴', 1190208, '1190201', 1, NULL, '2018-03-30 12:00:00', 1, 3364, 3365);
INSERT INTO `base_region` VALUES ('1190301', '镇江', '江苏-镇江', 1190301, '1190000', 0, NULL, '2018-03-30 12:00:00', 1, 3367, 3380);
INSERT INTO `base_region` VALUES ('1190302', '丹阳', '江苏-镇江-丹阳', 1190302, '1190301', 1, NULL, '2018-03-30 12:00:00', 1, 3368, 3369);
INSERT INTO `base_region` VALUES ('1190303', '扬中', '江苏-镇江-扬中', 1190303, '1190301', 1, NULL, '2018-03-30 12:00:00', 1, 3370, 3371);
INSERT INTO `base_region` VALUES ('1190304', '句容', '江苏-镇江-句容', 1190304, '1190301', 1, NULL, '2018-03-30 12:00:00', 1, 3372, 3373);
INSERT INTO `base_region` VALUES ('1190305', '丹徒', '江苏-镇江-丹徒', 1190305, '1190301', 1, NULL, '2018-03-30 12:00:00', 1, 3374, 3375);
INSERT INTO `base_region` VALUES ('1190306', '京口', '江苏-镇江-京口', 1190306, '1190301', 1, NULL, '2018-03-30 12:00:00', 1, 3376, 3377);
INSERT INTO `base_region` VALUES ('1190307', '润州', '江苏-镇江-润州', 1190307, '1190301', 1, NULL, '2018-03-30 12:00:00', 1, 3378, 3379);
INSERT INTO `base_region` VALUES ('1190401', '苏州', '江苏-苏州', 1190401, '1190000', 0, NULL, '2018-03-30 12:00:00', 1, 3381, 3400);
INSERT INTO `base_region` VALUES ('1190402', '常熟', '江苏-苏州-常熟', 1190402, '1190401', 1, NULL, '2018-03-30 12:00:00', 1, 3382, 3383);
INSERT INTO `base_region` VALUES ('1190403', '张家港', '江苏-苏州-张家港', 1190403, '1190401', 1, NULL, '2018-03-30 12:00:00', 1, 3384, 3385);
INSERT INTO `base_region` VALUES ('1190404', '昆山', '江苏-苏州-昆山', 1190404, '1190401', 1, NULL, '2018-03-30 12:00:00', 1, 3386, 3387);
INSERT INTO `base_region` VALUES ('1190405', '吴中', '江苏-苏州-吴中', 1190405, '1190401', 1, NULL, '2018-03-30 12:00:00', 1, 3388, 3389);
INSERT INTO `base_region` VALUES ('1190406', '虎丘', '江苏-苏州-虎丘', 1190406, '1190401', 1, NULL, '2018-03-30 12:00:00', 1, 3390, 3391);
INSERT INTO `base_region` VALUES ('1190407', '吴江', '江苏-苏州-吴江', 1190407, '1190401', 1, NULL, '2018-03-30 12:00:00', 1, 3392, 3393);
INSERT INTO `base_region` VALUES ('1190408', '太仓', '江苏-苏州-太仓', 1190408, '1190401', 1, NULL, '2018-03-30 12:00:00', 1, 3394, 3395);
INSERT INTO `base_region` VALUES ('1190409', '相城', '江苏-苏州-相城', 1190409, '1190401', 1, NULL, '2018-03-30 12:00:00', 1, 3396, 3397);
INSERT INTO `base_region` VALUES ('1190410', '姑苏', '江苏-苏州-姑苏', 1190410, '1190401', 1, NULL, '2018-03-30 12:00:00', 1, 3398, 3399);
INSERT INTO `base_region` VALUES ('1190501', '南通', '江苏-南通', 1190501, '1190000', 0, NULL, '2018-03-30 12:00:00', 1, 3401, 3418);
INSERT INTO `base_region` VALUES ('1190502', '海安', '江苏-南通-海安', 1190502, '1190501', 1, NULL, '2018-03-30 12:00:00', 1, 3402, 3403);
INSERT INTO `base_region` VALUES ('1190503', '如皋', '江苏-南通-如皋', 1190503, '1190501', 1, NULL, '2018-03-30 12:00:00', 1, 3404, 3405);
INSERT INTO `base_region` VALUES ('1190504', '如东', '江苏-南通-如东', 1190504, '1190501', 1, NULL, '2018-03-30 12:00:00', 1, 3406, 3407);
INSERT INTO `base_region` VALUES ('1190505', '崇川', '江苏-南通-崇川', 1190505, '1190501', 1, NULL, '2018-03-30 12:00:00', 1, 3408, 3409);
INSERT INTO `base_region` VALUES ('1190506', '港闸', '江苏-南通-港闸', 1190506, '1190501', 1, NULL, '2018-03-30 12:00:00', 1, 3410, 3411);
INSERT INTO `base_region` VALUES ('1190507', '启东', '江苏-南通-启东', 1190507, '1190501', 1, NULL, '2018-03-30 12:00:00', 1, 3412, 3413);
INSERT INTO `base_region` VALUES ('1190508', '海门', '江苏-南通-海门', 1190508, '1190501', 1, NULL, '2018-03-30 12:00:00', 1, 3414, 3415);
INSERT INTO `base_region` VALUES ('1190509', '通州', '江苏-南通-通州', 1190509, '1190501', 1, NULL, '2018-03-30 12:00:00', 1, 3416, 3417);
INSERT INTO `base_region` VALUES ('1190601', '扬州', '江苏-扬州', 1190601, '1190000', 0, NULL, '2018-03-30 12:00:00', 1, 3419, 3432);
INSERT INTO `base_region` VALUES ('1190602', '宝应', '江苏-扬州-宝应', 1190602, '1190601', 1, NULL, '2018-03-30 12:00:00', 1, 3420, 3421);
INSERT INTO `base_region` VALUES ('1190603', '仪征', '江苏-扬州-仪征', 1190603, '1190601', 1, NULL, '2018-03-30 12:00:00', 1, 3422, 3423);
INSERT INTO `base_region` VALUES ('1190604', '高邮', '江苏-扬州-高邮', 1190604, '1190601', 1, NULL, '2018-03-30 12:00:00', 1, 3424, 3425);
INSERT INTO `base_region` VALUES ('1190605', '江都', '江苏-扬州-江都', 1190605, '1190601', 1, NULL, '2018-03-30 12:00:00', 1, 3426, 3427);
INSERT INTO `base_region` VALUES ('1190606', '邗江', '江苏-扬州-邗江', 1190606, '1190601', 1, NULL, '2018-03-30 12:00:00', 1, 3428, 3429);
INSERT INTO `base_region` VALUES ('1190607', '广陵', '江苏-扬州-广陵', 1190607, '1190601', 1, NULL, '2018-03-30 12:00:00', 1, 3430, 3431);
INSERT INTO `base_region` VALUES ('1190701', '盐城', '江苏-盐城', 1190701, '1190000', 0, NULL, '2018-03-30 12:00:00', 1, 3433, 3452);
INSERT INTO `base_region` VALUES ('1190702', '响水', '江苏-盐城-响水', 1190702, '1190701', 1, NULL, '2018-03-30 12:00:00', 1, 3434, 3435);
INSERT INTO `base_region` VALUES ('1190703', '滨海', '江苏-盐城-滨海', 1190703, '1190701', 1, NULL, '2018-03-30 12:00:00', 1, 3436, 3437);
INSERT INTO `base_region` VALUES ('1190704', '阜宁', '江苏-盐城-阜宁', 1190704, '1190701', 1, NULL, '2018-03-30 12:00:00', 1, 3438, 3439);
INSERT INTO `base_region` VALUES ('1190705', '射阳', '江苏-盐城-射阳', 1190705, '1190701', 1, NULL, '2018-03-30 12:00:00', 1, 3440, 3441);
INSERT INTO `base_region` VALUES ('1190706', '建湖', '江苏-盐城-建湖', 1190706, '1190701', 1, NULL, '2018-03-30 12:00:00', 1, 3442, 3443);
INSERT INTO `base_region` VALUES ('1190707', '东台', '江苏-盐城-东台', 1190707, '1190701', 1, NULL, '2018-03-30 12:00:00', 1, 3444, 3445);
INSERT INTO `base_region` VALUES ('1190708', '大丰', '江苏-盐城-大丰', 1190708, '1190701', 1, NULL, '2018-03-30 12:00:00', 1, 3446, 3447);
INSERT INTO `base_region` VALUES ('1190709', '盐都', '江苏-盐城-盐都', 1190709, '1190701', 1, NULL, '2018-03-30 12:00:00', 1, 3448, 3449);
INSERT INTO `base_region` VALUES ('1190710', '亭湖', '江苏-盐城-亭湖', 1190710, '1190701', 1, NULL, '2018-03-30 12:00:00', 1, 3450, 3451);
INSERT INTO `base_region` VALUES ('1190801', '徐州', '江苏-徐州', 1190801, '1190000', 0, NULL, '2018-03-30 12:00:00', 1, 3453, 3474);
INSERT INTO `base_region` VALUES ('1190802', '铜山', '江苏-徐州-铜山', 1190802, '1190801', 1, NULL, '2018-03-30 12:00:00', 1, 3454, 3455);
INSERT INTO `base_region` VALUES ('1190803', '丰县', '江苏-徐州-丰县', 1190803, '1190801', 1, NULL, '2018-03-30 12:00:00', 1, 3456, 3457);
INSERT INTO `base_region` VALUES ('1190804', '沛县', '江苏-徐州-沛县', 1190804, '1190801', 1, NULL, '2018-03-30 12:00:00', 1, 3458, 3459);
INSERT INTO `base_region` VALUES ('1190805', '邳州', '江苏-徐州-邳州', 1190805, '1190801', 1, NULL, '2018-03-30 12:00:00', 1, 3460, 3461);
INSERT INTO `base_region` VALUES ('1190806', '睢宁', '江苏-徐州-睢宁', 1190806, '1190801', 1, NULL, '2018-03-30 12:00:00', 1, 3462, 3463);
INSERT INTO `base_region` VALUES ('1190807', '新沂', '江苏-徐州-新沂', 1190807, '1190801', 1, NULL, '2018-03-30 12:00:00', 1, 3464, 3465);
INSERT INTO `base_region` VALUES ('1190808', '鼓楼', '江苏-徐州-鼓楼', 1190808, '1190801', 1, NULL, '2018-03-30 12:00:00', 1, 3466, 3467);
INSERT INTO `base_region` VALUES ('1190809', '云龙', '江苏-徐州-云龙', 1190809, '1190801', 1, NULL, '2018-03-30 12:00:00', 1, 3468, 3469);
INSERT INTO `base_region` VALUES ('1190810', '贾汪', '江苏-徐州-贾汪', 1190810, '1190801', 1, NULL, '2018-03-30 12:00:00', 1, 3470, 3471);
INSERT INTO `base_region` VALUES ('1190811', '泉山', '江苏-徐州-泉山', 1190811, '1190801', 1, NULL, '2018-03-30 12:00:00', 1, 3472, 3473);
INSERT INTO `base_region` VALUES ('1190901', '淮安', '江苏-淮安', 1190901, '1190000', 0, NULL, '2018-03-30 12:00:00', 1, 3475, 3492);
INSERT INTO `base_region` VALUES ('1190902', '金湖', '江苏-淮安-金湖', 1190902, '1190901', 1, NULL, '2018-03-30 12:00:00', 1, 3476, 3477);
INSERT INTO `base_region` VALUES ('1190903', '盱眙', '江苏-淮安-盱眙', 1190903, '1190901', 1, NULL, '2018-03-30 12:00:00', 1, 3478, 3479);
INSERT INTO `base_region` VALUES ('1190904', '洪泽', '江苏-淮安-洪泽', 1190904, '1190901', 1, NULL, '2018-03-30 12:00:00', 1, 3480, 3481);
INSERT INTO `base_region` VALUES ('1190905', '涟水', '江苏-淮安-涟水', 1190905, '1190901', 1, NULL, '2018-03-30 12:00:00', 1, 3482, 3483);
INSERT INTO `base_region` VALUES ('1190906', '淮阴区', '江苏-淮安-淮阴区', 1190906, '1190901', 1, NULL, '2018-03-30 12:00:00', 1, 3484, 3485);
INSERT INTO `base_region` VALUES ('1190907', '清河', '江苏-淮安-清河', 1190907, '1190901', 1, NULL, '2018-03-30 12:00:00', 1, 3486, 3487);
INSERT INTO `base_region` VALUES ('1190908', '淮安区', '江苏-淮安-淮安区', 1190908, '1190901', 1, NULL, '2018-03-30 12:00:00', 1, 3488, 3489);
INSERT INTO `base_region` VALUES ('1190909', '清浦', '江苏-淮安-清浦', 1190909, '1190901', 1, NULL, '2018-03-30 12:00:00', 1, 3490, 3491);
INSERT INTO `base_region` VALUES ('1191001', '连云港', '江苏-连云港', 1191001, '1190000', 0, NULL, '2018-03-30 12:00:00', 1, 3493, 3504);
INSERT INTO `base_region` VALUES ('1191002', '东海', '江苏-连云港-东海', 1191002, '1191001', 1, NULL, '2018-03-30 12:00:00', 1, 3494, 3495);
INSERT INTO `base_region` VALUES ('1191003', '赣榆', '江苏-连云港-赣榆', 1191003, '1191001', 1, NULL, '2018-03-30 12:00:00', 1, 3496, 3497);
INSERT INTO `base_region` VALUES ('1191004', '灌云', '江苏-连云港-灌云', 1191004, '1191001', 1, NULL, '2018-03-30 12:00:00', 1, 3498, 3499);
INSERT INTO `base_region` VALUES ('1191005', '灌南', '江苏-连云港-灌南', 1191005, '1191001', 1, NULL, '2018-03-30 12:00:00', 1, 3500, 3501);
INSERT INTO `base_region` VALUES ('1191006', '海州', '江苏-连云港-海州', 1191006, '1191001', 1, NULL, '2018-03-30 12:00:00', 1, 3502, 3503);
INSERT INTO `base_region` VALUES ('1191101', '常州', '江苏-常州', 1191101, '1190000', 0, NULL, '2018-03-30 12:00:00', 1, 3505, 3518);
INSERT INTO `base_region` VALUES ('1191102', '溧阳', '江苏-常州-溧阳', 1191102, '1191101', 1, NULL, '2018-03-30 12:00:00', 1, 3506, 3507);
INSERT INTO `base_region` VALUES ('1191103', '金坛', '江苏-常州-金坛', 1191103, '1191101', 1, NULL, '2018-03-30 12:00:00', 1, 3508, 3509);
INSERT INTO `base_region` VALUES ('1191104', '武进', '江苏-常州-武进', 1191104, '1191101', 1, NULL, '2018-03-30 12:00:00', 1, 3510, 3511);
INSERT INTO `base_region` VALUES ('1191105', '天宁', '江苏-常州-天宁', 1191105, '1191101', 1, NULL, '2018-03-30 12:00:00', 1, 3512, 3513);
INSERT INTO `base_region` VALUES ('1191106', '钟楼', '江苏-常州-钟楼', 1191106, '1191101', 1, NULL, '2018-03-30 12:00:00', 1, 3514, 3515);
INSERT INTO `base_region` VALUES ('1191107', '新北', '江苏-常州-新北', 1191107, '1191101', 1, NULL, '2018-03-30 12:00:00', 1, 3516, 3517);
INSERT INTO `base_region` VALUES ('1191201', '泰州', '江苏-泰州', 1191201, '1190000', 0, NULL, '2018-03-30 12:00:00', 1, 3519, 3532);
INSERT INTO `base_region` VALUES ('1191202', '兴化', '江苏-泰州-兴化', 1191202, '1191201', 1, NULL, '2018-03-30 12:00:00', 1, 3520, 3521);
INSERT INTO `base_region` VALUES ('1191203', '泰兴', '江苏-泰州-泰兴', 1191203, '1191201', 1, NULL, '2018-03-30 12:00:00', 1, 3522, 3523);
INSERT INTO `base_region` VALUES ('1191204', '姜堰', '江苏-泰州-姜堰', 1191204, '1191201', 1, NULL, '2018-03-30 12:00:00', 1, 3524, 3525);
INSERT INTO `base_region` VALUES ('1191205', '靖江', '江苏-泰州-靖江', 1191205, '1191201', 1, NULL, '2018-03-30 12:00:00', 1, 3526, 3527);
INSERT INTO `base_region` VALUES ('1191206', '海陵', '江苏-泰州-海陵', 1191206, '1191201', 1, NULL, '2018-03-30 12:00:00', 1, 3528, 3529);
INSERT INTO `base_region` VALUES ('1191207', '高港', '江苏-泰州-高港', 1191207, '1191201', 1, NULL, '2018-03-30 12:00:00', 1, 3530, 3531);
INSERT INTO `base_region` VALUES ('1191301', '宿迁', '江苏-宿迁', 1191301, '1190000', 0, NULL, '2018-03-30 12:00:00', 1, 3533, 3544);
INSERT INTO `base_region` VALUES ('1191302', '沭阳', '江苏-宿迁-沭阳', 1191302, '1191301', 1, NULL, '2018-03-30 12:00:00', 1, 3534, 3535);
INSERT INTO `base_region` VALUES ('1191303', '泗阳', '江苏-宿迁-泗阳', 1191303, '1191301', 1, NULL, '2018-03-30 12:00:00', 1, 3536, 3537);
INSERT INTO `base_region` VALUES ('1191304', '泗洪', '江苏-宿迁-泗洪', 1191304, '1191301', 1, NULL, '2018-03-30 12:00:00', 1, 3538, 3539);
INSERT INTO `base_region` VALUES ('1191305', '宿豫', '江苏-宿迁-宿豫', 1191305, '1191301', 1, NULL, '2018-03-30 12:00:00', 1, 3540, 3541);
INSERT INTO `base_region` VALUES ('1191306', '宿城', '江苏-宿迁-宿城', 1191306, '1191301', 1, NULL, '2018-03-30 12:00:00', 1, 3542, 3543);
INSERT INTO `base_region` VALUES ('1200000', '湖北', '湖北', 1200000, 'ROOT', 0, NULL, '2018-03-30 12:00:00', 1, 3546, 3775);
INSERT INTO `base_region` VALUES ('1200101', '武汉', '湖北-武汉', 1200101, '1200000', 0, NULL, '2018-03-30 12:00:00', 1, 3547, 3574);
INSERT INTO `base_region` VALUES ('1200102', '蔡甸', '湖北-武汉-蔡甸', 1200102, '1200101', 1, NULL, '2018-03-30 12:00:00', 1, 3548, 3549);
INSERT INTO `base_region` VALUES ('1200103', '黄陂', '湖北-武汉-黄陂', 1200103, '1200101', 1, NULL, '2018-03-30 12:00:00', 1, 3550, 3551);
INSERT INTO `base_region` VALUES ('1200104', '新洲', '湖北-武汉-新洲', 1200104, '1200101', 1, NULL, '2018-03-30 12:00:00', 1, 3552, 3553);
INSERT INTO `base_region` VALUES ('1200105', '江夏', '湖北-武汉-江夏', 1200105, '1200101', 1, NULL, '2018-03-30 12:00:00', 1, 3554, 3555);
INSERT INTO `base_region` VALUES ('1200106', '东西湖', '湖北-武汉-东西湖', 1200106, '1200101', 1, NULL, '2018-03-30 12:00:00', 1, 3556, 3557);
INSERT INTO `base_region` VALUES ('1200107', '江岸', '湖北-武汉-江岸', 1200107, '1200101', 1, NULL, '2018-03-30 12:00:00', 1, 3558, 3559);
INSERT INTO `base_region` VALUES ('1200108', '江汉', '湖北-武汉-江汉', 1200108, '1200101', 1, NULL, '2018-03-30 12:00:00', 1, 3560, 3561);
INSERT INTO `base_region` VALUES ('1200109', '硚口', '湖北-武汉-硚口', 1200109, '1200101', 1, NULL, '2018-03-30 12:00:00', 1, 3562, 3563);
INSERT INTO `base_region` VALUES ('1200110', '汉阳', '湖北-武汉-汉阳', 1200110, '1200101', 1, NULL, '2018-03-30 12:00:00', 1, 3564, 3565);
INSERT INTO `base_region` VALUES ('1200111', '武昌', '湖北-武汉-武昌', 1200111, '1200101', 1, NULL, '2018-03-30 12:00:00', 1, 3566, 3567);
INSERT INTO `base_region` VALUES ('1200112', '青山', '湖北-武汉-青山', 1200112, '1200101', 1, NULL, '2018-03-30 12:00:00', 1, 3568, 3569);
INSERT INTO `base_region` VALUES ('1200113', '洪山', '湖北-武汉-洪山', 1200113, '1200101', 1, NULL, '2018-03-30 12:00:00', 1, 3570, 3571);
INSERT INTO `base_region` VALUES ('1200114', '汉南', '湖北-武汉-汉南', 1200114, '1200101', 1, NULL, '2018-03-30 12:00:00', 1, 3572, 3573);
INSERT INTO `base_region` VALUES ('1200201', '襄阳', '湖北-襄阳', 1200201, '1200000', 0, NULL, '2018-03-30 12:00:00', 1, 3575, 3594);
INSERT INTO `base_region` VALUES ('1200202', '襄州', '湖北-襄阳-襄州', 1200202, '1200201', 1, NULL, '2018-03-30 12:00:00', 1, 3576, 3577);
INSERT INTO `base_region` VALUES ('1200203', '保康', '湖北-襄阳-保康', 1200203, '1200201', 1, NULL, '2018-03-30 12:00:00', 1, 3578, 3579);
INSERT INTO `base_region` VALUES ('1200204', '南漳', '湖北-襄阳-南漳', 1200204, '1200201', 1, NULL, '2018-03-30 12:00:00', 1, 3580, 3581);
INSERT INTO `base_region` VALUES ('1200205', '宜城', '湖北-襄阳-宜城', 1200205, '1200201', 1, NULL, '2018-03-30 12:00:00', 1, 3582, 3583);
INSERT INTO `base_region` VALUES ('1200206', '老河口', '湖北-襄阳-老河口', 1200206, '1200201', 1, NULL, '2018-03-30 12:00:00', 1, 3584, 3585);
INSERT INTO `base_region` VALUES ('1200207', '谷城', '湖北-襄阳-谷城', 1200207, '1200201', 1, NULL, '2018-03-30 12:00:00', 1, 3586, 3587);
INSERT INTO `base_region` VALUES ('1200208', '枣阳', '湖北-襄阳-枣阳', 1200208, '1200201', 1, NULL, '2018-03-30 12:00:00', 1, 3588, 3589);
INSERT INTO `base_region` VALUES ('1200209', '襄城', '湖北-襄阳-襄城', 1200209, '1200201', 1, NULL, '2018-03-30 12:00:00', 1, 3590, 3591);
INSERT INTO `base_region` VALUES ('1200210', '樊城', '湖北-襄阳-樊城', 1200210, '1200201', 1, NULL, '2018-03-30 12:00:00', 1, 3592, 3593);
INSERT INTO `base_region` VALUES ('1200301', '鄂州', '湖北-鄂州', 1200301, '1200000', 0, NULL, '2018-03-30 12:00:00', 1, 3595, 3602);
INSERT INTO `base_region` VALUES ('1200302', '梁子湖', '湖北-鄂州-梁子湖', 1200302, '1200301', 1, NULL, '2018-03-30 12:00:00', 1, 3596, 3597);
INSERT INTO `base_region` VALUES ('1200303', '华容', '湖北-鄂州-华容', 1200303, '1200301', 1, NULL, '2018-03-30 12:00:00', 1, 3598, 3599);
INSERT INTO `base_region` VALUES ('1200304', '鄂城', '湖北-鄂州-鄂城', 1200304, '1200301', 1, NULL, '2018-03-30 12:00:00', 1, 3600, 3601);
INSERT INTO `base_region` VALUES ('1200401', '孝感', '湖北-孝感', 1200401, '1200000', 0, NULL, '2018-03-30 12:00:00', 1, 3603, 3618);
INSERT INTO `base_region` VALUES ('1200402', '安陆', '湖北-孝感-安陆', 1200402, '1200401', 1, NULL, '2018-03-30 12:00:00', 1, 3604, 3605);
INSERT INTO `base_region` VALUES ('1200403', '云梦', '湖北-孝感-云梦', 1200403, '1200401', 1, NULL, '2018-03-30 12:00:00', 1, 3606, 3607);
INSERT INTO `base_region` VALUES ('1200404', '大悟', '湖北-孝感-大悟', 1200404, '1200401', 1, NULL, '2018-03-30 12:00:00', 1, 3608, 3609);
INSERT INTO `base_region` VALUES ('1200405', '应城', '湖北-孝感-应城', 1200405, '1200401', 1, NULL, '2018-03-30 12:00:00', 1, 3610, 3611);
INSERT INTO `base_region` VALUES ('1200406', '汉川', '湖北-孝感-汉川', 1200406, '1200401', 1, NULL, '2018-03-30 12:00:00', 1, 3612, 3613);
INSERT INTO `base_region` VALUES ('1200407', '孝昌', '湖北-孝感-孝昌', 1200407, '1200401', 1, NULL, '2018-03-30 12:00:00', 1, 3614, 3615);
INSERT INTO `base_region` VALUES ('1200408', '孝南', '湖北-孝感-孝南', 1200408, '1200401', 1, NULL, '2018-03-30 12:00:00', 1, 3616, 3617);
INSERT INTO `base_region` VALUES ('1200501', '黄冈', '湖北-黄冈', 1200501, '1200000', 0, NULL, '2018-03-30 12:00:00', 1, 3619, 3640);
INSERT INTO `base_region` VALUES ('1200502', '红安', '湖北-黄冈-红安', 1200502, '1200501', 1, NULL, '2018-03-30 12:00:00', 1, 3620, 3621);
INSERT INTO `base_region` VALUES ('1200503', '麻城', '湖北-黄冈-麻城', 1200503, '1200501', 1, NULL, '2018-03-30 12:00:00', 1, 3622, 3623);
INSERT INTO `base_region` VALUES ('1200504', '罗田', '湖北-黄冈-罗田', 1200504, '1200501', 1, NULL, '2018-03-30 12:00:00', 1, 3624, 3625);
INSERT INTO `base_region` VALUES ('1200505', '英山', '湖北-黄冈-英山', 1200505, '1200501', 1, NULL, '2018-03-30 12:00:00', 1, 3626, 3627);
INSERT INTO `base_region` VALUES ('1200506', '浠水', '湖北-黄冈-浠水', 1200506, '1200501', 1, NULL, '2018-03-30 12:00:00', 1, 3628, 3629);
INSERT INTO `base_region` VALUES ('1200507', '蕲春', '湖北-黄冈-蕲春', 1200507, '1200501', 1, NULL, '2018-03-30 12:00:00', 1, 3630, 3631);
INSERT INTO `base_region` VALUES ('1200508', '黄梅', '湖北-黄冈-黄梅', 1200508, '1200501', 1, NULL, '2018-03-30 12:00:00', 1, 3632, 3633);
INSERT INTO `base_region` VALUES ('1200509', '武穴', '湖北-黄冈-武穴', 1200509, '1200501', 1, NULL, '2018-03-30 12:00:00', 1, 3634, 3635);
INSERT INTO `base_region` VALUES ('1200510', '团风', '湖北-黄冈-团风', 1200510, '1200501', 1, NULL, '2018-03-30 12:00:00', 1, 3636, 3637);
INSERT INTO `base_region` VALUES ('1200511', '黄州', '湖北-黄冈-黄州', 1200511, '1200501', 1, NULL, '2018-03-30 12:00:00', 1, 3638, 3639);
INSERT INTO `base_region` VALUES ('1200601', '黄石', '湖北-黄石', 1200601, '1200000', 0, NULL, '2018-03-30 12:00:00', 1, 3641, 3654);
INSERT INTO `base_region` VALUES ('1200602', '大冶', '湖北-黄石-大冶', 1200602, '1200601', 1, NULL, '2018-03-30 12:00:00', 1, 3642, 3643);
INSERT INTO `base_region` VALUES ('1200603', '阳新', '湖北-黄石-阳新', 1200603, '1200601', 1, NULL, '2018-03-30 12:00:00', 1, 3644, 3645);
INSERT INTO `base_region` VALUES ('1200604', '铁山', '湖北-黄石-铁山', 1200604, '1200601', 1, NULL, '2018-03-30 12:00:00', 1, 3646, 3647);
INSERT INTO `base_region` VALUES ('1200605', '下陆', '湖北-黄石-下陆', 1200605, '1200601', 1, NULL, '2018-03-30 12:00:00', 1, 3648, 3649);
INSERT INTO `base_region` VALUES ('1200606', '西塞山', '湖北-黄石-西塞山', 1200606, '1200601', 1, NULL, '2018-03-30 12:00:00', 1, 3650, 3651);
INSERT INTO `base_region` VALUES ('1200607', '黄石港', '湖北-黄石-黄石港', 1200607, '1200601', 1, NULL, '2018-03-30 12:00:00', 1, 3652, 3653);
INSERT INTO `base_region` VALUES ('1200701', '咸宁', '湖北-咸宁', 1200701, '1200000', 0, NULL, '2018-03-30 12:00:00', 1, 3655, 3668);
INSERT INTO `base_region` VALUES ('1200702', '赤壁', '湖北-咸宁-赤壁', 1200702, '1200701', 1, NULL, '2018-03-30 12:00:00', 1, 3656, 3657);
INSERT INTO `base_region` VALUES ('1200703', '嘉鱼', '湖北-咸宁-嘉鱼', 1200703, '1200701', 1, NULL, '2018-03-30 12:00:00', 1, 3658, 3659);
INSERT INTO `base_region` VALUES ('1200704', '崇阳', '湖北-咸宁-崇阳', 1200704, '1200701', 1, NULL, '2018-03-30 12:00:00', 1, 3660, 3661);
INSERT INTO `base_region` VALUES ('1200705', '通城', '湖北-咸宁-通城', 1200705, '1200701', 1, NULL, '2018-03-30 12:00:00', 1, 3662, 3663);
INSERT INTO `base_region` VALUES ('1200706', '通山', '湖北-咸宁-通山', 1200706, '1200701', 1, NULL, '2018-03-30 12:00:00', 1, 3664, 3665);
INSERT INTO `base_region` VALUES ('1200707', '咸安', '湖北-咸宁-咸安', 1200707, '1200701', 1, NULL, '2018-03-30 12:00:00', 1, 3666, 3667);
INSERT INTO `base_region` VALUES ('1200801', '荆州', '湖北-荆州', 1200801, '1200000', 0, NULL, '2018-03-30 12:00:00', 1, 3669, 3684);
INSERT INTO `base_region` VALUES ('1200802', '江陵', '湖北-荆州-江陵', 1200802, '1200801', 1, NULL, '2018-03-30 12:00:00', 1, 3670, 3671);
INSERT INTO `base_region` VALUES ('1200803', '公安', '湖北-荆州-公安', 1200803, '1200801', 1, NULL, '2018-03-30 12:00:00', 1, 3672, 3673);
INSERT INTO `base_region` VALUES ('1200804', '石首', '湖北-荆州-石首', 1200804, '1200801', 1, NULL, '2018-03-30 12:00:00', 1, 3674, 3675);
INSERT INTO `base_region` VALUES ('1200805', '监利', '湖北-荆州-监利', 1200805, '1200801', 1, NULL, '2018-03-30 12:00:00', 1, 3676, 3677);
INSERT INTO `base_region` VALUES ('1200806', '洪湖', '湖北-荆州-洪湖', 1200806, '1200801', 1, NULL, '2018-03-30 12:00:00', 1, 3678, 3679);
INSERT INTO `base_region` VALUES ('1200807', '松滋', '湖北-荆州-松滋', 1200807, '1200801', 1, NULL, '2018-03-30 12:00:00', 1, 3680, 3681);
INSERT INTO `base_region` VALUES ('1200808', '沙市', '湖北-荆州-沙市', 1200808, '1200801', 1, NULL, '2018-03-30 12:00:00', 1, 3682, 3683);
INSERT INTO `base_region` VALUES ('1200901', '宜昌', '湖北-宜昌', 1200901, '1200000', 0, NULL, '2018-03-30 12:00:00', 1, 3685, 3712);
INSERT INTO `base_region` VALUES ('1200902', '远安', '湖北-宜昌-远安', 1200902, '1200901', 1, NULL, '2018-03-30 12:00:00', 1, 3686, 3687);
INSERT INTO `base_region` VALUES ('1200903', '秭归', '湖北-宜昌-秭归', 1200903, '1200901', 1, NULL, '2018-03-30 12:00:00', 1, 3688, 3689);
INSERT INTO `base_region` VALUES ('1200904', '兴山', '湖北-宜昌-兴山', 1200904, '1200901', 1, NULL, '2018-03-30 12:00:00', 1, 3690, 3691);
INSERT INTO `base_region` VALUES ('1200905', '西陵', '湖北-宜昌-西陵', 1200905, '1200901', 1, NULL, '2018-03-30 12:00:00', 1, 3692, 3693);
INSERT INTO `base_region` VALUES ('1200906', '五峰', '湖北-宜昌-五峰', 1200906, '1200901', 1, NULL, '2018-03-30 12:00:00', 1, 3694, 3695);
INSERT INTO `base_region` VALUES ('1200907', '当阳', '湖北-宜昌-当阳', 1200907, '1200901', 1, NULL, '2018-03-30 12:00:00', 1, 3696, 3697);
INSERT INTO `base_region` VALUES ('1200908', '长阳', '湖北-宜昌-长阳', 1200908, '1200901', 1, NULL, '2018-03-30 12:00:00', 1, 3698, 3699);
INSERT INTO `base_region` VALUES ('1200909', '宜都', '湖北-宜昌-宜都', 1200909, '1200901', 1, NULL, '2018-03-30 12:00:00', 1, 3700, 3701);
INSERT INTO `base_region` VALUES ('1200910', '枝江', '湖北-宜昌-枝江', 1200910, '1200901', 1, NULL, '2018-03-30 12:00:00', 1, 3702, 3703);
INSERT INTO `base_region` VALUES ('1200912', '夷陵', '湖北-宜昌-夷陵', 1200912, '1200901', 1, NULL, '2018-03-30 12:00:00', 1, 3704, 3705);
INSERT INTO `base_region` VALUES ('1200913', '伍家岗', '湖北-宜昌-伍家岗', 1200913, '1200901', 1, NULL, '2018-03-30 12:00:00', 1, 3706, 3707);
INSERT INTO `base_region` VALUES ('1200914', '点军', '湖北-宜昌-点军', 1200914, '1200901', 1, NULL, '2018-03-30 12:00:00', 1, 3708, 3709);
INSERT INTO `base_region` VALUES ('1200915', '猇亭', '湖北-宜昌-猇亭', 1200915, '1200901', 1, NULL, '2018-03-30 12:00:00', 1, 3710, 3711);
INSERT INTO `base_region` VALUES ('1201001', '恩施', '湖北-恩施', 1201001, '1200000', 0, NULL, '2018-03-30 12:00:00', 1, 3713, 3728);
INSERT INTO `base_region` VALUES ('1201002', '利川', '湖北-恩施-利川', 1201002, '1201001', 1, NULL, '2018-03-30 12:00:00', 1, 3714, 3715);
INSERT INTO `base_region` VALUES ('1201003', '建始', '湖北-恩施-建始', 1201003, '1201001', 1, NULL, '2018-03-30 12:00:00', 1, 3716, 3717);
INSERT INTO `base_region` VALUES ('1201004', '咸丰', '湖北-恩施-咸丰', 1201004, '1201001', 1, NULL, '2018-03-30 12:00:00', 1, 3718, 3719);
INSERT INTO `base_region` VALUES ('1201005', '宣恩', '湖北-恩施-宣恩', 1201005, '1201001', 1, NULL, '2018-03-30 12:00:00', 1, 3720, 3721);
INSERT INTO `base_region` VALUES ('1201006', '鹤峰', '湖北-恩施-鹤峰', 1201006, '1201001', 1, NULL, '2018-03-30 12:00:00', 1, 3722, 3723);
INSERT INTO `base_region` VALUES ('1201007', '来凤', '湖北-恩施-来凤', 1201007, '1201001', 1, NULL, '2018-03-30 12:00:00', 1, 3724, 3725);
INSERT INTO `base_region` VALUES ('1201008', '巴东', '湖北-恩施-巴东', 1201008, '1201001', 1, NULL, '2018-03-30 12:00:00', 1, 3726, 3727);
INSERT INTO `base_region` VALUES ('1201101', '十堰', '湖北-十堰', 1201101, '1200000', 0, NULL, '2018-03-30 12:00:00', 1, 3729, 3746);
INSERT INTO `base_region` VALUES ('1201102', '竹溪', '湖北-十堰-竹溪', 1201102, '1201101', 1, NULL, '2018-03-30 12:00:00', 1, 3730, 3731);
INSERT INTO `base_region` VALUES ('1201103', '郧西', '湖北-十堰-郧西', 1201103, '1201101', 1, NULL, '2018-03-30 12:00:00', 1, 3732, 3733);
INSERT INTO `base_region` VALUES ('1201104', '郧阳', '湖北-十堰-郧阳', 1201104, '1201101', 1, NULL, '2018-03-30 12:00:00', 1, 3734, 3735);
INSERT INTO `base_region` VALUES ('1201105', '竹山', '湖北-十堰-竹山', 1201105, '1201101', 1, NULL, '2018-03-30 12:00:00', 1, 3736, 3737);
INSERT INTO `base_region` VALUES ('1201106', '房县', '湖北-十堰-房县', 1201106, '1201101', 1, NULL, '2018-03-30 12:00:00', 1, 3738, 3739);
INSERT INTO `base_region` VALUES ('1201107', '丹江口', '湖北-十堰-丹江口', 1201107, '1201101', 1, NULL, '2018-03-30 12:00:00', 1, 3740, 3741);
INSERT INTO `base_region` VALUES ('1201108', '茅箭', '湖北-十堰-茅箭', 1201108, '1201101', 1, NULL, '2018-03-30 12:00:00', 1, 3742, 3743);
INSERT INTO `base_region` VALUES ('1201109', '张湾', '湖北-十堰-张湾', 1201109, '1201101', 1, NULL, '2018-03-30 12:00:00', 1, 3744, 3745);
INSERT INTO `base_region` VALUES ('1201201', '神农架', '湖北-神农架', 1201201, '1200000', 0, NULL, '2018-03-30 12:00:00', 1, 3747, 3748);
INSERT INTO `base_region` VALUES ('1201301', '随州', '湖北-随州', 1201301, '1200000', 0, NULL, '2018-03-30 12:00:00', 1, 3749, 3756);
INSERT INTO `base_region` VALUES ('1201302', '广水', '湖北-随州-广水', 1201302, '1201301', 1, NULL, '2018-03-30 12:00:00', 1, 3750, 3751);
INSERT INTO `base_region` VALUES ('1201303', '曾都', '湖北-随州-曾都', 1201303, '1201301', 1, NULL, '2018-03-30 12:00:00', 1, 3752, 3753);
INSERT INTO `base_region` VALUES ('1201304', '随县', '湖北-随州-随县', 1201304, '1201301', 1, NULL, '2018-03-30 12:00:00', 1, 3754, 3755);
INSERT INTO `base_region` VALUES ('1201401', '荆门', '湖北-荆门', 1201401, '1200000', 0, NULL, '2018-03-30 12:00:00', 1, 3757, 3768);
INSERT INTO `base_region` VALUES ('1201402', '钟祥', '湖北-荆门-钟祥', 1201402, '1201401', 1, NULL, '2018-03-30 12:00:00', 1, 3758, 3759);
INSERT INTO `base_region` VALUES ('1201403', '京山', '湖北-荆门-京山', 1201403, '1201401', 1, NULL, '2018-03-30 12:00:00', 1, 3760, 3761);
INSERT INTO `base_region` VALUES ('1201404', '掇刀', '湖北-荆门-掇刀', 1201404, '1201401', 1, NULL, '2018-03-30 12:00:00', 1, 3762, 3763);
INSERT INTO `base_region` VALUES ('1201405', '沙洋', '湖北-荆门-沙洋', 1201405, '1201401', 1, NULL, '2018-03-30 12:00:00', 1, 3764, 3765);
INSERT INTO `base_region` VALUES ('1201406', '东宝', '湖北-荆门-东宝', 1201406, '1201401', 1, NULL, '2018-03-30 12:00:00', 1, 3766, 3767);
INSERT INTO `base_region` VALUES ('1201501', '天门', '湖北-天门', 1201501, '1200000', 0, NULL, '2018-03-30 12:00:00', 1, 3769, 3770);
INSERT INTO `base_region` VALUES ('1201601', '仙桃', '湖北-仙桃', 1201601, '1200000', 0, NULL, '2018-03-30 12:00:00', 1, 3771, 3772);
INSERT INTO `base_region` VALUES ('1201701', '潜江', '湖北-潜江', 1201701, '1200000', 0, NULL, '2018-03-30 12:00:00', 1, 3773, 3774);
INSERT INTO `base_region` VALUES ('1210000', '浙江', '浙江', 1210000, 'ROOT', 0, NULL, '2018-03-30 12:00:00', 1, 3776, 3979);
INSERT INTO `base_region` VALUES ('1210101', '杭州', '浙江-杭州', 1210101, '1210000', 0, NULL, '2018-03-30 12:00:00', 1, 3777, 3804);
INSERT INTO `base_region` VALUES ('1210102', '萧山', '浙江-杭州-萧山', 1210102, '1210101', 1, NULL, '2018-03-30 12:00:00', 1, 3778, 3779);
INSERT INTO `base_region` VALUES ('1210103', '桐庐', '浙江-杭州-桐庐', 1210103, '1210101', 1, NULL, '2018-03-30 12:00:00', 1, 3780, 3781);
INSERT INTO `base_region` VALUES ('1210104', '淳安', '浙江-杭州-淳安', 1210104, '1210101', 1, NULL, '2018-03-30 12:00:00', 1, 3782, 3783);
INSERT INTO `base_region` VALUES ('1210105', '建德', '浙江-杭州-建德', 1210105, '1210101', 1, NULL, '2018-03-30 12:00:00', 1, 3784, 3785);
INSERT INTO `base_region` VALUES ('1210106', '余杭', '浙江-杭州-余杭', 1210106, '1210101', 1, NULL, '2018-03-30 12:00:00', 1, 3786, 3787);
INSERT INTO `base_region` VALUES ('1210107', '临安', '浙江-杭州-临安', 1210107, '1210101', 1, NULL, '2018-03-30 12:00:00', 1, 3788, 3789);
INSERT INTO `base_region` VALUES ('1210108', '富阳', '浙江-杭州-富阳', 1210108, '1210101', 1, NULL, '2018-03-30 12:00:00', 1, 3790, 3791);
INSERT INTO `base_region` VALUES ('1210109', '上城', '浙江-杭州-上城', 1210109, '1210101', 1, NULL, '2018-03-30 12:00:00', 1, 3792, 3793);
INSERT INTO `base_region` VALUES ('1210110', '下城', '浙江-杭州-下城', 1210110, '1210101', 1, NULL, '2018-03-30 12:00:00', 1, 3794, 3795);
INSERT INTO `base_region` VALUES ('1210111', '江干', '浙江-杭州-江干', 1210111, '1210101', 1, NULL, '2018-03-30 12:00:00', 1, 3796, 3797);
INSERT INTO `base_region` VALUES ('1210112', '拱墅', '浙江-杭州-拱墅', 1210112, '1210101', 1, NULL, '2018-03-30 12:00:00', 1, 3798, 3799);
INSERT INTO `base_region` VALUES ('1210113', '西湖', '浙江-杭州-西湖', 1210113, '1210101', 1, NULL, '2018-03-30 12:00:00', 1, 3800, 3801);
INSERT INTO `base_region` VALUES ('1210114', '滨江', '浙江-杭州-滨江', 1210114, '1210101', 1, NULL, '2018-03-30 12:00:00', 1, 3802, 3803);
INSERT INTO `base_region` VALUES ('1210201', '湖州', '浙江-湖州', 1210201, '1210000', 0, NULL, '2018-03-30 12:00:00', 1, 3805, 3816);
INSERT INTO `base_region` VALUES ('1210202', '长兴', '浙江-湖州-长兴', 1210202, '1210201', 1, NULL, '2018-03-30 12:00:00', 1, 3806, 3807);
INSERT INTO `base_region` VALUES ('1210203', '安吉', '浙江-湖州-安吉', 1210203, '1210201', 1, NULL, '2018-03-30 12:00:00', 1, 3808, 3809);
INSERT INTO `base_region` VALUES ('1210204', '德清', '浙江-湖州-德清', 1210204, '1210201', 1, NULL, '2018-03-30 12:00:00', 1, 3810, 3811);
INSERT INTO `base_region` VALUES ('1210205', '吴兴', '浙江-湖州-吴兴', 1210205, '1210201', 1, NULL, '2018-03-30 12:00:00', 1, 3812, 3813);
INSERT INTO `base_region` VALUES ('1210206', '南浔', '浙江-湖州-南浔', 1210206, '1210201', 1, NULL, '2018-03-30 12:00:00', 1, 3814, 3815);
INSERT INTO `base_region` VALUES ('1210301', '嘉兴', '浙江-嘉兴', 1210301, '1210000', 0, NULL, '2018-03-30 12:00:00', 1, 3817, 3832);
INSERT INTO `base_region` VALUES ('1210302', '嘉善', '浙江-嘉兴-嘉善', 1210302, '1210301', 1, NULL, '2018-03-30 12:00:00', 1, 3818, 3819);
INSERT INTO `base_region` VALUES ('1210303', '海宁', '浙江-嘉兴-海宁', 1210303, '1210301', 1, NULL, '2018-03-30 12:00:00', 1, 3820, 3821);
INSERT INTO `base_region` VALUES ('1210304', '桐乡', '浙江-嘉兴-桐乡', 1210304, '1210301', 1, NULL, '2018-03-30 12:00:00', 1, 3822, 3823);
INSERT INTO `base_region` VALUES ('1210305', '平湖', '浙江-嘉兴-平湖', 1210305, '1210301', 1, NULL, '2018-03-30 12:00:00', 1, 3824, 3825);
INSERT INTO `base_region` VALUES ('1210306', '海盐', '浙江-嘉兴-海盐', 1210306, '1210301', 1, NULL, '2018-03-30 12:00:00', 1, 3826, 3827);
INSERT INTO `base_region` VALUES ('1210307', '南湖', '浙江-嘉兴-南湖', 1210307, '1210301', 1, NULL, '2018-03-30 12:00:00', 1, 3828, 3829);
INSERT INTO `base_region` VALUES ('1210308', '秀洲', '浙江-嘉兴-秀洲', 1210308, '1210301', 1, NULL, '2018-03-30 12:00:00', 1, 3830, 3831);
INSERT INTO `base_region` VALUES ('1210401', '宁波', '浙江-宁波', 1210401, '1210000', 0, NULL, '2018-03-30 12:00:00', 1, 3833, 3856);
INSERT INTO `base_region` VALUES ('1210402', '海曙', '浙江-宁波-海曙', 1210402, '1210401', 1, NULL, '2018-03-30 12:00:00', 1, 3834, 3835);
INSERT INTO `base_region` VALUES ('1210403', '慈溪', '浙江-宁波-慈溪', 1210403, '1210401', 1, NULL, '2018-03-30 12:00:00', 1, 3836, 3837);
INSERT INTO `base_region` VALUES ('1210404', '余姚', '浙江-宁波-余姚', 1210404, '1210401', 1, NULL, '2018-03-30 12:00:00', 1, 3838, 3839);
INSERT INTO `base_region` VALUES ('1210405', '奉化', '浙江-宁波-奉化', 1210405, '1210401', 1, NULL, '2018-03-30 12:00:00', 1, 3840, 3841);
INSERT INTO `base_region` VALUES ('1210406', '象山', '浙江-宁波-象山', 1210406, '1210401', 1, NULL, '2018-03-30 12:00:00', 1, 3842, 3843);
INSERT INTO `base_region` VALUES ('1210407', '江东', '浙江-宁波-江东', 1210407, '1210401', 1, NULL, '2018-03-30 12:00:00', 1, 3844, 3845);
INSERT INTO `base_region` VALUES ('1210408', '宁海', '浙江-宁波-宁海', 1210408, '1210401', 1, NULL, '2018-03-30 12:00:00', 1, 3846, 3847);
INSERT INTO `base_region` VALUES ('1210409', '江北', '浙江-宁波-江北', 1210409, '1210401', 1, NULL, '2018-03-30 12:00:00', 1, 3848, 3849);
INSERT INTO `base_region` VALUES ('1210410', '北仑', '浙江-宁波-北仑', 1210410, '1210401', 1, NULL, '2018-03-30 12:00:00', 1, 3850, 3851);
INSERT INTO `base_region` VALUES ('1210411', '鄞州', '浙江-宁波-鄞州', 1210411, '1210401', 1, NULL, '2018-03-30 12:00:00', 1, 3852, 3853);
INSERT INTO `base_region` VALUES ('1210412', '镇海', '浙江-宁波-镇海', 1210412, '1210401', 1, NULL, '2018-03-30 12:00:00', 1, 3854, 3855);
INSERT INTO `base_region` VALUES ('1210501', '越城', '浙江-绍兴-越城', 1210501, '1210507', 1, NULL, '2018-03-30 12:00:00', 1, 3858, 3859);
INSERT INTO `base_region` VALUES ('1210502', '诸暨', '浙江-绍兴-诸暨', 1210502, '1210507', 1, NULL, '2018-03-30 12:00:00', 1, 3860, 3861);
INSERT INTO `base_region` VALUES ('1210503', '上虞', '浙江-绍兴-上虞', 1210503, '1210507', 1, NULL, '2018-03-30 12:00:00', 1, 3862, 3863);
INSERT INTO `base_region` VALUES ('1210504', '新昌', '浙江-绍兴-新昌', 1210504, '1210507', 1, NULL, '2018-03-30 12:00:00', 1, 3864, 3865);
INSERT INTO `base_region` VALUES ('1210505', '嵊州', '浙江-绍兴-嵊州', 1210505, '1210507', 1, NULL, '2018-03-30 12:00:00', 1, 3866, 3867);
INSERT INTO `base_region` VALUES ('1210506', '柯桥', '浙江-绍兴-柯桥', 1210506, '1210507', 1, NULL, '2018-03-30 12:00:00', 1, 3868, 3869);
INSERT INTO `base_region` VALUES ('1210507', '绍兴', '浙江-绍兴', 1210507, '1210000', 0, NULL, '2018-03-30 12:00:00', 1, 3857, 3870);
INSERT INTO `base_region` VALUES ('1210601', '台州', '浙江-台州', 1210601, '1210000', 0, NULL, '2018-03-30 12:00:00', 1, 3871, 3890);
INSERT INTO `base_region` VALUES ('1210603', '玉环', '浙江-台州-玉环', 1210603, '1210601', 1, NULL, '2018-03-30 12:00:00', 1, 3872, 3873);
INSERT INTO `base_region` VALUES ('1210604', '三门', '浙江-台州-三门', 1210604, '1210601', 1, NULL, '2018-03-30 12:00:00', 1, 3874, 3875);
INSERT INTO `base_region` VALUES ('1210605', '天台', '浙江-台州-天台', 1210605, '1210601', 1, NULL, '2018-03-30 12:00:00', 1, 3876, 3877);
INSERT INTO `base_region` VALUES ('1210606', '仙居', '浙江-台州-仙居', 1210606, '1210601', 1, NULL, '2018-03-30 12:00:00', 1, 3878, 3879);
INSERT INTO `base_region` VALUES ('1210607', '温岭', '浙江-台州-温岭', 1210607, '1210601', 1, NULL, '2018-03-30 12:00:00', 1, 3880, 3881);
INSERT INTO `base_region` VALUES ('1210610', '临海', '浙江-台州-临海', 1210610, '1210601', 1, NULL, '2018-03-30 12:00:00', 1, 3882, 3883);
INSERT INTO `base_region` VALUES ('1210611', '椒江', '浙江-台州-椒江', 1210611, '1210601', 1, NULL, '2018-03-30 12:00:00', 1, 3884, 3885);
INSERT INTO `base_region` VALUES ('1210612', '黄岩', '浙江-台州-黄岩', 1210612, '1210601', 1, NULL, '2018-03-30 12:00:00', 1, 3886, 3887);
INSERT INTO `base_region` VALUES ('1210613', '路桥', '浙江-台州-路桥', 1210613, '1210601', 1, NULL, '2018-03-30 12:00:00', 1, 3888, 3889);
INSERT INTO `base_region` VALUES ('1210701', '温州', '浙江-温州', 1210701, '1210000', 0, NULL, '2018-03-30 12:00:00', 1, 3891, 3914);
INSERT INTO `base_region` VALUES ('1210702', '泰顺', '浙江-温州-泰顺', 1210702, '1210701', 1, NULL, '2018-03-30 12:00:00', 1, 3892, 3893);
INSERT INTO `base_region` VALUES ('1210703', '文成', '浙江-温州-文成', 1210703, '1210701', 1, NULL, '2018-03-30 12:00:00', 1, 3894, 3895);
INSERT INTO `base_region` VALUES ('1210704', '平阳', '浙江-温州-平阳', 1210704, '1210701', 1, NULL, '2018-03-30 12:00:00', 1, 3896, 3897);
INSERT INTO `base_region` VALUES ('1210705', '瑞安', '浙江-温州-瑞安', 1210705, '1210701', 1, NULL, '2018-03-30 12:00:00', 1, 3898, 3899);
INSERT INTO `base_region` VALUES ('1210706', '洞头', '浙江-温州-洞头', 1210706, '1210701', 1, NULL, '2018-03-30 12:00:00', 1, 3900, 3901);
INSERT INTO `base_region` VALUES ('1210707', '乐清', '浙江-温州-乐清', 1210707, '1210701', 1, NULL, '2018-03-30 12:00:00', 1, 3902, 3903);
INSERT INTO `base_region` VALUES ('1210708', '永嘉', '浙江-温州-永嘉', 1210708, '1210701', 1, NULL, '2018-03-30 12:00:00', 1, 3904, 3905);
INSERT INTO `base_region` VALUES ('1210709', '苍南', '浙江-温州-苍南', 1210709, '1210701', 1, NULL, '2018-03-30 12:00:00', 1, 3906, 3907);
INSERT INTO `base_region` VALUES ('1210710', '鹿城', '浙江-温州-鹿城', 1210710, '1210701', 1, NULL, '2018-03-30 12:00:00', 1, 3908, 3909);
INSERT INTO `base_region` VALUES ('1210711', '龙湾', '浙江-温州-龙湾', 1210711, '1210701', 1, NULL, '2018-03-30 12:00:00', 1, 3910, 3911);
INSERT INTO `base_region` VALUES ('1210712', '瓯海', '浙江-温州-瓯海', 1210712, '1210701', 1, NULL, '2018-03-30 12:00:00', 1, 3912, 3913);
INSERT INTO `base_region` VALUES ('1210801', '丽水', '浙江-丽水', 1210801, '1210000', 0, NULL, '2018-03-30 12:00:00', 1, 3915, 3934);
INSERT INTO `base_region` VALUES ('1210802', '遂昌', '浙江-丽水-遂昌', 1210802, '1210801', 1, NULL, '2018-03-30 12:00:00', 1, 3916, 3917);
INSERT INTO `base_region` VALUES ('1210803', '龙泉', '浙江-丽水-龙泉', 1210803, '1210801', 1, NULL, '2018-03-30 12:00:00', 1, 3918, 3919);
INSERT INTO `base_region` VALUES ('1210804', '缙云', '浙江-丽水-缙云', 1210804, '1210801', 1, NULL, '2018-03-30 12:00:00', 1, 3920, 3921);
INSERT INTO `base_region` VALUES ('1210805', '青田', '浙江-丽水-青田', 1210805, '1210801', 1, NULL, '2018-03-30 12:00:00', 1, 3922, 3923);
INSERT INTO `base_region` VALUES ('1210806', '云和', '浙江-丽水-云和', 1210806, '1210801', 1, NULL, '2018-03-30 12:00:00', 1, 3924, 3925);
INSERT INTO `base_region` VALUES ('1210807', '庆元', '浙江-丽水-庆元', 1210807, '1210801', 1, NULL, '2018-03-30 12:00:00', 1, 3926, 3927);
INSERT INTO `base_region` VALUES ('1210808', '松阳', '浙江-丽水-松阳', 1210808, '1210801', 1, NULL, '2018-03-30 12:00:00', 1, 3928, 3929);
INSERT INTO `base_region` VALUES ('1210809', '景宁', '浙江-丽水-景宁', 1210809, '1210801', 1, NULL, '2018-03-30 12:00:00', 1, 3930, 3931);
INSERT INTO `base_region` VALUES ('1210810', '莲都', '浙江-丽水-莲都', 1210810, '1210801', 1, NULL, '2018-03-30 12:00:00', 1, 3932, 3933);
INSERT INTO `base_region` VALUES ('1210901', '金华', '浙江-金华', 1210901, '1210000', 0, NULL, '2018-03-30 12:00:00', 1, 3935, 3954);
INSERT INTO `base_region` VALUES ('1210902', '浦江', '浙江-金华-浦江', 1210902, '1210901', 1, NULL, '2018-03-30 12:00:00', 1, 3936, 3937);
INSERT INTO `base_region` VALUES ('1210903', '兰溪', '浙江-金华-兰溪', 1210903, '1210901', 1, NULL, '2018-03-30 12:00:00', 1, 3938, 3939);
INSERT INTO `base_region` VALUES ('1210904', '义乌', '浙江-金华-义乌', 1210904, '1210901', 1, NULL, '2018-03-30 12:00:00', 1, 3940, 3941);
INSERT INTO `base_region` VALUES ('1210905', '东阳', '浙江-金华-东阳', 1210905, '1210901', 1, NULL, '2018-03-30 12:00:00', 1, 3942, 3943);
INSERT INTO `base_region` VALUES ('1210906', '武义', '浙江-金华-武义', 1210906, '1210901', 1, NULL, '2018-03-30 12:00:00', 1, 3944, 3945);
INSERT INTO `base_region` VALUES ('1210907', '永康', '浙江-金华-永康', 1210907, '1210901', 1, NULL, '2018-03-30 12:00:00', 1, 3946, 3947);
INSERT INTO `base_region` VALUES ('1210908', '磐安', '浙江-金华-磐安', 1210908, '1210901', 1, NULL, '2018-03-30 12:00:00', 1, 3948, 3949);
INSERT INTO `base_region` VALUES ('1210909', '婺城', '浙江-金华-婺城', 1210909, '1210901', 1, NULL, '2018-03-30 12:00:00', 1, 3950, 3951);
INSERT INTO `base_region` VALUES ('1210910', '金东', '浙江-金华-金东', 1210910, '1210901', 1, NULL, '2018-03-30 12:00:00', 1, 3952, 3953);
INSERT INTO `base_region` VALUES ('1211001', '衢州', '浙江-衢州', 1211001, '1210000', 0, NULL, '2018-03-30 12:00:00', 1, 3955, 3968);
INSERT INTO `base_region` VALUES ('1211002', '常山', '浙江-衢州-常山', 1211002, '1211001', 1, NULL, '2018-03-30 12:00:00', 1, 3956, 3957);
INSERT INTO `base_region` VALUES ('1211003', '开化', '浙江-衢州-开化', 1211003, '1211001', 1, NULL, '2018-03-30 12:00:00', 1, 3958, 3959);
INSERT INTO `base_region` VALUES ('1211004', '龙游', '浙江-衢州-龙游', 1211004, '1211001', 1, NULL, '2018-03-30 12:00:00', 1, 3960, 3961);
INSERT INTO `base_region` VALUES ('1211005', '江山', '浙江-衢州-江山', 1211005, '1211001', 1, NULL, '2018-03-30 12:00:00', 1, 3962, 3963);
INSERT INTO `base_region` VALUES ('1211006', '衢江', '浙江-衢州-衢江', 1211006, '1211001', 1, NULL, '2018-03-30 12:00:00', 1, 3964, 3965);
INSERT INTO `base_region` VALUES ('1211007', '柯城', '浙江-衢州-柯城', 1211007, '1211001', 1, NULL, '2018-03-30 12:00:00', 1, 3966, 3967);
INSERT INTO `base_region` VALUES ('1211101', '舟山', '浙江-舟山', 1211101, '1210000', 0, NULL, '2018-03-30 12:00:00', 1, 3969, 3978);
INSERT INTO `base_region` VALUES ('1211102', '嵊泗', '浙江-舟山-嵊泗', 1211102, '1211101', 1, NULL, '2018-03-30 12:00:00', 1, 3970, 3971);
INSERT INTO `base_region` VALUES ('1211104', '岱山', '浙江-舟山-岱山', 1211104, '1211101', 1, NULL, '2018-03-30 12:00:00', 1, 3972, 3973);
INSERT INTO `base_region` VALUES ('1211105', '普陀', '浙江-舟山-普陀', 1211105, '1211101', 1, NULL, '2018-03-30 12:00:00', 1, 3974, 3975);
INSERT INTO `base_region` VALUES ('1211106', '定海', '浙江-舟山-定海', 1211106, '1211101', 1, NULL, '2018-03-30 12:00:00', 1, 3976, 3977);
INSERT INTO `base_region` VALUES ('1220000', '安徽', '安徽', 1220000, 'ROOT', 0, NULL, '2018-03-30 12:00:00', 1, 3980, 4225);
INSERT INTO `base_region` VALUES ('1220101', '合肥', '安徽-合肥', 1220101, '1220000', 0, NULL, '2018-03-30 12:00:00', 1, 3981, 4000);
INSERT INTO `base_region` VALUES ('1220102', '长丰', '安徽-合肥-长丰', 1220102, '1220101', 1, NULL, '2018-03-30 12:00:00', 1, 3982, 3983);
INSERT INTO `base_region` VALUES ('1220103', '肥东', '安徽-合肥-肥东', 1220103, '1220101', 1, NULL, '2018-03-30 12:00:00', 1, 3984, 3985);
INSERT INTO `base_region` VALUES ('1220104', '肥西', '安徽-合肥-肥西', 1220104, '1220101', 1, NULL, '2018-03-30 12:00:00', 1, 3986, 3987);
INSERT INTO `base_region` VALUES ('1220105', '巢湖', '安徽-合肥-巢湖', 1220105, '1220101', 1, NULL, '2018-03-30 12:00:00', 1, 3988, 3989);
INSERT INTO `base_region` VALUES ('1220106', '庐江', '安徽-合肥-庐江', 1220106, '1220101', 1, NULL, '2018-03-30 12:00:00', 1, 3990, 3991);
INSERT INTO `base_region` VALUES ('1220107', '瑶海', '安徽-合肥-瑶海', 1220107, '1220101', 1, NULL, '2018-03-30 12:00:00', 1, 3992, 3993);
INSERT INTO `base_region` VALUES ('1220108', '庐阳', '安徽-合肥-庐阳', 1220108, '1220101', 1, NULL, '2018-03-30 12:00:00', 1, 3994, 3995);
INSERT INTO `base_region` VALUES ('1220109', '蜀山', '安徽-合肥-蜀山', 1220109, '1220101', 1, NULL, '2018-03-30 12:00:00', 1, 3996, 3997);
INSERT INTO `base_region` VALUES ('1220110', '包河', '安徽-合肥-包河', 1220110, '1220101', 1, NULL, '2018-03-30 12:00:00', 1, 3998, 3999);
INSERT INTO `base_region` VALUES ('1220201', '蚌埠', '安徽-蚌埠', 1220201, '1220000', 0, NULL, '2018-03-30 12:00:00', 1, 4001, 4016);
INSERT INTO `base_region` VALUES ('1220202', '怀远', '安徽-蚌埠-怀远', 1220202, '1220201', 1, NULL, '2018-03-30 12:00:00', 1, 4002, 4003);
INSERT INTO `base_region` VALUES ('1220203', '固镇', '安徽-蚌埠-固镇', 1220203, '1220201', 1, NULL, '2018-03-30 12:00:00', 1, 4004, 4005);
INSERT INTO `base_region` VALUES ('1220204', '五河', '安徽-蚌埠-五河', 1220204, '1220201', 1, NULL, '2018-03-30 12:00:00', 1, 4006, 4007);
INSERT INTO `base_region` VALUES ('1220205', '龙子湖', '安徽-蚌埠-龙子湖', 1220205, '1220201', 1, NULL, '2018-03-30 12:00:00', 1, 4008, 4009);
INSERT INTO `base_region` VALUES ('1220206', '蚌山', '安徽-蚌埠-蚌山', 1220206, '1220201', 1, NULL, '2018-03-30 12:00:00', 1, 4010, 4011);
INSERT INTO `base_region` VALUES ('1220207', '禹会', '安徽-蚌埠-禹会', 1220207, '1220201', 1, NULL, '2018-03-30 12:00:00', 1, 4012, 4013);
INSERT INTO `base_region` VALUES ('1220208', '淮上', '安徽-蚌埠-淮上', 1220208, '1220201', 1, NULL, '2018-03-30 12:00:00', 1, 4014, 4015);
INSERT INTO `base_region` VALUES ('1220301', '芜湖', '安徽-芜湖', 1220301, '1220000', 0, NULL, '2018-03-30 12:00:00', 1, 4017, 4034);
INSERT INTO `base_region` VALUES ('1220302', '繁昌', '安徽-芜湖-繁昌', 1220302, '1220301', 1, NULL, '2018-03-30 12:00:00', 1, 4018, 4019);
INSERT INTO `base_region` VALUES ('1220303', '芜湖县', '安徽-芜湖-芜湖县', 1220303, '1220301', 1, NULL, '2018-03-30 12:00:00', 1, 4020, 4021);
INSERT INTO `base_region` VALUES ('1220304', '南陵', '安徽-芜湖-南陵', 1220304, '1220301', 1, NULL, '2018-03-30 12:00:00', 1, 4022, 4023);
INSERT INTO `base_region` VALUES ('1220305', '无为', '安徽-芜湖-无为', 1220305, '1220301', 1, NULL, '2018-03-30 12:00:00', 1, 4024, 4025);
INSERT INTO `base_region` VALUES ('1220306', '镜湖', '安徽-芜湖-镜湖', 1220306, '1220301', 1, NULL, '2018-03-30 12:00:00', 1, 4026, 4027);
INSERT INTO `base_region` VALUES ('1220307', '弋江', '安徽-芜湖-弋江', 1220307, '1220301', 1, NULL, '2018-03-30 12:00:00', 1, 4028, 4029);
INSERT INTO `base_region` VALUES ('1220308', '鸠江', '安徽-芜湖-鸠江', 1220308, '1220301', 1, NULL, '2018-03-30 12:00:00', 1, 4030, 4031);
INSERT INTO `base_region` VALUES ('1220309', '三山', '安徽-芜湖-三山', 1220309, '1220301', 1, NULL, '2018-03-30 12:00:00', 1, 4032, 4033);
INSERT INTO `base_region` VALUES ('1220401', '淮南', '安徽-淮南', 1220401, '1220000', 0, NULL, '2018-03-30 12:00:00', 1, 4035, 4050);
INSERT INTO `base_region` VALUES ('1220402', '凤台', '安徽-淮南-凤台', 1220402, '1220401', 1, NULL, '2018-03-30 12:00:00', 1, 4036, 4037);
INSERT INTO `base_region` VALUES ('1220403', '潘集', '安徽-淮南-潘集', 1220403, '1220401', 1, NULL, '2018-03-30 12:00:00', 1, 4038, 4039);
INSERT INTO `base_region` VALUES ('1220404', '大通', '安徽-淮南-大通', 1220404, '1220401', 1, NULL, '2018-03-30 12:00:00', 1, 4040, 4041);
INSERT INTO `base_region` VALUES ('1220405', '田家庵', '安徽-淮南-田家庵', 1220405, '1220401', 1, NULL, '2018-03-30 12:00:00', 1, 4042, 4043);
INSERT INTO `base_region` VALUES ('1220406', '谢家集', '安徽-淮南-谢家集', 1220406, '1220401', 1, NULL, '2018-03-30 12:00:00', 1, 4044, 4045);
INSERT INTO `base_region` VALUES ('1220407', '八公山', '安徽-淮南-八公山', 1220407, '1220401', 1, NULL, '2018-03-30 12:00:00', 1, 4046, 4047);
INSERT INTO `base_region` VALUES ('1220408', '寿县', '安徽-淮南-寿县', 1220408, '1220401', 1, NULL, '2018-03-30 12:00:00', 1, 4048, 4049);
INSERT INTO `base_region` VALUES ('1220501', '马鞍山', '安徽-马鞍山', 1220501, '1220000', 0, NULL, '2018-03-30 12:00:00', 1, 4051, 4064);
INSERT INTO `base_region` VALUES ('1220502', '当涂', '安徽-马鞍山-当涂', 1220502, '1220501', 1, NULL, '2018-03-30 12:00:00', 1, 4052, 4053);
INSERT INTO `base_region` VALUES ('1220503', '含山', '安徽-马鞍山-含山', 1220503, '1220501', 1, NULL, '2018-03-30 12:00:00', 1, 4054, 4055);
INSERT INTO `base_region` VALUES ('1220504', '和县', '安徽-马鞍山-和县', 1220504, '1220501', 1, NULL, '2018-03-30 12:00:00', 1, 4056, 4057);
INSERT INTO `base_region` VALUES ('1220505', '花山', '安徽-马鞍山-花山', 1220505, '1220501', 1, NULL, '2018-03-30 12:00:00', 1, 4058, 4059);
INSERT INTO `base_region` VALUES ('1220506', '雨山', '安徽-马鞍山-雨山', 1220506, '1220501', 1, NULL, '2018-03-30 12:00:00', 1, 4060, 4061);
INSERT INTO `base_region` VALUES ('1220507', '博望', '安徽-马鞍山-博望', 1220507, '1220501', 1, NULL, '2018-03-30 12:00:00', 1, 4062, 4063);
INSERT INTO `base_region` VALUES ('1220601', '安庆', '安徽-安庆', 1220601, '1220000', 0, NULL, '2018-03-30 12:00:00', 1, 4065, 4086);
INSERT INTO `base_region` VALUES ('1220603', '太湖', '安徽-安庆-太湖', 1220603, '1220601', 1, NULL, '2018-03-30 12:00:00', 1, 4066, 4067);
INSERT INTO `base_region` VALUES ('1220604', '潜山', '安徽-安庆-潜山', 1220604, '1220601', 1, NULL, '2018-03-30 12:00:00', 1, 4068, 4069);
INSERT INTO `base_region` VALUES ('1220605', '怀宁', '安徽-安庆-怀宁', 1220605, '1220601', 1, NULL, '2018-03-30 12:00:00', 1, 4070, 4071);
INSERT INTO `base_region` VALUES ('1220606', '宿松', '安徽-安庆-宿松', 1220606, '1220601', 1, NULL, '2018-03-30 12:00:00', 1, 4072, 4073);
INSERT INTO `base_region` VALUES ('1220607', '望江', '安徽-安庆-望江', 1220607, '1220601', 1, NULL, '2018-03-30 12:00:00', 1, 4074, 4075);
INSERT INTO `base_region` VALUES ('1220608', '岳西', '安徽-安庆-岳西', 1220608, '1220601', 1, NULL, '2018-03-30 12:00:00', 1, 4076, 4077);
INSERT INTO `base_region` VALUES ('1220609', '桐城', '安徽-安庆-桐城', 1220609, '1220601', 1, NULL, '2018-03-30 12:00:00', 1, 4078, 4079);
INSERT INTO `base_region` VALUES ('1220610', '迎江', '安徽-安庆-迎江', 1220610, '1220601', 1, NULL, '2018-03-30 12:00:00', 1, 4080, 4081);
INSERT INTO `base_region` VALUES ('1220611', '大观', '安徽-安庆-大观', 1220611, '1220601', 1, NULL, '2018-03-30 12:00:00', 1, 4082, 4083);
INSERT INTO `base_region` VALUES ('1220612', '宜秀', '安徽-安庆-宜秀', 1220612, '1220601', 1, NULL, '2018-03-30 12:00:00', 1, 4084, 4085);
INSERT INTO `base_region` VALUES ('1220701', '宿州', '安徽-宿州', 1220701, '1220000', 0, NULL, '2018-03-30 12:00:00', 1, 4087, 4098);
INSERT INTO `base_region` VALUES ('1220702', '砀山', '安徽-宿州-砀山', 1220702, '1220701', 1, NULL, '2018-03-30 12:00:00', 1, 4088, 4089);
INSERT INTO `base_region` VALUES ('1220703', '灵璧', '安徽-宿州-灵璧', 1220703, '1220701', 1, NULL, '2018-03-30 12:00:00', 1, 4090, 4091);
INSERT INTO `base_region` VALUES ('1220704', '泗县', '安徽-宿州-泗县', 1220704, '1220701', 1, NULL, '2018-03-30 12:00:00', 1, 4092, 4093);
INSERT INTO `base_region` VALUES ('1220705', '萧县', '安徽-宿州-萧县', 1220705, '1220701', 1, NULL, '2018-03-30 12:00:00', 1, 4094, 4095);
INSERT INTO `base_region` VALUES ('1220706', '埇桥', '安徽-宿州-埇桥', 1220706, '1220701', 1, NULL, '2018-03-30 12:00:00', 1, 4096, 4097);
INSERT INTO `base_region` VALUES ('1220801', '阜阳', '安徽-阜阳', 1220801, '1220000', 0, NULL, '2018-03-30 12:00:00', 1, 4099, 4116);
INSERT INTO `base_region` VALUES ('1220802', '阜南', '安徽-阜阳-阜南', 1220802, '1220801', 1, NULL, '2018-03-30 12:00:00', 1, 4100, 4101);
INSERT INTO `base_region` VALUES ('1220803', '颍上', '安徽-阜阳-颍上', 1220803, '1220801', 1, NULL, '2018-03-30 12:00:00', 1, 4102, 4103);
INSERT INTO `base_region` VALUES ('1220804', '临泉', '安徽-阜阳-临泉', 1220804, '1220801', 1, NULL, '2018-03-30 12:00:00', 1, 4104, 4105);
INSERT INTO `base_region` VALUES ('1220805', '界首', '安徽-阜阳-界首', 1220805, '1220801', 1, NULL, '2018-03-30 12:00:00', 1, 4106, 4107);
INSERT INTO `base_region` VALUES ('1220806', '太和', '安徽-阜阳-太和', 1220806, '1220801', 1, NULL, '2018-03-30 12:00:00', 1, 4108, 4109);
INSERT INTO `base_region` VALUES ('1220807', '颍州', '安徽-阜阳-颍州', 1220807, '1220801', 1, NULL, '2018-03-30 12:00:00', 1, 4110, 4111);
INSERT INTO `base_region` VALUES ('1220808', '颍东', '安徽-阜阳-颍东', 1220808, '1220801', 1, NULL, '2018-03-30 12:00:00', 1, 4112, 4113);
INSERT INTO `base_region` VALUES ('1220809', '颍泉', '安徽-阜阳-颍泉', 1220809, '1220801', 1, NULL, '2018-03-30 12:00:00', 1, 4114, 4115);
INSERT INTO `base_region` VALUES ('1220901', '亳州', '安徽-亳州', 1220901, '1220000', 0, NULL, '2018-03-30 12:00:00', 1, 4117, 4126);
INSERT INTO `base_region` VALUES ('1220902', '涡阳', '安徽-亳州-涡阳', 1220902, '1220901', 1, NULL, '2018-03-30 12:00:00', 1, 4118, 4119);
INSERT INTO `base_region` VALUES ('1220903', '利辛', '安徽-亳州-利辛', 1220903, '1220901', 1, NULL, '2018-03-30 12:00:00', 1, 4120, 4121);
INSERT INTO `base_region` VALUES ('1220904', '蒙城', '安徽-亳州-蒙城', 1220904, '1220901', 1, NULL, '2018-03-30 12:00:00', 1, 4122, 4123);
INSERT INTO `base_region` VALUES ('1220905', '谯城', '安徽-亳州-谯城', 1220905, '1220901', 1, NULL, '2018-03-30 12:00:00', 1, 4124, 4125);
INSERT INTO `base_region` VALUES ('1221001', '黄山', '安徽-黄山', 1221001, '1220000', 0, NULL, '2018-03-30 12:00:00', 1, 4127, 4142);
INSERT INTO `base_region` VALUES ('1221002', '黄山区', '安徽-黄山-黄山区', 1221002, '1221001', 1, NULL, '2018-03-30 12:00:00', 1, 4128, 4129);
INSERT INTO `base_region` VALUES ('1221003', '屯溪', '安徽-黄山-屯溪', 1221003, '1221001', 1, NULL, '2018-03-30 12:00:00', 1, 4130, 4131);
INSERT INTO `base_region` VALUES ('1221004', '祁门', '安徽-黄山-祁门', 1221004, '1221001', 1, NULL, '2018-03-30 12:00:00', 1, 4132, 4133);
INSERT INTO `base_region` VALUES ('1221005', '黟县', '安徽-黄山-黟县', 1221005, '1221001', 1, NULL, '2018-03-30 12:00:00', 1, 4134, 4135);
INSERT INTO `base_region` VALUES ('1221006', '歙县', '安徽-黄山-歙县', 1221006, '1221001', 1, NULL, '2018-03-30 12:00:00', 1, 4136, 4137);
INSERT INTO `base_region` VALUES ('1221007', '休宁', '安徽-黄山-休宁', 1221007, '1221001', 1, NULL, '2018-03-30 12:00:00', 1, 4138, 4139);
INSERT INTO `base_region` VALUES ('1221009', '徽州', '安徽-黄山-徽州', 1221009, '1221001', 1, NULL, '2018-03-30 12:00:00', 1, 4140, 4141);
INSERT INTO `base_region` VALUES ('1221101', '滁州', '安徽-滁州', 1221101, '1220000', 0, NULL, '2018-03-30 12:00:00', 1, 4143, 4160);
INSERT INTO `base_region` VALUES ('1221102', '凤阳', '安徽-滁州-凤阳', 1221102, '1221101', 1, NULL, '2018-03-30 12:00:00', 1, 4144, 4145);
INSERT INTO `base_region` VALUES ('1221103', '明光', '安徽-滁州-明光', 1221103, '1221101', 1, NULL, '2018-03-30 12:00:00', 1, 4146, 4147);
INSERT INTO `base_region` VALUES ('1221104', '定远', '安徽-滁州-定远', 1221104, '1221101', 1, NULL, '2018-03-30 12:00:00', 1, 4148, 4149);
INSERT INTO `base_region` VALUES ('1221105', '全椒', '安徽-滁州-全椒', 1221105, '1221101', 1, NULL, '2018-03-30 12:00:00', 1, 4150, 4151);
INSERT INTO `base_region` VALUES ('1221106', '来安', '安徽-滁州-来安', 1221106, '1221101', 1, NULL, '2018-03-30 12:00:00', 1, 4152, 4153);
INSERT INTO `base_region` VALUES ('1221107', '天长', '安徽-滁州-天长', 1221107, '1221101', 1, NULL, '2018-03-30 12:00:00', 1, 4154, 4155);
INSERT INTO `base_region` VALUES ('1221108', '琅琊', '安徽-滁州-琅琊', 1221108, '1221101', 1, NULL, '2018-03-30 12:00:00', 1, 4156, 4157);
INSERT INTO `base_region` VALUES ('1221109', '南谯', '安徽-滁州-南谯', 1221109, '1221101', 1, NULL, '2018-03-30 12:00:00', 1, 4158, 4159);
INSERT INTO `base_region` VALUES ('1221201', '淮北', '安徽-淮北', 1221201, '1220000', 0, NULL, '2018-03-30 12:00:00', 1, 4161, 4170);
INSERT INTO `base_region` VALUES ('1221202', '濉溪', '安徽-淮北-濉溪', 1221202, '1221201', 1, NULL, '2018-03-30 12:00:00', 1, 4162, 4163);
INSERT INTO `base_region` VALUES ('1221203', '杜集', '安徽-淮北-杜集', 1221203, '1221201', 1, NULL, '2018-03-30 12:00:00', 1, 4164, 4165);
INSERT INTO `base_region` VALUES ('1221204', '相山', '安徽-淮北-相山', 1221204, '1221201', 1, NULL, '2018-03-30 12:00:00', 1, 4166, 4167);
INSERT INTO `base_region` VALUES ('1221205', '烈山', '安徽-淮北-烈山', 1221205, '1221201', 1, NULL, '2018-03-30 12:00:00', 1, 4168, 4169);
INSERT INTO `base_region` VALUES ('1221301', '铜陵', '安徽-铜陵', 1221301, '1220000', 0, NULL, '2018-03-30 12:00:00', 1, 4171, 4180);
INSERT INTO `base_region` VALUES ('1221302', '铜官', '安徽-铜陵-铜官', 1221302, '1221301', 1, NULL, '2018-03-30 12:00:00', 1, 4172, 4173);
INSERT INTO `base_region` VALUES ('1221303', '义安', '安徽-铜陵-义安', 1221303, '1221301', 1, NULL, '2018-03-30 12:00:00', 1, 4174, 4175);
INSERT INTO `base_region` VALUES ('1221304', '郊区', '安徽-铜陵-郊区', 1221304, '1221301', 1, NULL, '2018-03-30 12:00:00', 1, 4176, 4177);
INSERT INTO `base_region` VALUES ('1221305', '枞阳', '安徽-铜陵-枞阳', 1221305, '1221301', 1, NULL, '2018-03-30 12:00:00', 1, 4178, 4179);
INSERT INTO `base_region` VALUES ('1221401', '宣城', '安徽-宣城', 1221401, '1220000', 0, NULL, '2018-03-30 12:00:00', 1, 4181, 4196);
INSERT INTO `base_region` VALUES ('1221402', '泾县', '安徽-宣城-泾县', 1221402, '1221401', 1, NULL, '2018-03-30 12:00:00', 1, 4182, 4183);
INSERT INTO `base_region` VALUES ('1221403', '旌德', '安徽-宣城-旌德', 1221403, '1221401', 1, NULL, '2018-03-30 12:00:00', 1, 4184, 4185);
INSERT INTO `base_region` VALUES ('1221404', '宁国', '安徽-宣城-宁国', 1221404, '1221401', 1, NULL, '2018-03-30 12:00:00', 1, 4186, 4187);
INSERT INTO `base_region` VALUES ('1221405', '绩溪', '安徽-宣城-绩溪', 1221405, '1221401', 1, NULL, '2018-03-30 12:00:00', 1, 4188, 4189);
INSERT INTO `base_region` VALUES ('1221406', '广德', '安徽-宣城-广德', 1221406, '1221401', 1, NULL, '2018-03-30 12:00:00', 1, 4190, 4191);
INSERT INTO `base_region` VALUES ('1221407', '郎溪', '安徽-宣城-郎溪', 1221407, '1221401', 1, NULL, '2018-03-30 12:00:00', 1, 4192, 4193);
INSERT INTO `base_region` VALUES ('1221408', '宣州', '安徽-宣城-宣州', 1221408, '1221401', 1, NULL, '2018-03-30 12:00:00', 1, 4194, 4195);
INSERT INTO `base_region` VALUES ('1221501', '六安', '安徽-六安', 1221501, '1220000', 0, NULL, '2018-03-30 12:00:00', 1, 4197, 4212);
INSERT INTO `base_region` VALUES ('1221502', '霍邱', '安徽-六安-霍邱', 1221502, '1221501', 1, NULL, '2018-03-30 12:00:00', 1, 4198, 4199);
INSERT INTO `base_region` VALUES ('1221504', '金安', '安徽-六安-金安', 1221504, '1221501', 1, NULL, '2018-03-30 12:00:00', 1, 4200, 4201);
INSERT INTO `base_region` VALUES ('1221505', '金寨', '安徽-六安-金寨', 1221505, '1221501', 1, NULL, '2018-03-30 12:00:00', 1, 4202, 4203);
INSERT INTO `base_region` VALUES ('1221506', '霍山', '安徽-六安-霍山', 1221506, '1221501', 1, NULL, '2018-03-30 12:00:00', 1, 4204, 4205);
INSERT INTO `base_region` VALUES ('1221507', '舒城', '安徽-六安-舒城', 1221507, '1221501', 1, NULL, '2018-03-30 12:00:00', 1, 4206, 4207);
INSERT INTO `base_region` VALUES ('1221508', '裕安', '安徽-六安-裕安', 1221508, '1221501', 1, NULL, '2018-03-30 12:00:00', 1, 4208, 4209);
INSERT INTO `base_region` VALUES ('1221509', '叶集', '安徽-六安-叶集', 1221509, '1221501', 1, NULL, '2018-03-30 12:00:00', 1, 4210, 4211);
INSERT INTO `base_region` VALUES ('1221701', '池州', '安徽-池州', 1221701, '1220000', 0, NULL, '2018-03-30 12:00:00', 1, 4213, 4224);
INSERT INTO `base_region` VALUES ('1221702', '东至', '安徽-池州-东至', 1221702, '1221701', 1, NULL, '2018-03-30 12:00:00', 1, 4214, 4215);
INSERT INTO `base_region` VALUES ('1221703', '青阳', '安徽-池州-青阳', 1221703, '1221701', 1, NULL, '2018-03-30 12:00:00', 1, 4216, 4217);
INSERT INTO `base_region` VALUES ('1221704', '九华山', '安徽-池州-九华山', 1221704, '1221701', 1, NULL, '2018-03-30 12:00:00', 1, 4218, 4219);
INSERT INTO `base_region` VALUES ('1221705', '石台', '安徽-池州-石台', 1221705, '1221701', 1, NULL, '2018-03-30 12:00:00', 1, 4220, 4221);
INSERT INTO `base_region` VALUES ('1221706', '贵池', '安徽-池州-贵池', 1221706, '1221701', 1, NULL, '2018-03-30 12:00:00', 1, 4222, 4223);
INSERT INTO `base_region` VALUES ('1230000', '福建', '福建', 1230000, 'ROOT', 0, NULL, '2018-03-30 12:00:00', 1, 4226, 4417);
INSERT INTO `base_region` VALUES ('1230101', '福州', '福建-福州', 1230101, '1230000', 0, NULL, '2018-03-30 12:00:00', 1, 4227, 4254);
INSERT INTO `base_region` VALUES ('1230102', '闽清', '福建-福州-闽清', 1230102, '1230101', 1, NULL, '2018-03-30 12:00:00', 1, 4228, 4229);
INSERT INTO `base_region` VALUES ('1230103', '闽侯', '福建-福州-闽侯', 1230103, '1230101', 1, NULL, '2018-03-30 12:00:00', 1, 4230, 4231);
INSERT INTO `base_region` VALUES ('1230104', '罗源', '福建-福州-罗源', 1230104, '1230101', 1, NULL, '2018-03-30 12:00:00', 1, 4232, 4233);
INSERT INTO `base_region` VALUES ('1230105', '连江', '福建-福州-连江', 1230105, '1230101', 1, NULL, '2018-03-30 12:00:00', 1, 4234, 4235);
INSERT INTO `base_region` VALUES ('1230106', '鼓楼', '福建-福州-鼓楼', 1230106, '1230101', 1, NULL, '2018-03-30 12:00:00', 1, 4236, 4237);
INSERT INTO `base_region` VALUES ('1230107', '永泰', '福建-福州-永泰', 1230107, '1230101', 1, NULL, '2018-03-30 12:00:00', 1, 4238, 4239);
INSERT INTO `base_region` VALUES ('1230108', '平潭', '福建-福州-平潭', 1230108, '1230101', 1, NULL, '2018-03-30 12:00:00', 1, 4240, 4241);
INSERT INTO `base_region` VALUES ('1230109', '台江', '福建-福州-台江', 1230109, '1230101', 1, NULL, '2018-03-30 12:00:00', 1, 4242, 4243);
INSERT INTO `base_region` VALUES ('1230110', '长乐', '福建-福州-长乐', 1230110, '1230101', 1, NULL, '2018-03-30 12:00:00', 1, 4244, 4245);
INSERT INTO `base_region` VALUES ('1230111', '福清', '福建-福州-福清', 1230111, '1230101', 1, NULL, '2018-03-30 12:00:00', 1, 4246, 4247);
INSERT INTO `base_region` VALUES ('1230112', '仓山', '福建-福州-仓山', 1230112, '1230101', 1, NULL, '2018-03-30 12:00:00', 1, 4248, 4249);
INSERT INTO `base_region` VALUES ('1230113', '马尾', '福建-福州-马尾', 1230113, '1230101', 1, NULL, '2018-03-30 12:00:00', 1, 4250, 4251);
INSERT INTO `base_region` VALUES ('1230114', '晋安', '福建-福州-晋安', 1230114, '1230101', 1, NULL, '2018-03-30 12:00:00', 1, 4252, 4253);
INSERT INTO `base_region` VALUES ('1230201', '厦门', '福建-厦门', 1230201, '1230000', 0, NULL, '2018-03-30 12:00:00', 1, 4255, 4268);
INSERT INTO `base_region` VALUES ('1230202', '同安', '福建-厦门-同安', 1230202, '1230201', 1, NULL, '2018-03-30 12:00:00', 1, 4256, 4257);
INSERT INTO `base_region` VALUES ('1230203', '思明', '福建-厦门-思明', 1230203, '1230201', 1, NULL, '2018-03-30 12:00:00', 1, 4258, 4259);
INSERT INTO `base_region` VALUES ('1230204', '海沧', '福建-厦门-海沧', 1230204, '1230201', 1, NULL, '2018-03-30 12:00:00', 1, 4260, 4261);
INSERT INTO `base_region` VALUES ('1230205', '湖里', '福建-厦门-湖里', 1230205, '1230201', 1, NULL, '2018-03-30 12:00:00', 1, 4262, 4263);
INSERT INTO `base_region` VALUES ('1230206', '集美', '福建-厦门-集美', 1230206, '1230201', 1, NULL, '2018-03-30 12:00:00', 1, 4264, 4265);
INSERT INTO `base_region` VALUES ('1230207', '翔安', '福建-厦门-翔安', 1230207, '1230201', 1, NULL, '2018-03-30 12:00:00', 1, 4266, 4267);
INSERT INTO `base_region` VALUES ('1230301', '宁德', '福建-宁德', 1230301, '1230000', 0, NULL, '2018-03-30 12:00:00', 1, 4269, 4288);
INSERT INTO `base_region` VALUES ('1230302', '古田', '福建-宁德-古田', 1230302, '1230301', 1, NULL, '2018-03-30 12:00:00', 1, 4270, 4271);
INSERT INTO `base_region` VALUES ('1230303', '霞浦', '福建-宁德-霞浦', 1230303, '1230301', 1, NULL, '2018-03-30 12:00:00', 1, 4272, 4273);
INSERT INTO `base_region` VALUES ('1230304', '寿宁', '福建-宁德-寿宁', 1230304, '1230301', 1, NULL, '2018-03-30 12:00:00', 1, 4274, 4275);
INSERT INTO `base_region` VALUES ('1230305', '周宁', '福建-宁德-周宁', 1230305, '1230301', 1, NULL, '2018-03-30 12:00:00', 1, 4276, 4277);
INSERT INTO `base_region` VALUES ('1230306', '福安', '福建-宁德-福安', 1230306, '1230301', 1, NULL, '2018-03-30 12:00:00', 1, 4278, 4279);
INSERT INTO `base_region` VALUES ('1230307', '柘荣', '福建-宁德-柘荣', 1230307, '1230301', 1, NULL, '2018-03-30 12:00:00', 1, 4280, 4281);
INSERT INTO `base_region` VALUES ('1230308', '福鼎', '福建-宁德-福鼎', 1230308, '1230301', 1, NULL, '2018-03-30 12:00:00', 1, 4282, 4283);
INSERT INTO `base_region` VALUES ('1230309', '屏南', '福建-宁德-屏南', 1230309, '1230301', 1, NULL, '2018-03-30 12:00:00', 1, 4284, 4285);
INSERT INTO `base_region` VALUES ('1230310', '蕉城', '福建-宁德-蕉城', 1230310, '1230301', 1, NULL, '2018-03-30 12:00:00', 1, 4286, 4287);
INSERT INTO `base_region` VALUES ('1230401', '莆田', '福建-莆田', 1230401, '1230000', 0, NULL, '2018-03-30 12:00:00', 1, 4289, 4300);
INSERT INTO `base_region` VALUES ('1230402', '仙游', '福建-莆田-仙游', 1230402, '1230401', 1, NULL, '2018-03-30 12:00:00', 1, 4290, 4291);
INSERT INTO `base_region` VALUES ('1230404', '涵江', '福建-莆田-涵江', 1230404, '1230401', 1, NULL, '2018-03-30 12:00:00', 1, 4292, 4293);
INSERT INTO `base_region` VALUES ('1230405', '秀屿', '福建-莆田-秀屿', 1230405, '1230401', 1, NULL, '2018-03-30 12:00:00', 1, 4294, 4295);
INSERT INTO `base_region` VALUES ('1230406', '荔城', '福建-莆田-荔城', 1230406, '1230401', 1, NULL, '2018-03-30 12:00:00', 1, 4296, 4297);
INSERT INTO `base_region` VALUES ('1230407', '城厢', '福建-莆田-城厢', 1230407, '1230401', 1, NULL, '2018-03-30 12:00:00', 1, 4298, 4299);
INSERT INTO `base_region` VALUES ('1230501', '泉州', '福建-泉州', 1230501, '1230000', 0, NULL, '2018-03-30 12:00:00', 1, 4301, 4326);
INSERT INTO `base_region` VALUES ('1230502', '安溪', '福建-泉州-安溪', 1230502, '1230501', 1, NULL, '2018-03-30 12:00:00', 1, 4302, 4303);
INSERT INTO `base_region` VALUES ('1230503', '金门', '福建-泉州-金门', 1230503, '1230501', 1, NULL, '2018-03-30 12:00:00', 1, 4304, 4305);
INSERT INTO `base_region` VALUES ('1230504', '永春', '福建-泉州-永春', 1230504, '1230501', 1, NULL, '2018-03-30 12:00:00', 1, 4306, 4307);
INSERT INTO `base_region` VALUES ('1230505', '德化', '福建-泉州-德化', 1230505, '1230501', 1, NULL, '2018-03-30 12:00:00', 1, 4308, 4309);
INSERT INTO `base_region` VALUES ('1230506', '南安', '福建-泉州-南安', 1230506, '1230501', 1, NULL, '2018-03-30 12:00:00', 1, 4310, 4311);
INSERT INTO `base_region` VALUES ('1230508', '惠安', '福建-泉州-惠安', 1230508, '1230501', 1, NULL, '2018-03-30 12:00:00', 1, 4312, 4313);
INSERT INTO `base_region` VALUES ('1230509', '晋江', '福建-泉州-晋江', 1230509, '1230501', 1, NULL, '2018-03-30 12:00:00', 1, 4314, 4315);
INSERT INTO `base_region` VALUES ('1230510', '石狮', '福建-泉州-石狮', 1230510, '1230501', 1, NULL, '2018-03-30 12:00:00', 1, 4316, 4317);
INSERT INTO `base_region` VALUES ('1230511', '鲤城', '福建-泉州-鲤城', 1230511, '1230501', 1, NULL, '2018-03-30 12:00:00', 1, 4318, 4319);
INSERT INTO `base_region` VALUES ('1230512', '丰泽', '福建-泉州-丰泽', 1230512, '1230501', 1, NULL, '2018-03-30 12:00:00', 1, 4320, 4321);
INSERT INTO `base_region` VALUES ('1230513', '洛江', '福建-泉州-洛江', 1230513, '1230501', 1, NULL, '2018-03-30 12:00:00', 1, 4322, 4323);
INSERT INTO `base_region` VALUES ('1230514', '泉港', '福建-泉州-泉港', 1230514, '1230501', 1, NULL, '2018-03-30 12:00:00', 1, 4324, 4325);
INSERT INTO `base_region` VALUES ('1230601', '漳州', '福建-漳州', 1230601, '1230000', 0, NULL, '2018-03-30 12:00:00', 1, 4327, 4350);
INSERT INTO `base_region` VALUES ('1230602', '长泰', '福建-漳州-长泰', 1230602, '1230601', 1, NULL, '2018-03-30 12:00:00', 1, 4328, 4329);
INSERT INTO `base_region` VALUES ('1230603', '南靖', '福建-漳州-南靖', 1230603, '1230601', 1, NULL, '2018-03-30 12:00:00', 1, 4330, 4331);
INSERT INTO `base_region` VALUES ('1230604', '平和', '福建-漳州-平和', 1230604, '1230601', 1, NULL, '2018-03-30 12:00:00', 1, 4332, 4333);
INSERT INTO `base_region` VALUES ('1230605', '龙海', '福建-漳州-龙海', 1230605, '1230601', 1, NULL, '2018-03-30 12:00:00', 1, 4334, 4335);
INSERT INTO `base_region` VALUES ('1230606', '漳浦', '福建-漳州-漳浦', 1230606, '1230601', 1, NULL, '2018-03-30 12:00:00', 1, 4336, 4337);
INSERT INTO `base_region` VALUES ('1230607', '诏安', '福建-漳州-诏安', 1230607, '1230601', 1, NULL, '2018-03-30 12:00:00', 1, 4338, 4339);
INSERT INTO `base_region` VALUES ('1230608', '东山', '福建-漳州-东山', 1230608, '1230601', 1, NULL, '2018-03-30 12:00:00', 1, 4340, 4341);
INSERT INTO `base_region` VALUES ('1230609', '云霄', '福建-漳州-云霄', 1230609, '1230601', 1, NULL, '2018-03-30 12:00:00', 1, 4342, 4343);
INSERT INTO `base_region` VALUES ('1230610', '华安', '福建-漳州-华安', 1230610, '1230601', 1, NULL, '2018-03-30 12:00:00', 1, 4344, 4345);
INSERT INTO `base_region` VALUES ('1230611', '芗城', '福建-漳州-芗城', 1230611, '1230601', 1, NULL, '2018-03-30 12:00:00', 1, 4346, 4347);
INSERT INTO `base_region` VALUES ('1230612', '龙文', '福建-漳州-龙文', 1230612, '1230601', 1, NULL, '2018-03-30 12:00:00', 1, 4348, 4349);
INSERT INTO `base_region` VALUES ('1230701', '龙岩', '福建-龙岩', 1230701, '1230000', 0, NULL, '2018-03-30 12:00:00', 1, 4351, 4366);
INSERT INTO `base_region` VALUES ('1230702', '长汀', '福建-龙岩-长汀', 1230702, '1230701', 1, NULL, '2018-03-30 12:00:00', 1, 4352, 4353);
INSERT INTO `base_region` VALUES ('1230703', '连城', '福建-龙岩-连城', 1230703, '1230701', 1, NULL, '2018-03-30 12:00:00', 1, 4354, 4355);
INSERT INTO `base_region` VALUES ('1230704', '武平', '福建-龙岩-武平', 1230704, '1230701', 1, NULL, '2018-03-30 12:00:00', 1, 4356, 4357);
INSERT INTO `base_region` VALUES ('1230705', '上杭', '福建-龙岩-上杭', 1230705, '1230701', 1, NULL, '2018-03-30 12:00:00', 1, 4358, 4359);
INSERT INTO `base_region` VALUES ('1230706', '永定', '福建-龙岩-永定', 1230706, '1230701', 1, NULL, '2018-03-30 12:00:00', 1, 4360, 4361);
INSERT INTO `base_region` VALUES ('1230707', '漳平', '福建-龙岩-漳平', 1230707, '1230701', 1, NULL, '2018-03-30 12:00:00', 1, 4362, 4363);
INSERT INTO `base_region` VALUES ('1230708', '新罗', '福建-龙岩-新罗', 1230708, '1230701', 1, NULL, '2018-03-30 12:00:00', 1, 4364, 4365);
INSERT INTO `base_region` VALUES ('1230801', '三明', '福建-三明', 1230801, '1230000', 0, NULL, '2018-03-30 12:00:00', 1, 4367, 4392);
INSERT INTO `base_region` VALUES ('1230802', '宁化', '福建-三明-宁化', 1230802, '1230801', 1, NULL, '2018-03-30 12:00:00', 1, 4368, 4369);
INSERT INTO `base_region` VALUES ('1230803', '清流', '福建-三明-清流', 1230803, '1230801', 1, NULL, '2018-03-30 12:00:00', 1, 4370, 4371);
INSERT INTO `base_region` VALUES ('1230804', '泰宁', '福建-三明-泰宁', 1230804, '1230801', 1, NULL, '2018-03-30 12:00:00', 1, 4372, 4373);
INSERT INTO `base_region` VALUES ('1230805', '将乐', '福建-三明-将乐', 1230805, '1230801', 1, NULL, '2018-03-30 12:00:00', 1, 4374, 4375);
INSERT INTO `base_region` VALUES ('1230806', '建宁', '福建-三明-建宁', 1230806, '1230801', 1, NULL, '2018-03-30 12:00:00', 1, 4376, 4377);
INSERT INTO `base_region` VALUES ('1230807', '明溪', '福建-三明-明溪', 1230807, '1230801', 1, NULL, '2018-03-30 12:00:00', 1, 4378, 4379);
INSERT INTO `base_region` VALUES ('1230808', '沙县', '福建-三明-沙县', 1230808, '1230801', 1, NULL, '2018-03-30 12:00:00', 1, 4380, 4381);
INSERT INTO `base_region` VALUES ('1230809', '尤溪', '福建-三明-尤溪', 1230809, '1230801', 1, NULL, '2018-03-30 12:00:00', 1, 4382, 4383);
INSERT INTO `base_region` VALUES ('1230810', '永安', '福建-三明-永安', 1230810, '1230801', 1, NULL, '2018-03-30 12:00:00', 1, 4384, 4385);
INSERT INTO `base_region` VALUES ('1230811', '大田', '福建-三明-大田', 1230811, '1230801', 1, NULL, '2018-03-30 12:00:00', 1, 4386, 4387);
INSERT INTO `base_region` VALUES ('1230812', '梅列', '福建-三明-梅列', 1230812, '1230801', 1, NULL, '2018-03-30 12:00:00', 1, 4388, 4389);
INSERT INTO `base_region` VALUES ('1230813', '三元', '福建-三明-三元', 1230813, '1230801', 1, NULL, '2018-03-30 12:00:00', 1, 4390, 4391);
INSERT INTO `base_region` VALUES ('1230901', '南平', '福建-南平', 1230901, '1230000', 0, NULL, '2018-03-30 12:00:00', 1, 4393, 4414);
INSERT INTO `base_region` VALUES ('1230902', '顺昌', '福建-南平-顺昌', 1230902, '1230901', 1, NULL, '2018-03-30 12:00:00', 1, 4394, 4395);
INSERT INTO `base_region` VALUES ('1230903', '光泽', '福建-南平-光泽', 1230903, '1230901', 1, NULL, '2018-03-30 12:00:00', 1, 4396, 4397);
INSERT INTO `base_region` VALUES ('1230904', '邵武', '福建-南平-邵武', 1230904, '1230901', 1, NULL, '2018-03-30 12:00:00', 1, 4398, 4399);
INSERT INTO `base_region` VALUES ('1230905', '武夷山', '福建-南平-武夷山', 1230905, '1230901', 1, NULL, '2018-03-30 12:00:00', 1, 4400, 4401);
INSERT INTO `base_region` VALUES ('1230906', '浦城', '福建-南平-浦城', 1230906, '1230901', 1, NULL, '2018-03-30 12:00:00', 1, 4402, 4403);
INSERT INTO `base_region` VALUES ('1230907', '建阳', '福建-南平-建阳', 1230907, '1230901', 1, NULL, '2018-03-30 12:00:00', 1, 4404, 4405);
INSERT INTO `base_region` VALUES ('1230908', '松溪', '福建-南平-松溪', 1230908, '1230901', 1, NULL, '2018-03-30 12:00:00', 1, 4406, 4407);
INSERT INTO `base_region` VALUES ('1230909', '政和', '福建-南平-政和', 1230909, '1230901', 1, NULL, '2018-03-30 12:00:00', 1, 4408, 4409);
INSERT INTO `base_region` VALUES ('1230910', '建瓯', '福建-南平-建瓯', 1230910, '1230901', 1, NULL, '2018-03-30 12:00:00', 1, 4410, 4411);
INSERT INTO `base_region` VALUES ('1230911', '延平', '福建-南平-延平', 1230911, '1230901', 1, NULL, '2018-03-30 12:00:00', 1, 4412, 4413);
INSERT INTO `base_region` VALUES ('1231001', '钓鱼岛', '福建-钓鱼岛', 1231001, '1230000', 0, NULL, '2018-03-30 12:00:00', 1, 4415, 4416);
INSERT INTO `base_region` VALUES ('1240000', '江西', '江西', 1240000, 'ROOT', 0, NULL, '2018-03-30 12:00:00', 1, 4418, 4639);
INSERT INTO `base_region` VALUES ('1240101', '南昌', '江西-南昌', 1240101, '1240000', 0, NULL, '2018-03-30 12:00:00', 1, 4419, 4438);
INSERT INTO `base_region` VALUES ('1240102', '新建', '江西-南昌-新建', 1240102, '1240101', 1, NULL, '2018-03-30 12:00:00', 1, 4420, 4421);
INSERT INTO `base_region` VALUES ('1240103', '南昌县', '江西-南昌-南昌县', 1240103, '1240101', 1, NULL, '2018-03-30 12:00:00', 1, 4422, 4423);
INSERT INTO `base_region` VALUES ('1240104', '安义', '江西-南昌-安义', 1240104, '1240101', 1, NULL, '2018-03-30 12:00:00', 1, 4424, 4425);
INSERT INTO `base_region` VALUES ('1240105', '进贤', '江西-南昌-进贤', 1240105, '1240101', 1, NULL, '2018-03-30 12:00:00', 1, 4426, 4427);
INSERT INTO `base_region` VALUES ('1240106', '东湖', '江西-南昌-东湖', 1240106, '1240101', 1, NULL, '2018-03-30 12:00:00', 1, 4428, 4429);
INSERT INTO `base_region` VALUES ('1240107', '西湖', '江西-南昌-西湖', 1240107, '1240101', 1, NULL, '2018-03-30 12:00:00', 1, 4430, 4431);
INSERT INTO `base_region` VALUES ('1240108', '青云谱', '江西-南昌-青云谱', 1240108, '1240101', 1, NULL, '2018-03-30 12:00:00', 1, 4432, 4433);
INSERT INTO `base_region` VALUES ('1240109', '湾里', '江西-南昌-湾里', 1240109, '1240101', 1, NULL, '2018-03-30 12:00:00', 1, 4434, 4435);
INSERT INTO `base_region` VALUES ('1240110', '青山湖', '江西-南昌-青山湖', 1240110, '1240101', 1, NULL, '2018-03-30 12:00:00', 1, 4436, 4437);
INSERT INTO `base_region` VALUES ('1240201', '九江', '江西-九江', 1240201, '1240000', 0, NULL, '2018-03-30 12:00:00', 1, 4439, 4464);
INSERT INTO `base_region` VALUES ('1240202', '瑞昌', '江西-九江-瑞昌', 1240202, '1240201', 1, NULL, '2018-03-30 12:00:00', 1, 4440, 4441);
INSERT INTO `base_region` VALUES ('1240203', '庐山', '江西-九江-庐山', 1240203, '1240201', 1, NULL, '2018-03-30 12:00:00', 1, 4442, 4443);
INSERT INTO `base_region` VALUES ('1240204', '武宁', '江西-九江-武宁', 1240204, '1240201', 1, NULL, '2018-03-30 12:00:00', 1, 4444, 4445);
INSERT INTO `base_region` VALUES ('1240205', '德安', '江西-九江-德安', 1240205, '1240201', 1, NULL, '2018-03-30 12:00:00', 1, 4446, 4447);
INSERT INTO `base_region` VALUES ('1240206', '永修', '江西-九江-永修', 1240206, '1240201', 1, NULL, '2018-03-30 12:00:00', 1, 4448, 4449);
INSERT INTO `base_region` VALUES ('1240207', '湖口', '江西-九江-湖口', 1240207, '1240201', 1, NULL, '2018-03-30 12:00:00', 1, 4450, 4451);
INSERT INTO `base_region` VALUES ('1240208', '彭泽', '江西-九江-彭泽', 1240208, '1240201', 1, NULL, '2018-03-30 12:00:00', 1, 4452, 4453);
INSERT INTO `base_region` VALUES ('1240209', '星子', '江西-九江-星子', 1240209, '1240201', 1, NULL, '2018-03-30 12:00:00', 1, 4454, 4455);
INSERT INTO `base_region` VALUES ('1240210', '都昌', '江西-九江-都昌', 1240210, '1240201', 1, NULL, '2018-03-30 12:00:00', 1, 4456, 4457);
INSERT INTO `base_region` VALUES ('1240211', '浔阳', '江西-九江-浔阳', 1240211, '1240201', 1, NULL, '2018-03-30 12:00:00', 1, 4458, 4459);
INSERT INTO `base_region` VALUES ('1240212', '修水', '江西-九江-修水', 1240212, '1240201', 1, NULL, '2018-03-30 12:00:00', 1, 4460, 4461);
INSERT INTO `base_region` VALUES ('1240213', '共青城', '江西-九江-共青城', 1240213, '1240201', 1, NULL, '2018-03-30 12:00:00', 1, 4462, 4463);
INSERT INTO `base_region` VALUES ('1240301', '上饶', '江西-上饶', 1240301, '1240000', 0, NULL, '2018-03-30 12:00:00', 1, 4465, 4490);
INSERT INTO `base_region` VALUES ('1240302', '鄱阳', '江西-上饶-鄱阳', 1240302, '1240301', 1, NULL, '2018-03-30 12:00:00', 1, 4466, 4467);
INSERT INTO `base_region` VALUES ('1240303', '婺源', '江西-上饶-婺源', 1240303, '1240301', 1, NULL, '2018-03-30 12:00:00', 1, 4468, 4469);
INSERT INTO `base_region` VALUES ('1240304', '信州', '江西-上饶-信州', 1240304, '1240301', 1, NULL, '2018-03-30 12:00:00', 1, 4470, 4471);
INSERT INTO `base_region` VALUES ('1240305', '余干', '江西-上饶-余干', 1240305, '1240301', 1, NULL, '2018-03-30 12:00:00', 1, 4472, 4473);
INSERT INTO `base_region` VALUES ('1240306', '万年', '江西-上饶-万年', 1240306, '1240301', 1, NULL, '2018-03-30 12:00:00', 1, 4474, 4475);
INSERT INTO `base_region` VALUES ('1240307', '德兴', '江西-上饶-德兴', 1240307, '1240301', 1, NULL, '2018-03-30 12:00:00', 1, 4476, 4477);
INSERT INTO `base_region` VALUES ('1240308', '上饶县', '江西-上饶-上饶县', 1240308, '1240301', 1, NULL, '2018-03-30 12:00:00', 1, 4478, 4479);
INSERT INTO `base_region` VALUES ('1240309', '弋阳', '江西-上饶-弋阳', 1240309, '1240301', 1, NULL, '2018-03-30 12:00:00', 1, 4480, 4481);
INSERT INTO `base_region` VALUES ('1240310', '横峰', '江西-上饶-横峰', 1240310, '1240301', 1, NULL, '2018-03-30 12:00:00', 1, 4482, 4483);
INSERT INTO `base_region` VALUES ('1240311', '铅山', '江西-上饶-铅山', 1240311, '1240301', 1, NULL, '2018-03-30 12:00:00', 1, 4484, 4485);
INSERT INTO `base_region` VALUES ('1240312', '玉山', '江西-上饶-玉山', 1240312, '1240301', 1, NULL, '2018-03-30 12:00:00', 1, 4486, 4487);
INSERT INTO `base_region` VALUES ('1240313', '广丰', '江西-上饶-广丰', 1240313, '1240301', 1, NULL, '2018-03-30 12:00:00', 1, 4488, 4489);
INSERT INTO `base_region` VALUES ('1240401', '抚州', '江西-抚州', 1240401, '1240000', 0, NULL, '2018-03-30 12:00:00', 1, 4491, 4514);
INSERT INTO `base_region` VALUES ('1240402', '广昌', '江西-抚州-广昌', 1240402, '1240401', 1, NULL, '2018-03-30 12:00:00', 1, 4492, 4493);
INSERT INTO `base_region` VALUES ('1240403', '乐安', '江西-抚州-乐安', 1240403, '1240401', 1, NULL, '2018-03-30 12:00:00', 1, 4494, 4495);
INSERT INTO `base_region` VALUES ('1240404', '崇仁', '江西-抚州-崇仁', 1240404, '1240401', 1, NULL, '2018-03-30 12:00:00', 1, 4496, 4497);
INSERT INTO `base_region` VALUES ('1240405', '金溪', '江西-抚州-金溪', 1240405, '1240401', 1, NULL, '2018-03-30 12:00:00', 1, 4498, 4499);
INSERT INTO `base_region` VALUES ('1240406', '资溪', '江西-抚州-资溪', 1240406, '1240401', 1, NULL, '2018-03-30 12:00:00', 1, 4500, 4501);
INSERT INTO `base_region` VALUES ('1240407', '宜黄', '江西-抚州-宜黄', 1240407, '1240401', 1, NULL, '2018-03-30 12:00:00', 1, 4502, 4503);
INSERT INTO `base_region` VALUES ('1240408', '南城', '江西-抚州-南城', 1240408, '1240401', 1, NULL, '2018-03-30 12:00:00', 1, 4504, 4505);
INSERT INTO `base_region` VALUES ('1240409', '南丰', '江西-抚州-南丰', 1240409, '1240401', 1, NULL, '2018-03-30 12:00:00', 1, 4506, 4507);
INSERT INTO `base_region` VALUES ('1240410', '黎川', '江西-抚州-黎川', 1240410, '1240401', 1, NULL, '2018-03-30 12:00:00', 1, 4508, 4509);
INSERT INTO `base_region` VALUES ('1240411', '东乡', '江西-抚州-东乡', 1240411, '1240401', 1, NULL, '2018-03-30 12:00:00', 1, 4510, 4511);
INSERT INTO `base_region` VALUES ('1240412', '临川', '江西-抚州-临川', 1240412, '1240401', 1, NULL, '2018-03-30 12:00:00', 1, 4512, 4513);
INSERT INTO `base_region` VALUES ('1240501', '宜春', '江西-宜春', 1240501, '1240000', 0, NULL, '2018-03-30 12:00:00', 1, 4515, 4536);
INSERT INTO `base_region` VALUES ('1240502', '铜鼓', '江西-宜春-铜鼓', 1240502, '1240501', 1, NULL, '2018-03-30 12:00:00', 1, 4516, 4517);
INSERT INTO `base_region` VALUES ('1240503', '宜丰', '江西-宜春-宜丰', 1240503, '1240501', 1, NULL, '2018-03-30 12:00:00', 1, 4518, 4519);
INSERT INTO `base_region` VALUES ('1240504', '万载', '江西-宜春-万载', 1240504, '1240501', 1, NULL, '2018-03-30 12:00:00', 1, 4520, 4521);
INSERT INTO `base_region` VALUES ('1240505', '上高', '江西-宜春-上高', 1240505, '1240501', 1, NULL, '2018-03-30 12:00:00', 1, 4522, 4523);
INSERT INTO `base_region` VALUES ('1240506', '靖安', '江西-宜春-靖安', 1240506, '1240501', 1, NULL, '2018-03-30 12:00:00', 1, 4524, 4525);
INSERT INTO `base_region` VALUES ('1240507', '奉新', '江西-宜春-奉新', 1240507, '1240501', 1, NULL, '2018-03-30 12:00:00', 1, 4526, 4527);
INSERT INTO `base_region` VALUES ('1240508', '高安', '江西-宜春-高安', 1240508, '1240501', 1, NULL, '2018-03-30 12:00:00', 1, 4528, 4529);
INSERT INTO `base_region` VALUES ('1240509', '樟树', '江西-宜春-樟树', 1240509, '1240501', 1, NULL, '2018-03-30 12:00:00', 1, 4530, 4531);
INSERT INTO `base_region` VALUES ('1240510', '丰城', '江西-宜春-丰城', 1240510, '1240501', 1, NULL, '2018-03-30 12:00:00', 1, 4532, 4533);
INSERT INTO `base_region` VALUES ('1240511', '袁州', '江西-宜春-袁州', 1240511, '1240501', 1, NULL, '2018-03-30 12:00:00', 1, 4534, 4535);
INSERT INTO `base_region` VALUES ('1240601', '吉安', '江西-吉安', 1240601, '1240000', 0, NULL, '2018-03-30 12:00:00', 1, 4537, 4564);
INSERT INTO `base_region` VALUES ('1240602', '吉安县', '江西-吉安-吉安县', 1240602, '1240601', 1, NULL, '2018-03-30 12:00:00', 1, 4538, 4539);
INSERT INTO `base_region` VALUES ('1240603', '吉水', '江西-吉安-吉水', 1240603, '1240601', 1, NULL, '2018-03-30 12:00:00', 1, 4540, 4541);
INSERT INTO `base_region` VALUES ('1240604', '新干', '江西-吉安-新干', 1240604, '1240601', 1, NULL, '2018-03-30 12:00:00', 1, 4542, 4543);
INSERT INTO `base_region` VALUES ('1240605', '峡江', '江西-吉安-峡江', 1240605, '1240601', 1, NULL, '2018-03-30 12:00:00', 1, 4544, 4545);
INSERT INTO `base_region` VALUES ('1240606', '永丰', '江西-吉安-永丰', 1240606, '1240601', 1, NULL, '2018-03-30 12:00:00', 1, 4546, 4547);
INSERT INTO `base_region` VALUES ('1240607', '永新', '江西-吉安-永新', 1240607, '1240601', 1, NULL, '2018-03-30 12:00:00', 1, 4548, 4549);
INSERT INTO `base_region` VALUES ('1240608', '井冈山', '江西-吉安-井冈山', 1240608, '1240601', 1, NULL, '2018-03-30 12:00:00', 1, 4550, 4551);
INSERT INTO `base_region` VALUES ('1240609', '万安', '江西-吉安-万安', 1240609, '1240601', 1, NULL, '2018-03-30 12:00:00', 1, 4552, 4553);
INSERT INTO `base_region` VALUES ('1240610', '遂川', '江西-吉安-遂川', 1240610, '1240601', 1, NULL, '2018-03-30 12:00:00', 1, 4554, 4555);
INSERT INTO `base_region` VALUES ('1240611', '泰和', '江西-吉安-泰和', 1240611, '1240601', 1, NULL, '2018-03-30 12:00:00', 1, 4556, 4557);
INSERT INTO `base_region` VALUES ('1240612', '安福', '江西-吉安-安福', 1240612, '1240601', 1, NULL, '2018-03-30 12:00:00', 1, 4558, 4559);
INSERT INTO `base_region` VALUES ('1240614', '吉州', '江西-吉安-吉州', 1240614, '1240601', 1, NULL, '2018-03-30 12:00:00', 1, 4560, 4561);
INSERT INTO `base_region` VALUES ('1240615', '青原', '江西-吉安-青原', 1240615, '1240601', 1, NULL, '2018-03-30 12:00:00', 1, 4562, 4563);
INSERT INTO `base_region` VALUES ('1240701', '赣州', '江西-赣州', 1240701, '1240000', 0, NULL, '2018-03-30 12:00:00', 1, 4565, 4602);
INSERT INTO `base_region` VALUES ('1240702', '崇义', '江西-赣州-崇义', 1240702, '1240701', 1, NULL, '2018-03-30 12:00:00', 1, 4566, 4567);
INSERT INTO `base_region` VALUES ('1240703', '上犹', '江西-赣州-上犹', 1240703, '1240701', 1, NULL, '2018-03-30 12:00:00', 1, 4568, 4569);
INSERT INTO `base_region` VALUES ('1240704', '南康', '江西-赣州-南康', 1240704, '1240701', 1, NULL, '2018-03-30 12:00:00', 1, 4570, 4571);
INSERT INTO `base_region` VALUES ('1240705', '大余', '江西-赣州-大余', 1240705, '1240701', 1, NULL, '2018-03-30 12:00:00', 1, 4572, 4573);
INSERT INTO `base_region` VALUES ('1240706', '信丰', '江西-赣州-信丰', 1240706, '1240701', 1, NULL, '2018-03-30 12:00:00', 1, 4574, 4575);
INSERT INTO `base_region` VALUES ('1240707', '宁都', '江西-赣州-宁都', 1240707, '1240701', 1, NULL, '2018-03-30 12:00:00', 1, 4576, 4577);
INSERT INTO `base_region` VALUES ('1240708', '石城', '江西-赣州-石城', 1240708, '1240701', 1, NULL, '2018-03-30 12:00:00', 1, 4578, 4579);
INSERT INTO `base_region` VALUES ('1240709', '瑞金', '江西-赣州-瑞金', 1240709, '1240701', 1, NULL, '2018-03-30 12:00:00', 1, 4580, 4581);
INSERT INTO `base_region` VALUES ('1240710', '于都', '江西-赣州-于都', 1240710, '1240701', 1, NULL, '2018-03-30 12:00:00', 1, 4582, 4583);
INSERT INTO `base_region` VALUES ('1240711', '会昌', '江西-赣州-会昌', 1240711, '1240701', 1, NULL, '2018-03-30 12:00:00', 1, 4584, 4585);
INSERT INTO `base_region` VALUES ('1240712', '安远', '江西-赣州-安远', 1240712, '1240701', 1, NULL, '2018-03-30 12:00:00', 1, 4586, 4587);
INSERT INTO `base_region` VALUES ('1240713', '全南', '江西-赣州-全南', 1240713, '1240701', 1, NULL, '2018-03-30 12:00:00', 1, 4588, 4589);
INSERT INTO `base_region` VALUES ('1240714', '龙南', '江西-赣州-龙南', 1240714, '1240701', 1, NULL, '2018-03-30 12:00:00', 1, 4590, 4591);
INSERT INTO `base_region` VALUES ('1240715', '定南', '江西-赣州-定南', 1240715, '1240701', 1, NULL, '2018-03-30 12:00:00', 1, 4592, 4593);
INSERT INTO `base_region` VALUES ('1240716', '寻乌', '江西-赣州-寻乌', 1240716, '1240701', 1, NULL, '2018-03-30 12:00:00', 1, 4594, 4595);
INSERT INTO `base_region` VALUES ('1240717', '兴国', '江西-赣州-兴国', 1240717, '1240701', 1, NULL, '2018-03-30 12:00:00', 1, 4596, 4597);
INSERT INTO `base_region` VALUES ('1240718', '赣县', '江西-赣州-赣县', 1240718, '1240701', 1, NULL, '2018-03-30 12:00:00', 1, 4598, 4599);
INSERT INTO `base_region` VALUES ('1240719', '章贡', '江西-赣州-章贡', 1240719, '1240701', 1, NULL, '2018-03-30 12:00:00', 1, 4600, 4601);
INSERT INTO `base_region` VALUES ('1240801', '景德镇', '江西-景德镇', 1240801, '1240000', 0, NULL, '2018-03-30 12:00:00', 1, 4603, 4612);
INSERT INTO `base_region` VALUES ('1240802', '乐平', '江西-景德镇-乐平', 1240802, '1240801', 1, NULL, '2018-03-30 12:00:00', 1, 4604, 4605);
INSERT INTO `base_region` VALUES ('1240803', '浮梁', '江西-景德镇-浮梁', 1240803, '1240801', 1, NULL, '2018-03-30 12:00:00', 1, 4606, 4607);
INSERT INTO `base_region` VALUES ('1240804', '昌江', '江西-景德镇-昌江', 1240804, '1240801', 1, NULL, '2018-03-30 12:00:00', 1, 4608, 4609);
INSERT INTO `base_region` VALUES ('1240805', '珠山', '江西-景德镇-珠山', 1240805, '1240801', 1, NULL, '2018-03-30 12:00:00', 1, 4610, 4611);
INSERT INTO `base_region` VALUES ('1240901', '萍乡', '江西-萍乡', 1240901, '1240000', 0, NULL, '2018-03-30 12:00:00', 1, 4613, 4624);
INSERT INTO `base_region` VALUES ('1240902', '莲花', '江西-萍乡-莲花', 1240902, '1240901', 1, NULL, '2018-03-30 12:00:00', 1, 4614, 4615);
INSERT INTO `base_region` VALUES ('1240903', '上栗', '江西-萍乡-上栗', 1240903, '1240901', 1, NULL, '2018-03-30 12:00:00', 1, 4616, 4617);
INSERT INTO `base_region` VALUES ('1240904', '安源', '江西-萍乡-安源', 1240904, '1240901', 1, NULL, '2018-03-30 12:00:00', 1, 4618, 4619);
INSERT INTO `base_region` VALUES ('1240905', '芦溪', '江西-萍乡-芦溪', 1240905, '1240901', 1, NULL, '2018-03-30 12:00:00', 1, 4620, 4621);
INSERT INTO `base_region` VALUES ('1240906', '湘东', '江西-萍乡-湘东', 1240906, '1240901', 1, NULL, '2018-03-30 12:00:00', 1, 4622, 4623);
INSERT INTO `base_region` VALUES ('1241001', '新余', '江西-新余', 1241001, '1240000', 0, NULL, '2018-03-30 12:00:00', 1, 4625, 4630);
INSERT INTO `base_region` VALUES ('1241002', '分宜', '江西-新余-分宜', 1241002, '1241001', 1, NULL, '2018-03-30 12:00:00', 1, 4626, 4627);
INSERT INTO `base_region` VALUES ('1241003', '渝水', '江西-新余-渝水', 1241003, '1241001', 1, NULL, '2018-03-30 12:00:00', 1, 4628, 4629);
INSERT INTO `base_region` VALUES ('1241101', '鹰潭', '江西-鹰潭', 1241101, '1240000', 0, NULL, '2018-03-30 12:00:00', 1, 4631, 4638);
INSERT INTO `base_region` VALUES ('1241102', '余江', '江西-鹰潭-余江', 1241102, '1241101', 1, NULL, '2018-03-30 12:00:00', 1, 4632, 4633);
INSERT INTO `base_region` VALUES ('1241103', '贵溪', '江西-鹰潭-贵溪', 1241103, '1241101', 1, NULL, '2018-03-30 12:00:00', 1, 4634, 4635);
INSERT INTO `base_region` VALUES ('1241104', '月湖', '江西-鹰潭-月湖', 1241104, '1241101', 1, NULL, '2018-03-30 12:00:00', 1, 4636, 4637);
INSERT INTO `base_region` VALUES ('1250000', '湖南', '湖南', 1250000, 'ROOT', 0, NULL, '2018-03-30 12:00:00', 1, 4640, 4909);
INSERT INTO `base_region` VALUES ('1250101', '长沙', '湖南-长沙', 1250101, '1250000', 0, NULL, '2018-03-30 12:00:00', 1, 4641, 4662);
INSERT INTO `base_region` VALUES ('1250102', '宁乡', '湖南-长沙-宁乡', 1250102, '1250101', 1, NULL, '2018-03-30 12:00:00', 1, 4642, 4643);
INSERT INTO `base_region` VALUES ('1250103', '浏阳', '湖南-长沙-浏阳', 1250103, '1250101', 1, NULL, '2018-03-30 12:00:00', 1, 4644, 4645);
INSERT INTO `base_region` VALUES ('1250104', '湘江新区', '湖南-长沙-湘江新区', 1250104, '1250101', 1, NULL, '2018-03-30 12:00:00', 1, 4646, 4647);
INSERT INTO `base_region` VALUES ('1250105', '望城', '湖南-长沙-望城', 1250105, '1250101', 1, NULL, '2018-03-30 12:00:00', 1, 4648, 4649);
INSERT INTO `base_region` VALUES ('1250106', '长沙县', '湖南-长沙-长沙县', 1250106, '1250101', 1, NULL, '2018-03-30 12:00:00', 1, 4650, 4651);
INSERT INTO `base_region` VALUES ('1250107', '芙蓉', '湖南-长沙-芙蓉', 1250107, '1250101', 1, NULL, '2018-03-30 12:00:00', 1, 4652, 4653);
INSERT INTO `base_region` VALUES ('1250108', '天心', '湖南-长沙-天心', 1250108, '1250101', 1, NULL, '2018-03-30 12:00:00', 1, 4654, 4655);
INSERT INTO `base_region` VALUES ('1250109', '岳麓', '湖南-长沙-岳麓', 1250109, '1250101', 1, NULL, '2018-03-30 12:00:00', 1, 4656, 4657);
INSERT INTO `base_region` VALUES ('1250110', '开福', '湖南-长沙-开福', 1250110, '1250101', 1, NULL, '2018-03-30 12:00:00', 1, 4658, 4659);
INSERT INTO `base_region` VALUES ('1250111', '雨花', '湖南-长沙-雨花', 1250111, '1250101', 1, NULL, '2018-03-30 12:00:00', 1, 4660, 4661);
INSERT INTO `base_region` VALUES ('1250201', '湘潭', '湖南-湘潭', 1250201, '1250000', 0, NULL, '2018-03-30 12:00:00', 1, 4663, 4672);
INSERT INTO `base_region` VALUES ('1250202', '韶山', '湖南-湘潭-韶山', 1250202, '1250201', 1, NULL, '2018-03-30 12:00:00', 1, 4664, 4665);
INSERT INTO `base_region` VALUES ('1250203', '湘乡', '湖南-湘潭-湘乡', 1250203, '1250201', 1, NULL, '2018-03-30 12:00:00', 1, 4666, 4667);
INSERT INTO `base_region` VALUES ('1250204', '雨湖', '湖南-湘潭-雨湖', 1250204, '1250201', 1, NULL, '2018-03-30 12:00:00', 1, 4668, 4669);
INSERT INTO `base_region` VALUES ('1250205', '岳塘', '湖南-湘潭-岳塘', 1250205, '1250201', 1, NULL, '2018-03-30 12:00:00', 1, 4670, 4671);
INSERT INTO `base_region` VALUES ('1250301', '株洲', '湖南-株洲', 1250301, '1250000', 0, NULL, '2018-03-30 12:00:00', 1, 4673, 4690);
INSERT INTO `base_region` VALUES ('1250302', '攸县', '湖南-株洲-攸县', 1250302, '1250301', 1, NULL, '2018-03-30 12:00:00', 1, 4674, 4675);
INSERT INTO `base_region` VALUES ('1250303', '醴陵', '湖南-株洲-醴陵', 1250303, '1250301', 1, NULL, '2018-03-30 12:00:00', 1, 4676, 4677);
INSERT INTO `base_region` VALUES ('1250304', '荷塘', '湖南-株洲-荷塘', 1250304, '1250301', 1, NULL, '2018-03-30 12:00:00', 1, 4678, 4679);
INSERT INTO `base_region` VALUES ('1250305', '茶陵', '湖南-株洲-茶陵', 1250305, '1250301', 1, NULL, '2018-03-30 12:00:00', 1, 4680, 4681);
INSERT INTO `base_region` VALUES ('1250306', '炎陵', '湖南-株洲-炎陵', 1250306, '1250301', 1, NULL, '2018-03-30 12:00:00', 1, 4682, 4683);
INSERT INTO `base_region` VALUES ('1250307', '芦淞', '湖南-株洲-芦淞', 1250307, '1250301', 1, NULL, '2018-03-30 12:00:00', 1, 4684, 4685);
INSERT INTO `base_region` VALUES ('1250308', '石峰', '湖南-株洲-石峰', 1250308, '1250301', 1, NULL, '2018-03-30 12:00:00', 1, 4686, 4687);
INSERT INTO `base_region` VALUES ('1250309', '天元', '湖南-株洲-天元', 1250309, '1250301', 1, NULL, '2018-03-30 12:00:00', 1, 4688, 4689);
INSERT INTO `base_region` VALUES ('1250401', '衡阳', '湖南-衡阳', 1250401, '1250000', 0, NULL, '2018-03-30 12:00:00', 1, 4691, 4716);
INSERT INTO `base_region` VALUES ('1250402', '衡山', '湖南-衡阳-衡山', 1250402, '1250401', 1, NULL, '2018-03-30 12:00:00', 1, 4692, 4693);
INSERT INTO `base_region` VALUES ('1250403', '衡东', '湖南-衡阳-衡东', 1250403, '1250401', 1, NULL, '2018-03-30 12:00:00', 1, 4694, 4695);
INSERT INTO `base_region` VALUES ('1250404', '祁东', '湖南-衡阳-祁东', 1250404, '1250401', 1, NULL, '2018-03-30 12:00:00', 1, 4696, 4697);
INSERT INTO `base_region` VALUES ('1250405', '衡阳县', '湖南-衡阳-衡阳县', 1250405, '1250401', 1, NULL, '2018-03-30 12:00:00', 1, 4698, 4699);
INSERT INTO `base_region` VALUES ('1250406', '常宁', '湖南-衡阳-常宁', 1250406, '1250401', 1, NULL, '2018-03-30 12:00:00', 1, 4700, 4701);
INSERT INTO `base_region` VALUES ('1250407', '衡南', '湖南-衡阳-衡南', 1250407, '1250401', 1, NULL, '2018-03-30 12:00:00', 1, 4702, 4703);
INSERT INTO `base_region` VALUES ('1250408', '耒阳', '湖南-衡阳-耒阳', 1250408, '1250401', 1, NULL, '2018-03-30 12:00:00', 1, 4704, 4705);
INSERT INTO `base_region` VALUES ('1250409', '南岳', '湖南-衡阳-南岳', 1250409, '1250401', 1, NULL, '2018-03-30 12:00:00', 1, 4706, 4707);
INSERT INTO `base_region` VALUES ('1250410', '珠晖', '湖南-衡阳-珠晖', 1250410, '1250401', 1, NULL, '2018-03-30 12:00:00', 1, 4708, 4709);
INSERT INTO `base_region` VALUES ('1250411', '雁峰', '湖南-衡阳-雁峰', 1250411, '1250401', 1, NULL, '2018-03-30 12:00:00', 1, 4710, 4711);
INSERT INTO `base_region` VALUES ('1250412', '石鼓', '湖南-衡阳-石鼓', 1250412, '1250401', 1, NULL, '2018-03-30 12:00:00', 1, 4712, 4713);
INSERT INTO `base_region` VALUES ('1250413', '蒸湘', '湖南-衡阳-蒸湘', 1250413, '1250401', 1, NULL, '2018-03-30 12:00:00', 1, 4714, 4715);
INSERT INTO `base_region` VALUES ('1250501', '郴州', '湖南-郴州', 1250501, '1250000', 0, NULL, '2018-03-30 12:00:00', 1, 4717, 4740);
INSERT INTO `base_region` VALUES ('1250502', '桂阳', '湖南-郴州-桂阳', 1250502, '1250501', 1, NULL, '2018-03-30 12:00:00', 1, 4718, 4719);
INSERT INTO `base_region` VALUES ('1250503', '嘉禾', '湖南-郴州-嘉禾', 1250503, '1250501', 1, NULL, '2018-03-30 12:00:00', 1, 4720, 4721);
INSERT INTO `base_region` VALUES ('1250504', '宜章', '湖南-郴州-宜章', 1250504, '1250501', 1, NULL, '2018-03-30 12:00:00', 1, 4722, 4723);
INSERT INTO `base_region` VALUES ('1250505', '临武', '湖南-郴州-临武', 1250505, '1250501', 1, NULL, '2018-03-30 12:00:00', 1, 4724, 4725);
INSERT INTO `base_region` VALUES ('1250506', '北湖', '湖南-郴州-北湖', 1250506, '1250501', 1, NULL, '2018-03-30 12:00:00', 1, 4726, 4727);
INSERT INTO `base_region` VALUES ('1250507', '资兴', '湖南-郴州-资兴', 1250507, '1250501', 1, NULL, '2018-03-30 12:00:00', 1, 4728, 4729);
INSERT INTO `base_region` VALUES ('1250508', '汝城', '湖南-郴州-汝城', 1250508, '1250501', 1, NULL, '2018-03-30 12:00:00', 1, 4730, 4731);
INSERT INTO `base_region` VALUES ('1250509', '安仁', '湖南-郴州-安仁', 1250509, '1250501', 1, NULL, '2018-03-30 12:00:00', 1, 4732, 4733);
INSERT INTO `base_region` VALUES ('1250510', '永兴', '湖南-郴州-永兴', 1250510, '1250501', 1, NULL, '2018-03-30 12:00:00', 1, 4734, 4735);
INSERT INTO `base_region` VALUES ('1250511', '桂东', '湖南-郴州-桂东', 1250511, '1250501', 1, NULL, '2018-03-30 12:00:00', 1, 4736, 4737);
INSERT INTO `base_region` VALUES ('1250512', '苏仙', '湖南-郴州-苏仙', 1250512, '1250501', 1, NULL, '2018-03-30 12:00:00', 1, 4738, 4739);
INSERT INTO `base_region` VALUES ('1250601', '常德', '湖南-常德', 1250601, '1250000', 0, NULL, '2018-03-30 12:00:00', 1, 4741, 4760);
INSERT INTO `base_region` VALUES ('1250602', '安乡', '湖南-常德-安乡', 1250602, '1250601', 1, NULL, '2018-03-30 12:00:00', 1, 4742, 4743);
INSERT INTO `base_region` VALUES ('1250603', '桃源', '湖南-常德-桃源', 1250603, '1250601', 1, NULL, '2018-03-30 12:00:00', 1, 4744, 4745);
INSERT INTO `base_region` VALUES ('1250604', '汉寿', '湖南-常德-汉寿', 1250604, '1250601', 1, NULL, '2018-03-30 12:00:00', 1, 4746, 4747);
INSERT INTO `base_region` VALUES ('1250605', '澧县', '湖南-常德-澧县', 1250605, '1250601', 1, NULL, '2018-03-30 12:00:00', 1, 4748, 4749);
INSERT INTO `base_region` VALUES ('1250606', '临澧', '湖南-常德-临澧', 1250606, '1250601', 1, NULL, '2018-03-30 12:00:00', 1, 4750, 4751);
INSERT INTO `base_region` VALUES ('1250607', '石门', '湖南-常德-石门', 1250607, '1250601', 1, NULL, '2018-03-30 12:00:00', 1, 4752, 4753);
INSERT INTO `base_region` VALUES ('1250608', '津市', '湖南-常德-津市', 1250608, '1250601', 1, NULL, '2018-03-30 12:00:00', 1, 4754, 4755);
INSERT INTO `base_region` VALUES ('1250609', '武陵', '湖南-常德-武陵', 1250609, '1250601', 1, NULL, '2018-03-30 12:00:00', 1, 4756, 4757);
INSERT INTO `base_region` VALUES ('1250610', '鼎城', '湖南-常德-鼎城', 1250610, '1250601', 1, NULL, '2018-03-30 12:00:00', 1, 4758, 4759);
INSERT INTO `base_region` VALUES ('1250700', '益阳', '湖南-益阳', 1250700, '1250000', 0, NULL, '2018-03-30 12:00:00', 1, 4761, 4774);
INSERT INTO `base_region` VALUES ('1250701', '赫山区', '湖南-益阳-赫山区', 1250701, '1250700', 1, NULL, '2018-03-30 12:00:00', 1, 4762, 4763);
INSERT INTO `base_region` VALUES ('1250702', '南县', '湖南-益阳-南县', 1250702, '1250700', 1, NULL, '2018-03-30 12:00:00', 1, 4764, 4765);
INSERT INTO `base_region` VALUES ('1250703', '桃江', '湖南-益阳-桃江', 1250703, '1250700', 1, NULL, '2018-03-30 12:00:00', 1, 4766, 4767);
INSERT INTO `base_region` VALUES ('1250704', '安化', '湖南-益阳-安化', 1250704, '1250700', 1, NULL, '2018-03-30 12:00:00', 1, 4768, 4769);
INSERT INTO `base_region` VALUES ('1250705', '沅江', '湖南-益阳-沅江', 1250705, '1250700', 1, NULL, '2018-03-30 12:00:00', 1, 4770, 4771);
INSERT INTO `base_region` VALUES ('1250706', '资阳', '湖南-益阳-资阳', 1250706, '1250700', 1, NULL, '2018-03-30 12:00:00', 1, 4772, 4773);
INSERT INTO `base_region` VALUES ('1250801', '娄底', '湖南-娄底', 1250801, '1250000', 0, NULL, '2018-03-30 12:00:00', 1, 4775, 4786);
INSERT INTO `base_region` VALUES ('1250802', '双峰', '湖南-娄底-双峰', 1250802, '1250801', 1, NULL, '2018-03-30 12:00:00', 1, 4776, 4777);
INSERT INTO `base_region` VALUES ('1250803', '冷水江', '湖南-娄底-冷水江', 1250803, '1250801', 1, NULL, '2018-03-30 12:00:00', 1, 4778, 4779);
INSERT INTO `base_region` VALUES ('1250804', '娄星', '湖南-娄底-娄星', 1250804, '1250801', 1, NULL, '2018-03-30 12:00:00', 1, 4780, 4781);
INSERT INTO `base_region` VALUES ('1250805', '新化', '湖南-娄底-新化', 1250805, '1250801', 1, NULL, '2018-03-30 12:00:00', 1, 4782, 4783);
INSERT INTO `base_region` VALUES ('1250806', '涟源', '湖南-娄底-涟源', 1250806, '1250801', 1, NULL, '2018-03-30 12:00:00', 1, 4784, 4785);
INSERT INTO `base_region` VALUES ('1250901', '邵阳', '湖南-邵阳', 1250901, '1250000', 0, NULL, '2018-03-30 12:00:00', 1, 4787, 4812);
INSERT INTO `base_region` VALUES ('1250902', '隆回', '湖南-邵阳-隆回', 1250902, '1250901', 1, NULL, '2018-03-30 12:00:00', 1, 4788, 4789);
INSERT INTO `base_region` VALUES ('1250903', '洞口', '湖南-邵阳-洞口', 1250903, '1250901', 1, NULL, '2018-03-30 12:00:00', 1, 4790, 4791);
INSERT INTO `base_region` VALUES ('1250904', '新邵', '湖南-邵阳-新邵', 1250904, '1250901', 1, NULL, '2018-03-30 12:00:00', 1, 4792, 4793);
INSERT INTO `base_region` VALUES ('1250905', '邵东', '湖南-邵阳-邵东', 1250905, '1250901', 1, NULL, '2018-03-30 12:00:00', 1, 4794, 4795);
INSERT INTO `base_region` VALUES ('1250906', '绥宁', '湖南-邵阳-绥宁', 1250906, '1250901', 1, NULL, '2018-03-30 12:00:00', 1, 4796, 4797);
INSERT INTO `base_region` VALUES ('1250907', '新宁', '湖南-邵阳-新宁', 1250907, '1250901', 1, NULL, '2018-03-30 12:00:00', 1, 4798, 4799);
INSERT INTO `base_region` VALUES ('1250908', '武冈', '湖南-邵阳-武冈', 1250908, '1250901', 1, NULL, '2018-03-30 12:00:00', 1, 4800, 4801);
INSERT INTO `base_region` VALUES ('1250909', '城步', '湖南-邵阳-城步', 1250909, '1250901', 1, NULL, '2018-03-30 12:00:00', 1, 4802, 4803);
INSERT INTO `base_region` VALUES ('1250910', '邵阳县', '湖南-邵阳-邵阳县', 1250910, '1250901', 1, NULL, '2018-03-30 12:00:00', 1, 4804, 4805);
INSERT INTO `base_region` VALUES ('1250911', '双清', '湖南-邵阳-双清', 1250911, '1250901', 1, NULL, '2018-03-30 12:00:00', 1, 4806, 4807);
INSERT INTO `base_region` VALUES ('1250912', '大祥', '湖南-邵阳-大祥', 1250912, '1250901', 1, NULL, '2018-03-30 12:00:00', 1, 4808, 4809);
INSERT INTO `base_region` VALUES ('1250913', '北塔', '湖南-邵阳-北塔', 1250913, '1250901', 1, NULL, '2018-03-30 12:00:00', 1, 4810, 4811);
INSERT INTO `base_region` VALUES ('1251001', '岳阳', '湖南-岳阳', 1251001, '1250000', 0, NULL, '2018-03-30 12:00:00', 1, 4813, 4830);
INSERT INTO `base_region` VALUES ('1251002', '华容', '湖南-岳阳-华容', 1251002, '1251001', 1, NULL, '2018-03-30 12:00:00', 1, 4814, 4815);
INSERT INTO `base_region` VALUES ('1251003', '湘阴', '湖南-岳阳-湘阴', 1251003, '1251001', 1, NULL, '2018-03-30 12:00:00', 1, 4816, 4817);
INSERT INTO `base_region` VALUES ('1251004', '汨罗', '湖南-岳阳-汨罗', 1251004, '1251001', 1, NULL, '2018-03-30 12:00:00', 1, 4818, 4819);
INSERT INTO `base_region` VALUES ('1251005', '平江', '湖南-岳阳-平江', 1251005, '1251001', 1, NULL, '2018-03-30 12:00:00', 1, 4820, 4821);
INSERT INTO `base_region` VALUES ('1251006', '临湘', '湖南-岳阳-临湘', 1251006, '1251001', 1, NULL, '2018-03-30 12:00:00', 1, 4822, 4823);
INSERT INTO `base_region` VALUES ('1251007', '岳阳楼区', '湖南-岳阳-岳阳楼区', 1251007, '1251001', 1, NULL, '2018-03-30 12:00:00', 1, 4824, 4825);
INSERT INTO `base_region` VALUES ('1251008', '云溪', '湖南-岳阳-云溪', 1251008, '1251001', 1, NULL, '2018-03-30 12:00:00', 1, 4826, 4827);
INSERT INTO `base_region` VALUES ('1251009', '君山', '湖南-岳阳-君山', 1251009, '1251001', 1, NULL, '2018-03-30 12:00:00', 1, 4828, 4829);
INSERT INTO `base_region` VALUES ('1251101', '张家界', '湖南-张家界', 1251101, '1250000', 0, NULL, '2018-03-30 12:00:00', 1, 4831, 4840);
INSERT INTO `base_region` VALUES ('1251102', '桑植', '湖南-张家界-桑植', 1251102, '1251101', 1, NULL, '2018-03-30 12:00:00', 1, 4832, 4833);
INSERT INTO `base_region` VALUES ('1251103', '慈利', '湖南-张家界-慈利', 1251103, '1251101', 1, NULL, '2018-03-30 12:00:00', 1, 4834, 4835);
INSERT INTO `base_region` VALUES ('1251104', '武陵源', '湖南-张家界-武陵源', 1251104, '1251101', 1, NULL, '2018-03-30 12:00:00', 1, 4836, 4837);
INSERT INTO `base_region` VALUES ('1251105', '永定', '湖南-张家界-永定', 1251105, '1251101', 1, NULL, '2018-03-30 12:00:00', 1, 4838, 4839);
INSERT INTO `base_region` VALUES ('1251201', '怀化', '湖南-怀化', 1251201, '1250000', 0, NULL, '2018-03-30 12:00:00', 1, 4841, 4866);
INSERT INTO `base_region` VALUES ('1251202', '鹤城', '湖南-怀化-鹤城', 1251202, '1251201', 1, NULL, '2018-03-30 12:00:00', 1, 4842, 4843);
INSERT INTO `base_region` VALUES ('1251203', '沅陵', '湖南-怀化-沅陵', 1251203, '1251201', 1, NULL, '2018-03-30 12:00:00', 1, 4844, 4845);
INSERT INTO `base_region` VALUES ('1251204', '辰溪', '湖南-怀化-辰溪', 1251204, '1251201', 1, NULL, '2018-03-30 12:00:00', 1, 4846, 4847);
INSERT INTO `base_region` VALUES ('1251205', '靖州', '湖南-怀化-靖州', 1251205, '1251201', 1, NULL, '2018-03-30 12:00:00', 1, 4848, 4849);
INSERT INTO `base_region` VALUES ('1251206', '会同', '湖南-怀化-会同', 1251206, '1251201', 1, NULL, '2018-03-30 12:00:00', 1, 4850, 4851);
INSERT INTO `base_region` VALUES ('1251207', '通道', '湖南-怀化-通道', 1251207, '1251201', 1, NULL, '2018-03-30 12:00:00', 1, 4852, 4853);
INSERT INTO `base_region` VALUES ('1251208', '麻阳', '湖南-怀化-麻阳', 1251208, '1251201', 1, NULL, '2018-03-30 12:00:00', 1, 4854, 4855);
INSERT INTO `base_region` VALUES ('1251209', '新晃', '湖南-怀化-新晃', 1251209, '1251201', 1, NULL, '2018-03-30 12:00:00', 1, 4856, 4857);
INSERT INTO `base_region` VALUES ('1251210', '芷江', '湖南-怀化-芷江', 1251210, '1251201', 1, NULL, '2018-03-30 12:00:00', 1, 4858, 4859);
INSERT INTO `base_region` VALUES ('1251211', '溆浦', '湖南-怀化-溆浦', 1251211, '1251201', 1, NULL, '2018-03-30 12:00:00', 1, 4860, 4861);
INSERT INTO `base_region` VALUES ('1251212', '中方', '湖南-怀化-中方', 1251212, '1251201', 1, NULL, '2018-03-30 12:00:00', 1, 4862, 4863);
INSERT INTO `base_region` VALUES ('1251213', '洪江', '湖南-怀化-洪江', 1251213, '1251201', 1, NULL, '2018-03-30 12:00:00', 1, 4864, 4865);
INSERT INTO `base_region` VALUES ('1251401', '永州', '湖南-永州', 1251401, '1250000', 0, NULL, '2018-03-30 12:00:00', 1, 4867, 4890);
INSERT INTO `base_region` VALUES ('1251402', '祁阳', '湖南-永州-祁阳', 1251402, '1251401', 1, NULL, '2018-03-30 12:00:00', 1, 4868, 4869);
INSERT INTO `base_region` VALUES ('1251403', '东安', '湖南-永州-东安', 1251403, '1251401', 1, NULL, '2018-03-30 12:00:00', 1, 4870, 4871);
INSERT INTO `base_region` VALUES ('1251404', '双牌', '湖南-永州-双牌', 1251404, '1251401', 1, NULL, '2018-03-30 12:00:00', 1, 4872, 4873);
INSERT INTO `base_region` VALUES ('1251405', '道县', '湖南-永州-道县', 1251405, '1251401', 1, NULL, '2018-03-30 12:00:00', 1, 4874, 4875);
INSERT INTO `base_region` VALUES ('1251406', '宁远', '湖南-永州-宁远', 1251406, '1251401', 1, NULL, '2018-03-30 12:00:00', 1, 4876, 4877);
INSERT INTO `base_region` VALUES ('1251407', '江永', '湖南-永州-江永', 1251407, '1251401', 1, NULL, '2018-03-30 12:00:00', 1, 4878, 4879);
INSERT INTO `base_region` VALUES ('1251408', '蓝山', '湖南-永州-蓝山', 1251408, '1251401', 1, NULL, '2018-03-30 12:00:00', 1, 4880, 4881);
INSERT INTO `base_region` VALUES ('1251409', '新田', '湖南-永州-新田', 1251409, '1251401', 1, NULL, '2018-03-30 12:00:00', 1, 4882, 4883);
INSERT INTO `base_region` VALUES ('1251410', '江华', '湖南-永州-江华', 1251410, '1251401', 1, NULL, '2018-03-30 12:00:00', 1, 4884, 4885);
INSERT INTO `base_region` VALUES ('1251411', '冷水滩', '湖南-永州-冷水滩', 1251411, '1251401', 1, NULL, '2018-03-30 12:00:00', 1, 4886, 4887);
INSERT INTO `base_region` VALUES ('1251412', '零陵', '湖南-永州-零陵', 1251412, '1251401', 1, NULL, '2018-03-30 12:00:00', 1, 4888, 4889);
INSERT INTO `base_region` VALUES ('1251501', '吉首', '湖南-湘西-吉首', 1251501, '1251509', 1, NULL, '2018-03-30 12:00:00', 1, 4892, 4893);
INSERT INTO `base_region` VALUES ('1251502', '保靖', '湖南-湘西-保靖', 1251502, '1251509', 1, NULL, '2018-03-30 12:00:00', 1, 4894, 4895);
INSERT INTO `base_region` VALUES ('1251503', '永顺', '湖南-湘西-永顺', 1251503, '1251509', 1, NULL, '2018-03-30 12:00:00', 1, 4896, 4897);
INSERT INTO `base_region` VALUES ('1251504', '古丈', '湖南-湘西-古丈', 1251504, '1251509', 1, NULL, '2018-03-30 12:00:00', 1, 4898, 4899);
INSERT INTO `base_region` VALUES ('1251505', '凤凰', '湖南-湘西-凤凰', 1251505, '1251509', 1, NULL, '2018-03-30 12:00:00', 1, 4900, 4901);
INSERT INTO `base_region` VALUES ('1251506', '泸溪', '湖南-湘西-泸溪', 1251506, '1251509', 1, NULL, '2018-03-30 12:00:00', 1, 4902, 4903);
INSERT INTO `base_region` VALUES ('1251507', '龙山', '湖南-湘西-龙山', 1251507, '1251509', 1, NULL, '2018-03-30 12:00:00', 1, 4904, 4905);
INSERT INTO `base_region` VALUES ('1251508', '花垣', '湖南-湘西-花垣', 1251508, '1251509', 1, NULL, '2018-03-30 12:00:00', 1, 4906, 4907);
INSERT INTO `base_region` VALUES ('1251509', '湘西', '湖南-湘西', 1251509, '1250000', 0, NULL, '2018-03-30 12:00:00', 1, 4891, 4908);
INSERT INTO `base_region` VALUES ('1260000', '贵州', '贵州', 1260000, 'ROOT', 0, NULL, '2018-03-30 12:00:00', 1, 4910, 5107);
INSERT INTO `base_region` VALUES ('1260101', '贵阳', '贵州-贵阳', 1260101, '1260000', 0, NULL, '2018-03-30 12:00:00', 1, 4911, 4932);
INSERT INTO `base_region` VALUES ('1260102', '白云', '贵州-贵阳-白云', 1260102, '1260101', 1, NULL, '2018-03-30 12:00:00', 1, 4912, 4913);
INSERT INTO `base_region` VALUES ('1260103', '花溪', '贵州-贵阳-花溪', 1260103, '1260101', 1, NULL, '2018-03-30 12:00:00', 1, 4914, 4915);
INSERT INTO `base_region` VALUES ('1260104', '乌当', '贵州-贵阳-乌当', 1260104, '1260101', 1, NULL, '2018-03-30 12:00:00', 1, 4916, 4917);
INSERT INTO `base_region` VALUES ('1260105', '息烽', '贵州-贵阳-息烽', 1260105, '1260101', 1, NULL, '2018-03-30 12:00:00', 1, 4918, 4919);
INSERT INTO `base_region` VALUES ('1260106', '开阳', '贵州-贵阳-开阳', 1260106, '1260101', 1, NULL, '2018-03-30 12:00:00', 1, 4920, 4921);
INSERT INTO `base_region` VALUES ('1260107', '修文', '贵州-贵阳-修文', 1260107, '1260101', 1, NULL, '2018-03-30 12:00:00', 1, 4922, 4923);
INSERT INTO `base_region` VALUES ('1260108', '清镇', '贵州-贵阳-清镇', 1260108, '1260101', 1, NULL, '2018-03-30 12:00:00', 1, 4924, 4925);
INSERT INTO `base_region` VALUES ('1260110', '云岩', '贵州-贵阳-云岩', 1260110, '1260101', 1, NULL, '2018-03-30 12:00:00', 1, 4926, 4927);
INSERT INTO `base_region` VALUES ('1260111', '南明', '贵州-贵阳-南明', 1260111, '1260101', 1, NULL, '2018-03-30 12:00:00', 1, 4928, 4929);
INSERT INTO `base_region` VALUES ('1260112', '观山湖', '贵州-贵阳-观山湖', 1260112, '1260101', 1, NULL, '2018-03-30 12:00:00', 1, 4930, 4931);
INSERT INTO `base_region` VALUES ('1260201', '遵义', '贵州-遵义', 1260201, '1260000', 0, NULL, '2018-03-30 12:00:00', 1, 4933, 4964);
INSERT INTO `base_region` VALUES ('1260202', '遵义县', '贵州-遵义-遵义县', 1260202, '1260201', 1, NULL, '2018-03-30 12:00:00', 1, 4934, 4935);
INSERT INTO `base_region` VALUES ('1260203', '仁怀', '贵州-遵义-仁怀', 1260203, '1260201', 1, NULL, '2018-03-30 12:00:00', 1, 4936, 4937);
INSERT INTO `base_region` VALUES ('1260204', '绥阳', '贵州-遵义-绥阳', 1260204, '1260201', 1, NULL, '2018-03-30 12:00:00', 1, 4938, 4939);
INSERT INTO `base_region` VALUES ('1260205', '湄潭', '贵州-遵义-湄潭', 1260205, '1260201', 1, NULL, '2018-03-30 12:00:00', 1, 4940, 4941);
INSERT INTO `base_region` VALUES ('1260206', '凤冈', '贵州-遵义-凤冈', 1260206, '1260201', 1, NULL, '2018-03-30 12:00:00', 1, 4942, 4943);
INSERT INTO `base_region` VALUES ('1260207', '桐梓', '贵州-遵义-桐梓', 1260207, '1260201', 1, NULL, '2018-03-30 12:00:00', 1, 4944, 4945);
INSERT INTO `base_region` VALUES ('1260208', '赤水', '贵州-遵义-赤水', 1260208, '1260201', 1, NULL, '2018-03-30 12:00:00', 1, 4946, 4947);
INSERT INTO `base_region` VALUES ('1260209', '习水', '贵州-遵义-习水', 1260209, '1260201', 1, NULL, '2018-03-30 12:00:00', 1, 4948, 4949);
INSERT INTO `base_region` VALUES ('1260210', '道真', '贵州-遵义-道真', 1260210, '1260201', 1, NULL, '2018-03-30 12:00:00', 1, 4950, 4951);
INSERT INTO `base_region` VALUES ('1260211', '正安', '贵州-遵义-正安', 1260211, '1260201', 1, NULL, '2018-03-30 12:00:00', 1, 4952, 4953);
INSERT INTO `base_region` VALUES ('1260212', '务川', '贵州-遵义-务川', 1260212, '1260201', 1, NULL, '2018-03-30 12:00:00', 1, 4954, 4955);
INSERT INTO `base_region` VALUES ('1260213', '余庆', '贵州-遵义-余庆', 1260213, '1260201', 1, NULL, '2018-03-30 12:00:00', 1, 4956, 4957);
INSERT INTO `base_region` VALUES ('1260214', '汇川', '贵州-遵义-汇川', 1260214, '1260201', 1, NULL, '2018-03-30 12:00:00', 1, 4958, 4959);
INSERT INTO `base_region` VALUES ('1260215', '红花岗', '贵州-遵义-红花岗', 1260215, '1260201', 1, NULL, '2018-03-30 12:00:00', 1, 4960, 4961);
INSERT INTO `base_region` VALUES ('1260216', '播州', '贵州-遵义-播州', 1260216, '1260201', 1, NULL, '2018-03-30 12:00:00', 1, 4962, 4963);
INSERT INTO `base_region` VALUES ('1260301', '安顺', '贵州-安顺', 1260301, '1260000', 0, NULL, '2018-03-30 12:00:00', 1, 4965, 4978);
INSERT INTO `base_region` VALUES ('1260302', '普定', '贵州-安顺-普定', 1260302, '1260301', 1, NULL, '2018-03-30 12:00:00', 1, 4966, 4967);
INSERT INTO `base_region` VALUES ('1260303', '镇宁', '贵州-安顺-镇宁', 1260303, '1260301', 1, NULL, '2018-03-30 12:00:00', 1, 4968, 4969);
INSERT INTO `base_region` VALUES ('1260304', '平坝', '贵州-安顺-平坝', 1260304, '1260301', 1, NULL, '2018-03-30 12:00:00', 1, 4970, 4971);
INSERT INTO `base_region` VALUES ('1260305', '紫云', '贵州-安顺-紫云', 1260305, '1260301', 1, NULL, '2018-03-30 12:00:00', 1, 4972, 4973);
INSERT INTO `base_region` VALUES ('1260306', '关岭', '贵州-安顺-关岭', 1260306, '1260301', 1, NULL, '2018-03-30 12:00:00', 1, 4974, 4975);
INSERT INTO `base_region` VALUES ('1260307', '西秀', '贵州-安顺-西秀', 1260307, '1260301', 1, NULL, '2018-03-30 12:00:00', 1, 4976, 4977);
INSERT INTO `base_region` VALUES ('1260401', '都匀', '贵州-黔南-都匀', 1260401, '1260413', 1, NULL, '2018-03-30 12:00:00', 1, 4980, 4981);
INSERT INTO `base_region` VALUES ('1260402', '贵定', '贵州-黔南-贵定', 1260402, '1260413', 1, NULL, '2018-03-30 12:00:00', 1, 4982, 4983);
INSERT INTO `base_region` VALUES ('1260403', '瓮安', '贵州-黔南-瓮安', 1260403, '1260413', 1, NULL, '2018-03-30 12:00:00', 1, 4984, 4985);
INSERT INTO `base_region` VALUES ('1260404', '长顺', '贵州-黔南-长顺', 1260404, '1260413', 1, NULL, '2018-03-30 12:00:00', 1, 4986, 4987);
INSERT INTO `base_region` VALUES ('1260405', '福泉', '贵州-黔南-福泉', 1260405, '1260413', 1, NULL, '2018-03-30 12:00:00', 1, 4988, 4989);
INSERT INTO `base_region` VALUES ('1260406', '惠水', '贵州-黔南-惠水', 1260406, '1260413', 1, NULL, '2018-03-30 12:00:00', 1, 4990, 4991);
INSERT INTO `base_region` VALUES ('1260407', '龙里', '贵州-黔南-龙里', 1260407, '1260413', 1, NULL, '2018-03-30 12:00:00', 1, 4992, 4993);
INSERT INTO `base_region` VALUES ('1260408', '罗甸', '贵州-黔南-罗甸', 1260408, '1260413', 1, NULL, '2018-03-30 12:00:00', 1, 4994, 4995);
INSERT INTO `base_region` VALUES ('1260409', '平塘', '贵州-黔南-平塘', 1260409, '1260413', 1, NULL, '2018-03-30 12:00:00', 1, 4996, 4997);
INSERT INTO `base_region` VALUES ('1260410', '独山', '贵州-黔南-独山', 1260410, '1260413', 1, NULL, '2018-03-30 12:00:00', 1, 4998, 4999);
INSERT INTO `base_region` VALUES ('1260411', '三都', '贵州-黔南-三都', 1260411, '1260413', 1, NULL, '2018-03-30 12:00:00', 1, 5000, 5001);
INSERT INTO `base_region` VALUES ('1260412', '荔波', '贵州-黔南-荔波', 1260412, '1260413', 1, NULL, '2018-03-30 12:00:00', 1, 5002, 5003);
INSERT INTO `base_region` VALUES ('1260413', '黔南', '贵州-黔南', 1260413, '1260000', 0, NULL, '2018-03-30 12:00:00', 1, 4979, 5004);
INSERT INTO `base_region` VALUES ('1260501', '凯里', '贵州-黔东南-凯里', 1260501, '1260506', 1, NULL, '2018-03-30 12:00:00', 1, 5006, 5007);
INSERT INTO `base_region` VALUES ('1260502', '岑巩', '贵州-黔东南-岑巩', 1260502, '1260506', 1, NULL, '2018-03-30 12:00:00', 1, 5008, 5009);
INSERT INTO `base_region` VALUES ('1260503', '施秉', '贵州-黔东南-施秉', 1260503, '1260506', 1, NULL, '2018-03-30 12:00:00', 1, 5010, 5011);
INSERT INTO `base_region` VALUES ('1260504', '镇远', '贵州-黔东南-镇远', 1260504, '1260506', 1, NULL, '2018-03-30 12:00:00', 1, 5012, 5013);
INSERT INTO `base_region` VALUES ('1260505', '黄平', '贵州-黔东南-黄平', 1260505, '1260506', 1, NULL, '2018-03-30 12:00:00', 1, 5014, 5015);
INSERT INTO `base_region` VALUES ('1260506', '黔东南', '贵州-黔东南', 1260506, '1260000', 0, NULL, '2018-03-30 12:00:00', 1, 5005, 5038);
INSERT INTO `base_region` VALUES ('1260507', '麻江', '贵州-黔东南-麻江', 1260507, '1260506', 1, NULL, '2018-03-30 12:00:00', 1, 5016, 5017);
INSERT INTO `base_region` VALUES ('1260508', '丹寨', '贵州-黔东南-丹寨', 1260508, '1260506', 1, NULL, '2018-03-30 12:00:00', 1, 5018, 5019);
INSERT INTO `base_region` VALUES ('1260509', '三穗', '贵州-黔东南-三穗', 1260509, '1260506', 1, NULL, '2018-03-30 12:00:00', 1, 5020, 5021);
INSERT INTO `base_region` VALUES ('1260510', '台江', '贵州-黔东南-台江', 1260510, '1260506', 1, NULL, '2018-03-30 12:00:00', 1, 5022, 5023);
INSERT INTO `base_region` VALUES ('1260511', '剑河', '贵州-黔东南-剑河', 1260511, '1260506', 1, NULL, '2018-03-30 12:00:00', 1, 5024, 5025);
INSERT INTO `base_region` VALUES ('1260512', '雷山', '贵州-黔东南-雷山', 1260512, '1260506', 1, NULL, '2018-03-30 12:00:00', 1, 5026, 5027);
INSERT INTO `base_region` VALUES ('1260513', '黎平', '贵州-黔东南-黎平', 1260513, '1260506', 1, NULL, '2018-03-30 12:00:00', 1, 5028, 5029);
INSERT INTO `base_region` VALUES ('1260514', '天柱', '贵州-黔东南-天柱', 1260514, '1260506', 1, NULL, '2018-03-30 12:00:00', 1, 5030, 5031);
INSERT INTO `base_region` VALUES ('1260515', '锦屏', '贵州-黔东南-锦屏', 1260515, '1260506', 1, NULL, '2018-03-30 12:00:00', 1, 5032, 5033);
INSERT INTO `base_region` VALUES ('1260516', '榕江', '贵州-黔东南-榕江', 1260516, '1260506', 1, NULL, '2018-03-30 12:00:00', 1, 5034, 5035);
INSERT INTO `base_region` VALUES ('1260517', '从江', '贵州-黔东南-从江', 1260517, '1260506', 1, NULL, '2018-03-30 12:00:00', 1, 5036, 5037);
INSERT INTO `base_region` VALUES ('1260601', '铜仁', '贵州-铜仁', 1260601, '1260000', 0, NULL, '2018-03-30 12:00:00', 1, 5039, 5060);
INSERT INTO `base_region` VALUES ('1260602', '江口', '贵州-铜仁-江口', 1260602, '1260601', 1, NULL, '2018-03-30 12:00:00', 1, 5040, 5041);
INSERT INTO `base_region` VALUES ('1260603', '玉屏', '贵州-铜仁-玉屏', 1260603, '1260601', 1, NULL, '2018-03-30 12:00:00', 1, 5042, 5043);
INSERT INTO `base_region` VALUES ('1260604', '万山', '贵州-铜仁-万山', 1260604, '1260601', 1, NULL, '2018-03-30 12:00:00', 1, 5044, 5045);
INSERT INTO `base_region` VALUES ('1260605', '思南', '贵州-铜仁-思南', 1260605, '1260601', 1, NULL, '2018-03-30 12:00:00', 1, 5046, 5047);
INSERT INTO `base_region` VALUES ('1260606', '碧江', '贵州-铜仁-碧江', 1260606, '1260601', 1, NULL, '2018-03-30 12:00:00', 1, 5048, 5049);
INSERT INTO `base_region` VALUES ('1260607', '印江', '贵州-铜仁-印江', 1260607, '1260601', 1, NULL, '2018-03-30 12:00:00', 1, 5050, 5051);
INSERT INTO `base_region` VALUES ('1260608', '石阡', '贵州-铜仁-石阡', 1260608, '1260601', 1, NULL, '2018-03-30 12:00:00', 1, 5052, 5053);
INSERT INTO `base_region` VALUES ('1260609', '沿河', '贵州-铜仁-沿河', 1260609, '1260601', 1, NULL, '2018-03-30 12:00:00', 1, 5054, 5055);
INSERT INTO `base_region` VALUES ('1260610', '德江', '贵州-铜仁-德江', 1260610, '1260601', 1, NULL, '2018-03-30 12:00:00', 1, 5056, 5057);
INSERT INTO `base_region` VALUES ('1260611', '松桃', '贵州-铜仁-松桃', 1260611, '1260601', 1, NULL, '2018-03-30 12:00:00', 1, 5058, 5059);
INSERT INTO `base_region` VALUES ('1260701', '毕节', '贵州-毕节', 1260701, '1260000', 0, NULL, '2018-03-30 12:00:00', 1, 5061, 5078);
INSERT INTO `base_region` VALUES ('1260702', '赫章', '贵州-毕节-赫章', 1260702, '1260701', 1, NULL, '2018-03-30 12:00:00', 1, 5062, 5063);
INSERT INTO `base_region` VALUES ('1260703', '金沙', '贵州-毕节-金沙', 1260703, '1260701', 1, NULL, '2018-03-30 12:00:00', 1, 5064, 5065);
INSERT INTO `base_region` VALUES ('1260704', '威宁', '贵州-毕节-威宁', 1260704, '1260701', 1, NULL, '2018-03-30 12:00:00', 1, 5066, 5067);
INSERT INTO `base_region` VALUES ('1260705', '大方', '贵州-毕节-大方', 1260705, '1260701', 1, NULL, '2018-03-30 12:00:00', 1, 5068, 5069);
INSERT INTO `base_region` VALUES ('1260706', '纳雍', '贵州-毕节-纳雍', 1260706, '1260701', 1, NULL, '2018-03-30 12:00:00', 1, 5070, 5071);
INSERT INTO `base_region` VALUES ('1260707', '织金', '贵州-毕节-织金', 1260707, '1260701', 1, NULL, '2018-03-30 12:00:00', 1, 5072, 5073);
INSERT INTO `base_region` VALUES ('1260708', '黔西', '贵州-毕节-黔西', 1260708, '1260701', 1, NULL, '2018-03-30 12:00:00', 1, 5074, 5075);
INSERT INTO `base_region` VALUES ('1260709', '七星关', '贵州-毕节-七星关', 1260709, '1260701', 1, NULL, '2018-03-30 12:00:00', 1, 5076, 5077);
INSERT INTO `base_region` VALUES ('1260801', '水城', '贵州-六盘水-水城', 1260801, '1260803', 1, NULL, '2018-03-30 12:00:00', 1, 5080, 5081);
INSERT INTO `base_region` VALUES ('1260802', '六枝', '贵州-六盘水-六枝', 1260802, '1260803', 1, NULL, '2018-03-30 12:00:00', 1, 5082, 5083);
INSERT INTO `base_region` VALUES ('1260803', '六盘水', '贵州-六盘水', 1260803, '1260000', 0, NULL, '2018-03-30 12:00:00', 1, 5079, 5088);
INSERT INTO `base_region` VALUES ('1260804', '盘县', '贵州-六盘水-盘县', 1260804, '1260803', 1, NULL, '2018-03-30 12:00:00', 1, 5084, 5085);
INSERT INTO `base_region` VALUES ('1260805', '钟山', '贵州-六盘水-钟山', 1260805, '1260803', 1, NULL, '2018-03-30 12:00:00', 1, 5086, 5087);
INSERT INTO `base_region` VALUES ('1260901', '兴义', '贵州-黔西南-兴义', 1260901, '1260906', 1, NULL, '2018-03-30 12:00:00', 1, 5090, 5091);
INSERT INTO `base_region` VALUES ('1260902', '晴隆', '贵州-黔西南-晴隆', 1260902, '1260906', 1, NULL, '2018-03-30 12:00:00', 1, 5092, 5093);
INSERT INTO `base_region` VALUES ('1260903', '兴仁', '贵州-黔西南-兴仁', 1260903, '1260906', 1, NULL, '2018-03-30 12:00:00', 1, 5094, 5095);
INSERT INTO `base_region` VALUES ('1260904', '贞丰', '贵州-黔西南-贞丰', 1260904, '1260906', 1, NULL, '2018-03-30 12:00:00', 1, 5096, 5097);
INSERT INTO `base_region` VALUES ('1260905', '望谟', '贵州-黔西南-望谟', 1260905, '1260906', 1, NULL, '2018-03-30 12:00:00', 1, 5098, 5099);
INSERT INTO `base_region` VALUES ('1260906', '黔西南', '贵州-黔西南', 1260906, '1260000', 0, NULL, '2018-03-30 12:00:00', 1, 5089, 5106);
INSERT INTO `base_region` VALUES ('1260907', '安龙', '贵州-黔西南-安龙', 1260907, '1260906', 1, NULL, '2018-03-30 12:00:00', 1, 5100, 5101);
INSERT INTO `base_region` VALUES ('1260908', '册亨', '贵州-黔西南-册亨', 1260908, '1260906', 1, NULL, '2018-03-30 12:00:00', 1, 5102, 5103);
INSERT INTO `base_region` VALUES ('1260909', '普安', '贵州-黔西南-普安', 1260909, '1260906', 1, NULL, '2018-03-30 12:00:00', 1, 5104, 5105);
INSERT INTO `base_region` VALUES ('1270000', '四川', '四川', 1270000, 'ROOT', 0, NULL, '2018-03-30 12:00:00', 1, 5108, 5513);
INSERT INTO `base_region` VALUES ('1270101', '成都', '四川-成都', 1270101, '1270000', 0, NULL, '2018-03-30 12:00:00', 1, 5109, 5150);
INSERT INTO `base_region` VALUES ('1270102', '龙泉驿', '四川-成都-龙泉驿', 1270102, '1270101', 1, NULL, '2018-03-30 12:00:00', 1, 5110, 5111);
INSERT INTO `base_region` VALUES ('1270103', '新都', '四川-成都-新都', 1270103, '1270101', 1, NULL, '2018-03-30 12:00:00', 1, 5112, 5113);
INSERT INTO `base_region` VALUES ('1270104', '温江', '四川-成都-温江', 1270104, '1270101', 1, NULL, '2018-03-30 12:00:00', 1, 5114, 5115);
INSERT INTO `base_region` VALUES ('1270105', '金堂', '四川-成都-金堂', 1270105, '1270101', 1, NULL, '2018-03-30 12:00:00', 1, 5116, 5117);
INSERT INTO `base_region` VALUES ('1270106', '双流', '四川-成都-双流', 1270106, '1270101', 1, NULL, '2018-03-30 12:00:00', 1, 5118, 5119);
INSERT INTO `base_region` VALUES ('1270107', '郫县', '四川-成都-郫县', 1270107, '1270101', 1, NULL, '2018-03-30 12:00:00', 1, 5120, 5121);
INSERT INTO `base_region` VALUES ('1270108', '大邑', '四川-成都-大邑', 1270108, '1270101', 1, NULL, '2018-03-30 12:00:00', 1, 5122, 5123);
INSERT INTO `base_region` VALUES ('1270109', '蒲江', '四川-成都-蒲江', 1270109, '1270101', 1, NULL, '2018-03-30 12:00:00', 1, 5124, 5125);
INSERT INTO `base_region` VALUES ('1270110', '新津', '四川-成都-新津', 1270110, '1270101', 1, NULL, '2018-03-30 12:00:00', 1, 5126, 5127);
INSERT INTO `base_region` VALUES ('1270111', '都江堰', '四川-成都-都江堰', 1270111, '1270101', 1, NULL, '2018-03-30 12:00:00', 1, 5128, 5129);
INSERT INTO `base_region` VALUES ('1270112', '彭州', '四川-成都-彭州', 1270112, '1270101', 1, NULL, '2018-03-30 12:00:00', 1, 5130, 5131);
INSERT INTO `base_region` VALUES ('1270113', '邛崃', '四川-成都-邛崃', 1270113, '1270101', 1, NULL, '2018-03-30 12:00:00', 1, 5132, 5133);
INSERT INTO `base_region` VALUES ('1270114', '崇州', '四川-成都-崇州', 1270114, '1270101', 1, NULL, '2018-03-30 12:00:00', 1, 5134, 5135);
INSERT INTO `base_region` VALUES ('1270115', '青白江', '四川-成都-青白江', 1270115, '1270101', 1, NULL, '2018-03-30 12:00:00', 1, 5136, 5137);
INSERT INTO `base_region` VALUES ('1270116', '锦江', '四川-成都-锦江', 1270116, '1270101', 1, NULL, '2018-03-30 12:00:00', 1, 5138, 5139);
INSERT INTO `base_region` VALUES ('1270117', '青羊', '四川-成都-青羊', 1270117, '1270101', 1, NULL, '2018-03-30 12:00:00', 1, 5140, 5141);
INSERT INTO `base_region` VALUES ('1270118', '金牛', '四川-成都-金牛', 1270118, '1270101', 1, NULL, '2018-03-30 12:00:00', 1, 5142, 5143);
INSERT INTO `base_region` VALUES ('1270119', '武侯', '四川-成都-武侯', 1270119, '1270101', 1, NULL, '2018-03-30 12:00:00', 1, 5144, 5145);
INSERT INTO `base_region` VALUES ('1270120', '成华', '四川-成都-成华', 1270120, '1270101', 1, NULL, '2018-03-30 12:00:00', 1, 5146, 5147);
INSERT INTO `base_region` VALUES ('1270121', '简阳', '四川-成都-简阳', 1270121, '1270101', 1, NULL, '2018-03-30 12:00:00', 1, 5148, 5149);
INSERT INTO `base_region` VALUES ('1270201', '攀枝花', '四川-攀枝花', 1270201, '1270000', 0, NULL, '2018-03-30 12:00:00', 1, 5151, 5162);
INSERT INTO `base_region` VALUES ('1270202', '仁和', '四川-攀枝花-仁和', 1270202, '1270201', 1, NULL, '2018-03-30 12:00:00', 1, 5152, 5153);
INSERT INTO `base_region` VALUES ('1270203', '米易', '四川-攀枝花-米易', 1270203, '1270201', 1, NULL, '2018-03-30 12:00:00', 1, 5154, 5155);
INSERT INTO `base_region` VALUES ('1270204', '盐边', '四川-攀枝花-盐边', 1270204, '1270201', 1, NULL, '2018-03-30 12:00:00', 1, 5156, 5157);
INSERT INTO `base_region` VALUES ('1270205', '东区', '四川-攀枝花-东区', 1270205, '1270201', 1, NULL, '2018-03-30 12:00:00', 1, 5158, 5159);
INSERT INTO `base_region` VALUES ('1270206', '西区', '四川-攀枝花-西区', 1270206, '1270201', 1, NULL, '2018-03-30 12:00:00', 1, 5160, 5161);
INSERT INTO `base_region` VALUES ('1270301', '自贡', '四川-自贡', 1270301, '1270000', 0, NULL, '2018-03-30 12:00:00', 1, 5163, 5176);
INSERT INTO `base_region` VALUES ('1270302', '富顺', '四川-自贡-富顺', 1270302, '1270301', 1, NULL, '2018-03-30 12:00:00', 1, 5164, 5165);
INSERT INTO `base_region` VALUES ('1270303', '荣县', '四川-自贡-荣县', 1270303, '1270301', 1, NULL, '2018-03-30 12:00:00', 1, 5166, 5167);
INSERT INTO `base_region` VALUES ('1270304', '自流井', '四川-自贡-自流井', 1270304, '1270301', 1, NULL, '2018-03-30 12:00:00', 1, 5168, 5169);
INSERT INTO `base_region` VALUES ('1270305', '贡井', '四川-自贡-贡井', 1270305, '1270301', 1, NULL, '2018-03-30 12:00:00', 1, 5170, 5171);
INSERT INTO `base_region` VALUES ('1270306', '大安', '四川-自贡-大安', 1270306, '1270301', 1, NULL, '2018-03-30 12:00:00', 1, 5172, 5173);
INSERT INTO `base_region` VALUES ('1270307', '沿滩', '四川-自贡-沿滩', 1270307, '1270301', 1, NULL, '2018-03-30 12:00:00', 1, 5174, 5175);
INSERT INTO `base_region` VALUES ('1270401', '绵阳', '四川-绵阳', 1270401, '1270000', 0, NULL, '2018-03-30 12:00:00', 1, 5177, 5198);
INSERT INTO `base_region` VALUES ('1270402', '三台', '四川-绵阳-三台', 1270402, '1270401', 1, NULL, '2018-03-30 12:00:00', 1, 5178, 5179);
INSERT INTO `base_region` VALUES ('1270403', '盐亭', '四川-绵阳-盐亭', 1270403, '1270401', 1, NULL, '2018-03-30 12:00:00', 1, 5180, 5181);
INSERT INTO `base_region` VALUES ('1270404', '安县', '四川-绵阳-安县', 1270404, '1270401', 1, NULL, '2018-03-30 12:00:00', 1, 5182, 5183);
INSERT INTO `base_region` VALUES ('1270405', '梓潼', '四川-绵阳-梓潼', 1270405, '1270401', 1, NULL, '2018-03-30 12:00:00', 1, 5184, 5185);
INSERT INTO `base_region` VALUES ('1270406', '北川', '四川-绵阳-北川', 1270406, '1270401', 1, NULL, '2018-03-30 12:00:00', 1, 5186, 5187);
INSERT INTO `base_region` VALUES ('1270407', '平武', '四川-绵阳-平武', 1270407, '1270401', 1, NULL, '2018-03-30 12:00:00', 1, 5188, 5189);
INSERT INTO `base_region` VALUES ('1270408', '江油', '四川-绵阳-江油', 1270408, '1270401', 1, NULL, '2018-03-30 12:00:00', 1, 5190, 5191);
INSERT INTO `base_region` VALUES ('1270409', '涪城', '四川-绵阳-涪城', 1270409, '1270401', 1, NULL, '2018-03-30 12:00:00', 1, 5192, 5193);
INSERT INTO `base_region` VALUES ('1270410', '游仙', '四川-绵阳-游仙', 1270410, '1270401', 1, NULL, '2018-03-30 12:00:00', 1, 5194, 5195);
INSERT INTO `base_region` VALUES ('1270411', '安州', '四川-绵阳-安州', 1270411, '1270401', 1, NULL, '2018-03-30 12:00:00', 1, 5196, 5197);
INSERT INTO `base_region` VALUES ('1270501', '南充', '四川-南充', 1270501, '1270000', 0, NULL, '2018-03-30 12:00:00', 1, 5199, 5218);
INSERT INTO `base_region` VALUES ('1270502', '南部', '四川-南充-南部', 1270502, '1270501', 1, NULL, '2018-03-30 12:00:00', 1, 5200, 5201);
INSERT INTO `base_region` VALUES ('1270503', '营山', '四川-南充-营山', 1270503, '1270501', 1, NULL, '2018-03-30 12:00:00', 1, 5202, 5203);
INSERT INTO `base_region` VALUES ('1270504', '蓬安', '四川-南充-蓬安', 1270504, '1270501', 1, NULL, '2018-03-30 12:00:00', 1, 5204, 5205);
INSERT INTO `base_region` VALUES ('1270505', '仪陇', '四川-南充-仪陇', 1270505, '1270501', 1, NULL, '2018-03-30 12:00:00', 1, 5206, 5207);
INSERT INTO `base_region` VALUES ('1270506', '西充', '四川-南充-西充', 1270506, '1270501', 1, NULL, '2018-03-30 12:00:00', 1, 5208, 5209);
INSERT INTO `base_region` VALUES ('1270507', '阆中', '四川-南充-阆中', 1270507, '1270501', 1, NULL, '2018-03-30 12:00:00', 1, 5210, 5211);
INSERT INTO `base_region` VALUES ('1270508', '顺庆', '四川-南充-顺庆', 1270508, '1270501', 1, NULL, '2018-03-30 12:00:00', 1, 5212, 5213);
INSERT INTO `base_region` VALUES ('1270509', '高坪', '四川-南充-高坪', 1270509, '1270501', 1, NULL, '2018-03-30 12:00:00', 1, 5214, 5215);
INSERT INTO `base_region` VALUES ('1270510', '嘉陵', '四川-南充-嘉陵', 1270510, '1270501', 1, NULL, '2018-03-30 12:00:00', 1, 5216, 5217);
INSERT INTO `base_region` VALUES ('1270601', '达州', '四川-达州', 1270601, '1270000', 0, NULL, '2018-03-30 12:00:00', 1, 5219, 5234);
INSERT INTO `base_region` VALUES ('1270602', '宣汉', '四川-达州-宣汉', 1270602, '1270601', 1, NULL, '2018-03-30 12:00:00', 1, 5220, 5221);
INSERT INTO `base_region` VALUES ('1270603', '开江', '四川-达州-开江', 1270603, '1270601', 1, NULL, '2018-03-30 12:00:00', 1, 5222, 5223);
INSERT INTO `base_region` VALUES ('1270604', '大竹', '四川-达州-大竹', 1270604, '1270601', 1, NULL, '2018-03-30 12:00:00', 1, 5224, 5225);
INSERT INTO `base_region` VALUES ('1270605', '渠县', '四川-达州-渠县', 1270605, '1270601', 1, NULL, '2018-03-30 12:00:00', 1, 5226, 5227);
INSERT INTO `base_region` VALUES ('1270606', '万源', '四川-达州-万源', 1270606, '1270601', 1, NULL, '2018-03-30 12:00:00', 1, 5228, 5229);
INSERT INTO `base_region` VALUES ('1270607', '通川', '四川-达州-通川', 1270607, '1270601', 1, NULL, '2018-03-30 12:00:00', 1, 5230, 5231);
INSERT INTO `base_region` VALUES ('1270608', '达川', '四川-达州-达川', 1270608, '1270601', 1, NULL, '2018-03-30 12:00:00', 1, 5232, 5233);
INSERT INTO `base_region` VALUES ('1270701', '遂宁', '四川-遂宁', 1270701, '1270000', 0, NULL, '2018-03-30 12:00:00', 1, 5235, 5246);
INSERT INTO `base_region` VALUES ('1270702', '蓬溪', '四川-遂宁-蓬溪', 1270702, '1270701', 1, NULL, '2018-03-30 12:00:00', 1, 5236, 5237);
INSERT INTO `base_region` VALUES ('1270703', '射洪', '四川-遂宁-射洪', 1270703, '1270701', 1, NULL, '2018-03-30 12:00:00', 1, 5238, 5239);
INSERT INTO `base_region` VALUES ('1270704', '船山', '四川-遂宁-船山', 1270704, '1270701', 1, NULL, '2018-03-30 12:00:00', 1, 5240, 5241);
INSERT INTO `base_region` VALUES ('1270705', '安居', '四川-遂宁-安居', 1270705, '1270701', 1, NULL, '2018-03-30 12:00:00', 1, 5242, 5243);
INSERT INTO `base_region` VALUES ('1270706', '大英', '四川-遂宁-大英', 1270706, '1270701', 1, NULL, '2018-03-30 12:00:00', 1, 5244, 5245);
INSERT INTO `base_region` VALUES ('1270801', '广安', '四川-广安', 1270801, '1270000', 0, NULL, '2018-03-30 12:00:00', 1, 5247, 5258);
INSERT INTO `base_region` VALUES ('1270802', '岳池', '四川-广安-岳池', 1270802, '1270801', 1, NULL, '2018-03-30 12:00:00', 1, 5248, 5249);
INSERT INTO `base_region` VALUES ('1270803', '武胜', '四川-广安-武胜', 1270803, '1270801', 1, NULL, '2018-03-30 12:00:00', 1, 5250, 5251);
INSERT INTO `base_region` VALUES ('1270804', '邻水', '四川-广安-邻水', 1270804, '1270801', 1, NULL, '2018-03-30 12:00:00', 1, 5252, 5253);
INSERT INTO `base_region` VALUES ('1270805', '华蓥', '四川-广安-华蓥', 1270805, '1270801', 1, NULL, '2018-03-30 12:00:00', 1, 5254, 5255);
INSERT INTO `base_region` VALUES ('1270806', '前锋', '四川-广安-前锋', 1270806, '1270801', 1, NULL, '2018-03-30 12:00:00', 1, 5256, 5257);
INSERT INTO `base_region` VALUES ('1270901', '巴中', '四川-巴中', 1270901, '1270000', 0, NULL, '2018-03-30 12:00:00', 1, 5259, 5270);
INSERT INTO `base_region` VALUES ('1270902', '通江', '四川-巴中-通江', 1270902, '1270901', 1, NULL, '2018-03-30 12:00:00', 1, 5260, 5261);
INSERT INTO `base_region` VALUES ('1270903', '南江', '四川-巴中-南江', 1270903, '1270901', 1, NULL, '2018-03-30 12:00:00', 1, 5262, 5263);
INSERT INTO `base_region` VALUES ('1270904', '平昌', '四川-巴中-平昌', 1270904, '1270901', 1, NULL, '2018-03-30 12:00:00', 1, 5264, 5265);
INSERT INTO `base_region` VALUES ('1270905', '巴州', '四川-巴中-巴州', 1270905, '1270901', 1, NULL, '2018-03-30 12:00:00', 1, 5266, 5267);
INSERT INTO `base_region` VALUES ('1270906', '恩阳', '四川-巴中-恩阳', 1270906, '1270901', 1, NULL, '2018-03-30 12:00:00', 1, 5268, 5269);
INSERT INTO `base_region` VALUES ('1271001', '泸州', '四川-泸州', 1271001, '1270000', 0, NULL, '2018-03-30 12:00:00', 1, 5271, 5286);
INSERT INTO `base_region` VALUES ('1271002', '江阳', '四川-泸州-江阳', 1271002, '1271001', 1, NULL, '2018-03-30 12:00:00', 1, 5272, 5273);
INSERT INTO `base_region` VALUES ('1271003', '泸县', '四川-泸州-泸县', 1271003, '1271001', 1, NULL, '2018-03-30 12:00:00', 1, 5274, 5275);
INSERT INTO `base_region` VALUES ('1271004', '合江', '四川-泸州-合江', 1271004, '1271001', 1, NULL, '2018-03-30 12:00:00', 1, 5276, 5277);
INSERT INTO `base_region` VALUES ('1271005', '叙永', '四川-泸州-叙永', 1271005, '1271001', 1, NULL, '2018-03-30 12:00:00', 1, 5278, 5279);
INSERT INTO `base_region` VALUES ('1271006', '古蔺', '四川-泸州-古蔺', 1271006, '1271001', 1, NULL, '2018-03-30 12:00:00', 1, 5280, 5281);
INSERT INTO `base_region` VALUES ('1271007', '纳溪', '四川-泸州-纳溪', 1271007, '1271001', 1, NULL, '2018-03-30 12:00:00', 1, 5282, 5283);
INSERT INTO `base_region` VALUES ('1271008', '龙马潭', '四川-泸州-龙马潭', 1271008, '1271001', 1, NULL, '2018-03-30 12:00:00', 1, 5284, 5285);
INSERT INTO `base_region` VALUES ('1271101', '宜宾', '四川-宜宾', 1271101, '1270000', 0, NULL, '2018-03-30 12:00:00', 1, 5287, 5308);
INSERT INTO `base_region` VALUES ('1271102', '翠屏', '四川-宜宾-翠屏', 1271102, '1271101', 1, NULL, '2018-03-30 12:00:00', 1, 5288, 5289);
INSERT INTO `base_region` VALUES ('1271103', '宜宾县', '四川-宜宾-宜宾县', 1271103, '1271101', 1, NULL, '2018-03-30 12:00:00', 1, 5290, 5291);
INSERT INTO `base_region` VALUES ('1271104', '南溪', '四川-宜宾-南溪', 1271104, '1271101', 1, NULL, '2018-03-30 12:00:00', 1, 5292, 5293);
INSERT INTO `base_region` VALUES ('1271105', '江安', '四川-宜宾-江安', 1271105, '1271101', 1, NULL, '2018-03-30 12:00:00', 1, 5294, 5295);
INSERT INTO `base_region` VALUES ('1271106', '长宁', '四川-宜宾-长宁', 1271106, '1271101', 1, NULL, '2018-03-30 12:00:00', 1, 5296, 5297);
INSERT INTO `base_region` VALUES ('1271107', '高县', '四川-宜宾-高县', 1271107, '1271101', 1, NULL, '2018-03-30 12:00:00', 1, 5298, 5299);
INSERT INTO `base_region` VALUES ('1271108', '珙县', '四川-宜宾-珙县', 1271108, '1271101', 1, NULL, '2018-03-30 12:00:00', 1, 5300, 5301);
INSERT INTO `base_region` VALUES ('1271109', '筠连', '四川-宜宾-筠连', 1271109, '1271101', 1, NULL, '2018-03-30 12:00:00', 1, 5302, 5303);
INSERT INTO `base_region` VALUES ('1271110', '兴文', '四川-宜宾-兴文', 1271110, '1271101', 1, NULL, '2018-03-30 12:00:00', 1, 5304, 5305);
INSERT INTO `base_region` VALUES ('1271111', '屏山', '四川-宜宾-屏山', 1271111, '1271101', 1, NULL, '2018-03-30 12:00:00', 1, 5306, 5307);
INSERT INTO `base_region` VALUES ('1271201', '内江', '四川-内江', 1271201, '1270000', 0, NULL, '2018-03-30 12:00:00', 1, 5309, 5320);
INSERT INTO `base_region` VALUES ('1271202', '东兴', '四川-内江-东兴', 1271202, '1271201', 1, NULL, '2018-03-30 12:00:00', 1, 5310, 5311);
INSERT INTO `base_region` VALUES ('1271203', '威远', '四川-内江-威远', 1271203, '1271201', 1, NULL, '2018-03-30 12:00:00', 1, 5312, 5313);
INSERT INTO `base_region` VALUES ('1271204', '资中', '四川-内江-资中', 1271204, '1271201', 1, NULL, '2018-03-30 12:00:00', 1, 5314, 5315);
INSERT INTO `base_region` VALUES ('1271205', '隆昌', '四川-内江-隆昌', 1271205, '1271201', 1, NULL, '2018-03-30 12:00:00', 1, 5316, 5317);
INSERT INTO `base_region` VALUES ('1271206', '市中', '四川-内江-市中', 1271206, '1271201', 1, NULL, '2018-03-30 12:00:00', 1, 5318, 5319);
INSERT INTO `base_region` VALUES ('1271301', '资阳', '四川-资阳', 1271301, '1270000', 0, NULL, '2018-03-30 12:00:00', 1, 5321, 5328);
INSERT INTO `base_region` VALUES ('1271302', '安岳', '四川-资阳-安岳', 1271302, '1271301', 1, NULL, '2018-03-30 12:00:00', 1, 5322, 5323);
INSERT INTO `base_region` VALUES ('1271303', '乐至', '四川-资阳-乐至', 1271303, '1271301', 1, NULL, '2018-03-30 12:00:00', 1, 5324, 5325);
INSERT INTO `base_region` VALUES ('1271305', '雁江', '四川-资阳-雁江', 1271305, '1271301', 1, NULL, '2018-03-30 12:00:00', 1, 5326, 5327);
INSERT INTO `base_region` VALUES ('1271401', '乐山', '四川-乐山', 1271401, '1270000', 0, NULL, '2018-03-30 12:00:00', 1, 5329, 5352);
INSERT INTO `base_region` VALUES ('1271402', '犍为', '四川-乐山-犍为', 1271402, '1271401', 1, NULL, '2018-03-30 12:00:00', 1, 5330, 5331);
INSERT INTO `base_region` VALUES ('1271403', '井研', '四川-乐山-井研', 1271403, '1271401', 1, NULL, '2018-03-30 12:00:00', 1, 5332, 5333);
INSERT INTO `base_region` VALUES ('1271404', '夹江', '四川-乐山-夹江', 1271404, '1271401', 1, NULL, '2018-03-30 12:00:00', 1, 5334, 5335);
INSERT INTO `base_region` VALUES ('1271405', '沐川', '四川-乐山-沐川', 1271405, '1271401', 1, NULL, '2018-03-30 12:00:00', 1, 5336, 5337);
INSERT INTO `base_region` VALUES ('1271406', '峨边', '四川-乐山-峨边', 1271406, '1271401', 1, NULL, '2018-03-30 12:00:00', 1, 5338, 5339);
INSERT INTO `base_region` VALUES ('1271407', '马边', '四川-乐山-马边', 1271407, '1271401', 1, NULL, '2018-03-30 12:00:00', 1, 5340, 5341);
INSERT INTO `base_region` VALUES ('1271409', '峨眉山', '四川-乐山-峨眉山', 1271409, '1271401', 1, NULL, '2018-03-30 12:00:00', 1, 5342, 5343);
INSERT INTO `base_region` VALUES ('1271410', '市中', '四川-乐山-市中', 1271410, '1271401', 1, NULL, '2018-03-30 12:00:00', 1, 5344, 5345);
INSERT INTO `base_region` VALUES ('1271411', '沙湾', '四川-乐山-沙湾', 1271411, '1271401', 1, NULL, '2018-03-30 12:00:00', 1, 5346, 5347);
INSERT INTO `base_region` VALUES ('1271412', '五通桥', '四川-乐山-五通桥', 1271412, '1271401', 1, NULL, '2018-03-30 12:00:00', 1, 5348, 5349);
INSERT INTO `base_region` VALUES ('1271413', '金口河', '四川-乐山-金口河', 1271413, '1271401', 1, NULL, '2018-03-30 12:00:00', 1, 5350, 5351);
INSERT INTO `base_region` VALUES ('1271501', '眉山', '四川-眉山', 1271501, '1270000', 0, NULL, '2018-03-30 12:00:00', 1, 5353, 5366);
INSERT INTO `base_region` VALUES ('1271502', '仁寿', '四川-眉山-仁寿', 1271502, '1271501', 1, NULL, '2018-03-30 12:00:00', 1, 5354, 5355);
INSERT INTO `base_region` VALUES ('1271503', '彭山', '四川-眉山-彭山', 1271503, '1271501', 1, NULL, '2018-03-30 12:00:00', 1, 5356, 5357);
INSERT INTO `base_region` VALUES ('1271504', '洪雅', '四川-眉山-洪雅', 1271504, '1271501', 1, NULL, '2018-03-30 12:00:00', 1, 5358, 5359);
INSERT INTO `base_region` VALUES ('1271505', '丹棱', '四川-眉山-丹棱', 1271505, '1271501', 1, NULL, '2018-03-30 12:00:00', 1, 5360, 5361);
INSERT INTO `base_region` VALUES ('1271506', '青神', '四川-眉山-青神', 1271506, '1271501', 1, NULL, '2018-03-30 12:00:00', 1, 5362, 5363);
INSERT INTO `base_region` VALUES ('1271507', '东坡', '四川-眉山-东坡', 1271507, '1271501', 1, NULL, '2018-03-30 12:00:00', 1, 5364, 5365);
INSERT INTO `base_region` VALUES ('1271601', '凉山', '四川-凉山', 1271601, '1270000', 0, NULL, '2018-03-30 12:00:00', 1, 5367, 5402);
INSERT INTO `base_region` VALUES ('1271603', '木里', '四川-凉山-木里', 1271603, '1271601', 1, NULL, '2018-03-30 12:00:00', 1, 5368, 5369);
INSERT INTO `base_region` VALUES ('1271604', '盐源', '四川-凉山-盐源', 1271604, '1271601', 1, NULL, '2018-03-30 12:00:00', 1, 5370, 5371);
INSERT INTO `base_region` VALUES ('1271605', '德昌', '四川-凉山-德昌', 1271605, '1271601', 1, NULL, '2018-03-30 12:00:00', 1, 5372, 5373);
INSERT INTO `base_region` VALUES ('1271606', '会理', '四川-凉山-会理', 1271606, '1271601', 1, NULL, '2018-03-30 12:00:00', 1, 5374, 5375);
INSERT INTO `base_region` VALUES ('1271607', '会东', '四川-凉山-会东', 1271607, '1271601', 1, NULL, '2018-03-30 12:00:00', 1, 5376, 5377);
INSERT INTO `base_region` VALUES ('1271608', '宁南', '四川-凉山-宁南', 1271608, '1271601', 1, NULL, '2018-03-30 12:00:00', 1, 5378, 5379);
INSERT INTO `base_region` VALUES ('1271609', '普格', '四川-凉山-普格', 1271609, '1271601', 1, NULL, '2018-03-30 12:00:00', 1, 5380, 5381);
INSERT INTO `base_region` VALUES ('1271610', '西昌', '四川-凉山-西昌', 1271610, '1271601', 1, NULL, '2018-03-30 12:00:00', 1, 5382, 5383);
INSERT INTO `base_region` VALUES ('1271611', '金阳', '四川-凉山-金阳', 1271611, '1271601', 1, NULL, '2018-03-30 12:00:00', 1, 5384, 5385);
INSERT INTO `base_region` VALUES ('1271612', '昭觉', '四川-凉山-昭觉', 1271612, '1271601', 1, NULL, '2018-03-30 12:00:00', 1, 5386, 5387);
INSERT INTO `base_region` VALUES ('1271613', '喜德', '四川-凉山-喜德', 1271613, '1271601', 1, NULL, '2018-03-30 12:00:00', 1, 5388, 5389);
INSERT INTO `base_region` VALUES ('1271614', '冕宁', '四川-凉山-冕宁', 1271614, '1271601', 1, NULL, '2018-03-30 12:00:00', 1, 5390, 5391);
INSERT INTO `base_region` VALUES ('1271615', '越西', '四川-凉山-越西', 1271615, '1271601', 1, NULL, '2018-03-30 12:00:00', 1, 5392, 5393);
INSERT INTO `base_region` VALUES ('1271616', '甘洛', '四川-凉山-甘洛', 1271616, '1271601', 1, NULL, '2018-03-30 12:00:00', 1, 5394, 5395);
INSERT INTO `base_region` VALUES ('1271617', '雷波', '四川-凉山-雷波', 1271617, '1271601', 1, NULL, '2018-03-30 12:00:00', 1, 5396, 5397);
INSERT INTO `base_region` VALUES ('1271618', '美姑', '四川-凉山-美姑', 1271618, '1271601', 1, NULL, '2018-03-30 12:00:00', 1, 5398, 5399);
INSERT INTO `base_region` VALUES ('1271619', '布拖', '四川-凉山-布拖', 1271619, '1271601', 1, NULL, '2018-03-30 12:00:00', 1, 5400, 5401);
INSERT INTO `base_region` VALUES ('1271701', '雅安', '四川-雅安', 1271701, '1270000', 0, NULL, '2018-03-30 12:00:00', 1, 5403, 5420);
INSERT INTO `base_region` VALUES ('1271702', '名山', '四川-雅安-名山', 1271702, '1271701', 1, NULL, '2018-03-30 12:00:00', 1, 5404, 5405);
INSERT INTO `base_region` VALUES ('1271703', '荥经', '四川-雅安-荥经', 1271703, '1271701', 1, NULL, '2018-03-30 12:00:00', 1, 5406, 5407);
INSERT INTO `base_region` VALUES ('1271704', '汉源', '四川-雅安-汉源', 1271704, '1271701', 1, NULL, '2018-03-30 12:00:00', 1, 5408, 5409);
INSERT INTO `base_region` VALUES ('1271705', '石棉', '四川-雅安-石棉', 1271705, '1271701', 1, NULL, '2018-03-30 12:00:00', 1, 5410, 5411);
INSERT INTO `base_region` VALUES ('1271706', '天全', '四川-雅安-天全', 1271706, '1271701', 1, NULL, '2018-03-30 12:00:00', 1, 5412, 5413);
INSERT INTO `base_region` VALUES ('1271707', '芦山', '四川-雅安-芦山', 1271707, '1271701', 1, NULL, '2018-03-30 12:00:00', 1, 5414, 5415);
INSERT INTO `base_region` VALUES ('1271708', '宝兴', '四川-雅安-宝兴', 1271708, '1271701', 1, NULL, '2018-03-30 12:00:00', 1, 5416, 5417);
INSERT INTO `base_region` VALUES ('1271709', '雨城', '四川-雅安-雨城', 1271709, '1271701', 1, NULL, '2018-03-30 12:00:00', 1, 5418, 5419);
INSERT INTO `base_region` VALUES ('1271801', '甘孜', '四川-甘孜', 1271801, '1270000', 0, NULL, '2018-03-30 12:00:00', 1, 5421, 5456);
INSERT INTO `base_region` VALUES ('1271802', '康定', '四川-甘孜-康定', 1271802, '1271801', 1, NULL, '2018-03-30 12:00:00', 1, 5422, 5423);
INSERT INTO `base_region` VALUES ('1271803', '泸定', '四川-甘孜-泸定', 1271803, '1271801', 1, NULL, '2018-03-30 12:00:00', 1, 5424, 5425);
INSERT INTO `base_region` VALUES ('1271804', '丹巴', '四川-甘孜-丹巴', 1271804, '1271801', 1, NULL, '2018-03-30 12:00:00', 1, 5426, 5427);
INSERT INTO `base_region` VALUES ('1271805', '九龙', '四川-甘孜-九龙', 1271805, '1271801', 1, NULL, '2018-03-30 12:00:00', 1, 5428, 5429);
INSERT INTO `base_region` VALUES ('1271806', '雅江', '四川-甘孜-雅江', 1271806, '1271801', 1, NULL, '2018-03-30 12:00:00', 1, 5430, 5431);
INSERT INTO `base_region` VALUES ('1271807', '道孚', '四川-甘孜-道孚', 1271807, '1271801', 1, NULL, '2018-03-30 12:00:00', 1, 5432, 5433);
INSERT INTO `base_region` VALUES ('1271808', '炉霍', '四川-甘孜-炉霍', 1271808, '1271801', 1, NULL, '2018-03-30 12:00:00', 1, 5434, 5435);
INSERT INTO `base_region` VALUES ('1271809', '新龙', '四川-甘孜-新龙', 1271809, '1271801', 1, NULL, '2018-03-30 12:00:00', 1, 5436, 5437);
INSERT INTO `base_region` VALUES ('1271810', '德格', '四川-甘孜-德格', 1271810, '1271801', 1, NULL, '2018-03-30 12:00:00', 1, 5438, 5439);
INSERT INTO `base_region` VALUES ('1271811', '白玉', '四川-甘孜-白玉', 1271811, '1271801', 1, NULL, '2018-03-30 12:00:00', 1, 5440, 5441);
INSERT INTO `base_region` VALUES ('1271812', '石渠', '四川-甘孜-石渠', 1271812, '1271801', 1, NULL, '2018-03-30 12:00:00', 1, 5442, 5443);
INSERT INTO `base_region` VALUES ('1271813', '色达', '四川-甘孜-色达', 1271813, '1271801', 1, NULL, '2018-03-30 12:00:00', 1, 5444, 5445);
INSERT INTO `base_region` VALUES ('1271814', '理塘', '四川-甘孜-理塘', 1271814, '1271801', 1, NULL, '2018-03-30 12:00:00', 1, 5446, 5447);
INSERT INTO `base_region` VALUES ('1271815', '巴塘', '四川-甘孜-巴塘', 1271815, '1271801', 1, NULL, '2018-03-30 12:00:00', 1, 5448, 5449);
INSERT INTO `base_region` VALUES ('1271816', '乡城', '四川-甘孜-乡城', 1271816, '1271801', 1, NULL, '2018-03-30 12:00:00', 1, 5450, 5451);
INSERT INTO `base_region` VALUES ('1271817', '稻城', '四川-甘孜-稻城', 1271817, '1271801', 1, NULL, '2018-03-30 12:00:00', 1, 5452, 5453);
INSERT INTO `base_region` VALUES ('1271818', '得荣', '四川-甘孜-得荣', 1271818, '1271801', 1, NULL, '2018-03-30 12:00:00', 1, 5454, 5455);
INSERT INTO `base_region` VALUES ('1271901', '阿坝', '四川-阿坝', 1271901, '1270000', 0, NULL, '2018-03-30 12:00:00', 1, 5457, 5482);
INSERT INTO `base_region` VALUES ('1271902', '汶川', '四川-阿坝-汶川', 1271902, '1271901', 1, NULL, '2018-03-30 12:00:00', 1, 5458, 5459);
INSERT INTO `base_region` VALUES ('1271903', '理县', '四川-阿坝-理县', 1271903, '1271901', 1, NULL, '2018-03-30 12:00:00', 1, 5460, 5461);
INSERT INTO `base_region` VALUES ('1271904', '茂县', '四川-阿坝-茂县', 1271904, '1271901', 1, NULL, '2018-03-30 12:00:00', 1, 5462, 5463);
INSERT INTO `base_region` VALUES ('1271905', '松潘', '四川-阿坝-松潘', 1271905, '1271901', 1, NULL, '2018-03-30 12:00:00', 1, 5464, 5465);
INSERT INTO `base_region` VALUES ('1271906', '九寨沟', '四川-阿坝-九寨沟', 1271906, '1271901', 1, NULL, '2018-03-30 12:00:00', 1, 5466, 5467);
INSERT INTO `base_region` VALUES ('1271907', '金川', '四川-阿坝-金川', 1271907, '1271901', 1, NULL, '2018-03-30 12:00:00', 1, 5468, 5469);
INSERT INTO `base_region` VALUES ('1271908', '小金', '四川-阿坝-小金', 1271908, '1271901', 1, NULL, '2018-03-30 12:00:00', 1, 5470, 5471);
INSERT INTO `base_region` VALUES ('1271909', '黑水', '四川-阿坝-黑水', 1271909, '1271901', 1, NULL, '2018-03-30 12:00:00', 1, 5472, 5473);
INSERT INTO `base_region` VALUES ('1271910', '马尔康', '四川-阿坝-马尔康', 1271910, '1271901', 1, NULL, '2018-03-30 12:00:00', 1, 5474, 5475);
INSERT INTO `base_region` VALUES ('1271911', '壤塘', '四川-阿坝-壤塘', 1271911, '1271901', 1, NULL, '2018-03-30 12:00:00', 1, 5476, 5477);
INSERT INTO `base_region` VALUES ('1271912', '若尔盖', '四川-阿坝-若尔盖', 1271912, '1271901', 1, NULL, '2018-03-30 12:00:00', 1, 5478, 5479);
INSERT INTO `base_region` VALUES ('1271913', '红原', '四川-阿坝-红原', 1271913, '1271901', 1, NULL, '2018-03-30 12:00:00', 1, 5480, 5481);
INSERT INTO `base_region` VALUES ('1272001', '德阳', '四川-德阳', 1272001, '1270000', 0, NULL, '2018-03-30 12:00:00', 1, 5483, 5496);
INSERT INTO `base_region` VALUES ('1272002', '中江', '四川-德阳-中江', 1272002, '1272001', 1, NULL, '2018-03-30 12:00:00', 1, 5484, 5485);
INSERT INTO `base_region` VALUES ('1272003', '广汉', '四川-德阳-广汉', 1272003, '1272001', 1, NULL, '2018-03-30 12:00:00', 1, 5486, 5487);
INSERT INTO `base_region` VALUES ('1272004', '什邡', '四川-德阳-什邡', 1272004, '1272001', 1, NULL, '2018-03-30 12:00:00', 1, 5488, 5489);
INSERT INTO `base_region` VALUES ('1272005', '绵竹', '四川-德阳-绵竹', 1272005, '1272001', 1, NULL, '2018-03-30 12:00:00', 1, 5490, 5491);
INSERT INTO `base_region` VALUES ('1272006', '罗江', '四川-德阳-罗江', 1272006, '1272001', 1, NULL, '2018-03-30 12:00:00', 1, 5492, 5493);
INSERT INTO `base_region` VALUES ('1272007', '旌阳', '四川-德阳-旌阳', 1272007, '1272001', 1, NULL, '2018-03-30 12:00:00', 1, 5494, 5495);
INSERT INTO `base_region` VALUES ('1272101', '广元', '四川-广元', 1272101, '1270000', 0, NULL, '2018-03-30 12:00:00', 1, 5497, 5512);
INSERT INTO `base_region` VALUES ('1272102', '旺苍', '四川-广元-旺苍', 1272102, '1272101', 1, NULL, '2018-03-30 12:00:00', 1, 5498, 5499);
INSERT INTO `base_region` VALUES ('1272103', '青川', '四川-广元-青川', 1272103, '1272101', 1, NULL, '2018-03-30 12:00:00', 1, 5500, 5501);
INSERT INTO `base_region` VALUES ('1272104', '剑阁', '四川-广元-剑阁', 1272104, '1272101', 1, NULL, '2018-03-30 12:00:00', 1, 5502, 5503);
INSERT INTO `base_region` VALUES ('1272105', '苍溪', '四川-广元-苍溪', 1272105, '1272101', 1, NULL, '2018-03-30 12:00:00', 1, 5504, 5505);
INSERT INTO `base_region` VALUES ('1272106', '利州', '四川-广元-利州', 1272106, '1272101', 1, NULL, '2018-03-30 12:00:00', 1, 5506, 5507);
INSERT INTO `base_region` VALUES ('1272107', '昭化', '四川-广元-昭化', 1272107, '1272101', 1, NULL, '2018-03-30 12:00:00', 1, 5508, 5509);
INSERT INTO `base_region` VALUES ('1272108', '朝天', '四川-广元-朝天', 1272108, '1272101', 1, NULL, '2018-03-30 12:00:00', 1, 5510, 5511);
INSERT INTO `base_region` VALUES ('1280000', '广东', '广东', 1280000, 'ROOT', 0, NULL, '2018-03-30 12:00:00', 1, 5514, 5793);
INSERT INTO `base_region` VALUES ('1280101', '广州', '广东-广州', 1280101, '1280000', 0, NULL, '2018-03-30 12:00:00', 1, 5515, 5538);
INSERT INTO `base_region` VALUES ('1280102', '番禺', '广东-广州-番禺', 1280102, '1280101', 1, NULL, '2018-03-30 12:00:00', 1, 5516, 5517);
INSERT INTO `base_region` VALUES ('1280103', '从化', '广东-广州-从化', 1280103, '1280101', 1, NULL, '2018-03-30 12:00:00', 1, 5518, 5519);
INSERT INTO `base_region` VALUES ('1280104', '增城', '广东-广州-增城', 1280104, '1280101', 1, NULL, '2018-03-30 12:00:00', 1, 5520, 5521);
INSERT INTO `base_region` VALUES ('1280105', '花都', '广东-广州-花都', 1280105, '1280101', 1, NULL, '2018-03-30 12:00:00', 1, 5522, 5523);
INSERT INTO `base_region` VALUES ('1280106', '荔湾', '广东-广州-荔湾', 1280106, '1280101', 1, NULL, '2018-03-30 12:00:00', 1, 5524, 5525);
INSERT INTO `base_region` VALUES ('1280107', '越秀', '广东-广州-越秀', 1280107, '1280101', 1, NULL, '2018-03-30 12:00:00', 1, 5526, 5527);
INSERT INTO `base_region` VALUES ('1280108', '海珠', '广东-广州-海珠', 1280108, '1280101', 1, NULL, '2018-03-30 12:00:00', 1, 5528, 5529);
INSERT INTO `base_region` VALUES ('1280109', '天河', '广东-广州-天河', 1280109, '1280101', 1, NULL, '2018-03-30 12:00:00', 1, 5530, 5531);
INSERT INTO `base_region` VALUES ('1280110', '白云', '广东-广州-白云', 1280110, '1280101', 1, NULL, '2018-03-30 12:00:00', 1, 5532, 5533);
INSERT INTO `base_region` VALUES ('1280111', '黄埔', '广东-广州-黄埔', 1280111, '1280101', 1, NULL, '2018-03-30 12:00:00', 1, 5534, 5535);
INSERT INTO `base_region` VALUES ('1280112', '南沙', '广东-广州-南沙', 1280112, '1280101', 1, NULL, '2018-03-30 12:00:00', 1, 5536, 5537);
INSERT INTO `base_region` VALUES ('1280201', '韶关', '广东-韶关', 1280201, '1280000', 0, NULL, '2018-03-30 12:00:00', 1, 5539, 5560);
INSERT INTO `base_region` VALUES ('1280202', '乳源', '广东-韶关-乳源', 1280202, '1280201', 1, NULL, '2018-03-30 12:00:00', 1, 5540, 5541);
INSERT INTO `base_region` VALUES ('1280203', '始兴', '广东-韶关-始兴', 1280203, '1280201', 1, NULL, '2018-03-30 12:00:00', 1, 5542, 5543);
INSERT INTO `base_region` VALUES ('1280204', '翁源', '广东-韶关-翁源', 1280204, '1280201', 1, NULL, '2018-03-30 12:00:00', 1, 5544, 5545);
INSERT INTO `base_region` VALUES ('1280205', '乐昌', '广东-韶关-乐昌', 1280205, '1280201', 1, NULL, '2018-03-30 12:00:00', 1, 5546, 5547);
INSERT INTO `base_region` VALUES ('1280206', '仁化', '广东-韶关-仁化', 1280206, '1280201', 1, NULL, '2018-03-30 12:00:00', 1, 5548, 5549);
INSERT INTO `base_region` VALUES ('1280207', '南雄', '广东-韶关-南雄', 1280207, '1280201', 1, NULL, '2018-03-30 12:00:00', 1, 5550, 5551);
INSERT INTO `base_region` VALUES ('1280208', '新丰', '广东-韶关-新丰', 1280208, '1280201', 1, NULL, '2018-03-30 12:00:00', 1, 5552, 5553);
INSERT INTO `base_region` VALUES ('1280209', '曲江', '广东-韶关-曲江', 1280209, '1280201', 1, NULL, '2018-03-30 12:00:00', 1, 5554, 5555);
INSERT INTO `base_region` VALUES ('1280210', '浈江', '广东-韶关-浈江', 1280210, '1280201', 1, NULL, '2018-03-30 12:00:00', 1, 5556, 5557);
INSERT INTO `base_region` VALUES ('1280211', '武江', '广东-韶关-武江', 1280211, '1280201', 1, NULL, '2018-03-30 12:00:00', 1, 5558, 5559);
INSERT INTO `base_region` VALUES ('1280301', '惠州', '广东-惠州', 1280301, '1280000', 0, NULL, '2018-03-30 12:00:00', 1, 5561, 5572);
INSERT INTO `base_region` VALUES ('1280302', '博罗', '广东-惠州-博罗', 1280302, '1280301', 1, NULL, '2018-03-30 12:00:00', 1, 5562, 5563);
INSERT INTO `base_region` VALUES ('1280303', '惠阳', '广东-惠州-惠阳', 1280303, '1280301', 1, NULL, '2018-03-30 12:00:00', 1, 5564, 5565);
INSERT INTO `base_region` VALUES ('1280304', '惠东', '广东-惠州-惠东', 1280304, '1280301', 1, NULL, '2018-03-30 12:00:00', 1, 5566, 5567);
INSERT INTO `base_region` VALUES ('1280305', '龙门', '广东-惠州-龙门', 1280305, '1280301', 1, NULL, '2018-03-30 12:00:00', 1, 5568, 5569);
INSERT INTO `base_region` VALUES ('1280306', '惠城', '广东-惠州-惠城', 1280306, '1280301', 1, NULL, '2018-03-30 12:00:00', 1, 5570, 5571);
INSERT INTO `base_region` VALUES ('1280401', '梅州', '广东-梅州', 1280401, '1280000', 0, NULL, '2018-03-30 12:00:00', 1, 5573, 5590);
INSERT INTO `base_region` VALUES ('1280402', '兴宁', '广东-梅州-兴宁', 1280402, '1280401', 1, NULL, '2018-03-30 12:00:00', 1, 5574, 5575);
INSERT INTO `base_region` VALUES ('1280403', '蕉岭', '广东-梅州-蕉岭', 1280403, '1280401', 1, NULL, '2018-03-30 12:00:00', 1, 5576, 5577);
INSERT INTO `base_region` VALUES ('1280404', '大埔', '广东-梅州-大埔', 1280404, '1280401', 1, NULL, '2018-03-30 12:00:00', 1, 5578, 5579);
INSERT INTO `base_region` VALUES ('1280405', '梅江', '广东-梅州-梅江', 1280405, '1280401', 1, NULL, '2018-03-30 12:00:00', 1, 5580, 5581);
INSERT INTO `base_region` VALUES ('1280406', '丰顺', '广东-梅州-丰顺', 1280406, '1280401', 1, NULL, '2018-03-30 12:00:00', 1, 5582, 5583);
INSERT INTO `base_region` VALUES ('1280407', '平远', '广东-梅州-平远', 1280407, '1280401', 1, NULL, '2018-03-30 12:00:00', 1, 5584, 5585);
INSERT INTO `base_region` VALUES ('1280408', '五华', '广东-梅州-五华', 1280408, '1280401', 1, NULL, '2018-03-30 12:00:00', 1, 5586, 5587);
INSERT INTO `base_region` VALUES ('1280409', '梅县', '广东-梅州-梅县', 1280409, '1280401', 1, NULL, '2018-03-30 12:00:00', 1, 5588, 5589);
INSERT INTO `base_region` VALUES ('1280501', '汕头', '广东-汕头', 1280501, '1280000', 0, NULL, '2018-03-30 12:00:00', 1, 5591, 5606);
INSERT INTO `base_region` VALUES ('1280502', '潮阳', '广东-汕头-潮阳', 1280502, '1280501', 1, NULL, '2018-03-30 12:00:00', 1, 5592, 5593);
INSERT INTO `base_region` VALUES ('1280503', '澄海', '广东-汕头-澄海', 1280503, '1280501', 1, NULL, '2018-03-30 12:00:00', 1, 5594, 5595);
INSERT INTO `base_region` VALUES ('1280504', '南澳', '广东-汕头-南澳', 1280504, '1280501', 1, NULL, '2018-03-30 12:00:00', 1, 5596, 5597);
INSERT INTO `base_region` VALUES ('1280505', '龙湖', '广东-汕头-龙湖', 1280505, '1280501', 1, NULL, '2018-03-30 12:00:00', 1, 5598, 5599);
INSERT INTO `base_region` VALUES ('1280506', '金平', '广东-汕头-金平', 1280506, '1280501', 1, NULL, '2018-03-30 12:00:00', 1, 5600, 5601);
INSERT INTO `base_region` VALUES ('1280507', '濠江', '广东-汕头-濠江', 1280507, '1280501', 1, NULL, '2018-03-30 12:00:00', 1, 5602, 5603);
INSERT INTO `base_region` VALUES ('1280508', '潮南', '广东-汕头-潮南', 1280508, '1280501', 1, NULL, '2018-03-30 12:00:00', 1, 5604, 5605);
INSERT INTO `base_region` VALUES ('1280601', '深圳', '广东-深圳', 1280601, '1280000', 0, NULL, '2018-03-30 12:00:00', 1, 5607, 5620);
INSERT INTO `base_region` VALUES ('1280602', '罗湖', '广东-深圳-罗湖', 1280602, '1280601', 1, NULL, '2018-03-30 12:00:00', 1, 5608, 5609);
INSERT INTO `base_region` VALUES ('1280603', '福田', '广东-深圳-福田', 1280603, '1280601', 1, NULL, '2018-03-30 12:00:00', 1, 5610, 5611);
INSERT INTO `base_region` VALUES ('1280604', '南山', '广东-深圳-南山', 1280604, '1280601', 1, NULL, '2018-03-30 12:00:00', 1, 5612, 5613);
INSERT INTO `base_region` VALUES ('1280605', '宝安', '广东-深圳-宝安', 1280605, '1280601', 1, NULL, '2018-03-30 12:00:00', 1, 5614, 5615);
INSERT INTO `base_region` VALUES ('1280606', '龙岗', '广东-深圳-龙岗', 1280606, '1280601', 1, NULL, '2018-03-30 12:00:00', 1, 5616, 5617);
INSERT INTO `base_region` VALUES ('1280607', '盐田', '广东-深圳-盐田', 1280607, '1280601', 1, NULL, '2018-03-30 12:00:00', 1, 5618, 5619);
INSERT INTO `base_region` VALUES ('1280701', '珠海', '广东-珠海', 1280701, '1280000', 0, NULL, '2018-03-30 12:00:00', 1, 5621, 5628);
INSERT INTO `base_region` VALUES ('1280702', '斗门', '广东-珠海-斗门', 1280702, '1280701', 1, NULL, '2018-03-30 12:00:00', 1, 5622, 5623);
INSERT INTO `base_region` VALUES ('1280703', '金湾', '广东-珠海-金湾', 1280703, '1280701', 1, NULL, '2018-03-30 12:00:00', 1, 5624, 5625);
INSERT INTO `base_region` VALUES ('1280704', '香洲', '广东-珠海-香洲', 1280704, '1280701', 1, NULL, '2018-03-30 12:00:00', 1, 5626, 5627);
INSERT INTO `base_region` VALUES ('1280800', '佛山', '广东-佛山', 1280800, '1280000', 0, NULL, '2018-03-30 12:00:00', 1, 5629, 5640);
INSERT INTO `base_region` VALUES ('1280801', '顺德', '广东-佛山-顺德', 1280801, '1280800', 1, NULL, '2018-03-30 12:00:00', 1, 5630, 5631);
INSERT INTO `base_region` VALUES ('1280802', '三水', '广东-佛山-三水', 1280802, '1280800', 1, NULL, '2018-03-30 12:00:00', 1, 5632, 5633);
INSERT INTO `base_region` VALUES ('1280803', '南海', '广东-佛山-南海', 1280803, '1280800', 1, NULL, '2018-03-30 12:00:00', 1, 5634, 5635);
INSERT INTO `base_region` VALUES ('1280804', '高明', '广东-佛山-高明', 1280804, '1280800', 1, NULL, '2018-03-30 12:00:00', 1, 5636, 5637);
INSERT INTO `base_region` VALUES ('1280805', '禅城', '广东-佛山-禅城', 1280805, '1280800', 1, NULL, '2018-03-30 12:00:00', 1, 5638, 5639);
INSERT INTO `base_region` VALUES ('1280901', '肇庆', '广东-肇庆', 1280901, '1280000', 0, NULL, '2018-03-30 12:00:00', 1, 5641, 5658);
INSERT INTO `base_region` VALUES ('1280902', '广宁', '广东-肇庆-广宁', 1280902, '1280901', 1, NULL, '2018-03-30 12:00:00', 1, 5642, 5643);
INSERT INTO `base_region` VALUES ('1280903', '四会', '广东-肇庆-四会', 1280903, '1280901', 1, NULL, '2018-03-30 12:00:00', 1, 5644, 5645);
INSERT INTO `base_region` VALUES ('1280904', '端州', '广东-肇庆-端州', 1280904, '1280901', 1, NULL, '2018-03-30 12:00:00', 1, 5646, 5647);
INSERT INTO `base_region` VALUES ('1280905', '德庆', '广东-肇庆-德庆', 1280905, '1280901', 1, NULL, '2018-03-30 12:00:00', 1, 5648, 5649);
INSERT INTO `base_region` VALUES ('1280906', '怀集', '广东-肇庆-怀集', 1280906, '1280901', 1, NULL, '2018-03-30 12:00:00', 1, 5650, 5651);
INSERT INTO `base_region` VALUES ('1280907', '封开', '广东-肇庆-封开', 1280907, '1280901', 1, NULL, '2018-03-30 12:00:00', 1, 5652, 5653);
INSERT INTO `base_region` VALUES ('1280908', '高要', '广东-肇庆-高要', 1280908, '1280901', 1, NULL, '2018-03-30 12:00:00', 1, 5654, 5655);
INSERT INTO `base_region` VALUES ('1280909', '鼎湖', '广东-肇庆-鼎湖', 1280909, '1280901', 1, NULL, '2018-03-30 12:00:00', 1, 5656, 5657);
INSERT INTO `base_region` VALUES ('1281001', '湛江', '广东-湛江', 1281001, '1280000', 0, NULL, '2018-03-30 12:00:00', 1, 5659, 5678);
INSERT INTO `base_region` VALUES ('1281002', '吴川', '广东-湛江-吴川', 1281002, '1281001', 1, NULL, '2018-03-30 12:00:00', 1, 5660, 5661);
INSERT INTO `base_region` VALUES ('1281003', '雷州', '广东-湛江-雷州', 1281003, '1281001', 1, NULL, '2018-03-30 12:00:00', 1, 5662, 5663);
INSERT INTO `base_region` VALUES ('1281004', '徐闻', '广东-湛江-徐闻', 1281004, '1281001', 1, NULL, '2018-03-30 12:00:00', 1, 5664, 5665);
INSERT INTO `base_region` VALUES ('1281005', '廉江', '广东-湛江-廉江', 1281005, '1281001', 1, NULL, '2018-03-30 12:00:00', 1, 5666, 5667);
INSERT INTO `base_region` VALUES ('1281006', '赤坎', '广东-湛江-赤坎', 1281006, '1281001', 1, NULL, '2018-03-30 12:00:00', 1, 5668, 5669);
INSERT INTO `base_region` VALUES ('1281007', '遂溪', '广东-湛江-遂溪', 1281007, '1281001', 1, NULL, '2018-03-30 12:00:00', 1, 5670, 5671);
INSERT INTO `base_region` VALUES ('1281008', '坡头', '广东-湛江-坡头', 1281008, '1281001', 1, NULL, '2018-03-30 12:00:00', 1, 5672, 5673);
INSERT INTO `base_region` VALUES ('1281009', '霞山', '广东-湛江-霞山', 1281009, '1281001', 1, NULL, '2018-03-30 12:00:00', 1, 5674, 5675);
INSERT INTO `base_region` VALUES ('1281010', '麻章', '广东-湛江-麻章', 1281010, '1281001', 1, NULL, '2018-03-30 12:00:00', 1, 5676, 5677);
INSERT INTO `base_region` VALUES ('1281101', '江门', '广东-江门', 1281101, '1280000', 0, NULL, '2018-03-30 12:00:00', 1, 5679, 5694);
INSERT INTO `base_region` VALUES ('1281103', '开平', '广东-江门-开平', 1281103, '1281101', 1, NULL, '2018-03-30 12:00:00', 1, 5680, 5681);
INSERT INTO `base_region` VALUES ('1281104', '新会', '广东-江门-新会', 1281104, '1281101', 1, NULL, '2018-03-30 12:00:00', 1, 5682, 5683);
INSERT INTO `base_region` VALUES ('1281105', '恩平', '广东-江门-恩平', 1281105, '1281101', 1, NULL, '2018-03-30 12:00:00', 1, 5684, 5685);
INSERT INTO `base_region` VALUES ('1281106', '台山', '广东-江门-台山', 1281106, '1281101', 1, NULL, '2018-03-30 12:00:00', 1, 5686, 5687);
INSERT INTO `base_region` VALUES ('1281107', '蓬江', '广东-江门-蓬江', 1281107, '1281101', 1, NULL, '2018-03-30 12:00:00', 1, 5688, 5689);
INSERT INTO `base_region` VALUES ('1281108', '鹤山', '广东-江门-鹤山', 1281108, '1281101', 1, NULL, '2018-03-30 12:00:00', 1, 5690, 5691);
INSERT INTO `base_region` VALUES ('1281109', '江海', '广东-江门-江海', 1281109, '1281101', 1, NULL, '2018-03-30 12:00:00', 1, 5692, 5693);
INSERT INTO `base_region` VALUES ('1281201', '河源', '广东-河源', 1281201, '1280000', 0, NULL, '2018-03-30 12:00:00', 1, 5695, 5708);
INSERT INTO `base_region` VALUES ('1281202', '紫金', '广东-河源-紫金', 1281202, '1281201', 1, NULL, '2018-03-30 12:00:00', 1, 5696, 5697);
INSERT INTO `base_region` VALUES ('1281203', '连平', '广东-河源-连平', 1281203, '1281201', 1, NULL, '2018-03-30 12:00:00', 1, 5698, 5699);
INSERT INTO `base_region` VALUES ('1281204', '和平', '广东-河源-和平', 1281204, '1281201', 1, NULL, '2018-03-30 12:00:00', 1, 5700, 5701);
INSERT INTO `base_region` VALUES ('1281205', '龙川', '广东-河源-龙川', 1281205, '1281201', 1, NULL, '2018-03-30 12:00:00', 1, 5702, 5703);
INSERT INTO `base_region` VALUES ('1281206', '东源', '广东-河源-东源', 1281206, '1281201', 1, NULL, '2018-03-30 12:00:00', 1, 5704, 5705);
INSERT INTO `base_region` VALUES ('1281207', '源城', '广东-河源-源城', 1281207, '1281201', 1, NULL, '2018-03-30 12:00:00', 1, 5706, 5707);
INSERT INTO `base_region` VALUES ('1281301', '清远', '广东-清远', 1281301, '1280000', 0, NULL, '2018-03-30 12:00:00', 1, 5709, 5726);
INSERT INTO `base_region` VALUES ('1281302', '连南', '广东-清远-连南', 1281302, '1281301', 1, NULL, '2018-03-30 12:00:00', 1, 5710, 5711);
INSERT INTO `base_region` VALUES ('1281303', '连州', '广东-清远-连州', 1281303, '1281301', 1, NULL, '2018-03-30 12:00:00', 1, 5712, 5713);
INSERT INTO `base_region` VALUES ('1281304', '连山', '广东-清远-连山', 1281304, '1281301', 1, NULL, '2018-03-30 12:00:00', 1, 5714, 5715);
INSERT INTO `base_region` VALUES ('1281305', '阳山', '广东-清远-阳山', 1281305, '1281301', 1, NULL, '2018-03-30 12:00:00', 1, 5716, 5717);
INSERT INTO `base_region` VALUES ('1281306', '佛冈', '广东-清远-佛冈', 1281306, '1281301', 1, NULL, '2018-03-30 12:00:00', 1, 5718, 5719);
INSERT INTO `base_region` VALUES ('1281307', '英德', '广东-清远-英德', 1281307, '1281301', 1, NULL, '2018-03-30 12:00:00', 1, 5720, 5721);
INSERT INTO `base_region` VALUES ('1281308', '清新', '广东-清远-清新', 1281308, '1281301', 1, NULL, '2018-03-30 12:00:00', 1, 5722, 5723);
INSERT INTO `base_region` VALUES ('1281309', '清城', '广东-清远-清城', 1281309, '1281301', 1, NULL, '2018-03-30 12:00:00', 1, 5724, 5725);
INSERT INTO `base_region` VALUES ('1281401', '云浮', '广东-云浮', 1281401, '1280000', 0, NULL, '2018-03-30 12:00:00', 1, 5727, 5738);
INSERT INTO `base_region` VALUES ('1281402', '罗定', '广东-云浮-罗定', 1281402, '1281401', 1, NULL, '2018-03-30 12:00:00', 1, 5728, 5729);
INSERT INTO `base_region` VALUES ('1281403', '新兴', '广东-云浮-新兴', 1281403, '1281401', 1, NULL, '2018-03-30 12:00:00', 1, 5730, 5731);
INSERT INTO `base_region` VALUES ('1281404', '郁南', '广东-云浮-郁南', 1281404, '1281401', 1, NULL, '2018-03-30 12:00:00', 1, 5732, 5733);
INSERT INTO `base_region` VALUES ('1281405', '云城', '广东-云浮-云城', 1281405, '1281401', 1, NULL, '2018-03-30 12:00:00', 1, 5734, 5735);
INSERT INTO `base_region` VALUES ('1281406', '云安', '广东-云浮-云安', 1281406, '1281401', 1, NULL, '2018-03-30 12:00:00', 1, 5736, 5737);
INSERT INTO `base_region` VALUES ('1281501', '潮州', '广东-潮州', 1281501, '1280000', 0, NULL, '2018-03-30 12:00:00', 1, 5739, 5746);
INSERT INTO `base_region` VALUES ('1281502', '饶平', '广东-潮州-饶平', 1281502, '1281501', 1, NULL, '2018-03-30 12:00:00', 1, 5740, 5741);
INSERT INTO `base_region` VALUES ('1281503', '潮安', '广东-潮州-潮安', 1281503, '1281501', 1, NULL, '2018-03-30 12:00:00', 1, 5742, 5743);
INSERT INTO `base_region` VALUES ('1281504', '湘桥', '广东-潮州-湘桥', 1281504, '1281501', 1, NULL, '2018-03-30 12:00:00', 1, 5744, 5745);
INSERT INTO `base_region` VALUES ('1281601', '东莞', '广东-东莞', 1281601, '1280000', 0, NULL, '2018-03-30 12:00:00', 1, 5747, 5748);
INSERT INTO `base_region` VALUES ('1281701', '中山', '广东-中山', 1281701, '1280000', 0, NULL, '2018-03-30 12:00:00', 1, 5749, 5750);
INSERT INTO `base_region` VALUES ('1281801', '阳江', '广东-阳江', 1281801, '1280000', 0, NULL, '2018-03-30 12:00:00', 1, 5751, 5760);
INSERT INTO `base_region` VALUES ('1281802', '阳春', '广东-阳江-阳春', 1281802, '1281801', 1, NULL, '2018-03-30 12:00:00', 1, 5752, 5753);
INSERT INTO `base_region` VALUES ('1281803', '阳东', '广东-阳江-阳东', 1281803, '1281801', 1, NULL, '2018-03-30 12:00:00', 1, 5754, 5755);
INSERT INTO `base_region` VALUES ('1281804', '阳西', '广东-阳江-阳西', 1281804, '1281801', 1, NULL, '2018-03-30 12:00:00', 1, 5756, 5757);
INSERT INTO `base_region` VALUES ('1281805', '江城', '广东-阳江-江城', 1281805, '1281801', 1, NULL, '2018-03-30 12:00:00', 1, 5758, 5759);
INSERT INTO `base_region` VALUES ('1281901', '揭阳', '广东-揭阳', 1281901, '1280000', 0, NULL, '2018-03-30 12:00:00', 1, 5761, 5772);
INSERT INTO `base_region` VALUES ('1281902', '揭西', '广东-揭阳-揭西', 1281902, '1281901', 1, NULL, '2018-03-30 12:00:00', 1, 5762, 5763);
INSERT INTO `base_region` VALUES ('1281903', '普宁', '广东-揭阳-普宁', 1281903, '1281901', 1, NULL, '2018-03-30 12:00:00', 1, 5764, 5765);
INSERT INTO `base_region` VALUES ('1281904', '惠来', '广东-揭阳-惠来', 1281904, '1281901', 1, NULL, '2018-03-30 12:00:00', 1, 5766, 5767);
INSERT INTO `base_region` VALUES ('1281905', '揭东', '广东-揭阳-揭东', 1281905, '1281901', 1, NULL, '2018-03-30 12:00:00', 1, 5768, 5769);
INSERT INTO `base_region` VALUES ('1281906', '榕城', '广东-揭阳-榕城', 1281906, '1281901', 1, NULL, '2018-03-30 12:00:00', 1, 5770, 5771);
INSERT INTO `base_region` VALUES ('1282001', '茂名', '广东-茂名', 1282001, '1280000', 0, NULL, '2018-03-30 12:00:00', 1, 5773, 5784);
INSERT INTO `base_region` VALUES ('1282002', '高州', '广东-茂名-高州', 1282002, '1282001', 1, NULL, '2018-03-30 12:00:00', 1, 5774, 5775);
INSERT INTO `base_region` VALUES ('1282003', '化州', '广东-茂名-化州', 1282003, '1282001', 1, NULL, '2018-03-30 12:00:00', 1, 5776, 5777);
INSERT INTO `base_region` VALUES ('1282004', '电白', '广东-茂名-电白', 1282004, '1282001', 1, NULL, '2018-03-30 12:00:00', 1, 5778, 5779);
INSERT INTO `base_region` VALUES ('1282005', '信宜', '广东-茂名-信宜', 1282005, '1282001', 1, NULL, '2018-03-30 12:00:00', 1, 5780, 5781);
INSERT INTO `base_region` VALUES ('1282007', '茂南', '广东-茂名-茂南', 1282007, '1282001', 1, NULL, '2018-03-30 12:00:00', 1, 5782, 5783);
INSERT INTO `base_region` VALUES ('1282101', '汕尾', '广东-汕尾', 1282101, '1280000', 0, NULL, '2018-03-30 12:00:00', 1, 5785, 5792);
INSERT INTO `base_region` VALUES ('1282102', '海丰', '广东-汕尾-海丰', 1282102, '1282101', 1, NULL, '2018-03-30 12:00:00', 1, 5786, 5787);
INSERT INTO `base_region` VALUES ('1282103', '陆丰', '广东-汕尾-陆丰', 1282103, '1282101', 1, NULL, '2018-03-30 12:00:00', 1, 5788, 5789);
INSERT INTO `base_region` VALUES ('1282104', '陆河', '广东-汕尾-陆河', 1282104, '1282101', 1, NULL, '2018-03-30 12:00:00', 1, 5790, 5791);
INSERT INTO `base_region` VALUES ('1290000', '云南', '云南', 1290000, 'ROOT', 0, NULL, '2018-03-30 12:00:00', 1, 5794, 6077);
INSERT INTO `base_region` VALUES ('1290101', '昆明', '云南-昆明', 1290101, '1290000', 0, NULL, '2018-03-30 12:00:00', 1, 5795, 5824);
INSERT INTO `base_region` VALUES ('1290102', '五华', '云南-昆明-五华', 1290102, '1290101', 1, NULL, '2018-03-30 12:00:00', 1, 5796, 5797);
INSERT INTO `base_region` VALUES ('1290103', '东川', '云南-昆明-东川', 1290103, '1290101', 1, NULL, '2018-03-30 12:00:00', 1, 5798, 5799);
INSERT INTO `base_region` VALUES ('1290104', '寻甸', '云南-昆明-寻甸', 1290104, '1290101', 1, NULL, '2018-03-30 12:00:00', 1, 5800, 5801);
INSERT INTO `base_region` VALUES ('1290105', '晋宁', '云南-昆明-晋宁', 1290105, '1290101', 1, NULL, '2018-03-30 12:00:00', 1, 5802, 5803);
INSERT INTO `base_region` VALUES ('1290106', '宜良', '云南-昆明-宜良', 1290106, '1290101', 1, NULL, '2018-03-30 12:00:00', 1, 5804, 5805);
INSERT INTO `base_region` VALUES ('1290107', '石林', '云南-昆明-石林', 1290107, '1290101', 1, NULL, '2018-03-30 12:00:00', 1, 5806, 5807);
INSERT INTO `base_region` VALUES ('1290108', '呈贡', '云南-昆明-呈贡', 1290108, '1290101', 1, NULL, '2018-03-30 12:00:00', 1, 5808, 5809);
INSERT INTO `base_region` VALUES ('1290109', '富民', '云南-昆明-富民', 1290109, '1290101', 1, NULL, '2018-03-30 12:00:00', 1, 5810, 5811);
INSERT INTO `base_region` VALUES ('1290110', '嵩明', '云南-昆明-嵩明', 1290110, '1290101', 1, NULL, '2018-03-30 12:00:00', 1, 5812, 5813);
INSERT INTO `base_region` VALUES ('1290111', '禄劝', '云南-昆明-禄劝', 1290111, '1290101', 1, NULL, '2018-03-30 12:00:00', 1, 5814, 5815);
INSERT INTO `base_region` VALUES ('1290112', '安宁', '云南-昆明-安宁', 1290112, '1290101', 1, NULL, '2018-03-30 12:00:00', 1, 5816, 5817);
INSERT INTO `base_region` VALUES ('1290114', '盘龙', '云南-昆明-盘龙', 1290114, '1290101', 1, NULL, '2018-03-30 12:00:00', 1, 5818, 5819);
INSERT INTO `base_region` VALUES ('1290115', '官渡', '云南-昆明-官渡', 1290115, '1290101', 1, NULL, '2018-03-30 12:00:00', 1, 5820, 5821);
INSERT INTO `base_region` VALUES ('1290116', '西山', '云南-昆明-西山', 1290116, '1290101', 1, NULL, '2018-03-30 12:00:00', 1, 5822, 5823);
INSERT INTO `base_region` VALUES ('1290201', '大理', '云南-大理', 1290201, '1290000', 0, NULL, '2018-03-30 12:00:00', 1, 5825, 5848);
INSERT INTO `base_region` VALUES ('1290202', '云龙', '云南-大理-云龙', 1290202, '1290201', 1, NULL, '2018-03-30 12:00:00', 1, 5826, 5827);
INSERT INTO `base_region` VALUES ('1290203', '漾濞', '云南-大理-漾濞', 1290203, '1290201', 1, NULL, '2018-03-30 12:00:00', 1, 5828, 5829);
INSERT INTO `base_region` VALUES ('1290204', '永平', '云南-大理-永平', 1290204, '1290201', 1, NULL, '2018-03-30 12:00:00', 1, 5830, 5831);
INSERT INTO `base_region` VALUES ('1290205', '宾川', '云南-大理-宾川', 1290205, '1290201', 1, NULL, '2018-03-30 12:00:00', 1, 5832, 5833);
INSERT INTO `base_region` VALUES ('1290206', '弥渡', '云南-大理-弥渡', 1290206, '1290201', 1, NULL, '2018-03-30 12:00:00', 1, 5834, 5835);
INSERT INTO `base_region` VALUES ('1290207', '祥云', '云南-大理-祥云', 1290207, '1290201', 1, NULL, '2018-03-30 12:00:00', 1, 5836, 5837);
INSERT INTO `base_region` VALUES ('1290208', '巍山', '云南-大理-巍山', 1290208, '1290201', 1, NULL, '2018-03-30 12:00:00', 1, 5838, 5839);
INSERT INTO `base_region` VALUES ('1290209', '剑川', '云南-大理-剑川', 1290209, '1290201', 1, NULL, '2018-03-30 12:00:00', 1, 5840, 5841);
INSERT INTO `base_region` VALUES ('1290210', '洱源', '云南-大理-洱源', 1290210, '1290201', 1, NULL, '2018-03-30 12:00:00', 1, 5842, 5843);
INSERT INTO `base_region` VALUES ('1290211', '鹤庆', '云南-大理-鹤庆', 1290211, '1290201', 1, NULL, '2018-03-30 12:00:00', 1, 5844, 5845);
INSERT INTO `base_region` VALUES ('1290212', '南涧', '云南-大理-南涧', 1290212, '1290201', 1, NULL, '2018-03-30 12:00:00', 1, 5846, 5847);
INSERT INTO `base_region` VALUES ('1290301', '红河', '云南-红河', 1290301, '1290000', 0, NULL, '2018-03-30 12:00:00', 1, 5849, 5874);
INSERT INTO `base_region` VALUES ('1290302', '石屏', '云南-红河-石屏', 1290302, '1290301', 1, NULL, '2018-03-30 12:00:00', 1, 5850, 5851);
INSERT INTO `base_region` VALUES ('1290303', '建水', '云南-红河-建水', 1290303, '1290301', 1, NULL, '2018-03-30 12:00:00', 1, 5852, 5853);
INSERT INTO `base_region` VALUES ('1290304', '弥勒', '云南-红河-弥勒', 1290304, '1290301', 1, NULL, '2018-03-30 12:00:00', 1, 5854, 5855);
INSERT INTO `base_region` VALUES ('1290305', '元阳', '云南-红河-元阳', 1290305, '1290301', 1, NULL, '2018-03-30 12:00:00', 1, 5856, 5857);
INSERT INTO `base_region` VALUES ('1290306', '绿春', '云南-红河-绿春', 1290306, '1290301', 1, NULL, '2018-03-30 12:00:00', 1, 5858, 5859);
INSERT INTO `base_region` VALUES ('1290307', '开远', '云南-红河-开远', 1290307, '1290301', 1, NULL, '2018-03-30 12:00:00', 1, 5860, 5861);
INSERT INTO `base_region` VALUES ('1290308', '个旧', '云南-红河-个旧', 1290308, '1290301', 1, NULL, '2018-03-30 12:00:00', 1, 5862, 5863);
INSERT INTO `base_region` VALUES ('1290309', '蒙自', '云南-红河-蒙自', 1290309, '1290301', 1, NULL, '2018-03-30 12:00:00', 1, 5864, 5865);
INSERT INTO `base_region` VALUES ('1290310', '屏边', '云南-红河-屏边', 1290310, '1290301', 1, NULL, '2018-03-30 12:00:00', 1, 5866, 5867);
INSERT INTO `base_region` VALUES ('1290311', '泸西', '云南-红河-泸西', 1290311, '1290301', 1, NULL, '2018-03-30 12:00:00', 1, 5868, 5869);
INSERT INTO `base_region` VALUES ('1290312', '金平', '云南-红河-金平', 1290312, '1290301', 1, NULL, '2018-03-30 12:00:00', 1, 5870, 5871);
INSERT INTO `base_region` VALUES ('1290313', '河口', '云南-红河-河口', 1290313, '1290301', 1, NULL, '2018-03-30 12:00:00', 1, 5872, 5873);
INSERT INTO `base_region` VALUES ('1290401', '曲靖', '云南-曲靖', 1290401, '1290000', 0, NULL, '2018-03-30 12:00:00', 1, 5875, 5894);
INSERT INTO `base_region` VALUES ('1290402', '沾益', '云南-曲靖-沾益', 1290402, '1290401', 1, NULL, '2018-03-30 12:00:00', 1, 5876, 5877);
INSERT INTO `base_region` VALUES ('1290403', '陆良', '云南-曲靖-陆良', 1290403, '1290401', 1, NULL, '2018-03-30 12:00:00', 1, 5878, 5879);
INSERT INTO `base_region` VALUES ('1290404', '富源', '云南-曲靖-富源', 1290404, '1290401', 1, NULL, '2018-03-30 12:00:00', 1, 5880, 5881);
INSERT INTO `base_region` VALUES ('1290405', '马龙', '云南-曲靖-马龙', 1290405, '1290401', 1, NULL, '2018-03-30 12:00:00', 1, 5882, 5883);
INSERT INTO `base_region` VALUES ('1290406', '师宗', '云南-曲靖-师宗', 1290406, '1290401', 1, NULL, '2018-03-30 12:00:00', 1, 5884, 5885);
INSERT INTO `base_region` VALUES ('1290407', '罗平', '云南-曲靖-罗平', 1290407, '1290401', 1, NULL, '2018-03-30 12:00:00', 1, 5886, 5887);
INSERT INTO `base_region` VALUES ('1290408', '会泽', '云南-曲靖-会泽', 1290408, '1290401', 1, NULL, '2018-03-30 12:00:00', 1, 5888, 5889);
INSERT INTO `base_region` VALUES ('1290409', '宣威', '云南-曲靖-宣威', 1290409, '1290401', 1, NULL, '2018-03-30 12:00:00', 1, 5890, 5891);
INSERT INTO `base_region` VALUES ('1290410', '麒麟', '云南-曲靖-麒麟', 1290410, '1290401', 1, NULL, '2018-03-30 12:00:00', 1, 5892, 5893);
INSERT INTO `base_region` VALUES ('1290501', '保山', '云南-保山', 1290501, '1290000', 0, NULL, '2018-03-30 12:00:00', 1, 5895, 5906);
INSERT INTO `base_region` VALUES ('1290502', '隆阳', '云南-保山-隆阳', 1290502, '1290501', 1, NULL, '2018-03-30 12:00:00', 1, 5896, 5897);
INSERT INTO `base_region` VALUES ('1290503', '龙陵', '云南-保山-龙陵', 1290503, '1290501', 1, NULL, '2018-03-30 12:00:00', 1, 5898, 5899);
INSERT INTO `base_region` VALUES ('1290504', '施甸', '云南-保山-施甸', 1290504, '1290501', 1, NULL, '2018-03-30 12:00:00', 1, 5900, 5901);
INSERT INTO `base_region` VALUES ('1290505', '昌宁', '云南-保山-昌宁', 1290505, '1290501', 1, NULL, '2018-03-30 12:00:00', 1, 5902, 5903);
INSERT INTO `base_region` VALUES ('1290506', '腾冲', '云南-保山-腾冲', 1290506, '1290501', 1, NULL, '2018-03-30 12:00:00', 1, 5904, 5905);
INSERT INTO `base_region` VALUES ('1290601', '文山', '云南-文山', 1290601, '1290000', 0, NULL, '2018-03-30 12:00:00', 1, 5907, 5922);
INSERT INTO `base_region` VALUES ('1290602', '西畴', '云南-文山-西畴', 1290602, '1290601', 1, NULL, '2018-03-30 12:00:00', 1, 5908, 5909);
INSERT INTO `base_region` VALUES ('1290603', '马关', '云南-文山-马关', 1290603, '1290601', 1, NULL, '2018-03-30 12:00:00', 1, 5910, 5911);
INSERT INTO `base_region` VALUES ('1290604', '麻栗坡', '云南-文山-麻栗坡', 1290604, '1290601', 1, NULL, '2018-03-30 12:00:00', 1, 5912, 5913);
INSERT INTO `base_region` VALUES ('1290605', '砚山', '云南-文山-砚山', 1290605, '1290601', 1, NULL, '2018-03-30 12:00:00', 1, 5914, 5915);
INSERT INTO `base_region` VALUES ('1290606', '丘北', '云南-文山-丘北', 1290606, '1290601', 1, NULL, '2018-03-30 12:00:00', 1, 5916, 5917);
INSERT INTO `base_region` VALUES ('1290607', '广南', '云南-文山-广南', 1290607, '1290601', 1, NULL, '2018-03-30 12:00:00', 1, 5918, 5919);
INSERT INTO `base_region` VALUES ('1290608', '富宁', '云南-文山-富宁', 1290608, '1290601', 1, NULL, '2018-03-30 12:00:00', 1, 5920, 5921);
INSERT INTO `base_region` VALUES ('1290701', '玉溪', '云南-玉溪', 1290701, '1290000', 0, NULL, '2018-03-30 12:00:00', 1, 5923, 5942);
INSERT INTO `base_region` VALUES ('1290702', '澄江', '云南-玉溪-澄江', 1290702, '1290701', 1, NULL, '2018-03-30 12:00:00', 1, 5924, 5925);
INSERT INTO `base_region` VALUES ('1290703', '江川', '云南-玉溪-江川', 1290703, '1290701', 1, NULL, '2018-03-30 12:00:00', 1, 5926, 5927);
INSERT INTO `base_region` VALUES ('1290704', '通海', '云南-玉溪-通海', 1290704, '1290701', 1, NULL, '2018-03-30 12:00:00', 1, 5928, 5929);
INSERT INTO `base_region` VALUES ('1290705', '华宁', '云南-玉溪-华宁', 1290705, '1290701', 1, NULL, '2018-03-30 12:00:00', 1, 5930, 5931);
INSERT INTO `base_region` VALUES ('1290706', '新平', '云南-玉溪-新平', 1290706, '1290701', 1, NULL, '2018-03-30 12:00:00', 1, 5932, 5933);
INSERT INTO `base_region` VALUES ('1290707', '易门', '云南-玉溪-易门', 1290707, '1290701', 1, NULL, '2018-03-30 12:00:00', 1, 5934, 5935);
INSERT INTO `base_region` VALUES ('1290708', '峨山', '云南-玉溪-峨山', 1290708, '1290701', 1, NULL, '2018-03-30 12:00:00', 1, 5936, 5937);
INSERT INTO `base_region` VALUES ('1290709', '元江', '云南-玉溪-元江', 1290709, '1290701', 1, NULL, '2018-03-30 12:00:00', 1, 5938, 5939);
INSERT INTO `base_region` VALUES ('1290710', '红塔', '云南-玉溪-红塔', 1290710, '1290701', 1, NULL, '2018-03-30 12:00:00', 1, 5940, 5941);
INSERT INTO `base_region` VALUES ('1290801', '楚雄', '云南-楚雄', 1290801, '1290000', 0, NULL, '2018-03-30 12:00:00', 1, 5943, 5962);
INSERT INTO `base_region` VALUES ('1290802', '大姚', '云南-楚雄-大姚', 1290802, '1290801', 1, NULL, '2018-03-30 12:00:00', 1, 5944, 5945);
INSERT INTO `base_region` VALUES ('1290803', '元谋', '云南-楚雄-元谋', 1290803, '1290801', 1, NULL, '2018-03-30 12:00:00', 1, 5946, 5947);
INSERT INTO `base_region` VALUES ('1290804', '姚安', '云南-楚雄-姚安', 1290804, '1290801', 1, NULL, '2018-03-30 12:00:00', 1, 5948, 5949);
INSERT INTO `base_region` VALUES ('1290805', '牟定', '云南-楚雄-牟定', 1290805, '1290801', 1, NULL, '2018-03-30 12:00:00', 1, 5950, 5951);
INSERT INTO `base_region` VALUES ('1290806', '南华', '云南-楚雄-南华', 1290806, '1290801', 1, NULL, '2018-03-30 12:00:00', 1, 5952, 5953);
INSERT INTO `base_region` VALUES ('1290807', '武定', '云南-楚雄-武定', 1290807, '1290801', 1, NULL, '2018-03-30 12:00:00', 1, 5954, 5955);
INSERT INTO `base_region` VALUES ('1290808', '禄丰', '云南-楚雄-禄丰', 1290808, '1290801', 1, NULL, '2018-03-30 12:00:00', 1, 5956, 5957);
INSERT INTO `base_region` VALUES ('1290809', '双柏', '云南-楚雄-双柏', 1290809, '1290801', 1, NULL, '2018-03-30 12:00:00', 1, 5958, 5959);
INSERT INTO `base_region` VALUES ('1290810', '永仁', '云南-楚雄-永仁', 1290810, '1290801', 1, NULL, '2018-03-30 12:00:00', 1, 5960, 5961);
INSERT INTO `base_region` VALUES ('1290901', '普洱', '云南-普洱', 1290901, '1290000', 0, NULL, '2018-03-30 12:00:00', 1, 5963, 5984);
INSERT INTO `base_region` VALUES ('1290902', '景谷', '云南-普洱-景谷', 1290902, '1290901', 1, NULL, '2018-03-30 12:00:00', 1, 5964, 5965);
INSERT INTO `base_region` VALUES ('1290903', '景东', '云南-普洱-景东', 1290903, '1290901', 1, NULL, '2018-03-30 12:00:00', 1, 5966, 5967);
INSERT INTO `base_region` VALUES ('1290904', '澜沧', '云南-普洱-澜沧', 1290904, '1290901', 1, NULL, '2018-03-30 12:00:00', 1, 5968, 5969);
INSERT INTO `base_region` VALUES ('1290905', '思茅', '云南-普洱-思茅', 1290905, '1290901', 1, NULL, '2018-03-30 12:00:00', 1, 5970, 5971);
INSERT INTO `base_region` VALUES ('1290906', '墨江', '云南-普洱-墨江', 1290906, '1290901', 1, NULL, '2018-03-30 12:00:00', 1, 5972, 5973);
INSERT INTO `base_region` VALUES ('1290907', '江城', '云南-普洱-江城', 1290907, '1290901', 1, NULL, '2018-03-30 12:00:00', 1, 5974, 5975);
INSERT INTO `base_region` VALUES ('1290908', '孟连', '云南-普洱-孟连', 1290908, '1290901', 1, NULL, '2018-03-30 12:00:00', 1, 5976, 5977);
INSERT INTO `base_region` VALUES ('1290909', '西盟', '云南-普洱-西盟', 1290909, '1290901', 1, NULL, '2018-03-30 12:00:00', 1, 5978, 5979);
INSERT INTO `base_region` VALUES ('1290911', '镇沅', '云南-普洱-镇沅', 1290911, '1290901', 1, NULL, '2018-03-30 12:00:00', 1, 5980, 5981);
INSERT INTO `base_region` VALUES ('1290912', '宁洱', '云南-普洱-宁洱', 1290912, '1290901', 1, NULL, '2018-03-30 12:00:00', 1, 5982, 5983);
INSERT INTO `base_region` VALUES ('1291001', '昭通', '云南-昭通', 1291001, '1290000', 0, NULL, '2018-03-30 12:00:00', 1, 5985, 6008);
INSERT INTO `base_region` VALUES ('1291002', '鲁甸', '云南-昭通-鲁甸', 1291002, '1291001', 1, NULL, '2018-03-30 12:00:00', 1, 5986, 5987);
INSERT INTO `base_region` VALUES ('1291003', '彝良', '云南-昭通-彝良', 1291003, '1291001', 1, NULL, '2018-03-30 12:00:00', 1, 5988, 5989);
INSERT INTO `base_region` VALUES ('1291004', '镇雄', '云南-昭通-镇雄', 1291004, '1291001', 1, NULL, '2018-03-30 12:00:00', 1, 5990, 5991);
INSERT INTO `base_region` VALUES ('1291005', '威信', '云南-昭通-威信', 1291005, '1291001', 1, NULL, '2018-03-30 12:00:00', 1, 5992, 5993);
INSERT INTO `base_region` VALUES ('1291006', '巧家', '云南-昭通-巧家', 1291006, '1291001', 1, NULL, '2018-03-30 12:00:00', 1, 5994, 5995);
INSERT INTO `base_region` VALUES ('1291007', '绥江', '云南-昭通-绥江', 1291007, '1291001', 1, NULL, '2018-03-30 12:00:00', 1, 5996, 5997);
INSERT INTO `base_region` VALUES ('1291008', '永善', '云南-昭通-永善', 1291008, '1291001', 1, NULL, '2018-03-30 12:00:00', 1, 5998, 5999);
INSERT INTO `base_region` VALUES ('1291009', '盐津', '云南-昭通-盐津', 1291009, '1291001', 1, NULL, '2018-03-30 12:00:00', 1, 6000, 6001);
INSERT INTO `base_region` VALUES ('1291010', '大关', '云南-昭通-大关', 1291010, '1291001', 1, NULL, '2018-03-30 12:00:00', 1, 6002, 6003);
INSERT INTO `base_region` VALUES ('1291011', '水富', '云南-昭通-水富', 1291011, '1291001', 1, NULL, '2018-03-30 12:00:00', 1, 6004, 6005);
INSERT INTO `base_region` VALUES ('1291012', '昭阳', '云南-昭通-昭阳', 1291012, '1291001', 1, NULL, '2018-03-30 12:00:00', 1, 6006, 6007);
INSERT INTO `base_region` VALUES ('1291101', '临沧', '云南-临沧', 1291101, '1290000', 0, NULL, '2018-03-30 12:00:00', 1, 6009, 6026);
INSERT INTO `base_region` VALUES ('1291102', '沧源', '云南-临沧-沧源', 1291102, '1291101', 1, NULL, '2018-03-30 12:00:00', 1, 6010, 6011);
INSERT INTO `base_region` VALUES ('1291103', '耿马', '云南-临沧-耿马', 1291103, '1291101', 1, NULL, '2018-03-30 12:00:00', 1, 6012, 6013);
INSERT INTO `base_region` VALUES ('1291104', '双江', '云南-临沧-双江', 1291104, '1291101', 1, NULL, '2018-03-30 12:00:00', 1, 6014, 6015);
INSERT INTO `base_region` VALUES ('1291105', '凤庆', '云南-临沧-凤庆', 1291105, '1291101', 1, NULL, '2018-03-30 12:00:00', 1, 6016, 6017);
INSERT INTO `base_region` VALUES ('1291106', '永德', '云南-临沧-永德', 1291106, '1291101', 1, NULL, '2018-03-30 12:00:00', 1, 6018, 6019);
INSERT INTO `base_region` VALUES ('1291107', '云县', '云南-临沧-云县', 1291107, '1291101', 1, NULL, '2018-03-30 12:00:00', 1, 6020, 6021);
INSERT INTO `base_region` VALUES ('1291108', '镇康', '云南-临沧-镇康', 1291108, '1291101', 1, NULL, '2018-03-30 12:00:00', 1, 6022, 6023);
INSERT INTO `base_region` VALUES ('1291109', '临翔', '云南-临沧-临翔', 1291109, '1291101', 1, NULL, '2018-03-30 12:00:00', 1, 6024, 6025);
INSERT INTO `base_region` VALUES ('1291201', '怒江', '云南-怒江', 1291201, '1290000', 0, NULL, '2018-03-30 12:00:00', 1, 6027, 6036);
INSERT INTO `base_region` VALUES ('1291203', '福贡', '云南-怒江-福贡', 1291203, '1291201', 1, NULL, '2018-03-30 12:00:00', 1, 6028, 6029);
INSERT INTO `base_region` VALUES ('1291204', '兰坪', '云南-怒江-兰坪', 1291204, '1291201', 1, NULL, '2018-03-30 12:00:00', 1, 6030, 6031);
INSERT INTO `base_region` VALUES ('1291205', '泸水', '云南-怒江-泸水', 1291205, '1291201', 1, NULL, '2018-03-30 12:00:00', 1, 6032, 6033);
INSERT INTO `base_region` VALUES ('1291207', '贡山', '云南-怒江-贡山', 1291207, '1291201', 1, NULL, '2018-03-30 12:00:00', 1, 6034, 6035);
INSERT INTO `base_region` VALUES ('1291301', '香格里拉', '云南-迪庆-香格里拉', 1291301, '1291305', 1, NULL, '2018-03-30 12:00:00', 1, 6038, 6039);
INSERT INTO `base_region` VALUES ('1291302', '德钦', '云南-迪庆-德钦', 1291302, '1291305', 1, NULL, '2018-03-30 12:00:00', 1, 6040, 6041);
INSERT INTO `base_region` VALUES ('1291303', '维西', '云南-迪庆-维西', 1291303, '1291305', 1, NULL, '2018-03-30 12:00:00', 1, 6042, 6043);
INSERT INTO `base_region` VALUES ('1291305', '迪庆', '云南-迪庆', 1291305, '1290000', 0, NULL, '2018-03-30 12:00:00', 1, 6037, 6044);
INSERT INTO `base_region` VALUES ('1291401', '丽江', '云南-丽江', 1291401, '1290000', 0, NULL, '2018-03-30 12:00:00', 1, 6045, 6056);
INSERT INTO `base_region` VALUES ('1291402', '永胜', '云南-丽江-永胜', 1291402, '1291401', 1, NULL, '2018-03-30 12:00:00', 1, 6046, 6047);
INSERT INTO `base_region` VALUES ('1291403', '华坪', '云南-丽江-华坪', 1291403, '1291401', 1, NULL, '2018-03-30 12:00:00', 1, 6048, 6049);
INSERT INTO `base_region` VALUES ('1291404', '宁蒗', '云南-丽江-宁蒗', 1291404, '1291401', 1, NULL, '2018-03-30 12:00:00', 1, 6050, 6051);
INSERT INTO `base_region` VALUES ('1291405', '古城', '云南-丽江-古城', 1291405, '1291401', 1, NULL, '2018-03-30 12:00:00', 1, 6052, 6053);
INSERT INTO `base_region` VALUES ('1291406', '玉龙', '云南-丽江-玉龙', 1291406, '1291401', 1, NULL, '2018-03-30 12:00:00', 1, 6054, 6055);
INSERT INTO `base_region` VALUES ('1291501', '德宏', '云南-德宏', 1291501, '1290000', 0, NULL, '2018-03-30 12:00:00', 1, 6057, 6068);
INSERT INTO `base_region` VALUES ('1291503', '陇川', '云南-德宏-陇川', 1291503, '1291501', 1, NULL, '2018-03-30 12:00:00', 1, 6058, 6059);
INSERT INTO `base_region` VALUES ('1291504', '盈江', '云南-德宏-盈江', 1291504, '1291501', 1, NULL, '2018-03-30 12:00:00', 1, 6060, 6061);
INSERT INTO `base_region` VALUES ('1291506', '瑞丽', '云南-德宏-瑞丽', 1291506, '1291501', 1, NULL, '2018-03-30 12:00:00', 1, 6062, 6063);
INSERT INTO `base_region` VALUES ('1291507', '梁河', '云南-德宏-梁河', 1291507, '1291501', 1, NULL, '2018-03-30 12:00:00', 1, 6064, 6065);
INSERT INTO `base_region` VALUES ('1291508', '芒市', '云南-德宏-芒市', 1291508, '1291501', 1, NULL, '2018-03-30 12:00:00', 1, 6066, 6067);
INSERT INTO `base_region` VALUES ('1291601', '景洪', '云南-西双版纳-景洪', 1291601, '1291602', 1, NULL, '2018-03-30 12:00:00', 1, 6070, 6071);
INSERT INTO `base_region` VALUES ('1291602', '西双版纳', '云南-西双版纳', 1291602, '1290000', 0, NULL, '2018-03-30 12:00:00', 1, 6069, 6076);
INSERT INTO `base_region` VALUES ('1291603', '勐海', '云南-西双版纳-勐海', 1291603, '1291602', 1, NULL, '2018-03-30 12:00:00', 1, 6072, 6073);
INSERT INTO `base_region` VALUES ('1291605', '勐腊', '云南-西双版纳-勐腊', 1291605, '1291602', 1, NULL, '2018-03-30 12:00:00', 1, 6074, 6075);
INSERT INTO `base_region` VALUES ('1300000', '广西', '广西', 1300000, 'ROOT', 0, NULL, '2018-03-30 12:00:00', 1, 6078, 6329);
INSERT INTO `base_region` VALUES ('1300101', '南宁', '广西-南宁', 1300101, '1300000', 0, NULL, '2018-03-30 12:00:00', 1, 6079, 6104);
INSERT INTO `base_region` VALUES ('1300102', '兴宁', '广西-南宁-兴宁', 1300102, '1300101', 1, NULL, '2018-03-30 12:00:00', 1, 6080, 6081);
INSERT INTO `base_region` VALUES ('1300103', '邕宁', '广西-南宁-邕宁', 1300103, '1300101', 1, NULL, '2018-03-30 12:00:00', 1, 6082, 6083);
INSERT INTO `base_region` VALUES ('1300104', '横县', '广西-南宁-横县', 1300104, '1300101', 1, NULL, '2018-03-30 12:00:00', 1, 6084, 6085);
INSERT INTO `base_region` VALUES ('1300105', '隆安', '广西-南宁-隆安', 1300105, '1300101', 1, NULL, '2018-03-30 12:00:00', 1, 6086, 6087);
INSERT INTO `base_region` VALUES ('1300106', '马山', '广西-南宁-马山', 1300106, '1300101', 1, NULL, '2018-03-30 12:00:00', 1, 6088, 6089);
INSERT INTO `base_region` VALUES ('1300107', '上林', '广西-南宁-上林', 1300107, '1300101', 1, NULL, '2018-03-30 12:00:00', 1, 6090, 6091);
INSERT INTO `base_region` VALUES ('1300108', '武鸣', '广西-南宁-武鸣', 1300108, '1300101', 1, NULL, '2018-03-30 12:00:00', 1, 6092, 6093);
INSERT INTO `base_region` VALUES ('1300109', '宾阳', '广西-南宁-宾阳', 1300109, '1300101', 1, NULL, '2018-03-30 12:00:00', 1, 6094, 6095);
INSERT INTO `base_region` VALUES ('1300110', '青秀', '广西-南宁-青秀', 1300110, '1300101', 1, NULL, '2018-03-30 12:00:00', 1, 6096, 6097);
INSERT INTO `base_region` VALUES ('1300111', '江南', '广西-南宁-江南', 1300111, '1300101', 1, NULL, '2018-03-30 12:00:00', 1, 6098, 6099);
INSERT INTO `base_region` VALUES ('1300112', '西乡塘', '广西-南宁-西乡塘', 1300112, '1300101', 1, NULL, '2018-03-30 12:00:00', 1, 6100, 6101);
INSERT INTO `base_region` VALUES ('1300113', '良庆', '广西-南宁-良庆', 1300113, '1300101', 1, NULL, '2018-03-30 12:00:00', 1, 6102, 6103);
INSERT INTO `base_region` VALUES ('1300201', '崇左', '广西-崇左', 1300201, '1300000', 0, NULL, '2018-03-30 12:00:00', 1, 6105, 6120);
INSERT INTO `base_region` VALUES ('1300202', '天等', '广西-崇左-天等', 1300202, '1300201', 1, NULL, '2018-03-30 12:00:00', 1, 6106, 6107);
INSERT INTO `base_region` VALUES ('1300203', '龙州', '广西-崇左-龙州', 1300203, '1300201', 1, NULL, '2018-03-30 12:00:00', 1, 6108, 6109);
INSERT INTO `base_region` VALUES ('1300204', '凭祥', '广西-崇左-凭祥', 1300204, '1300201', 1, NULL, '2018-03-30 12:00:00', 1, 6110, 6111);
INSERT INTO `base_region` VALUES ('1300205', '大新', '广西-崇左-大新', 1300205, '1300201', 1, NULL, '2018-03-30 12:00:00', 1, 6112, 6113);
INSERT INTO `base_region` VALUES ('1300206', '扶绥', '广西-崇左-扶绥', 1300206, '1300201', 1, NULL, '2018-03-30 12:00:00', 1, 6114, 6115);
INSERT INTO `base_region` VALUES ('1300207', '宁明', '广西-崇左-宁明', 1300207, '1300201', 1, NULL, '2018-03-30 12:00:00', 1, 6116, 6117);
INSERT INTO `base_region` VALUES ('1300208', '江州', '广西-崇左-江州', 1300208, '1300201', 1, NULL, '2018-03-30 12:00:00', 1, 6118, 6119);
INSERT INTO `base_region` VALUES ('1300301', '柳州', '广西-柳州', 1300301, '1300000', 0, NULL, '2018-03-30 12:00:00', 1, 6121, 6142);
INSERT INTO `base_region` VALUES ('1300302', '柳城', '广西-柳州-柳城', 1300302, '1300301', 1, NULL, '2018-03-30 12:00:00', 1, 6122, 6123);
INSERT INTO `base_region` VALUES ('1300303', '城中', '广西-柳州-城中', 1300303, '1300301', 1, NULL, '2018-03-30 12:00:00', 1, 6124, 6125);
INSERT INTO `base_region` VALUES ('1300304', '鹿寨', '广西-柳州-鹿寨', 1300304, '1300301', 1, NULL, '2018-03-30 12:00:00', 1, 6126, 6127);
INSERT INTO `base_region` VALUES ('1300305', '柳江', '广西-柳州-柳江', 1300305, '1300301', 1, NULL, '2018-03-30 12:00:00', 1, 6128, 6129);
INSERT INTO `base_region` VALUES ('1300306', '融安', '广西-柳州-融安', 1300306, '1300301', 1, NULL, '2018-03-30 12:00:00', 1, 6130, 6131);
INSERT INTO `base_region` VALUES ('1300307', '融水', '广西-柳州-融水', 1300307, '1300301', 1, NULL, '2018-03-30 12:00:00', 1, 6132, 6133);
INSERT INTO `base_region` VALUES ('1300308', '三江', '广西-柳州-三江', 1300308, '1300301', 1, NULL, '2018-03-30 12:00:00', 1, 6134, 6135);
INSERT INTO `base_region` VALUES ('1300309', '鱼峰', '广西-柳州-鱼峰', 1300309, '1300301', 1, NULL, '2018-03-30 12:00:00', 1, 6136, 6137);
INSERT INTO `base_region` VALUES ('1300310', '柳南', '广西-柳州-柳南', 1300310, '1300301', 1, NULL, '2018-03-30 12:00:00', 1, 6138, 6139);
INSERT INTO `base_region` VALUES ('1300311', '柳北', '广西-柳州-柳北', 1300311, '1300301', 1, NULL, '2018-03-30 12:00:00', 1, 6140, 6141);
INSERT INTO `base_region` VALUES ('1300401', '来宾', '广西-来宾', 1300401, '1300000', 0, NULL, '2018-03-30 12:00:00', 1, 6143, 6156);
INSERT INTO `base_region` VALUES ('1300402', '忻城', '广西-来宾-忻城', 1300402, '1300401', 1, NULL, '2018-03-30 12:00:00', 1, 6144, 6145);
INSERT INTO `base_region` VALUES ('1300403', '金秀', '广西-来宾-金秀', 1300403, '1300401', 1, NULL, '2018-03-30 12:00:00', 1, 6146, 6147);
INSERT INTO `base_region` VALUES ('1300404', '象州', '广西-来宾-象州', 1300404, '1300401', 1, NULL, '2018-03-30 12:00:00', 1, 6148, 6149);
INSERT INTO `base_region` VALUES ('1300405', '武宣', '广西-来宾-武宣', 1300405, '1300401', 1, NULL, '2018-03-30 12:00:00', 1, 6150, 6151);
INSERT INTO `base_region` VALUES ('1300406', '合山', '广西-来宾-合山', 1300406, '1300401', 1, NULL, '2018-03-30 12:00:00', 1, 6152, 6153);
INSERT INTO `base_region` VALUES ('1300407', '兴宾', '广西-来宾-兴宾', 1300407, '1300401', 1, NULL, '2018-03-30 12:00:00', 1, 6154, 6155);
INSERT INTO `base_region` VALUES ('1300501', '桂林', '广西-桂林', 1300501, '1300000', 0, NULL, '2018-03-30 12:00:00', 1, 6157, 6192);
INSERT INTO `base_region` VALUES ('1300502', '秀峰', '广西-桂林-秀峰', 1300502, '1300501', 1, NULL, '2018-03-30 12:00:00', 1, 6158, 6159);
INSERT INTO `base_region` VALUES ('1300503', '龙胜', '广西-桂林-龙胜', 1300503, '1300501', 1, NULL, '2018-03-30 12:00:00', 1, 6160, 6161);
INSERT INTO `base_region` VALUES ('1300504', '永福', '广西-桂林-永福', 1300504, '1300501', 1, NULL, '2018-03-30 12:00:00', 1, 6162, 6163);
INSERT INTO `base_region` VALUES ('1300505', '临桂', '广西-桂林-临桂', 1300505, '1300501', 1, NULL, '2018-03-30 12:00:00', 1, 6164, 6165);
INSERT INTO `base_region` VALUES ('1300506', '兴安', '广西-桂林-兴安', 1300506, '1300501', 1, NULL, '2018-03-30 12:00:00', 1, 6166, 6167);
INSERT INTO `base_region` VALUES ('1300507', '灵川', '广西-桂林-灵川', 1300507, '1300501', 1, NULL, '2018-03-30 12:00:00', 1, 6168, 6169);
INSERT INTO `base_region` VALUES ('1300508', '全州', '广西-桂林-全州', 1300508, '1300501', 1, NULL, '2018-03-30 12:00:00', 1, 6170, 6171);
INSERT INTO `base_region` VALUES ('1300509', '灌阳', '广西-桂林-灌阳', 1300509, '1300501', 1, NULL, '2018-03-30 12:00:00', 1, 6172, 6173);
INSERT INTO `base_region` VALUES ('1300510', '阳朔', '广西-桂林-阳朔', 1300510, '1300501', 1, NULL, '2018-03-30 12:00:00', 1, 6174, 6175);
INSERT INTO `base_region` VALUES ('1300511', '恭城', '广西-桂林-恭城', 1300511, '1300501', 1, NULL, '2018-03-30 12:00:00', 1, 6176, 6177);
INSERT INTO `base_region` VALUES ('1300512', '平乐', '广西-桂林-平乐', 1300512, '1300501', 1, NULL, '2018-03-30 12:00:00', 1, 6178, 6179);
INSERT INTO `base_region` VALUES ('1300513', '荔浦', '广西-桂林-荔浦', 1300513, '1300501', 1, NULL, '2018-03-30 12:00:00', 1, 6180, 6181);
INSERT INTO `base_region` VALUES ('1300514', '资源', '广西-桂林-资源', 1300514, '1300501', 1, NULL, '2018-03-30 12:00:00', 1, 6182, 6183);
INSERT INTO `base_region` VALUES ('1300515', '叠彩', '广西-桂林-叠彩', 1300515, '1300501', 1, NULL, '2018-03-30 12:00:00', 1, 6184, 6185);
INSERT INTO `base_region` VALUES ('1300516', '象山', '广西-桂林-象山', 1300516, '1300501', 1, NULL, '2018-03-30 12:00:00', 1, 6186, 6187);
INSERT INTO `base_region` VALUES ('1300517', '七星', '广西-桂林-七星', 1300517, '1300501', 1, NULL, '2018-03-30 12:00:00', 1, 6188, 6189);
INSERT INTO `base_region` VALUES ('1300518', '雁山', '广西-桂林-雁山', 1300518, '1300501', 1, NULL, '2018-03-30 12:00:00', 1, 6190, 6191);
INSERT INTO `base_region` VALUES ('1300601', '梧州', '广西-梧州', 1300601, '1300000', 0, NULL, '2018-03-30 12:00:00', 1, 6193, 6208);
INSERT INTO `base_region` VALUES ('1300602', '藤县', '广西-梧州-藤县', 1300602, '1300601', 1, NULL, '2018-03-30 12:00:00', 1, 6194, 6195);
INSERT INTO `base_region` VALUES ('1300603', '万秀', '广西-梧州-万秀', 1300603, '1300601', 1, NULL, '2018-03-30 12:00:00', 1, 6196, 6197);
INSERT INTO `base_region` VALUES ('1300604', '苍梧', '广西-梧州-苍梧', 1300604, '1300601', 1, NULL, '2018-03-30 12:00:00', 1, 6198, 6199);
INSERT INTO `base_region` VALUES ('1300605', '蒙山', '广西-梧州-蒙山', 1300605, '1300601', 1, NULL, '2018-03-30 12:00:00', 1, 6200, 6201);
INSERT INTO `base_region` VALUES ('1300606', '岑溪', '广西-梧州-岑溪', 1300606, '1300601', 1, NULL, '2018-03-30 12:00:00', 1, 6202, 6203);
INSERT INTO `base_region` VALUES ('1300607', '长洲', '广西-梧州-长洲', 1300607, '1300601', 1, NULL, '2018-03-30 12:00:00', 1, 6204, 6205);
INSERT INTO `base_region` VALUES ('1300608', '龙圩', '广西-梧州-龙圩', 1300608, '1300601', 1, NULL, '2018-03-30 12:00:00', 1, 6206, 6207);
INSERT INTO `base_region` VALUES ('1300701', '贺州', '广西-贺州', 1300701, '1300000', 0, NULL, '2018-03-30 12:00:00', 1, 6209, 6220);
INSERT INTO `base_region` VALUES ('1300702', '昭平', '广西-贺州-昭平', 1300702, '1300701', 1, NULL, '2018-03-30 12:00:00', 1, 6210, 6211);
INSERT INTO `base_region` VALUES ('1300703', '富川', '广西-贺州-富川', 1300703, '1300701', 1, NULL, '2018-03-30 12:00:00', 1, 6212, 6213);
INSERT INTO `base_region` VALUES ('1300704', '钟山', '广西-贺州-钟山', 1300704, '1300701', 1, NULL, '2018-03-30 12:00:00', 1, 6214, 6215);
INSERT INTO `base_region` VALUES ('1300705', '八步', '广西-贺州-八步', 1300705, '1300701', 1, NULL, '2018-03-30 12:00:00', 1, 6216, 6217);
INSERT INTO `base_region` VALUES ('1300706', '平桂', '广西-贺州-平桂', 1300706, '1300701', 1, NULL, '2018-03-30 12:00:00', 1, 6218, 6219);
INSERT INTO `base_region` VALUES ('1300801', '贵港', '广西-贵港', 1300801, '1300000', 0, NULL, '2018-03-30 12:00:00', 1, 6221, 6232);
INSERT INTO `base_region` VALUES ('1300802', '桂平', '广西-贵港-桂平', 1300802, '1300801', 1, NULL, '2018-03-30 12:00:00', 1, 6222, 6223);
INSERT INTO `base_region` VALUES ('1300803', '平南', '广西-贵港-平南', 1300803, '1300801', 1, NULL, '2018-03-30 12:00:00', 1, 6224, 6225);
INSERT INTO `base_region` VALUES ('1300804', '港北', '广西-贵港-港北', 1300804, '1300801', 1, NULL, '2018-03-30 12:00:00', 1, 6226, 6227);
INSERT INTO `base_region` VALUES ('1300805', '港南', '广西-贵港-港南', 1300805, '1300801', 1, NULL, '2018-03-30 12:00:00', 1, 6228, 6229);
INSERT INTO `base_region` VALUES ('1300806', '覃塘', '广西-贵港-覃塘', 1300806, '1300801', 1, NULL, '2018-03-30 12:00:00', 1, 6230, 6231);
INSERT INTO `base_region` VALUES ('1300901', '玉林', '广西-玉林', 1300901, '1300000', 0, NULL, '2018-03-30 12:00:00', 1, 6233, 6248);
INSERT INTO `base_region` VALUES ('1300902', '博白', '广西-玉林-博白', 1300902, '1300901', 1, NULL, '2018-03-30 12:00:00', 1, 6234, 6235);
INSERT INTO `base_region` VALUES ('1300903', '北流', '广西-玉林-北流', 1300903, '1300901', 1, NULL, '2018-03-30 12:00:00', 1, 6236, 6237);
INSERT INTO `base_region` VALUES ('1300904', '容县', '广西-玉林-容县', 1300904, '1300901', 1, NULL, '2018-03-30 12:00:00', 1, 6238, 6239);
INSERT INTO `base_region` VALUES ('1300905', '陆川', '广西-玉林-陆川', 1300905, '1300901', 1, NULL, '2018-03-30 12:00:00', 1, 6240, 6241);
INSERT INTO `base_region` VALUES ('1300906', '兴业', '广西-玉林-兴业', 1300906, '1300901', 1, NULL, '2018-03-30 12:00:00', 1, 6242, 6243);
INSERT INTO `base_region` VALUES ('1300907', '玉州', '广西-玉林-玉州', 1300907, '1300901', 1, NULL, '2018-03-30 12:00:00', 1, 6244, 6245);
INSERT INTO `base_region` VALUES ('1300908', '福绵', '广西-玉林-福绵', 1300908, '1300901', 1, NULL, '2018-03-30 12:00:00', 1, 6246, 6247);
INSERT INTO `base_region` VALUES ('1301001', '百色', '广西-百色', 1301001, '1300000', 0, NULL, '2018-03-30 12:00:00', 1, 6249, 6274);
INSERT INTO `base_region` VALUES ('1301002', '那坡', '广西-百色-那坡', 1301002, '1301001', 1, NULL, '2018-03-30 12:00:00', 1, 6250, 6251);
INSERT INTO `base_region` VALUES ('1301003', '田阳', '广西-百色-田阳', 1301003, '1301001', 1, NULL, '2018-03-30 12:00:00', 1, 6252, 6253);
INSERT INTO `base_region` VALUES ('1301004', '德保', '广西-百色-德保', 1301004, '1301001', 1, NULL, '2018-03-30 12:00:00', 1, 6254, 6255);
INSERT INTO `base_region` VALUES ('1301005', '靖西', '广西-百色-靖西', 1301005, '1301001', 1, NULL, '2018-03-30 12:00:00', 1, 6256, 6257);
INSERT INTO `base_region` VALUES ('1301006', '田东', '广西-百色-田东', 1301006, '1301001', 1, NULL, '2018-03-30 12:00:00', 1, 6258, 6259);
INSERT INTO `base_region` VALUES ('1301007', '平果', '广西-百色-平果', 1301007, '1301001', 1, NULL, '2018-03-30 12:00:00', 1, 6260, 6261);
INSERT INTO `base_region` VALUES ('1301008', '隆林', '广西-百色-隆林', 1301008, '1301001', 1, NULL, '2018-03-30 12:00:00', 1, 6262, 6263);
INSERT INTO `base_region` VALUES ('1301009', '西林', '广西-百色-西林', 1301009, '1301001', 1, NULL, '2018-03-30 12:00:00', 1, 6264, 6265);
INSERT INTO `base_region` VALUES ('1301010', '乐业', '广西-百色-乐业', 1301010, '1301001', 1, NULL, '2018-03-30 12:00:00', 1, 6266, 6267);
INSERT INTO `base_region` VALUES ('1301011', '凌云', '广西-百色-凌云', 1301011, '1301001', 1, NULL, '2018-03-30 12:00:00', 1, 6268, 6269);
INSERT INTO `base_region` VALUES ('1301012', '田林', '广西-百色-田林', 1301012, '1301001', 1, NULL, '2018-03-30 12:00:00', 1, 6270, 6271);
INSERT INTO `base_region` VALUES ('1301013', '右江', '广西-百色-右江', 1301013, '1301001', 1, NULL, '2018-03-30 12:00:00', 1, 6272, 6273);
INSERT INTO `base_region` VALUES ('1301101', '钦州', '广西-钦州', 1301101, '1300000', 0, NULL, '2018-03-30 12:00:00', 1, 6275, 6284);
INSERT INTO `base_region` VALUES ('1301102', '浦北', '广西-钦州-浦北', 1301102, '1301101', 1, NULL, '2018-03-30 12:00:00', 1, 6276, 6277);
INSERT INTO `base_region` VALUES ('1301103', '灵山', '广西-钦州-灵山', 1301103, '1301101', 1, NULL, '2018-03-30 12:00:00', 1, 6278, 6279);
INSERT INTO `base_region` VALUES ('1301104', '钦南', '广西-钦州-钦南', 1301104, '1301101', 1, NULL, '2018-03-30 12:00:00', 1, 6280, 6281);
INSERT INTO `base_region` VALUES ('1301105', '钦北', '广西-钦州-钦北', 1301105, '1301101', 1, NULL, '2018-03-30 12:00:00', 1, 6282, 6283);
INSERT INTO `base_region` VALUES ('1301201', '河池', '广西-河池', 1301201, '1300000', 0, NULL, '2018-03-30 12:00:00', 1, 6285, 6308);
INSERT INTO `base_region` VALUES ('1301202', '天峨', '广西-河池-天峨', 1301202, '1301201', 1, NULL, '2018-03-30 12:00:00', 1, 6286, 6287);
INSERT INTO `base_region` VALUES ('1301203', '东兰', '广西-河池-东兰', 1301203, '1301201', 1, NULL, '2018-03-30 12:00:00', 1, 6288, 6289);
INSERT INTO `base_region` VALUES ('1301204', '巴马', '广西-河池-巴马', 1301204, '1301201', 1, NULL, '2018-03-30 12:00:00', 1, 6290, 6291);
INSERT INTO `base_region` VALUES ('1301205', '环江', '广西-河池-环江', 1301205, '1301201', 1, NULL, '2018-03-30 12:00:00', 1, 6292, 6293);
INSERT INTO `base_region` VALUES ('1301206', '罗城', '广西-河池-罗城', 1301206, '1301201', 1, NULL, '2018-03-30 12:00:00', 1, 6294, 6295);
INSERT INTO `base_region` VALUES ('1301207', '宜州', '广西-河池-宜州', 1301207, '1301201', 1, NULL, '2018-03-30 12:00:00', 1, 6296, 6297);
INSERT INTO `base_region` VALUES ('1301208', '凤山', '广西-河池-凤山', 1301208, '1301201', 1, NULL, '2018-03-30 12:00:00', 1, 6298, 6299);
INSERT INTO `base_region` VALUES ('1301209', '南丹', '广西-河池-南丹', 1301209, '1301201', 1, NULL, '2018-03-30 12:00:00', 1, 6300, 6301);
INSERT INTO `base_region` VALUES ('1301210', '都安', '广西-河池-都安', 1301210, '1301201', 1, NULL, '2018-03-30 12:00:00', 1, 6302, 6303);
INSERT INTO `base_region` VALUES ('1301211', '大化', '广西-河池-大化', 1301211, '1301201', 1, NULL, '2018-03-30 12:00:00', 1, 6304, 6305);
INSERT INTO `base_region` VALUES ('1301212', '金城江', '广西-河池-金城江', 1301212, '1301201', 1, NULL, '2018-03-30 12:00:00', 1, 6306, 6307);
INSERT INTO `base_region` VALUES ('1301301', '北海', '广西-北海', 1301301, '1300000', 0, NULL, '2018-03-30 12:00:00', 1, 6309, 6318);
INSERT INTO `base_region` VALUES ('1301302', '合浦', '广西-北海-合浦', 1301302, '1301301', 1, NULL, '2018-03-30 12:00:00', 1, 6310, 6311);
INSERT INTO `base_region` VALUES ('1301304', '海城', '广西-北海-海城', 1301304, '1301301', 1, NULL, '2018-03-30 12:00:00', 1, 6312, 6313);
INSERT INTO `base_region` VALUES ('1301305', '银海', '广西-北海-银海', 1301305, '1301301', 1, NULL, '2018-03-30 12:00:00', 1, 6314, 6315);
INSERT INTO `base_region` VALUES ('1301306', '铁山港', '广西-北海-铁山港', 1301306, '1301301', 1, NULL, '2018-03-30 12:00:00', 1, 6316, 6317);
INSERT INTO `base_region` VALUES ('1301401', '防城港', '广西-防城港', 1301401, '1300000', 0, NULL, '2018-03-30 12:00:00', 1, 6319, 6328);
INSERT INTO `base_region` VALUES ('1301402', '上思', '广西-防城港-上思', 1301402, '1301401', 1, NULL, '2018-03-30 12:00:00', 1, 6320, 6321);
INSERT INTO `base_region` VALUES ('1301403', '东兴', '广西-防城港-东兴', 1301403, '1301401', 1, NULL, '2018-03-30 12:00:00', 1, 6322, 6323);
INSERT INTO `base_region` VALUES ('1301404', '港口', '广西-防城港-港口', 1301404, '1301401', 1, NULL, '2018-03-30 12:00:00', 1, 6324, 6325);
INSERT INTO `base_region` VALUES ('1301405', '防城', '广西-防城港-防城', 1301405, '1301401', 1, NULL, '2018-03-30 12:00:00', 1, 6326, 6327);
INSERT INTO `base_region` VALUES ('1310000', '海南', '海南', 1310000, 'ROOT', 0, NULL, '2018-03-30 12:00:00', 1, 6330, 6391);
INSERT INTO `base_region` VALUES ('1310101', '海口', '海南-海口', 1310101, '1310000', 0, NULL, '2018-03-30 12:00:00', 1, 6331, 6340);
INSERT INTO `base_region` VALUES ('1310102', '秀英', '海南-海口-秀英', 1310102, '1310101', 1, NULL, '2018-03-30 12:00:00', 1, 6332, 6333);
INSERT INTO `base_region` VALUES ('1310103', '龙华', '海南-海口-龙华', 1310103, '1310101', 1, NULL, '2018-03-30 12:00:00', 1, 6334, 6335);
INSERT INTO `base_region` VALUES ('1310104', '琼山', '海南-海口-琼山', 1310104, '1310101', 1, NULL, '2018-03-30 12:00:00', 1, 6336, 6337);
INSERT INTO `base_region` VALUES ('1310105', '美兰', '海南-海口-美兰', 1310105, '1310101', 1, NULL, '2018-03-30 12:00:00', 1, 6338, 6339);
INSERT INTO `base_region` VALUES ('1310201', '三亚', '海南-三亚', 1310201, '1310000', 0, NULL, '2018-03-30 12:00:00', 1, 6341, 6350);
INSERT INTO `base_region` VALUES ('1310202', '东方', '海南-东方', 1310202, '1310000', 0, NULL, '2018-03-30 12:00:00', 1, 6351, 6352);
INSERT INTO `base_region` VALUES ('1310203', '临高', '海南-临高', 1310203, '1310000', 0, NULL, '2018-03-30 12:00:00', 1, 6353, 6354);
INSERT INTO `base_region` VALUES ('1310204', '澄迈', '海南-澄迈', 1310204, '1310000', 0, NULL, '2018-03-30 12:00:00', 1, 6355, 6356);
INSERT INTO `base_region` VALUES ('1310205', '儋州', '海南-儋州', 1310205, '1310000', 0, NULL, '2018-03-30 12:00:00', 1, 6357, 6358);
INSERT INTO `base_region` VALUES ('1310206', '昌江', '海南-昌江', 1310206, '1310000', 0, NULL, '2018-03-30 12:00:00', 1, 6359, 6360);
INSERT INTO `base_region` VALUES ('1310207', '白沙', '海南-白沙', 1310207, '1310000', 0, NULL, '2018-03-30 12:00:00', 1, 6361, 6362);
INSERT INTO `base_region` VALUES ('1310208', '琼中', '海南-琼中', 1310208, '1310000', 0, NULL, '2018-03-30 12:00:00', 1, 6363, 6364);
INSERT INTO `base_region` VALUES ('1310209', '定安', '海南-定安', 1310209, '1310000', 0, NULL, '2018-03-30 12:00:00', 1, 6365, 6366);
INSERT INTO `base_region` VALUES ('1310210', '屯昌', '海南-屯昌', 1310210, '1310000', 0, NULL, '2018-03-30 12:00:00', 1, 6367, 6368);
INSERT INTO `base_region` VALUES ('1310211', '琼海', '海南-琼海', 1310211, '1310000', 0, NULL, '2018-03-30 12:00:00', 1, 6369, 6370);
INSERT INTO `base_region` VALUES ('1310212', '文昌', '海南-文昌', 1310212, '1310000', 0, NULL, '2018-03-30 12:00:00', 1, 6371, 6372);
INSERT INTO `base_region` VALUES ('1310213', '海棠', '海南-三亚-海棠', 1310213, '1310201', 1, NULL, '2018-03-30 12:00:00', 1, 6342, 6343);
INSERT INTO `base_region` VALUES ('1310214', '保亭', '海南-保亭', 1310214, '1310000', 0, NULL, '2018-03-30 12:00:00', 1, 6373, 6374);
INSERT INTO `base_region` VALUES ('1310215', '万宁', '海南-万宁', 1310215, '1310000', 0, NULL, '2018-03-30 12:00:00', 1, 6375, 6376);
INSERT INTO `base_region` VALUES ('1310216', '陵水', '海南-陵水', 1310216, '1310000', 0, NULL, '2018-03-30 12:00:00', 1, 6377, 6378);
INSERT INTO `base_region` VALUES ('1310218', '吉阳', '海南-三亚-吉阳', 1310218, '1310201', 1, NULL, '2018-03-30 12:00:00', 1, 6344, 6345);
INSERT INTO `base_region` VALUES ('1310219', '天涯', '海南-三亚-天涯', 1310219, '1310201', 1, NULL, '2018-03-30 12:00:00', 1, 6346, 6347);
INSERT INTO `base_region` VALUES ('1310221', '乐东', '海南-乐东', 1310221, '1310000', 0, NULL, '2018-03-30 12:00:00', 1, 6379, 6380);
INSERT INTO `base_region` VALUES ('1310222', '五指山', '海南-五指山', 1310222, '1310000', 0, NULL, '2018-03-30 12:00:00', 1, 6381, 6382);
INSERT INTO `base_region` VALUES ('1310223', '崖州', '海南-三亚-崖州', 1310223, '1310201', 1, NULL, '2018-03-30 12:00:00', 1, 6348, 6349);
INSERT INTO `base_region` VALUES ('1310301', '三沙', '海南-三沙', 1310301, '1310000', 0, NULL, '2018-03-30 12:00:00', 1, 6383, 6390);
INSERT INTO `base_region` VALUES ('1310302', '西沙', '海南-三沙-西沙', 1310302, '1310301', 1, NULL, '2018-03-30 12:00:00', 1, 6384, 6385);
INSERT INTO `base_region` VALUES ('1310303', '中沙', '海南-三沙-中沙', 1310303, '1310301', 1, NULL, '2018-03-30 12:00:00', 1, 6386, 6387);
INSERT INTO `base_region` VALUES ('1310304', '南沙', '海南-三沙-南沙', 1310304, '1310301', 1, NULL, '2018-03-30 12:00:00', 1, 6388, 6389);
INSERT INTO `base_region` VALUES ('1320000', '香港', '香港', 1320000, 'ROOT', 0, NULL, '2018-03-30 12:00:00', 1, 6392, 6399);
INSERT INTO `base_region` VALUES ('1320101', '香港', '香港-香港', 1320101, '1320000', 0, NULL, '2018-03-30 12:00:00', 1, 6393, 6398);
INSERT INTO `base_region` VALUES ('1320102', '九龙', '香港-香港-九龙', 1320102, '1320101', 1, NULL, '2018-03-30 12:00:00', 1, 6394, 6395);
INSERT INTO `base_region` VALUES ('1320103', '新界', '香港-香港-新界', 1320103, '1320101', 1, NULL, '2018-03-30 12:00:00', 1, 6396, 6397);
INSERT INTO `base_region` VALUES ('1330000', '澳门', '澳门', 1330000, 'ROOT', 0, NULL, '2018-03-30 12:00:00', 1, 6400, 6407);
INSERT INTO `base_region` VALUES ('1330101', '澳门', '澳门-澳门', 1330101, '1330000', 0, NULL, '2018-03-30 12:00:00', 1, 6401, 6406);
INSERT INTO `base_region` VALUES ('1330102', '氹仔岛', '澳门-澳门-氹仔岛', 1330102, '1330101', 1, NULL, '2018-03-30 12:00:00', 1, 6402, 6403);
INSERT INTO `base_region` VALUES ('1330103', '路环岛', '澳门-澳门-路环岛', 1330103, '1330101', 1, NULL, '2018-03-30 12:00:00', 1, 6404, 6405);
INSERT INTO `base_region` VALUES ('1340000', '台湾', '台湾', 1340000, 'ROOT', 0, NULL, '2018-03-30 12:00:00', 1, 6408, 6439);
INSERT INTO `base_region` VALUES ('1340101', '台北', '台湾-台北', 1340101, '1340000', 0, NULL, '2018-03-30 12:00:00', 1, 6409, 6416);
INSERT INTO `base_region` VALUES ('1340102', '桃园', '台湾-台北-桃园', 1340102, '1340101', 1, NULL, '2018-03-30 12:00:00', 1, 6410, 6411);
INSERT INTO `base_region` VALUES ('1340103', '新竹', '台湾-台北-新竹', 1340103, '1340101', 1, NULL, '2018-03-30 12:00:00', 1, 6412, 6413);
INSERT INTO `base_region` VALUES ('1340104', '宜兰', '台湾-台北-宜兰', 1340104, '1340101', 1, NULL, '2018-03-30 12:00:00', 1, 6414, 6415);
INSERT INTO `base_region` VALUES ('1340201', '高雄', '台湾-高雄', 1340201, '1340000', 0, NULL, '2018-03-30 12:00:00', 1, 6417, 6426);
INSERT INTO `base_region` VALUES ('1340202', '嘉义', '台湾-高雄-嘉义', 1340202, '1340201', 1, NULL, '2018-03-30 12:00:00', 1, 6418, 6419);
INSERT INTO `base_region` VALUES ('1340203', '台南', '台湾-高雄-台南', 1340203, '1340201', 1, NULL, '2018-03-30 12:00:00', 1, 6420, 6421);
INSERT INTO `base_region` VALUES ('1340204', '台东', '台湾-高雄-台东', 1340204, '1340201', 1, NULL, '2018-03-30 12:00:00', 1, 6422, 6423);
INSERT INTO `base_region` VALUES ('1340205', '屏东', '台湾-高雄-屏东', 1340205, '1340201', 1, NULL, '2018-03-30 12:00:00', 1, 6424, 6425);
INSERT INTO `base_region` VALUES ('1340401', '台中', '台湾-台中', 1340401, '1340000', 0, NULL, '2018-03-30 12:00:00', 1, 6427, 6438);
INSERT INTO `base_region` VALUES ('1340402', '苗栗', '台湾-台中-苗栗', 1340402, '1340401', 1, NULL, '2018-03-30 12:00:00', 1, 6428, 6429);
INSERT INTO `base_region` VALUES ('1340403', '彰化', '台湾-台中-彰化', 1340403, '1340401', 1, NULL, '2018-03-30 12:00:00', 1, 6430, 6431);
INSERT INTO `base_region` VALUES ('1340404', '南投', '台湾-台中-南投', 1340404, '1340401', 1, NULL, '2018-03-30 12:00:00', 1, 6432, 6433);
INSERT INTO `base_region` VALUES ('1340405', '花莲', '台湾-台中-花莲', 1340405, '1340401', 1, NULL, '2018-03-30 12:00:00', 1, 6434, 6435);
INSERT INTO `base_region` VALUES ('1340406', '云林', '台湾-台中-云林', 1340406, '1340401', 1, NULL, '2018-03-30 12:00:00', 1, 6436, 6437);
INSERT INTO `base_region` VALUES ('15b82047-9011-4b30-a086-1a798bac4a6f', '高新区', '重庆-重庆-高新区', 1044400, '1040100', 1, '高新区', '2018-08-28 10:27:22', 1, 190, 191);
INSERT INTO `base_region` VALUES ('b47bc7ba-2822-447a-afaf-4db9b5168172', '万盛区', '重庆-重庆-万盛区', 1044401, '1040100', 1, '', '2018-12-05 14:39:26', 1, 196, 197);
INSERT INTO `base_region` VALUES ('d42695e6-7722-48a2-8490-e4bc9ca88596', '两江新区', '重庆-重庆-两江新区', 1044701, '1040100', 1, '两江新区', '2018-08-28 10:28:29', 1, 194, 195);
INSERT INTO `base_region` VALUES ('ROOT', '中国', '中国', 0, NULL, 0, NULL, '2018-03-30 12:00:00', 1, 1, 6440);

-- ----------------------------
-- Table structure for base_sms
-- ----------------------------
DROP TABLE IF EXISTS `base_sms`;
CREATE TABLE `base_sms`  (
  `id` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `remarks` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime(0) NOT NULL,
  `author_id` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `status` int(11) NOT NULL DEFAULT 0 COMMENT '0、未发送 1、已发送 2、未完成',
  `send_time` datetime(0) NULL DEFAULT NULL,
  `type` int(11) NOT NULL DEFAULT 0 COMMENT '0 系统发送，1 后台管理发送，template_id 短信模板id',
  `template_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `batch` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `param_json` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `sms_channel` int(11) NULL DEFAULT NULL COMMENT '短信通道',
  `user_filter` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '接收短信的user过滤条件',
  `sms_send_mode` int(11) NULL DEFAULT NULL COMMENT '短信发送模式，0 系统用户，1 只输手机号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '短信' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for base_sms_send_record
-- ----------------------------
DROP TABLE IF EXISTS `base_sms_send_record`;
CREATE TABLE `base_sms_send_record`  (
  `id` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `sms_id` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `template_id` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `template_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `user_id` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `status` int(1) NOT NULL,
  `send_time` datetime(0) NULL DEFAULT NULL,
  `create_time` datetime(0) NOT NULL,
  `batch` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `user_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `remarks` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '短信发送记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for base_sms_template
-- ----------------------------
DROP TABLE IF EXISTS `base_sms_template`;
CREATE TABLE `base_sms_template`  (
  `id` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `tpl_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `type_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `ali_sms_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 0 COMMENT '0、未发送 1、已发送',
  `create_time` datetime(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '短信模板' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of base_sms_template
-- ----------------------------
INSERT INTO `base_sms_template` VALUES ('55b72c38-d38f-4acb-93ca-a640f05b7810', '测试模板3', '运营', '哈哈哈哈哈${test}，识别一下${pwd}', 'asdf', 0, '2018-06-25 14:18:52');
INSERT INTO `base_sms_template` VALUES ('7629b75d-d669-4573-8842-e6e3cc605f0c', '手动参数设置测试2', '运营', '您好，你的手机号码${phone}已成功注册，请登录网站查看,昵称为${nickName}。', 'SMS_138060617', 1, '2018-06-26 15:12:17');
INSERT INTO `base_sms_template` VALUES ('a7833ae6-a49d-43e3-b591-8cb6c2e8fbc2', '手动参数设置测试', '运营', '您好，已经${detailNo}，初始密码${pwd}，请妥善保管', 'SMS_138060318', 1, '2018-06-25 14:44:22');

-- ----------------------------
-- Table structure for base_sms_template_param
-- ----------------------------
DROP TABLE IF EXISTS `base_sms_template_param`;
CREATE TABLE `base_sms_template_param`  (
  `id` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `template_id` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `param_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `param_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `type` int(1) NOT NULL,
  `sys_param_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '系统参数类型',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '短信模板参数' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of base_sms_template_param
-- ----------------------------
INSERT INTO `base_sms_template_param` VALUES ('1d2b9631-8fe6-47f4-8492-e75b14ca4bb9', '730506cc-7597-49bc-86d9-5a2abfbdc18f', 'name', '姓名', 1, '');
INSERT INTO `base_sms_template_param` VALUES ('2093935d-77f7-4491-91b3-e28e8f339471', '7629b75d-d669-4573-8842-e6e3cc605f0c', 'phone', '电话', 0, 'userInfo');
INSERT INTO `base_sms_template_param` VALUES ('23088f0f-ec21-4c13-b1af-5c48a3690ffa', '7629b75d-d669-4573-8842-e6e3cc605f0c', 'nickName', 'nickName', 1, '');
INSERT INTO `base_sms_template_param` VALUES ('431b99e2-44ff-418d-9745-147eada1570a', '55b72c38-d38f-4acb-93ca-a640f05b7810', 'pwd', '密码', 0, 'userInfo');
INSERT INTO `base_sms_template_param` VALUES ('4508c7b1-f316-4ddb-a25d-d0d8dcf2d5bd', '67386ae6-098c-44db-a43c-8d2d9154dbe2', 'password', '密码', 0, 'userInfo');
INSERT INTO `base_sms_template_param` VALUES ('796990d5-a56b-48d9-85d1-2743ec3b72c5', '730506cc-7597-49bc-86d9-5a2abfbdc18f', 'password', '密码', 0, 'userInfo');
INSERT INTO `base_sms_template_param` VALUES ('c628d72d-a5d5-44b2-8fdd-4ed2461fad4e', 'a7833ae6-a49d-43e3-b591-8cb6c2e8fbc2', 'pwd', '密码', 0, 'userInfo');
INSERT INTO `base_sms_template_param` VALUES ('e0431c42-765b-41c1-8485-2306baf36044', 'a7833ae6-a49d-43e3-b591-8cb6c2e8fbc2', 'detailNo', 'detailNo', 1, NULL);
INSERT INTO `base_sms_template_param` VALUES ('fb8892af-cb99-4cdc-9ea2-4ef12bf63023', '55b72c38-d38f-4acb-93ca-a640f05b7810', 'test', '测试手动', 1, '');

-- ----------------------------
-- Table structure for base_sys_message
-- ----------------------------
DROP TABLE IF EXISTS `base_sys_message`;
CREATE TABLE `base_sys_message`  (
  `id` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `user_id` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `create_time` datetime(0) NOT NULL,
  `know_time` datetime(0) NULL DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 0 COMMENT '0、未读 1、已读',
  `biz_type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `biz_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `del_flag` int(1) NULL DEFAULT 1 COMMENT '0、已删除 1、未删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统消息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for base_user_base_info
-- ----------------------------
DROP TABLE IF EXISTS `base_user_base_info`;
CREATE TABLE `base_user_base_info`  (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `phone` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `phone2` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备用联系电话',
  `pwd` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `user_nick_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `gender` int(11) NOT NULL DEFAULT 0 COMMENT '0、 未填写  1、男  2、女',
  `birth` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `user_email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `open_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `user_qq` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `user_type` int(11) NOT NULL DEFAULT 1 COMMENT '1、注册用户，2、客户经理，3、专业会计，4、财务专家',
  `user_type_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `balance` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '余额',
  `regist_time` datetime(0) NOT NULL,
  `regist_ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `last_login_time` datetime(0) NULL DEFAULT NULL,
  `last_login_ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 1 COMMENT '1,正常 0.限制登录',
  `password_errors` int(11) NOT NULL DEFAULT 0 COMMENT '密码错误次数',
  `wx_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `wx_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `work_status` int(11) NOT NULL DEFAULT 1 COMMENT '0、未工作，1、工作中',
  `profile` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '个人简介',
  `regist_region` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `region_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `select_region` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户选择的地区',
  `select_region_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户选择的地区id',
  `homepage` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '备注',
  `data_source` int(1) NULL DEFAULT 0 COMMENT '数据来源（0 - PC, 1 - MOBILE, 2 - 存量数据导入）',
  `pay_pwd` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '支付密码',
  `mini_open_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `wx_union_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `referrer_user_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '推荐人id',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `phone`(`phone`) USING BTREE,
  INDEX `regionId`(`region_id`) USING BTREE,
  INDEX `regist_time`(`regist_time`) USING BTREE,
  INDEX `user_type`(`user_type`) USING BTREE,
  INDEX `user_type_id`(`user_type_id`) USING BTREE,
  INDEX `remark`(`remark`(191)) USING BTREE,
  INDEX `user_id_index`(`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户详情表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of base_user_base_info
-- ----------------------------
INSERT INTO `base_user_base_info` VALUES ('115ad181-9468-469b-a956-c716e8ce3b7e', '13900000000', NULL, '81ZIzqyyhUkoVZ60ottpJQBrSvudoU7kwVZhrKlEGWY=', NULL, '和0000', 0, NULL, NULL, NULL, NULL, 1, '4c16750b-3b93-461e-baa0-efbce442356e', 100.00, '2018-11-12 14:11:33', '106.86.208.106', '2018-11-22 10:37:28', '192.168.80.49', 1, 0, NULL, NULL, 1, NULL, '中国-重庆-重庆-', '1040100', NULL, NULL, NULL, '', 1, NULL, NULL, NULL, '');

-- ----------------------------
-- Table structure for base_user_base_type
-- ----------------------------
DROP TABLE IF EXISTS `base_user_base_type`;
CREATE TABLE `base_user_base_type`  (
  `id` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `user_type` int(2) NOT NULL DEFAULT 0,
  `user_type_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of base_user_base_type
-- ----------------------------
INSERT INTO `base_user_base_type` VALUES ('4c16750b-3b93-461e-baa0-efbce442356e', 1, '普通用户', 'remark');
INSERT INTO `base_user_base_type` VALUES ('97e80f12-1c2c-46e7-b905-70a83633e276', 0, '未分配角色', '用户分类删除时，所有该分类下的用户都会改变为未分配角色类型');

-- ----------------------------
-- Table structure for base_user_company_info
-- ----------------------------
DROP TABLE IF EXISTS `base_user_company_info`;
CREATE TABLE `base_user_company_info`  (
  `id` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `user_id` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `logo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `nature` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0',
  `industry` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `scale` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0',
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `region` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `region_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '注册用户企业信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for base_variable_data
-- ----------------------------
DROP TABLE IF EXISTS `base_variable_data`;
CREATE TABLE `base_variable_data`  (
  `id` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `type` int(11) NOT NULL,
  `ref_id` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `json_data` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `order_no` int(11) NOT NULL,
  `avatar` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '前端可变数据' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of base_variable_data
-- ----------------------------
INSERT INTO `base_variable_data` VALUES ('0079763d-850a-4ebe-b64f-cebc21eb7825', 0, '12', '{\"title\":\"快速注册\",\"price\":\"1000\",\"unit\":\"元\",\"link\":\"/shoppingcart/productselection?productId=e67ad13c-e23e-4879-b4bf-54e0fac6c923\"}', '商标', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('02793991-3a71-4f6d-b814-896a5ac6ff58', 0, '14', '{\"title\":\"高新技术企业\",\"price\":\"30000\",\"unit\":\"元\",\"link\":\"/shoppingcart/productselection?productId=c8e5070d-de85-435e-8df5-5a11f52445f8\"}', '项目申报', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('0461c6ce-fe4f-4c82-96f5-2274ac060431', 0, '5', '{\"title\":\"中外企业注册\",\"price\":\"2000\",\"unit\":\"元起\",\"link\":\"/shoppingcart/productselection?productId=52a700f0-7d9c-403f-8317-4741d1d0e223\"}', '注册公司', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('0504432a-6aa2-4cab-bddf-ace1139398d7', 0, '11', '{\"title\":\"音乐作品\",\"price\":\"1000\",\"unit\":\"元\",\"link\":\"/shoppingcart/productselection?productId=174a8156-e38c-4ffe-9e0b-6ab770726d65\"}', '著作权', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('092ecd0d-8a06-4ce6-8b3d-9d43e1177e0a', 0, '2', '{\"title\":\"非正常户解除\",\"price\":\"2000\",\"unit\":\"元 起\",\"link\":\"/shoppingcart/productselection?productId=0c9c54dd-394a-488f-b12d-12a89b03d0e8\"}', '税务服务', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('0a3b7aa8-2d73-42b9-b920-1a700cd9733b', 0, '1', '{\"title\":\"一般纳税人\",\"price\":\"250\",\"unit\":\"元/月 起\",\"link\":\"/shoppingcart/productselection?productId=5914a6bf-2b03-4b68-8f79-5b66d09185e0\"}', '代理记账', 1, NULL);
INSERT INTO `base_variable_data` VALUES ('0f655fbf-4941-43f8-a030-a152ea69ddb7', 0, '2', '{\"title\":\"小规模纳税人\",\"price\":\"1000\",\"unit\":\"元 起\",\"link\":\"/shoppingcart/productselection?productId=0c9c54dd-394a-488f-b12d-12a89b03d0e8\"}', '税务服务', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('0ff0e970-a35c-4222-a73d-650c8246dc88', 0, '11', '{\"title\":\"汇编作品\",\"price\":\"3500\",\"unit\":\"元\",\"link\":\"/shoppingcart/productselection?productId=174a8156-e38c-4ffe-9e0b-6ab770726d65\"}', '著作权', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('1310634b-06aa-466d-9bee-0afc3ff3dc30', 0, '10', '{\"title\":\"建筑资质\",\"price\":\"100000\",\"unit\":\"元\",\"link\":\"/shoppingcart/productselection?productId=cce8d9ee-e4db-4504-8a88-ac6d8e077ca1\"}', '行业资质', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('16e43701-bed5-4520-a34a-0af89577423a', 0, '14', '{\"title\":\"科技型企业\",\"price\":\"2000\",\"unit\":\"元\",\"link\":\"/shoppingcart/productselection?productId=c8e5070d-de85-435e-8df5-5a11f52445f8\"}', '项目申报', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('18a94348-64e0-41a4-aee7-27ddf9242620', 0, '10', '{\"title\":\"烟草专卖许可证\",\"price\":\"4000\",\"unit\":\"元\",\"link\":\"/shoppingcart/productselection?productId=cce8d9ee-e4db-4504-8a88-ac6d8e077ca1\"}', '行业资质', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('1929cb7d-e9ff-405b-bd7c-924d173336b6', 0, '6', '{\"title\":\"经营范围\",\"price\":\"500\",\"unit\":\"元\",\"link\":\"/shoppingcart/productselection?productId=6dbdb3dc-2972-4710-8fdb-af72da83cb0e\"}', '公司变更', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('1a0337ad-472e-40b7-a548-518ad07df8e3', 0, '11', '{\"title\":\"多媒体汇编作品\",\"price\":\"3500\",\"unit\":\"元\",\"link\":\"/shoppingcart/productselection?productId=174a8156-e38c-4ffe-9e0b-6ab770726d65\"}', '著作权', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('1a403d2d-7778-409b-bad5-ebda9b3a4537', 0, '9', '{\"title\":\"代办医保卡\",\"price\":\"25\",\"unit\":\"元/人 起\",\"link\":\"/shoppingcart/productselection?productId=27eb67af-2b15-47fd-b007-6fa1b6a38b62\"}', '代办社保', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('1dcebab0-5291-4b33-8cac-02da30ba52a6', 0, '3', '{\"title\":\"验资 （200万以下）\",\"price\":\"1500\",\"unit\":\"元\",\"link\":\"/shoppingcart/productselection?productId=ce59af69-1c62-482c-b67d-c178a9a771dd\"}', '审计验资', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('20fc1565-3ecc-4bf7-8359-fb3f153b82fd', 0, '1', '{\"title\":\"消费税申报\",\"price\":\"200\",\"unit\":\"元/月 起\",\"link\":\"/shoppingcart/productselection?productId=5914a6bf-2b03-4b68-8f79-5b66d09185e0\"}', '代理记账', 4, NULL);
INSERT INTO `base_variable_data` VALUES ('24063bb1-9d49-4e3d-b735-605750683595', 0, '5', '{\"title\":\"合伙企业注册\",\"price\":\"1000\",\"unit\":\"元起\",\"link\":\"/shoppingcart/productselection?productId=52a700f0-7d9c-403f-8317-4741d1d0e223\"}', '注册公司', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('2832340b-47d7-4e10-9896-de9af9df516e', 0, '2', '{\"title\":\"小规模纳税人注销税务登记申请审批\",\"price\":\"3000\",\"unit\":\"元 起\",\"link\":\"/shoppingcart/productselection?productId=0c9c54dd-394a-488f-b12d-12a89b03d0e8\"}', '税务服务', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('28ccfb6f-1de9-4976-a7ec-dbac1e9a986a', 0, '6', '{\"title\":\"股东\",\"price\":\"1500\",\"unit\":\"元\",\"link\":\"/shoppingcart/productselection?productId=6dbdb3dc-2972-4710-8fdb-af72da83cb0e\"}', '公司变更', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('29c05d46-ed4b-4b4a-b54d-d4b1f6288b5d', 0, '3', '{\"title\":\"审计 （2000万以下）\",\"price\":\"12000\",\"unit\":\"元\",\"link\":\"/shoppingcart/productselection?productId=ce59af69-1c62-482c-b67d-c178a9a771dd\"}', '审计验资', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('2d383320-9477-4561-a8b0-8bd14f63d0b9', 0, '6', '{\"title\":\"地址（跨区）\",\"price\":\"1000\",\"unit\":\"元\",\"link\":\"/shoppingcart/productselection?productId=6dbdb3dc-2972-4710-8fdb-af72da83cb0e\"}', '公司变更', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('348326a5-5b26-44a1-a36c-0265984410fc', 0, '9', '{\"title\":\"社保新开户\",\"price\":\"500\",\"unit\":\"元\",\"link\":\"/shoppingcart/productselection?productId=27eb67af-2b15-47fd-b007-6fa1b6a38b62\"}', '代办社保', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('37a50a11-b331-458b-9f2c-c74c33a028c1', 0, '2', '{\"title\":\"一般纳税人注销税务登记申请审批\",\"price\":\"5000\",\"unit\":\"元 起\",\"link\":\"/shoppingcart/productselection?productId=0c9c54dd-394a-488f-b12d-12a89b03d0e8\"}', '税务服务', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('3a3c814d-d911-4a35-a6f5-709bf268b413', 0, '10', '{\"title\":\"食品经营许可证\",\"price\":\"2500\",\"unit\":\"元\",\"link\":\"/shoppingcart/productselection?productId=cce8d9ee-e4db-4504-8a88-ac6d8e077ca1\"}', '行业资质', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('3c8e5ba6-c8cb-4d39-80b9-2b71c92f021a', 0, '2', '{\"title\":\"个体\",\"price\":\"1000\",\"unit\":\"元 起\",\"link\":\"/shoppingcart/productselection?productId=0c9c54dd-394a-488f-b12d-12a89b03d0e8\"}', '税务服务', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('40447fae-c9f9-4ff2-b99e-f6de66c332da', 0, '2', '{\"title\":\"税务登记证件遗失补办\",\"price\":\"300\",\"unit\":\"元 起\",\"link\":\"/shoppingcart/productselection?productId=0c9c54dd-394a-488f-b12d-12a89b03d0e8\"}', '税务服务', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('447967c3-cfd7-4c6e-b50c-9678bf20dc78', 0, '11', '{\"title\":\"舞蹈作品\",\"price\":\"1000\",\"unit\":\"元\",\"link\":\"/shoppingcart/productselection?productId=174a8156-e38c-4ffe-9e0b-6ab770726d65\"}', '著作权', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('464f8682-938a-4789-b69b-727b6258b683', 0, '9', '{\"title\":\"社保跨区迁移\",\"price\":\"1000\",\"unit\":\"元\",\"link\":\"/shoppingcart/productselection?productId=27eb67af-2b15-47fd-b007-6fa1b6a38b62\"}', '代办社保', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('471c9b2c-924f-49ec-966c-264df295d372', 0, '5', '{\"title\":\"个体/工商户\",\"price\":\"500\",\"unit\":\"元起\",\"link\":\"/shoppingcart/productselection?productId=52a700f0-7d9c-403f-8317-4741d1d0e223\"}', '注册公司', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('478d6b41-8b71-4c90-9123-e84aafa12313', 0, '4', '{\"title\":\"顾问咨询 （800万以上）\",\"price\":\"25000\",\"unit\":\"元起\",\"link\":\"/shoppingcart/productselection?productId=409ebc76-30c9-4f92-afe4-1913997ff994\"}', '税收筹划', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('48204236-c761-4b11-b0c8-db45c1580435', 0, '1', '{\"title\":\"个体注册\",\"price\":\"50\",\"unit\":\"元/月 起\",\"link\":\"/shoppingcart/productselection?productId=5914a6bf-2b03-4b68-8f79-5b66d09185e0\"}', '代理记账', 3, NULL);
INSERT INTO `base_variable_data` VALUES ('498f9c24-439b-4e3f-9711-60b997c31111', 0, '2', '{\"title\":\"一般纳税人\",\"price\":\"1200\",\"unit\":\"元 起\",\"link\":\"/shoppingcart/productselection?productId=0c9c54dd-394a-488f-b12d-12a89b03d0e8\"}', '税务服务', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('4be4c235-4932-459d-adf0-156439e9d8e6', 0, '4', '{\"title\":\"顾问咨询 （1000万以上）\",\"price\":\"30000\",\"unit\":\"元起\",\"link\":\"/shoppingcart/productselection?productId=409ebc76-30c9-4f92-afe4-1913997ff994\"}', '税收筹划', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('4ce6f97f-00da-4a7b-bb91-bde2091b21ad', 0, '2', '{\"title\":\"外出经营报验登记\",\"price\":\"150\",\"unit\":\"元 起\",\"link\":\"/shoppingcart/productselection?productId=0c9c54dd-394a-488f-b12d-12a89b03d0e8\"}', '税务服务', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('4e3fbade-af77-4363-93aa-7b2036f5999f', 0, '3', '{\"title\":\"审计 （100万以下）\",\"price\":\"2000\",\"unit\":\"元\",\"link\":\"/shoppingcart/productselection?productId=ce59af69-1c62-482c-b67d-c178a9a771dd\"}', '审计验资', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('4f9fd215-3dd1-4a68-9e9d-1ede08343aad', 0, '9', '{\"title\":\"人员增减\",\"price\":\"50\",\"unit\":\"元/人 起\",\"link\":\"/shoppingcart/productselection?productId=27eb67af-2b15-47fd-b007-6fa1b6a38b62\"}', '代办社保', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('4ffff6a1-bcd2-42c8-b7b4-7ab402bbc520', 0, '6', '{\"title\":\"名称\",\"price\":\"1000\",\"unit\":\"元\",\"link\":\"/shoppingcart/productselection?productId=6dbdb3dc-2972-4710-8fdb-af72da83cb0e\"}', '公司变更', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('5183b9c9-3d78-40e0-9e3f-2ad8c76c6482', 0, '002', '{\"content\":\"以前从未做过任何账务，每月只做申报，留下了财税隐患。机缘巧合看到麦积财税，便将自己公司 2016年到2017年两年的账目交于麦积财税财税顾问进行重新整理。非常专业，成功帮助我完成了年报的报税。\",\"date\":\"2018/5/12\"}', '评价', 1, '/pub/a29af355be1b479f986d84f56912abbe/headimg4.png');
INSERT INTO `base_variable_data` VALUES ('520520fb-a812-418d-819b-7faa2bd5838e', 0, '12', '{\"title\":\"普通注册\",\"price\":\"900\",\"unit\":\"元\",\"link\":\"/shoppingcart/productselection?productId=e67ad13c-e23e-4879-b4bf-54e0fac6c923\"}', '商标', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('54d1ceb7-68ba-4735-8b1e-f0ff70eff744', 0, '7', '{\"title\":\"特殊年报\",\"price\":\"3000\",\"unit\":\"元\",\"link\":\"/shoppingcart/productselection?productId=28abd30d-c952-4d75-9943-6e9665487b61\"}', '公司年报', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('55d5e8cd-49c7-4d75-b084-b94a929ee6ab', 0, '6', '{\"title\":\"注册资金\",\"price\":\"800\",\"unit\":\"元\",\"link\":\"/shoppingcart/productselection?productId=6dbdb3dc-2972-4710-8fdb-af72da83cb0e\"}', '公司变更', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('5603c0eb-f25f-417c-a038-43cee4195ab6', 0, '4', '{\"title\":\"顾问咨询 （5000万以上）\",\"price\":\"50000\",\"unit\":\"元起\",\"link\":\"/shoppingcart/productselection?productId=409ebc76-30c9-4f92-afe4-1913997ff994\"}', '税收筹划', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('577d0a14-e776-4884-b987-6f1e13aa00b6', 0, '1', '{\"title\":\"零申报无任何票据\",\"price\":\"100\",\"unit\":\"元/月 起\",\"link\":\"/shoppingcart/productselection?productId=5914a6bf-2b03-4b68-8f79-5b66d09185e0\"}', '代理记账', 7, NULL);
INSERT INTO `base_variable_data` VALUES ('58788f39-a2cb-45ac-8a03-a7dd894c8c18', 0, '11', '{\"title\":\"工程设计图\",\"price\":\"1500\",\"unit\":\"元\",\"link\":\"/shoppingcart/productselection?productId=174a8156-e38c-4ffe-9e0b-6ab770726d65\"}', '著作权', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('6173533e-5fac-40b7-9373-d41d28b761a0', 0, '3', '{\"title\":\"验资 （1000万以下）\",\"price\":\"2500\",\"unit\":\"元\",\"link\":\"/shoppingcart/productselection?productId=ce59af69-1c62-482c-b67d-c178a9a771dd\"}', '审计验资', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('62372683-5723-4b84-a40f-d23f87fd4fb0', 0, '8', '{\"title\":\"银行注销\",\"price\":\"500\",\"unit\":\"元\",\"link\":\"/shoppingcart/productselection?productId=5b20630d-2127-4860-939c-1ef4e38f481b\"}', '公司注销', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('62ec731b-c43d-4757-b434-224b0b4e2a1a', 0, '11', '{\"title\":\"口述作品\",\"price\":\"1000\",\"unit\":\"元\",\"link\":\"/shoppingcart/productselection?productId=174a8156-e38c-4ffe-9e0b-6ab770726d65\"}', '著作权', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('6321a416-8452-4d1f-a456-ef5df9bbbdae', 0, '3', '{\"title\":\"验资 （500万以下）\",\"price\":\"2000\",\"unit\":\"元\",\"link\":\"/shoppingcart/productselection?productId=ce59af69-1c62-482c-b67d-c178a9a771dd\"}', '审计验收', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('6416cc27-db7e-4595-a2a0-4a3f37101ab3', 0, '10', '{\"title\":\"药品经营许可证\",\"price\":\"7000\",\"unit\":\"元\",\"link\":\"/shoppingcart/productselection?productId=cce8d9ee-e4db-4504-8a88-ac6d8e077ca1\"}', '行业资质', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('6ed818e8-e030-40ed-ab53-e2a5c1e65ea3', 0, '1', '{\"title\":\"小规模纳税人\",\"price\":\"150\",\"unit\":\"元/月起\",\"link\":\"/shoppingcart/productselection?productId=5914a6bf-2b03-4b68-8f79-5b66d09185e0\"}', '代理记账', 2, NULL);
INSERT INTO `base_variable_data` VALUES ('70ae825c-650e-406a-88e8-ee1220ea950f', 0, '7', '{\"title\":\"正常年报\",\"price\":\"500\",\"unit\":\"元\",\"link\":\"/shoppingcart/productselection?productId=28abd30d-c952-4d75-9943-6e9665487b61\"}', '公司年报', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('71278b96-ebfb-4797-869f-644814ca9686', 0, '10', '{\"title\":\"医疗器械（三类）许可证\",\"price\":\"15000\",\"unit\":\"元\",\"link\":\"/shoppingcart/productselection?productId=cce8d9ee-e4db-4504-8a88-ac6d8e077ca1\"}', '行业资质', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('772a844c-b5f3-4ab4-be02-74f39ce88ef9', 0, '8', '{\"title\":\"执照注销\",\"price\":\"800\",\"unit\":\"元\",\"link\":\"/shoppingcart/productselection?productId=5b20630d-2127-4860-939c-1ef4e38f481b\"}', '公司注销', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('89c4c083-5714-4988-923f-761e7f17c984', 0, '6', '{\"title\":\"法人\",\"price\":\"800\",\"unit\":\"元\",\"link\":\"/shoppingcart/productselection?productId=6dbdb3dc-2972-4710-8fdb-af72da83cb0e\"}', '公司变更', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('8e97cd0b-55b4-4bee-a9f5-91dba098ab32', 0, '11', '{\"title\":\"美术作品\",\"price\":\"1000\",\"unit\":\"元\",\"link\":\"/shoppingcart/productselection?productId=174a8156-e38c-4ffe-9e0b-6ab770726d65\"}', '著作权', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('8eea1af0-b87c-4c47-beb3-987a1a464838', 0, '10', '{\"title\":\"人力资源服务许可证\",\"price\":\"10000\",\"unit\":\"元\",\"link\":\"/shoppingcart/productselection?productId=cce8d9ee-e4db-4504-8a88-ac6d8e077ca1\"}', '行业资质', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('8efe1703-7650-4bf2-af5a-6baf592b0139', 0, '11', '{\"title\":\"补办证书\",\"price\":\"500\",\"unit\":\"元\",\"link\":\"/shoppingcart/productselection?productId=174a8156-e38c-4ffe-9e0b-6ab770726d65\"}', '著作权', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('966fbf8c-5e16-4dcc-8b6e-3e741bb8fa5c', 0, '1', '{\"title\":\"车辆购置税申报\",\"price\":\"200\",\"unit\":\"元/月 起\",\"link\":\"/shoppingcart/productselection?productId=5914a6bf-2b03-4b68-8f79-5b66d09185e0\"}', '代理记账', 5, NULL);
INSERT INTO `base_variable_data` VALUES ('98321b9b-a148-4d63-9796-2f9dafb8481c', 0, '13', '{\"title\":\"发明专利 \",\"price\":\"5000\",\"unit\":\"元\",\"link\":\"/shoppingcart/productselection?productId=56b2765b-1396-45e8-b177-06a424538b45\"}', '专利', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('9961fe89-c5b3-44ae-8948-e0b0a10d7925', 0, '4', '{\"title\":\"顾问咨询 （3000万以上）\",\"price\":\"40000\",\"unit\":\"元起\",\"link\":\"/shoppingcart/productselection?productId=409ebc76-30c9-4f92-afe4-1913997ff994\"}', '税收筹划', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('9bc51461-9e50-407e-909b-bc09939c0e0d', 0, '12', '{\"title\":\"无忧担保注册\",\"price\":\"1500\",\"unit\":\"元\",\"link\":\"/shoppingcart/productselection?productId=e67ad13c-e23e-4879-b4bf-54e0fac6c923\"}', '商标', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('9e122851-029c-4b71-b591-e78501fd1ed9', 0, '002', '	{\"content\":\"服务很快，态度也相当不错，我代办了公司注册的业务，他们全程帮我代办，没有拖延，对于现在社会是相当难得可贵的，从代办的时间上，和对我提出要求的材料情况，可以肯定他们是专业的，我连会计都不用请了，代理记账我也选择他们。 \",\"date\":\"2018/5/16\"}', '1', 1, '/pub/d26f2f90f22842e4ae770cd50fc6628f/headimg3.png');
INSERT INTO `base_variable_data` VALUES ('9e7de9dd-3fd6-4d88-81ae-4ae0049ecb1b', 0, '5', '{\"title\":\"加急\",\"price\":\"2000\",\"unit\":\"元\",\"link\":\"/shoppingcart/productselection?productId=52a700f0-7d9c-403f-8317-4741d1d0e223\"}', '注册公司', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('a3357947-e536-462f-bdd3-1acaa6dd9751', 0, '11', '{\"title\":\"建筑作品\",\"price\":\"3000\",\"unit\":\"元\",\"link\":\"/shoppingcart/productselection?productId=174a8156-e38c-4ffe-9e0b-6ab770726d65\"}', '著作权', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('a45217cd-92ca-490f-b97e-bc770d64920b', 0, '3', '{\"title\":\"审计 （1000万以下）\",\"price\":\"7000\",\"unit\":\"元\",\"link\":\"/shoppingcart/productselection?productId=ce59af69-1c62-482c-b67d-c178a9a771dd\"}', '审计验资', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('a6587afe-5554-4739-b508-d4a443e46fae', 0, '3', '{\"title\":\"验资 （2000万以下）\",\"price\":\"3500\",\"unit\":\"元\",\"link\":\"/shoppingcart/productselection?productId=ce59af69-1c62-482c-b67d-c178a9a771dd\"}', '审计验资', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('a904441a-3a58-4f4e-9027-15a9301ee126', 0, '6', '{\"title\":\"地址\",\"price\":\"800\",\"unit\":\"元\",\"link\":\"/shoppingcart/productselection?productId=6dbdb3dc-2972-4710-8fdb-af72da83cb0e\"}', '公司变更', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('aad367ce-64fc-4690-a744-4649c6793541', 0, '001', '{\"content\":\"服务很快，态度也相当不错，我代办了公司注册的业务，他们全程帮我代办，没有拖延，对于现在社会是相当难得可贵的，从代办的时间上，和对我提出要求的材料情况，可以肯定他们是专业的，我连会计都不用请了，代理记账我也选择他们。 \",\"date\":\"2018/5/16\"}', '评价', 1, '/pub/fdede6d8540646dfa218f9deabb11741/headimg2.png');
INSERT INTO `base_variable_data` VALUES ('aae2d5e5-b95a-40e8-bc74-a56e3aafa689', 0, '11', '{\"title\":\"文字作品\",\"price\":\"1000\",\"unit\":\"元\",\"link\":\"/shoppingcart/productselection?productId=174a8156-e38c-4ffe-9e0b-6ab770726d65\"}', '著作权', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('ad3d344d-9617-4eb1-bf41-4dd52dee226c', 0, '10', '{\"title\":\"道路运输许可证\",\"price\":\"3000\",\"unit\":\"元\",\"link\":\"/shoppingcart/productselection?productId=cce8d9ee-e4db-4504-8a88-ac6d8e077ca1\"}', '行业资质', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('b2ef26bd-53d9-464a-81c6-28bec91c18c5', 0, '5', '{\"title\":\"分公司注册\",\"price\":\"500\",\"unit\":\"元起\",\"link\":\"/shoppingcart/productselection?productId=52a700f0-7d9c-403f-8317-4741d1d0e223\"}', '注册公司代办', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('b30f0783-c455-46c7-ae0b-3c0cbdd094e5', 0, '11', '{\"title\":\"计算机软件著作权登记\",\"price\":\"1200\",\"unit\":\"元\",\"link\":\"/shoppingcart/productselection?productId=174a8156-e38c-4ffe-9e0b-6ab770726d65\"}', '著作权', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('b54f70cb-3a94-4def-b01a-5fbe0d46b398', 0, '11', '{\"title\":\"杂技作品\",\"price\":\"1000\",\"unit\":\"元\",\"link\":\"/shoppingcart/productselection?productId=174a8156-e38c-4ffe-9e0b-6ab770726d65\"}', '著作权', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('be285ca6-0d8e-4886-afb2-48cb9cd0d8b2', 0, '4', '{\"title\":\"顾问咨询 （10000万以上）\",\"price\":\"60000\",\"unit\":\"元起\",\"link\":\"/shoppingcart/productselection?productId=409ebc76-30c9-4f92-afe4-1913997ff994\"}', '税收筹划', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('bf2a3ba4-f742-4e38-ba14-8dcea4d0fef9', 0, '11', '{\"title\":\"戏剧作品\",\"price\":\"1000\",\"unit\":\"元\",\"link\":\"/shoppingcart/productselection?productId=174a8156-e38c-4ffe-9e0b-6ab770726d65\"}', '著作权', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('c09347c9-021a-4aa3-be2f-6753fcd7221f', 0, '11', '{\"title\":\"曲艺作品\",\"price\":\"1000\",\"unit\":\"元\",\"link\":\"/shoppingcart/productselection?productId=174a8156-e38c-4ffe-9e0b-6ab770726d65\"}', '著作权', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('c3e5cef1-0296-46dd-b50a-925b310d9a1b', 0, '2', '{\"title\":\"完税证明开具\",\"price\":\"100\",\"unit\":\"元 起\",\"link\":\"/shoppingcart/productselection?productId=0c9c54dd-394a-488f-b12d-12a89b03d0e8\"}', '税务服务', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('c43d283b-3d25-4086-887f-07d4719ae8c1', 0, '11', '{\"title\":\"其他作品\",\"price\":\"3500\",\"unit\":\"元\",\"link\":\"/shoppingcart/productselection?productId=174a8156-e38c-4ffe-9e0b-6ab770726d65\"}', '著作权', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('c7fc1f22-71bf-4255-abcf-283dd7cd526e', 0, '10', '{\"title\":\"医疗器械（二类）许可证 \",\"price\":\"8000\",\"unit\":\"元\",\"link\":\"/shoppingcart/productselection?productId=cce8d9ee-e4db-4504-8a88-ac6d8e077ca1\"}', '行业资质', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('ce65b156-0efa-438d-a25c-42320590f2d1', 0, '5', '{\"title\":\"内资企业注册\",\"price\":\"500\",\"unit\":\"元起\",\"link\":\"/shoppingcart/productselection?productId=52a700f0-7d9c-403f-8317-4741d1d0e223\"}', '注册公司', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('ce691bdd-2a3b-4224-9079-a5a9a0935345', 0, '1', '{\"title\":\"基金（费）申报\",\"price\":\"200\",\"unit\":\"元/月 起\",\"link\":\"/shoppingcart/productselection?productId=5914a6bf-2b03-4b68-8f79-5b66d09185e0\"}', '代理记账', 6, NULL);
INSERT INTO `base_variable_data` VALUES ('d49f57bc-c21a-4413-9e9d-8a0c7e29d3bc', 0, '11', '{\"title\":\"电影作品\",\"price\":\"4000\",\"unit\":\"元\",\"link\":\"/shoppingcart/productselection?productId=174a8156-e38c-4ffe-9e0b-6ab770726d65\"}', '著作权', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('d761329c-023d-44aa-bb34-0600002af060', 0, '002', '	{\"content\":\"服务很快，态度也相当不错，我代办了公司注册的业务，他们全程帮我代办，没有拖延，对于现在社会是相当难得可贵的，从代办的时间上，和对我提出要求的材料情况，可以肯定他们是专业的，我连会计都不用请了，代理记账我也选择他们。 \",\"date\":\"2018/5/16\"}', '1', 1, '/pub/c7d22e941c8d44779d7dd330b159548c/headimg3.png');
INSERT INTO `base_variable_data` VALUES ('d8a12dfd-f091-4eed-99e3-fa5121605944', 0, '8', '{\"title\":\"登报公示\",\"price\":\"200\",\"unit\":\"元\",\"link\":\"/shoppingcart/productselection?productId=5b20630d-2127-4860-939c-1ef4e38f481b\"}', '公司注销', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('dd96568a-ca5f-461f-97fc-776ef74262d4', 0, '11', '{\"title\":\"模型作品\",\"price\":\"1800\",\"unit\":\"元\",\"link\":\"/shoppingcart/productselection?productId=174a8156-e38c-4ffe-9e0b-6ab770726d65\"}', '著作权', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('de4ac0b1-16d2-44ae-a927-66c4a47c0c28', 0, '002', '	{\"content\":\"服务很快，态度也相当不错，我代办了公司注册的业务，他们全程帮我代办，没有拖延，对于现在社会是相当难得可贵的，从代办的时间上，和对我提出要求的材料情况，可以肯定他们是专业的，我连会计都不用请了，代理记账我也选择他们。 \",\"date\":\"2018/5/16\"}', '1', 1, '/pub/9830c06e94d74dc7a8ea9e0bf4d5e3c0/headimg4.png');
INSERT INTO `base_variable_data` VALUES ('e23199be-115d-4fe6-92bb-e6b5348bd2ae', 0, '4', '{\"title\":\"顾问咨询 （500万以上）\",\"price\":\"20000\",\"unit\":\"元起\",\"link\":\"/shoppingcart/productselection?productId=409ebc76-30c9-4f92-afe4-1913997ff994\"}', '税收筹划', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('e2406b5b-9ca7-4d34-9bb0-da6edc1b23e4', 0, '11', '{\"title\":\"计算机软件著作权登记（加急）\",\"price\":\"1800\",\"unit\":\"元\",\"link\":\"/shoppingcart/productselection?productId=174a8156-e38c-4ffe-9e0b-6ab770726d65\"}', '著作权', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('e6a41832-003e-4336-a14e-c1f73ab90e73', 0, '13', '{\"title\":\"外观设计专利\",\"price\":\"1500\",\"unit\":\"元\",\"link\":\"/shoppingcart/productselection?productId=56b2765b-1396-45e8-b177-06a424538b45\"}', '专利', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('e6ebc7ae-572f-49a9-b651-578bb7673bad', 0, '13', '{\"title\":\"实用新型专利\",\"price\":\"2500\",\"unit\":\"元\",\"link\":\"/shoppingcart/productselection?productId=56b2765b-1396-45e8-b177-06a424538b45\"}', '专利', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('e896b47c-1d8a-4baf-9e1d-056ee3d74b39', 0, '14', '{\"title\":\"高成长性企业\",\"price\":\"20000\",\"unit\":\"元\",\"link\":\"/shoppingcart/productselection?productId=c8e5070d-de85-435e-8df5-5a11f52445f8\"}', '项目申报', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('e8f6266d-c11b-41e2-ba70-93fa884b9b1f', 0, '2', '{\"title\":\"清税申报\",\"price\":\"500\",\"unit\":\"元 起\",\"link\":\"/shoppingcart/productselection?productId=0c9c54dd-394a-488f-b12d-12a89b03d0e8\"}', '税务服务', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('eb4d050c-7d53-4b54-b2c4-0984782d8383', 0, '002', '	{\"content\":\"服务很快，态度也相当不错，我代办了公司注册的业务，他们全程帮我代办，没有拖延，对于现在社会是相当难得可贵的，从代办的时间上，和对我提出要求的材料情况，可以肯定他们是专业的，我连会计都不用请了，代理记账我也选择他们。 \",\"date\":\"2018/5/16\"}', '002描述', 1, '/pub/6e9c69e61d374aa79d643e577ca6e224/headimg4.png');
INSERT INTO `base_variable_data` VALUES ('ed0e0889-5a5b-47ff-a370-7e254f99b11a', 0, '12', '{\"title\":\"双享注册\",\"price\":\"1300\",\"unit\":\"元\",\"link\":\"/shoppingcart/productselection?productId=e67ad13c-e23e-4879-b4bf-54e0fac6c923\"}', '商标', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('ef5edd06-4df7-42f5-914e-28000514148e', 0, '3', '{\"title\":\"审计 （500万以下）\",\"price\":\"4000\",\"unit\":\"元\",\"link\":\"/shoppingcart/productselection?productId=ce59af69-1c62-482c-b67d-c178a9a771dd\"}', '审计验资', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('f11b38c4-e155-4a53-8d60-a38c4a86e3b6', 0, '10', '{\"title\":\"劳务派遣经营许可证\",\"price\":\"8000\",\"unit\":\"元\",\"link\":\"/shoppingcart/productselection?productId=cce8d9ee-e4db-4504-8a88-ac6d8e077ca1\"}', '行业资质', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('f3f5e4ce-864b-4cc0-b3ee-dc392317a36a', 0, '5', '{\"title\":\"外资企业注册\",\"price\":\"2000\",\"unit\":\"元起\",\"link\":\"/shoppingcart/productselection?productId=52a700f0-7d9c-403f-8317-4741d1d0e223\"}', '注册公司', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('f7d922b3-b7ed-45da-a818-6e4696e182c7', 0, '002', '	{\"content\":\"服务很快，态度也相当不错，我代办了公司注册的业务，他们全程帮我代办，没有拖延，对于现在社会是相当难得可贵的，从代办的时间上，和对我提出要求的材料情况，可以肯定他们是专业的，我连会计都不用请了，代理记账我也选择他们。 \",\"date\":\"2018/5/16\"}', 'sa', 1, '/pub/11fdc10168d34680b7546dddbbc36dd8/headimg2.png');
INSERT INTO `base_variable_data` VALUES ('fb32ad20-d633-4ff7-ba5b-13fa11937531', 0, '11', '{\"title\":\"摄影作品\",\"price\":\"1000\",\"unit\":\"元\",\"link\":\"/shoppingcart/productselection?productId=174a8156-e38c-4ffe-9e0b-6ab770726d65\"}', '著作权', 0, NULL);
INSERT INTO `base_variable_data` VALUES ('fd60812f-ba2e-4156-abcd-10b72caa2f11', 0, '10', '{\"title\":\"建筑安全生产许可证\",\"price\":\"15000\",\"unit\":\"元\",\"link\":\"/shoppingcart/productselection?productId=cce8d9ee-e4db-4504-8a88-ac6d8e077ca1\"}', '行业资质', 0, NULL);

-- ----------------------------
-- Table structure for base_weixin_msg_log
-- ----------------------------
DROP TABLE IF EXISTS `base_weixin_msg_log`;
CREATE TABLE `base_weixin_msg_log`  (
  `id` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `user_id` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '发送者id',
  `receive_id` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '接受用户id',
  `open_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'openid',
  `msg_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '消息id',
  `template_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '消息模板id',
  `send_time` datetime(0) NULL DEFAULT NULL COMMENT '发送时间',
  `recevie_status` int(11) NULL DEFAULT NULL COMMENT '接受状态',
  `wx_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `template_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '微信公众号消息发送记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_message_event
-- ----------------------------
DROP TABLE IF EXISTS `sys_message_event`;
CREATE TABLE `sys_message_event`  (
  `id` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `channel` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `event_info_json` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `has_done` int(11) NULL DEFAULT NULL,
  `create_time` datetime(0) NULL DEFAULT NULL,
  `sender_info` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `send_time` datetime(0) NULL DEFAULT NULL,
  `send_count` int(11) NULL DEFAULT NULL,
  `done_server` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `done_host` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `done_time` datetime(0) NULL DEFAULT NULL,
  `error_time` datetime(0) NULL DEFAULT NULL,
  `error_stack` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `remark` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '消息队列发送事件' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_message_event_error
-- ----------------------------
DROP TABLE IF EXISTS `sys_message_event_error`;
CREATE TABLE `sys_message_event_error`  (
  `id` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `message_id` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `channel` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `error_server` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `error_host` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `error_stack` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '消息队列发送异常日志' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_message_event_handle
-- ----------------------------
DROP TABLE IF EXISTS `sys_message_event_handle`;
CREATE TABLE `sys_message_event_handle`  (
  `id` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `event_id` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `listener_id` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `listener_class` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `has_done` int(11) NULL DEFAULT NULL COMMENT '是否已完成',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `done_server` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '完成服务host',
  `done_host` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `done_time` datetime(0) NULL DEFAULT NULL COMMENT '完成时间',
  `error_time` datetime(0) NULL DEFAULT NULL COMMENT '异常时间',
  `error_stack` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '异常信息',
  `remark` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `listener_unique`(`event_id`, `listener_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '消息事件处理记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_task
-- ----------------------------
DROP TABLE IF EXISTS `sys_task`;
CREATE TABLE `sys_task`  (
  `id` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '作业名称',
  `description` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `target_class` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '执行完整类名',
  `cron_expression` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '格式: [秒] [分] [小时] [日] [月] [周] [年]，如：2016年1月10日13点24分0秒 为 0 24 13 10 1 ? 2016 ',
  `arguments_map` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '传递到执行方法的参数',
  `last_server` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最后执行的作业服务器端',
  `last_time` datetime(0) NULL DEFAULT NULL COMMENT '最后执行时间',
  `disabled` bit(1) NOT NULL DEFAULT b'0' COMMENT '已禁用',
  `locking` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否锁定中，一般为一个作业服务端调用时锁定并排它',
  `create_time` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '调度作业' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_task
-- ----------------------------
INSERT INTO `sys_task` VALUES ('000000000000000000000000000000000001', 'demo', '测试作业', 'com.mj.he800.task.service.handler.DemoTaskHandler', '0 0/3 * * * ? *', '{\"a\":2}', '192.168.80.46:64397', '2018-07-30 13:39:00', b'1', b'0', '2017-08-03 04:58:24');

-- ----------------------------
-- Table structure for sys_task_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_task_log`;
CREATE TABLE `sys_task_log`  (
  `id` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `task_id` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `task_name` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '作业名称',
  `execute_over_time` datetime(0) NOT NULL COMMENT '执行完成时间',
  `task_fire_time` datetime(0) NOT NULL COMMENT '作业触发时间',
  `execute_success` bit(1) NOT NULL DEFAULT b'1' COMMENT '是否完整执行并未抛异常',
  `execute_exceptions` varchar(4000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '异常信息',
  `execute_server_host` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '执行作业服务端',
  `result_message` varchar(4000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '完成返回信息',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '调度作业日志' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for t_demo
-- ----------------------------
DROP TABLE IF EXISTS `t_demo`;
CREATE TABLE `t_demo`  (
  `t_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `t_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `t_address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `t_age` int(11) NULL DEFAULT NULL,
  `t_update_time` datetime(0) NULL DEFAULT NULL,
  `t_create_time` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`t_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Function structure for CAMEL_CASE
-- ----------------------------
DROP FUNCTION IF EXISTS `CAMEL_CASE`;
delimiter ;;
CREATE DEFINER=`root`@`%` FUNCTION `CAMEL_CASE`(`str` varchar(3000)) RETURNS varchar(3000) CHARSET utf8
BEGIN
	declare i int default 1;
	declare len int default LENGTH(str);
	declare s VARCHAR(1);
	declare re VARCHAR(3000) default '';
	myloop:loop
		if i > len then
			leave myloop;
		ELSE
			set s = SUBSTR(str, i, 1);
			if s = '_' then
				set i = i+1;
				set s = UPPER( SUBSTR(str, i, 1) );
			end if;
			set re = CONCAT(re, s);
		end if;
		set i = i+1;
  end loop; 

	RETURN re;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for GET_COLUMN
-- ----------------------------
DROP PROCEDURE IF EXISTS `GET_COLUMN`;
delimiter ;;
CREATE DEFINER=`root`@`%` PROCEDURE `GET_COLUMN`(IN `select_sql` varchar(2000), IN `is_camel_case`  tinyint(1))
    COMMENT '用于获得sql结果集的所有列名，拼接的字符串；\r\n参数1：自定义的select语句\r\n参数2：是否将列转换为驼峰形式'
BEGIN
	declare table_name varchar(36);
	declare v_sql varchar(4000);
	declare call_str varchar(100);
	if is_camel_case = 1 then
		set call_str = 'CAMEL_CASE(COLUMN_NAME)';
	else 
		set call_str = 'COLUMN_NAME';
	end if;

	set table_name = CONCAT('temp_', UUID_SHORT());
	set v_sql = concat('create table ', table_name, ' as (', select_sql, ')');
	set @v_sql=v_sql;
	prepare stmt from @v_sql;
	EXECUTE stmt;
	deallocate prepare stmt; 
	
	set v_sql = concat('SELECT CONCAT(\'"\', GROUP_CONCAT(', call_str,' SEPARATOR \'","\'), \'"\') as `columns` FROM information_schema.COLUMNS 
	WHERE TABLE_NAME = \'', table_name, '\'');
	set @v_sql=v_sql;
	prepare stmt from @v_sql;
	EXECUTE stmt;
	deallocate prepare stmt;
	
	set v_sql = concat('drop table if exists ', table_name);
	set @v_sql=v_sql;
	prepare stmt from @v_sql;
	EXECUTE stmt;
	deallocate prepare stmt; 
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for GET_COLUMN_ALIAS
-- ----------------------------
DROP PROCEDURE IF EXISTS `GET_COLUMN_ALIAS`;
delimiter ;;
CREATE DEFINER=`root`@`%` PROCEDURE `GET_COLUMN_ALIAS`(IN `select_sql` varchar(2000), IN `is_camel_case`  tinyint(1), IN `prefix`  varchar(100))
    COMMENT '用于获得sql结果集的所有列名，拼接的字符串；\r\n参数1：自定义的select语句\r\n参数2：是否将列转换为驼峰形式'
BEGIN
	declare table_name varchar(36);
	declare v_sql varchar(4000);
	declare call_str varchar(100);
	declare v_prefix varchar(100);
	if prefix is null THEN
		set v_prefix = '';
	else 
		set v_prefix = prefix;
	end if;
	if is_camel_case = 1 then
		set call_str = 'COLUMN_NAME,\' \',CAMEL_CASE(COLUMN_NAME)';
	else 
		set call_str = 'COLUMN_NAME';
	end if;

	set table_name = CONCAT('temp_', UUID_SHORT());
	set v_sql = concat('create table ', table_name, ' as (', select_sql, ')');
	set @v_sql=v_sql;
	prepare stmt from @v_sql;
	EXECUTE stmt;
	deallocate prepare stmt; 
	
	set v_sql = concat('SELECT CONCAT(\'',v_prefix,'\',GROUP_CONCAT(', call_str,' SEPARATOR \', ',v_prefix,'\')) as `columns` FROM information_schema.COLUMNS 
	WHERE TABLE_NAME = \'', table_name, '\'');
	set @v_sql=v_sql;
	prepare stmt from @v_sql;
	EXECUTE stmt;
	deallocate prepare stmt;
	
	set v_sql = concat('drop table if exists ', table_name);
	set @v_sql=v_sql;
	prepare stmt from @v_sql;
	EXECUTE stmt;
	deallocate prepare stmt; 
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
