# 校园摄影作品分享与约拍平台部署说明

## 技术环境

- Visual Studio 2012
- .NET Framework 4.5
- ASP.NET Web Forms
- C# + ADO.NET
- MySQL
- MySql.Data.dll

本项目未使用 EF、ORM、jQuery、Vue 或第三方前端框架。页面样式位于 `Css/site.css`，前端仅使用原生 HTML/CSS 和少量原生 JS。

## 数据库导入

1. 启动 MySQL 服务。
2. 使用 Navicat、MySQL Workbench 或命令行打开 `Sql/database.sql`。
3. 执行完整脚本，脚本会创建数据库 `campus_photo_share`、5 张表和初始化数据。

默认账号：

- 管理员：`admin / 123456`
- 摄影师：`test / 123456`
- 摄影师：`photo2 / 123456`
- 普通用户：`student / 123456`

密码在数据库中以 MD5 密文保存。登录和注册页面使用项目内 `Scripts/security.js` 在提交前对密码做 MD5 处理，表单提交的是密文值；正式部署时仍建议在 IIS 配置 HTTPS 进一步保护整条传输链路。

## 修改连接字符串

打开 `Web.config`，按本机 MySQL 账号修改：

```xml
<add name="CampusPhotoConn" connectionString="server=localhost;port=3306;database=campus_photo_share;uid=root;pwd=123456;charset=utf8;" providerName="MySql.Data.MySqlClient" />
```

## 配置 MySql.Data.dll

1. 下载或找到与 .NET Framework 4.5 兼容的 `MySql.Data.dll`。
2. 将 `MySql.Data.dll` 复制到项目 `Lib` 目录。
3. 在 Visual Studio 2012 中打开 `CampusPhotoShare.sln`。
4. 项目文件已经配置 `Lib\MySql.Data.dll` 引用路径，复制后可直接编译。
5. 若仍提示缺引用，右键引用中的 `MySql.Data`，移除后重新添加 `Lib\MySql.Data.dll`。

## 运行项目

1. 确认 MySQL 数据库已导入。
2. 确认 `Web.config` 连接串正确。
3. 在 VS2012 中设为启动项目。
4. 设置 `Default.aspx` 为启动页。
5. 按 F5 运行。

## 功能范围

- 游客可浏览首页、作品分类、作品详情、摄影师列表、摄影师主页。
- 普通用户可注册、登录、评论、提交约拍、查看个人预约。
- 摄影师可维护个人资料、上传和删除自有作品、处理个人预约。
- 管理员可进入 `AdminMain.aspx` 处理作品审核、摄影师管理、订单管理和评论管理。
- 未登录用户不能直接访问 `MyInfo.aspx`。
- 非管理员不能直接访问 `AdminMain.aspx`。
