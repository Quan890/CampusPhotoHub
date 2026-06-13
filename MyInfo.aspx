<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MyInfo.aspx.cs" Inherits="CampusPhotoShare.MyInfo" %>
<!DOCTYPE html>
<html><head runat="server"><meta charset="utf-8" /><title>个人中心</title><link href="Css/site.css" rel="stylesheet" /><script src="Scripts/site.js"></script></head>
<body>
<!-- ========== 顶部导航栏 ========== -->
<div class="topbar"><div class="topbar-inner"><div class="brand"><span class="brand-mark">影</span>校园摄影约拍</div><div class="nav"><%= BuildNavHtml() %></div></div></div>
<!-- ========== 用户信息栏 ========== -->
<div class="userbar"><div class="userbar-inner"><%= BuildUserBarHtml() %></div></div>
<div class="container">
    <div class="section-title"><h2>个人中心</h2></div>
    <div class="two-col">
        <!-- ========== 左侧导航菜单（滚动固定+高亮） ========== -->
        <div class="side-menu"><a href="#profile">资料修改</a><a href="#orders">我的约拍</a><%= PhotographerMenu %></div>
        <div>
            <!-- ========== 资料修改表单（姓名、性别、手机、邮箱、密码） ========== -->
            <form id="profile" method="post" action="MyInfo.aspx" enctype="multipart/form-data" class="form-panel">
                <input type="hidden" name="action" value="profile" />
                <h2>资料修改</h2>
                <%= ProfileFormHtml %>
                <button class="btn" type="submit">保存资料</button>
            </form>
            <!-- ========== 我的约拍订单列表 ========== -->
            <div id="orders" class="section-title"><h2>我的约拍</h2></div>
            <%= OrderHtml %>
            <!-- ========== 摄影师专区（仅摄影师可见：资料编辑+作品管理） ========== -->
            <%= PhotographerPanelHtml %>
        </div>
    </div>
</div>
<div class="footer">校园摄影作品分享与约拍平台</div>
<button class="back-to-top" id="backToTop" title="回到顶部">↑</button>
<script>
(function () {
    var sideMenu = document.querySelector('.side-menu');
    var btn = document.getElementById('backToTop');
    var links = sideMenu ? sideMenu.querySelectorAll('a[href^="#"]') : [];
    var sections = [];
    for (var i = 0; i < links.length; i++) {
        var id = links[i].getAttribute('href').slice(1);
        var el = document.getElementById(id);
        if (el) sections.push({ link: links[i], el: el });
    }
    function onScroll() {
        var s = window.scrollY > 10;
        if (sideMenu) sideMenu.classList.toggle('scrolled', s);
        if (btn) btn.classList.toggle('show', window.scrollY > 300);
        var cur = null;
        for (var i = sections.length - 1; i >= 0; i--) {
            if (sections[i].el.getBoundingClientRect().top <= 140) { cur = i; break; }
        }
        for (var j = 0; j < sections.length; j++) {
            sections[j].link.classList.toggle('active', j === cur);
        }
    }
    window.addEventListener('scroll', onScroll);
    onScroll();
    if (btn) btn.addEventListener('click', function () {
        window.scrollTo({ top: 0, behavior: 'smooth' });
    });
})();
</script>
</body></html>
