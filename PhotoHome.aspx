<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PhotoHome.aspx.cs" Inherits="CampusPhotoShare.PhotoHome" %>
<!DOCTYPE html>
<html><head runat="server"><meta charset="utf-8" /><title>摄影师主页</title><link href="Css/site.css" rel="stylesheet" /></head>
<body>
<div class="topbar"><div class="topbar-inner"><div class="brand"><span class="brand-mark">影</span>校园摄影约拍</div><div class="nav"><%= BuildNavHtml() %></div></div></div>
<div class="userbar"><div class="userbar-inner"><%= BuildUserBarHtml() %></div></div>
<div class="container"><%= ProfileHtml %><div class="section-title"><h2>个人作品集</h2></div><div class="grid"><%= WorkHtml %></div></div>
<div class="footer">校园摄影作品分享与约拍平台</div>
</body></html>
