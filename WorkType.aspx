<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WorkType.aspx.cs" Inherits="CampusPhotoShare.WorkType" %>
<!DOCTYPE html>
<html><head runat="server"><meta charset="utf-8" /><title>作品分类</title><link href="Css/site.css" rel="stylesheet" /></head>
<body>
<div class="topbar"><div class="topbar-inner"><div class="brand"><span class="brand-mark">影</span>校园摄影约拍</div><div class="nav"><%= BuildNavHtml() %></div></div></div>
<div class="userbar"><div class="userbar-inner"><%= BuildUserBarHtml() %></div></div>
<div class="container">
    <div class="section-title"><h2>作品分类</h2></div>
    <p><a class="btn-light btn" href="WorkType.aspx">全部</a> <a class="btn-light btn" href="WorkType.aspx?type=人像">人像</a> <a class="btn-light btn" href="WorkType.aspx?type=校园风景">校园风景</a> <a class="btn-light btn" href="WorkType.aspx?type=静物">静物</a></p>
    <div class="grid"><%= WorkHtml %></div>
</div>
<div class="footer">校园摄影作品分享与约拍平台</div>
</body></html>
