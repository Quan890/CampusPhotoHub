using System;
using System.Data;
using System.Text;
using MySql.Data.MySqlClient;
using CampusPhotoShare.Common;

namespace CampusPhotoShare
{
    public partial class WorkType : BasePage
    {
        protected string WorkHtml = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            string type = QueryText("type");
            string sql = "select w.*,p.nick_name from photo_work w inner join photographer p on w.photographer_id=p.photographer_id where w.audit_status=1";
            DataTable table;
            if (type.Length > 0)
            {
                sql += " and w.work_type=@type order by w.create_time desc";
                table = DBHelper.GetDataTable(sql, new MySqlParameter("@type", type));
            }
            else
            {
                sql += " order by w.create_time desc";
                table = DBHelper.GetDataTable(sql);
            }
            StringBuilder html = new StringBuilder();
            for (int i = 0; i < table.Rows.Count; i++)
            {
                DataRow row = table.Rows[i];
                html.Append("<div class=\"card\"><a href=\"WorkDetail.aspx?id=" + row["work_id"] + "\"><img class=\"thumb\" src=\"" + HtmlEncode(row["image_url"]) + "\" /></a><div class=\"card-body\"><span class=\"tag\">" + HtmlEncode(row["work_type"]) + "</span><h3>" + HtmlEncode(row["title"]) + "</h3><p class=\"muted\">摄影师：" + HtmlEncode(row["nick_name"]) + "</p><p>" + HtmlEncode(row["description"]) + "</p><a class=\"btn\" href=\"WorkDetail.aspx?id=" + row["work_id"] + "\">查看详情</a></div></div>");
            }
            WorkHtml = html.ToString();
        }
    }
}
