-- 新增测试数据（在已有数据库上执行，不需要重建表）
-- 密码统一为 123456（MD5: e10adc3949ba59abbe56e057f20f883e）

INSERT INTO sys_user
(user_id, user_name, password, real_name, sex, phone, email, role, status, create_time)
VALUES
(5,  'photo3',  'e10adc3949ba59abbe56e057f20f883e', '苏然',     '女', '13800000004', 'photo3@campus.local',  'photographer', 1, NOW()),
(6,  'photo4',  'e10adc3949ba59abbe56e057f20f883e', '张昊',     '男', '13800000005', 'photo4@campus.local',  'photographer', 1, NOW()),
(7,  'lihua',   'e10adc3949ba59abbe56e057f20f883e', '李华',     '男', '13800000006', 'lihua@campus.local',   'user',         1, NOW()),
(8,  'wangmm',  'e10adc3949ba59abbe56e057f20f883e', '王萌萌',   '女', '13800000007', 'wangmm@campus.local',  'user',         1, NOW()),
(9,  'zhangfei','e10adc3949ba59abbe56e057f20f883e', '张飞',     '男', '13800000008', 'zhangfei@campus.local','user',         1, NOW()),
(10, 'liuyang', 'e10adc3949ba59abbe56e057f20f883e', '刘洋',     '男', '13800000009', 'liuyang@campus.local', 'user',         1, NOW()),
(11, 'photo5',  'e10adc3949ba59abbe56e057f20f883e', '赵敏',     '女', '13800000010', 'photo5@campus.local',  'photographer', 1, NOW());

INSERT INTO photographer
(photographer_id, user_id, nick_name, avatar, specialty, price, intro, free_time, status, create_time)
VALUES
(3, 5,  '苏然影像',   'Images/work-still.png',   '静物、美食摄影',   129.00, '专注咖啡馆、书桌、花艺等静物拍摄，色调温暖治愈。',           '周一全天、周四下午',         1, NOW()),
(4, 6,  '昊天视觉',   'Images/hero-campus.png',  '毕业季、社团活动', 259.00, '三年校园摄影经验，擅长毕业季集体照和社团活动纪实，可提供后期修图。', '周五至周日全天',             1, NOW()),
(5, 11, '赵敏工作室', 'Images/work-portrait.png', '证件照、形象照',   89.00,  '专业证件照和形象照拍摄，出片快、价格实惠，适合求职季。',      '周二、周四、周六上午',       1, NOW());

INSERT INTO photo_work
(work_id, photographer_id, title, work_type, image_url, description, is_recommend, audit_status, view_count, create_time)
VALUES
(5,  1, '毕业季·学士服',  '人像',     'Images/work-portrait.png', '穿着学士服在操场奔跑的瞬间，定格青春最后的肆意。',           1, 1, 312, NOW()),
(6,  3, '咖啡与书',       '静物',     'Images/work-still.png',   '一杯拿铁搭配翻开的小说，午后的图书馆角落最有故事感。',       1, 1, 97,  NOW()),
(7,  2, '樱花大道',       '校园风景', 'Images/work-campus.png',  '三月校园樱花盛开，落英缤纷的小路是每年最受欢迎的打卡点。',   1, 1, 278, NOW()),
(8,  4, '社团招新现场',   '校园风景', 'Images/hero-campus.png',  '百团大战的热闹场面，用广角记录下操场上的青春活力。',         0, 1, 65,  NOW()),
(9,  3, '相机与胶卷',     '静物',     'Images/work-still.png',   '老式胶片相机搭配彩色胶卷，致敬传统摄影的魅力。',             0, 1, 54,  NOW()),
(10, 4, '毕业晚会舞台',   '校园风景', 'Images/hero-campus.png',  '舞台灯光亮起的瞬间，用慢快门捕捉流动的光影。',               0, 1, 88,  NOW()),
(11, 5, '证件照对比',     '人像',     'Images/work-portrait.png', '左边是普通证件照，右边是我们拍的——差别一目了然。',           1, 1, 420, NOW()),
(12, 1, '操场夕阳',       '人像',     'Images/work-portrait.png', '夕阳逆光下剪影效果绝佳，适合情侣写真和个人写真。',           0, 1, 176, NOW()),
(13, 2, '雨后教学楼',     '校园风景', 'Images/work-campus.png',  '雨后的教学楼地面倒映着天空，格外通透干净。',                 0, 1, 63,  NOW()),
(14, 3, '花艺台灯',       '静物',     'Images/work-still.png',   '干花搭配暖色台灯，适合做桌面壁纸或明信片素材。',             0, 1, 41,  NOW()),
(15, 4, '篮球赛精彩瞬间', '校园风景', 'Images/hero-campus.png',  '校际篮球联赛决赛，用高速快门定格扣篮瞬间。',                 0, 1, 95,  NOW());

INSERT INTO book_order
(order_id, user_id, photographer_id, shoot_date, shoot_place, requirement, order_status, create_time)
VALUES
(3,  7,  1, '2026-06-25', '操场跑道',         '毕业季个人写真，想要逆光夕阳的感觉。',               '待确认', NOW()),
(4,  7,  4, '2026-06-28', '大礼堂门口',       '全班毕业合影，大约30人，需要广角镜头。',              '已确认', NOW()),
(5,  8,  5, '2026-06-18', '摄影工作室',       '拍一组求职用的形象照，白底正装。',                   '已完成', NOW()),
(6,  8,  3, '2026-07-01', '图书馆咖啡角',     '想拍一组文艺风格的写真，带书和咖啡。',               '待确认', NOW()),
(7,  9,  2, '2026-06-30', '樱花大道',         '情侣写真，自然抓拍风格就好。',                       '待确认', NOW()),
(8,  10, 4, '2026-06-26', '体育馆',           '篮球社活动跟拍，需要高速快门抓拍。',                 '已确认', NOW()),
(9,  10, 1, '2026-07-05', '图书馆门口',       '毕业季证件照+生活照各一组。',                        '待确认', NOW()),
(10, 8,  1, '2026-06-15', '湖边长椅',         '给男朋友拍生日纪念照，自然温馨风格。',               '已完成', NOW());

INSERT INTO comment
(comment_id, work_id, user_id, content, status, create_time)
VALUES
(4,  5,  7,  '学士服这组太有感觉了！请问拍摄套餐多少钱？',       1, NOW()),
(5,  5,  8,  '毕业季必拍！已预约了同款。',                       1, NOW()),
(6,  6,  9,  '色调好温暖，好想在图书馆也拍一组。',               1, NOW()),
(7,  7,  10, '每年三月都来这里拍照，今年终于有专业摄影师拍了。', 1, NOW()),
(8,  11, 4,  '证件照对比太明显了，已推荐给室友。',               1, NOW()),
(9,  11, 9,  '拍得真好，比照相馆的好看太多了！',                 1, NOW()),
(10, 4,  7,  '教学楼的光影层次感很强，构图很棒。',               1, NOW()),
(11, 1,  8,  '请问这个风格可以用在毕业照上吗？',                 1, NOW()),
(12, 12, 10, '夕阳逆光绝了！下次约拍就选这个风格。',             1, NOW()),
(13, 2,  9,  '湖面倒影拍得好棒，像油画一样。',                   1, NOW()),
(14, 8,  7,  '百团大战的氛围感拍出来了！社团招新必备素材。',     1, NOW()),
(15, 15, 4,  '篮球赛抓拍太帅了，能帮我们社团也拍一组吗？',       1, NOW());
