using System;
using System.Data;
using System.Text;
using MySql.Data.MySqlClient;
using CampusPhotoShare.Common;

namespace CampusPhotoShare
{
    public partial class AdminMain : BasePage
    {
        protected string WorkHtml = "";
        protected string PhotographerHtml = "";
        protected string OrderHtml = "";
        protected string CommentHtml = "";
        protected string WorkAddHtml = "";
        protected string PhotographerAddHtml = "";
        protected string OrderAddHtml = "";
        protected string CommentAddHtml = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            RequireAdmin();
            if (Request.HttpMethod == "POST")
            {
                HandlePost();
            }
            LoadAddForms();
            LoadWorks();
            LoadPhotographers();
            LoadOrders();
            LoadComments();
        }

        private void HandlePost()
        {
            string action = FormText("action");
            if (action == "work_add")
            {
                string img = SaveUploadImage("work_image", "Uploads/Works");
                if (img.Length == 0)
                {
                    Alert("请上传作品图片。");
                    return;
                }
                DBHelper.ExecuteNonQuery("insert into photo_work(photographer_id,title,work_type,image_url,description,is_recommend,audit_status,view_count,create_time) values(@pid,@title,@type,@img,@desc,@rec,@audit,0,now())", new MySqlParameter("@pid", ToInt(FormText("photographer_id"), 0)), new MySqlParameter("@title", FormText("title")), new MySqlParameter("@type", FormText("work_type")), new MySqlParameter("@img", img), new MySqlParameter("@desc", FormText("description")), new MySqlParameter("@rec", ToInt(FormText("is_recommend"), 0)), new MySqlParameter("@audit", ToInt(FormText("audit_status"), 1)));
                Alert("作品已新增。");
            }
            if (action == "work_audit")
            {
                DBHelper.ExecuteNonQuery("update photo_work set audit_status=@s,is_recommend=@r where work_id=@id", new MySqlParameter("@s", ToInt(FormText("audit_status"), 0)), new MySqlParameter("@r", ToInt(FormText("is_recommend"), 0)), new MySqlParameter("@id", ToInt(FormText("work_id"), 0)));
                Alert("作品状态已更新。");
            }
            if (action == "work_delete")
            {
                DBHelper.ExecuteNonQuery("delete from photo_work where work_id=@id", new MySqlParameter("@id", ToInt(FormText("work_id"), 0)));
                Alert("作品已删除。");
            }
            if (action == "photo_add")
            {
                object count = DBHelper.ExecuteScalar("select count(*) from sys_user where user_name=@name", new MySqlParameter("@name", FormText("user_name")));
                if (Convert.ToInt32(count) > 0)
                {
                    Alert("摄影师账号已存在。");
                    return;
                }
                DBHelper.ExecuteNonQuery("insert into sys_user(user_name,password,real_name,phone,email,role,status,create_time) values(@name,@pwd,@real,@phone,@mail,'photographer',1,now())", new MySqlParameter("@name", FormText("user_name")), new MySqlParameter("@pwd", Md5(FormText("password"))), new MySqlParameter("@real", FormText("real_name")), new MySqlParameter("@phone", FormText("phone")), new MySqlParameter("@mail", FormText("email")));
                object uid = DBHelper.ExecuteScalar("select user_id from sys_user where user_name=@name", new MySqlParameter("@name", FormText("user_name")));
                DBHelper.ExecuteNonQuery("insert into photographer(user_id,nick_name,avatar,specialty,price,intro,free_time,status,create_time) values(@uid,@nick,'Images/work-portrait.png',@sp,@price,@intro,@free,1,now())", new MySqlParameter("@uid", Convert.ToInt32(uid)), new MySqlParameter("@nick", FormText("nick_name")), new MySqlParameter("@sp", FormText("specialty")), new MySqlParameter("@price", ToDecimal(FormText("price"), 0)), new MySqlParameter("@intro", FormText("intro")), new MySqlParameter("@free", FormText("free_time")));
                Alert("摄影师已新增。");
            }
            if (action == "photo_save")
            {
                DBHelper.ExecuteNonQuery("update photographer set nick_name=@name,specialty=@sp,price=@price,intro=@intro,free_time=@free,status=@status where photographer_id=@id", new MySqlParameter("@name", FormText("nick_name")), new MySqlParameter("@sp", FormText("specialty")), new MySqlParameter("@price", ToDecimal(FormText("price"), 0)), new MySqlParameter("@intro", FormText("intro")), new MySqlParameter("@free", FormText("free_time")), new MySqlParameter("@status", ToInt(FormText("status"), 1)), new MySqlParameter("@id", ToInt(FormText("photographer_id"), 0)));
                Alert("摄影师信息已更新。");
            }
            if (action == "photo_delete")
            {
                DBHelper.ExecuteNonQuery("delete from photographer where photographer_id=@id", new MySqlParameter("@id", ToInt(FormText("photographer_id"), 0)));
                Alert("摄影师已删除。");
            }
            if (action == "order_add")
            {
                DBHelper.ExecuteNonQuery("insert into book_order(user_id,photographer_id,shoot_date,shoot_place,requirement,order_status,create_time) values(@uid,@pid,@date,@place,@req,@status,now())", new MySqlParameter("@uid", ToInt(FormText("user_id"), 0)), new MySqlParameter("@pid", ToInt(FormText("photographer_id"), 0)), new MySqlParameter("@date", FormText("shoot_date")), new MySqlParameter("@place", FormText("shoot_place")), new MySqlParameter("@req", FormText("requirement")), new MySqlParameter("@status", FormText("order_status")));
                Alert("订单已新增。");
            }
            if (action == "order_save")
            {
                DBHelper.ExecuteNonQuery("update book_order set shoot_date=@date,shoot_place=@place,requirement=@req,order_status=@status where order_id=@id", new MySqlParameter("@date", FormText("shoot_date")), new MySqlParameter("@place", FormText("shoot_place")), new MySqlParameter("@req", FormText("requirement")), new MySqlParameter("@status", FormText("order_status")), new MySqlParameter("@id", ToInt(FormText("order_id"), 0)));
                Alert("订单已更新。");
            }
            if (action == "order_delete")
            {
                DBHelper.ExecuteNonQuery("delete from book_order where order_id=@id", new MySqlParameter("@id", ToInt(FormText("order_id"), 0)));
                Alert("订单已删除。");
            }
            if (action == "comment_add")
            {
                DBHelper.ExecuteNonQuery("insert into comment(work_id,user_id,content,status,create_time) values(@wid,@uid,@content,1,now())", new MySqlParameter("@wid", ToInt(FormText("work_id"), 0)), new MySqlParameter("@uid", ToInt(FormText("user_id"), 0)), new MySqlParameter("@content", FormText("content")));
                Alert("评论已新增。");
            }
            if (action == "comment_status")
            {
                DBHelper.ExecuteNonQuery("update comment set status=@s where comment_id=@id", new MySqlParameter("@s", ToInt(FormText("status"), 1)), new MySqlParameter("@id", ToInt(FormText("comment_id"), 0)));
                Alert("评论状态已更新。");
            }
            if (action == "comment_delete")
            {
                DBHelper.ExecuteNonQuery("delete from comment where comment_id=@id", new MySqlParameter("@id", ToInt(FormText("comment_id"), 0)));
                Alert("评论已删除。");
            }
        }

