<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="CampusPhotoShare.Login" %>
<!DOCTYPE html>
<html><head runat="server"><meta charset="utf-8" /><title>登录注册</title><link href="Css/site.css" rel="stylesheet" /><script src="Scripts/site.js"></script><script src="Scripts/security.js"></script></head>
<body>
<div class="topbar"><div class="topbar-inner"><div class="brand"><span class="brand-mark">影</span>校园摄影约拍</div><div class="nav"><%= BuildNavHtml() %></div></div></div>
<div class="userbar"><div class="userbar-inner"><%= BuildUserBarHtml() %></div></div>
<div class="container two-col">
    <form method="post" action="Login.aspx" class="form-panel" onsubmit="return submitLoginForm(this)">
        <input type="hidden" name="action" value="login" />
        <input type="hidden" name="password_hash" value="" />
        <h2>账号登录</h2>
        <div class="form-row"><label>账号</label><input class="input" name="user_name" /></div>
        <div class="form-row"><label>密码</label><input class="input" type="password" name="password" /></div>
        <button class="btn" type="submit">登录</button>
    </form>
    <form method="post" action="Login.aspx" class="form-panel" onsubmit="return submitRegisterForm(this)">
        <input type="hidden" name="action" value="register" />
        <input type="hidden" name="reg_password_hash" value="" />
        <h2>用户注册</h2>
        <div class="form-row"><label>账号</label><input class="input" name="reg_user_name" /></div>
        <div class="form-row"><label>密码</label><input class="input" type="password" name="reg_password" /></div>
        <div class="form-row"><label>姓名</label><input class="input" name="real_name" /></div>
        <div class="form-row"><label>手机</label><input class="input" name="phone" /></div>
        <div class="form-row"><label>邮箱</label><input class="input" name="email" /></div>
        <button class="btn" type="submit">注册普通用户</button>
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
