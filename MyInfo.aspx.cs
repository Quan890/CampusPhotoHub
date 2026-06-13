using System;
using System.Data;
using System.Text;
using MySql.Data.MySqlClient;
using CampusPhotoShare.Common;

namespace CampusPhotoShare
{
    public partial class MyInfo : BasePage
    {
        protected string ProfileFormHtml = "";
        protected string OrderHtml = "";
        protected string PhotographerMenu = "";
        protected string PhotographerPanelHtml = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            RequireLogin();
            if (Request.HttpMethod == "POST")
            {
                string action = FormText("action");
                if (action == "profile") SaveProfile();
                if (action == "photo_profile") SavePhotoProfile();
                if (action == "work_add") AddWork();
                if (action == "work_delete") DeleteWork();
                if (action == "order_status") UpdateOrderStatus();
            }
            LoadProfile();
            LoadOrders();
            if (CurrentRole == "photographer")
            {
                PhotographerMenu = "<a href=\"#photo\">摄影师资料</a><a href=\"#works\">作品管理</a>";
                LoadPhotographerPanel();
            }
        }

        private void LoadProfile()
        {
            DataTable table = DBHelper.GetDataTable("select * from sys_user where user_id=@id", new MySqlParameter("@id", CurrentUserId));
            DataRow row = table.Rows[0];
            ProfileFormHtml = "<div class=\"form-row\"><label>账号</label><input class=\"input\" value=\"" + HtmlEncode(row["user_name"]) + "\" disabled=\"disabled\" /></div>"
                + "<div class=\"form-row\"><label>姓名</label><input class=\"input\" name=\"real_name\" value=\"" + HtmlEncode(row["real_name"]) + "\" /></div>"
                + "<div class=\"form-row\"><label>性别</label><input class=\"input\" name=\"sex\" value=\"" + HtmlEncode(row["sex"]) + "\" /></div>"
                + "<div class=\"form-row\"><label>手机</label><input class=\"input\" name=\"phone\" value=\"" + HtmlEncode(row["phone"]) + "\" /></div>"
                + "<div class=\"form-row\"><label>邮箱</label><input class=\"input\" name=\"email\" value=\"" + HtmlEncode(row["email"]) + "\" /></div>"
                + "<div class=\"form-row\"><label>新密码（不修改请留空）</label><input class=\"input\" type=\"password\" name=\"new_password\" /></div>";
        }

        private void SaveProfile()
        {
            string pwd = FormText("new_password");
            if (pwd.Length > 0)
            {
                DBHelper.ExecuteNonQuery("update sys_user set real_name=@real,sex=@sex,phone=@phone,email=@mail,password=@pwd where user_id=@id", new MySqlParameter("@real", FormText("real_name")), new MySqlParameter("@sex", FormText("sex")), new MySqlParameter("@phone", FormText("phone")), new MySqlParameter("@mail", FormText("email")), new MySqlParameter("@pwd", Md5(pwd)), new MySqlParameter("@id", CurrentUserId));
            }
            else
            {
                DBHelper.ExecuteNonQuery("update sys_user set real_name=@real,sex=@sex,phone=@phone,email=@mail where user_id=@id", new MySqlParameter("@real", FormText("real_name")), new MySqlParameter("@sex", FormText("sex")), new MySqlParameter("@phone", FormText("phone")), new MySqlParameter("@mail", FormText("email")), new MySqlParameter("@id", CurrentUserId));
            }
            Alert("资料保存成功。");
        }

