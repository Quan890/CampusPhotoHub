-- 新增作品图片（人像→摄影师1，风景→摄影师2，静物→摄影师3）

INSERT INTO photo_work
(photographer_id, title, work_type, image_url, description, is_recommend, audit_status, view_count, create_time)
VALUES
(1, '清新人像·校园一角', '人像',     'Images/portrait/q.png',                '校园角落的自然光人像，清新淡雅的色调记录青春瞬间。',     1, 1, 0, NOW()),
(1, '双人写真·光影交错', '人像',     'Images/portrait/qw.png',               '双人合影中光影的运用让画面更有层次感。',                 0, 1, 0, NOW()),
(2, '校园风光·全景',     '校园风景', 'Images/landscape/fj.jpg',              '俯瞰校园全景，蓝天白云下的教学楼群格外壮观。',           1, 1, 0, NOW()),
(2, '教学楼·建筑之美',   '校园风景', 'Images/landscape/jiaoxuelou.jpg',      '教学楼的几何线条与光影构成独特的建筑美感。',             0, 1, 0, NOW()),
(2, '图书馆·知识殿堂',   '校园风景', 'Images/landscape/tushuguan.jpg',       '图书馆外观在不同光线下呈现出不同的韵味。',               0, 1, 0, NOW()),
(3, '教室一角·日常',     '静物',     'Images/StillLife/jiaoshi.jpg',         '教室里整齐的桌椅和窗外透进的光线，最熟悉的校园日常。',   1, 1, 0, NOW()),
(3, '图书馆内·静谧时光', '静物',     'Images/StillLife/tsg.jpg',             '图书馆内部安静的氛围，书架与灯光营造出温暖的阅读空间。', 0, 1, 0, NOW()),
(1, '可爱写真·光影交错', '人像',     'Images/portrait/ces.png',              '光影交错间捕捉最可爱的表情，自然又生动。',               0, 1, 0, NOW()),
(1, '双人闺蜜·青春纪念', '人像',     'Images/portrait/shuanr.jpg',           '闺蜜双人的青春纪念照，记录最好的友情时光。',             0, 1, 0, NOW());

-- 对应评论（用子查询关联作品）
INSERT INTO comment (work_id, user_id, content, status, create_time)
VALUES
((SELECT work_id FROM photo_work WHERE title='清新人像·校园一角' LIMIT 1), 4,  '光线拍得好自然，很适合毕业季参考！',               1, NOW()),
((SELECT work_id FROM photo_work WHERE title='清新人像·校园一角' LIMIT 1), 7,  '这个风格太喜欢了，已预约同款拍摄。',               1, NOW()),
((SELECT work_id FROM photo_work WHERE title='双人写真·光影交错' LIMIT 1), 8,  '双人合影的光影效果很棒，很有层次感。',             1, NOW()),
((SELECT work_id FROM photo_work WHERE title='双人写真·光影交错' LIMIT 1), 9,  '请问这种双人写真套餐多少钱？',                     1, NOW()),
((SELECT work_id FROM photo_work WHERE title='校园风光·全景' LIMIT 1),     10, '校园全景太壮观了！蓝天白云下的教学楼真美。',       1, NOW()),
((SELECT work_id FROM photo_work WHERE title='校园风光·全景' LIMIT 1),     4,  '每年三月都来这里拍照，今年终于有专业摄影师拍了。', 1, NOW()),
((SELECT work_id FROM photo_work WHERE title='教学楼·建筑之美' LIMIT 1),   7,  '教学楼的建筑线条拍得好有设计感。',                 1, NOW()),
((SELECT work_id FROM photo_work WHERE title='图书馆·知识殿堂' LIMIT 1),   8,  '图书馆外观不同光线下确实有不同的韵味。',           1, NOW()),
((SELECT work_id FROM photo_work WHERE title='教室一角·日常' LIMIT 1),     9,  '教室桌椅和窗外的光线，最熟悉的校园日常。',         1, NOW()),
((SELECT work_id FROM photo_work WHERE title='教室一角·日常' LIMIT 1),     10, '好有怀旧感，想起每天上课的日子。',                 1, NOW()),
((SELECT work_id FROM photo_work WHERE title='图书馆内·静谧时光' LIMIT 1), 4,  '图书馆内部好安静，书架与灯光营造出温暖的阅读空间。', 1, NOW()),
((SELECT work_id FROM photo_work WHERE title='图书馆内·静谧时光' LIMIT 1), 7,  '阳光透过窗户洒在桌面上，光影与书籍完美搭配。',     1, NOW()),
((SELECT work_id FROM photo_work WHERE title='可爱写真·光影交错' LIMIT 1), 8,  '光影交错的感觉拍得好棒，表情很自然！',             1, NOW()),
((SELECT work_id FROM photo_work WHERE title='可爱写真·光影交错' LIMIT 1), 9,  '请问这种风格可以拍情侣照吗？',                     1, NOW()),
((SELECT work_id FROM photo_work WHERE title='双人闺蜜·青春纪念' LIMIT 1), 10, '闺蜜照拍得好有感觉，想和好朋友也拍一组！',         1, NOW()),
((SELECT work_id FROM photo_work WHERE title='双人闺蜜·青春纪念' LIMIT 1), 4,  '青春纪念照就该这样拍，自然不做作。',               1, NOW());
