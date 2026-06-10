/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80045 (8.0.45)
 Source Host           : localhost:3306
 Source Schema         : campus_photo_share

 Target Server Type    : MySQL
 Target Server Version : 80045 (8.0.45)
 File Encoding         : 65001

 Date: 10/06/2026 20:25:07
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for book_order
-- ----------------------------
DROP TABLE IF EXISTS `book_order`;
CREATE TABLE `book_order`  (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `photographer_id` int NOT NULL,
  `shoot_date` date NOT NULL,
  `shoot_place` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `requirement` varchar(800) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `order_status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '待确认',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`order_id`) USING BTREE,
  INDEX `fk_order_user`(`user_id` ASC) USING BTREE,
  INDEX `fk_order_photographer`(`photographer_id` ASC) USING BTREE,
  CONSTRAINT `fk_order_photographer` FOREIGN KEY (`photographer_id`) REFERENCES `photographer` (`photographer_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_order_user` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of book_order
-- ----------------------------
INSERT INTO `book_order` VALUES (1, 4, 1, '2026-06-20', '校园图书馆东侧草坪', '想拍一组简约毕业纪念照，服装以白衬衫为主。', '待确认', '2026-06-09 22:40:23');
INSERT INTO `book_order` VALUES (2, 4, 2, '2026-06-22', '校内湖边与主教学楼', '社团宣传照，需要偏纪实风格。', '已确认', '2026-06-09 22:40:23');

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment`  (
  `comment_id` int NOT NULL AUTO_INCREMENT,
  `work_id` int NOT NULL,
  `user_id` int NOT NULL,
  `content` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `status` tinyint NOT NULL DEFAULT 1,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`comment_id`) USING BTREE,
  INDEX `fk_comment_work`(`work_id` ASC) USING BTREE,
  INDEX `fk_comment_user`(`user_id` ASC) USING BTREE,
  CONSTRAINT `fk_comment_user` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_comment_work` FOREIGN KEY (`work_id`) REFERENCES `photo_work` (`work_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 53 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment` VALUES (1, 1, 4, '这组人像的光线很舒服，很适合毕业季参考。', 1, '2026-06-09 22:40:23');
INSERT INTO `comment` VALUES (2, 2, 4, '校园湖边拍出了很安静的感觉。', 1, '2026-06-09 22:40:23');
INSERT INTO `comment` VALUES (3, 3, 2, '静物布置简洁，适合做摄影社课程展示。', 0, '2026-06-09 22:40:23');
INSERT INTO `comment` VALUES (29, 49, 4, '光线拍得好自然，很适合毕业季参考！', 1, '2026-06-10 20:04:46');
INSERT INTO `comment` VALUES (30, 49, 7, '这个风格太喜欢了，已预约同款拍摄。', 1, '2026-06-10 20:04:46');
INSERT INTO `comment` VALUES (31, 50, 8, '拍的好可爱', 1, '2026-06-10 20:04:46');
INSERT INTO `comment` VALUES (32, 50, 9, '请问这种套餐多少钱？', 1, '2026-06-10 20:04:46');
INSERT INTO `comment` VALUES (33, 51, 10, '校园全景太壮观了！蓝天白云下的教学楼真美。', 1, '2026-06-10 20:04:46');
INSERT INTO `comment` VALUES (34, 51, 4, '每年三月都来这里拍照，今年终于有专业摄影师拍了。', 1, '2026-06-10 20:04:46');
INSERT INTO `comment` VALUES (35, 52, 7, '教学楼的建筑线条拍得好有设计感。', 1, '2026-06-10 20:04:46');
INSERT INTO `comment` VALUES (36, 53, 8, '图书馆外观不同光线下确实有不同的韵味。', 1, '2026-06-10 20:04:46');
INSERT INTO `comment` VALUES (37, 54, 9, '教室桌椅和窗外的光线，最熟悉的校园日常。', 1, '2026-06-10 20:04:46');
INSERT INTO `comment` VALUES (38, 54, 10, '好有怀旧感，想起每天上课的日子。', 1, '2026-06-10 20:04:46');
INSERT INTO `comment` VALUES (39, 55, 4, '图书馆内部好安静，书架与灯光营造出温暖的阅读空间。', 1, '2026-06-10 20:04:46');
INSERT INTO `comment` VALUES (40, 55, 7, '阳光透过窗户洒在桌面上，光影与书籍完美搭配。', 1, '2026-06-10 20:04:46');
INSERT INTO `comment` VALUES (41, 49, 4, '光线拍得好自然，很适合毕业季参考！', 1, '2026-06-10 20:06:39');
INSERT INTO `comment` VALUES (42, 49, 7, '这个风格太喜欢了，已预约同款拍摄。', 1, '2026-06-10 20:06:39');
INSERT INTO `comment` VALUES (45, 51, 10, '校园全景太壮观了！蓝天白云下的教学楼真美。', 1, '2026-06-10 20:06:39');
INSERT INTO `comment` VALUES (46, 51, 4, '每年三月都来这里拍照，今年终于有专业摄影师拍了。', 1, '2026-06-10 20:06:39');
INSERT INTO `comment` VALUES (47, 52, 7, '教学楼的建筑线条拍得好有设计感。', 1, '2026-06-10 20:06:39');
INSERT INTO `comment` VALUES (48, 53, 8, '图书馆外观不同光线下确实有不同的韵味。', 1, '2026-06-10 20:06:39');
INSERT INTO `comment` VALUES (49, 54, 9, '教室桌椅和窗外的光线，最熟悉的校园日常。', 1, '2026-06-10 20:06:39');
INSERT INTO `comment` VALUES (50, 54, 10, '好有怀旧感，想起每天上课的日子。', 1, '2026-06-10 20:06:39');
INSERT INTO `comment` VALUES (51, 55, 4, '图书馆内部好安静，书架与灯光营造出温暖的阅读空间。', 1, '2026-06-10 20:06:39');
INSERT INTO `comment` VALUES (52, 55, 7, '阳光透过窗户洒在桌面上，光影与书籍完美搭配。', 1, '2026-06-10 20:06:39');

-- ----------------------------
-- Table structure for photo_work
-- ----------------------------
DROP TABLE IF EXISTS `photo_work`;
CREATE TABLE `photo_work`  (
  `work_id` int NOT NULL AUTO_INCREMENT,
  `photographer_id` int NOT NULL,
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `work_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `image_url` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `description` varchar(800) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `is_recommend` tinyint NOT NULL DEFAULT 0,
  `audit_status` tinyint NOT NULL DEFAULT 1,
  `view_count` int NOT NULL DEFAULT 0,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`work_id`) USING BTREE,
  INDEX `fk_work_photographer`(`photographer_id` ASC) USING BTREE,
  CONSTRAINT `fk_work_photographer` FOREIGN KEY (`photographer_id`) REFERENCES `photographer` (`photographer_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 63 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of photo_work
-- ----------------------------
INSERT INTO `photo_work` VALUES (1, 1, '毕业季·学士服', '人像', 'Images/work-portrait.png', '毕业季定格青春最后的肆意', 1, 1, 67, '2026-06-09 22:40:23');
INSERT INTO `photo_work` VALUES (2, 2, '湖边晨色', '校园风景', 'Images/work-campus.png', '清晨湖面和教学楼倒影形成稳定的画面节奏，适合校园风景主题展示。', 1, 1, 80, '2026-06-09 22:40:23');
INSERT INTO `photo_work` VALUES (3, 1, '窗边静物', '静物', 'Images/work-still.png', '利用自然窗光拍摄相机、笔记本与干花，表达摄影学习的日常感。', 1, 1, 43, '2026-06-09 22:40:23');
INSERT INTO `photo_work` VALUES (4, 2, '教学楼光影', '校园风景', 'Images/hero-campus.png', '傍晚教学区的斜阳和行道树形成温暖层次，适合作为首页推荐作品。', 0, 1, 40, '2026-06-09 22:40:23');
INSERT INTO `photo_work` VALUES (49, 1, '清新人像·校园一角', '人像', 'Images/portrait/q.png', '校园角落的自然光人像，清新淡雅的色调记录青春瞬间。', 1, 1, 2, '2026-06-10 20:04:46');
INSERT INTO `photo_work` VALUES (50, 1, '可爱写真·光影交错', '人像', 'Images/portrait/qw.png', '可爱的动作和光影的运用让画面更有层次感。', 0, 1, 2, '2026-06-10 20:04:46');
INSERT INTO `photo_work` VALUES (51, 2, '校园风光·全景', '校园风景', 'Images/landscape/fj.jpg', '俯瞰校园全景，蓝天白云下的教学楼群格外壮观。', 1, 1, 1, '2026-06-10 20:04:46');
INSERT INTO `photo_work` VALUES (52, 2, '教学楼·建筑之美', '校园风景', 'Images/landscape/jiaoxuelou.jpg', '教学楼的几何线条与光影构成独特的建筑美感。', 0, 1, 1, '2026-06-10 20:04:46');
INSERT INTO `photo_work` VALUES (53, 2, '图书馆·知识殿堂', '校园风景', 'Images/landscape/tushuguan.jpg', '图书馆外观在不同光线下呈现出不同的韵味。', 0, 1, 1, '2026-06-10 20:04:46');
INSERT INTO `photo_work` VALUES (54, 3, '教室一角·日常', '静物', 'Images/StillLife/jiaoshi.jpg', '教室里整齐的桌椅和窗外透进的光线，最熟悉的校园日常。', 1, 1, 1, '2026-06-10 20:04:46');
INSERT INTO `photo_work` VALUES (55, 3, '图书馆内·静谧时光', '静物', 'Images/StillLife/tsg.jpg', '图书馆内部安静的氛围，书架与灯光营造出温暖的阅读空间。', 0, 1, 1, '2026-06-10 20:04:46');

-- ----------------------------
-- Table structure for photographer
-- ----------------------------
DROP TABLE IF EXISTS `photographer`;
CREATE TABLE `photographer`  (
  `photographer_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `nick_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `avatar` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'Images/work-portrait.png',
  `specialty` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `price` decimal(10, 2) NOT NULL DEFAULT 0.00,
  `intro` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `free_time` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `status` tinyint NOT NULL DEFAULT 1,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`photographer_id`) USING BTREE,
  INDEX `fk_photographer_user`(`user_id` ASC) USING BTREE,
  CONSTRAINT `fk_photographer_user` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of photographer
-- ----------------------------
INSERT INTO `photographer` VALUES (1, 2, '晨光影像', 'Images/sys/tx1.jpg', '人像写真、毕业照', 199.00, '擅长自然光校园人像，喜欢记录学生时代轻松真实的状态。', '周三下午、周六全天、周日晚', 1, '2026-06-09 22:40:23');
INSERT INTO `photographer` VALUES (2, 3, '远山摄影', 'Images/sys/tx2.png', '校园风景、活动跟拍', 159.00, '偏好清爽构图和纪实色彩，可承接社团活动、校园风景专题拍摄。', '周二晚上、周五下午、周日全天', 1, '2026-06-09 22:40:23');
INSERT INTO `photographer` VALUES (3, 5, '苏然影像', 'Images/sys/tx3.jpg', '静物、美食摄影', 129.00, '专注咖啡馆、书桌、花艺等静物拍摄，色调温暖治愈。', '周一全天、周四下午', 1, '2026-06-10 19:44:19');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `real_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `sex` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `phone` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `email` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `role` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'user',
  `status` tinyint NOT NULL DEFAULT 1,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`) USING BTREE,
  UNIQUE INDEX `user_name`(`user_name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 'admin', 'e10adc3949ba59abbe56e057f20f883e', '系统管理员', '男', '13800000000', 'admin@campus.local', 'admin', 1, '2026-06-09 22:40:23');
