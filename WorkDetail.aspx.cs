using System;
using System.Data;
using System.Text;
using MySql.Data.MySqlClient;
using CampusPhotoShare.Common;

namespace CampusPhotoShare
{
    public partial class WorkDetail : BasePage
    {
        protected int WorkId = 0;
        protected string DetailHtml = "";
        protected string CommentHtml = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            WorkId = ToInt(QueryText("id"), 0);
            if (WorkId <= 0)
            {
                AlertAndRedirect("作品不存在。", "WorkType.aspx");
                return;
            }
            if (Request.HttpMethod == "POST" && FormText("action") == "comment")
            {
                AddComment();
            }
            LoadDetail();
            LoadComments();
        }

        private void AddComment()
        {
            if (!IsLogin)
            {
                Response.Redirect("Login.aspx?returnUrl=" + Server.UrlEncode(Request.RawUrl), false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }
            string content = FormText("content");
            if (content.Length == 0)
            {
                Alert("请输入评论内容。");
                return;
            }
            DBHelper.ExecuteNonQuery("insert into comment(work_id,user_id,content,status,create_time) values(@wid,@uid,@content,1,now())", new MySqlParameter("@wid", WorkId), new MySqlParameter("@uid", CurrentUserId), new MySqlParameter("@content", content));
            Alert("评论发布成功。");
        }

        private void LoadDetail()
        {
            DataTable table = DBHelper.GetDataTable("select w.*,p.nick_name,p.photographer_id from photo_work w inner join photographer p on w.photographer_id=p.photographer_id where w.work_id=@id and w.audit_status=1", new MySqlParameter("@id", WorkId));
            if (table.Rows.Count == 0)
            {
                DetailHtml = "<div class=\"form-panel\">作品不存在或尚未审核。</div>";
                return;
            }
            DBHelper.ExecuteNonQuery("update photo_work set view_count=view_count+1 where work_id=@id", new MySqlParameter("@id", WorkId));
            DataRow row = table.Rows[0];
            DetailHtml = "<div class=\"card\"><img style=\"width:100%;max-height:560px;object-fit:cover;display:block\" src=\"" + HtmlEncode(row["image_url"]) + "\" /><div class=\"card-body\"><span class=\"tag\">" + HtmlEncode(row["work_type"]) + "</span><h2>" + HtmlEncode(row["title"]) + "</h2><p class=\"muted\">摄影师：<a href=\"PhotoHome.aspx?id=" + row["photographer_id"] + "\">" + HtmlEncode(row["nick_name"]) + "</a> | 浏览：" + HtmlEncode(row["view_count"]) + "</p><p>" + HtmlEncode(row["description"]) + "</p></div></div>";
        }

        private void LoadComments()
        {
            DataTable table = DBHelper.GetDataTable("select c.*,u.user_name from comment c inner join sys_user u on c.user_id=u.user_id where c.work_id=@id and c.status=1 order by c.create_time desc", new MySqlParameter("@id", WorkId));
            StringBuilder html = new StringBuilder();
            for (int i = 0; i < table.Rows.Count; i++)
            {
                DataRow row = table.Rows[i];
                html.Append("<div class=\"card\"><div class=\"card-body\"><p>" + HtmlEncode(row["content"]) + "</p><p class=\"muted\">" + HtmlEncode(row["user_name"]) + " · " + HtmlEncode(row["create_time"]) + "</p></div></div><div style=\"height:10px\"></div>");
            }
            if (table.Rows.Count == 0)
            {
                html.Append("<div class=\"form-panel muted\">暂无评论。</div>");
            }
            CommentHtml = html.ToString();
        }
    }
}
