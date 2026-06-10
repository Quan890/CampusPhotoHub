DROP DATABASE IF EXISTS campus_photo_share;
CREATE DATABASE campus_photo_share DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE campus_photo_share;

CREATE TABLE sys_user (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    user_name VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(32) NOT NULL,
    real_name VARCHAR(50) DEFAULT NULL,
    sex VARCHAR(10) DEFAULT NULL,
    phone VARCHAR(30) DEFAULT NULL,
    email VARCHAR(80) DEFAULT NULL,
    role VARCHAR(20) NOT NULL DEFAULT 'user',
    status TINYINT NOT NULL DEFAULT 1,
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE photographer (
    photographer_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    nick_name VARCHAR(50) NOT NULL,
    avatar VARCHAR(200) DEFAULT 'Images/work-portrait.png',
    specialty VARCHAR(100) DEFAULT NULL,
    price DECIMAL(10,2) NOT NULL DEFAULT 0,
    intro VARCHAR(500) DEFAULT NULL,
    free_time VARCHAR(300) DEFAULT NULL,
    status TINYINT NOT NULL DEFAULT 1,
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_photographer_user FOREIGN KEY (user_id) REFERENCES sys_user(user_id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE photo_work (
    work_id INT AUTO_INCREMENT PRIMARY KEY,
    photographer_id INT NOT NULL,
    title VARCHAR(100) NOT NULL,
    work_type VARCHAR(20) NOT NULL,
    image_url VARCHAR(200) NOT NULL,
    description VARCHAR(800) DEFAULT NULL,
    is_recommend TINYINT NOT NULL DEFAULT 0,
    audit_status TINYINT NOT NULL DEFAULT 1,
    view_count INT NOT NULL DEFAULT 0,
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_work_photographer FOREIGN KEY (photographer_id) REFERENCES photographer(photographer_id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE book_order (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    photographer_id INT NOT NULL,
    shoot_date DATE NOT NULL,
    shoot_place VARCHAR(120) NOT NULL,
    requirement VARCHAR(800) DEFAULT NULL,
    order_status VARCHAR(20) NOT NULL DEFAULT '待确认',
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_order_user FOREIGN KEY (user_id) REFERENCES sys_user(user_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_order_photographer FOREIGN KEY (photographer_id) REFERENCES photographer(photographer_id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE comment (
    comment_id INT AUTO_INCREMENT PRIMARY KEY,
    work_id INT NOT NULL,
    user_id INT NOT NULL,
    content VARCHAR(500) NOT NULL,
    status TINYINT NOT NULL DEFAULT 1,
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_comment_work FOREIGN KEY (work_id) REFERENCES photo_work(work_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_comment_user FOREIGN KEY (user_id) REFERENCES sys_user(user_id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO sys_user
(user_id, user_name, password, real_name, sex, phone, email, role, status, create_time)
VALUES
(1, 'admin', 'e10adc3949ba59abbe56e057f20f883e', '系统管理员', '男', '13800000000', 'admin@campus.local', 'admin', 1, NOW()),
(2, 'test', 'e10adc3949ba59abbe56e057f20f883e', '林晨', '女', '13800000001', 'test@campus.local', 'photographer', 1, NOW()),
(3, 'photo2', 'e10adc3949ba59abbe56e057f20f883e', '周远', '男', '13800000002', 'photo2@campus.local', 'photographer', 1, NOW()),
(4, 'student', 'e10adc3949ba59abbe56e057f20f883e', '陈同学', '女', '13800000003', 'student@campus.local', 'user', 1, NOW());

INSERT INTO photographer
(photographer_id, user_id, nick_name, avatar, specialty, price, intro, free_time, status, create_time)
VALUES
(1, 2, '晨光影像', 'Images/work-portrait.png', '人像写真、毕业照', 199.00, '擅长自然光校园人像，喜欢记录学生时代轻松真实的状态。', '周三下午、周六全天、周日晚', 1, NOW()),
(2, 3, '远山摄影', 'Images/work-campus.png', '校园风景、活动跟拍', 159.00, '偏好清爽构图和纪实色彩，可承接社团活动、校园风景专题拍摄。', '周二晚上、周五下午、周日全天', 1, NOW());

INSERT INTO photo_work
(work_id, photographer_id, title, work_type, image_url, description, is_recommend, audit_status, view_count, create_time)
VALUES
(1, 1, '图书馆午后', '人像', 'Images/work-portrait.png', '以图书馆外的树影作为背景，突出校园生活中安静自然的一面。', 1, 1, 58, NOW()),
(2, 2, '湖边晨色', '校园风景', 'Images/work-campus.png', '清晨湖面和教学楼倒影形成稳定的画面节奏，适合校园风景主题展示。', 1, 1, 73, NOW()),
(3, 1, '窗边静物', '静物', 'Images/work-still.png', '利用自然窗光拍摄相机、笔记本与干花，表达摄影学习的日常感。', 1, 1, 42, NOW()),
(4, 2, '教学楼光影', '校园风景', 'Images/hero-campus.png', '傍晚教学区的斜阳和行道树形成温暖层次，适合作为首页推荐作品。', 0, 1, 36, NOW());

INSERT INTO book_order
(order_id, user_id, photographer_id, shoot_date, shoot_place, requirement, order_status, create_time)
VALUES
(1, 4, 1, '2026-06-20', '校园图书馆东侧草坪', '想拍一组简约毕业纪念照，服装以白衬衫为主。', '待确认', NOW()),
(2, 4, 2, '2026-06-22', '校内湖边与主教学楼', '社团宣传照，需要偏纪实风格。', '已确认', NOW());

INSERT INTO comment
(comment_id, work_id, user_id, content, status, create_time)
VALUES
(1, 1, 4, '这组人像的光线很舒服，很适合毕业季参考。', 1, NOW()),
(2, 2, 4, '校园湖边拍出了很安静的感觉。', 1, NOW()),
(3, 3, 2, '静物布置简洁，适合做摄影社课程展示。', 1, NOW());