        private void LoadAddForms()
        {
            string photoOptions = BuildOptions("select photographer_id as id,nick_name as name from photographer order by photographer_id desc");
            string userOptions = BuildOptions("select user_id as id,user_name as name from sys_user order by user_id desc");
            string workOptions = BuildOptions("select work_id as id,title as name from photo_work order by work_id desc");
            PhotographerAddHtml = "<form method=\"post\" action=\"AdminMain.aspx\" class=\"form-panel\"><input type=\"hidden\" name=\"action\" value=\"photo_add\" /><h3>新增摄影师</h3><div class=\"grid\"><input class=\"input\" name=\"user_name\" placeholder=\"账号\" /><input class=\"input\" name=\"password\" placeholder=\"密码\" /><input class=\"input\" name=\"real_name\" placeholder=\"姓名\" /></div><div class=\"grid\"><input class=\"input\" name=\"nick_name\" placeholder=\"昵称\" /><input class=\"input\" name=\"specialty\" placeholder=\"专长\" /><input class=\"input\" name=\"price\" placeholder=\"报价\" /></div><div class=\"grid\"><input class=\"input\" name=\"phone\" placeholder=\"手机\" /><input class=\"input\" name=\"email\" placeholder=\"邮箱\" /><input class=\"input\" name=\"free_time\" placeholder=\"档期\" /></div><div class=\"form-row\"><textarea class=\"textarea\" name=\"intro\" placeholder=\"简介\"></textarea></div><button class=\"btn\" type=\"submit\">新增摄影师</button></form><div style=\"height:12px\"></div>";
            WorkAddHtml = "<form method=\"post\" enctype=\"multipart/form-data\" action=\"AdminMain.aspx\" class=\"form-panel\"><input type=\"hidden\" name=\"action\" value=\"work_add\" /><h3>新增作品</h3><div class=\"grid\"><select class=\"select\" name=\"photographer_id\">" + photoOptions + "</select><input class=\"input\" name=\"title\" placeholder=\"标题\" /><select class=\"select\" name=\"work_type\"><option>人像</option><option>校园风景</option><option>静物</option></select></div><div class=\"grid\"><input class=\"input\" type=\"file\" name=\"work_image\" /><select class=\"select\" name=\"audit_status\"><option value=\"1\">审核通过</option><option value=\"0\">待审核</option></select><select class=\"select\" name=\"is_recommend\"><option value=\"0\">不推荐</option><option value=\"1\">推荐</option></select></div><div class=\"form-row\"><textarea class=\"textarea\" name=\"description\" placeholder=\"作品文案\"></textarea></div><button class=\"btn\" type=\"submit\">新增作品</button></form><div style=\"height:12px\"></div>";
            OrderAddHtml = "<form method=\"post\" action=\"AdminMain.aspx\" class=\"form-panel\"><input type=\"hidden\" name=\"action\" value=\"order_add\" /><h3>新增订单</h3><div class=\"grid\"><select class=\"select\" name=\"user_id\">" + userOptions + "</select><select class=\"select\" name=\"photographer_id\">" + photoOptions + "</select><input class=\"input\" name=\"shoot_date\" placeholder=\"日期：2026-06-20\" /></div><div class=\"grid\"><input class=\"input\" name=\"shoot_place\" placeholder=\"地点\" /><select class=\"select\" name=\"order_status\"><option>待确认</option><option>已确认</option><option>已完成</option><option>已取消</option></select><input class=\"input\" name=\"requirement\" placeholder=\"需求\" /></div><button class=\"btn\" type=\"submit\">新增订单</button></form><div style=\"height:12px\"></div>";
            CommentAddHtml = "<form method=\"post\" action=\"AdminMain.aspx\" class=\"form-panel\"><input type=\"hidden\" name=\"action\" value=\"comment_add\" /><h3>新增评论</h3><div class=\"grid\"><select class=\"select\" name=\"work_id\">" + workOptions + "</select><select class=\"select\" name=\"user_id\">" + userOptions + "</select><input class=\"input\" name=\"content\" placeholder=\"评论内容\" /></div><button class=\"btn\" type=\"submit\">新增评论</button></form><div style=\"height:12px\"></div>";
        }

