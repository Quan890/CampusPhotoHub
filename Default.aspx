<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="CampusPhotoShare.Default" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <meta charset="utf-8" />
    <title>校园摄影作品分享与约拍平台</title>
    <link href="Css/site.css" rel="stylesheet" />
</head>
<body>
    <!-- ========== 顶部导航栏 ========== -->
    <div class="topbar"><div class="topbar-inner"><div class="brand"><span class="brand-mark">影</span>校园摄影约拍</div><div class="nav"><%= BuildNavHtml() %></div></div></div>
    <!-- ========== 用户信息栏 ========== -->
    <div class="userbar"><div class="userbar-inner"><%= BuildUserBarHtml() %></div></div>
    <script src="Scripts/site.js"></script>
    <div class="container">
        <!-- ========== 轮播图区域 ========== -->
        <div id="homeCarousel" class="hero carousel">
            <div class="carousel-slide active" style="background-image:url('Images/hero-campus.png')"></div>
            <div class="carousel-slide" style="background-image:url('Images/work-portrait.png')"></div>
            <div class="carousel-slide" style="background-image:url('Images/work-campus.png')"></div>
            <div class="carousel-slide" style="background-image:url('Images/work-still.png')"></div>
            <div class="hero-overlay"></div>
            <div class="hero-text"><h1>把校园里的光，留给认真生活的人</h1><p>分享摄影作品、发现校园摄影师、提交约拍需求，让毕业季、社团活动和日常记录都有好看的表达。</p></div>
            <div class="carousel-dots"><span class="carousel-dot active"></span><span class="carousel-dot"></span><span class="carousel-dot"></span><span class="carousel-dot"></span></div>
        </div>
        <!-- ========== 推荐作品列表（从数据库读取，按推荐+浏览量排序） ========== -->
        <div class="section-title"><h2>推荐摄影作品</h2><a href="WorkType.aspx">查看更多</a></div>
        <div class="grid"><%= WorkHtml %></div>
        <!-- ========== 热门摄影师列表（从数据库读取已启用的摄影师） ========== -->
        <div class="section-title"><h2>热门摄影师</h2><a href="PhotoList.aspx">全部摄影师</a></div>
        <div class="grid"><%= PhotoHtml %></div>
        <!-- ========== 分类快捷导航卡片 ========== -->
        <div class="section-title"><h2>分类快捷导航</h2></div>
        <div class="grid grid-four">
            <div class="card"><div class="card-body"><h3>人像</h3><p class="muted">毕业照、证件风、校园写真。</p><a class="btn-light btn" href="WorkType.aspx?type=人像">进入分类</a></div></div>
            <div class="card"><div class="card-body"><h3>校园风景</h3><p class="muted">建筑、湖景、操场与四季校园。</p><a class="btn-light btn" href="WorkType.aspx?type=校园风景">进入分类</a></div></div>
            <div class="card"><div class="card-body"><h3>静物</h3><p class="muted">书桌、相机、花束与课堂日常。</p><a class="btn-light btn" href="WorkType.aspx?type=静物">进入分类</a></div></div>
            <div class="card"><div class="card-body"><h3>立即约拍</h3><p class="muted">选择摄影师并提交拍摄需求。</p><a class="btn" href="BookOrder.aspx">预约摄影师</a></div></div>
        </div>
    </div>
    <!-- ========== 页脚 ========== -->
    <div class="footer">校园摄影作品分享与约拍平台 | ASP.NET Web Forms + ADO.NET + MySQL</div>
<button class="back-to-top" id="backToTop" title="回到顶部">↑</button>
<script>
(function () {
    var btn = document.getElementById('backToTop');
    window.addEventListener('scroll', function () {
        if (btn) btn.classList.toggle('show', window.scrollY > 300);
    });
    if (btn) btn.addEventListener('click', function () {
        window.scrollTo({ top: 0, behavior: 'smooth' });
    });
})();
</script>
</body>
</html>
