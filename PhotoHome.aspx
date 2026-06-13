<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PhotoHome.aspx.cs" Inherits="CampusPhotoShare.PhotoHome" %>
<!DOCTYPE html>
<html><head runat="server"><meta charset="utf-8" /><title>摄影师主页</title><link href="Css/site.css" rel="stylesheet" /><script src="Scripts/site.js"></script></head>
<body>
<!-- ========== 顶部导航栏 ========== -->
<div class="topbar"><div class="topbar-inner"><div class="brand"><span class="brand-mark">影</span>校园摄影约拍</div><div class="nav"><%= BuildNavHtml() %></div></div></div>
<!-- ========== 用户信息栏 ========== -->
<div class="userbar"><div class="userbar-inner"><%= BuildUserBarHtml() %></div></div>
<div class="container">
    <!-- ========== 摄影师个人资料（头像、昵称、专长、报价、简介、档期） ========== -->
    <%= ProfileHtml %>
    <!-- ========== 摄影师作品集列表 ========== -->
    <div class="section-title"><h2>个人作品集</h2></div><div class="grid"><%= WorkHtml %></div>
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
