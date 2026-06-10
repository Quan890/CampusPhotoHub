<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminMain.aspx.cs" Inherits="CampusPhotoShare.AdminMain" %>
<!DOCTYPE html>
<html><head runat="server"><meta charset="utf-8" /><title>管理员后台</title><link href="Css/site.css" rel="stylesheet" /></head>
<body>
<div class="topbar"><div class="topbar-inner"><div class="brand"><span class="brand-mark">影</span>校园摄影约拍</div><div class="nav"><%= BuildNavHtml() %></div></div></div>
<div class="userbar"><div class="userbar-inner"><%= BuildUserBarHtml() %></div></div>
<div class="container">
    <div class="section-title"><h2>管理员后台</h2></div>
    <div class="side-menu"><a href="#works">作品审核</a><a href="#photos">摄影师管理</a><a href="#orders">约拍订单管理</a><a href="#comments">评论管理</a></div>
    <div id="works" class="section-title"><h2>作品审核</h2></div><%= WorkAddHtml %><%= WorkHtml %>
    <div id="photos" class="section-title"><h2>摄影师信息管理</h2></div><%= PhotographerAddHtml %><%= PhotographerHtml %>
    <div id="orders" class="section-title"><h2>约拍订单管理</h2></div><%= OrderAddHtml %><%= OrderHtml %>
    <div id="comments" class="section-title"><h2>评论管理</h2></div><%= CommentAddHtml %><%= CommentHtml %>
</div>
<div class="footer">校园摄影作品分享与约拍平台</div>
</body></html>
