using System;
using System.Data;
using System.Text;
using CampusPhotoShare.Common;

namespace CampusPhotoShare
{
    public partial class Default : BasePage
    {
        protected string WorkHtml = "";
        protected string PhotoHtml = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            LoadWorks();
            LoadPhotographers();
        }

        private void LoadWorks()
        {
            DataTable table = DBHelper.GetDataTable("select w.*,p.nick_name from photo_work w inner join photographer p on w.photographer_id=p.photographer_id where w.audit_status=1 order by w.is_recommend*1000+w.view_count desc limit 6");
            StringBuilder html = new StringBuilder();
            for (int i = 0; i < table.Rows.Count; i++)
            {
                DataRow row = table.Rows[i];
                html.Append("<div class=\"card\"><a href=\"WorkDetail.aspx?id=" + row["work_id"] + "\"><img class=\"thumb\" src=\"" + HtmlEncode(row["image_url"]) + "\" /></a><div class=\"card-body\"><span class=\"tag\">" + HtmlEncode(row["work_type"]) + "</span><h3>" + HtmlEncode(row["title"]) + "</h3><p class=\"muted\">摄影师：" + HtmlEncode(row["nick_name"]) + "</p><a class=\"btn-light btn\" href=\"WorkDetail.aspx?id=" + row["work_id"] + "\">查看详情</a></div></div>");
            }
            WorkHtml = html.ToString();
        }

        private void LoadPhotographers()
        {
            DataTable table = DBHelper.GetDataTable("select * from photographer where status=1 order by photographer_id desc limit 3");
            StringBuilder html = new StringBuilder();
            for (int i = 0; i < table.Rows.Count; i++)
            {
                DataRow row = table.Rows[i];
                html.Append("<div class=\"card\"><img class=\"thumb\" src=\"" + HtmlEncode(row["avatar"]) + "\" /><div class=\"card-body\"><h3>" + HtmlEncode(row["nick_name"]) + "</h3><p class=\"muted\">" + HtmlEncode(row["specialty"]) + "</p><p>约拍报价：￥" + HtmlEncode(row["price"]) + "</p><a class=\"btn\" href=\"PhotoHome.aspx?id=" + row["photographer_id"] + "\">进入主页</a></div></div>");
            }
            PhotoHtml = html.ToString();
        }
    }
}
