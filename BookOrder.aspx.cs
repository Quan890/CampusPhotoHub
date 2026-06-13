using System;
using System.Data;
using System.Text;
using MySql.Data.MySqlClient;
using CampusPhotoShare.Common;

namespace CampusPhotoShare
{
    public partial class BookOrder : BasePage
    {
        protected string PhotographerOptions = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsLogin)
            {
                Response.Redirect("Login.aspx?returnUrl=BookOrder.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }
            LoadOptions();
            if (Request.HttpMethod == "POST" && FormText("action") == "book")
            {
                SubmitOrder();
            }
        }

        private void LoadOptions()
        {
            int selectedId = ToInt(QueryText("pid"), 0);
            DataTable table = DBHelper.GetDataTable("select photographer_id,nick_name,price from photographer where status=1 and exists(select 1 from photo_work where photographer_id=photographer.photographer_id) order by photographer_id desc");
            StringBuilder html = new StringBuilder();
            for (int i = 0; i < table.Rows.Count; i++)
            {
                DataRow row = table.Rows[i];
                string selected = Convert.ToInt32(row["photographer_id"]) == selectedId ? " selected=\"selected\"" : "";
                html.Append("<option value=\"" + row["photographer_id"] + "\"" + selected + ">" + HtmlEncode(row["nick_name"]) + " - ￥" + HtmlEncode(row["price"]) + "</option>");
            }
            PhotographerOptions = html.ToString();
        }

        private void SubmitOrder()
        {
            if (!IsLogin)
            {
                Alert("请先登录后再操作");
                return;
            }
            int pid = ToInt(FormText("photographer_id"), 0);
            string date = FormText("shoot_date");
            string place = FormText("shoot_place");
            if (pid <= 0 || date.Length == 0 || place.Length == 0)
            {
                Alert("请选择摄影师，并填写拍摄日期和地点。");
                return;
            }
            DBHelper.ExecuteNonQuery("insert into book_order(user_id,photographer_id,shoot_date,shoot_place,requirement,order_status,create_time) values(@uid,@pid,@date,@place,@req,'待确认',now())", new MySqlParameter("@uid", CurrentUserId), new MySqlParameter("@pid", pid), new MySqlParameter("@date", date), new MySqlParameter("@place", place), new MySqlParameter("@req", FormText("requirement")));
            Alert("预约提交成功，请在个人中心查看。");
        }
    }
}