INSERT INTO `sys_user` VALUES (2, 'test', 'e10adc3949ba59abbe56e057f20f883e', '林晨', '女', '13800000001', 'test@campus.local', 'photographer', 1, '2026-06-09 22:40:23');
INSERT INTO `sys_user` VALUES (3, 'photo2', 'e10adc3949ba59abbe56e057f20f883e', '周远', '男', '13800000002', 'photo2@campus.local', 'photographer', 1, '2026-06-09 22:40:23');
INSERT INTO `sys_user` VALUES (4, 'student', 'e10adc3949ba59abbe56e057f20f883e', '陈同学', '女', '13800000003', 'student@campus.local', 'user', 1, '2026-06-09 22:40:23');
INSERT INTO `sys_user` VALUES (5, 'photo3', 'e10adc3949ba59abbe56e057f20f883e', '苏然', '女', '13800000004', 'photo3@campus.local', 'photographer', 1, '2026-06-10 19:44:10');
INSERT INTO `sys_user` VALUES (6, 'photo4', 'e10adc3949ba59abbe56e057f20f883e', '张昊', '男', '13800000005', 'photo4@campus.local', 'photographer', 1, '2026-06-10 19:44:10');
INSERT INTO `sys_user` VALUES (7, 'lihua', 'e10adc3949ba59abbe56e057f20f883e', '李华', '男', '13800000006', 'lihua@campus.local', 'user', 1, '2026-06-10 19:44:10');
INSERT INTO `sys_user` VALUES (8, 'wangmm', 'e10adc3949ba59abbe56e057f20f883e', '王萌萌', '女', '13800000007', 'wangmm@campus.local', 'user', 1, '2026-06-10 19:44:10');
INSERT INTO `sys_user` VALUES (9, 'zhangfei', 'e10adc3949ba59abbe56e057f20f883e', '张飞', '男', '13800000008', 'zhangfei@campus.local', 'user', 1, '2026-06-10 19:44:10');
INSERT INTO `sys_user` VALUES (10, 'liuyang', 'e10adc3949ba59abbe56e057f20f883e', '刘洋', '男', '13800000009', 'liuyang@campus.local', 'user', 1, '2026-06-10 19:44:10');
INSERT INTO `sys_user` VALUES (11, 'photo5', 'e10adc3949ba59abbe56e057f20f883e', '赵敏', '女', '13800000010', 'photo5@campus.local', 'photographer', 1, '2026-06-10 19:44:10');

SET FOREIGN_KEY_CHECKS = 1;
