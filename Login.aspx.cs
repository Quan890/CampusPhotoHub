using System;
using System.Data;
using MySql.Data.MySqlClient;
using CampusPhotoShare.Common;

namespace CampusPhotoShare
{
    public partial class Login : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (QueryText("action") == "logout")
            {
                Session.Abandon();
                AlertAndRedirect("已退出登录。", "Default.aspx");
                return;
            }
            if (Request.HttpMethod == "POST")
            {
                if (FormText("action") == "login")
                {
                    DoLogin();
                }
                if (FormText("action") == "register")
                {
                    DoRegister();
                }
            }
        }

        private void DoLogin()
        {
            string name = FormText("user_name");
            string pwd = FormText("password");
            string pwdHash = FormText("password_hash");
            if (name.Length == 0 || (pwd.Length == 0 && pwdHash.Length == 0))
            {
                Alert("请输入账号和密码。");
                return;
            }
            if (pwdHash.Length == 0)
            {
                pwdHash = Md5(pwd);
            }
            DataTable table = DBHelper.GetDataTable("select * from sys_user where user_name=@name and password=@pwd and status=1", new MySqlParameter("@name", name), new MySqlParameter("@pwd", pwdHash));
            if (table.Rows.Count == 0)
            {
                Alert("账号或密码错误。");
                return;
            }
            DataRow row = table.Rows[0];
            Session["UserId"] = row["user_id"];
            Session["UserName"] = row["user_name"];
            Session["Role"] = row["role"];
            string returnUrl = QueryText("returnUrl");
            if (returnUrl.Length > 0 && returnUrl.StartsWith("/") && !returnUrl.StartsWith("//"))
            {
                Response.Redirect(returnUrl, false);
                Context.ApplicationInstance.CompleteRequest();
            }
            else if (row["role"].ToString() == "admin")
            {
                Response.Redirect("AdminMain.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
            }
            else
            {
                Response.Redirect("MyInfo.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
            }
        }

        private void DoRegister()
        {
            string name = FormText("reg_user_name");
            string pwd = FormText("reg_password");
            string pwdHash = FormText("reg_password_hash");
            if (name.Length == 0 || (pwd.Length == 0 && pwdHash.Length == 0))
            {
                Alert("注册账号和密码不能为空。");
                return;
            }
            if (pwdHash.Length == 0)
            {
                pwdHash = Md5(pwd);
            }
            object count = DBHelper.ExecuteScalar("select count(*) from sys_user where user_name=@name", new MySqlParameter("@name", name));
            if (Convert.ToInt32(count) > 0)
            {
                Alert("该账号已存在。");
                return;
            }
            DBHelper.ExecuteNonQuery("insert into sys_user(user_name,password,real_name,phone,email,role,status,create_time) values(@name,@pwd,@real,@phone,@mail,'user',1,now())", new MySqlParameter("@name", name), new MySqlParameter("@pwd", pwdHash), new MySqlParameter("@real", FormText("real_name")), new MySqlParameter("@phone", FormText("phone")), new MySqlParameter("@mail", FormText("email")));
            Alert("注册成功，请登录。");
        }
    }
}
