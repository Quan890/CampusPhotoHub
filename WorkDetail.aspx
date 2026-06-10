<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WorkDetail.aspx.cs" Inherits="CampusPhotoShare.WorkDetail" %>
<!DOCTYPE html>
<html><head runat="server"><meta charset="utf-8" /><title>作品详情</title><link href="Css/site.css" rel="stylesheet" /></head>
<body>
<div class="topbar"><div class="topbar-inner"><div class="brand"><span class="brand-mark">影</span>校园摄影约拍</div><div class="nav"><%= BuildNavHtml() %></div></div></div>
<div class="userbar"><div class="userbar-inner"><%= BuildUserBarHtml() %></div></div>
<div class="container">
    <%= DetailHtml %>
    <div class="section-title"><h2>评论区</h2></div>
    <form method="post" action="WorkDetail.aspx?id=<%= WorkId %>" class="form-panel">
        <input type="hidden" name="action" value="comment" />
        <div class="form-row"><label>评论内容</label><textarea class="textarea" name="content"></textarea></div>
        <button class="btn" type="submit">发布评论</button>
    </form>
    <div style="height:18px"></div>
    <%= CommentHtml %>
</div>
<div class="footer">校园摄影作品分享与约拍平台</div>
</body></html>
