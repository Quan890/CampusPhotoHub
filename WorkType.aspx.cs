using System;
using System.Data;
using System.Text;
using System.Web;
using MySql.Data.MySqlClient;
using CampusPhotoShare.Common;

namespace CampusPhotoShare
{
    public partial class WorkType : BasePage
    {
        protected string WorkHtml = "";
        protected string PagerHtml = "";
        protected string CurrentType = "";

        private const int PageSize = 9;

        protected void Page_Load(object sender, EventArgs e)
        {
            string type = QueryText("type");
            CurrentType = type;
            int page = 1;
            int.TryParse(Request.QueryString["page"], out page);
            if (page < 1) page = 1;

            // 构建基础查询条件
            string where = " where w.audit_status=1";
            MySqlParameter typeParam = null;
            if (type.Length > 0)
            {
                where += " and w.work_type=@type";
                typeParam = new MySqlParameter("@type", type);
            }

            // 查询总数
            string countSql = "select count(*) from photo_work w" + where;
            int total = Convert.ToInt32(typeParam != null
                ? DBHelper.ExecuteScalar(countSql, typeParam)
                : DBHelper.ExecuteScalar(countSql));
            int totalPages = (int)Math.Ceiling((double)total / PageSize);
            if (page > totalPages && totalPages > 0) page = totalPages;

            // 查询当前页数据
            int offset = (page - 1) * PageSize;
            string dataSql = "select w.*,p.nick_name from photo_work w inner join photographer p on w.photographer_id=p.photographer_id"
                + where + " order by w.view_count desc limit @offset,@size";
            DataTable table;
            if (typeParam != null)
            {
                table = DBHelper.GetDataTable(dataSql, typeParam,
                    new MySqlParameter("@offset", offset),
                    new MySqlParameter("@size", PageSize));
            }
            else
            {
                table = DBHelper.GetDataTable(dataSql,
                    new MySqlParameter("@offset", offset),
                    new MySqlParameter("@size", PageSize));
            }

            // 生成作品卡片
            StringBuilder html = new StringBuilder();
            for (int i = 0; i < table.Rows.Count; i++)
            {
                DataRow row = table.Rows[i];
                html.Append("<div class=\"card\"><a href=\"WorkDetail.aspx?id=" + row["work_id"] + "\"><img class=\"thumb\" src=\"" + HtmlEncode(row["image_url"]) + "\" /></a><div class=\"card-body\"><span class=\"tag\">" + HtmlEncode(row["work_type"]) + "</span><h3>" + HtmlEncode(row["title"]) + "</h3><p class=\"muted\">摄影师：" + HtmlEncode(row["nick_name"]) + "</p><p>" + HtmlEncode(row["description"]) + "</p><a class=\"btn\" href=\"WorkDetail.aspx?id=" + row["work_id"] + "\">查看详情</a></div></div>");
            }
            WorkHtml = html.ToString();

            // 生成分页导航
            if (totalPages > 1)
            {
                string baseUrl = "WorkType.aspx";
                string typeArg = type.Length > 0 ? "&type=" + HttpUtility.UrlEncode(type) : "";
                StringBuilder pager = new StringBuilder();
                pager.Append("<div class=\"pager\">");

                // 上一页
                if (page > 1)
                    pager.Append("<a class=\"pager-btn\" href=\"" + baseUrl + "?page=" + (page - 1) + typeArg + "\">&laquo;</a>");
                else
                    pager.Append("<span class=\"pager-btn disabled\">&laquo;</span>");

                // 页码：显示当前页附近的页码
                int start = Math.Max(1, page - 2);
                int end = Math.Min(totalPages, page + 2);
                if (start > 1)
                {
                    pager.Append("<a class=\"pager-num\" href=\"" + baseUrl + "?page=1" + typeArg + "\">1</a>");
                    if (start > 2) pager.Append("<span class=\"pager-ellipsis\">…</span>");
                }
                for (int i = start; i <= end; i++)
                {
                    if (i == page)
                        pager.Append("<span class=\"pager-num active\">" + i + "</span>");
                    else
                        pager.Append("<a class=\"pager-num\" href=\"" + baseUrl + "?page=" + i + typeArg + "\">" + i + "</a>");
                }
                if (end < totalPages)
                {
                    if (end < totalPages - 1) pager.Append("<span class=\"pager-ellipsis\">…</span>");
                    pager.Append("<a class=\"pager-num\" href=\"" + baseUrl + "?page=" + totalPages + typeArg + "\">" + totalPages + "</a>");
                }

                // 下一页
                if (page < totalPages)
                    pager.Append("<a class=\"pager-btn\" href=\"" + baseUrl + "?page=" + (page + 1) + typeArg + "\">&raquo;</a>");
                else
                    pager.Append("<span class=\"pager-btn disabled\">&raquo;</span>");

                pager.Append("</div>");
                PagerHtml = pager.ToString();
            }
        }
    }
}
