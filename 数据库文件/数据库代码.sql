SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for flasksql
-- ----------------------------
DROP TABLE IF EXISTS `flasksql`;
CREATE TABLE `flasksql`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE,
  UNIQUE INDEX `email`(`email`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of flasksql
-- ----------------------------
INSERT INTO `flasksql` VALUES (4, 'zyx', 'root@zyx.com');

-- ----------------------------
-- Table structure for scene_project_list
-- ----------------------------
DROP TABLE IF EXISTS `scene_project_list`;
CREATE TABLE `scene_project_list`  (
  `projectId` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `userId` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `projectName` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `createTime` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `introduction` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '项目描述',
  `deleted` tinyint(5) NULL DEFAULT NULL COMMENT '是否删除',
  PRIMARY KEY (`projectId`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of scene_project_list
-- ----------------------------
INSERT INTO `scene_project_list` VALUES ('qpt-v3TEYB1yY0o4n7GgC', 'admin', '项目3', '2021-08-20 16:40:12', '这是测试项目3', 0);
INSERT INTO `scene_project_list` VALUES ('CjoWxBbdjiQ9rBKIeLxPs', 'admin', '项目4', '2021-09-15 19:40:00', '这是测试项目4', 0);
INSERT INTO `scene_project_list` VALUES ('UP-ZhUk1op5tnuq2GfGTw', 'admin', '项目2', '2021-08-17 18:40:12', '这是测试项目2', 0);
INSERT INTO `scene_project_list` VALUES ('R-2HTPWZyZEosmiPQa6Gh', 'admin', '公司门禁', '2021-08-15 13:40:12', '这是测试项目1这是测试项目1这是测试项目1这是测试项目1', 0);
INSERT INTO `scene_project_list` VALUES ('kq9HbA6Zg-u6yAim2s8V', 'admin', '小区门禁', '2021-10-20 21:53:00', '测试', 0);
INSERT INTO `scene_project_list` VALUES ('bLQjothglOLVx7-5euZc', 'admin', '高校寝室门禁', '2021-10-20 22:06:29', '新测试新测试', 0);
INSERT INTO `scene_project_list` VALUES ('xhEUPEaQZ0hvFp1NCp_n', 'admin', '测试项目', '2021-10-24 16:09:21', '', 0);
INSERT INTO `scene_project_list` VALUES ('-WlbxPlXqW94hAFhVlIJ', 'admin', '高校校园测试', '2021-10-24 16:14:39', '', 0);
INSERT INTO `scene_project_list` VALUES ('iX0CTPZaysVUcvtUlvR5', 'admin', '开发测试', '2021-10-26 14:27:31', '', 0);
INSERT INTO `scene_project_list` VALUES ('DX5xcw8cwPzAG-05hCK9', 'admin', '演示测试', '2021-11-07 17:33:21', '演示测试\n', 0);

-- ----------------------------
-- Table structure for scene_test_list
-- ----------------------------
DROP TABLE IF EXISTS `scene_test_list`;
CREATE TABLE `scene_test_list`  (
  `id` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `projectId` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `sdkVersion` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `testName` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `sceneName` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `allowThreshold` int(11) NULL DEFAULT NULL,
  `thresholdmodelBGR` float NULL DEFAULT NULL,
  `thresholdmodelIR` float NULL DEFAULT NULL,
  `similarityThresholdLow` float NULL DEFAULT NULL,
  `similarityThresholdHigh` float NULL DEFAULT NULL,
  `testModel` int(11) NULL DEFAULT NULL,
  `allowCover` int(11) NULL DEFAULT NULL,
  `allowFace` int(11) NULL DEFAULT NULL,
  `allowGender` int(11) NULL DEFAULT NULL,
  `allowNum` int(11) NULL DEFAULT NULL,
  `allowBack` int(11) NULL DEFAULT NULL,
  `allowLightType` int(11) NULL DEFAULT NULL,
  `allowLightIntensity` int(11) NULL DEFAULT NULL,
  `allowConcurrent` int(11) NULL DEFAULT NULL,
  `allowDistanceLow` int(11) NULL DEFAULT NULL,
  `allowDistanceHigh` int(11) NULL DEFAULT NULL,
  `hopeFAR` float NULL DEFAULT NULL,
  `hopeFRR` float NULL DEFAULT NULL,
  `createTime` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `startTime` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `completeTime` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `testState` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `deleted` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of scene_test_list
-- ----------------------------
INSERT INTO `scene_test_list` VALUES ('TJS19Jk37E3RGvRS_kQx', 'R-2HTPWZyZEosmiPQa6Gh', '30', 'Demo', 'scene1', 0, 0.5, 0.7, 0.95, 0.95, 1, 0, 0, 0, 0, 0, 0, 0, 0, 10, 30, 0, 0, '2021-09-20 14:13:04', '', '2021-09-21 11:08:00', 'Completed', 0);
INSERT INTO `scene_test_list` VALUES ('qaiyXHHjcybGzCpPa1iB', 'R-2HTPWZyZEosmiPQa6Gh', '30', 'school123', 'scene1', 0, 0.5, 0.7, 0.95, 0.95, 1, 0, 0, 0, 0, 0, 0, 0, 0, 10, 30, 0, 0, '2021-09-20 14:12:37', '', '', 'Error', 0);
INSERT INTO `scene_test_list` VALUES ('FVhEHXuBMeY844UwDpvV', 'R-2HTPWZyZEosmiPQa6Gh', '30', 'sceneLaLaLa', 'scene1', 0, 0.5, 0.7, 0.95, 0.95, 1, 0, 0, 0, 0, 0, 0, 0, 0, 10, 30, 0, 0, '2021-09-20 14:11:19', '', '2021-09-20 18:10:07', 'Completed', 0);
INSERT INTO `scene_test_list` VALUES ('_jUO5PMuKD74olB8dWoI', 'iX0CTPZaysVUcvtUlvR5', '30', '567', 'genscene', 0, 0.5, 0.7, 0, 1, 2, 0, 1, 0, 0, 0, 0, 0, 0, 40, 80, 0.2, 0.2, '2021-11-07 17:20:36', '2021-11-07 17:21:43', '', 'Running', 0);
INSERT INTO `scene_test_list` VALUES ('eSZxt4M3RXQqWLkAqmCN', 'R-2HTPWZyZEosmiPQa6Gh', '30', 'scene1', 'scene1', 0, 0.5, 0.7, 0.95, 0.95, 1, 0, 0, 0, 0, 0, 0, 0, 0, 10, 30, 0, 0, '2021-09-20 14:10:07', '', '2021-09-20 15:10:07', 'Completed', 0);
INSERT INTO `scene_test_list` VALUES ('QM--7srHYc32ZFcFSwsV', 'R-2HTPWZyZEosmiPQa6Gh', '30', 'school123', 'scene1', 0, 0.5, 0.7, 0.95, 0.95, 1, 0, 0, 0, 0, 0, 0, 0, 0, 10, 30, 0, 0, '2021-09-20 14:09:45', '', '', 'Error', 0);
INSERT INTO `scene_test_list` VALUES ('g21YqVgX3KBKR511GAqt', 'R-2HTPWZyZEosmiPQa6Gh', '30', 'testtest', 'scene1', 0, 0.5, 0.7, 0.95, 0.95, 1, 0, 0, 0, 0, 0, 0, 0, 0, 10, 30, 0, 0, '2021-09-20 14:07:01', '', '', 'Running', 0);
INSERT INTO `scene_test_list` VALUES ('F53pzPTlBLBXGlrYvIKC', 'R-2HTPWZyZEosmiPQa6Gh', '30', 'lalala', 'scene1', 0, 0.5, 0.7, 0.95, 0.95, 1, 0, 0, 0, 0, 0, 0, 0, 0, 10, 30, 0, 0, '2021-09-20 14:06:02', '', '', 'Running', 0);
INSERT INTO `scene_test_list` VALUES ('ITlY6_gVBXz9r4oS2d_w', 'R-2HTPWZyZEosmiPQa6Gh', '30', 'school', 'scene1', 1, 0.5, 0.7, 0.95, 0.95, 1, 0, 0, 0, 0, 0, 0, 0, 0, 10, 30, 0.2, 0.1, '2021-09-20 14:03:00', '', '', 'Completed', 0);
INSERT INTO `scene_test_list` VALUES ('WDnkSJ5wJuUFVUL-Dy0C', 'R-2HTPWZyZEosmiPQa6Gh', '30', 'SceneTest1', 'scene1', 0, 0.5, 0.7, 0.95, 0.95, 1, 0, 0, 0, 0, 0, 0, 0, 0, 10, 30, 0, 0, '2021-09-20 13:56:40', '2021-10-26 18:52:17', '2021-10-26 18:52:37', 'Completed', 0);
INSERT INTO `scene_test_list` VALUES ('Wb44HTd_ypKOeaWJY1Hv', 'kq9HbA6Zg-u6yAim2s8V', '30', '测试100', 'scene1', 1, 0.5, 0.7, 0.5, 0.85, 2, 0, 0, 0, 0, 0, 0, 0, 0, 40, 80, 0.1, 0.1, '2021-10-20 21:53:23', '2021-10-20 21:53:25', '2021-10-20 21:53:40', 'Completed', 0);
INSERT INTO `scene_test_list` VALUES ('s3JKPm3KEd1n3-nF9NMc', 'kq9HbA6Zg-u6yAim2s8V', '30', '123', 'scene1', 1, 0.5, 0.7, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 40, 80, 0.1, 0.1, '2021-10-20 21:54:25', '2021-10-20 21:54:26', '2021-10-20 21:54:39', 'Completed', 0);
INSERT INTO `scene_test_list` VALUES ('dVDtFmIDEwQRYVJeJMtQ', 'kq9HbA6Zg-u6yAim2s8V', '30', '123123', 'scene1', 0, 0.5, 0.7, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 40, 80, 0.1, 0.1, '2021-10-20 21:55:56', '2021-10-20 21:55:58', '2021-10-20 21:56:10', 'Completed', 0);
INSERT INTO `scene_test_list` VALUES ('rx4ivvb_F7CK8cRwqvLV', 'kq9HbA6Zg-u6yAim2s8V', '30', '1231231', 'scene1', 0, 0.5, 0.7, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 40, 80, 0.1, 0.1, '2021-10-20 21:57:10', '2021-10-20 21:57:11', '2021-10-20 21:57:22', 'Completed', 0);
INSERT INTO `scene_test_list` VALUES ('f_Dqe-eVCgspICzLodwW', 'kq9HbA6Zg-u6yAim2s8V', '30', '12312312', 'genscene', 1, 0.5, 0.7, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 40, 80, 0.1, 0.1, '2021-10-20 21:58:13', '2021-10-20 21:58:15', '2021-10-20 22:00:45', 'Completed', 0);
INSERT INTO `scene_test_list` VALUES ('dalasDvuvchkg_iu5dgD', 'kq9HbA6Zg-u6yAim2s8V', '30', '1000', 'genscene', 1, 0.5, 0.7, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 40, 80, 0.1, 0.1, '2021-10-20 22:02:02', '2021-10-20 22:02:04', '2021-10-20 22:04:30', 'Completed', 0);
INSERT INTO `scene_test_list` VALUES ('vNM-d87djQsQHwDVvDjK', 'bLQjothglOLVx7-5euZc', '30', '测试123', 'genscene', 1, 0.5, 0.7, 0.3, 0.85, 2, 0, 0, 0, 0, 0, 0, 0, 0, 40, 80, 0.3, 0.45, '2021-10-20 22:07:09', '2021-10-20 22:07:21', '2021-10-20 22:09:47', 'Completed', 0);
INSERT INTO `scene_test_list` VALUES ('NfpSq_4q9FkB2AcRBJMX', 'xhEUPEaQZ0hvFp1NCp_n', '30', '校园门禁', 'genscene', 0, 0.5, 0.7, 0.15, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 40, 80, 0.3, 0.3, '2021-10-24 16:09:57', '2021-10-24 16:10:03', '', 'Running', 0);
INSERT INTO `scene_test_list` VALUES ('o2ffAv_1HRq7oHO-sOrw', 'xhEUPEaQZ0hvFp1NCp_n', '30', 'sdf', 'scene1', 0, 0.5, 0.7, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 40, 80, 0.1, 0.1, '2021-10-24 16:13:18', '2021-10-24 16:13:20', '2021-10-24 16:13:47', 'Completed', 0);
INSERT INTO `scene_test_list` VALUES ('ywt6XbnlrCq3KsHIDNMR', '-WlbxPlXqW94hAFhVlIJ', '30', '校园门禁', 'genscene', 1, 0.5, 0.7, 0.2, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 40, 80, 0.3, 0.3, '2021-10-24 16:15:09', '2021-10-24 16:15:13', '2021-10-24 16:19:39', 'Completed', 0);
INSERT INTO `scene_test_list` VALUES ('CESR_GDLboLgnilkbpaj', '-WlbxPlXqW94hAFhVlIJ', '30', '123123', 'scene1', 0, 0.5, 0.7, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 40, 80, 0.1, 0.1, '2021-10-24 16:24:17', '2021-10-24 16:24:21', '2021-10-24 16:24:34', 'Completed', 0);
INSERT INTO `scene_test_list` VALUES ('mRh7hFOn7xCMZ8ug5a6F', '-WlbxPlXqW94hAFhVlIJ', '30', '123123', 'scene1', 0, 0.5, 0.7, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 40, 80, 0.1, 0.1, '2021-10-24 16:25:16', '2021-10-24 16:25:21', '2021-10-24 16:25:35', 'Completed', 0);
INSERT INTO `scene_test_list` VALUES ('xS6w5BIH5q2ho5PVcL_G', '-WlbxPlXqW94hAFhVlIJ', '30', '3516546', 'scene1', 0, 0.5, 0.7, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 40, 80, 0.1, 0.1, '2021-10-24 16:26:11', '2021-10-24 16:26:13', '2021-10-24 16:26:28', 'Completed', 0);
INSERT INTO `scene_test_list` VALUES ('NjsfY_n0JRNQediNkqch', '-WlbxPlXqW94hAFhVlIJ', '30', '6546465', 'scene1', 0, 0.5, 0.7, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 40, 80, 0.1, 0.1, '2021-10-24 16:31:39', '2021-10-24 16:31:41', '2021-10-24 16:31:54', 'Completed', 0);
INSERT INTO `scene_test_list` VALUES ('1kDy38s9gArKhRKpJ2GO', '-WlbxPlXqW94hAFhVlIJ', '30', '6546546', 'scene1', 0, 0.5, 0.7, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 40, 80, 0.1, 0.1, '2021-10-24 16:40:42', '2021-10-24 16:40:44', '2021-10-24 16:40:57', 'Completed', 0);
INSERT INTO `scene_test_list` VALUES ('bnQde1ZAM1ltOdbkNVVB', '-WlbxPlXqW94hAFhVlIJ', '30', '2ese', 'scene1', 0, 0.5, 0.7, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 40, 80, 0.1, 0.1, '2021-10-24 16:42:23', '2021-10-24 16:42:25', '2021-10-24 16:42:38', 'Completed', 0);
INSERT INTO `scene_test_list` VALUES ('xotoThG4yvt_3Q7HOs_N', '-WlbxPlXqW94hAFhVlIJ', '30', '5465465', 'scene1', 0, 0.5, 0.7, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 40, 80, 0.1, 0.1, '2021-10-24 16:48:59', '2021-10-24 16:49:01', '2021-10-24 16:49:16', 'Completed', 0);
INSERT INTO `scene_test_list` VALUES ('QemYByp0pfMCY9KfpZnz', '-WlbxPlXqW94hAFhVlIJ', '30', '1232', 'scene1', 0, 0.5, 0.7, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 40, 80, 0.1, 0.1, '2021-10-26 14:14:56', '2021-10-26 14:14:58', '2021-10-26 14:15:13', 'Completed', 0);
INSERT INTO `scene_test_list` VALUES ('_GJtW3I-slDE70kf-w1Y', '-WlbxPlXqW94hAFhVlIJ', '30', '3434', 'scene1', 0, 0.5, 0.7, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 40, 80, 0.38, 0.03, '2021-10-26 14:18:47', '2021-10-26 14:18:49', '2021-10-26 14:19:02', 'Completed', 0);
INSERT INTO `scene_test_list` VALUES ('BGdjAsoTNcZTvDNrTqZN', 'iX0CTPZaysVUcvtUlvR5', '30', 'sadfa', 'scene1', 0, 0.5, 0.7, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 40, 80, 0.1, 0.1, '2021-10-26 14:27:39', '2021-10-26 14:27:40', '2021-10-26 14:27:54', 'Completed', 0);
INSERT INTO `scene_test_list` VALUES ('Aw99MsLlmKMm-wXjI2iE', 'UP-ZhUk1op5tnuq2GfGTw', '30', '校园测试', 'scene1', 0, 0.5, 0.7, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 40, 80, 0.1, 0.1, '2021-10-26 14:49:53', '2021-10-26 14:49:55', '2021-10-26 14:50:09', 'Completed', 0);
INSERT INTO `scene_test_list` VALUES ('QBeqzQWmEaFIelDZE4Kj', 'UP-ZhUk1op5tnuq2GfGTw', '30', '校园测试2', 'genscene', 0, 0.5, 0.7, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 40, 80, 0.1, 0.1, '2021-10-26 14:50:41', '2021-10-26 14:50:55', '2021-10-26 14:53:50', 'Completed', 0);
INSERT INTO `scene_test_list` VALUES ('ZGB9Y7RkjsdPYyMfNNjs', 'iX0CTPZaysVUcvtUlvR5', '30', '12312313', 'scene1', 0, 0.5, 0.7, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 40, 80, 0.1, 0.1, '2021-10-26 19:01:51', '2021-10-26 19:01:52', '2021-10-26 19:02:04', 'Completed', 0);
INSERT INTO `scene_test_list` VALUES ('MOktlA5_DATzF6Mh7RFk', 'iX0CTPZaysVUcvtUlvR5', '30', 'qweqw', 'scene1', 0, 0.5, 0.7, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 40, 80, 0.1, 0.1, '2021-10-26 20:11:01', '2021-10-26 20:11:02', '2021-10-26 20:11:16', 'Completed', 0);
INSERT INTO `scene_test_list` VALUES ('52byg3Zm0_dl3QGXJ7Kx', 'iX0CTPZaysVUcvtUlvR5', '30', '12321', 'genscene', 0, 0.5, 0.7, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 40, 80, 0.3, 0.3, '2021-10-26 20:17:29', '2021-10-26 20:17:30', '2021-10-26 20:20:19', 'Completed', 0);
INSERT INTO `scene_test_list` VALUES ('YaKVaAeC1Ey4cULd-t8P', 'iX0CTPZaysVUcvtUlvR5', '30', '100000', 'scene1', 0, 0.5, 0.7, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 40, 80, 0.1, 0.1, '2021-10-26 20:22:20', '2021-10-26 20:22:22', '2021-10-26 20:22:35', 'Completed', 0);
INSERT INTO `scene_test_list` VALUES ('feDk3jAGYnquld81jNir', 'iX0CTPZaysVUcvtUlvR5', '30', '123123', 'genscene', 0, 0.5, 0.7, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 40, 80, 0.1, 0.1, '2021-11-03 13:30:41', '2021-11-03 13:30:43', '', 'Stopped', 0);
INSERT INTO `scene_test_list` VALUES ('X35BG0UZ-up8b3w1eigc', 'iX0CTPZaysVUcvtUlvR5', '30', '33333', 'genscene', 0, 0.5, 0.7, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 40, 80, 0.1, 0.1, '2021-11-03 13:41:18', '2021-11-03 13:41:20', '', 'Stopped', 0);
INSERT INTO `scene_test_list` VALUES ('ED7cU2fmcI52xO-uDJrF', 'iX0CTPZaysVUcvtUlvR5', '30', '1233123123', 'genscene', 0, 0.5, 0.7, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 40, 80, 0.1, 0.1, '2021-11-03 13:58:18', '2021-11-03 13:58:20', '', 'Running', 0);
INSERT INTO `scene_test_list` VALUES ('774aMeCVg7Y5Opy3O6me', 'iX0CTPZaysVUcvtUlvR5', '30', '123123123', 'genscene', 0, 0.5, 0.7, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 40, 80, 0.1, 0.1, '2021-11-03 15:31:11', '2021-11-03 15:31:12', '', 'Running', 0);
INSERT INTO `scene_test_list` VALUES ('dtheQtHF9_lHHWwtSdIw', 'iX0CTPZaysVUcvtUlvR5', '30', '345353', 'genscene', 0, 0.5, 0.7, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 40, 80, 0.1, 0.1, '2021-11-03 15:43:37', '2021-11-03 15:43:39', '2021-11-03 15:46:20', 'Completed', 0);
INSERT INTO `scene_test_list` VALUES ('PE1VxNmGu4rSJ8c0bwtw', 'iX0CTPZaysVUcvtUlvR5', '30', '00000', 'genscene', 0, 0.5, 0.7, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 40, 80, 0.1, 0.1, '2021-11-03 15:46:42', '2021-11-03 15:46:43', '', 'Running', 0);
INSERT INTO `scene_test_list` VALUES ('VHCf1EeJyX7y73GtB4E0', 'iX0CTPZaysVUcvtUlvR5', '30', '65465', 'scene1', 0, 0.5, 0.7, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 40, 80, 0.1, 0.1, '2021-11-03 15:56:20', '2021-11-03 15:56:23', '2021-11-03 15:56:35', 'Completed', 0);
INSERT INTO `scene_test_list` VALUES ('lppHQbHPpssZm7szPl3n', 'iX0CTPZaysVUcvtUlvR5', '30', '46546', 'scene1', 0, 0.5, 0.7, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 40, 80, 0.1, 0.1, '2021-11-03 15:56:54', '2021-11-03 15:56:56', '2021-11-03 15:57:03', 'Completed', 0);
INSERT INTO `scene_test_list` VALUES ('e4TYxAgiut95KYZlWkKs', 'iX0CTPZaysVUcvtUlvR5', '30', '84646', 'genscene', 0, 0.5, 0.7, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 40, 80, 0.1, 0.1, '2021-11-03 15:57:56', '2021-11-03 15:57:58', '', 'Running', 0);
INSERT INTO `scene_test_list` VALUES ('ar00GoOBcF_woA41_Nnv', 'iX0CTPZaysVUcvtUlvR5', '30', '1312313', 'genscene', 0, 0.5, 0.7, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 40, 80, 0.1, 0.1, '2021-11-03 16:03:15', '2021-11-03 16:03:16', '2021-11-03 16:04:39', 'Completed', 0);
INSERT INTO `scene_test_list` VALUES ('7WByOg0zBobe-koXh6bP', 'iX0CTPZaysVUcvtUlvR5', '30', 'wewerwer', 'genscene', 0, 0.5, 0.7, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 40, 80, 0.1, 0.1, '2021-11-03 16:09:52', '2021-11-03 16:09:53', '2021-11-03 16:12:41', 'Completed', 0);
INSERT INTO `scene_test_list` VALUES ('EaSDZLiMrbFTYNvISawz', 'iX0CTPZaysVUcvtUlvR5', '30', '6456456', 'genscene', 0, 0.5, 0.7, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 40, 80, 0.1, 0.1, '2021-11-03 16:13:05', '2021-11-03 16:13:07', '', 'Running', 0);
INSERT INTO `scene_test_list` VALUES ('ZY4Hiwsphnrr34CGwr6A', 'iX0CTPZaysVUcvtUlvR5', '30', '13213', 'genscene', 0, 0.5, 0.7, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 40, 80, 0.1, 0.1, '2021-11-03 16:15:32', '2021-11-03 16:15:33', '', 'Running', 0);
INSERT INTO `scene_test_list` VALUES ('yM457V0hZE1vf_7_CTTG', 'iX0CTPZaysVUcvtUlvR5', '30', '213123', 'scene1', 0, 0.5, 0.7, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 40, 80, 0.1, 0.1, '2021-11-03 16:19:50', '2021-11-03 16:19:52', '', 'Running', 0);
INSERT INTO `scene_test_list` VALUES ('giotXu3LTsLQCKfX12Dm', 'iX0CTPZaysVUcvtUlvR5', '30', '3213312', 'scene1', 0, 0.5, 0.7, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 40, 80, 0.1, 0.1, '2021-11-03 16:22:00', '2021-11-03 16:22:02', '2021-11-03 16:22:08', 'Completed', 0);
INSERT INTO `scene_test_list` VALUES ('TukIG4fOdxxPvogzhVzJ', 'iX0CTPZaysVUcvtUlvR5', '30', '132132', 'scene1', 0, 0.5, 0.7, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 40, 80, 0.1, 0.1, '2021-11-03 16:22:28', '2021-11-03 16:22:30', '2021-11-03 16:22:36', 'Completed', 0);
INSERT INTO `scene_test_list` VALUES ('33ipbl2szNj0JNkwvZJK', 'iX0CTPZaysVUcvtUlvR5', '30', '321312', 'scene1', 0, 0.5, 0.7, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 40, 80, 0.1, 0.1, '2021-11-03 16:22:46', '2021-11-03 16:22:47', '2021-11-03 16:22:53', 'Completed', 0);
INSERT INTO `scene_test_list` VALUES ('bTbbGPOouE1k6LxtCrjF', 'iX0CTPZaysVUcvtUlvR5', '30', '3213', 'scene1', 0, 0.5, 0.7, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 40, 80, 0.1, 0.1, '2021-11-03 16:23:26', '2021-11-03 16:23:27', '2021-11-03 16:23:35', 'Completed', 0);
INSERT INTO `scene_test_list` VALUES ('M93iW1IXOeZ_lFndi8uR', 'iX0CTPZaysVUcvtUlvR5', '30', 'werwr', 'scene1', 0, 0.5, 0.7, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 40, 80, 0.1, 0.1, '2021-11-03 16:25:57', '2021-11-03 16:25:59', '2021-11-03 16:26:05', 'Completed', 0);
INSERT INTO `scene_test_list` VALUES ('-INNp_XDRnr5K0prQEYv', 'iX0CTPZaysVUcvtUlvR5', '30', '223', 'genscene', 0, 0.5, 0.7, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 40, 80, 0.1, 0.1, '2021-11-03 16:26:19', '2021-11-03 16:26:20', '2021-11-03 16:27:39', 'Completed', 0);
INSERT INTO `scene_test_list` VALUES ('_DU9IGawA0Upt2WxLO09', 'iX0CTPZaysVUcvtUlvR5', '30', '2131', 'scene1', 0, 0.5, 0.7, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 40, 80, 0.1, 0.1, '2021-11-03 16:37:27', '2021-11-03 16:37:29', '2021-11-03 16:37:36', 'Completed', 0);
INSERT INTO `scene_test_list` VALUES ('QdVEEQran_k_mNZ2siHK', 'iX0CTPZaysVUcvtUlvR5', '30', '1111', 'scene1', 0, 0.5, 0.7, 0, 1, 2, 0, 1, 0, 0, 0, 0, 0, 0, 40, 80, 0.2, 0.2, '2021-11-06 16:14:37', '2021-11-06 16:14:39', '2021-11-06 16:14:46', 'Completed', 0);
INSERT INTO `scene_test_list` VALUES ('C-r_YPKHVzQPBZ9qaCk9', 'iX0CTPZaysVUcvtUlvR5', '30', '3333', 'scene1', 0, 0.5, 0.7, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 40, 80, 0.2, 0.2, '2021-11-06 16:15:34', '2021-11-06 16:15:36', '2021-11-06 16:15:43', 'Completed', 0);
INSERT INTO `scene_test_list` VALUES ('gAH4HLHBZgjpZ8GlKtNg', 'iX0CTPZaysVUcvtUlvR5', '30', '666', 'scene1', 0, 0.5, 0.7, 0, 1, 2, 0, 1, 0, 0, 0, 0, 0, 0, 40, 80, 0.2, 0.2, '2021-11-06 16:17:48', '2021-11-06 16:17:49', '2021-11-06 16:18:02', 'Completed', 0);
INSERT INTO `scene_test_list` VALUES ('pAQjLf8PB852IhAVKnWP', 'iX0CTPZaysVUcvtUlvR5', '30', '888', 'scene1', 0, 0.5, 0.7, 0, 1, 2, 0, 1, 0, 0, 0, 0, 0, 0, 40, 80, 0.2, 0.2, '2021-11-06 16:20:40', '2021-11-06 16:20:43', '2021-11-06 16:20:55', 'Completed', 0);
INSERT INTO `scene_test_list` VALUES ('3PG_jSpcub42_v-0sQYy', 'iX0CTPZaysVUcvtUlvR5', '30', '3213', 'scene1', 0, 0.5, 0.7, 0, 1, 2, 0, 1, 0, 0, 0, 0, 0, 0, 40, 80, 0.2, 0.2, '2021-11-06 16:24:55', '2021-11-06 16:24:56', '', 'Running', 0);
INSERT INTO `scene_test_list` VALUES ('gAPF8CtPQQtPSAGUA_bJ', 'iX0CTPZaysVUcvtUlvR5', '30', '555', 'scene1', 0, 0.5, 0.7, 0, 1, 2, 0, 1, 0, 0, 0, 0, 0, 0, 40, 80, 0.2, 0.2, '2021-11-06 16:42:24', '2021-11-06 16:42:26', '', 'Running', 0);
INSERT INTO `scene_test_list` VALUES ('E8B8EIPK_pOaxnRj0S8A', 'iX0CTPZaysVUcvtUlvR5', '30', '666', 'scene1', 0, 0.5, 0.7, 0, 1, 2, 0, 1, 0, 0, 0, 0, 0, 0, 40, 80, 0.2, 0.2, '2021-11-06 16:54:57', '2021-11-06 16:54:58', '2021-11-06 17:02:19', 'Completed', 0);
INSERT INTO `scene_test_list` VALUES ('8SS6_0wbEwiF2jecIJtC', 'iX0CTPZaysVUcvtUlvR5', '30', '23234', 'scene1', 0, 0.5, 0.7, 0, 1, 2, 0, 1, 0, 0, 0, 0, 0, 0, 40, 80, 0.2, 0.2, '2021-11-06 17:05:10', '2021-11-06 17:05:12', '', 'Running', 0);
INSERT INTO `scene_test_list` VALUES ('gjNaredP6CT9dqMy3Hiy', 'iX0CTPZaysVUcvtUlvR5', '30', '888', 'scene1', 0, 0.5, 0.7, 0, 1, 2, 0, 1, 0, 0, 0, 0, 0, 0, 40, 80, 0.2, 0.2, '2021-11-06 17:10:57', '2021-11-06 17:10:59', '', 'Running', 0);
INSERT INTO `scene_test_list` VALUES ('IIgWJOx2erRD65oIO7u2', 'iX0CTPZaysVUcvtUlvR5', '30', '1123123', 'scene1', 0, 0.5, 0.7, 0, 1, 2, 0, 1, 0, 0, 0, 0, 0, 0, 40, 80, 0.2, 0.2, '2021-11-06 17:23:16', '2021-11-06 17:23:18', '2021-11-06 17:23:19', 'Completed', 0);
INSERT INTO `scene_test_list` VALUES ('-JkQxAV5-yPhAb83N3kC', 'iX0CTPZaysVUcvtUlvR5', '30', '454', 'genscene', 0, 0.5, 0.7, 0, 1, 2, 0, 1, 0, 0, 0, 0, 0, 0, 40, 80, 0.2, 0.2, '2021-11-06 17:23:41', '2021-11-06 17:23:43', '', 'Running', 0);
INSERT INTO `scene_test_list` VALUES ('4bVfxCDdjlR9JnxUPByZ', 'iX0CTPZaysVUcvtUlvR5', '30', '3333', 'genscene', 0, 0.5, 0.7, 0, 1, 2, 0, 1, 0, 0, 0, 0, 0, 0, 40, 80, 0.2, 0.2, '2021-11-06 17:25:23', '2021-11-06 17:25:24', '', 'Running', 0);
INSERT INTO `scene_test_list` VALUES ('BBmJ4S6D6YOuoT-XAaTS', 'iX0CTPZaysVUcvtUlvR5', '30', '666', 'scene1', 0, 0.5, 0.7, 0, 1, 2, 0, 1, 0, 0, 0, 0, 0, 0, 40, 80, 0.2, 0.2, '2021-11-06 17:49:27', '2021-11-06 17:49:29', '2021-11-06 17:49:51', 'Completed', 0);
INSERT INTO `scene_test_list` VALUES ('PwFKDQopd8S-M-Q139eA', 'iX0CTPZaysVUcvtUlvR5', '30', '111', 'scene1', 0, 0.5, 0.7, 0, 1, 2, 0, 1, 0, 0, 0, 0, 0, 0, 40, 80, 0.2, 0.2, '2021-11-06 17:51:12', '2021-11-06 17:51:13', '2021-11-06 17:51:34', 'Completed', 0);
INSERT INTO `scene_test_list` VALUES ('uvuYLFncElozLOnSPbQr', 'iX0CTPZaysVUcvtUlvR5', '30', '555', 'genscene', 0, 0.5, 0.7, 0, 1, 2, 0, 1, 0, 0, 0, 0, 0, 0, 40, 80, 0.2, 0.2, '2021-11-06 18:02:39', '2021-11-06 18:02:44', '2021-11-06 18:05:31', 'Completed', 0);
INSERT INTO `scene_test_list` VALUES ('-nJu4jMxWcMKYX4DFXoy', 'iX0CTPZaysVUcvtUlvR5', '30', '5555', 'genscene', 0, 0.5, 0.7, 0, 1, 2, 0, 1, 0, 0, 0, 0, 0, 0, 40, 80, 0.2, 0.2, '2021-11-06 18:06:47', '2021-11-06 18:06:50', '', 'Running', 0);
INSERT INTO `scene_test_list` VALUES ('3Rjbr7wYljqtYn8whxhx', 'iX0CTPZaysVUcvtUlvR5', '30', '6666', 'genscene', 0, 0.5, 0.7, 0, 1, 2, 0, 1, 0, 0, 0, 0, 0, 0, 40, 80, 0.2, 0.2, '2021-11-06 18:09:10', '2021-11-06 18:09:12', '', 'Running', 0);
INSERT INTO `scene_test_list` VALUES ('vSec65bh4gUIU90JWO22', 'iX0CTPZaysVUcvtUlvR5', '30', '3333', 'genscene', 0, 0.5, 0.7, 0, 1, 2, 0, 1, 0, 0, 0, 0, 0, 0, 40, 80, 0.2, 0.2, '2021-11-06 18:14:38', '2021-11-06 18:14:40', '2021-11-06 18:14:54', 'Completed', 0);
INSERT INTO `scene_test_list` VALUES ('BB-YFPqY9GkTp6vMwA1-', 'iX0CTPZaysVUcvtUlvR5', '30', '333', 'genscene', 0, 0.5, 0.7, 0, 1, 2, 0, 1, 0, 0, 0, 0, 0, 0, 40, 80, 0.2, 0.2, '2021-11-06 18:15:58', '2021-11-06 18:16:00', '', 'Running', 0);
INSERT INTO `scene_test_list` VALUES ('WcRA6zwLmTYnLxUn6ecK', 'iX0CTPZaysVUcvtUlvR5', '30', '666', 'genscene', 0, 0.5, 0.7, 0, 1, 2, 0, 1, 0, 0, 0, 0, 0, 0, 40, 80, 0.2, 0.2, '2021-11-06 18:19:05', '2021-11-06 18:19:06', '', 'Running', 0);
INSERT INTO `scene_test_list` VALUES ('7XrBIbqkU2uOdXK8KwdE', 'iX0CTPZaysVUcvtUlvR5', '30', '66666', 'scene1', 0, 0.5, 0.7, 0, 1, 2, 0, 1, 0, 0, 0, 0, 0, 0, 40, 80, 0.2, 0.2, '2021-11-06 18:21:42', '2021-11-06 18:21:43', '2021-11-06 18:22:07', 'Completed', 0);
INSERT INTO `scene_test_list` VALUES ('gznY0i63g5iVzhX5SHWo', 'iX0CTPZaysVUcvtUlvR5', '30', '8888', 'genscene', 0, 0.5, 0.7, 0, 1, 2, 0, 1, 0, 0, 0, 0, 0, 0, 40, 80, 0.2, 0.2, '2021-11-06 18:24:31', '2021-11-06 18:24:32', '', 'Running', 0);
INSERT INTO `scene_test_list` VALUES ('3uyA3mbJuzr4sQrwOv99', 'iX0CTPZaysVUcvtUlvR5', '30', '8888', 'genscene', 0, 0.5, 0.7, 0, 1, 2, 0, 1, 0, 0, 0, 0, 0, 0, 40, 80, 0.2, 0.2, '2021-11-06 18:35:12', '2021-11-06 18:35:14', '', 'Running', 0);
INSERT INTO `scene_test_list` VALUES ('1YsJ3MF5X_Ddjw1TrfSl', 'iX0CTPZaysVUcvtUlvR5', '30', '99999', 'genscene', 0, 0.5, 0.7, 0, 1, 2, 0, 1, 0, 0, 0, 0, 0, 0, 40, 80, 0.2, 0.2, '2021-11-06 18:42:34', '2021-11-06 18:42:35', '', 'Running', 0);
INSERT INTO `scene_test_list` VALUES ('thxq5PHPtDoooxJIm_X7', 'iX0CTPZaysVUcvtUlvR5', '30', '1111', 'genscene', 0, 0.5, 0.7, 0, 1, 2, 0, 1, 0, 0, 0, 0, 0, 0, 40, 80, 0.2, 0.2, '2021-11-06 18:54:42', '2021-11-06 18:54:44', '', 'Running', 0);
INSERT INTO `scene_test_list` VALUES ('tVjE7R7yt8qutckZ3IUU', 'iX0CTPZaysVUcvtUlvR5', '30', '8888', 'genscene', 0, 0.5, 0.7, 0, 1, 2, 0, 1, 0, 0, 0, 0, 0, 0, 40, 80, 0.2, 0.2, '2021-11-06 19:08:23', '2021-11-06 19:08:25', '', 'Running', 0);
INSERT INTO `scene_test_list` VALUES ('sEdOW_4BR8Lrb1BO0blo', 'iX0CTPZaysVUcvtUlvR5', '30', '6666666', 'genscene', 0, 0.5, 0.7, 0, 1, 2, 0, 1, 0, 0, 0, 0, 0, 0, 40, 80, 0.2, 0.2, '2021-11-06 19:26:37', '2021-11-06 19:26:39', '', 'Running', 0);
INSERT INTO `scene_test_list` VALUES ('vuJCxNn0RBAqvC0r43kh', 'iX0CTPZaysVUcvtUlvR5', '30', '5566', 'scene1', 0, 0.5, 0.7, 0, 1, 2, 0, 1, 0, 0, 0, 0, 0, 0, 40, 80, 0.2, 0.2, '2021-11-06 19:30:38', '2021-11-06 19:30:42', '2021-11-06 19:30:55', 'Completed', 0);
INSERT INTO `scene_test_list` VALUES ('tAnolim2Oo5Kid_9SSGg', 'iX0CTPZaysVUcvtUlvR5', '30', '888', 'genscene', 0, 0.5, 0.7, 0, 1, 2, 0, 1, 0, 0, 0, 0, 0, 0, 40, 80, 0.2, 0.2, '2021-11-06 19:33:08', '2021-11-06 19:33:10', '2021-11-06 19:35:43', 'Completed', 0);
INSERT INTO `scene_test_list` VALUES ('ALrP7qy39mcg4U5Tty-G', 'iX0CTPZaysVUcvtUlvR5', '30', '555', 'genscene', 0, 0.5, 0.7, 0, 1, 2, 0, 1, 0, 0, 0, 0, 0, 0, 40, 80, 0.2, 0.2, '2021-11-06 19:41:50', '2021-11-06 19:42:10', '2021-11-06 19:43:29', 'Completed', 0);
INSERT INTO `scene_test_list` VALUES ('dyMxAsDHoSifUqjtyzgZ', 'iX0CTPZaysVUcvtUlvR5', '30', '8888', 'genscene', 0, 0.5, 0.7, 0, 1, 2, 0, 1, 0, 0, 0, 0, 0, 0, 40, 80, 0.2, 0.2, '2021-11-06 19:44:46', '2021-11-06 19:44:50', '2021-11-06 19:46:07', 'Completed', 0);
INSERT INTO `scene_test_list` VALUES ('abKG0kbsdJ6FQMmVKyqA', 'iX0CTPZaysVUcvtUlvR5', '30', '111', 'scene1', 0, 0.5, 0.7, 0, 1, 2, 0, 1, 0, 0, 0, 0, 0, 0, 40, 80, 0.2, 0.2, '2021-11-07 17:14:09', '2021-11-07 17:14:58', '2021-11-07 17:15:04', 'Completed', 0);
INSERT INTO `scene_test_list` VALUES ('e0y2_hGqDbYfQw1YKq-9', 'iX0CTPZaysVUcvtUlvR5', '30', '111', 'scene1', 0, 0.5, 0.7, 0, 1, 2, 0, 1, 0, 0, 0, 0, 0, 0, 40, 80, 0.2, 0.2, '2021-11-07 15:09:21', '2021-11-07 15:09:22', '', 'Running', 0);
INSERT INTO `scene_test_list` VALUES ('74cKAfXPkuFkXEshut7s', 'iX0CTPZaysVUcvtUlvR5', '30', '111', 'scene1', 0, 0.5, 0.7, 0, 1, 2, 0, 1, 0, 0, 0, 0, 0, 0, 40, 80, 0.2, 0.2, '2021-11-07 15:11:44', '2021-11-07 15:11:44', '2021-11-07 15:11:51', 'Completed', 0);
INSERT INTO `scene_test_list` VALUES ('WPmgTue283ND80N7DeF5', 'iX0CTPZaysVUcvtUlvR5', '30', '2222', 'genscene', 0, 0.5, 0.7, 0, 1, 2, 0, 1, 0, 0, 0, 0, 0, 0, 40, 80, 0.2, 0.2, '2021-11-07 15:15:20', '2021-11-07 15:15:21', '2021-11-07 15:15:37', 'Completed', 0);
INSERT INTO `scene_test_list` VALUES ('Gn_EwD_rORO6PWB9aMTP', 'iX0CTPZaysVUcvtUlvR5', '30', '111', 'scene1', 0, 0.5, 0.7, 0, 1, 2, 0, 1, 0, 0, 0, 0, 0, 0, 40, 80, 0.2, 0.2, '2021-11-07 15:32:38', '2021-11-07 15:32:38', '2021-11-07 15:32:44', 'Completed', 0);
INSERT INTO `scene_test_list` VALUES ('veverk-uRq8VUad198Av', 'iX0CTPZaysVUcvtUlvR5', '30', '666', 'genscene', 0, 0.5, 0.7, 0, 1, 2, 0, 1, 0, 0, 0, 0, 0, 0, 40, 80, 0.2, 0.2, '2021-11-07 15:33:00', '2021-11-07 15:33:01', '2021-11-07 15:33:16', 'Completed', 0);
INSERT INTO `scene_test_list` VALUES ('zMKvjrK-eBOxG06Lj-XC', 'iX0CTPZaysVUcvtUlvR5', '30', '1111', 'genscene', 0, 0.5, 0.7, 0, 1, 2, 0, 1, 0, 0, 0, 0, 0, 0, 40, 80, 0.2, 0.2, '2021-11-07 15:40:18', '2021-11-07 15:40:18', '2021-11-07 15:40:36', 'Completed', 0);
INSERT INTO `scene_test_list` VALUES ('AelEF-cnQl5yuIPzHNgT', 'iX0CTPZaysVUcvtUlvR5', '30', '888', 'genscene', 0, 0.5, 0.7, 0, 1, 2, 0, 1, 0, 0, 0, 0, 0, 0, 40, 80, 0.2, 0.2, '2021-11-07 15:43:11', '2021-11-07 15:43:11', '', 'Running', 0);
INSERT INTO `scene_test_list` VALUES ('Tuh0NsaUBS-BSKHWDu14', 'iX0CTPZaysVUcvtUlvR5', '30', '123123', 'genscene', 0, 0.5, 0.7, 0, 1, 2, 0, 1, 0, 0, 0, 0, 0, 0, 40, 80, 0.2, 0.2, '2021-11-07 16:02:26', '2021-11-07 16:02:26', '2021-11-07 16:04:06', 'Completed', 0);
INSERT INTO `scene_test_list` VALUES ('gFHCZzQGTXXjOAHoq3zy', 'iX0CTPZaysVUcvtUlvR5', '30', '12123', 'genscene', 0, 0.5, 0.7, 0, 1, 2, 0, 1, 0, 0, 0, 0, 0, 0, 40, 80, 0.2, 0.2, '2021-11-07 16:09:29', '2021-11-07 16:09:53', '', 'Running', 0);
INSERT INTO `scene_test_list` VALUES ('dn5LmSRkm4_Mfdqy3W3J', 'iX0CTPZaysVUcvtUlvR5', '30', '123123', 'genscene', 0, 0.5, 0.7, 0, 1, 2, 0, 1, 0, 0, 0, 0, 0, 0, 40, 80, 0.2, 0.2, '2021-11-07 16:09:34', '2021-11-07 16:09:35', '', 'Running', 0);
INSERT INTO `scene_test_list` VALUES ('gxE_-vg8UBObCZXaCzpl', 'iX0CTPZaysVUcvtUlvR5', '30', '555', 'scene1', 0, 0.5, 0.7, 0, 1, 2, 0, 1, 0, 0, 0, 0, 0, 0, 40, 80, 0.2, 0.2, '2021-11-07 16:26:30', '2021-11-07 16:26:31', '2021-11-07 16:26:39', 'Completed', 0);
INSERT INTO `scene_test_list` VALUES ('DmhgSNi0-8XPi4Se9NRk', 'iX0CTPZaysVUcvtUlvR5', '30', '666', 'genscene', 0, 0.5, 0.7, 0, 1, 2, 0, 1, 0, 0, 0, 0, 0, 0, 40, 80, 0.2, 0.2, '2021-11-07 16:27:23', '2021-11-07 16:27:23', '2021-11-07 16:29:08', 'Completed', 0);
INSERT INTO `scene_test_list` VALUES ('N2H1rAGBpuIkESE5Qx5K', 'iX0CTPZaysVUcvtUlvR5', '30', '1212', 'genscene', 0, 0.5, 0.7, 0, 1, 2, 0, 1, 0, 0, 0, 0, 0, 0, 40, 80, 0.2, 0.2, '2021-11-07 16:29:12', '2021-11-07 16:29:12', '', 'Running', 0);
INSERT INTO `scene_test_list` VALUES ('N5vxBRqQi6xhr2WgdNbb', 'iX0CTPZaysVUcvtUlvR5', '30', '123123', 'genscene', 0, 0.5, 0.7, 0, 1, 2, 0, 1, 0, 0, 0, 0, 0, 0, 40, 80, 0.2, 0.2, '2021-11-07 16:29:48', '2021-11-07 16:29:48', '', 'Running', 0);
INSERT INTO `scene_test_list` VALUES ('5xDhhCcP_-O1os-8a4Kd', 'iX0CTPZaysVUcvtUlvR5', '30', '132', 'genscene', 0, 0.5, 0.7, 0, 1, 2, 0, 1, 0, 0, 0, 0, 0, 0, 40, 80, 0.2, 0.2, '2021-11-07 16:36:22', '2021-11-07 16:36:42', '', 'Running', 0);
INSERT INTO `scene_test_list` VALUES ('kpjC5oVbk4QDHE47AbQl', 'iX0CTPZaysVUcvtUlvR5', '30', '321', 'genscene', 0, 0.5, 0.7, 0, 1, 2, 0, 1, 0, 0, 0, 0, 0, 0, 40, 80, 0.2, 0.2, '2021-11-07 16:36:26', '2021-11-07 16:36:27', '', 'Running', 0);
INSERT INTO `scene_test_list` VALUES ('VBvNKEo8z9xOCjkaMAu2', 'iX0CTPZaysVUcvtUlvR5', '30', '123', 'genscene', 0, 0.5, 0.7, 0, 1, 2, 0, 1, 0, 0, 0, 0, 0, 0, 40, 80, 0.2, 0.2, '2021-11-07 16:39:04', '2021-11-07 16:39:10', '', 'Running', 0);
INSERT INTO `scene_test_list` VALUES ('ck408hEH7w-vkrkWsXfJ', 'iX0CTPZaysVUcvtUlvR5', '30', '456', 'genscene', 0, 0.5, 0.7, 0, 1, 2, 0, 1, 0, 0, 0, 0, 0, 0, 40, 80, 0.2, 0.2, '2021-11-07 16:39:10', '2021-11-07 16:39:22', '', 'Running', 0);
INSERT INTO `scene_test_list` VALUES ('lOnlS7i3xf9pY4chKsKS', 'iX0CTPZaysVUcvtUlvR5', '30', '123', 'genscene', 0, 0.5, 0.7, 0, 1, 2, 0, 1, 0, 0, 0, 0, 0, 0, 40, 80, 0.2, 0.2, '2021-11-07 16:54:16', '2021-11-07 16:54:24', '', 'Running', 0);
INSERT INTO `scene_test_list` VALUES ('-Q5c5zwel6tK54UistQx', 'iX0CTPZaysVUcvtUlvR5', '30', '456', 'genscene', 0, 0.5, 0.7, 0, 1, 2, 0, 1, 0, 0, 0, 0, 0, 0, 40, 80, 0.2, 0.2, '2021-11-07 16:54:23', '2021-11-07 16:54:40', '2021-11-07 16:56:30', 'Completed', 0);
INSERT INTO `scene_test_list` VALUES ('peA5UQQ5-9lfVHInv_ih', 'iX0CTPZaysVUcvtUlvR5', '30', '456', 'genscene', 0, 0.5, 0.7, 0, 1, 2, 0, 1, 0, 0, 0, 0, 0, 0, 40, 80, 0.2, 0.2, '2021-11-07 17:13:02', '2021-11-07 17:16:03', '', 'Running', 0);
INSERT INTO `scene_test_list` VALUES ('vFfS2sjioLZOh6U3xWdQ', 'iX0CTPZaysVUcvtUlvR5', '30', '123', 'genscene', 0, 0.5, 0.7, 0, 1, 2, 0, 1, 0, 0, 0, 0, 0, 0, 40, 80, 0.2, 0.2, '2021-11-07 17:12:56', '2021-11-07 17:16:03', '2021-11-07 17:18:34', 'Completed', 0);
INSERT INTO `scene_test_list` VALUES ('6duSvH229feBvrN3oZLG', 'iX0CTPZaysVUcvtUlvR5', '30', '678', 'genscene', 0, 0.5, 0.7, 0, 1, 2, 0, 1, 0, 0, 0, 0, 0, 0, 40, 80, 0.2, 0.2, '2021-11-07 17:20:44', '2021-11-07 17:21:43', '2021-11-07 17:23:08', 'Completed', 0);
INSERT INTO `scene_test_list` VALUES ('En_zxORCHMVt8JsHKcMY', 'DX5xcw8cwPzAG-05hCK9', '30', '高校门禁1', 'genscene', 1, 0.5, 0.7, 0, 1, 2, 0, 1, 0, 0, 0, 0, 0, 0, 40, 80, 0.2, 0.2, '2021-11-07 17:33:59', '2021-11-07 17:34:18', '2021-11-07 17:35:41', 'Completed', 0);
INSERT INTO `scene_test_list` VALUES ('YjYPXKBA9dnIO0Z4fhK6', 'DX5xcw8cwPzAG-05hCK9', '30', '高校门禁2', 'genscene', 1, 0.5, 0.7, 0, 1, 2, 0, 1, 0, 0, 0, 0, 0, 0, 40, 80, 0.2, 0.2, '2021-11-07 17:34:11', '2021-11-07 17:34:18', '2021-11-07 17:35:50', 'Completed', 0);
INSERT INTO `scene_test_list` VALUES ('7EqRsWYR27u4JM8IdAr_', 'DX5xcw8cwPzAG-05hCK9', '30', '校园门禁', 'scene1', 0, 0.5, 0.7, 0, 1, 2, 0, 1, 0, 0, 0, 0, 0, 0, 40, 80, 0.2, 0.2, '2021-11-10 14:22:44', '2021-11-10 14:22:47', '2021-11-10 14:22:49', 'Completed', 0);

SET FOREIGN_KEY_CHECKS = 1;
