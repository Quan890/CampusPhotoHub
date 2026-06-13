<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WorkDetail.aspx.cs" Inherits="CampusPhotoShare.WorkDetail" %>
<!DOCTYPE html>
<html><head runat="server"><meta charset="utf-8" /><title>作品详情</title><link href="Css/site.css" rel="stylesheet" /><script src="Scripts/site.js"></script></head>
<body>
<!-- ========== 顶部导航栏 ========== -->
<div class="topbar"><div class="topbar-inner"><div class="brand"><span class="brand-mark">影</span>校园摄影约拍</div><div class="nav"><%= BuildNavHtml() %></div></div></div>
<!-- ========== 用户信息栏 ========== -->
<div class="userbar"><div class="userbar-inner"><%= BuildUserBarHtml() %></div></div>
<div class="container">
    <!-- ========== 作品详情（大图、标题、分类、摄影师、浏览量） ========== -->
    <%= DetailHtml %>
    <!-- ========== 评论发表表单（需登录才能提交） ========== -->
    <div class="section-title"><h2>评论区</h2></div>
    <form method="post" action="WorkDetail.aspx?id=<%= WorkId %>" class="form-panel">
        <input type="hidden" name="action" value="comment" />
        <div class="form-row"><label>评论内容</label><textarea class="textarea" name="content"></textarea></div>
        <button class="btn" type="submit">发布评论</button>
    </form>
    <div style="height:18px"></div>
    <!-- ========== 评论列表（只显示已审核的评论） ========== -->
    <%= CommentHtml %>
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