        private string BuildOptions(string sql)
        {
            DataTable table = DBHelper.GetDataTable(sql);
            StringBuilder html = new StringBuilder();
            for (int i = 0; i < table.Rows.Count; i++)
            {
                DataRow row = table.Rows[i];
                html.Append("<option value=\"" + row["id"] + "\">" + HtmlEncode(row["name"]) + "</option>");
            }
            return html.ToString();
        }

        private void LoadWorks()
        {
            DataTable table = DBHelper.GetDataTable("select w.*,p.nick_name from photo_work w inner join photographer p on w.photographer_id=p.photographer_id order by w.create_time desc");
            StringBuilder html = new StringBuilder();
            html.Append("<table class=\"table\"><tr><th>作品</th><th>摄影师</th><th>分类</th><th>审核</th><th>推荐</th><th>操作</th></tr>");
            for (int i = 0; i < table.Rows.Count; i++)
            {
                DataRow r = table.Rows[i];
                html.Append("<tr><td>" + HtmlEncode(r["title"]) + "</td><td>" + HtmlEncode(r["nick_name"]) + "</td><td>" + HtmlEncode(r["work_type"]) + "</td><td>" + HtmlEncode(r["audit_status"]) + "</td><td>" + HtmlEncode(r["is_recommend"]) + "</td><td><form method=\"post\" action=\"AdminMain.aspx\"><input type=\"hidden\" name=\"action\" value=\"work_audit\" /><input type=\"hidden\" name=\"work_id\" value=\"" + r["work_id"] + "\" /><select name=\"audit_status\"><option value=\"1\">通过</option><option value=\"0\">待审</option></select><select name=\"is_recommend\"><option value=\"0\">不推荐</option><option value=\"1\">推荐</option></select><button class=\"btn-light btn\" type=\"submit\">保存</button></form><form method=\"post\" action=\"AdminMain.aspx\"><input type=\"hidden\" name=\"action\" value=\"work_delete\" /><input type=\"hidden\" name=\"work_id\" value=\"" + r["work_id"] + "\" /><button class=\"btn-light btn\" type=\"submit\">删除</button></form></td></tr>");
            }
            html.Append("</table>");
            WorkHtml = html.ToString();
        }

