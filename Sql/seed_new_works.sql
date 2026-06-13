-- =============================================
-- 新增摄影师 + 人像7张 + 风景8张 + 对应评论
-- 运行前请确认 seed_more.sql 已执行过
-- =============================================

-- ========== 1. 新增两个用户账号（摄影师） ==========
INSERT INTO sys_user (user_name, password, real_name, sex, phone, email, role, status)
VALUES
('linchen', 'e10adc3949ba59abbe56e057f20f883e', '林晨', '男', '13800000012', 'linchen@campus.com', 'photographer', 1),
('muxi',    'e10adc3949ba59abbe56e057f20f883e', '沐希', '女', '13800000013', 'muxi@campus.com',    'photographer', 1);

-- ========== 2. 新增两个摄影师档案 ==========
-- 人像摄影师：林晨（user_id=12）
INSERT INTO photographer (user_id, nick_name, avatar, specialty, price, intro, free_time, status)
VALUES (
    (SELECT user_id FROM sys_user WHERE user_name='linchen' LIMIT 1),
    '林晨工作室',
    'Images/work-portrait.png',
    '人像写真、情绪摄影',
    259.00,
    '专注人像情绪摄影五年，擅长捕捉自然表情与光影氛围，风格细腻温暖。',
    '周六、周日全天，工作日傍晚',
    1
);

-- 风景摄影师：沐希（user_id=13）
INSERT INTO photographer (user_id, nick_name, avatar, specialty, price, intro, free_time, status) VALUES (
    (SELECT user_id FROM sys_user WHERE user_name='muxi' LIMIT 1),
    '沐希光影',
    'Images/work-portrait.png',
    '校园风景、建筑摄影',
    189.00,
    '热爱用镜头记录校园四季风光，善于发现平凡角落里的独特美感。',
    '周六上午、周日下午',
    1
);

-- ========== 3. 新增人像作品 7 张（摄影师：林晨工作室） ==========
INSERT INTO photo_work
(photographer_id, title, work_type, image_url, description, is_recommend, audit_status, view_count, create_time)
VALUES
(
    (SELECT photographer_id FROM photographer WHERE nick_name='林晨工作室' LIMIT 1),
    '复古写真·暖阳午后',
    '人像',
    'Images/portrait/newfu1.png',
    '暖色调复古风格人像，午后的阳光洒在脸上，营造出怀旧而温柔的氛围。',
    1, 1, 0, NOW()
),
(
    (SELECT photographer_id FROM photographer WHERE nick_name='林晨工作室' LIMIT 1),
    '复古写真·胶片质感',
    '人像',
    'Images/portrait/newfu2.png',
    '胶片质感的复古人像，颗粒感与色彩偏移带来独特的时光味道。',
    0, 1, 0, NOW()
),
(
    (SELECT photographer_id FROM photographer WHERE nick_name='林晨工作室' LIMIT 1),
    '元气少女·清新日系',
    '人像',
    'Images/portrait/newyuan1.jpg',
    '日系清新风格的元气少女写真，明亮的色调与自然表情展现青春活力。',
    1, 1, 0, NOW()
),
(
    (SELECT photographer_id FROM photographer WHERE nick_name='林晨工作室' LIMIT 1),
    '元气少女·午后时光',
    '人像',
    'Images/portrait/newyuan2.jpg',
    '午后的校园里，元气满满的少女笑容，记录最真实的青春模样。',
    0, 1, 0, NOW()
),
(
    (SELECT photographer_id FROM photographer WHERE nick_name='林晨工作室' LIMIT 1),
    '洛丽塔·梦幻花园',
    '人像',
    'Images/portrait/newluo1.png',
    '梦幻花园中的洛丽塔风格写真，精致的服装与柔和的光线交织出童话般的画面。',
    1, 1, 0, NOW()
),
(
    (SELECT photographer_id FROM photographer WHERE nick_name='林晨工作室' LIMIT 1),
    '情绪人像·光影独白',
    '人像',
    'Images/portrait/newe.png',
    '光影交错中的情绪人像，用明暗对比诉说内心的故事，充满艺术感染力。',
    0, 1, 0, NOW()
),
(
    (SELECT photographer_id FROM photographer WHERE nick_name='林晨工作室' LIMIT 1),
    '三人闺蜜·青春群像',
    '人像',
    'Images/portrait/newsanr.png',
    '三位闺蜜的青春群像，自然的互动与欢笑，记录最珍贵的友谊时光。',
    0, 1, 0, NOW()
);

