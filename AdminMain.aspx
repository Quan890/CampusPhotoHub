<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminMain.aspx.cs" Inherits="CampusPhotoShare.AdminMain" %>
<!DOCTYPE html>
<html><head runat="server"><meta charset="utf-8" /><title>管理员后台</title><link href="Css/site.css" rel="stylesheet" /><script src="Scripts/site.js"></script></head>
<body>
<div class="topbar"><div class="topbar-inner"><div class="brand"><span class="brand-mark">影</span>校园摄影约拍</div><div class="nav"><%= BuildNavHtml() %></div></div></div>
<div class="userbar"><div class="userbar-inner"><%= BuildUserBarHtml() %></div></div>
<div class="container">
    <div class="section-title"><h2>管理员后台</h2></div>
    <div class="two-col">
        <div class="side-menu"><a href="#works">作品审核</a><a href="#photos">摄影师管理</a><a href="#orders">约拍订单管理</a><a href="#comments">评论管理</a></div>
        <div>
            <div id="works" class="section-title"><h2>作品审核</h2></div><%= WorkAddHtml %><%= WorkHtml %>
            <div id="photos" class="section-title"><h2>摄影师信息管理</h2></div><%= PhotographerAddHtml %><%= PhotographerHtml %>
            <div id="orders" class="section-title"><h2>约拍订单管理</h2></div><%= OrderAddHtml %><%= OrderHtml %>
            <div id="comments" class="section-title"><h2>评论管理</h2></div><%= CommentAddHtml %><%= CommentHtml %>
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
