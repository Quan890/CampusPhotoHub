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
        private StringBuilder _alerts = new StringBuilder();

        protected override void Render(HtmlTextWriter writer)
        {
            StringWriter sw = new StringWriter();
            HtmlTextWriter hw = new HtmlTextWriter(sw);
            base.Render(hw);
            string html = sw.ToString();
            string script = _alerts.ToString();
            if (script.Length > 0)
            {
                int pos = html.LastIndexOf("</body>", StringComparison.OrdinalIgnoreCase);
                if (pos >= 0)
                {
                    html = html.Substring(0, pos) + script + html.Substring(pos);
                }
                else
                {
                    html += script;
                }
            }
            writer.Write(html);
        }

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
                AlertAndRedirect("请先登录后再操作", "Login.aspx?returnUrl=" + Server.UrlEncode(Request.RawUrl));
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
            _alerts.Append("<script>alert('" + JsEncode(message) + "');</script>");
        }

        protected void AlertAndRedirect(string message, string url)
        {
            string escapedMsg = JsEncode(message);
            string escapedUrl = JsEncode(url);
            _alerts.Append("<script>alert('" + escapedMsg + "');window.location='" + escapedUrl + "';</script>");
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
            string page = Path.GetFileName(Request.Path).ToLower();
            StringBuilder html = new StringBuilder();
            html.Append(NavLink("Default.aspx", "首页", page));
            html.Append(NavLink("WorkType.aspx", "作品分类", page));
            html.Append(NavLink("PhotoList.aspx", "摄影师列表", page));
            html.Append(NavLink("BookOrder.aspx", "约拍预约", page));

            if (IsLogin)
            {
                html.Append(NavLink("MyInfo.aspx", "个人中心", page));
                if (CurrentRole == "admin")
                {
                    html.Append(NavLink("AdminMain.aspx", "管理员后台", page));
                }
                html.Append("<a href=\"Login.aspx?action=logout\">退出登录</a>");
            }
            else
            {
                html.Append(NavLink("Login.aspx", "登录", page));
            }

            return html.ToString();
        }

        private string NavLink(string url, string text, string currentPage)
        {
            string target = url.Split('?')[0].ToLower();
            string cls = currentPage == target ? " class=\"active\"" : "";
            return "<a href=\"" + url + "\"" + cls + ">" + text + "</a>";
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