        private void LoadOrders()
        {
            string sql;
            MySqlParameter param = new MySqlParameter("@id", CurrentUserId);
            if (CurrentRole == "photographer")
            {
                sql = "select o.*,p.nick_name,u.user_name from book_order o inner join photographer p on o.photographer_id=p.photographer_id inner join sys_user u on o.user_id=u.user_id where p.user_id=@id order by o.create_time desc";
            }
            else
            {
                sql = "select o.*,p.nick_name,u.user_name from book_order o inner join photographer p on o.photographer_id=p.photographer_id inner join sys_user u on o.user_id=u.user_id where o.user_id=@id order by o.create_time desc";
            }
            DataTable table = DBHelper.GetDataTable(sql, param);
            StringBuilder html = new StringBuilder();
            html.Append("<table class=\"table\"><tr><th>预约人</th><th>摄影师</th><th>日期</th><th>地点</th><th>需求</th><th>状态</th><th>操作</th></tr>");
            for (int i = 0; i < table.Rows.Count; i++)
            {
                DataRow row = table.Rows[i];
                html.Append("<tr><td>" + HtmlEncode(row["user_name"]) + "</td><td>" + HtmlEncode(row["nick_name"]) + "</td><td>" + HtmlEncode(row["shoot_date"]) + "</td><td>" + HtmlEncode(row["shoot_place"]) + "</td><td>" + HtmlEncode(row["requirement"]) + "</td><td>" + HtmlEncode(row["order_status"]) + "</td><td>");
                if (CurrentRole == "photographer")
                {
                    html.Append("<form method=\"post\" action=\"MyInfo.aspx\" style=\"display:inline\"><input type=\"hidden\" name=\"action\" value=\"order_status\" /><input type=\"hidden\" name=\"order_id\" value=\"" + row["order_id"] + "\" /><select name=\"status\"><option>待确认</option><option>已确认</option><option>已完成</option><option>已取消</option></select><button class=\"btn-light btn\" type=\"submit\">更新</button></form>");
                }
                html.Append("</td></tr>");
            }
            html.Append("</table>");
            OrderHtml = html.ToString();
        }

        private int GetPhotographerId()
        {
            object id = DBHelper.ExecuteScalar("select photographer_id from photographer where user_id=@uid", new MySqlParameter("@uid", CurrentUserId));
            if (id == null || id == DBNull.Value) return 0;
            return Convert.ToInt32(id);
        }

        private void LoadPhotographerPanel()
        {
            int pid = GetPhotographerId();
            if (pid == 0)
            {
                PhotographerPanelHtml = "<div class=\"form-panel\">您的摄影师档案尚未创建，请联系管理员。</div>";
                return;
            }
            DataTable p = DBHelper.GetDataTable("select * from photographer where photographer_id=@id", new MySqlParameter("@id", pid));
            DataRow row = p.Rows[0];
            StringBuilder html = new StringBuilder();
            html.Append("<div id=\"photo\" class=\"section-title\"><h2>摄影师资料</h2></div><form method=\"post\" enctype=\"multipart/form-data\" action=\"MyInfo.aspx\" class=\"form-panel\"><input type=\"hidden\" name=\"action\" value=\"photo_profile\" />");
            html.Append("<div class=\"form-row\"><label>昵称</label><input class=\"input\" name=\"nick_name\" value=\"" + HtmlEncode(row["nick_name"]) + "\" /></div><div class=\"form-row\"><label>头像</label><input class=\"input\" type=\"file\" name=\"avatar\" /></div><div class=\"form-row\"><label>专长</label><input class=\"input\" name=\"specialty\" value=\"" + HtmlEncode(row["specialty"]) + "\" /></div><div class=\"form-row\"><label>报价</label><input class=\"input\" name=\"price\" value=\"" + HtmlEncode(row["price"]) + "\" /></div><div class=\"form-row\"><label>简介</label><textarea class=\"textarea\" name=\"intro\">" + HtmlEncode(row["intro"]) + "</textarea></div><div class=\"form-row\"><label>空闲档期</label><textarea class=\"textarea\" name=\"free_time\">" + HtmlEncode(row["free_time"]) + "</textarea></div><button class=\"btn\" type=\"submit\">保存摄影师资料</button></form>");
            html.Append("<div id=\"works\" class=\"section-title\"><h2>作品管理</h2></div><form method=\"post\" enctype=\"multipart/form-data\" action=\"MyInfo.aspx\" class=\"form-panel\"><input type=\"hidden\" name=\"action\" value=\"work_add\" /><div class=\"form-row\"><label>标题</label><input class=\"input\" name=\"title\" /></div><div class=\"form-row\"><label>分类</label><select class=\"select\" name=\"work_type\"><option>人像</option><option>校园风景</option><option>静物</option></select></div><div class=\"form-row\"><label>作品图片</label><input class=\"input\" type=\"file\" name=\"work_image\" /></div><div class=\"form-row\"><label>文案介绍</label><textarea class=\"textarea\" name=\"description\"></textarea></div><button class=\"btn\" type=\"submit\">上传作品</button></form>");
            DataTable works = DBHelper.GetDataTable("select * from photo_work where photographer_id=@pid order by create_time desc", new MySqlParameter("@pid", pid));
            html.Append("<table class=\"table\"><tr><th>标题</th><th>分类</th><th>审核</th><th>操作</th></tr>");
            for (int i = 0; i < works.Rows.Count; i++)
            {
                DataRow w = works.Rows[i];
                html.Append("<tr><td>" + HtmlEncode(w["title"]) + "</td><td>" + HtmlEncode(w["work_type"]) + "</td><td>" + (Convert.ToInt32(w["audit_status"]) == 1 ? "通过" : "待审核") + "</td><td><form method=\"post\" action=\"MyInfo.aspx\"><input type=\"hidden\" name=\"action\" value=\"work_delete\" /><input type=\"hidden\" name=\"work_id\" value=\"" + w["work_id"] + "\" /><button class=\"btn-light btn\" type=\"submit\">删除</button></form></td></tr>");
            }
            html.Append("</table>");
            PhotographerPanelHtml = html.ToString();
        }