        private void LoadPhotographers()
        {
            DataTable table = DBHelper.GetDataTable("select * from photographer order by photographer_id desc");
            StringBuilder html = new StringBuilder();
            html.Append("<table class=\"table\"><tr><th>昵称</th><th>专长</th><th>报价</th><th>状态</th><th>操作</th></tr>");
            for (int i = 0; i < table.Rows.Count; i++)
            {
                DataRow r = table.Rows[i];
                html.Append("<tr><form method=\"post\" action=\"AdminMain.aspx\"><td><input class=\"input\" name=\"nick_name\" value=\"" + HtmlEncode(r["nick_name"]) + "\" /></td><td><input class=\"input\" name=\"specialty\" value=\"" + HtmlEncode(r["specialty"]) + "\" /></td><td><input class=\"input\" name=\"price\" value=\"" + HtmlEncode(r["price"]) + "\" /></td><td><select name=\"status\"><option value=\"1\">启用</option><option value=\"0\">禁用</option></select></td><td><input type=\"hidden\" name=\"action\" value=\"photo_save\" /><input type=\"hidden\" name=\"photographer_id\" value=\"" + r["photographer_id"] + "\" /><input type=\"hidden\" name=\"intro\" value=\"" + HtmlEncode(r["intro"]) + "\" /><input type=\"hidden\" name=\"free_time\" value=\"" + HtmlEncode(r["free_time"]) + "\" /><button class=\"btn-light btn\" type=\"submit\">保存</button></form><form method=\"post\" action=\"AdminMain.aspx\"><input type=\"hidden\" name=\"action\" value=\"photo_delete\" /><input type=\"hidden\" name=\"photographer_id\" value=\"" + r["photographer_id"] + "\" /><button class=\"btn-light btn\" type=\"submit\">删除</button></form></td></tr>");
            }
            html.Append("</table>");
            PhotographerHtml = html.ToString();
        }

