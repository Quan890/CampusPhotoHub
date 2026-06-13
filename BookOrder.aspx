<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BookOrder.aspx.cs" Inherits="CampusPhotoShare.BookOrder" %>
<!DOCTYPE html>
<html><head runat="server"><meta charset="utf-8" /><title>约拍预约</title><link href="Css/site.css" rel="stylesheet" /><script src="Scripts/site.js"></script></head>
<body>
<!-- ========== 顶部导航栏 ========== -->
<div class="topbar"><div class="topbar-inner"><div class="brand"><span class="brand-mark">影</span>校园摄影约拍</div><div class="nav"><%= BuildNavHtml() %></div></div></div>
<!-- ========== 用户信息栏 ========== -->
<div class="userbar"><div class="userbar-inner"><%= BuildUserBarHtml() %></div></div>
<div class="container">
<!-- ========== 约拍预约表单（需登录，选择摄影师+日期+地点+需求） ========== -->
<form method="post" action="BookOrder.aspx" class="form-panel">
    <input type="hidden" name="action" value="book" />
    <h2>提交约拍预约</h2>
    <div class="form-row"><label>选择摄影师</label><select class="select" name="photographer_id"><%= PhotographerOptions %></select></div>
    <div class="form-row"><label>拍摄日期</label><input class="input" type="date" name="shoot_date" /></div>
    <div class="form-row"><label>拍摄地点</label><input class="input" name="shoot_place" /></div>
    <div class="form-row"><label>需求备注</label><textarea class="textarea" name="requirement"></textarea></div>
    <button class="btn" type="submit">提交预约</button>
</form>
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