        private void SavePhotoProfile()
        {
            int pid = GetPhotographerId();
            string avatar = SaveUploadImage("avatar", "Uploads/Photographers");
            if (avatar.Length > 0)
            {
                DBHelper.ExecuteNonQuery("update photographer set nick_name=@name,avatar=@avatar,specialty=@sp,price=@price,intro=@intro,free_time=@free where photographer_id=@pid", new MySqlParameter("@name", FormText("nick_name")), new MySqlParameter("@avatar", avatar), new MySqlParameter("@sp", FormText("specialty")), new MySqlParameter("@price", ToDecimal(FormText("price"), 0)), new MySqlParameter("@intro", FormText("intro")), new MySqlParameter("@free", FormText("free_time")), new MySqlParameter("@pid", pid));
            }
            else
            {
                DBHelper.ExecuteNonQuery("update photographer set nick_name=@name,specialty=@sp,price=@price,intro=@intro,free_time=@free where photographer_id=@pid", new MySqlParameter("@name", FormText("nick_name")), new MySqlParameter("@sp", FormText("specialty")), new MySqlParameter("@price", ToDecimal(FormText("price"), 0)), new MySqlParameter("@intro", FormText("intro")), new MySqlParameter("@free", FormText("free_time")), new MySqlParameter("@pid", pid));
            }
            Alert("摄影师资料已保存。");
        }

        private void AddWork()
        {
            int pid = GetPhotographerId();
            string img = SaveUploadImage("work_image", "Uploads/Works");
            if (img.Length == 0 || FormText("title").Length == 0)
            {
                Alert("请填写标题并上传作品图片。");
                return;
            }
            DBHelper.ExecuteNonQuery("insert into photo_work(photographer_id,title,work_type,image_url,description,is_recommend,audit_status,view_count,create_time) values(@pid,@title,@type,@img,@desc,0,0,0,now())", new MySqlParameter("@pid", pid), new MySqlParameter("@title", FormText("title")), new MySqlParameter("@type", FormText("work_type")), new MySqlParameter("@img", img), new MySqlParameter("@desc", FormText("description")));
            Alert("作品上传成功，等待管理员审核。");
        }

        private void DeleteWork()
        {
            int pid = GetPhotographerId();
            DBHelper.ExecuteNonQuery("delete from photo_work where work_id=@wid and photographer_id=@pid", new MySqlParameter("@wid", ToInt(FormText("work_id"), 0)), new MySqlParameter("@pid", pid));
            Alert("作品已删除。");
        }

        private void UpdateOrderStatus()
        {
            int pid = GetPhotographerId();
            DBHelper.ExecuteNonQuery("update book_order set order_status=@s where order_id=@oid and photographer_id=@pid", new MySqlParameter("@s", FormText("status")), new MySqlParameter("@oid", ToInt(FormText("order_id"), 0)), new MySqlParameter("@pid", pid));
            Alert("预约状态已更新。");
        }
    }
}
