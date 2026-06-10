using System;
using System.IO;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CampusPhotoShare.Common
{
    public class BasePage : Page
    {
        protected int CurrentUserId
        {
            get
            {
                if (Session["UserId"] == null)
                {
                    return 0;
                }
                return Convert.ToInt32(Session["UserId"]);
            }
        }

        protected string CurrentUserName
        {
            get
            {
                if (Session["UserName"] == null)
                {
                    return string.Empty;
                }
                return Session["UserName"].ToString();
            }
        }

        protected string CurrentRole
        {
            get
            {
                if (Session["Role"] == null)
                {
                    return "guest";
                }
                return Session["Role"].ToString();
            }
        }

        protected bool IsLogin
        {
            get { return CurrentUserId > 0; }
        }

        protected override void OnPreRender(EventArgs e)
        {
            base.OnPreRender(e);
            Literal nav = FindControl("litNav") as Literal;
            if (nav != null)
            {
                nav.Text = BuildNavHtml();
            }

            Literal userBar = FindControl("litUserBar") as Literal;
            if (userBar != null)
            {
                userBar.Text = BuildUserBarHtml();
            }
        }

        protected void RequireLogin()
        {
            if (!IsLogin)
            {
                Response.Redirect("Login.aspx?returnUrl=" + Server.UrlEncode(Request.RawUrl));
            }
        }

        protected void RequireAdmin()
        {
            RequireLogin();
            if (CurrentRole != "admin")
            {
                Response.Redirect("Default.aspx");
            }
        }

        protected void Alert(string message)
        {
            string script = "alert('" + JsEncode(message) + "');";
            ClientScript.RegisterStartupScript(GetType(), Guid.NewGuid().ToString("N"), script, true);
        }

        protected void AlertAndRedirect(string message, string url)
        {
            string escapedMsg = JsEncode(message);
            string escapedUrl = JsEncode(url);
            HttpContext.Current.Response.Write("<script>alert('" + escapedMsg + "');window.location='" + escapedUrl + "';</script>");
            HttpContext.Current.Response.End();
        }

        public static string Md5(string text)
        {
            using (MD5 md5 = MD5.Create())
            {
                byte[] input = Encoding.UTF8.GetBytes(text == null ? string.Empty : text);
                byte[] hash = md5.ComputeHash(input);
                StringBuilder builder = new StringBuilder();
                for (int i = 0; i < hash.Length; i++)
                {
                    builder.Append(hash[i].ToString("x2"));
                }
                return builder.ToString();
            }
        }

        protected string HtmlEncode(object value)
        {
            if (value == null)
            {
                return string.Empty;
            }
            return Server.HtmlEncode(value.ToString());
        }

        protected string BuildNavHtml()
        {
            StringBuilder html = new StringBuilder();
            html.Append("<a href=\"Default.aspx\">首页</a>");
            html.Append("<a href=\"WorkType.aspx\">作品分类</a>");
            html.Append("<a href=\"PhotoList.aspx\">摄影师列表</a>");
            html.Append("<a href=\"BookOrder.aspx\">约拍预约</a>");

            if (IsLogin)
            {
                html.Append("<a href=\"MyInfo.aspx\">个人中心</a>");
                if (CurrentRole == "admin")
                {
                    html.Append("<a href=\"AdminMain.aspx\">管理员后台</a>");
                }
                html.Append("<a href=\"Login.aspx?action=logout\">退出登录</a>");
            }
            else
            {
                html.Append("<a href=\"Login.aspx\">登录</a>");
            }

            return html.ToString();
        }

        protected string BuildUserBarHtml()
        {
            if (!IsLogin)
            {
                return "<span>游客浏览</span>";
            }
            return "<span>欢迎您，" + HttpUtility.HtmlEncode(CurrentUserName) + "（" + RoleName(CurrentRole) + "）</span>";
        }

        protected string RoleName(string role)
        {
            if (role == "admin")
            {
                return "管理员";
            }
            if (role == "photographer")
            {
                return "摄影师";
            }
            if (role == "user")
            {
                return "普通用户";
            }
            return "游客";
        }

        protected int ToInt(string value, int defaultValue)
        {
            int result = defaultValue;
            if (int.TryParse(value, out result))
            {
                return result;
            }
            return defaultValue;
        }

        protected decimal ToDecimal(string value, decimal defaultValue)
        {
            decimal result = defaultValue;
            if (decimal.TryParse(value, out result))
            {
                return result;
            }
            return defaultValue;
        }

        protected string FormText(string key)
        {
            string value = Request.Form[key];
            if (value == null)
            {
                return string.Empty;
            }
            return value.Trim();
        }

        protected string QueryText(string key)
        {
            string value = Request.QueryString[key];
            if (value == null)
            {
                return string.Empty;
            }
            return value.Trim();
        }

        protected string SaveUploadImage(string formName, string folder)
        {
            HttpPostedFile file = Request.Files[formName];
            if (file == null || file.ContentLength <= 0)
            {
                return string.Empty;
            }

            string ext = Path.GetExtension(file.FileName).ToLower();
            if (ext != ".jpg" && ext != ".jpeg" && ext != ".png" && ext != ".gif")
            {
                Alert("只允许上传 jpg、png、gif 格式图片。");
                return string.Empty;
            }

            string relativeFolder = folder.Trim('/').Replace("\\", "/");
            string serverFolder = Server.MapPath("~/" + relativeFolder);
            if (!Directory.Exists(serverFolder))
            {
                Directory.CreateDirectory(serverFolder);
            }

            string fileName = DateTime.Now.ToString("yyyyMMddHHmmssfff") + ext;
            string fullPath = Path.Combine(serverFolder, fileName);
            file.SaveAs(fullPath);
            return relativeFolder + "/" + fileName;
        }

        private static string JsEncode(string text)
        {
            if (text == null)
            {
                return string.Empty;
            }
            return text.Replace("\\", "\\\\").Replace("'", "\\'").Replace("\r", "").Replace("\n", "");
        }
    }
}
