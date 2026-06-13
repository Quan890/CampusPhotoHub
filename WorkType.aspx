<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WorkType.aspx.cs" Inherits="CampusPhotoShare.WorkType" %>
<!DOCTYPE html>
<html><head runat="server"><meta charset="utf-8" /><title>作品分类</title><link href="Css/site.css" rel="stylesheet" /><script src="Scripts/site.js"></script></head>
<body>
<!-- ========== 顶部导航栏 ========== -->
<div class="topbar"><div class="topbar-inner"><div class="brand"><span class="brand-mark">影</span>校园摄影约拍</div><div class="nav"><%= BuildNavHtml() %></div></div></div>
<!-- ========== 用户信息栏 ========== -->
<div class="userbar"><div class="userbar-inner"><%= BuildUserBarHtml() %></div></div>
<div class="container">
    <div class="section-title"><h2>作品分类</h2></div>
    <!-- ========== 分类筛选按钮（通过URL参数?type=筛选） ========== -->
    <div class="filter-bar">
        <a class="<%= CurrentType == "" ? "active" : "" %>" href="WorkType.aspx">全部</a>
        <a class="<%= CurrentType == "人像" ? "active" : "" %>" href="WorkType.aspx?type=人像">人像</a>
        <a class="<%= CurrentType == "校园风景" ? "active" : "" %>" href="WorkType.aspx?type=校园风景">校园风景</a>
        <a class="<%= CurrentType == "静物" ? "active" : "" %>" href="WorkType.aspx?type=静物">静物</a>
    </div>
    <!-- ========== 作品卡片列表（从数据库按分类筛选） ========== -->
    <div class="grid"><%= WorkHtml %></div>
    <%= PagerHtml %>
</div>
<div class="footer">校园摄影作品分享与约拍平台</div>
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
</body></html>
