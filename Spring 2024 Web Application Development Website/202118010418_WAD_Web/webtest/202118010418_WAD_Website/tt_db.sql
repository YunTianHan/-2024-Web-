/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80026
 Source Host           : localhost:3306
 Source Schema         : tt_db

 Target Server Type    : MySQL
 Target Server Version : 80026
 File Encoding         : 65001

 Date: 15/05/2024 19:08:08
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for tb_course
-- ----------------------------
DROP TABLE IF EXISTS `tb_course`;
CREATE TABLE `tb_course`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `teacher_id` int NULL DEFAULT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `start_time` date NULL DEFAULT NULL,
  `end_time` date NULL DEFAULT NULL,
  `status` smallint NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `teacher_id`(`teacher_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_course
-- ----------------------------
INSERT INTO `tb_course` VALUES (4, '12345', 2, '2', '2024-05-16', '2025-05-16', 0);
INSERT INTO `tb_course` VALUES (5, '1235', 2, 'description1', '2024-05-16', '2025-05-16', 0);
INSERT INTO `tb_course` VALUES (7, '2', 2, 'description1', '2024-05-16', '2025-05-16', 0);
INSERT INTO `tb_course` VALUES (8, '2', 2, 'd12321321', '2024-05-16', '2025-05-16', 0);
INSERT INTO `tb_course` VALUES (9, '2', 2, 'd12321321232131', '2024-05-16', '2025-05-16', 0);
INSERT INTO `tb_course` VALUES (10, '2', 2, 'd12321321123123232131', '2024-05-16', '2025-05-16', 0);

-- ----------------------------
-- Table structure for tb_course_selection
-- ----------------------------
DROP TABLE IF EXISTS `tb_course_selection`;
CREATE TABLE `tb_course_selection`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_id` int NULL DEFAULT NULL,
  `course_id` int NULL DEFAULT NULL,
  `status` smallint NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `student_id`(`student_id`) USING BTREE,
  INDEX `course_id`(`course_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_course_selection
-- ----------------------------
INSERT INTO `tb_course_selection` VALUES (1, 1, 4, 1);
INSERT INTO `tb_course_selection` VALUES (3, 2, 7, 1);
INSERT INTO `tb_course_selection` VALUES (4, 2, 8, 0);

-- ----------------------------
-- Table structure for tb_courseware
-- ----------------------------
DROP TABLE IF EXISTS `tb_courseware`;
CREATE TABLE `tb_courseware`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `course_id` int NULL DEFAULT NULL,
  `name` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `file_path` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `type` smallint NULL DEFAULT 0 COMMENT '0: 课件 1:讲座',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `course_id`(`course_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_courseware
-- ----------------------------
INSERT INTO `tb_courseware` VALUES (2, 2, 'name1', 'path213', 0, '12321312');
INSERT INTO `tb_courseware` VALUES (3, 2, 'name', 'path', 0, '123');

-- ----------------------------
-- Table structure for tb_discussion
-- ----------------------------
DROP TABLE IF EXISTS `tb_discussion`;
CREATE TABLE `tb_discussion`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NULL DEFAULT NULL,
  `title` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `add_time` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `parent_id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_discussion
-- ----------------------------
INSERT INTO `tb_discussion` VALUES (4, 2, 'title', 'content', '2024-05-15 18:30:00', '');

-- ----------------------------
-- Table structure for tb_email
-- ----------------------------
DROP TABLE IF EXISTS `tb_email`;
CREATE TABLE `tb_email`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `sender_id` int NULL DEFAULT NULL,
  `receiver_id` int NULL DEFAULT NULL,
  `subject` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `send_time` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sender_id`(`sender_id`) USING BTREE,
  INDEX `receiver_id`(`receiver_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_email
-- ----------------------------
INSERT INTO `tb_email` VALUES (1, 2, 4, 'hello', 'content', '2024-05-15 19:00:00');

-- ----------------------------
-- Table structure for tb_homework
-- ----------------------------
DROP TABLE IF EXISTS `tb_homework`;
CREATE TABLE `tb_homework`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `course_id` int NULL DEFAULT NULL,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `file_path` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `end_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `course_id`(`course_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_homework
-- ----------------------------
INSERT INTO `tb_homework` VALUES (2, 7, 'name', 'description', 'path', '2024-05-15 18:00:00');

-- ----------------------------
-- Table structure for tb_homework_answer
-- ----------------------------
DROP TABLE IF EXISTS `tb_homework_answer`;
CREATE TABLE `tb_homework_answer`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `homework_id` int NULL DEFAULT NULL,
  `user_id` int NULL DEFAULT NULL,
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `file_path` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `score` decimal(10, 2) NULL DEFAULT NULL,
  `add_time` datetime NULL DEFAULT NULL,
  `feedback` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_homework_answer
-- ----------------------------
INSERT INTO `tb_homework_answer` VALUES (4, 2, 2, '作业描述', '附带文件', NULL, '2024-05-15 18:15:00', 'good');

-- ----------------------------
-- Table structure for tb_news
-- ----------------------------
DROP TABLE IF EXISTS `tb_news`;
CREATE TABLE `tb_news`  (
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_news
-- ----------------------------
INSERT INTO `tb_news` VALUES ('1234');

-- ----------------------------
-- Table structure for tb_user
-- ----------------------------
DROP TABLE IF EXISTS `tb_user`;
CREATE TABLE `tb_user`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `identity` smallint NULL DEFAULT 0 COMMENT '0: admin 1: teacher  2: student',
  `sex` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `age` int NULL DEFAULT NULL,
  `add_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_user
-- ----------------------------
INSERT INTO `tb_user` VALUES (2, 'teacher', 'c4ca4238a0b923820dcc509a6f75849b', 1, 'girls', 25, '2024-05-14 02:00:00');
INSERT INTO `tb_user` VALUES (4, 'admin', 'c4ca4238a0b923820dcc509a6f75849b', 0, 'boy', 15, '2024-05-15 02:00:00');

SET FOREIGN_KEY_CHECKS = 1;