-- ========== 4. 新增风景作品 8 张（摄影师：沐希光影） ==========
INSERT INTO photo_work
(photographer_id, title, work_type, image_url, description, is_recommend, audit_status, view_count, create_time)
VALUES
(
    (SELECT photographer_id FROM photographer WHERE nick_name='沐希光影' LIMIT 1),
    '校园小径·绿荫幽深',
    '校园风景',
    'Images/landscape/newxx.png',
    '校园小径两旁绿树成荫，阳光透过树叶洒落斑驳光影，宁静而美好。',
    1, 1, 0, NOW()
),
(
    (SELECT photographer_id FROM photographer WHERE nick_name='沐希光影' LIMIT 1),
    '图书馆·晨光初照',
    '校园风景',
    'Images/landscape/newtsg1.jpg',
    '清晨的图书馆在柔和的晨光中显得庄重而温暖，是校园最美的风景线。',
    0, 1, 0, NOW()
),
(
    (SELECT photographer_id FROM photographer WHERE nick_name='沐希光影' LIMIT 1),
    '操场·青春飞扬',
    '校园风景',
    'Images/landscape/newcc.png',
    '宽阔的操场上蓝天白云，仿佛能看到青春奔跑的身影，充满活力与朝气。',
    1, 1, 0, NOW()
),
(
    (SELECT photographer_id FROM photographer WHERE nick_name='沐希光影' LIMIT 1),
    '图书馆·夕阳余晖',
    '校园风景',
    'Images/landscape/newtsg.png',
    '夕阳西下，图书馆的玻璃幕墙映射出金色的光芒，美得令人屏息。',
    0, 1, 0, NOW()
),
(
    (SELECT photographer_id FROM photographer WHERE nick_name='沐希光影' LIMIT 1),
    '广场·晨曦微露',
    '校园风景',
    'Images/landscape/newgc.png',
    '清晨的校园广场，薄雾与晨曦交织，建筑轮廓在光影中若隐若现。',
    0, 1, 0, NOW()
),
(
    (SELECT photographer_id FROM photographer WHERE nick_name='沐希光影' LIMIT 1),
    '广场·四季轮转',
    '校园风景',
    'Images/landscape/newgc2.jpg',
    '同一角度记录校园广场的四季变化，感受时光流转中的校园之美。',
    0, 1, 0, NOW()
),
(
    (SELECT photographer_id FROM photographer WHERE nick_name='沐希光影' LIMIT 1),
    '图书馆·夜色灯火',
    '校园风景',
    'Images/landscape/newtsg2.jpg',
    '夜幕下的图书馆灯火通明，温暖的灯光照亮求知的道路。',
    0, 1, 0, NOW()
),
(
    (SELECT photographer_id FROM photographer WHERE nick_name='沐希光影' LIMIT 1),
    '广场·光影几何',
    '校园风景',
    'Images/landscape/newgcgsg.jpg',
    '广场建筑的几何线条与光影变化构成独特的视觉韵律，展现建筑之美。',
    0, 1, 0, NOW()
);

-- ========== 5. 人像作品评论（每张 2 条，user_id 从已有普通用户中选取） ==========
INSERT INTO comment (work_id, user_id, content, status, create_time)
VALUES
((SELECT work_id FROM photo_work WHERE title='复古写真·暖阳午后' LIMIT 1),   4,  '暖色调太有感觉了，复古风人像拍得好有味道！',           1, NOW()),
((SELECT work_id FROM photo_work WHERE title='复古写真·暖阳午后' LIMIT 1),   7,  '午后的阳光配合复古色调，简直是绝配，已收藏。',         1, NOW()),
((SELECT work_id FROM photo_work WHERE title='复古写真·胶片质感' LIMIT 1),   8,  '胶片质感好真实，颗粒感让照片更有故事感。',             1, NOW()),
((SELECT work_id FROM photo_work WHERE title='复古写真·胶片质感' LIMIT 1),   9,  '这种风格太独特了，求摄影师的调色教程！',               1, NOW()),
((SELECT work_id FROM photo_work WHERE title='元气少女·清新日系' LIMIT 1),   10, '日系清新风格好治愈，少女感满满！',                     1, NOW()),
((SELECT work_id FROM photo_work WHERE title='元气少女·清新日系' LIMIT 1),   4,  '色调好舒服，很有日系写真的感觉，想约拍！',             1, NOW()),
((SELECT work_id FROM photo_work WHERE title='元气少女·午后时光' LIMIT 1),   7,  '自然的表情最打动人，拍得好真实好青春。',               1, NOW()),
((SELECT work_id FROM photo_work WHERE title='元气少女·午后时光' LIMIT 1),   11, '这种自然风格比摆拍好看多了，赞！',                     1, NOW()),
((SELECT work_id FROM photo_work WHERE title='洛丽塔·梦幻花园' LIMIT 1),     8,  '梦幻感十足！服装和场景搭配得好完美。',                 1, NOW()),
((SELECT work_id FROM photo_work WHERE title='洛丽塔·梦幻花园' LIMIT 1),     9,  '仿佛走进了童话世界，摄影师的审美太好了。',             1, NOW()),
((SELECT work_id FROM photo_work WHERE title='情绪人像·光影独白' LIMIT 1),   10, '光影的运用太妙了，每一张都像在讲述一个故事。',         1, NOW()),
((SELECT work_id FROM photo_work WHERE title='情绪人像·光影独白' LIMIT 1),   4,  '情绪人像拍得这么有感染力，真的很厉害。',               1, NOW()),
((SELECT work_id FROM photo_work WHERE title='三人闺蜜·青春群像' LIMIT 1),   7,  '三个人的互动好自然，闺蜜照就该这样拍！',               1, NOW()),
((SELECT work_id FROM photo_work WHERE title='三人闺蜜·青春群像' LIMIT 1),   11, '看完想立刻约上好朋友拍一组，太有感觉了。',             1, NOW());

