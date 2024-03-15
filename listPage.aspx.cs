using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Net;

namespace TodoList
{
    public partial class listPage : System.Web.UI.Page
    {
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                bring_data();
            }
        }

        private void bring_data()
        {
            lists_list.DataSource = null;
            lists_list.DataBind();

            string ConnectStr = ConfigurationManager.AppSettings["ConnectionString"];

            SqlConnection conn = new SqlConnection(ConnectStr);
            SqlCommand Cmd = new SqlCommand();
            Cmd.Connection = conn;

            #region 타이틀 가져오기
            Cmd.CommandText =
                "select l.tltle, l.id " +
                "from list_todo l " +
                "inner join Uinfo_todo a " +
                "on l.Tuser = a.Tmail " +
                "where l.Tuser=@mail " +
                "order by [importance] desc";

            Cmd.Parameters.Add("@mail", SqlDbType.VarChar, 25);
            Cmd.Parameters["@mail"].Value = Session["email"];  // , l.id, l.Tuser, l.importance 

            SqlDataAdapter adp = new SqlDataAdapter(Cmd);
            DataSet dstitle = new DataSet();
            adp.Fill(dstitle, "list_todo");

            lists_list.DataSource = dstitle;
            lists_list.DataBind();
            #endregion
        }

        protected void btnAdd_Click(object sender, EventArgs e)  //  Application["newItems"]
        {
            List<string> newItems = new List<string>();
            if (Session["newItems"] as List<string> != null) { newItems = Session["newItems"] as List<string>; }
            
            newItems.Add(txt_newitem.Text.Trim());

            Session["newItems"] = newItems;
            lb_items.Items.Add(txt_newitem.Text.Trim());
            txt_newitem.Text = "";
        }

        protected void btnFinish_Click(object sender, EventArgs e)
        {
            if (Session["newItems"] == null) return;

            string ConnectStr = ConfigurationManager.AppSettings["ConnectionString"];
            string query;
            string query2;

            SqlConnection conn = new SqlConnection(ConnectStr);
            SqlCommand Cmd = new SqlCommand();
            Cmd.Connection = conn;

            query =
                "insert into list_item_todo values(@work, @success, @listname, @owner)";
            query2 =
                    "insert into list_todo values(@title, @importance, @user)";

            Cmd.CommandText = query;

            Cmd.Parameters.Add("@work", SqlDbType.Text);
            Cmd.Parameters.Add("@success", SqlDbType.Bit);
            Cmd.Parameters.Add("@listname", SqlDbType.VarChar, 25);
            Cmd.Parameters.Add("@owner", SqlDbType.VarChar, 80);
            
            Cmd.Parameters.Add("@title", SqlDbType.VarChar, 25);
            Cmd.Parameters.Add("@importance", SqlDbType.Int);
            Cmd.Parameters.Add("@user", SqlDbType.VarChar, 80);

            Cmd.Parameters["@title"].Value = TextBox1.Text.Trim();
            Cmd.Parameters["@importance"].Value = slider.Value;
            Cmd.Parameters["@user"].Value = Session["email"];

            try
            {
                List<string> myList = Session["newItems"] as List<string>;
                conn.Open();
                for(int i = 0; i < myList.Count; i++)
                {
                    Cmd.Parameters["@work"].Value = myList[i];
                    Cmd.Parameters["@success"].Value = 0;
                    Cmd.Parameters["@listname"].Value = TextBox1.Text.Trim();
                    Cmd.Parameters["@owner"].Value = Session["email"];
                    Cmd.ExecuteNonQuery();
                }

                Cmd.CommandText = query2;
                Cmd.ExecuteNonQuery();
                
                TextBox1.Text = "";
                lb_items.Items.Clear();
                Session["newItems"] = null;
            }
            catch
            {
                throw new NullReferenceException();
            }
            finally
            {
                conn.Close();

                bring_data();
            }
        }

        protected void btnDel_Click(object sender, EventArgs e)
        {
            // 원하는 리스트명 얻어오기
            Button button = (Button)sender;
            DataGridItem item = (DataGridItem)button.NamingContainer;

            HtmlAnchor link = (HtmlAnchor)item.FindControl("hyperlink");
            string selectedTitle = link.InnerText.Trim();

            Response.Write($"<title>{selectedTitle}</title>");

            /*test.InnerText= selectedTitle;  // 테스트용*/

            // DB관리
            string ConnectStr = ConfigurationManager.AppSettings["ConnectionString"];

            SqlConnection conn = new SqlConnection(ConnectStr);
            conn.Open();
            SqlCommand Cmd = new SqlCommand();
            Cmd.Connection = conn;

            try
            {
                #region 리스트 지우기
                string query1 =
                    "Delete from list_todo " +
                    "where Tuser = @mail and tltle = @title";

                Cmd.CommandText = query1;

                Cmd.Parameters.Add("@title", SqlDbType.VarChar, 25);
                Cmd.Parameters.Add("@mail", SqlDbType.VarChar, 80);

                Cmd.Parameters["@title"].Value = selectedTitle;
                Cmd.Parameters["@mail"].Value = Session["email"];

                Cmd.ExecuteNonQuery();
                #endregion

                #region 리스트 아이템지우기
                // 리스트 아이템용
                string query2 =
                    "Delete from list_item_todo " +
                    "where [owner] = @mail and listname = @listname";

                Cmd.CommandText = query2;

                Cmd.Parameters.Add("@listname", SqlDbType.VarChar, 25);

                Cmd.Parameters["@listname"].Value = selectedTitle;

                Cmd.ExecuteNonQuery();
                #endregion
            }
            catch(Exception ex)
            {
                test.InnerText = ex.Message;
            }
            finally
            {
                conn.Close();

                bring_data();
            }
        }
    }
}