using System;
using System.Data;
using System.Text;
using CampusPhotoShare.Common;

namespace CampusPhotoShare
{
    public partial class PhotoList : BasePage
    {
        protected string PhotoHtml = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            DataTable table = DBHelper.GetDataTable("select * from photographer where status=1 order by photographer_id desc");
            StringBuilder html = new StringBuilder();
            for (int i = 0; i < table.Rows.Count; i++)
            {
                DataRow row = table.Rows[i];
                html.Append("<div class=\"card\"><img class=\"thumb\" src=\"" + HtmlEncode(row["avatar"]) + "\" /><div class=\"card-body\"><h3>" + HtmlEncode(row["nick_name"]) + "</h3><p><span class=\"tag\">" + HtmlEncode(row["specialty"]) + "</span></p><p class=\"muted\">" + HtmlEncode(row["intro"]) + "</p><p>报价：￥" + HtmlEncode(row["price"]) + "</p><a class=\"btn\" href=\"PhotoHome.aspx?id=" + row["photographer_id"] + "\">查看主页</a> <a class=\"btn-light btn\" href=\"BookOrder.aspx?pid=" + row["photographer_id"] + "\">预约</a></div></div>");
            }
            PhotoHtml = html.ToString();
        }
    }
}
