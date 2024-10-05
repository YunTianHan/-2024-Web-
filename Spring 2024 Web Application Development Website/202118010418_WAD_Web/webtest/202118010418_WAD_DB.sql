/*
 Navicat Premium Data Transfer

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 80036 (8.0.36)
 Source Host           : localhost:3306
 Source Schema         : tt_db

 Target Server Type    : MySQL
 Target Server Version : 80036 (8.0.36)
 File Encoding         : 65001

 Date: 25/05/2024 22:20:29
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for tb_course
-- ----------------------------
DROP TABLE IF EXISTS `tb_course`;
CREATE TABLE `tb_course`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `teacher_id` int NULL DEFAULT NULL,
  `description` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL,
  `start_time` date NULL DEFAULT NULL,
  `end_time` date NULL DEFAULT NULL,
  `status` smallint NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `teacher_id`(`teacher_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_course
-- ----------------------------
INSERT INTO `tb_course` VALUES (4, '12345', 2, '2', '2024-05-16', '2025-05-16', 0);
INSERT INTO `tb_course` VALUES (5, '1235', 2, 'description1', '2024-05-16', '2025-05-16', 0);
INSERT INTO `tb_course` VALUES (11, 'courses', 2, 'Descriptions', '2024-05-20', '2024-07-04', 0);
INSERT INTO `tb_course` VALUES (13, 'WAD', 2, 'Good Course!', '2024-05-22', '2024-06-22', 0);
INSERT INTO `tb_course` VALUES (14, 'DSA', 2, 'aaaa', '2024-05-25', '2024-06-05', 0);

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
  INDEX `student_id`(`student_id` ASC) USING BTREE,
  INDEX `course_id`(`course_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_course_selection
-- ----------------------------
INSERT INTO `tb_course_selection` VALUES (1, 1, 4, 1);
INSERT INTO `tb_course_selection` VALUES (3, 2, 7, 1);
INSERT INTO `tb_course_selection` VALUES (5, 5, 4, 1);
INSERT INTO `tb_course_selection` VALUES (7, 5, 12, 1);
INSERT INTO `tb_course_selection` VALUES (9, 5, 8, -1);
INSERT INTO `tb_course_selection` VALUES (16, 5, 11, 1);
INSERT INTO `tb_course_selection` VALUES (17, 5, 5, 1);

-- ----------------------------
-- Table structure for tb_courseware
-- ----------------------------
DROP TABLE IF EXISTS `tb_courseware`;
CREATE TABLE `tb_courseware`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `course_id` int NULL DEFAULT NULL,
  `name` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `file_path` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `type` smallint NULL DEFAULT 0 COMMENT '0: 课件 1:讲座',
  `content` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `course_id`(`course_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_courseware
-- ----------------------------
INSERT INTO `tb_courseware` VALUES (11, 4, '12345_Lecture_11', '/file/202118010418_IPD_CV.pdf', 1, 'This is lecture1.111');
INSERT INTO `tb_courseware` VALUES (12, 11, 'courses_Lecture_6', '/file/specification-part-c_2.docx', 1, '....');
INSERT INTO `tb_courseware` VALUES (13, 13, 'WAD_Lecture_7', '', 1, 'aaaa');
INSERT INTO `tb_courseware` VALUES (14, 5, 'aaa', '/file/specification-part-c_2.docx', 1, 'aaa');

-- ----------------------------
-- Table structure for tb_discussion
-- ----------------------------
DROP TABLE IF EXISTS `tb_discussion`;
CREATE TABLE `tb_discussion`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NULL DEFAULT NULL,
  `title` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `content` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL,
  `add_time` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `parent_id` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_discussion
-- ----------------------------
INSERT INTO `tb_discussion` VALUES (4, 2, 'title', 'content', '2024-05-15 18:30:00', '');
INSERT INTO `tb_discussion` VALUES (5, 4, '', '123', '2024-05-17 16:19:40', '4');
INSERT INTO `tb_discussion` VALUES (6, 4, 'forum', 'hahha', '2024-05-17 17:51:58', '');
INSERT INTO `tb_discussion` VALUES (7, 4, '', '12321', '2024-05-17 17:52:01', '6');
INSERT INTO `tb_discussion` VALUES (8, 4, 'aaa', 'aaaa', '2024-05-20 11:25:46', '');
INSERT INTO `tb_discussion` VALUES (9, 4, '', 'bbbb', '2024-05-20 11:25:55', '8');
INSERT INTO `tb_discussion` VALUES (10, 4, '', 'aa', '2024-05-20 15:36:23', '8');
INSERT INTO `tb_discussion` VALUES (11, 4, 'aaa', 'aaaa', '2024-05-20 15:36:49', '');

-- ----------------------------
-- Table structure for tb_email
-- ----------------------------
DROP TABLE IF EXISTS `tb_email`;
CREATE TABLE `tb_email`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `sender_id` int NULL DEFAULT NULL,
  `receiver_id` int NULL DEFAULT NULL,
  `subject` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `content` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL,
  `send_time` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sender_id`(`sender_id` ASC) USING BTREE,
  INDEX `receiver_id`(`receiver_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_email
-- ----------------------------
INSERT INTO `tb_email` VALUES (1, 2, 4, 'hello', 'content', '2024-05-15 19:00:00');
INSERT INTO `tb_email` VALUES (2, 4, 5, 'hello', '123', '2024-05-17 17:51:14');
INSERT INTO `tb_email` VALUES (3, 4, 5, 'aa', 'aaa', '2024-05-20 11:24:27');

-- ----------------------------
-- Table structure for tb_homework
-- ----------------------------
DROP TABLE IF EXISTS `tb_homework`;
CREATE TABLE `tb_homework`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `course_id` int NULL DEFAULT NULL,
  `name` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `description` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL,
  `file_path` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL,
  `end_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `course_id`(`course_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_homework
-- ----------------------------
INSERT INTO `tb_homework` VALUES (2, 4, 'name', 'description', 'path', '2024-05-15 18:00:00');
INSERT INTO `tb_homework` VALUES (6, 12, 'aaa', 'aaaa', '/file/2022.pdf', '2024-05-31 07:59:59');
INSERT INTO `tb_homework` VALUES (7, 12, 'aaa', 'aaaaa', '/file/2024.pdf', '2024-05-31 09:10:20');
INSERT INTO `tb_homework` VALUES (8, 11, 'Homework_9', 'ssss', '/file/202118010418_IPD_CV.pdf', '2024-07-28 02:54:19');
INSERT INTO `tb_homework` VALUES (9, 11, 'Homework_8', '1111', '/file/202118010418_IPD_CV.pdf', '2024-06-27 02:55:38');
INSERT INTO `tb_homework` VALUES (10, 13, 'Volunteer activities', 'ssss', '', '2024-06-21 11:39:40');

-- ----------------------------
-- Table structure for tb_homework_answer
-- ----------------------------
DROP TABLE IF EXISTS `tb_homework_answer`;
CREATE TABLE `tb_homework_answer`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `homework_id` int NULL DEFAULT NULL,
  `user_id` int NULL DEFAULT NULL,
  `content` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL,
  `file_path` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `score` decimal(10, 2) NULL DEFAULT NULL,
  `add_time` datetime NULL DEFAULT NULL,
  `feedback` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_homework_answer
-- ----------------------------
INSERT INTO `tb_homework_answer` VALUES (4, 2, 2, '作业描述', '附带文件', 80.00, '2024-05-15 18:15:00', 'goods');
INSERT INTO `tb_homework_answer` VALUES (5, 3, 5, '123123', '/file/1.pdf', 80.00, '2024-05-17 18:15:41', '123');
INSERT INTO `tb_homework_answer` VALUES (6, 3, 5, '123', '/file/1.pdf', 99.00, '2024-05-17 18:18:31', 'good');
INSERT INTO `tb_homework_answer` VALUES (7, 6, 5, 'aaaa', '/file/2022.pdf', NULL, '2024-05-20 16:00:40', NULL);
INSERT INTO `tb_homework_answer` VALUES (8, 9, 5, 'aaaa', '/file/202118010418_IPD_CV.pdf', NULL, '2024-05-22 11:08:34', NULL);

-- ----------------------------
-- Table structure for tb_news
-- ----------------------------
DROP TABLE IF EXISTS `tb_news`;
CREATE TABLE `tb_news`  (
  `content` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_news
-- ----------------------------
INSERT INTO `tb_news` VALUES ('Announcement: Hello World!');

-- ----------------------------
-- Table structure for tb_user
-- ----------------------------
DROP TABLE IF EXISTS `tb_user`;
CREATE TABLE `tb_user`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `identity` smallint NULL DEFAULT 0 COMMENT '0: admin 1: teacher  2: student',
  `sex` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `age` int NULL DEFAULT NULL,
  `add_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_user
-- ----------------------------
INSERT INTO `tb_user` VALUES (2, 'teacher', 'c4ca4238a0b923820dcc509a6f75849b', 1, 'girls', 25, '2024-05-14 02:00:00');
INSERT INTO `tb_user` VALUES (4, 'admin', 'c4ca4238a0b923820dcc509a6f75849b', 0, 'boy', 15, '2024-05-15 02:00:00');
INSERT INTO `tb_user` VALUES (5, 'student', 'c4ca4238a0b923820dcc509a6f75849b', 2, 'Boys', 22, '2024-05-17 17:49:13');
INSERT INTO `tb_user` VALUES (8, 'teacher2', 'c4ca4238a0b923820dcc509a6f75849b', 1, 'Male', 19, '2024-05-22 10:32:44');

SET FOREIGN_KEY_CHECKS = 1;