-- ========== 6. 风景作品评论（每张 2 条） ==========
INSERT INTO comment (work_id, user_id, content, status, create_time)
VALUES
((SELECT work_id FROM photo_work WHERE title='校园小径·绿荫幽深' LIMIT 1),   4,  '这条路我每天走，没想到被拍得这么美！',                 1, NOW()),
((SELECT work_id FROM photo_work WHERE title='校园小径·绿荫幽深' LIMIT 1),   8,  '斑驳的光影太有意境了，校园里原来藏着这么多美景。',     1, NOW()),
((SELECT work_id FROM photo_work WHERE title='图书馆·晨光初照' LIMIT 1),     9,  '清晨的图书馆好安静好美，晨光洒在建筑上的感觉太棒了。', 1, NOW()),
((SELECT work_id FROM photo_work WHERE title='图书馆·晨光初照' LIMIT 1),     10, '早起的校园果然有不一样的风景，拍得真好！',             1, NOW()),
((SELECT work_id FROM photo_work WHERE title='操场·青春飞扬' LIMIT 1),       7,  '蓝天白云下的操场，看着就想去跑两圈！',                 1, NOW()),
((SELECT work_id FROM photo_work WHERE title='操场·青春飞扬' LIMIT 1),       11, '操场的照片拍出了青春的感觉，活力满满。',               1, NOW()),
((SELECT work_id FROM photo_work WHERE title='图书馆·夕阳余晖' LIMIT 1),     4,  '夕阳下的图书馆太震撼了，金色光芒美得不像话。',         1, NOW()),
((SELECT work_id FROM photo_work WHERE title='图书馆·夕阳余晖' LIMIT 1),     8,  '这个角度拍图书馆绝了，玻璃幕墙的反光效果好梦幻。',     1, NOW()),
((SELECT work_id FROM photo_work WHERE title='广场·晨曦微露' LIMIT 1),       9,  '薄雾中的校园广场有种朦胧的美感，太有意境了。',         1, NOW()),
((SELECT work_id FROM photo_work WHERE title='广场·晨曦微露' LIMIT 1),       10, '清晨的校园原来这么美，下次要早点起来拍照！',           1, NOW()),
((SELECT work_id FROM photo_work WHERE title='广场·四季轮转' LIMIT 1),       7,  '四季对比好有创意，同一个角度完全不同的感觉。',           1, NOW()),
((SELECT work_id FROM photo_work WHERE title='广场·四季轮转' LIMIT 1),       11, '时光流转的感觉好强烈，拍得真有心。',                   1, NOW()),
((SELECT work_id FROM photo_work WHERE title='图书馆·夜色灯火' LIMIT 1),     4,  '夜晚的图书馆灯火通明，是校园里最温暖的风景。',         1, NOW()),
((SELECT work_id FROM photo_work WHERE title='图书馆·夜色灯火' LIMIT 1),     8,  '灯光照亮的不只是图书馆，还有求知的路。拍得太好了！',   1, NOW()),
((SELECT work_id FROM photo_work WHERE title='广场·光影几何' LIMIT 1),       9,  '建筑线条和光影的组合好有设计感，几何美学满分！',         1, NOW()),
((SELECT work_id FROM photo_work WHERE title='广场·光影几何' LIMIT 1),       10, '原来广场的建筑这么有美感，摄影的眼光真独到。',         1, NOW());
