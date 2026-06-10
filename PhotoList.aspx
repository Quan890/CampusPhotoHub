<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PhotoList.aspx.cs" Inherits="CampusPhotoShare.PhotoList" %>
<!DOCTYPE html>
<html><head runat="server"><meta charset="utf-8" /><title>摄影师列表</title><link href="Css/site.css" rel="stylesheet" /></head>
<body>
<div class="topbar"><div class="topbar-inner"><div class="brand"><span class="brand-mark">影</span>校园摄影约拍</div><div class="nav"><%= BuildNavHtml() %></div></div></div>
<div class="userbar"><div class="userbar-inner"><%= BuildUserBarHtml() %></div></div>
<div class="container"><div class="section-title"><h2>摄影师列表</h2></div><div class="grid"><%= PhotoHtml %></div></div>
<div class="footer">校园摄影作品分享与约拍平台</div>
</body></html>