        private void LoadOrders()
        {
            DataTable table = DBHelper.GetDataTable("select o.*,u.user_name,p.nick_name from book_order o inner join sys_user u on o.user_id=u.user_id inner join photographer p on o.photographer_id=p.photographer_id order by o.create_time desc");
            StringBuilder html = new StringBuilder();
            html.Append("<table class=\"table\"><tr><th>用户</th><th>摄影师</th><th>日期</th><th>地点</th><th>状态</th><th>操作</th></tr>");
            for (int i = 0; i < table.Rows.Count; i++)
            {
                DataRow r = table.Rows[i];
                html.Append("<tr><form method=\"post\" action=\"AdminMain.aspx\"><td>" + HtmlEncode(r["user_name"]) + "</td><td>" + HtmlEncode(r["nick_name"]) + "</td><td><input class=\"input\" name=\"shoot_date\" value=\"" + Convert.ToDateTime(r["shoot_date"]).ToString("yyyy-MM-dd") + "\" /></td><td><input class=\"input\" name=\"shoot_place\" value=\"" + HtmlEncode(r["shoot_place"]) + "\" /></td><td><select name=\"order_status\"><option>待确认</option><option>已确认</option><option>已完成</option><option>已取消</option></select></td><td><input type=\"hidden\" name=\"action\" value=\"order_save\" /><input type=\"hidden\" name=\"order_id\" value=\"" + r["order_id"] + "\" /><input type=\"hidden\" name=\"requirement\" value=\"" + HtmlEncode(r["requirement"]) + "\" /><button class=\"btn-light btn\" type=\"submit\">保存</button></form><form method=\"post\" action=\"AdminMain.aspx\"><input type=\"hidden\" name=\"action\" value=\"order_delete\" /><input type=\"hidden\" name=\"order_id\" value=\"" + r["order_id"] + "\" /><button class=\"btn-light btn\" type=\"submit\">删除</button></form></td></tr>");
            }
            html.Append("</table>");
            OrderHtml = html.ToString();
        }

        private void LoadComments()
        {
            DataTable table = DBHelper.GetDataTable("select c.*,u.user_name,w.title from comment c inner join sys_user u on c.user_id=u.user_id inner join photo_work w on c.work_id=w.work_id order by c.create_time desc");
            StringBuilder html = new StringBuilder();
            html.Append("<table class=\"table\"><tr><th>作品</th><th>用户</th><th>内容</th><th>状态</th><th>操作</th></tr>");
            for (int i = 0; i < table.Rows.Count; i++)
            {
                DataRow r = table.Rows[i];
                html.Append("<tr><td>" + HtmlEncode(r["title"]) + "</td><td>" + HtmlEncode(r["user_name"]) + "</td><td>" + HtmlEncode(r["content"]) + "</td><td>" + HtmlEncode(r["status"]) + "</td><td><form method=\"post\" action=\"AdminMain.aspx\"><input type=\"hidden\" name=\"action\" value=\"comment_status\" /><input type=\"hidden\" name=\"comment_id\" value=\"" + r["comment_id"] + "\" /><select name=\"status\"><option value=\"1\">显示</option><option value=\"0\">隐藏</option></select><button class=\"btn-light btn\" type=\"submit\">保存</button></form><form method=\"post\" action=\"AdminMain.aspx\"><input type=\"hidden\" name=\"action\" value=\"comment_delete\" /><input type=\"hidden\" name=\"comment_id\" value=\"" + r["comment_id"] + "\" /><button class=\"btn-light btn\" type=\"submit\">删除</button></form></td></tr>");
            }
            html.Append("</table>");
            CommentHtml = html.ToString();
        }
    }
}
