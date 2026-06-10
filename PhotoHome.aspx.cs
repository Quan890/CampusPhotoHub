using System;
using System.Data;
using System.Text;
using MySql.Data.MySqlClient;
using CampusPhotoShare.Common;

namespace CampusPhotoShare
{
    public partial class PhotoHome : BasePage
    {
        protected string ProfileHtml = "";
        protected string WorkHtml = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            int id = ToInt(QueryText("id"), 0);
            DataTable p = DBHelper.GetDataTable("select * from photographer where photographer_id=@id and status=1", new MySqlParameter("@id", id));
            if (p.Rows.Count == 0)
            {
                AlertAndRedirect("摄影师不存在。", "PhotoList.aspx");
                return;
            }
            DataRow row = p.Rows[0];
            ProfileHtml = "<div class=\"card\"><img class=\"thumb\" style=\"height:260px\" src=\"" + HtmlEncode(row["avatar"]) + "\" /><div class=\"card-body\"><h2>" + HtmlEncode(row["nick_name"]) + "</h2><p><span class=\"tag\">" + HtmlEncode(row["specialty"]) + "</span></p><p>" + HtmlEncode(row["intro"]) + "</p><p>报价：￥" + HtmlEncode(row["price"]) + " | 空闲档期：" + HtmlEncode(row["free_time"]) + "</p><a class=\"btn\" href=\"BookOrder.aspx?pid=" + row["photographer_id"] + "\">预约该摄影师</a></div></div>";
            DataTable works = DBHelper.GetDataTable("select * from photo_work where photographer_id=@id and audit_status=1 order by create_time desc", new MySqlParameter("@id", id));
            StringBuilder html = new StringBuilder();
            for (int i = 0; i < works.Rows.Count; i++)
            {
                DataRow w = works.Rows[i];
                html.Append("<div class=\"card\"><a href=\"WorkDetail.aspx?id=" + w["work_id"] + "\"><img class=\"thumb\" src=\"" + HtmlEncode(w["image_url"]) + "\" /></a><div class=\"card-body\"><h3>" + HtmlEncode(w["title"]) + "</h3><p class=\"muted\">" + HtmlEncode(w["work_type"]) + "</p></div></div>");
            }
            WorkHtml = html.ToString();
        }
    }
}
